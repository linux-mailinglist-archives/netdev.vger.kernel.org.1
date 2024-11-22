Return-Path: <netdev+bounces-146868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C979D65E0
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4780128293B
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D81A4F20;
	Fri, 22 Nov 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IrvIh9sw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970119C555
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315595; cv=none; b=TtkD2e75+BTeDNWj3UWvugHycsqL8UCAjfk0DJBHHWHqlQz+FVUmxMtDvW22RIwxUrP2HGw6QVI+P+Qa4c0AUCsKnBfr7xnAhu2G3KQYlwAxh72kmIpj+on6xeaq+2vp5usMkJBZybWPvoJlO6ieFJKZBj4fmahAeTlxmz16yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315595; c=relaxed/simple;
	bh=nCua10wF1ZXqxHXsRz26RyX+YXrfgDCsc9r73aRBxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc7eham54gY93gPk6xftgLEDpC96TgBVYTo0Fiuh+6JCQk5pxtuhYVf+7b8mynFTB//qibxypC5VPkPtKqJwVcPJEmmUkPIdveqmMF3w4TDZ8gXVFIcIMYl4Ar+LAOd3yfy99I7Ytj+r+TQx/QYyXdtPzXIhfsLwqTCwzU5y07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IrvIh9sw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c1ba306bso17739261cf.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315593; x=1732920393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33RedGfU2fSAWyojYapp2Fsg/JW26ZMcQC36AGNOBXE=;
        b=IrvIh9sw4TrKV7R6gXt/s+fvDf4cxifopdmvXWdlE6vhIaiOppqJK7VE1E4zq164j+
         ZbanfLd79fXxg/DvLkoL2k7T/d37ZmCaQmv7JxVkwqB2wtKuxJZ8BzEGDrbPBOWQNIwj
         a4PL9UTfJBh75u/2IN28DO49/9Cmcrv1FFOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315593; x=1732920393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33RedGfU2fSAWyojYapp2Fsg/JW26ZMcQC36AGNOBXE=;
        b=hRrS5J2UZgy9D2Q3jVuEDlhJA2I1lou0tYTawTQptMNR5VpyAdbJ0yjB6SO1S0LlN6
         AlHZIRn7oFa/0NHmDWx2VfBh3Sqp+0OTlr3+gVrGyBcoy1kkGDFn9vDoHKQv059KARi6
         iu9MOAa/wpk04MBLhj5owa3MkZvjR8QleB7/vChPKvQXhBb99fQ6URuhJyCzlQOBBu7I
         vdwxmUOAm8gTsqzx3kWDmjbpYPPuxYbnbV5hyYf3aJ1sQ68bAh1bkUZ7n4Qx+MCNJWH9
         DvoXmipHnkYjT6Q0as/d8AuRpUEGJ/bqh8Vacox0ob16UC8lGr9yp2hAoFfCEoahQYoT
         g0DQ==
X-Gm-Message-State: AOJu0YzLDSgt+RCB7oAMTVMGS+WjSoCpTpY5+rTGmEErBPxRgbZp7tUa
	ogDpOuJ8JH0sIkeMJy7O7IEY7682y2tOnMsxIYx5li+5LBmVz1NBFzBHDYXVog==
X-Gm-Gg: ASbGnctZat0TrBR1DODeqRab/H/U+xtHH+9oYWHLRXp31I3J/WssZ6LeB4OfBLsUePX
	UwJDwwNSyXkVHGKntSxZPopZhmUzdHONpCBJ9VNiOjVw6sbmvvbbWFe3TxN2ZScNlK33n30eZwb
	D4ujv3iWXlfJrYmcNysw77PQ/MDb03s1+6RIqlwSA/hAKODqajdct62byBhKIuhIx+1USwiRFkq
	6JwMqdsVDpdB3ZV4AXBo1U8vi1rujFYzQsbGlIHUw9B12Zdvdp1qEr6Sy4SdEcB0mil0H9JhQML
	ZxAyAU0y/ENJ6pCGg9QjD4kWyg==
X-Google-Smtp-Source: AGHT+IGgAXT6rkQ67a3+v5xcNTM6JlnY7lURzSKKxB7P+hqNlOJkddhaBL6EVYquDKzRZh9f9FsMaQ==
X-Received: by 2002:ac8:5fcc:0:b0:460:961e:9996 with SMTP id d75a77b69052e-4653d5222bbmr67313861cf.7.1732315593122;
        Fri, 22 Nov 2024 14:46:33 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:32 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/6] bnxt_en: Set backplane link modes correctly for ethtool
Date: Fri, 22 Nov 2024 14:45:42 -0800
Message-ID: <20241122224547.984808-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shravya KN <shravya.k-n@broadcom.com>

Use the return value from bnxt_get_media() to determine the port and
link modes.  bnxt_get_media() returns the proper BNXT_MEDIA_KR when
the PHY is backplane.  This will correct the ethtool settings for
backplane devices.

Fixes: 5d4e1bf60664 ("bnxt_en: extend media types to supported and autoneg modes")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2f4987ec7464..f1f6bb328a55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2837,19 +2837,24 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	}
 
 	base->port = PORT_NONE;
-	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
+	if (media == BNXT_MEDIA_TP) {
 		base->port = PORT_TP;
 		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
 				 lk_ksettings->link_modes.supported);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
 				 lk_ksettings->link_modes.advertising);
+	} else if (media == BNXT_MEDIA_KR) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT,
+				 lk_ksettings->link_modes.advertising);
 	} else {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
 				 lk_ksettings->link_modes.supported);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
 				 lk_ksettings->link_modes.advertising);
 
-		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
+		if (media == BNXT_MEDIA_CR)
 			base->port = PORT_DA;
 		else
 			base->port = PORT_FIBRE;
-- 
2.30.1


