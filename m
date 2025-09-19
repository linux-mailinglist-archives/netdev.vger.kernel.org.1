Return-Path: <netdev+bounces-224710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA64B88A2C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB800189FB6D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAF33081C6;
	Fri, 19 Sep 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFm2hgFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A463081AF
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275093; cv=none; b=XqWird2Q0xjxC+4zvcmRV+HWfW81U/TBiSC14fWwD+8zXQQtReKwDejGpPTgGFMeizv/tvt4il6N0cOO3HXMaMSij4XNMkm8Qe04aBf0e+5uuGqfvkxdNFxp5E1nOnqTQinOOzkdKSWNyabjMgFiw8zVtkfurJSYfW79mmnI/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275093; c=relaxed/simple;
	bh=gWUcbqWzXS4ELq3evqPkerHD9lX2KLiWU0+/a9cMlCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smFetM8E73/u3EZ+pEtbGgglR6ekdA0VTs/Y5etpyYK8ivFD2cdfKS5bg80tPH2QhI8ul0taudr8IwX6UZKE01VJcVPtKeEsTHWbv5Yw6xATRQlVUN3vn8tJcnDkna7eQOKRgEJ7KSVakvo691450plzBVcE347gT2cJaaSzOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFm2hgFW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1228718a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275091; x=1758879891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uXchjrYgw2P6t2wdy84RUZzxd4YvHrjFTdhMIXbqmA=;
        b=PFm2hgFWyaqsaiymaUuPyPL9zwIExW+ZYIZE9RD/wzRlwyTdHr1KXJc4Q+oZ39LhKo
         SZqowZGdFkYmS3dQ5vznKyUtz+1ONbC3hwoVZCqQkpPb1k9va2tsSk1x0uDyDIe8KGP0
         VvxdQXjt/YE2mmXQxjxAlg1/mcOB3pH5jLo1SQx6X4iLDIXloBMtTEztuv4migwO4VHb
         5cwhiuDVtDl5Xvts6yhzoxlXY2QnNsiiAcAakpM/7BBfzD/FBRLxkRyYYsNv8akTbo1j
         TA+rkKgQWdcuEP2WE8W2luzRRam751DVXGGb3pETuSBIiud/skzouAibjwf+K9dLiQTP
         e17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275091; x=1758879891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uXchjrYgw2P6t2wdy84RUZzxd4YvHrjFTdhMIXbqmA=;
        b=GBSnwTkXaR52fsgPbsVmUkticG/FHXY6JID49aS916DaN8qoCKlf3FOQLAWgYOIcNg
         hd8T0iFwFwB+d+Zp4EuLHBevmf5BBPyhfaLRyayil1vcHlBj5c2/0tM0cR/nllzfSTIM
         833mZBy0ier3iHzE0gAIcsTfPqWA6YzCB6/BP/vZ+K996MOT1Ff28rH6pnPKCGuUpidt
         AkcO/laIho17egviiLhc1UZtXiLVswF7UjpQvlSZlA0opoW8McPsxFhkctenK02TMs6p
         +p+1Qri/p5BUkRPKBRLHs4ncuRrz04QteuQG0UKxjapvYAcNDqHh4scT24aNAOiUp04s
         QOWA==
X-Gm-Message-State: AOJu0YwfhqTDisEJAwX5HNk/IfjdoTLrsH25s3xq0FgTPfPp7apg3QgU
	mkfROb5BuLy+il64eK0x30OaZkY55VfXFIBw48N3hdj/46okypGyuAA5CFG7hGtXRns=
X-Gm-Gg: ASbGncsF8f1btGPo8BwdrQ9ftWXs1r5KJISgNuO9bYs4QsU73FxfmRq6nOxXxtQPIxr
	J6xjZ3FjATNUJIjsSSlm1ajJKTgcC22HciuNlb4G89CeBnz6/leH9Aypiu8ZxHeRLCMZqV99RLt
	4rK4PtfLjjKek5pMuK/eaF+JmFuFyCLpZGsFq2jiRy6eamh8kAEDe0VfLmfjrDscpPzYItgkGb6
	Unrj7BiGa/5d4Sd62GJcZzfDaLKUuLNeG50vIwfTm2Vw3dP6Jm3GTnEk1xqC/XdzgCQptCKFwtT
	9NjQ1aFAzwtFKRvyIgQkjpzPErVhREENZ6VxirsXMwVqVF7xDvqUg3RwaZ97N8P3i8Sm5Hge6Cu
	pgTVr34iJNvK5a45FSPapJmxs8cgpRg==
X-Google-Smtp-Source: AGHT+IEvIwPdCC2Ox9DysgUBn9JHQSkN1p8vO88sNNPeIZnOafK65JQCeAHhnp9WRFeHNeib8fAUew==
X-Received: by 2002:a17:90b:5109:b0:32e:96b1:fb80 with SMTP id 98e67ed59e1d1-33097fe9687mr3253247a91.11.1758275091472;
        Fri, 19 Sep 2025 02:44:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3304a1d22cfsm6221873a91.7.2025.09.19.02.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:44:51 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
Date: Fri, 19 Sep 2025 17:42:27 +0800
Message-ID: <20250919094234.1491638-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919094234.1491638-1-mmyangfl@gmail.com>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/phy.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7da9e19471c9..42d5c1f4d8ad 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -107,6 +107,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
  * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
+ * @PHY_INTERFACE_MODE_REVSGMII: Serial gigabit media-independent interface in PHY role
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -152,6 +153,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_100GBASEP,
 	PHY_INTERFACE_MODE_MIILITE,
+	PHY_INTERFACE_MODE_REVSGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -281,6 +283,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "100gbase-p";
 	case PHY_INTERFACE_MODE_MIILITE:
 		return "mii-lite";
+	case PHY_INTERFACE_MODE_REVSGMII:
+		return "rev-sgmii";
 	default:
 		return "unknown";
 	}
-- 
2.51.0


