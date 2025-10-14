Return-Path: <netdev+bounces-229050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CCBD78D1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E32C4E2C19
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8D155CB3;
	Tue, 14 Oct 2025 06:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC7256D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422743; cv=none; b=SNr+3czsR/KY4oBxNZQHS7XXfSOvomnuZDc2GP0VHS2sPC4IzNlCFrSj7hf7setU7v0slyUdu8DA6Ol+rzX9x9YNaaif5jLUrFf7mroNTIaxUlOHVLXeB0ERO17So7vKDkRnZwnEGtj2NNQlyuhDxn8OQCnYXJqrU8T8qJXGAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422743; c=relaxed/simple;
	bh=7Kf9ZvAycRhTL1CqAA14NKEo5Exe8sTW1+WxD8NkPjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnzmV1O3S7LnJzhnn25qKvg8CNGdaBstUnvXAJjRxjKdE4oWysUzXRXTOV74xfTDWpgNmZEARi93VZzdx0NSfGt4O0UVqDmGLFV2rJTg08RGnqY0BO9vSp74xUwc8Zx+MH4hpD+6b0BBPh7L9uly7UsDpjhT+RbA4LL4yj7Hl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1760422655t49ccc1a4
X-QQ-Originating-IP: RTxrthsil0aJzArw8c4wFuML3qFvSiKfjF/coGdxASk=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.111.193])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 14:17:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8812132578749970895
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/3] net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
Date: Tue, 14 Oct 2025 14:17:24 +0800
Message-Id: <20251014061726.36660-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251014061726.36660-1-jiawenwu@trustnetic.com>
References: <20251014061726.36660-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/EN6P+BmEaf/8NNAZVY+Fufyzk+Y2KQmjCmbDzIHO2hrv178JElKf0H
	BnTb5QnhIOr5xqcXz4Zx+D0inxWmxLb1XfY3f3ETrXX4DrW5Ji9CsRtdOB8lAOEj5zWteZP
	kTq07poogVwetw5HJaCjf8MhR9HEmuhJALV8o6eVUMODFW6Z7x/B7xideHmavsElOB3/Rh/
	HUj5gWp2f6gNHfXmHJlO7SjKwmkCfmGlUSelsefgKvnTZfWdA3MsjXY6DM169CaFVgC/AVB
	afwzLM4ZdxYz7t4IWBlED1Wtmn33zBGv7qAEJpqdkwfKcFmFCd8FxBD8sZeoxzhNC2BDPLJ
	lRUhQZwVLttgbhS/qcCgUi+2463Wk/er3WG6zVTUDFjbgzNv2UDccMIoZE/nhSBqbNqjfBy
	3G9ktlfR6vaXMWCUe44UrV4Ct/0vAp03jMg9spvLcmLhU0rK/AhwfSXfreaP5vVfYFI0l9m
	Xpn0dYzQbY4z9BJfG6lAPYp11WuFoJel4tQRhV+ypP6qbhlicWhwvWLN8ewWiF9H2T7Xk8k
	akIu26Eg71HQmcEKiOhtT4U878OeL6wp5vYtxo9VLh5Bo+nAXu6v+WBjWXso2BHr9jBHIhs
	kFOx36ts43QMLQQR5BWd17nU88eZ3mBKUYBmBY8ZXAPTNXnLiF/uR1WRrFvGLJ5mYCQfejT
	tUgS8Z03UHU9BBymBNT346FZPuSAE726mtGsa/MPvkEXgXqAUVp1WWZ+m1K62GcGM8XC/fm
	U+InbRTEI+Dd7Lxo4B8cAVuJNKE8NUgmVG1AucW67Po74TTQ+LiYzvYCs77OwCvYnnJubJG
	bSvzzf+C4NWHi+HPpinJAwd7pwkPQjyULXr4S5tnTAZ0haB02NWr8E7RlGEUS8DGKw5pyeu
	MaTIvC4EZ4UWdka+JmcY5rYL0vwQpumqJoBhdwXq3fn+VCnyka206rfj4eLkHFb8rUfUJxc
	6ZthRSHT3I/+B2bH/Cm5yl0c+rwQ/m4vfJe5c+54kD4k/P+LlyZljOusE1LWn3sujI0Ir0c
	XWQK3rhJbLmRG/dyi6YZ35oxRXDgZKRf2XRzylRoiVhujiudnZ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Recent firmware updates introduce additional fields in the mailbox message
to provide more information for identifying 40G and 100G QSFP modules.
To accommodate these new fields, expand the mailbox buffer size by 4 bytes.

Without this change, drivers built against the updated firmware cannot
properly identify modules due to mismatched mailbox message lengths.

The old firmware version that used the smaller mailbox buffer has never
been publicly released, so there are no backward-compatibility concerns.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 41915d7dd372..9d53c7413f7b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -352,7 +352,9 @@ struct txgbe_sfp_id {
 	u8 vendor_oui0;		/* A0H 0x25 */
 	u8 vendor_oui1;		/* A0H 0x26 */
 	u8 vendor_oui2;		/* A0H 0x27 */
-	u8 reserved[3];
+	u8 transceiver_type;	/* A0H 0x83 */
+	u8 sff_opt1;		/* A0H 0xC0 */
+	u8 reserved[5];
 };
 
 struct txgbe_hic_i2c_read {
-- 
2.48.1


