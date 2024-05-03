Return-Path: <netdev+bounces-93343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A68BB3D4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379CA1F257D5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9770158844;
	Fri,  3 May 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXmVvi0W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC61158869
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764066; cv=none; b=bBpCE/Evrmv1KinNDImCIYA55W3dKx1v5B429u+Zrabo7/btGr6YroKG9RUfG8ozA8vpvFmiXaTt3ZWYsi35BNITYHZkcjR9SFz5cXYgmaA7UO/H9tKNxSrQtpgk8JZXHjjcXIAHLCa69kAfAAuWdSYfNpVMzyZndcL7uXoV2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764066; c=relaxed/simple;
	bh=cjtmtU/qY66mskFg5LMQm5YqDpAxiSceCr1Av3WJ0LA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQ9B/WlTzuqsRTk5dE1qYnv93j17s65+xQO5CXA6y1wcqocjuZ7qwBHx8gyySI0eHjXZiblwa1Mv0cOwUmY9WW/QXVm65Qv0rfk0mYZ5m1ZJCq6tFk+ftKbZ3u5cfFmal290Fl9+9dzAtQMkciddnXE6joYQpGyHrGucQ8oQxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXmVvi0W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bb09d8fecso140413477b3.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764064; x=1715368864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dz6D2GuVBAhhi2ShyqTlonmshv6ltlgTKSRmhVnZVcI=;
        b=KXmVvi0WUdbijAlqXMHSVGBEnwXnBWzi6Nqh0ltJg5T4Yn+fc15jc8DZ4SX+F5bVXT
         MCNUMQ4sFoohZDpHglDEqSDEzdDUajBBfigR83rB2+SXjU3D0MpTXgSRQcqeCLOoK2hS
         PvYH0YS08jzpVIeg/Nv8C9nZLHPuEFTMwEF7Iph+NDWMsY/VgTVpZWoethIKcdsUlJPX
         mY/EpsjRxk5DgAyd6Mmiqmk2xnTKBZVYRUH2jqrZPLYrJx0r4WHPstYWUPlfwmTM5C0S
         20ZvQ6VwfilDgZIm9lirTegLYPlArUd/zZzEOe4eJZF9xci3j3cnvfXKCC9vS+Pcw4F2
         qSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764064; x=1715368864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dz6D2GuVBAhhi2ShyqTlonmshv6ltlgTKSRmhVnZVcI=;
        b=UxLcJPqd6WqJjKEVJL/x59xY2bAqtw5ggMq20uOrhVgUL7gL9YDLSe2nNsMqu/TVu9
         5DK/jErAa5B5E3dw/2V+nH5ZD6hOSxiNlfFrGipehQySJMlc3Mh6Xd6NuPF0+C2VUaXQ
         +rdc49hz7XxhupeG+1ik5+pVx5A8RhbfnsoEBQT/d7AqVZIYjB/1YWtXqZktaL80N8kW
         Snl9iCIdga6+8FZGd/ZOjuDrlWu3kbp0vcEttUEveWj2AFKx5BawAH7h+5xq3SfEZ4vb
         /QZdRRfSZQWhfX6ZDAF7CbCxaUS89AzkUVCI1829IxRV/eDAneecqob/93egzXX3wZZT
         jkqw==
X-Gm-Message-State: AOJu0YxMMUlXgJAqfrpoEOsIdIG/ZlTZv9ak7NGuTbEMEK1SIcLkObiw
	nPXzMSAlAvRCkJBCT1f473jIBos/dODEmR2pJPOlip1g1CXTaMeel5EkOc5oGK00cR157m9DzHP
	UyMGztCVrKg==
X-Google-Smtp-Source: AGHT+IG6l3qlrG5m/LlVp3NMTWf8BX0Qs4BWlh+srDdvbN4hraZZJ57Who3dt3ia0gDr90pSTYUUmCInk1I5pw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18ca:b0:dc6:b813:5813 with SMTP
 id ck10-20020a05690218ca00b00dc6b8135813mr468363ybb.9.1714764064231; Fri, 03
 May 2024 12:21:04 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:53 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] rtnetlink: do not depend on RTNL for IFLA_IFNAME output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can use netdev_copy_name() to no longer rely on RTNL
to fetch dev->name.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f4a87f89d5cde0cdd35c156d78ebe31511d4a31c..a92e3b533d8d2ed1a52a40e02eb994c3070ede38 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1812,6 +1812,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			    u32 event, int *new_nsid, int new_ifindex,
 			    int tgt_netnsid, gfp_t gfp)
 {
+	char devname[IFNAMSIZ];
 	struct ifinfomsg *ifm;
 	struct nlmsghdr *nlh;
 	struct Qdisc *qdisc;
@@ -1832,8 +1833,11 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
-	    nla_put_u32(skb, IFLA_TXQLEN, dev->tx_queue_len) ||
+	netdev_copy_name(dev, devname);
+	if (nla_put_string(skb, IFLA_IFNAME, devname))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, IFLA_TXQLEN, dev->tx_queue_len) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
 		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, dev->link_mode) ||
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


