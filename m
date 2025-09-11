Return-Path: <netdev+bounces-222295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE91B53CE2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0700AAC13AA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72EA2773C9;
	Thu, 11 Sep 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="X+AnvfYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB80273D7B;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621136; cv=none; b=lHABEVFm2Ppj+QOcIDeLJ1ymdKUqI1YiWaSdk/xptuUKrXnfYUbYrCwMvUVzgMnvXTBStnpRNZU+uJJoB/GqYFptQSHSF8EE8/iKJfAs54j1dJZnzb8a9R+/8qVeo3e+X/V1JnFxoTCrNCf5JAxu+qh3NxGYW0NwH2S5UGePgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621136; c=relaxed/simple;
	bh=C+VTgsHCYZdF8SYNjY6frnXzohQkWdBkQ4hBxELYtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVLK6r0XSR1PMLb5LqeOd2pFjQsasPrRXHyEOBwut4tuU7L5TgaYp1p1y7cig7gajzAYw76wWaXxn6WqLLNLjw9+GieuXPCpuMl7yS4/es6WFxNQS0O70nWYD1+eUK8tshjRKpxd4AhnLODbz1GJ4kv9SpVgm2bpRqkTYAXT+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=X+AnvfYJ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=C+VTgsHCYZdF8SYNjY6frnXzohQkWdBkQ4hBxELYtjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+AnvfYJoONEm+GMLbkvkrS9OCuzC2hCB28mkKDJGqcK6WHSxzfpImZoAu9Q1ix07
	 5T+pg8HT7j4sv1tbeqkyazcF087xWSAL1qkAa1aROiOTigbVzZuvr+/2jErnwsfqKx
	 XEd0U4hgTMRNTfQfhHFsPB8oCS3IZtk82JlQ/ke96asU47fkTabpFgmYInKVt60qcv
	 rBi8vVS1s+mE6Qy2BIoOKNU3ymh3JTZQZQcqIigQMjhxvLhYYmMRRRIq2yk6Xqmyeo
	 tWGtT72vlxf/wdWtw67Q+AL/3k+eTZv+2UsWrERX8Fm0fMUnPvV4nWn3eC/OeT+1zu
	 dSDVsQ/ro62tA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 38E3B6013D;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 29F9F204EE2; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/13] tools: ynl-gen: only validate nested array payload
Date: Thu, 11 Sep 2025 20:05:01 +0000
Message-ID: <20250911200508.79341-9-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In nested arrays don't require that the intermediate attribute
type should be a valid attribute type, it might just be zero
or an incrementing index, it is often not even used.

See include/net/netlink.h about NLA_NESTED_ARRAY:
> The difference to NLA_NESTED is the structure:
> NLA_NESTED has the nested attributes directly inside
> while an array has the nested attributes at another
> level down and the attribute types directly in the
> nesting don't matter.

Example based on include/uapi/linux/wireguard.h:
 > WGDEVICE_A_PEERS: NLA_NESTED
 >   0: NLA_NESTED
 >     WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 >     [..]
 >   0: NLA_NESTED
 >     ...
 >   ...

Previous the check required that the nested type was valid in
the parent attribute set, which in this case resolves to
WGDEVICE_A_UNSPEC, which is YNL_PT_REJECT, and it took the
early exit and returned YNL_PARSE_CB_ERROR.

This patch adds a new helper, ynl_attr_validate_payload(),
which we can use to validate the payload of the nested
attribute, in the context of the parents attribute type,
and it's policy, which in the above case is generated as:
[WGDEVICE_A_PEERS] = {
  .name = "peers",
  .type = YNL_PT_NEST,
  .nest = &wireguard_wgpeer_nest,
},

Some other examples are NL80211_BAND_ATTR_FREQS (nest) and
NL80211_ATTR_SUPPORTED_COMMANDS (u32).

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/lib/ynl-priv.h     |  2 ++
 tools/net/ynl/lib/ynl.c          | 17 ++++++++++++++---
 tools/net/ynl/pyynl/ynl_gen_c.py |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 824777d7e05e..70ea14c0a0e9 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -107,6 +107,8 @@ struct nlmsghdr *
 ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 
 int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
+int ynl_attr_validate_payload(struct ynl_parse_arg *yarg,
+			      const struct nlattr *attr, unsigned int type);
 int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
 		      const char *sel_name);
 
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2a169c3c0797..0daf39229587 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -360,15 +360,15 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 /* Attribute validation */
 
-int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
+static int __ynl_attr_validate(struct ynl_parse_arg *yarg,
+			       const struct nlattr *attr, unsigned int type)
 {
 	const struct ynl_policy_attr *policy;
-	unsigned int type, len;
 	unsigned char *data;
+	unsigned int len;
 
 	data = ynl_attr_data(attr);
 	len = ynl_attr_data_len(attr);
-	type = ynl_attr_type(attr);
 	if (type > yarg->rsp_policy->max_attr) {
 		yerr(yarg->ys, YNL_ERROR_INTERNAL,
 		     "Internal error, validating unknown attribute");
@@ -450,6 +450,17 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 	return 0;
 }
 
+int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
+{
+	return __ynl_attr_validate(yarg, attr, ynl_attr_type(attr));
+}
+
+int ynl_attr_validate_payload(struct ynl_parse_arg *yarg,
+			      const struct nlattr *attr, unsigned int type)
+{
+	return __ynl_attr_validate(yarg, attr, type);
+}
+
 int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
 		      const char *sel_name)
 {
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index d63b63ac0b8e..ab5b8d98cbda 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -831,7 +831,7 @@ class TypeArrayNest(Type):
         local_vars = ['const struct nlattr *attr2;']
         get_lines = [f'attr_{self.c_name} = attr;',
                      'ynl_attr_for_each_nested(attr2, attr) {',
-                     '\tif (ynl_attr_validate(yarg, attr2))',
+                     '\tif (ynl_attr_validate_payload(yarg, attr2, type))',
                      '\t\treturn YNL_PARSE_CB_ERROR;',
                      f'\tn_{self.c_name}++;',
                      '}']
-- 
2.51.0


