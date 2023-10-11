Return-Path: <netdev+bounces-39767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED137C46BE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7191C20D28
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A4C14B;
	Wed, 11 Oct 2023 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7QGOSIh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0BC147
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F13C433C7;
	Wed, 11 Oct 2023 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696984403;
	bh=kwmpRM7PkZGDlJCRHlww9qoOrGfsbM3+ZVdZLMtp1sM=;
	h=From:To:Cc:Subject:Date:From;
	b=c7QGOSIhUpejqau2FhfPn/UQr7N/r/08+WuMLImtzlHHD9j/VclH+0HkHFf+mJfRW
	 eme30QH/x7sphClmrMMSY3t16+/yu51+UgXXSptd8bS5aD2PiYpDtLy2S2Nzwwuv4j
	 PLRXHCUKXZpJBVgQ+1H95UyFYAKKqPdw+Wp9M3KSGGmTI/EHdwL3MZMCUtYBNTIwIf
	 8zmUY395Rql3srYG37ZShdaTNVeHuRKKKAHgBgQHf/peaaecE3wEB34bDl9f65R2Qf
	 P+aKzqrWBZFOcHr1BCforHMgX4XnXFIKJ9HBPDOWbU4I0g/GB9lPJzVhhPlD3m2GOl
	 6ft0fO6h8a6fw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	jiri@resnulli.us,
	mkubecek@suse.cz,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC] netlink: add variable-length / auto integers
Date: Tue, 10 Oct 2023 17:33:13 -0700
Message-ID: <20231011003313.105315-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently push everyone to use padding to align 64b values in netlink.
I'm not sure what the story behind this is. I found this:
https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com/#t
but it doesn't go into details WRT the motivation.
Even for arches which don't have good unaligned access - I'd think
that access aligned to 4B *is* pretty efficient, and that's all
we need. Plus kernel deals with unaligned input. Why can't user space?

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
Currently telling people "don't use u8, you may need the space,
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
Thoughts?

This is completely untested. YNL to follow.
---
 include/net/netlink.h        | 62 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/netlink.h |  5 +++
 lib/nlattr.c                 |  9 ++++++
 net/netlink/policy.c         | 14 ++++++--
 4 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 8a7cd1170e1f..523486dfe4f3 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -183,6 +183,8 @@ enum {
 	NLA_REJECT,
 	NLA_BE16,
 	NLA_BE32,
+	NLA_SINT,
+	NLA_UINT,
 	__NLA_TYPE_MAX,
 };
 
@@ -377,9 +379,11 @@ struct nla_policy {
 
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
@@ -1357,6 +1361,22 @@ static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
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
@@ -1511,6 +1531,22 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
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
@@ -1600,6 +1636,17 @@ static inline u32 nla_get_u32(const struct nlattr *nla)
 	return *(u32 *) nla_data(nla);
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
  * nla_get_be32 - return payload of __be32 attribute
  * @nla: __be32 netlink attribute
@@ -1729,6 +1776,17 @@ static inline s64 nla_get_s64(const struct nlattr *nla)
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
index 7a2b6c38fd59..116459f35a4c 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -433,6 +433,15 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
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


