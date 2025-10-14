Return-Path: <netdev+bounces-229131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E5BD8649
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A111C406B69
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64322DFA2D;
	Tue, 14 Oct 2025 09:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AA2D47EB
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433596; cv=none; b=GlnQ7sX1c/u9Af7hIljAs/88mNY7W+hADbPBRt9BkKkixOONvQn5K9fJAFKVsrkazBjd3aS2jx1AeeRiNk2FmqzyUwhm27WYxKWYiT5YwNGCvG3DfQtunQu0AnsVhBr/uOaRlA0UnhHhfhLrjZsvoUcUjWLB10xXpAY98CjKzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433596; c=relaxed/simple;
	bh=VJgMPLn1l+slzARbgJQjau6sONTpo4VaJ2HYwxfoqcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uI0LojCyAmI8WJcKiTX/l6mqGNGs19/GTgXle2g+hYPbZDGqGELNxTc/wiSCujY7lNBZuuz6pheF4LoRuEJDCF3o3UYhZMDDAlShKaeHQasiiTkyAcfPpYmS8i4xpZ7/11L/QiBUpd0DpuxSWTVejX5gm9EnMWDHlqxRwfOKAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4736e043f9so803930766b.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433593; x=1761038393;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUWbRtnAFePUI1tMie+GrKRoLPPrc7Cc1NmHWueu9MU=;
        b=dfpUbpwife+89ecZGiYuxSfttI7WSJP2taDnQT8e6Q9v7mfm4w7K3ZkJAg1Nfvdf3C
         OXY3P+Ccwsts0QUeRtafm9iIwGVAS/OiGD3whU6jSMFIqlFdv6FYOXQPJ2cyTMzLJ3l4
         Pg+OqGD2otKEqmQY1qZPMAvoxvLpPJxkQrvRC1rtDzEId4pGfByDqTevBakM5GECBpiN
         IXBtXTVGr3YzJ8O8xFFzYLlU1NtRp7m1PejgEo2q8v8cRhuJOCfFPa1ACDI6OFAbU7KG
         721wHRrygpSohUim6oHDV8YqUQeCEY3vDgJm6/sVp+gXTgZsT3Gu/XkNrTJLRaqeAhOK
         XsTA==
X-Gm-Message-State: AOJu0YzDhEbhKmz1pk2KdsHMJniJ38o0RNPNtjJjHwe2PPa9QoCz+DQU
	7QMzm5dj5PSk0XeqZygw8QPgJQbORzyx49VWZIi/2NgMJEQ7YdgVWAMd
X-Gm-Gg: ASbGnctvCHFxwRfddS3voHwwGv79iP3B+eOaf8dKQ4TaXknk8W11O4/bxDnAzcmh9rW
	h66ZJ26vCa6+wVITSVnWrBHMGFooZmHgyNa1y7KqWKvwKftv9MV1mxGTYIsRE8kf2cdWNwucR0o
	2j8nFa2gMnbH1iSxrWUw0M5imRScED35gZeHx30f+rLeezIP+qjmHEaUK+t5ZBJ1j98JI0S9TUG
	i4fSCWM2eKUAHrQcwMLyZtONKc8i2QKvfjJ5oJF7XH83RFK0LsLISWXPpE0vo+66M/6NnNERw/a
	wuQjAM2Xp8N71HrUQW+01ebyr7x5ES0JqZ3XOVHK/C+WHE2qCDMEeesX9Io/R2Wb3/XpWIW/oWm
	OB3ITJiM+gS58UTIUyl1VUqgrYI2nFDT5xqGuYx4+WxdCog==
X-Google-Smtp-Source: AGHT+IFjohny4b8ONv2Wek8GZB2PYRw08z+IDcEkU2PBHzAFqFb2nqGo/sSeqK8BBkKa1jGRp3pB8Q==
X-Received: by 2002:a17:907:3f14:b0:b38:6689:b9f5 with SMTP id a640c23a62f3a-b50aa48dad9mr2709407866b.3.1760433592704;
        Tue, 14 Oct 2025 02:19:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61d04dfsm1118930066b.22.2025.10.14.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:19:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 14 Oct 2025 02:17:25 -0700
Subject: [PATCH net v2] netdevsim: set the carrier when the device goes up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-netdevsim_fix-v2-1-53b40590dae1@debian.org>
X-B4-Tracking: v=1; b=H4sIACUV7mgC/3XNQQqDMBRF0a2ENzYliY1VR91HkRKbH/2DxpJIs
 Ih7Lzjv+MK5OzIlpoxe7EhUOPMS0QtTCbxmFyeS7NELGGWsVrqWkVZPJfP7GXiTY+daZ1VzDW1
 AJfBJFHg7vQcirRgqgZnzuqTv+Sj6TH+4oqWWtb2NprHed17dPY3s4mVJE4bjOH4TUOGYsAAAA
 A==
X-Change-ID: 20251013-netdevsim_fix-b9a8a5064f8f
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=leitao@debian.org;
 h=from:subject:message-id; bh=VJgMPLn1l+slzARbgJQjau6sONTpo4VaJ2HYwxfoqcs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7hW3j+Ib/nYC8U/xj494rOJsEYPBywCIJFrS+
 CYsrtcb5OyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaO4VtwAKCRA1o5Of/Hh3
 bWSzEACsWRp0dx8Hba+M++EAUB/uUIZaaFAnYLaTeCSdrbCWdIKFSONIW+T3eqfEyEj2AYZ15MY
 K2Ebz1MWYoyywEl7MQEX/YnALn3cz/EeFeqTKwyZKuA6Spp/1Lgn3uGlagPiRL09sUT1b23EFLr
 rVizn3VYsK6NVgPDTjdebOGDBwOBQROZtDyC7aLIXu3xbvKzZ7b0Q6S4vyLhVcw7DXy2SHCTXVj
 rPKYZaTZxLC3Svjf2m4qubZat6Moyfllt44L6pX9EiYK/m1QmDjZcdzePfVYgHaKOFaDa9wb8WI
 6fsNryZyWRiPjcKEKdLuvs7ouVw1gtVO84tL3tye9H8gb6CDnKy3Yfeg7FXAQTIe6XEzh0FgvLa
 3laXsdZL1+2hRgUcOLx6P1YgrBAPlPhp71Xefwe+w0tzKOrPAi91qmp2yyislz+2jWj+wM1Fat8
 29ZQgGzqx94W56310sYDHknxUhviOoAHCF79Ef8f8hbu2y971DiYIDTMHivK7Dwov2G1l5a0di2
 Nm5rY1PnD4NzSWSR9SQ0jlQMrKXNwdv42rn1YXa7ZDyX8b6m3rRxX8HHzTvgUeln4/fghC5D8u5
 IdUJgWdQICOzwAVJTTFLZn+hANGi4vFiCFyg9+mOfjSZQ7jjB/weVIHS2Z2yyMHLuiz4TFs7WKt
 LY0xi2yiHuwZBEQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Bringing a linked netdevsim device down and then up causes communication
failure because both interfaces lack carrier. Basically a ifdown/ifup on
the interface make the link broken.

Commit 3762ec05a9fbda ("netdevsim: add NAPI support") added supported
for NAPI, calling netif_carrier_off() in nsim_stop(). This patch
re-enables the carrier symmetrically on nsim_open(), in case the device
is linked and the peer is up.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- Reword the commit message to reference the symmetry between
  nsim_open() and nsim_stop() in regarding to carrier. (Andrew Lunn)
- Link to v1: https://lore.kernel.org/r/20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org
---
 drivers/net/netdevsim/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index ebc3833e95b44..fa1d97885caaf 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -545,6 +545,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
 	int err;
 
 	netdev_assert_locked(dev);
@@ -555,6 +556,12 @@ static int nsim_open(struct net_device *dev)
 
 	nsim_enable_napi(ns);
 
+	peer = rtnl_dereference(ns->peer);
+	if (peer && netif_running(peer->netdev)) {
+		netif_carrier_on(dev);
+		netif_carrier_on(peer->netdev);
+	}
+
 	return 0;
 }
 

---
base-commit: 0b4b77eff5f8cd9be062783a1c1e198d46d0a753
change-id: 20251013-netdevsim_fix-b9a8a5064f8f

Best regards,
--  
Breno Leitao <leitao@debian.org>


