Return-Path: <netdev+bounces-181351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97FA849EC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27024A30ED
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF15215181;
	Thu, 10 Apr 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlLgbVq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C511EDA2A;
	Thu, 10 Apr 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302656; cv=none; b=unL6kD5W3JxmQv90toL1NEoRkKGBm3AdOEunfFJ9eXc+/gacnFxP3dfkw1bOc25XD60uCvpXnFHwsSVnSu/2OyRMdKRZl39LKJc7b3EYCi2hFMv+GkUqVEsEsImkADZIk2JP1xgSACPz2jgzxufXouqtXrKdumXznQB1KlLiFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302656; c=relaxed/simple;
	bh=NiHcLZuiX+UbI2WSnEGYPrTum8IpyJ+F4IO29GcArR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah1jB/3s2/uvL8WQFFpNyORnfcA35IJvxkA5xlJXwGnD8MJPgSfKfSEiq89EuGMBPav0iHLXdITNb4sV1lHtFu36ZwuJye4D5oYZ7RACXxteYZORsY7xL42P3pY6/IoUhkJ0nNZPYB+gvzNtFkw4lMuBwrTzpywoiPfuS+Sc968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlLgbVq1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c30d9085aso640652f8f.1;
        Thu, 10 Apr 2025 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302653; x=1744907453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQTDX8Alv29qulK4sXrqEmrdIZusnQjdpDN5F5ZMILw=;
        b=HlLgbVq1tDPYzsKpkkNYO1S1LhynXCWSU8CKunSE8X40SODxzGRCZPMG+KZUDbGbjO
         HO1W8BN4ON2CofsFzfNXU+ntUpiudJUhbfOLL10IBwabu6bPfac2nRhskcwCcc6mkaXB
         anx95u1C4VGzaLLB9fQ6YbRqN90oeGnWIPy+6on6IpEZbzRnb3TiWmGwx55H3l14JQS9
         1HvhQKrRZAny0XnHLwoEmZXBX4eMMAmp11ngD6d8wof4wUuQw0Tcy6vsQi8AffDuf0oW
         9BMM+5/wbUVK1LafFg0AG8JFavOjskdYPCVoIBf3dR1LJoXcz0UZD7PDAyeu1eZ1m5Ms
         Zf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302653; x=1744907453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQTDX8Alv29qulK4sXrqEmrdIZusnQjdpDN5F5ZMILw=;
        b=gEmHU/CAJ9K1IhRCphz/u9CxRnx79kn46Jd/pSl41XD2d60C7Q/Kcvgz2Y2CDapYrg
         UXZw0VyxvbnWg6uo364Poifba+8iQm78PbdGc8NW2Xo7ZMRX4XmhHAJ+ZOfSG862oldR
         IB/6sH32FaKu46bbLxShGKFqzUSKKtSoip3bngCyhnLMKa7sK1KzTtpR18ZhohXdVuW/
         pFYP5WNX/UFRsvnwoKiSslbwKmpzn1ePLrCpRHB2f4YJ5o2/1OIAS7D+A2kTVgctefsI
         3iyFpop71HdYQUIRKYSiuaLveSGyuse8/TVESp1kEFN4p1WpbDtBtr8wDymc2MBXCTLd
         i84g==
X-Forwarded-Encrypted: i=1; AJvYcCUoTqlZ0tzxH7EUbkFZqYX3xryzv+g3QWMM4DJX/s7N/Y0O2dYDTnBZ6y91MWLarP98ZZY4NMfboL4hhhQ=@vger.kernel.org, AJvYcCUyxJKaj/CoWsg9vtOLFfpMTUcdx+o+lW+1xa0Fiz6Yh/64/+YqFRtOA1Z1PWyZNDJ6nJokSxpp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1a0bViwalNQ6Y/2/uwZngnI9Zont8gY9nQZhkadjrckyC+ZU
	3BYEIJwCNqI5IAWZ/Fd6GYMH4GQpMBmnY5XrmEuHXfcHRbRB3P+z+DESpA==
X-Gm-Gg: ASbGncvtuOLV5fjQDnUVwEqipREOGsIwbzxNTE8gvbpUze0svToJTF3+QUM+gZNhDJ9
	1JXNoYtt5Qa+HESmzL8FwkzbyvIAxhgeyEqNRuTOdw4m4kUszqZXWQq+tocut1Bq95rVQHEjdog
	i63iN+EMsGN1rexcA4A2UjJzbmhy/WkRAFfvw3XQPFH88/sS/DQYhufJ3EcP2QZEYVJc/+rOPmj
	bhwHY0pUsyjQ/HCOQ3GejWVK3lQHIABK1d9qXIdX1JIYilEyVKoywtIBx8xisCVGJzIHpORSbee
	co8t/7GyhI6k5JBMBqK9SuRukOYNKFvj+P79dsJeUtLqWJF+YIssARqoBCT7MmVEOL5kz2jPXW8
	7n6adRgsJiw==
X-Google-Smtp-Source: AGHT+IEkC+tTadCXFScLP1G32ei1mC9Yd5VZfiGai+LcT2Iz3BJBKI8tPw+x/jngazgY6l86z4MM/Q==
X-Received: by 2002:a5d:648f:0:b0:39c:1257:c7a3 with SMTP id ffacd0b85a97d-39d8f50227emr3137236f8f.59.1744302653117;
        Thu, 10 Apr 2025 09:30:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/6] net: dsa: mt7530: modernize MIB handling + fix
Date: Thu, 10 Apr 2025 18:30:08 +0200
Message-ID: <20250410163022.3695-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series modernize MIB handling for MT7530 and also
implement .get_stats64.

It was reported that kernel and Switch MIB desync in scenario where
a packet is forwarded from a port to another. In such case, the
forwarding is offloaded and the kernel is not aware of the
transmitted packet. To handle this, read the counter directly
from Switch registers.

Christian Marangi (6):
  net: dsa: mt7530: generalize read port stats logic
  net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats
    API
  net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
  net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats
    API
  net: dsa: mt7530: move remaining MIB counter to define
  net: dsa: mt7530: implement .get_stats64

 drivers/net/dsa/mt7530.c | 246 +++++++++++++++++++++++++++++++--------
 drivers/net/dsa/mt7530.h |  42 +++++++
 2 files changed, 239 insertions(+), 49 deletions(-)

-- 
2.48.1


