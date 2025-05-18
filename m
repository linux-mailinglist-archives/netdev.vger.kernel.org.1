Return-Path: <netdev+bounces-191344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C504ABB055
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2467C1898EB6
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50520B1E8;
	Sun, 18 May 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE6S21vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B351ACED1
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574308; cv=none; b=cK0dF9w5FFIKm0p4O/4gUfyLEMkLfGMd9vNhk1pKAUHv5qZ9jepkUMfwQ0sRv2DxCWtAex7A8rC47A/vbp72e4cWytbi9F3NIB3oQYtjz/l3nJV2+C7vau87XXZ85ssMGMKvwdEJ63LBTISBTO3/GWW1jEOFmwohOUEWRCN97MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574308; c=relaxed/simple;
	bh=mLnIgSMci8d7RYWw+EKv1gn1uvSyCTPOFnCkKGlS8uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=buq9sDTfLSjmzKQJS/okdusKS8MCKAUmY4eMPqMZh7mDaqEQdbNrp4PCHfHrBIggqVPgt6nHEd3mBAHxmKhRDzzQqZj6r67yA++ooc0I2nDvSY6PRacDOMf4owprVD3O54S0CfhOG2wO1wV0L0ny3tizQLgEaqY9bC6ZhdWpv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE6S21vx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-551f0072119so254344e87.0
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747574305; x=1748179105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXQRWDAwcCAL71MJ1uafRPVOWa4LIaU6jL80DH7q7WM=;
        b=TE6S21vxaDFLNN0aqEmbgEJeX0WqRZetHDwvpUl4ZjAQE9R7UNmWyKYhlFDUtW0Pfl
         BhEYU4V1VZMzQtdb2N7Y29dq4eEqdL9g48n5265PrJ6PXaJqK2R5L6jj0hHsOvZhVCJs
         ujXd+1YbjB9HHl3MMtr0BO4pTT8vWmKpQDBQblQpY0e2lhTPjnX1HfMd6hE/oiguHhbj
         nQx2t1QPq6PawUJtWTt3mrlBEy3NJdhFhufkRag0ZKK549U71bHX4KLbvfCf94oFUQ0h
         vxjx/rxCEk7acGMUaYb3AjFlRnVK9RaVscu0H0gku2j68kETEYRP/yFzFrfutBQavwLJ
         OpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747574305; x=1748179105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXQRWDAwcCAL71MJ1uafRPVOWa4LIaU6jL80DH7q7WM=;
        b=QRJluWryTelPAxLcY4DoLoBl8UW6SXqQVwyLzXC/ozPB19LoE4mH448jaD9+tOn3HR
         HJXlnfC6y6X141GrEBlpMTZbRfyiHJWt6TXeZUi6ToAtUukcEUnzNRz+iE6guhygz4Sm
         nLqPts8EXU1bkaPFoIaIFarfLzS4q3G5OaCMiwcrQIT/KEg3Ba8MWxkcyZ4Oo7ffAY12
         nhyivVPhWb1Er4cMIFnVIh0aw+A1gZx2xMgrCmapxczLixuyh/JLRVgiiDD2WCeiMk20
         1YCl/+KPoXCIW0pV7C5YeAj/mrEH6VuDUPa7KsIqVAqKNVcmcrXTJ7/eAqmP3DIxBfYr
         Ba1A==
X-Gm-Message-State: AOJu0Yz4h+f11iARtDgiQ7Q2mJOjnRgrhUfbqTpsBWWmLSxVpJmBGHwt
	cxZfrRymwfO2mj2k8LRwV4Ui4uLINNtQQRZtOpH/341s35JJBPOrtEzE
X-Gm-Gg: ASbGncts16G/I6tU8kfUvZuCthxNxMWLNJoRKxs6PSIkpc3Q4nVG1VVYdJsCYiS+r7i
	VCIlIPLnVcUFAcNfmbspVt/Yd7HMNh6IEw0RFbC0W3XFR6ylbExuSkVtPvmIgnITowQuZQa6bMQ
	TdmnD66cQ8SnsNxhrI30b3oCy4wlLuQvWeE1azCwLKDSD/mPdDxnmKR0Fw9VKOkE3dHRunEyCWB
	3+zaDw4Ak+ueitnbijleYuWkGji7V/4L/7HVZ/7mGc/JShe1DfKpBsmxMDexiXNCEDLi6l7up6H
	QqRDi1RoxzHppcTDFNaiqbJRdjFg5TlLJT9gc+dVmsX/lMho/lGR0b4OsSeWOimnGntfYHb+43I
	FpA/OSzidEuPJmET8g0G0M5Mk9r3R
X-Google-Smtp-Source: AGHT+IHwHbSJigqAMM/g2XxCGIWvpnY+3ABo2/5+UmGb7EOr1szVDCmJutXB5u1cR/JcgK3DeBO1rw==
X-Received: by 2002:a05:6512:3d87:b0:550:ee70:2074 with SMTP id 2adb3069b0e04-550ee702311mr2126435e87.4.1747574304783;
        Sun, 18 May 2025 06:18:24 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703c328sm1419163e87.211.2025.05.18.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 06:18:24 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] fec: fix possible NULL dereference in fec_mode_walk()
Date: Sun, 18 May 2025 16:18:18 +0300
Message-Id: <20250518131818.972039-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer (Svace) reported a possible null pointer dereference
in fec_mode_walk(), where the 'name' pointer is passed to print_string()
without checking for NULL.

Although some callers check the return value of get_string(), others
(e.g., walk_bitset()) do not. This patch adds an early NULL check
to avoid dereferencing a null pointer.

This resolves:
DEREF_OF_NULL.EX.COND: json_print.c:142 via fec.c

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 netlink/fec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/netlink/fec.c b/netlink/fec.c
index 6027dc0..ed100d7 100644
--- a/netlink/fec.c
+++ b/netlink/fec.c
@@ -27,6 +27,8 @@ fec_mode_walk(unsigned int idx, const char *name, bool val, void *data)
 
 	if (!val)
 		return;
+	if (!name)
+		return;
 	if (empty)
 		*empty = false;
 
-- 
2.34.1


