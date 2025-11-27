Return-Path: <netdev+bounces-242222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115BC8DBDE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC943A9610
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B458329E48;
	Thu, 27 Nov 2025 10:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E21329C5E
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239189; cv=none; b=D9RUlKbenlEDmm4get0WJLjn0GLuopQE0iiMCmzpocIeg6AjM0HYq1mRfXXq6Ht9BooZJpdwi+DHBUyqeT+Io4TqRTcBZFc0q383djn68pQbnY95eRPtR0KcOA/AnoIje56AeepAn2u39dpiRR8lxHNMi6Y0m2ftJmRQgVgbEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239189; c=relaxed/simple;
	bh=zsb1EsoAfuFHllYEOv9MbWHY4PxMMzX189jENZoo9wo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oh1bY5+mxIcAaMfvMqfcTQyE0+UQzWFXU1k991GrZdfe5Lcz3on1UrGjcalwY1KOKBe5PMJToiLDr6i0GbvxaWJKhIrwoOXIxrOCnU9bH7sA2Wob/eyF36ka6KJFFi//A3m6wWGW2bXUIsjLK0u+H88kLHM8nrxsDRTu8ZC3kk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656b4881f55so238587eaf.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239187; x=1764843987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Xzulo6dH7OvqzutGx06W/AtjXvaorUsagh+ZNHAd0=;
        b=AwLeOdNs2ewlMRoOm2AIGSFb+EjPHCnvLqrk6f3JrXyceKidlsBkfPHezZ+ae3KvgI
         HFX2MT5O0QwezyR+3euRx/g/0MCiLVV7H6ldk5Sa/gyYMaEA4uoxJDqznBBm8rRF+yVu
         CybMrqbC7Lcp8FYAUPt2sJ8/vcg9QW9GAjCBgFwp7ojhrqnl5/W4WIZpQ8xG0Vv039DF
         Qj4mAjXZF7Zi8BC38htH+i9cPhTCOFIv66MXpCBRCC6oifQL1x63YQ2dPvPYd9NDFBId
         dl5LNwbUoBCFk5huCccNIJSm83BOdZCPkA6KIpcoOvuzq7QeNIGmkf+fH3CJ1xcyTVDV
         JPJw==
X-Gm-Message-State: AOJu0YyjmstjQZCH99dBOloRPFGn7ECYHshDiK/tP8EaHGx31YYtppRH
	quYNMjETfz01ANk49ETBKZc5Jrl8i8Ic30P7WAJNxIljiOBHPISdfXQNLaVNVQ==
X-Gm-Gg: ASbGncsPTwxYF6fStbdxpkXj1JysJclfYYnXSjaMYINWB8FwagcucM6NiN3b/YoIbTo
	u8o+grwzTEetCpP314RU18skV4SQIZpE/JdLS1KSvXPOx4h8JvCnaTALhMSJS2b4VsHK79rYUpU
	m8Q1C7g+lrtzdV/SH67ti5xvtlCqb9UqJRI7I8RT/yaK+YBfkARnBi+1dqnufXaUwIZO76FXUkI
	QFkoMIHBk8Ug/BVRxLcc0E62Fu94uXvaU/6B5OAjJ59gMLzxMwWk+qMHVsGH/Bz4eOIcKvp0PWU
	Tu1/StdTCtra/YR7wjzGSIe72PlURxp/uvKZxRapHgqarZXB2kwU5W1lTTH0utNN3YvC0jNy3oP
	sUBn0hoozgcOFL2ICB/5LqskYoOdrum4iU/h32UVOTrNFoJbfjcarYOV4NAis8SaTSsbf9IZe42
	2SuRVgP1YI3OyhLQ==
X-Google-Smtp-Source: AGHT+IHIOuE9AxY+AVHlyfnT5qmy1sU8yYhdycKb7L6zytGWWry/1iTzmCJfU4LKQMzWFy+SpoAIZw==
X-Received: by 2002:a05:6820:811b:b0:654:f6f1:dd07 with SMTP id 006d021491bc7-657bdb68d36mr3447956eaf.4.1764239186899;
        Thu, 27 Nov 2025 02:26:26 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-659332d2fd5sm204566eaf.4.2025.11.27.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:26:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: broadcom: migrate to
 .get_rx_ring_count() ethtool callback
Date: Thu, 27 Nov 2025 02:17:14 -0800
Message-Id: <20251127-grxrings_broadcom-v1-0-b0b182864950@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAColKGkC/x3MQQrCMBAF0KsMf92AGWiruYqIxHQaZ2EikyKB0
 rsLfQd4O5qYSkOgHSY/bVoLAvmBkN6xZHG6IBD4wqP3PLts3bTk9nxZjUuqH+fjlW/TyDxPCQP
 ha7JqP887imyuSN/wOI4/zqp0pm0AAAA=
X-Change-ID: 20251127-grxrings_broadcom-1a829652276c
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=leitao@debian.org;
 h=from:subject:message-id; bh=zsb1EsoAfuFHllYEOv9MbWHY4PxMMzX189jENZoo9wo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKCdRRhOrsf8xL/u/Dk9atYNS9/CaykfmQ2nzG
 TXRsl7UrneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSgnUQAKCRA1o5Of/Hh3
 bWS2D/9iJAviP44HHroqrE2dRjLp488BYs48nITG7V6eKmBeMUwOBbFFCmlLueXRIP0/Lry3ppr
 ZnguMLSLx4JsE8bu6z33mSWMvcgwBynkdRRMF9mUGOMgLPMq58eUGAUtR2XfKdiWAm8QcHbjXzB
 DseC5y6x6lVvM+8DQOK+T/Bn1YcQLqjZqT1j0F7Gz3qxvTGr0c0JpL4rzpqGNCUY+Gqx6rS2v9D
 6kF8Gvv1nxFPX7rLILiLVGxOZPgqqlAl/GtxssFA0R70tJHEo4W3aSv2Vq8AuraLk03E5IL26go
 5w1caOwbVD/aj33ZJi/xGrbmtHBLXTvUwAnoIWqSeqSFx/7rS+R87s0fPnrGGMgqobZY2jAV6qa
 hplVcmwioWoRhZ0biadas6t+neexLrqek1GxokrEtkci2uo4VZ1u17oQgZFHJ5Ff9Qvxvhc5OQ7
 tOKooPyFS8vr4JGm1idXAIvTQnYDr+0vDABKTc2yDdjWwjXdsBguMEf/I/PEGmWi3aCSm3ErCaQ
 DTxhRg/od8kClIqarxMTrD3mOLt23JUMVdghHUES4iINhjHqSY3wkM0A0XYTor8zhtUh8jkVt4J
 /uwRaae8ikxvEN9dBqGi1cLad3REWXSxm8zTnaWg11sLE1Sy1+9/LN2uULO+2+BYX54Ew6hiUld
 JqOuM17vA/hYHzQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates Broadcom ethernet drivers to use the new
.get_rx_ring_count() ethtool callback introduced in commit 84eaf4359c36
("net: ethtool: add get_rx_ring_count callback to optimize RX ring
queries").

This change simplifies the .get_rxnfc() implementation by
extracting the ETHTOOL_GRXRINGS case handling into a dedicated callback,
making the code cleaner and aligning these drivers with the updated
ethtool API.

The series covers two Broadcom drivers: bnxt and bcmgenet. Each patch
removes the ETHTOOL_GRXRINGS case from the driver's .get_rxnfc() switch
statement and implements the new .get_rx_ring_count() callback that
returns the number of RX rings.

---
Breno Leitao (2):
      net: bnxt: extract GRXRINGS from .get_rxnfc
      net: bcmgenet: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ++++++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)
---
base-commit: f93505f35745637b6d94efe8effa97ef26819784
change-id: 20251127-grxrings_broadcom-1a829652276c

Best regards,
--  
Breno Leitao <leitao@debian.org>


