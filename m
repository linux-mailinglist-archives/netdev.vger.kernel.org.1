Return-Path: <netdev+bounces-248197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79828D05607
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF7F9351A923
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0E314D15;
	Thu,  8 Jan 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Rvfh86mq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDF3148C2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892540; cv=none; b=TPjbrwGCI8usWD73VknVJKpcDE7Shb94nCQE8IrUVX4BWpWWV8Tb6cfgzdde/KpFwaIj1mC9GL+8kb1pu4EUhUk6guE/AldDSfMHvdSu6TSEBquCsxICY6RNCoL6N8fsIlDiIZKzMXtiFaNAWW+jupVg1TZoLl+hXYJunloOQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892540; c=relaxed/simple;
	bh=Pp+RyNeLzhhLKDsxA3l7VyNB9D7kU7+G+58F0/AdNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvoOuQUsnz3Uld2YJr6XJH1xWXXvWsuP+8eqNjYfzCvxg40utUnvkI2y42HJ/k2611otqu9Y+1RkFGSwSIU+4bPUTQ+Ck1MGvVsfWT970Zaby6dgjP/OUx7BnKQJvXDY+TS0EpHGT9EyiUrL72EGRzGrseQrHmfbQX/vZwvd/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Rvfh86mq; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f3a10dcbbso2696702c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1767892538; x=1768497338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QX7tWIaD7P8JHgeRDVlG6J8pJuBtN6MtFRMVvJ/yns=;
        b=Rvfh86mqxvQ6p0usRKBz5OoP92eT4q87kwx+PJTTKELdK+KfBZuBrhEmgVgZItdGPD
         bX7GnYXW5C2hrXjOdgknS9slZQlpWt+VxcumFbshg3j7BxDo1JBh2w2xC8AQiv9/1+n4
         It7LL+QfQzoZBdfhuKVVDhpLG5frZEvmADfCJbJnp7zltN4qT5O9LsNMCAsIC7RNKAb5
         NDrfhdv+h48L0IeAa95McOEbHyM/X/BY0kQjosrqgxhtjeCaxCcYJPbJ3Z5HSCLe0U/c
         VNcYEOfcJcvBFjppITzFp1p3Iuou47F0UcB3iqkU+2i5rFQIgeyXiD/hjBA8GXuHxb1t
         +oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892538; x=1768497338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QX7tWIaD7P8JHgeRDVlG6J8pJuBtN6MtFRMVvJ/yns=;
        b=fuwW2pchpnPk/NExcBC/kHtWBc9kckB18cBqm7MWQ0M2H/w0K5a95o7Me4RrSZ6CVj
         jM6QMDx7DAH8pGd8cAPDj+ygsoCybg/2+Z4avckTdED/3TjxnwpWqF+WR08i3Jy5Hzjj
         FsbT6ZhPseMqsFUlnMaTRW7u1bZmucOEVS/baBj0kptHSDU8CtWOVgvC3uAMPomixmwm
         v+uOdQF76ATMv9ZqYSzpnTmdhirxXiXlnwgOj6DUNueAaHPQZHKkaYm71/ZSSuf6VAnD
         FpMOLDB9lfdEw3ltevxl9iaLMv+VxdIx61MYVizDhqCYngDcK4o3MUYT0qUFmd5SSFGA
         LuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMma3dcXWqgOnuNCuevQnO/WOWPDys5PEy4C1dL/BF4ItUDDDrH8q4JStv9q0eo1S2HAocezQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3C9xsaSHz6NF3U5SI8dldD6TwLpmgTjCvSf6s7KcsaxAuYeMf
	8KzPKblhOxLaXGXd2zuqcmclIzHZIFzmyRbNtH8ZtwKPNo7Amo0lbvwmVqs4b7/h4Q==
X-Gm-Gg: AY/fxX4qlwcuix3KTWIrwtNvnFCquaFora/mzEUbLCGlE9hqyIevNKKxTH0KKd1rLQV
	ntL0c3xA4kwsWY8ij0c8hnPpyCc895Mq/mluO+6aU3vKf6Ng+q3veNSkZgovkuyKG90OhXit9dt
	rAGq/RcpRU/vBKLWYtocG/5kBn+UYiRSAxYMIkdI9uUoEzQFFFX2yuDd7i8XBxhMQRlP9pkexwl
	m4rWXSRegQvbiGMQCbIUDBTqzfyFZLuMlJr7Nxpymc1sOUlRFspSDC03b+9foJrtqGvg+8IT4jS
	MJ2BpHIDooXCM/dcFo3oXPUrqZNL0vRKXlN3/qDQMUVD8aqAvJKIT6glr5+f1si7v2VOgUqeAxx
	xdQp2Ve5z/eny+ihRlFo33vkAcOGDcZ4eI0sV9rJCEWx6FIoJkKYDlXfZknpixQsv18wQP5NrZZ
	+gMrMswj18fMlxxsobtYa/I64hmEQ25zia83cNDqHMZQ5eztByvNFqFoqV
X-Google-Smtp-Source: AGHT+IF7gVTdRtJ6RtXHPaPKcXv2udeUgKbapJRgXRIgRG9hH8Wge2wX/UBF7jUGoYOu+YYXOrxxMw==
X-Received: by 2002:a05:7022:e0c:b0:11b:9386:8264 with SMTP id a92af1059eb24-121f8b8dd4dmr6015255c88.41.1767892538015;
        Thu, 08 Jan 2026 09:15:38 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:812d:d4cb:feac:3d09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm14029259c88.12.2026.01.08.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:15:37 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 1/4] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Thu,  8 Jan 2026 09:14:53 -0800
Message-ID: <20260108171456.47519-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108171456.47519-1-tom@herbertland.com>
References: <20260108171456.47519-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a23eb8734e15..11ff3d4df129 100644
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
@@ -1040,7 +1041,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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


