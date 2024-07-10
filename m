Return-Path: <netdev+bounces-110588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55792D4D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6291C2312E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028DE192B8F;
	Wed, 10 Jul 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efgbkzUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39818FA14
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624617; cv=none; b=shSH7Hc6A/zUN1RhdPuaI1Ty6i0oowd0WnuFkexRci0f1VowwMukNIp/uPswu2tQbeE7VBAPw4HGIT8gAnipv0glvHI9g+lh1pmoEsywLX9Lr6nOX5l/cV1JFtB1Zn9pqsk7qQZGlnUmNPIqoWe2lD6+5P942A00g8TCEbiiOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624617; c=relaxed/simple;
	bh=qSB28iDkP8YascThZXPoDoYJir7wMRxeXaIqM56AYyU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dd9YfyeY8jQEu/kpNkMLwk+nXuR61nMjN/SAyZTERKtzX64UZmqiBpKX3G1iPK0iLk9cyAGuLgBWRdEEF8PpjkDFx2g6kT799/uzwe3ugb4CJNgaH51y2zhOGjrqgs+v3rv0EQ6ndZ6N90kFBr+bZQ1g8rIxJo+3ax0pinI1Hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efgbkzUR; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-79f0283223eso649544685a.2
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720624615; x=1721229415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHS1QFsZTjqrHkA8tGsX6273RP9+w+12s3zy+y+UPUs=;
        b=efgbkzUR3gymnR1QGJaCk2TXTiRkFGuJy6DlRRmvnfYmtwBNxku3B9IISHltrhomTr
         xY2Z6lmcysjjHWiI4OJhFMMyUsY8OdRvpU5EwuGJmph2PSju6X/dx+wV54x801XWUzQy
         BJoQVcAw4NDkeJo0c7oq6zclCQ+Mx1djvbw2Kv0L4GPIPqWbybG4yWYwivMWBbVFcP1U
         3oF3Ft9HQDOgrB4u3jx8MA80pskFFqD+dnbi4nVQE12QXp/mhQM1nRPzKOEuyvO0aO3U
         dcBLQi16GjDgZNUjj3wS47ciAuhyT2dG7ehD5d93fvANIyyQN9scfkWBsk42NMwNmhJo
         v+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624615; x=1721229415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHS1QFsZTjqrHkA8tGsX6273RP9+w+12s3zy+y+UPUs=;
        b=V45mbKRPrCqI+OMbDtQnbBNegJ17UCnlJhP/QimOyJCUCMmmyasBjiuOoZHh9qeNr8
         pQY+IqW9ZcNA1/umK1Cmf8SgNT62ga6cS787ae9EuL7eRRP5gPaZHhR1f2LMPEXu8Nd9
         Uk9d6mfACYje70A9KbDCpeBF2syKstEeA056ZH1BaKF6fomvXaDInS0FiK11hfGhv4L3
         tkBVug3sjfwdtFSaVkPEL2JYPipcGQr1P1sQ3no0E26s4tScsmvdlij/y+31++kkg7Uz
         J06E3WU5aJ2VgdpEZEIF2xCx7XWCLLI8rKypnunpCBgOGPctELenXcBm2QIiNhf/BJjU
         92Hg==
X-Gm-Message-State: AOJu0YxWk9fQVGG7PeZdzT8mh68Kl6ilIjhvY96SLY3fy7DpGPpo0HS+
	+VXodQemZYucQuJoekbyAmXWH7wNxsaujA9kxO/9sjzdyMrQRYaFzBtW7ckZHsOs7icWYmHXUfw
	ovQ45zp9R4A==
X-Google-Smtp-Source: AGHT+IG92PO78IuiEjOcRTOiTEfJfsMjI2kXGhQfKIl8B2Q+Mte/HiR0NSD60+3K42vuGv1g8Xo2nGp8cLUMHQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:29e1:b0:6b0:7c57:26da with SMTP
 id 6a1803df08f44-6b61bc7e1f4mr3999386d6.3.1720624615110; Wed, 10 Jul 2024
 08:16:55 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:16:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710151653.3786604-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: reduce rtnetlink_rcv_msg() stack usage
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

IFLA_MAX is increasing slowly but surely.

Some compilers use more than 512 bytes of stack in rtnetlink_rcv_msg()
because it calls rtnl_calcit() for RTM_GETLINK message.

Use noinline_for_stack attribute to not inline rtnl_calcit(),
and directly use nla_for_each_attr_type() (Jakub suggestion)
because we only care about IFLA_EXT_MASK at this stage.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e29f2ef3e5c1481715ae9056ea689..87e67194f24046a8420bbb51c19fb0a686b9b06b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3969,22 +3969,28 @@ static int rtnl_dellinkprop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return rtnl_linkprop(RTM_DELLINKPROP, skb, nlh, extack);
 }
 
-static u32 rtnl_calcit(struct sk_buff *skb, struct nlmsghdr *nlh)
+static noinline_for_stack u32 rtnl_calcit(struct sk_buff *skb,
+					  struct nlmsghdr *nlh)
 {
 	struct net *net = sock_net(skb->sk);
 	size_t min_ifinfo_dump_size = 0;
-	struct nlattr *tb[IFLA_MAX+1];
 	u32 ext_filter_mask = 0;
 	struct net_device *dev;
-	int hdrlen;
+	struct nlattr *nla;
+	int hdrlen, rem;
 
 	/* Same kernel<->userspace interface hack as in rtnl_dump_ifinfo. */
 	hdrlen = nlmsg_len(nlh) < sizeof(struct ifinfomsg) ?
 		 sizeof(struct rtgenmsg) : sizeof(struct ifinfomsg);
 
-	if (nlmsg_parse_deprecated(nlh, hdrlen, tb, IFLA_MAX, ifla_policy, NULL) >= 0) {
-		if (tb[IFLA_EXT_MASK])
-			ext_filter_mask = nla_get_u32(tb[IFLA_EXT_MASK]);
+	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
+		return NLMSG_GOODSIZE;
+
+	nla_for_each_attr_type(nla, IFLA_EXT_MASK,
+			       nlmsg_attrdata(nlh, hdrlen),
+			       nlmsg_attrlen(nlh, hdrlen), rem) {
+		if (nla_len(nla) == sizeof(u32))
+			ext_filter_mask = nla_get_u32(nla);
 	}
 
 	if (!ext_filter_mask)
-- 
2.45.2.993.g49e7a77208-goog


