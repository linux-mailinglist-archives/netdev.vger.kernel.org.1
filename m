Return-Path: <netdev+bounces-252060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIL1IvxLcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:58:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF775E63E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B095E4ACB2F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EA34AAE4;
	Wed, 21 Jan 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="EkXSB4Vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C5337B87
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032191; cv=none; b=E3u4TS4X3KLdHLrLTVaG8boKJwwarmxo35LboX9f2GndUD68/gGuyJptwM1ftkdNtfFD4cDxGxK+aQhHR0u/P9kZ8RKhWrIhgLaSv29Bpb8p2NjDKDlb01mBulFii9Qei5eUJ+K7m8pW+G9L7dSqA4ZLxwJFBFICrGTNOYn6V3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032191; c=relaxed/simple;
	bh=RxuB4fQOw40GjTFCeMNeAO9JQq+9pyRO9zVS/bwqwqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZgxH5dscv0RjGqnU0UGofimIgx2GX0Y7nZ76xaiWzVn87xT9HuE9adsZobsiYmHZBX1ExENCuHKN5x+Cv3c4FgJ4TO0Ae9NH1eQj2e2Ry6QgBdTgxoyNC7jMGgruoweWTFoFXWe3/V1Kj/p+quBuYm+SndkRP5Mquwwnl6abBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=EkXSB4Vv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ad70765db9so437618eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032189; x=1769636989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxarzd/JYXJXH1ji4SIrW5uq3pJu4+kyHJNxhFjiKx0=;
        b=EkXSB4VvgNZaTd+Uva363RT1OlAkes69dqkGaiGSkLTfpZniV/OLxxxUEY6yPk10Yg
         Ss3nc9RuKsvW38ch3TGCCM0r6mlhQNJWQGj7sKYmZQIbvuKoXAPTDKjCmLKLoVvWjGH8
         Q4vz4WKzLTl5SYw0EllyA024sFOo2TSToz346/DEJXiAPAiSqiHdoxCYJ7DfXvZETWvG
         E3n738odX1twzE19LA2Pyw/zFSOCyDincl7EabVG89jEirSH8dZ2AkSkewAvAhj3sh+w
         j6EjLE00wZuIkeum0ebR8xOTGq8lo/h5xA+ykWLu1nE7Np2af3dsjEbU+hwpYt2lopY/
         MzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032189; x=1769636989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxarzd/JYXJXH1ji4SIrW5uq3pJu4+kyHJNxhFjiKx0=;
        b=km6X+YM/VyA+xNgMgiSlNkA9qyA+nE+F3zdR83eXaGA+CgCJfsd6thE0zpldXTOShd
         Djkmea9+GDe3BlEiSsM3+KEzBJOYKu4XMG+FeL61mwPXGuhOfa9pUmFvJwLy6JPUIt94
         bafjpvY5VtkYeDn/iLvK/L/rkDz6oZp9TShiTGqrhPJWMgRxhf9ttu7cPPhFuhpxJXoJ
         kFWydQwXfH3XGp5stpWFAEjHHtz9o/u1gPeZc8IK7TfIjRPwH9JaI787ZwHKR4yRO/jd
         F6CFWDIRUSWp6a9xAhSdJsA+8CxWGShoaz4gFm4yV4zkgiPSgAXZ+UJA2awUa1TTn5cB
         EGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVZLWNpRssHll4sXH8mOBAOum4bagPFsCVfhm0Phxqmcie3a6dTIDTW4Twk5GY3QdtbAhY0+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHiDRG631rSeQRcbmaRrHGsnoi8z8UI3XNuR4I2mdAAYtr8vA
	C0NJDuzycu5U6JSJ6cf7bQebjdIZXvBw9YsDmaLS2tUAklLqVPsXOzveCXnKb9KQYQ==
X-Gm-Gg: AZuq6aLIXLYItyeafjLHWa+eOk6slWghJRlWm0S9546NdkmFvFaWCPRasps812q3zE5
	kCqQZmYivSIuUe+XZRF8fPVfTuKy/9Vh+sQKC4oBR89CvfzF+srHak8er10qwmSmwTQKTUFvBnj
	KTIFPssf0zPZDmLoBrCK3GT1+c9m9b0wa/MWxhLSkSYWxrTYDbl3RUj/ZQ9yBHGquV1MxH7eByH
	uhh96jC3uuUlTwZx0tQHoGTuX4GrJ2TTIbcAeIU9U8l9etLhZ6yJ7qERcdPUzlknr5Jlg6hzUod
	RSwsGL384+98SebnucijDGvYOR1aaIrSYDcDg9uxhL3vTVVropNuxzsvc4LXs4WFGHDwD59SXY0
	thfGG6cGNjKs5+W9bJPvUh4y8xE7KYHprA/upVPYhEHW4/lQZz0W3tX9v18bzDZG2X1bNhtZy86
	idwqpoZQThq9OC1sqzxzf2JP/oVybH6sib0VDZbOkjropW6c41NgJpnn3cyr81hpK1c3g=
X-Received: by 2002:a05:7300:3254:b0:2a4:765b:b4bd with SMTP id 5a478bee46e88-2b6b5045f4dmr13364107eec.37.1769032188014;
        Wed, 21 Jan 2026 13:49:48 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:47 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 1/7] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Wed, 21 Jan 2026 13:49:19 -0800
Message-ID: <20260121214925.112604-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[herbertland.com,reject];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252060-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5DF775E63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
drop the packet since Hop-by-Hop Options processing is disabled.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54088fa0c09d..45bbad76f5de 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int extlen;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -1041,7 +1042,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
-- 
2.43.0


