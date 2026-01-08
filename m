Return-Path: <netdev+bounces-247943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68188D00B4D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60FF8308BA28
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF11E1A33;
	Thu,  8 Jan 2026 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EALqSZ4F"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DF19F135;
	Thu,  8 Jan 2026 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839754; cv=none; b=PSxiPDRPCOGWyuPcRRE9r0XsM9JAJbFLWIzEicxHmfHdc0wreNF3y4ZvAq8Kg/xpgRXrRE9NsJiPm2c2cYykc1yNMFUNlPJnbt1xRsg3xZot8yEUKaTsLXHsEwYkIEaCn3oMqnbasXRa1+DAqBAf++lzadSr1qny6JjwsyO3XPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839754; c=relaxed/simple;
	bh=8w0zUQot0Td8MJc64KNRrRzNN1FGkWnaIgcl+PhOHrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bi8ZF/gILy6g60sB3Rzv2PUPYvy9QuWjsUhnjL6wFCqwBtC+YHMrUo1vHKwhTMVb2akmIt18uZ4tKUl9YFBj/UJq/CaawRUFr2UN+UBW0yFDw6CPiFbIFxq8w5TYqvDVAio3NCTEcU3iQck88eeZdZcrh4jV9SOCdwSpCd/Sgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=EALqSZ4F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6082ZQgJ4109080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767839727;
	bh=FifvSYiNNb4Ew6CTBLmhWhGdlOu/GARV3FDormX0taQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=EALqSZ4Farr1/SfSfYTLYkj4k7J2YiU3L6mkAkSwdU9+Dac0Y6INWlxYW+t3+Ktrq
	 tR7RAXH4Y72owBuk469/LLkewwmQ9jEPWPIWb+3vBe9O5x0ZoUHRdExaiTrydpjuor
	 tzvXfZFct9JXKWRElDtwcBQbbRVigkxkaHm3yC2WG2xFv6W14bdSgL9v0PdRRla5Wy
	 OH8M67Inhvf5Z1mkAalsyVzoTEo06I3dmm5utlchiQnkRztBDUMOZgo0xM4aQRYlGY
	 j/2SEnXqfiHE4UTlxQiC98KK9kVMWphCUnMSFpjcOZ+njCU5gFgsYsARZHYtcJ130r
	 LLHj+vl598grw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6082ZQgJ4109080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Jan 2026 10:35:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 8 Jan 2026 10:35:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 8 Jan 2026 10:35:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 0/2] r8169: add dash and LTR support
Date: Thu, 8 Jan 2026 10:35:21 +0800
Message-ID: <20260108023523.1019-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds dash support for RTL8127AP and LTR support for=0D
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127.
=0D
---=0D
Changes in v2:=0D
- Replace some register numbers with names according to the datasheet.=0D
- Link to v1: https://lore.kernel.org/netdev/20260106083012.164-1-javen_xu@=
realsil.com.cn/=0D
=0D
---=0D

Javen Xu (2):
  r8169: add DASH support for RTL8127AP
  r8169: enable LTR support

 drivers/net/ethernet/realtek/r8169_main.c | 116 ++++++++++++++++++++++
 1 file changed, 116 insertions(+)

--=20
2.43.0


