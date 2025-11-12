Return-Path: <netdev+bounces-237832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9089C50AA6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB343189AD37
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558144C63;
	Wed, 12 Nov 2025 06:01:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2E41A8F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927279; cv=none; b=mgo9I5ttPgLt7LZzktUVFUGqRBGp7FiuzrgI9pKua2xSBiBig0E2tAlaib9HpslAhjzStKjNdE9pUgP1qhwu1py3fPW3Teo1kniwyUY8yeXsdfbopVF6qlHVPVcokT3kUuqJKS/7BaTLzovVyj4UOMUKlbuHqQDR8G6uV+bF5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927279; c=relaxed/simple;
	bh=u6efNNU9aanxSp0eaoO/ntgz+VNnKx7pm5GlPDZ6o/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jf6toM1Y5B+aUjWpuQWtHdvan6ZIlJmtv90DL2/t8Yo0AW12etQt3as8/UV4ljPaCdEJp/9AF0vhbYylSNrjYxr3CeQ9XNS3U2N68aN/rwHDxdwTIhPcfWj0nJbkImBUMLyPDLhzxmvOB4OL+YCa92Puh69YfvxMc4v0FA8CkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1762927139ta5f732c3
X-QQ-Originating-IP: 2HvwFJgJjkFeFKmZjRJ6QlUgADYZtdLzWt2Lxs9Rh+8=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.224.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Nov 2025 13:58:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13364907905896120963
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 4/5] net: txgbe: delay to identify modules in .ndo_open
Date: Wed, 12 Nov 2025 13:58:40 +0800
Message-Id: <20251112055841.22984-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251112055841.22984-1-jiawenwu@trustnetic.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NRYSeI3Ux+UPCodlLyzyeyFB4NLZAhX8jGPZ5l9eQsFcakPVB7wzNCW/
	BL2SsOCT2B5+4hdoGB04kcv/320rNYKFBDXYl06/LmnLy1u27CD+6D+0oRj8RIbuhnOSHow
	vzn67u0jorHA6MY953WxmsK0jJxOdwvQ3fvwPIo1AISP9BnI4NYAr+Xs3FvRU31QiUwz3YX
	0mBwe/kj7Kil++PwFhmwSox5mHyCEoIFbIT+VqPwjwQGaA+I4HbQDq7vFVv1UsS5JI/f5mq
	PlEd2ZXaIXsyijveVno7uKIJT5Nzz03txOSfZNMxfhLVfdTmf7rT/50efBf2U6dIg4VT0Ia
	NSeoZ0zOshgktzRAH0Ts65U150otuR09AJXHDLmDTxKPLiqFJ3gvf4aoxTZ4podspFV0yAt
	LHXbByH9nIihlyYBoibDa3DzhPjZ8RVYQhBKBmh74vUKJcJWOaM2XkaARLCqFxaPeumFN84
	9Zg2OpKWYytbYlxyAwvpBynPrIJrHXo9C6sAqMfvp2/PNemu0iUbkz9h6m7ArDB/j5tyHmR
	sHLoF3FU1wfSFfrsoGHmLik5WIs0oogEkTxsjhoH5Fn1lPlc/CVn76aNMcF6MBZO6nqrdKN
	ooKYn1/IP6GTfe0nn9EWeToDlA5nO1RlHj4P/v188d+GEISzFcp/Zb0/UFdbwQDaA23WfJN
	xvcQg73Z+8WGkj0AdOEKn+TBGJkoR33NIu1VQrpB063rPhyJJU5p1lFMi9NJMxk7FLoQM4/
	9XnTjBPbQXhpGMQw+w0DeENSvsyyfiBLWnq431itfUJIQFYm9fZXZ98eDKqvhkoVGvtiMU8
	RjuGwv9fX+vpoADGRQYiNIX26f8GJN16cOWc31wQRMPB/tD1LBmMg3p6ueojn4Bbg2yjFuT
	RPYZEBXsnDWCkB9pEW0goMsIXO3Zl3SZ6Z9wJRs2/rOZqDiiNpEUqPoQ7IW9lXQ17HHv7B5
	xQKAdepfN9p7ApSmMUlHdW+CnbNuoZhzX7s8wUGOS3bb2NY+28reu7tEPCuw44PBFuUExyu
	OPcbseNCOn0F8xcrvG8Ljca1tyFDRhOxv2WXbVRFiBuKe+kCMYlzoFJHlz2vs47I4lU9SxQ
	Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

For QSFP modules, there is a possibility that the module cannot be
identified when read I2C immediately in .ndo_open. So just set the flag
WX_FLAG_NEED_MODULE_RESET and do it in the subtask, which always wait
200 ms to identify the module. And this change has no impact on the
original adaptation.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 5725e9557669..3b6ea456fbf7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -345,7 +345,8 @@ void txgbe_setup_link(struct wx *wx)
 	phy_interface_zero(txgbe->link_interfaces);
 	linkmode_zero(txgbe->link_support);
 
-	txgbe_identify_module(wx);
+	set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
+	wx_service_event_schedule(wx);
 }
 
 static void txgbe_get_link_state(struct phylink_config *config,
-- 
2.48.1


