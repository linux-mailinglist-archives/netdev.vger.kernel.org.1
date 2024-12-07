Return-Path: <netdev+bounces-149922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79D9E8233
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90A9281BA0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9655C15442A;
	Sat,  7 Dec 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kwOMFSzv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D21F602;
	Sat,  7 Dec 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606353; cv=none; b=i7AGmJQtjGF8VCl7/gTHTgo6+gVBzar26y4iaOuh/ZLp1g3/pAfD46mD2Tyr6UEIlPew7epcLuKW/YiN1GZw5KD/V8UQoBJ/Nrnim/b2HCmUZVfxcTbxq7/eC3YgxqJaGOv2TiTh0Yg8xehc9Qe6ik04oYizckKPovnz8BH43Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606353; c=relaxed/simple;
	bh=NedThzF3R/DnBOZe2/t3C2mwOwMI6DS1cmuWzpWb8yk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MF8ynqPlcdLBV1usk8RZCW/Qi/Z9C7fAp1QXo0IYorZXZ5j84ZHT7ZwS+dfpzh3mrUInu/hzWXjQukpDL81D6bsIiKqNeese47Bgj5ZUZy1+oS9F2WOCyqCI5XxCLIMsmTiJS7zxM8pVnsjzc8yPLt4seMUf3jpYXNco9Zw5BKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kwOMFSzv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CSpTw1WsMcL4wL9s+yWHcnrb8i7Nz6p+hxmJQSUiZjY=; b=kwOMFSzvNoW65z052Ihfa0J+ln
	EVb+PI2sNVyVd1f94T2qHIbQVgdjsgpANkez++9vBLVVacrTnaHe4qvw5O+ZSk7UAqCZ79MEX2YiL
	3qKwM24gBG2HN1ekFRPLM6Cn/EABFcAIiED9a9Hozz4Ml/ib5g521guSA4Hxyn2IGI1E=;
Received: from c-68-46-73-62.hsd1.mn.comcast.net ([68.46.73.62] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK2CV-00FVTF-Ln; Sat, 07 Dec 2024 22:19:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/2] dsa: mv88e6xxx: Refactor statistics ready for RMU
 support
Date: Sat, 07 Dec 2024 15:18:43 -0600
Message-Id: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALO7VGcC/x2NQQrDMAwEvxJ0riB2g2P6ldKDaiutDnWKZIwh5
 O81PcxhGNg9wFiFDW7TAcpNTPYyxF0mSG8qL0bJw8HPfnF+XrEFdFfU5LBwHfSKnxYjh947WqV
 qqLxRqrtipDVRTjn78ISx+B1F+v/t/jjPH7/dRd19AAAA
X-Change-ID: 20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-8a7cadcdd26b
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=NedThzF3R/DnBOZe2/t3C2mwOwMI6DS1cmuWzpWb8yk=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnVLvG1UEVAkfAvPcAT/eWnRt1AGQsaG+QJ9/zJ
 Ii+TPql2gGJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ1S7xgAKCRDmvw3LpmlM
 hKiaEADUycl2Vx9eanJwyEsaw1jQI7LvzC7eHxm0SnhZn7+TyfQLZy8wmpVbnvD08sHlX4t/5CH
 L8tE36beIOK+FrwmDXVNzJsi7aND288gWz6pTNCb6VVbbebakZTVRNbAUdNCND3+83RPCEACTLR
 kk89jlcbFcEs17dOxmZQq9jqf4wJTWSLFi7pJv3hH2tNwHUJnj5FV8tQAWAbl9kf5RxPL9OfSfX
 YQKDn9OiWFq4T4kbflGRcBmHTZYnaf93iag5S8qAZZYepDSwSD2xo/gt+qdz9VJApx9ku29YCsr
 vzvajFhCm2wGszV4KHZZ2j2hY5cg8lOoo6gfTuA5Juy2tA2eeWRlcOS2aEOU21U7qRiZkW5bowr
 Fd8aujw1bFRPJ4hQHvSgcLFvOVMtF8eEF2vQar1Mjw/25Aw3gr+tkxQqyQQV9lPMQItts4euUAC
 MiuBJB+SFPiebOZWmfb/UagPnwQ0cCiwKQv1y9efSRh2irNy6+Q30QLL4+1hgukgQwnUhL0k+JE
 Tv7M6D5KUX0wmqM050mZ7E2TvBwMwow5COu1tknG7UB0O6CM9mBc7LMSJh3ePYD/RGJVRbilSO0
 +KvQ7QdS6XPLBlsgr/YovlF+1ElTGe8RFnxUjN9p2NQB+veXPg1jhS7lPFu+eZgkrB26LxTv720
 hUGzwu61Ofs4jIg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Marvell Ethernet switches support sending commands to the switch
inside Ethernet frames, which the Remote Management Unit, RMU,
handles. One such command retries all the RMON statistics. The
switches however have other statistics which cannot be retried by this
bulk method, so need to be gathered individually.

This patch series refactors the existing statistics code into a
structure that will allow RMU integration in a future patchset.

There should be no functional change as a result of this refactoring.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Andrew Lunn (2):
      dsa: mv88e6xxx: Move available stats into info structure
      dsa: mv88e6xxx: Centralise common statistics check

 drivers/net/dsa/mv88e6xxx/chip.c | 49 ++++++++++++++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 2 files changed, 38 insertions(+), 12 deletions(-)
---
base-commit: 860dbab69ad8d07a91117ed9c9eb5fb64adf7e0e
change-id: 20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-8a7cadcdd26b

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


