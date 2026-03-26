Return-Path: <netdev+bounces-271796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wApuK5+XxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD932E4D9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D153031EBB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA062E62C3;
	Thu, 26 Mar 2026 02:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD71F1513
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491366; cv=none; b=e7QNdGYc/5vf9Z+U35GT+p3wAZZcpv+FcFbjMTUALAoiwf2lMJZJAfiT7t6Mx7QXDRufZJpp6JYaz4ZNwUx833bUmxl5QgDn9ZiarTzMzGkuVwdC9AI26/X+WWLx46O2JcAVto2v8UsK+5Iw0XEdriEFm55WYYREUfB+INEgTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491366; c=relaxed/simple;
	bh=2b7f4vUUVw+Nif1beU/Mv0gX1l5DIhn/5UT+42ERHBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7aRrYfN54/q0zpkWm9+tTl4zKBI6aiqoAgm58Ga7A63eSRBZ9rsFA0DQPQbCZY2wcdZ3ozyQ+zJWAXnDDy+HGYz9L5yeTGDgt8/NqQJu0e2UBD1AYZkqnH92ScdN89YknvONaH0xvDyx0Ai6gxVrzfuXbWIQo8KdCz7KsR9moo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491302tbb30fc4d
X-QQ-Originating-IP: zqLjt/vPnBDSdXgTdhZrFP9tGAX5hBeACzIoPosSbD8=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10991289311477992220
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 01/11] net: ngbe: remove netdev->ethtool->wol_enabled setting
Date: Thu, 26 Mar 2026 10:13:56 +0800
Message-Id: <20260326021406.30444-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMB3uNxca02mv52fN6/6m1xZPG3cKzVRJ8q2KoQ4R60qtA2PUpk8jghv
	YazPW2/wk3YoossW9bDE0SAH8jVvTpW0LZ8HbQxINDuG90IrJskcGOP2ZkSrqMm5HdBlvdZ
	kqX0M2w61R9gvyoLiM6JI4EUVFOcQSfaUs993IzcMOVD/abyHwlWsUBP13VBLXw+fWQORYZ
	e8WlX0dS2Ma0V4TV+LNU7EQGD8J58v8Y4LGEXQwGijuKr6ujRFF00TtjliSXyCKnI5oPmAq
	XCOzWYmby2K+wTC5RO2dnGEiBZ5l90oz7AC0U0KQaw2vClWmuIDSQcfWcDfgfduQ6Axwy4o
	tyK9TjSvElTJ6oHD5mTv2ElYWpsV8vwRv1hOEskN65gM9WyNCN6mXopmB0OVg+opA6VSUL8
	bgjVvx8USUk+mABslwi8sZhcmU06MSJi1dz348OOt6nkcssuBieYi7hS9ac+VBsayfzhOkk
	UuR5UTD4QONlWIi1wLplNYJKNX/5IfnoM2oS2hmjI6L8vkhGY999LygZE+S7fOdx07QsO9O
	W6BPeZGgXC7i1J05TDbqEVLbETUnU5mTXOfPaTCyfSxQOfbCcuFLNJXzmvYXi+MXZ8azDc6
	9TWUogYVn92ymZUQWbT3L8p67MaHS+nLnbXlPyrqvwJZRyd+va4NxBO2A8g+Yr7UbtGdBr0
	RdcWrPG2xt1G379F4TnBvWrSw6H8ZVC47lr1YCr2ClYGFK6SE+/os6okpelhFw87bEeA/Y8
	Nzd2RMPRAQVqHDjBBrKhrr9Z3M5od2a0lxYbg3rZO1j9DnyIkH0BEFh3JwhSuMDFoBXIHXk
	2n5BPVNkW/oqPXGL3gdDNUZE3t9SytgBOkCA/bFsdnRGWMMCNhe27ZcnUMpVNXsPOl+NSW0
	C8HStvHommn+Gf/hJP8+tJTrfSuzUMKNibXD75pLFdK/7KEtdRbEeGbAQ/3ZxPrNhKGFq0p
	8209qhaw47o+nD80gyV/uAVrBtTjp3jzeREim7xKh0S9oHAlP03aaUJRGYz1Ste6s0YXsNf
	YVrcucBFJdm5ByPErp8iF11A2j+JDPt6c2NRLTGFncAobmpJoGmglfqOndaabVJ6pF+4wZg
	NsDIGK8V6iA
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271796-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid,dama.to:email]
X-Rspamd-Queue-Id: 14DD932E4D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
redundant setting in ngbe_set_wol().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index fc04040957bf..40779fee0fdf 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,8 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
 
 	return 0;
 }
-- 
2.48.1


