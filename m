Return-Path: <netdev+bounces-259573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MN5AJNgl2kAxgIAu9opvQ
	(envelope-from <netdev+bounces-259573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:12:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92884161DE7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D13BA3012D06
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A76B2F0C7E;
	Thu, 19 Feb 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="D8w/74TZ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009E2DFF3F
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528336; cv=none; b=f+lTA1+Jr3zrm1RK4EOaAaWp8UczMVfj7LY4vLea6TZQ/s1xnBTwMdZRzVaDh8ueZYDIecfV6zX2oiggAmzdpbnZZ1fAuulehj2VTgE6r60ej7vkFNtRa5tsczpc/lLO+ZkfPMiPMp0X85TXujO8uT7LrHADvVZcu1+q8FhiXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528336; c=relaxed/simple;
	bh=3ikTeXHqkkKjka3YreCgbGPZvLBVSQVy7oDraPv6vT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=CPWkDRCyDkjLXx0cPfRg3pQ6oET40r/e9avDT+XONQs7PDzMPtpneT4pImalAqlUSSHltOZGVZ9rZO/jPwqX/z8LuAmk68EhANfUATBQlxgD7OTkCF5MslFSHUXBv4MAEA2NYQXAWKTw7t/Np4HVW6ebfI5Zgx8Rk5jYXuRE2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=D8w/74TZ; arc=none smtp.client-ip=77.238.176.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771528325; bh=iaCwCXJITWk+Di0OQ3tScf/e/NJTS15h2zbUKrBRvDk=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=D8w/74TZFeb/nxtVENBfs9nTrdckc9lJXMiF9sYygE3eq6uRA4IunrjrdPhwCCU/dTRRlheTiXKO3jbAqSaDx6xsYLcOxFuXl7J9ZwBXsfVVzTa8nPdB6fOZzKijRTst8C8wPknzPwLBdeDeKc+s9DTfvimHEIA5J2+txoQGvKG8IvURqyIVkB+eQ1Q8OIEpDVyQwjF2teA/hkEZjfe3AU+kWAJUHSr6jgi140oWpkApCRta3TZeQGWVMExQkIL64sUx8ojYqXuVGvgR+FjLwFSg5KFF/8wNzciEtp3GgrQzDrK1o6ThmoLLdPsMjP4Bu58DrNS9TehIG0OFtvynGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771528325; bh=iAH4w9xhX8/ED/ivZQozZb3rpgExpkkwdOHtQRU+HYi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HgBwkZVD+iE7BOSlEObrgMuxvCSQwmBQpY/nApkdyGGrXu0R1zFqasAY1AjHDo4VQ0vCB+rQpN0JF+ZoWHKzStLJkimHr319m5ZkwrGdCP0EffjpTgTQ+pAsU8P5C+kRiKtSMz/tji3YhBE/0msebJFBz+Ec22yC8CoOVxCTlAOZKv7r5Ki2K0JxXiMQqWZR8+ApTpiQrdHshrBXpmgQEWDEoOO6W435Zb8yIGNxaBjcABJE5RPUUILQkWBnMRflD2qo27HUutjTVJUvrVjD0MMsTH3UKIPtvBdkjEQsIMjcWFQp9/vkzgapVb2cpUuWukpDmdCcH5nCZBkC3hoiJA==
X-YMail-OSG: Te4q5EkVM1kGVDot1c9H4NhhSf5ajsxQh.y9DvS4oBn0.xzMnwtiNGPUqBdnZaL
 KVWDpVcpRF1FRzHgUAE7ZwJTKy9NzfYPPcWuPFSKfCdWNNIsXB9Jnuls.3BGU32AteIAONuW1P2l
 nRZLvR8mMdu9s5JejgpHowThk7ZlwHzaxcnwHOxsDX1FruPjCfOIr8lV2cHhDXh1UenJAPqxbNI0
 sFmx23YuPhayaI7IDIYHAqKRl9lAhz35tRNOggWb6TaLA6pLhcEWb8BlwRKh_b_C4.BCG0vb7_gL
 LAIfdj2rZcmV5u0NJCEy_BbIWfFp9GIdm4vJBtrbL2EXw0DeDFNn0JPOmq1.4qchuW9FItBDbEdM
 BU2QJAPWYHmPscGCFETB2E8lWfNWRRlAkOBYOwP6FL28zljPf6.hQBf8aKl1MOhps7GPKX9mszWk
 Hvrx8Hg1xBGOmT3USue4pkpmCbbgTtkXvSX_8c8bxUcMwgRtaqGrL3eVz818Rq8ArEFUSGZ5Td_e
 wSfWGpyHWzuQCANz_EETSzIyIvx7Cv21qU9Wv3epTOUD4YR8gi.PfxEqQsqpB8WF2tvzbPrr8wac
 7fyiIPqLKcI9HlZMC3RyL.mWysxOsXPdAOw8_1kqsM1LeIVOSWIx6bjTP0lUYzpNIbBBnjeUc.kt
 .94bIzs09JuRVOJdaYO6l0AWjJRhKZH.6oDBZXN3J4ETnUdvdrLgn.NIdBDVyU_yOjEpHInQO1CR
 ir8VXbk7wpBTCZVkGClVTrrsowrkdmUHluAE9HyU3ZOspKVn9ClCOx_QuLe0fEVC8_F6ok5aJesy
 0ECF1Q7MjB9PrQPnzNaNS99Y.CYbEC81LwJ6deU3GK3aXzH2FcqFAfH1CCCvnt6mOW_jq0bBLLgI
 VWMCZAcNH7w1rctEGyUjBOzkIyS_UCXP3CysAp_XzNUXCc52KvZbrQdqeBUdMOGY9YdBzelJB8g4
 307IM6BhvACZl5SteSSbfZsMsM89a3KK6qbARt.CRgHUwRBNGV5m0JKTxQbGI2_gArYkNgfDHbY0
 _ZZJ94neIrn6r6zYp719hUhNz2._RN3_PCx6R93uChRCSuZr4Eo.qRcepASetVRE72Bp5HDHgJeH
 j16_e6SCkQkg_aH8btVaIJwI3mBC6KTTIqA_pSwXn_d.gezgNjEif0ZLXEnB3SAXqP8tsSWKfAjw
 pt3zrWEQuFNQpXs.a5GBev7IrlN9hMsSkIRONpQAwayoMqSONwOmuP7irff6w5f1cQ.SeeGRK_3R
 FwGRI7YitPFI28PphG8gW9_KipqvOXm0jEj9kpMxJrP.nBZqJGs0AGpJwwGgvZPXHrdoONRram_h
 hpc9NVGowFz.79COM0NJl7ZHVG5MfcC.RHQiq4xsWxBKm17YCD6khxo2dwOLIGq4VGTIiWlNsBxF
 smITZRcwbKzm8Pto89AdDhmMcXMr1j9HEa4K5ce04P1ApdANrTe2lJKXs0ItDlmAvOKbv96AYbLX
 gjW_zVpcdCvus.ZNpSqhoQI7_ky4lQ7Da8foP4sTHqIGdZVGtlRe9EuiGE7k3S26MkCczgjOEQO_
 FFH7UHqwx2iuiq2P_0.k2PUBSNavRT62DllS9cdSiwKtmqezRbE_dNJffPD7GdCXQtUwgUv4F8ZA
 5F0kJTo7UgusioAu.vyHSAVgI.4mvwbYuu5uCmZRjbbFkCNzHuKLq2VBR8d8s5lha8SMR1RFy7zZ
 VhT4j3fv.s0ZY9NUyig2AIBhqnZj04P7Jb3xhoQkBcF.9KDXnAX9AAbINp5mMRzI0FIsar3kDy6b
 BIShHrsg7Lv4kzaTaMrl2w..J7gsvIkjyyIT4uxIg3UogMaKqepP7auYcmhnuG3PTWwpoOjZ5Qm7
 jrk1a82D8At6pJB7W9Gl.U3bLUEKYORda4KYsQngRBeS99xjODZL9FLaF57DaqfwSnIur5yZvGL2
 _bqK9GokTAafrPBCxRr2G9Dfsr8cfhkFo3kyoIWa7TZYHqcybNTLObwydNJNfdhDXkNAcncWnFGQ
 aBkhWij4XEZROb0VE57hs0vGSHJQ71Rg3y2aJpbr_Rw9OZPMQDTyVIsLBFscyW7troKKnMoX4sVB
 GeRKi8RCqeeTVYwObnl6mXPgPCGwlWXt22kLozRb3bxLgDtJArTXnBEOD3IRPcnZHkrsNGkYcV.h
 0wG0U_NOjTjo7f_GD0tuOGvq2sZONYBbbOKWI2S6KqKPqf41aOvY9JCuKc6_vX3DaZQuw7Mo1Ea5
 GZyKXmhl.O9udFuNnTXxguE_vm1foxAmoq0xFccV8O6Hr9E4atZyqjcO4msBum8pi8M1CW014dBd
 9qxNuey8-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 429394d8-8e5c-41ec-8418-8cc9ead76d2b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Feb 2026 19:12:05 +0000
Received: by hermes--production-ir2-bbcfb4457-9k578 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4276a2a9be5d302a996c69ff3595aa6;
          Thu, 19 Feb 2026 19:12:01 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] nfc: pn544: i2c: Fix spelling mistake in comment
Date: Thu, 19 Feb 2026 20:11:53 +0100
Message-ID: <20260219191153.96434-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260219191153.96434-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259573-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92884161DE7
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

'occured' -> 'occurred'

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/nfc/pn544/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index a0dfb3f98d5a..1ecef0acaa50 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -171,7 +171,7 @@ struct pn544_i2c_phy {
 	int run_mode;
 
 	int hard_fault;		/*
-				 * < 0 if hardware error occured (e.g. i2c err)
+				 * < 0 if hardware error occurred (e.g. i2c err)
 				 * and prevents normal operation.
 				 */
 };
-- 
2.53.0


