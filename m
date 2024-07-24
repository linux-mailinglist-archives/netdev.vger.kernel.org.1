Return-Path: <netdev+bounces-112885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7893B997
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B5B23A5A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE2146A6F;
	Wed, 24 Jul 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP3v8ai6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA6146010
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864578; cv=none; b=VgCK2+UozU7NqH83rIUn7V4KXcdFF6sBpc/ww2aqWX/hpGziVwlGEh1v+j+ER57sPWkWkkLDkBBPs+0etaqCtAUEys6IxuJAZIr0+9F+sCY0opF0g3Yg6p+6qDtYW8ErNzQNBEQ0X6CrOCaXPK3gWSX4X9a+nvkH7/riXsu/aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864578; c=relaxed/simple;
	bh=bgm+ZFAGhtj8s32bJ1QiVTcA4ZGUmQMtN0tluBoCOdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW7+arq/M5HODXy1Awmnd7Mv7p5HLS8hfTze+D71k6e43aoEpB1Pf3MD9dHGTfBNTu6wMTyFJQDKGd3wh7QdO9uF9ZUg8enp7WZhodyqjpdCezS+B9i1m4G4E1bfuatY4Iz3kn23AcsqIhJXhE/bQP7o0U6IyMFatrLdngGxwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP3v8ai6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ED9C4AF0B;
	Wed, 24 Jul 2024 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721864577;
	bh=bgm+ZFAGhtj8s32bJ1QiVTcA4ZGUmQMtN0tluBoCOdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qP3v8ai6Oa1rOKVEhUEE7lLjjZ8j5s2oxkOtRYwaBp6OSCiXnrJsniIt5tW8SZL87
	 T0lsPfa0kVDJZsWcYBr/D6T+uwnqASKxj/iOED1vigrYhGIZ13YcndtDKLjnt9Zrjt
	 UdaIBsTLaNB2CtJ7k1t9bNNAX86f7UJrRLl4ZoRjLb2LfF/64dUr4MEq53bmMzQ40r
	 UPs+RwnLO08IurY5NG27hV9KrSercIOIiYuZMdPZmAKUIOvr5KvU6593Y+eytA9b/Q
	 CfDAtR0WXW66X1V9ayVuF6cLLLzoKUCl0XXROplAi2ZUE8EEBG2QG24f6oGGNC0Msz
	 Tk5eEIZSqwK4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	sudheer.mogilappagari@intel.com
Subject: [PATCH net 2/2] ethtool: rss: echo the context number back
Date: Wed, 24 Jul 2024 16:42:49 -0700
Message-ID: <20240724234249.2621109-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724234249.2621109-1-kuba@kernel.org>
References: <20240724234249.2621109-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The response to a GET request in Netlink should fully identify
the queried object. RSS_GET accepts context id as an input,
so it must echo that attribute back to the response.

After (assuming context 1 has been created):

  $ ./cli.py --spec netlink/specs/ethtool.yaml \
             --do rss-get \
	     --json '{"header": {"dev-index": 2}, "context": 1}'
  {'context': 1,
   'header': {'dev-index': 2, 'dev-name': 'eth0'},
  [...]

Fixes: 7112a04664bf ("ethtool: add netlink based get rss support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Calling this a fix may be a bit up to interpretation.
For dumps missing ID would be really bad, but personally I also
lean towards fixing it for do already.
---
CC: donald.hunter@gmail.com
CC: kory.maincent@bootlin.com
CC: ahmed.zaki@intel.com
CC: sudheer.mogilappagari@intel.com
---
 Documentation/netlink/specs/ethtool.yaml     | 1 +
 Documentation/networking/ethtool-netlink.rst | 1 +
 net/ethtool/rss.c                            | 8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index ebbd8dd96b5c..ea21fe135b97 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1757,6 +1757,7 @@ doc: Partial family for Ethtool Netlink.
         reply:
           attributes:
             - header
+            - context
             - hfunc
             - indir
             - hkey
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3ab423b80e91..d5f246aceb9f 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1875,6 +1875,7 @@ RSS context of an interface similar to ``ETHTOOL_GRSSH`` ioctl request.
 
 =====================================  ======  ==========================
   ``ETHTOOL_A_RSS_HEADER``             nested  reply header
+  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 71679137eff2..5c4c4505ab9a 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -111,7 +111,8 @@ rss_reply_size(const struct ethnl_req_info *req_base,
 	const struct rss_reply_data *data = RSS_REPDATA(reply_base);
 	int len;
 
-	len = nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
+	len = nla_total_size(sizeof(u32)) +	/* _RSS_CONTEXT */
+	      nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
 	      nla_total_size(sizeof(u32)) +	/* _RSS_INPUT_XFRM */
 	      nla_total_size(sizeof(u32) * data->indir_size) + /* _RSS_INDIR */
 	      nla_total_size(data->hkey_size);	/* _RSS_HKEY */
@@ -124,6 +125,11 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 	       const struct ethnl_reply_data *reply_base)
 {
 	const struct rss_reply_data *data = RSS_REPDATA(reply_base);
+	struct rss_req_info *request = RSS_REQINFO(req_base);
+
+	if (request->rss_context &&
+	    nla_put_u32(skb, ETHTOOL_A_RSS_CONTEXT, request->rss_context))
+		return -EMSGSIZE;
 
 	if ((data->hfunc &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
-- 
2.45.2


