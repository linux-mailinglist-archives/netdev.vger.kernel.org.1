Return-Path: <netdev+bounces-146836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2ED9D62CD
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798FEB24243
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E111DED78;
	Fri, 22 Nov 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USiQgHxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B242056
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295627; cv=none; b=XEsb6B/tsEeA5Las5B+95LwvGc51Ac+B6o6LbXHQ0EU5ovE+x5SCLiOLVg7jkmSvMOJWFqr3Y9q7r7TXW4EkheLQKHhDhFOnyF+wO9KFkAEjurXzeBl4Ud95KxibUte422VY1Ou9pCvnqdKGnnc++SyZmSoZEm3PG1T4BsuhOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295627; c=relaxed/simple;
	bh=KmhrcVvH8xYSIcQaerIpZyKf1gg+0WnG2JsdvOd93LE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P1h4YcGwAfFn5RF44Iqu7P4Cw91DRYiN6vg97QRapiBlP08grJBdZ765KfiavJsslU5HRAVGAobZzljPngw9Qzc2WdD8l+79iV7Oqz2xqJ2hx4kfNFiyk2JqwFPQFo9e3jMSSx4KVJhSBzRWzpUIpPIXSxeTCncXKSp4wbEAOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USiQgHxj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38797ab481so4615923276.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732295625; x=1732900425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppwUOYCAwJEPccTsQy9aV6qCLEEVzHPqGwEmRJublmY=;
        b=USiQgHxjJL2qw/4MkvVCK9RTtgo88EfxQ05YaIzZn58iFUa1thyZ4olP8JtxDmgsDG
         TlWbxh9kGEmZhT/RsoDPiSI5f0Z3jvKjknXBZdkjBxj5Q8TUNAAYE5CO0yfb/6T7/Hu1
         fp1faUp2oo4/u5rnb72flG6Esl8FPyTpzzmLyevGlq/vaLlt6j3ZWgvDcVboDFMfDqWN
         U6hW3vsqqZh6YMD3roacI7mfsnT39YmI+aQhrWaCOe999FawUcoqLJqse4oSGO3CIZQQ
         bF9IpiLWWBoJYCTQSWGErrURSDYOFdsHtQyQJUVA+OB5wmmp4H9rigQV1c0FJb95/kJd
         wZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295625; x=1732900425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppwUOYCAwJEPccTsQy9aV6qCLEEVzHPqGwEmRJublmY=;
        b=YrarilAMBzfymy5yq//NofPwl5IrheZg6kOpnLLr/S+ceZLYrM8erOuizUY6JCwpaB
         6x6DoGaeyOFMekygFYzLlqBUrJ1FdksHmeuQCnMGZvBDOhff+KZWRXf/h873RPJ6m5PY
         sG+EpyLsTsS+WYm4i947qVwgfG5NxZJlwRX5Ul4nlbb2wmmThFMLkV/9Zvuv3fS8C7MA
         N6k0s4ZmxcoCdbm2CKF7Jex1YX8aC8E3EvuqJQyas6rngx5UlTuIBxIPhWBgOP+h/6TK
         AyDZFYF5JBEJu+KD/bcUffpXNznjzISQlt/cGeN6Kcrn8ylFLxSYbptipO1dSte3XTMx
         s91g==
X-Gm-Message-State: AOJu0YxThcGI28h1ZVEhSuSvWQS83VT9L5TkFhyfiP2yLHACGP0q76zj
	tPjihMCzKWfB7U3tHo+Jinnq5mfSVDMrcDsX9Hbu6wtulalTMywiEUe/3l9upOUe8vrACV7PWKG
	hTX4+bNfRnA==
X-Google-Smtp-Source: AGHT+IFhDxj3j51Ke76VRwynaqYDlFfrDcfl+YxtLTKas3C/dNKMEUk+rvMfz2nK/LzI7NwLC7pPL2d5FChyYQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:af50:0:b0:e38:115f:eeb0 with SMTP id
 3f1490d57ef6-e38f8be4aedmr1440276.10.1732295625005; Fri, 22 Nov 2024 09:13:45
 -0800 (PST)
Date: Fri, 22 Nov 2024 17:13:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122171343.897551-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: fix hsr_init_sk() vs network/transport headers.
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Following sequence in hsr_init_sk() is invalid :

    skb_reset_mac_header(skb);
    skb_reset_mac_len(skb);
    skb_reset_network_header(skb);
    skb_reset_transport_header(skb);

It is invalid because skb_reset_mac_len() needs the correct
network header, which should be after the mac header.

This patch moves the skb_reset_network_header()
and skb_reset_transport_header() before
the call to dev_hard_header().

As a result skb->mac_len is no longer set to a value
close to 65535.

Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: George McCollister <george.mccollister@gmail.com>
---
 net/hsr/hsr_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9e64496a5c1c80d916756fcc51553098ffef126e..31a416ee21ad904f68c9f1c99110153b9236ab07 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -268,6 +268,8 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
 	skb->dev = master->dev;
 	skb->priority = TC_PRIO_CONTROL;
 
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 	if (dev_hard_header(skb, skb->dev, ETH_P_PRP,
 			    hsr->sup_multicast_addr,
 			    skb->dev->dev_addr, skb->len) <= 0)
@@ -275,8 +277,6 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
 
 	return skb;
 out:
-- 
2.47.0.371.ga323438b13-goog


