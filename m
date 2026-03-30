Return-Path: <netdev+bounces-273297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN5RDPDEymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814F35FE92
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 980EC301134D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765663DF015;
	Mon, 30 Mar 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qu5zmt+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED153A1A27;
	Mon, 30 Mar 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896365; cv=none; b=tR6zXxLhpTn42q4HyNxYHh/4nTtXfQ+FpjnXixjpd7wgXLNVwwCGu3agGK5sf0izaqaLZlrpMSTbboj5nV/40J3LJ42+cd/G0g8nvWhu+9u9a3n1XxQIndo+B5i1yv55Clwjc0ot+CQcTMXEkuTvZ2t8NUqzbUzmuX/oyJDEALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896365; c=relaxed/simple;
	bh=QsSoqKo+RvBgVtDs65gRGQEN5/0YAAlpWhg+wJjdDg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzICoUsVEPu1fgEvjimHoI6uaZ6YEJomkewaTTojnx7EqiAsRAFpWvpkTtLpyhbqwvJpET8Ft3jycY7A/511DHvekDvANu6DNxmSPMNFOvpTWHSb0K2DTCIXgXKiqH7jRK4XlklTljrngvSLc7/OxICBAIo6Nopga8e47k06res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qu5zmt+2; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [79.139.249.222])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0F935413A4D5;
	Mon, 30 Mar 2026 18:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0F935413A4D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1774896353;
	bh=+B6v1TakfJioZJMNia76L2HfBJ0P/AY42vMLbLG1nhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu5zmt+2waCfevZU5dKqtQzT5zgKS/zq3guS8vs7IArhtbaS41C2btQfS1mjKBuvv
	 iUJhlUfuG96mKBrtsQlw7KQZ/AaM0uR2gA1epi3vLODJp81OAZ9J1P8qFt3gfPttBP
	 lvTIs2aoLY/8qcD8iTxW1HrpRGfn6DTdc7ITZKvk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tong Zhang <ztong0001@gmail.com>,
	Bartosz Folta <bfolta@cadence.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net 2/2] net: macb: properly unregister fixed rate clocks
Date: Mon, 30 Mar 2026 21:45:41 +0300
Message-ID: <20260330184542.626619-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330184542.626619-1-pchelkin@ispras.ru>
References: <20260330184542.626619-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ispras.ru,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,cadence.com,vger.kernel.org,linuxtesting.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-273297-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ispras.ru:dkim,ispras.ru:email,ispras.ru:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 9814F35FE92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The additional resources allocated with clk_register_fixed_rate() need
to be released with clk_unregister_fixed_rate(), otherwise they are lost.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 83a77e9ec415 ("net: macb: Added PCI wrapper for Platform Driver.")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/ethernet/cadence/macb_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_pci.c b/drivers/net/ethernet/cadence/macb_pci.c
index 0ce5b736ea43..b79dec17e6b0 100644
--- a/drivers/net/ethernet/cadence/macb_pci.c
+++ b/drivers/net/ethernet/cadence/macb_pci.c
@@ -96,10 +96,10 @@ static int macb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_plat_dev_register:
-	clk_unregister(plat_data.hclk);
+	clk_unregister_fixed_rate(plat_data.hclk);
 
 err_hclk_register:
-	clk_unregister(plat_data.pclk);
+	clk_unregister_fixed_rate(plat_data.pclk);
 
 err_pclk_register:
 	return err;
@@ -113,8 +113,8 @@ static void macb_remove(struct pci_dev *pdev)
 	struct clk *hclk = plat_data->hclk;
 
 	platform_device_unregister(plat_dev);
-	clk_unregister(pclk);
-	clk_unregister(hclk);
+	clk_unregister_fixed_rate(pclk);
+	clk_unregister_fixed_rate(hclk);
 }
 
 static const struct pci_device_id dev_id_table[] = {
-- 
2.53.0


