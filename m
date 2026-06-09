Return-Path: <netdev+bounces-297135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmDIGFE3KGpMAQMAu9opvQ
	(envelope-from <netdev+bounces-297135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B35662085
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DwatjoPr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297135-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DD31327727F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668A47A0DF;
	Tue,  9 Jun 2026 15:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781B43CEEA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019128; cv=none; b=htrp3kjyRPvPTTm4pKpnw4u1tVekrtfyjyI58k65QLMgm0ECatAx/f91XmiJTi7062MlmYERNpvGd2D6fEk52b3c8krgVgz+HLB4T1s29D7tPI4RVnxQaQtmikjGYsxriFA1wmVHutsBeFt5NAkId/TuXn25jFvJaPQ5jpZhS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019128; c=relaxed/simple;
	bh=ivMpJTuST67OvWZvLSPyo0l4X0xZhd9H2nyZTc7Ydpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NWotH2APtOnlqYj8lCOnd1Dma38VPI5fy6TrriyIFhgpDoT5AD4oxgnfr1wECleXa8Uzkuuq4WL/ByVUgT6ZIoac/GETKsXHU1DQw/CBoPBKTeokRYCu11hhNJgXwEglJIK9eA6812JQpnViKgbNFMMIWTKmy0dKYojyoEkrTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwatjoPr; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2710592b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781019127; x=1781623927; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ekJGw9V13VW+N9NwEBgx5UfRiMWtb3j2m0dcn4FQ2A=;
        b=DwatjoPrbbeRxbkAHLD+j+UeP1rJ6diMlwJl1W+hA0q1IJa50rsGWg5Rw5c/+djTn0
         G0KayvCpGt7lTqWMFK4I9b53lOSsljdClAXb/PijrFYAhiO8VVCSDR+fOJdfRtnqT/lb
         P+wfeyRl8nIKj4vKUTGsROBxDN4RRJxezxApyZ2pmeZcs/Xj9vn3xZoNYz3pIvA4/My9
         e/OMDZI+UtHp/qLZJroPj+gtiDAX+MbsyWEzGIPa3TbgqaNoP1adhDyDI6Tg10ztLEyD
         tyGsuCDT+zz+rRqokaqrExtVy0CzYcYYVYmtv5yObcU/YpPuIVFc5Ya8xzmCQ9WSuyXi
         RjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019127; x=1781623927;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ekJGw9V13VW+N9NwEBgx5UfRiMWtb3j2m0dcn4FQ2A=;
        b=Nx4uYZqGdTl4GGqpzJVD8UOBij+2Nr07KqrFToc3fMSenzFwL9K6h5buA6S1VUqNZ3
         t/4dQ26PM1ClLHRGdK481W/6UNa1pJ24S1zjz+qr6NJkUWcyU8041U6TZ6MKbTFG4VLW
         pfxtxqDD+z6Fg8F6gDsDW3Px56zNSj31e0VIG8VzzJE19NHvLqeAtBsYpG7JKdYznI9n
         3XUkZdrun267lN6qboCILChRhYE/9cQlZjwwFegvShKMcAeg3uOaYTXpoN/FwMBMpawP
         GtogagJQe4GbK5TA/3ewSSc6BM9xZJGjwtrC5ofs+1Zbij5gnnhvuyI8yEalAGkEl7oz
         oUsQ==
X-Gm-Message-State: AOJu0YxdHisK6/+zkWmOAObwH1wiyQ8FwNrh/PyP4FuBNW6N129gr6sC
	RcJDlkj7Y5di1bSU3T2VuOhUMhJf503hBjL2OnbWYOAYq5Ty3cdsMLP8TJhc5k6kwuo=
X-Gm-Gg: Acq92OEnoB0Wtx5A0uu+GVU44TzlcGMsVzVFG7tsCdGLkJW8VDx9Si22Z8M3DmuV9Fh
	Ya6VDdptQ3b/NygaXGTnPbbqxsoQ2f/pKp8MFLSUNYQHcUKj1pripE5zaMYP3MDK8BWjUvRfl96
	Y/vFCmxxvO9jb/q51ld1mIpUHa+goPgiEL40/7CNtg3w7t36qiSkf95i7Hh8WTXKs/eoEaBBING
	Nrchbsr2gFFdxSfwQrzAnS7zG74paUpXxGg871YCHkc3rxfUbDh5CD2xOCSyTCPBzRfILFeF1GT
	BnX9b5ZU1mwPcos/m4v/WAexxWYEcq8VRl80cJ7xLZJMwImcgzb32M79izy61lsy29AknoMhUpZ
	PL/2Pu0ZS7Vk+caw8M5dItcY/dCXiDl4vXG2hwo9VMSL+oHmldEHaNaPhaowN9T9P3+ZlgcTjN/
	GqgzJWtoMA3m2ZJohuP5pUKUPNPuylVC9LQbbDPc36Rxq+j2IIqp3deg==
X-Received: by 2002:a05:6a00:1d84:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-842b10b2f1dmr20267200b3a.40.1781019126967;
        Tue, 09 Jun 2026 08:32:06 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84300cb0a82sm4400668b3a.53.2026.06.09.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:32:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 00:32:03 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] ipv6: account for fraggap on the paged allocation path
Message-ID: <aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9B35662085

In __ip6_append_data(), when the paged-allocation branch is taken
(MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap (datalen = length + fraggap), but
the fraggap bytes carried over from the previous skb are copied into
the new skb's linear area at offset transhdrlen by the subsequent
skb_copy_and_csum_bits(). The linear area is therefore undersized by
fraggap bytes while pagedlen is overstated by the same amount, and
the copy writes past skb->end into the trailing skb_shared_info.

An unprivileged user can trigger this via a UDPv6 socket using
MSG_MORE together with MSG_SPLICE_PAGES.

The non-paged branch a few lines above sets
alloclen = fraglen = datalen + fragheaderlen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
Assisted-by: Xint
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
---
v2:
- Fix mail format.
- v1: https://lore.kernel.org/netdev/aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain
---
 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c14adcdd4396..265502caa44b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1668,8 +1668,8 @@ static int __ip6_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 			alloclen += alloc_extra;
 
-- 
2.34.1

