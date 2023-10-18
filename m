Return-Path: <netdev+bounces-42430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B477CEA23
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E40281E60
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C193E008;
	Wed, 18 Oct 2023 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQZ///bW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47C3D3B6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53221C433CB;
	Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697665164;
	bh=c5zNuUwEGaxHODHNF1aoAP9vytsF226gPHU77GpfqE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQZ///bWVxMI4OS/J+djwycxrd3vUbTwLsoHJ21jZQXFF3GEnA8IKIVXtPdMYii2k
	 +dw0jSF6iK9rodbKlHfUjRdGWGiw0m35J93zODsR30ULhqC5t3r7o+uXMPyZGcXnDB
	 zGD5HR4DK6aeGmU21YUuNivXnOx7hWzZ8GqKXuIp5m7XBoWy1hmHgVZZ4+6RjwIDBw
	 oGwGLOKc1v4zDPd4ivcX2mnMgvjq8UntTAORxnqX72AHOMHPXEdzz4HSlmO2/zy29s
	 el9PQ1Ruo/PqAIO0yOb4EttIBtyOQtFuUx1S0XG+LSZjGqqCzysn81eh8cgpthfJug
	 f5IGCg5tPId9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	johannes@sipsolutions.net,
	nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	jiri@resnulli.us
Subject: [PATCH net-next 2/3] netlink: add variable-length / auto integers
Date: Wed, 18 Oct 2023 14:39:20 -0700
Message-ID: <20231018213921.2694459-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018213921.2694459-1-kuba@kernel.org>
References: <20231018213921.2694459-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently push everyone to use padding to align 64b values
in netlink. Un-padded nla_put_u64() doesn't even exist any more.

The story behind this possibly start with this thread:
https://lore.kernel.org/netdev/20121204.130914.1457976839967676240.davem@davemloft.net/
where DaveM was concerned about the alignment of a structure
containing 64b stats. If user space tries to access such struct
directly:

	struct some_stats *stats = nla_data(attr);
	printf("A: %llu", stats->a);

lack of alignment may become problematic for some architectures.
These days we most often put every single member in a separate
attribute, meaning that the code above would use a helper like
nla_get_u64(), which can deal with alignment internally.
Even for arches which don't have good unaligned access - access
aligned to 4B should be pretty efficient.
Kernel and well known libraries deal with unaligned input already.

Padded 64b is quite space-inefficient (64b + pad means at worst 16B
per attr vs 32b which takes 8B). It is also more typing:

    if (nla_put_u64_pad(rsp, NETDEV_A_SOMETHING_SOMETHING,
                        value, NETDEV_A_SOMETHING_PAD))

Create a new attribute type which will use 32 bits at netlink
level if value is small enough (probably most of the time?),
and (4B-aligned) 64 bits otherwise. Kernel API is just:

    if (nla_put_uint(rsp, NETDEV_A_SOMETHING_SOMETHING, value))

Calling this new type "just" sint / uint with no specific size
will hopefully also make people more comfortable with using it.
Currently telling people "don't use u8, you may need the bits,
and netlink will round up to 4B, anyway" is the #1 comment
we give to newcomers.

In terms of netlink layout it looks like this:

         0       4       8       12      16
32b:     [nlattr][ u32  ]
64b:     [  pad ][nlattr][     u64      ]
uint(32) [nlattr][ u32  ]
uint(64) [nlattr][     u64      ]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1:
 - fill in missed nlattr support
 - add docs
 - fix build (missed commit -a --amend..)
RFC: https://lore.kernel.org/all/20231011003313.105315-1-kuba@kernel.org/

CC: johannes@sipsolutions.net
CC: nicolas.dichtel@6wind.com
CC: stephen@networkplumber.org
CC: jiri@resnulli.us
---
 Documentation/userspace-api/netlink/specs.rst | 18 ++++-
 include/net/netlink.h                         | 69 ++++++++++++++++++-
 include/uapi/linux/netlink.h                  |  5 ++
 lib/nlattr.c                                  | 22 ++++++
 net/netlink/policy.c                          | 14 +++-
 5 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index 40dd7442d2c3..c1b951649113 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -403,10 +403,21 @@ This section describes the attribute types supported by the ``genetlink``
 compatibility level. Refer to documentation of different levels for additional
 attribute types.
 
-Scalar integer types
+Common integer types
 --------------------
 
-Fixed-width integer types:
+``sint`` and ``uint`` represent signed and unsigned 64 bit integers.
+If the value can fit on 32 bits only 32 bits are carried in netlink
+messages, otherwise full 64 bits are carried. Note that the payload
+is only aligned to 4B, so the full 64 bit value may be unaligned!
+
+Common integer types should be preferred over fix-width types in majority
+of cases.
+
+Fix-width integer types
+-----------------------
+
+Fixed-width integer types include:
 ``u8``, ``u16``, ``u32``, ``u64``, ``s8``, ``s16``, ``s32``, ``s64``.
 
 Note that types smaller than 32 bit should be avoided as using them
@@ -416,6 +427,9 @@ See :ref:`pad_type` for padding of 64 bit attributes.
 The payload of the attribute is the integer in host order unless ``byte-order``
 specifies otherwise.
 
+64 bit values are usually aligned by the kernel but it is recommended
+that the user space is able to deal with unaligned values.
+
 .. _pad_type:
 
 pad
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 8a7cd1170e1f..aba2b162a226 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -128,6 +128,8 @@
  *   nla_len(nla)			length of attribute payload
  *
  * Attribute Payload Access for Basic Types:
+ *   nla_get_uint(nla)			get payload for a uint attribute
+ *   nla_get_sint(nla)			get payload for a sint attribute
  *   nla_get_u8(nla)			get payload for a u8 attribute
  *   nla_get_u16(nla)			get payload for a u16 attribute
  *   nla_get_u32(nla)			get payload for a u32 attribute
@@ -183,6 +185,8 @@ enum {
 	NLA_REJECT,
 	NLA_BE16,
 	NLA_BE32,
+	NLA_SINT,
+	NLA_UINT,
 	__NLA_TYPE_MAX,
 };
 
@@ -229,6 +233,7 @@ enum nla_policy_validation {
  *                         nested header (or empty); len field is used if
  *                         nested_policy is also used, for the max attr
  *                         number in the nested policy.
+ *    NLA_SINT, NLA_UINT,
  *    NLA_U8, NLA_U16,
  *    NLA_U32, NLA_U64,
  *    NLA_S8, NLA_S16,
@@ -260,12 +265,14 @@ enum nla_policy_validation {
  *                         while an array has the nested attributes at another
  *                         level down and the attribute types directly in the
  *                         nesting don't matter.
+ *    NLA_UINT,
  *    NLA_U8,
  *    NLA_U16,
  *    NLA_U32,
  *    NLA_U64,
  *    NLA_BE16,
  *    NLA_BE32,
+ *    NLA_SINT,
  *    NLA_S8,
  *    NLA_S16,
  *    NLA_S32,
@@ -280,6 +287,7 @@ enum nla_policy_validation {
  *                         or NLA_POLICY_FULL_RANGE_SIGNED() macros instead.
  *                         Use the NLA_POLICY_MIN(), NLA_POLICY_MAX() and
  *                         NLA_POLICY_RANGE() macros.
+ *    NLA_UINT,
  *    NLA_U8,
  *    NLA_U16,
  *    NLA_U32,
@@ -288,6 +296,7 @@ enum nla_policy_validation {
  *                         to a struct netlink_range_validation that indicates
  *                         the min/max values.
  *                         Use NLA_POLICY_FULL_RANGE().
+ *    NLA_SINT,
  *    NLA_S8,
  *    NLA_S16,
  *    NLA_S32,
@@ -377,9 +386,11 @@ struct nla_policy {
 
 #define __NLA_IS_UINT_TYPE(tp)					\
 	(tp == NLA_U8 || tp == NLA_U16 || tp == NLA_U32 ||	\
-	 tp == NLA_U64 || tp == NLA_BE16 || tp == NLA_BE32)
+	 tp == NLA_U64 || tp == NLA_UINT ||			\
+	 tp == NLA_BE16 || tp == NLA_BE32)
 #define __NLA_IS_SINT_TYPE(tp)						\
-	(tp == NLA_S8 || tp == NLA_S16 || tp == NLA_S32 || tp == NLA_S64)
+	(tp == NLA_S8 || tp == NLA_S16 || tp == NLA_S32 || tp == NLA_S64 || \
+	 tp == NLA_SINT)
 
 #define __NLA_ENSURE(condition) BUILD_BUG_ON_ZERO(!(condition))
 #define NLA_ENSURE_UINT_TYPE(tp)			\
@@ -1357,6 +1368,22 @@ static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
 	return nla_put(skb, attrtype, sizeof(u32), &tmp);
 }
 
+/**
+ * nla_put_uint - Add a variable-size unsigned int to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_uint(struct sk_buff *skb, int attrtype, u64 value)
+{
+	u64 tmp64 = value;
+	u32 tmp32 = value;
+
+	if (tmp64 == tmp32)
+		return nla_put_u32(skb, attrtype, tmp32);
+	return nla_put(skb, attrtype, sizeof(u64), &tmp64);
+}
+
 /**
  * nla_put_be32 - Add a __be32 netlink attribute to a socket buffer
  * @skb: socket buffer to add attribute to
@@ -1511,6 +1538,22 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
 	return nla_put_64bit(skb, attrtype, sizeof(s64), &tmp, padattr);
 }
 
+/**
+ * nla_put_sint - Add a variable-size signed int to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_sint(struct sk_buff *skb, int attrtype, s64 value)
+{
+	s64 tmp64 = value;
+	s32 tmp32 = value;
+
+	if (tmp64 == tmp32)
+		return nla_put_s32(skb, attrtype, tmp32);
+	return nla_put(skb, attrtype, sizeof(s64), &tmp64);
+}
+
 /**
  * nla_put_string - Add a string netlink attribute to a socket buffer
  * @skb: socket buffer to add attribute to
@@ -1667,6 +1710,17 @@ static inline u64 nla_get_u64(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_get_uint - return payload of uint attribute
+ * @nla: uint netlink attribute
+ */
+static inline u64 nla_get_uint(const struct nlattr *nla)
+{
+	if (nla_len(nla) == sizeof(u32))
+		return nla_get_u32(nla);
+	return nla_get_u64(nla);
+}
+
 /**
  * nla_get_be64 - return payload of __be64 attribute
  * @nla: __be64 netlink attribute
@@ -1729,6 +1783,17 @@ static inline s64 nla_get_s64(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_get_sint - return payload of uint attribute
+ * @nla: uint netlink attribute
+ */
+static inline s64 nla_get_sint(const struct nlattr *nla)
+{
+	if (nla_len(nla) == sizeof(s32))
+		return nla_get_s32(nla);
+	return nla_get_s64(nla);
+}
+
 /**
  * nla_get_flag - return payload of flag attribute
  * @nla: flag netlink attribute
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index e2ae82e3f9f7..f87aaf28a649 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -298,6 +298,8 @@ struct nla_bitfield32 {
  *	entry has attributes again, the policy for those inner ones
  *	and the corresponding maxtype may be specified.
  * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
+ * @NL_ATTR_TYPE_SINT: 32-bit or 64-bit signed attribute, aligned to 4B
+ * @NL_ATTR_TYPE_UINT: 32-bit or 64-bit unsigned attribute, aligned to 4B
  */
 enum netlink_attribute_type {
 	NL_ATTR_TYPE_INVALID,
@@ -322,6 +324,9 @@ enum netlink_attribute_type {
 	NL_ATTR_TYPE_NESTED_ARRAY,
 
 	NL_ATTR_TYPE_BITFIELD32,
+
+	NL_ATTR_TYPE_SINT,
+	NL_ATTR_TYPE_UINT,
 };
 
 /**
diff --git a/lib/nlattr.c b/lib/nlattr.c
index 7a2b6c38fd59..dc15e7888fc1 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -134,6 +134,7 @@ void nla_get_range_unsigned(const struct nla_policy *pt,
 		range->max = U32_MAX;
 		break;
 	case NLA_U64:
+	case NLA_UINT:
 	case NLA_MSECS:
 		range->max = U64_MAX;
 		break;
@@ -183,6 +184,9 @@ static int nla_validate_range_unsigned(const struct nla_policy *pt,
 	case NLA_U64:
 		value = nla_get_u64(nla);
 		break;
+	case NLA_UINT:
+		value = nla_get_uint(nla);
+		break;
 	case NLA_MSECS:
 		value = nla_get_u64(nla);
 		break;
@@ -248,6 +252,7 @@ void nla_get_range_signed(const struct nla_policy *pt,
 		range->max = S32_MAX;
 		break;
 	case NLA_S64:
+	case NLA_SINT:
 		range->min = S64_MIN;
 		range->max = S64_MAX;
 		break;
@@ -295,6 +300,9 @@ static int nla_validate_int_range_signed(const struct nla_policy *pt,
 	case NLA_S64:
 		value = nla_get_s64(nla);
 		break;
+	case NLA_SINT:
+		value = nla_get_sint(nla);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -320,6 +328,7 @@ static int nla_validate_int_range(const struct nla_policy *pt,
 	case NLA_U16:
 	case NLA_U32:
 	case NLA_U64:
+	case NLA_UINT:
 	case NLA_MSECS:
 	case NLA_BINARY:
 	case NLA_BE16:
@@ -329,6 +338,7 @@ static int nla_validate_int_range(const struct nla_policy *pt,
 	case NLA_S16:
 	case NLA_S32:
 	case NLA_S64:
+	case NLA_SINT:
 		return nla_validate_int_range_signed(pt, nla, extack);
 	default:
 		WARN_ON(1);
@@ -355,6 +365,9 @@ static int nla_validate_mask(const struct nla_policy *pt,
 	case NLA_U64:
 		value = nla_get_u64(nla);
 		break;
+	case NLA_UINT:
+		value = nla_get_uint(nla);
+		break;
 	case NLA_BE16:
 		value = ntohs(nla_get_be16(nla));
 		break;
@@ -433,6 +446,15 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 			goto out_err;
 		break;
 
+	case NLA_SINT:
+	case NLA_UINT:
+		if (attrlen != sizeof(u32) && attrlen != sizeof(u64)) {
+			NL_SET_ERR_MSG_ATTR_POL(extack, nla, pt,
+						"invalid attribute length");
+			return -EINVAL;
+		}
+		break;
+
 	case NLA_BITFIELD32:
 		if (attrlen != sizeof(struct nla_bitfield32))
 			goto out_err;
diff --git a/net/netlink/policy.c b/net/netlink/policy.c
index e2f111edf66c..1f8909c16f14 100644
--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -230,6 +230,8 @@ int netlink_policy_dump_attr_size_estimate(const struct nla_policy *pt)
 	case NLA_S16:
 	case NLA_S32:
 	case NLA_S64:
+	case NLA_SINT:
+	case NLA_UINT:
 		/* maximum is common, u64 min/max with padding */
 		return common +
 		       2 * (nla_attr_size(0) + nla_attr_size(sizeof(u64)));
@@ -288,6 +290,7 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 	case NLA_U16:
 	case NLA_U32:
 	case NLA_U64:
+	case NLA_UINT:
 	case NLA_MSECS: {
 		struct netlink_range_validation range;
 
@@ -297,8 +300,10 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 			type = NL_ATTR_TYPE_U16;
 		else if (pt->type == NLA_U32)
 			type = NL_ATTR_TYPE_U32;
-		else
+		else if (pt->type == NLA_U64)
 			type = NL_ATTR_TYPE_U64;
+		else
+			type = NL_ATTR_TYPE_UINT;
 
 		if (pt->validation_type == NLA_VALIDATE_MASK) {
 			if (nla_put_u64_64bit(skb, NL_POLICY_TYPE_ATTR_MASK,
@@ -320,7 +325,8 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 	case NLA_S8:
 	case NLA_S16:
 	case NLA_S32:
-	case NLA_S64: {
+	case NLA_S64:
+	case NLA_SINT: {
 		struct netlink_range_validation_signed range;
 
 		if (pt->type == NLA_S8)
@@ -329,8 +335,10 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 			type = NL_ATTR_TYPE_S16;
 		else if (pt->type == NLA_S32)
 			type = NL_ATTR_TYPE_S32;
-		else
+		else if (pt->type == NLA_S64)
 			type = NL_ATTR_TYPE_S64;
+		else
+			type = NL_ATTR_TYPE_SINT;
 
 		nla_get_range_signed(pt, &range);
 
-- 
2.41.0


