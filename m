Return-Path: <netdev+bounces-119178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B3954846
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6B283A1B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B01ABEB4;
	Fri, 16 Aug 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NTuTsYTH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACB198A2F
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809080; cv=none; b=ZTiSvD49sHYSIbeJRGm1QnOxcBc6u3JaaEjg5fgmtkfymE7b333DCYPBKPtMLmJ7LCD+rGxtwjzVzJ0NMFFz/AWd5CQONQ+xJajQZmUjx8xiuGifGBUvJUpxpq9t6GOHl9vui0xSTdL+F1gSqKp+RlgvZZlOsZydd6JfnBwqa0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809080; c=relaxed/simple;
	bh=JO93xhbgSaTuYjxi+Cl4YUEu7bGerZYLXHtYiTT/wYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovFnfh5WDQ1oOhkNjskD4edoVTEcK1f3rilQuDSvQyeKwUHepKJOFza5hVPBGLecbwysO5IR2K6A+NJ4HmGxww4OSDIX9B9PsZpdUkmkZ42xM9YxvF9xO0egPYeqPa3diurwOAaFSaS1hAFzVnOA1+0VFkT9l4UtTIQXTYfBTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NTuTsYTH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a80ea7084e9so105829766b.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809077; x=1724413877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O29xCPNUIaer8YJvgLSvXVeHF8sRBOh8qRqEGZYZ06I=;
        b=NTuTsYTHRg9zCGIA2ToaELGVVLBHy6uvR68Q01HXLaSQMU+AW0zf/IO7NdN+4fwean
         61PIu68LmSIHNPh2/ZzI/Lku5pFIEblsxrTBdEoWsBa/sOBSXvv4lU03/PdO4owRecjT
         yQWGTAmYTFY/P4kTwXXBLYBMlJ5w0KsFGHy97eCOtZx3/b2q2EkYQHGDtUHt76vCUwk3
         qzgK7Mh+KMFX1xZtVeY4KxGnBiHYdfCsB1Q7HwBo+1flYFFd5GU60/TrtyT2Iwk5PEJN
         eT7x4ZCbcLvNVRfACCwvplZTguM+Q1XDYVyBk8pvx0uE793ngMxuEDPduhSZEcLEbk6a
         bpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809077; x=1724413877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O29xCPNUIaer8YJvgLSvXVeHF8sRBOh8qRqEGZYZ06I=;
        b=jZg7Hq+Pwxf2tDSzLMerQpl88MI0S5AosNcDRiQr/oIehsSZyhE8qPP15+Wys5ajwO
         h8PnToTGy7pUrAMZtakFXbmYSHFPg2wHICxkzdWAdHEFZvm/fv0k5WiDc34K1NhrK77a
         smLmhpQZnLb+KV4rT3UUyT8BDLVhzgW2X3SyN2F9WJ5bPKdyMoH5XfBjJrm4MVUqWhad
         s0wQf6/wsAmqfgfZoMUypyy2QqIL67D6XrMZaycAGpGc5HPYDR+CgY2iJg91sseqS13N
         Pxz+bDPbwKK7CovFB+EZ31PW7wfFin32b0CQSSLZ8l4uCw81pVlxSKQ+7qgoPGoU7Uhv
         s73g==
X-Gm-Message-State: AOJu0Yy0mAg2CkUlERUoNSDVbdEF7esRogeq/HWZMBKpV/08vcC+Ldq5
	vXk527GFwaHLlwQIcdt9TNZkdq1joLFmduuHLRwGqlASupCKynQW9Zi8gp3DFWOCNDTVphI7ZdG
	m
X-Google-Smtp-Source: AGHT+IE6Q/nHSMjbkfeXvNXGMkTgqve2YDIQIW9PCdqFyozXNBnlvN/G9zRZv5WkXP9EYvo1R1zXEg==
X-Received: by 2002:a05:6402:50cb:b0:5a1:f9bc:7f13 with SMTP id 4fb4d7f45d1cf-5beca5ae7ccmr2228090a12.22.1723809076220;
        Fri, 16 Aug 2024 04:51:16 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2152845a12.39.2024.08.16.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:51:15 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jarod@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/4] bonding: fix bond_ipsec_offload_ok return type
Date: Fri, 16 Aug 2024 14:48:10 +0300
Message-ID: <20240816114813.326645-2-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
References: <20240816114813.326645-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the return type which should be bool.

Fixes: 955b785ec6b3 ("bonding: fix suspicious RCU usage in bond_ipsec_offload_ok()")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1cd92c12e782..85b5868deeea 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -599,34 +599,28 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	struct net_device *real_dev;
 	struct slave *curr_active;
 	struct bonding *bond;
-	int err;
+	bool ok = false;
 
 	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
 	curr_active = rcu_dereference(bond->curr_active_slave);
 	real_dev = curr_active->dev;
 
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		goto out;
-	}
 
-	if (!xs->xso.real_dev) {
-		err = false;
+	if (!xs->xso.real_dev)
 		goto out;
-	}
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
-	    netif_is_bond_master(real_dev)) {
-		err = false;
+	    netif_is_bond_master(real_dev))
 		goto out;
-	}
 
-	err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
+	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
 out:
 	rcu_read_unlock();
-	return err;
+	return ok;
 }
 
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
-- 
2.44.0


