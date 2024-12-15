Return-Path: <netdev+bounces-151998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5999F250C
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C2318859D8
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACF1B4150;
	Sun, 15 Dec 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RnmyhxMw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE81465A5;
	Sun, 15 Dec 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283851; cv=none; b=ITD6SHk2tBAlK5D6PMFrkIg7qjpeNeU13e+lhBDlTmkF3Z8Uzgia6g6ygdslTPo0vtXWNsJExAC6un6jZ0wD2LeYcjh+PaRXY4yOHJewOvMzEipHrZ8OsbJg5a7XrX/KyMgG8nLbaSMs2mtsoheQVf4QP4Y6eBO5eZIm29WyZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283851; c=relaxed/simple;
	bh=XvSZhCcMO+b5GYrnq5FHh4XipnZMgiopvTngRcyaNSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvbO1uadUIUL9MmecobE8w9yQMbNka+oIJKoeWO8WWNcIuBDdiYLMVgI3IxDHeQwzn4wT7kYNW3MWuC80xj+Nn2NaW/Zn4Ckg9a3gcxUMuYQGffCqeN37x2kRvNAR1aF2BFG/0ivilT73dU2DMiABMfzKSfrvsEuvaghsy6rrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RnmyhxMw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pq5GsMcfo4rfBFuKUoZeo1gFpeGJ1AOCYPKI7H6XpQI=; b=Rn
	myhxMwzSnLlwXLQtUOSmSog/6e6ID8k2vxFLj088y5+GzYQKS6t58XyYLXd3G3OhSe32WZSPfKg3h
	VOFU0AaDzjsuzvfQ/kbAaJQ3/HRpZLEuZufFfJzo22W6ASGuscwHIb45OUA9NDsFoE7aAK5XmZk7M
	cw29iEZqrE2BRCA=;
Received: from [94.14.176.234] (helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMsS3-000WHi-4N; Sun, 15 Dec 2024 18:30:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 15 Dec 2024 17:30:05 +0000
Subject: [PATCH 3/3] net: dsa: mv88e6xxx: Enable RMU on 6351 family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-3-87671db17a65@lunn.ch>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
In-Reply-To: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=XvSZhCcMO+b5GYrnq5FHh4XipnZMgiopvTngRcyaNSo=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnXxI9phcCRRuLiYllJ4YEMZM1vEHAZi+aJS4no
 tO+5knklT+JAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ18SPQAKCRDmvw3LpmlM
 hI3aD/9zAtdryswp48PAA0NV9GJumIa/On7kZD3bFs2DAIPN7cxSdly/qUkoEe0DezcKp3a2SAG
 ohekJekcxiWlCbLJ2GAXL/5OgYuWb7xO7Q9ZYatDJeCxJ3bJ8jnt7Y2NAGWJhzApoyaR++HVah3
 Nq4ff1q2dH9Wigu5DlntueHM4dbvodlmSvMnJdFpxVPL2Br3fLneWcLCdIzsq6Nr25jT9Jp3Jlt
 geb+zV1b9+FP+tV+ZjsvHREPhPWPbkWzbnvd2CD+RGNdXFgE0YUgQdG4H4TE58Yoe6mYDKasAO+
 UVf+ilkhJEPr0te/OeEzqrkOayZRhIdPnxRV1xs9Us0fqyojjF0RN3lvkAb0UytMAhCopfwlDLj
 I7/I4pP1LWx9dRaqyaURqLoAiR6M5ju8yMpNY7qJ3yWo5U4xzhpIEpE46Tsu82kwnK4eOO3WScG
 JZBimCOYGX3iIPFyZKuKBp9VxMFmu2j6Qgr5gtYPXEKrTZLJULrOs2fI8I3BAMl4NHlXWUnGixj
 3gv12jZ7lQzek1OUpgocxog41T0JzUr6JVK+CIb9JEm6ua8IUE507CnkKSLNTmt7ooOi3szhh08
 TMlr6mFVG3B/ehBOXIQ8gVCGwwxoyj1ceRKLPKUZrZQwcYipFPhIy5CK1x79vcUyOedWCrOP1+Q
 zVb0QItl8xNTDZA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The 6351 family of switches has the same RMU configuration as the 6352
family.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index fe471ff4cd8ea8bb6654c61d0b95bb66c2e12157..300a2acfdd941f30d5ae7cb16062ee269e04178a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4559,6 +4559,8 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.rmu_enable = mv88e6352_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
@@ -4663,6 +4665,8 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.rmu_enable = mv88e6352_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
@@ -5321,6 +5325,8 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.rmu_enable = mv88e6352_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
@@ -5367,6 +5373,8 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.rmu_enable = mv88e6352_g1_rmu_enable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,

-- 
2.45.2


