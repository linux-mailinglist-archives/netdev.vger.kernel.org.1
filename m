Return-Path: <netdev+bounces-276884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO9yI9Rf12noNAgAu9opvQ
	(envelope-from <netdev+bounces-276884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 030DF3C797B
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8024302AF2D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9639E6F8;
	Thu,  9 Apr 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ai5YDOxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2A39EF2F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722420; cv=none; b=EkLNinJQmbhIrp1fSCzBhP6KPdIENEb/ktil4pHtFP9QEMjm5USOvODXTt5qPVIIUgvzbjmJ9m7Ze/5IqSbL4WvGFIoilzfFGYEJ8eVTp/v+e5kcJtzgHK03WUev540oDHAasFamqJ/d+GrDqKcebCzhnx4HJYk4fIrfosYAKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722420; c=relaxed/simple;
	bh=zVpeYCI0Fp2z5aqjv7cM/PPua39ANpiE2GE9IcuZhfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRrK29S+apnXuObYJnd1XB+IZnzSFq0YMPrOvpbYPeimPsc5pw3ImVbEezxaeridGcGXqBJvnnuehe6lIsS35WMoI8z3U3hqIE54ru6kYG6GEYPN/jSP7yZMA1kQlNYFjfvJd9TvSOZ52wZ0siJJbI2LKd95u0FWqvSJ4+cz8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ai5YDOxS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66dd1b5bb6aso923089a12.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775722417; x=1776327217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLl5gC/5dARZUSktr9tifAs18EiDAxNQou2h9Hd7lWo=;
        b=ai5YDOxSESAibjjoqzj6vwacxgrGcmaoMS+m6WTTP3fBMt1V6SUwKsX/VYPRX1DSgh
         klERBGmCt7CbrW31GnumjfHp7x289kiwrHAl2k/gBu3ZcTpGXpN48gp3kOElQ4KmuGmD
         S2s66IQ+3qNSUD33WG4dX6VX9vfpDy3YfnM1gfxN62mprd5JL7jKLLGmYnFpyVKhNIun
         fuC2e69sFBUxBCERLQ0btgVfSyWlPin+SC+X8IWDqd2HeRjC+B5JCwiEhDQta3WQ2zlI
         Te2KgpXWb+AvY3Fu01ytcrHqxPiiTZiyhuaGbf3HdcfM8Q9pFxKCYXstMDI60kGj+O5Z
         1yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722417; x=1776327217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xLl5gC/5dARZUSktr9tifAs18EiDAxNQou2h9Hd7lWo=;
        b=kL8JH6SdytxMTrUAqsH2K+K4eVXb+ohLvHmMGfpa9PGqUfba4RTJQ5nDGarIN8D+nr
         XaDYTEfsukuFmCQ23IfqJIZ9HX4zmesQrzmAy+XYiy2W53jh8lgc8CHvnBTgLxF5YvE0
         Vp5obkqMRXIkrhNupvb5INCmpF559CW9xdjlA0HMrmAwMoSIwloLFHxOVKcnd3pf/jBV
         03bw66dJMoxP/6kUO9vbPzBTvVBUtRw2jyWCJzmpNa/m51Lra50wd3Rbs+pau+dz767P
         Kkjp/t00QUulNQOPI8TTIlt7lZeGlMaeAEt+jNFoQTD7QBf+ISfozRlBO7RPYwSAb2+n
         TGPg==
X-Forwarded-Encrypted: i=1; AJvYcCV1VCbYsZZxBj5I2r3SWuG+Su0qnvDlJWo8XxftrRtXx4g+hGp8BFlmAQdnXvwiyf5q8dPJkXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdHZIQpeVgTQ+vWqYF5mWxAiCgQqBu9MXrmjTLWqjEZNRblHU
	aVQl8ASaib9c0qvUmZwfyCEfPU5hqdNNKEM6gV0B2Z53wwMqFZOOZycm2qlIgw6j573NdCOv1Ef
	Wi6vmFcM=
X-Gm-Gg: AeBDieucuykuLBS/BnsYkY1122omljUg4wEwvEhwCnKFBPhjRxSjcWDD2g0bNXcc5y7
	yBrs42StasxZkk6/Gv9BACh+nI8vuSfJ2LscZY6N/y5oCYtUDfg/3xdgZiOuSiGKE4TXaJRvEyI
	C6TnxnMFJrSAqaSqLtWd4m9+cPujtHnF30pqr4UnRt56X49Zw2+RAELVFUECCJ77rhf8sj8o9Hw
	W5Ln6vbamAulnR8EDsMPBHaQXZ6kFu5L3NBzJ5cpyOfpXNpLKBdxATD/JMar4ELxDn1bz7kN9/4
	2RJamZ019Xw6gSGv1JTCrSCZ9sZWOEPsjCTcbAo66HyKkxxlBkCGndt/CbsZNviFPf5u7N2r7YK
	vbvy5RD9mBLoOi1nb2JSSdaV3sOV5TaqzikuVY7pnGXG02j2qE68AVe9GJaZzq/nb9pv4HnXFWL
	DV7JqHUMVtTZz1e8Rl75tI+hWohkfKez/SbtJz7hsUXo596wH1qpSwrzLc1vXAQR9CGrk6dUOFS
	/PzxBSHKvopX9dQ
X-Received: by 2002:a17:907:2d9f:b0:b9c:b3b5:bbf0 with SMTP id a640c23a62f3a-b9cb3b5bc8fmr892722766b.6.1775722416882;
        Thu, 09 Apr 2026 01:13:36 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f20sm709846066b.38.2026.04.09.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:13:36 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Apr 2026 10:13:32 +0200
Subject: [PATCH net 2/2] net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ipa-fixes-v1-2-a817c30678ac@fairphone.com>
References: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
In-Reply-To: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775722413; l=1045;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=zVpeYCI0Fp2z5aqjv7cM/PPua39ANpiE2GE9IcuZhfs=;
 b=CHEi445KZvoC0I15KF5hTJRWv53wWRXSGHOTpa7orG3qMHl0QrFrlARJUij2VbYkde8+d0wyF
 KqVSQMVHMVbCXXj8FH5xKxVlPcmaajmNdmK1qmTVgdje8Gkloqxakwv
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276884-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 030DF3C797B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Initially 'reg' and 'val' are assigned from HW_PARAM_2.

But since IPA v5.0+ takes EV_PER_EE from HW_PARAM_4 (instead of
NUM_EV_PER_EE from HW_PARAM_2), we not only need to re-assign 'reg' but
also read the register value of that register into 'val' so that
reg_decode() works on the correct value.

Fixes: f651334e1ef5 ("net: ipa: add HW_PARAM_4 GSI register")
Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=2
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/gsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 4c3227e77898..624649484d62 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -2044,6 +2044,7 @@ static int gsi_ring_setup(struct gsi *gsi)
 		count = reg_decode(reg, NUM_EV_PER_EE, val);
 	} else {
 		reg = gsi_reg(gsi, HW_PARAM_4);
+		val = ioread32(gsi->virt + reg_offset(reg));
 		count = reg_decode(reg, EV_PER_EE, val);
 	}
 	if (!count) {

-- 
2.53.0


