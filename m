Return-Path: <netdev+bounces-77080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A561D870133
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B79C1F22FD2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE93CF68;
	Mon,  4 Mar 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkeqoTff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D863C6A4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555246; cv=none; b=QQbkQk/ivaNbZHwtCRDAQk6PfM366PXAWHhhGItAdSy6Xan6J8KKhrajC2gGr5xs35XinGxhoCbxrFzH9IqI2Tr6HBKiijXoLU6zGjLMiZBMzGAnl1OoEycf5tlSpbsNmwWbkq4I7XaM8ibgl1u5b9teY6KrBPQ7M6Bj7lvOnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555246; c=relaxed/simple;
	bh=xuLWOyzq68+nZXPgLGJCHootHmTZD8Cr72A5rxa8j3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHvbhelF3QYjFPaWLn+B44ac5SzFxNG2ofyr1VgEOBXURlCywZBTdYs7/dMJBeqSYg2pu299C+iP3eLTSWtZjkjiZDjK1ovWHMBElZqt8yiKKURZCOWULHKagUfLNUXQBdgbZx6olsB7uo/0oEQ0FMH3AEfQCnb2N7YULLsg/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkeqoTff; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6100a6b58so738673b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709555245; x=1710160045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWbdXhcY0xlW/VQschDTuYtK2K++3l1INuEy5AynLJA=;
        b=EkeqoTffixUSGMsz8oOuTFVRqKpHlV4YyLRxb8zvFM/do6TZcrCPjb4vx5PkgHgv1e
         0zXpXFb0cjBPfJnujEYUtvvZnF7mGQKJvANFsAdOvRxEKONHgVQEjNijf/mhHmkVBWgp
         rivV1XPMJQ5zw9s4m0wIqcRzLQzQsXdsvn7fLptARbl+dAcyIRkorHo7YzqOiZrDCc9j
         TDirGzjoBPXi0LmXS1qW5SRr1c+6arXtpohbZfDjYS+JSk1SKe/0ADNfCImproLcuoeF
         ScNZDwOYjYMCbn7UsHJLN8wTUzMGMwifcq0LAeD2ZW436F3NwTH3xCsgq8vqbrgsRAvv
         aBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555245; x=1710160045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWbdXhcY0xlW/VQschDTuYtK2K++3l1INuEy5AynLJA=;
        b=JmPB6Vl6VPOCsQNbIZKqUk17yjUZLSL0e/sP1vLpv4eFUw4m+t/tnBZMVhm+RabJs5
         s88wQUluZotRaWVVE+ldPiBJiSB9Dq1PLjJXVUqGtkKSjeg2KOsuh6j/AIkZW135jMsg
         An/Li3l5HOozDauXBKm4s/aHsuh9iTjtXx/R97WrMqolM/SDPdznfkuwwhgPMzm/eyKk
         qiWMq4m3zuCqRijg/GDgHJuhOlpyQNRnL9LyjrmAqVBx9UKn+h2BUMpL2+MW4CV9e0Y0
         4etd/i0mbF/DTWejpd7M2Ov5UbLY6IfdRBK1CRCEemZQ8HeevLKXZms8gz2ZXhyKDCVP
         8g+Q==
X-Gm-Message-State: AOJu0YzABgc29NosFCU9Faeu98rJqNC1mGdTSbjfiq8vfxPRk1aV9NWt
	PP/L9k1S/RkcIRneOEGpCi70tO8OqH/BaVOL87VPub9fpsptMXHfLtPWqTHWWo7nlhEgRuTyN8z
	6p7es6ofu75L8IMRnYJwQzZW4pm0AlbVtujq+0nDlsQSbKsvp9Kcmv9gGIB8UIDRtcYijwqQ/4w
	taJIaSLrAY27otplEGkkM94yESnfTZucrY
X-Google-Smtp-Source: AGHT+IFsnQEncAJk+ccH/K/BFhfpW3o5BpBFm1rq3R7Q4pOMopqD4EqH/dBW1JOzsez/sXLwSR79r9qX2mk=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6a00:2d28:b0:6e5:547c:2f82 with SMTP id
 fa40-20020a056a002d2800b006e5547c2f82mr384110pfb.6.1709555244613; Mon, 04 Mar
 2024 04:27:24 -0800 (PST)
Date: Mon,  4 Mar 2024 12:24:08 +0000
In-Reply-To: <20240304122409.355875-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304122409.355875-1-yumike@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304122409.355875-2-yumike@google.com>
Subject: [PATCH ipsec 1/2] xfrm: fix xfrm child route lookup for packet offload
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

In current code, xfrm_bundle_create() always uses the matched
SA's family type to look up a xfrm child route for the skb.
The route returned by xfrm_dst_lookup() will eventually be
used in xfrm_output_resume() (skb_dst(skb)->ops->local_out()).

If packet offload is used, the above behavior can lead to
calling ip_local_out() for an IPv6 packet or calling
ip6_local_out() for an IPv4 packet, which is likely to fail.

This change fixes the behavior by checking if the matched SA
has packet offload enabled. If not, keep the same behavior;
if yes, use the matched SP's family type for the lookup.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 53b7ce4a4db0..bb7e7593a3f2 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2695,7 +2695,9 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
 				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
-			family = xfrm[i]->props.family;
+			if (xfrm[i]->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+				family = xfrm[i]->props.family;
+
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
 			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
 					      &saddr, &daddr, family, mark);
-- 
2.44.0.rc1.240.g4c46232300-goog


