Return-Path: <netdev+bounces-261033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FQFMaExn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:30:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260EC19B926
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B41302003B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4163E9F62;
	Wed, 25 Feb 2026 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="nr79grJ3"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA43DA7DE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040453; cv=none; b=hrf6Ya+Nm1W9LhBXOFcV4zdMDs0GF1gcGB4xWh2cyyf7Dh6uCV/dHoOBn2PnKcQJTpldiBkZLki7+1HAO706fB/JGCrdm7TORivrjNFwlrm5rJyD5wHAqU6XdghEn7CZfxCh5jhv+PitHOK/W62/5trVaGAGNCAvki+G3U/zJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040453; c=relaxed/simple;
	bh=1rCLsUMXYJ51Chyg7pUNrR6pCLSBmImRH8vTKJeGBO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Ex4UdXmgGF76VztNBpoZsO3UK2UI4gupP5t+m5JTs3K58QsS18Ubp2gVZnl59EedFIDdDTkUkCWvldS6jyuLb4O/zGoU6ykqgrT6ymFIa72EnfFXyVT8P7pI9Pn7TWc0rN5W4BsnN9v6hTvzmCaI/rgCFSMzeI1lQ8BjfsJB6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=nr79grJ3; arc=none smtp.client-ip=77.238.176.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772040442; bh=s/gSVanzR7FfLUJU8S6hY2ZnBTKLVh5CuFa7+q61QIo=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=nr79grJ3Gosy3clrymgmmY0YOZPV/lcjtHApLGenANBlv8SnTTLkLXfFrf5tF9Rai5axfL1lUQptcBxKsO5cgI5YI8x5unIelpSwINzLUN6/md6PFEU76YdescbaV6PxkMu9Phi6dsF74o8DhSnRapHOUcXw4PkMutlEj5iR1uBeQdKysIrKRdqjcT79iswF4DhDysEnUPaJkRMsf/8CfYyQ3YyKU3taHUNUoLHWAtLMQ/3D1xKsBsEigsHDWAoInh/oTwpGNx8VQybmKZJd44VgmXO+k5xGLHtPJRfKp2hN4blI5wuF78wMH5/suUwtbul340wjMHKx5aZw+JQGVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772040442; bh=4XlP007k3lN+u/e5fxnW1E80LEz54vSgsLLpt1v5dg7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IqCo2Zsy/ErgbavF/r8OCtt0IXAmAVzGK9d9vVoesD8hME1Hi5dMGs6YOv/XBp1awfQfbopsmcuc3X93xiEUmOwwQjI8Un5lOvM0arCe2enkwjxwpGDzEWcUiqBEUT3cdHgB0bkEbVKfZdy3Z2RdulxYyZWRjsmRPZ5YRz3VoUEL/kmI3xdjWBec3VLCeu2eZY3ivbKlNTUPVwgjtnzx80dF2hu15Rbb9KTAN2dyjoS4jRMONmIZUK3TrB7QpRDZXbaIDJiLQEP7gl4cl3xa891d/ntHGWE4Yr8Ia5s4tmPeam9Z78NxRrotxLJAb0eMGTTO3tmGvzNyYoBxTjDCpg==
X-YMail-OSG: 1cFWW6QVM1mb3OibriezuxHPrBpXVab7HuZW6qV4c.8_zJNpwBVSaP0EAtYlGlW
 5RkRQKFqAxrd7tYyHOE_5uUe0ek8bX9V7v8NMaMnq0.AFPuEQYtOtru_AzkGSFgElCCgaQeBmGyT
 H354lIzO0ADEpq8PDcTL9XAYcgXFYsJo8FsIl2w3gi1P4zR33r1X0q5NJ3SIdfQ65Ea5d0CrRHyS
 KV6pRWU6QkN7H0.theo7Oc7I.r2cFjqVCbTldV64lbyoIQfXVmp.I2pNL4YiaCfn_SLMKTudel2_
 Z8HRAFsAeUF_CbY5_nqWfmoOfylR2H1XXpyHrNfDxoe2wTAoqiFqE9bGmZFtH03S3GULo6yDPv5.
 afg56JOeG1dWPQoapKMgqIx3YVFdAYLFTPpCLSAbNxZQmBwlu.PtXl26YxSkpxPaOHVoBLWTgNB5
 6m7dQPFZHgaP_y2MaOoYUKqJDLZM1.3xu5Qay4e.vpMUADXwreALLbqxdXyZUm.u_zaP4Dy5S4cE
 UIcsO_.GimPp_33MZxh3E9njmnEW0GA5MIQ8cUPe6VTnxGvGeyr_pmNl2juYPcnljWqJ0pPMafDH
 5ylUwdPsqVkHcC7tNvcoabdLNTfBYEJpDTClZenusmwmodI90URB64KhUS9axgtkDBYMabuG3yTn
 vb4SjKKFxHyW2epwQnuzpyH2e6lQkKuKmHN9dhEfUJ_ij6L1ycRi7kjjmD.GNWs3zrFXdcKivGtu
 2lCh3sCV_QaxaRb_rhyQtnpNOOUyal5..44pGu372JMCO7BsIn3fspb7ZzL5JQR2T2nW4FOun6GA
 LvKlJcX9snxmdCPq8oIQmvj5Kw4YgEFzxAdxuomwfSKaKQqNe53UXLw7Y7yXnETHhoZ8OYyZzGSf
 lxQj99VjobxY6zDY.I3lYQ.Rg_uZ0N_zMh5z8ws.RbkHuRLbVdPfePS4PVXRVAy59diqGPG99abK
 PwOHIDb6FJ7wiJ_b95Z_KG4_4P90qvKSOpZb1R3V1ciHytwg5zrPDTvStaDmX8.NVBXWe59jt_NL
 bqzEXTeO0Ylk8BJHW57m.m1rPSAk88X7tcHGAGtFmuoKTqvEVKufdpSGca6k5DUaUobYnc69aoPy
 K79e5fcwz5g.VPLTn_Wv7x44ArYzxcFyORQUtJo1JxZkbhCXyiKOGHZmiei_Rds_OaMNs00EDF9n
 MQqpAIhWaVBX2g8QTfU3Lq.CsZONDolik2l3Gysb7ivhA_LXk88yGeLV1YHTBLYQK5QdcSNcp2gH
 Cedjxc83hEif9.OLw1TzKWIAw4O_DmbxSPFo9fw4TEphGPRTMIujyv4M_CvlHVoGBKkci8OdG1ih
 MEwrSsg27iBv9ViZ4pf3XiRYcDEHAdLEYvrvwIl66fLWCxAMOCb5Fd.Lunz3jPBUpqCm1Bdk4wp9
 tXc3Xjy_2jkxOr_caj.wG8smJJ98yry1mLhOa8LWiPbItfQaMsU1xUXJF6XBHsiE2fYbGX2rrzRe
 _cj.ydUIwh20FAj05ZhqLf00VT.IuGJYCB3.BntkOCTs4cTb_wXYncGq40jm2Wu4OFE1mpwF8Dp7
 mWNPxeRpT_hFcRYALx.kOmMdgi2QddVmHYdZYiBKiLbsG1t1UUZB_YwA6l4YZRDvd97KkANEzOaa
 09nqV3V7XV2OvfYeZvUYy05gWEXjBfpl.iYBznD7hyrTFynRdUNmtooPQyT5XaZ80fIW2n_OfQtH
 .CZCVPDDO1aAQPdsvKH42zJ6aiEgr5o29saDWPDLKg_SYEos2dGyCaXVU3OiTCnMTM7dibTCvCbt
 TtzkaynECBNKgh1147BEHw5bycA3TkPOc_4qHPlIj.0wz.6VtnOn6X6ZiszV1GS8Cr2ofNKRSmGl
 WmqxFdCyBMGisZAXlkhuRAoB70GVrz5svk5lA8Hwb2fK_C5cYjYTlH5p4kIKkecdOMgbDO26fiM7
 N0SF5WpwJK8thL55qlmEQaHBvawH_Eu0P.6fPoHHPPMjZPi468ExqGgZhvCK_5Qwr0K5bsWkWAPJ
 GW3kvwP4.e.16fCcMIDybzsEfEZ0Mts0X.rh1PlE43ycXXmQBp2BIZ.AaAhV1k.cPUrYsVR28cVm
 0zQudgB_SlXUeTt3aZ8QnV9SmYKWwTALmrhnknMMKnsDjwUHHh3w7CDYJ86_c65dYz_4UE2JH5lF
 wAs4lr9lErflcQKcj2yCLDLsQxHkMEwSPDvNYxMVnW7VIHzKUFXlgOW0aNzP4ym8GkcPds4vhP_a
 kVwPI6fPRCv_BbTJKHyMwq5gvktrkXEjilcVxCx55dnlDzNtp0e63EOw9W3R9gBzT_mfPJ_C6uts
 -
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: ddb83b94-9cca-420d-82ec-cd4cdfdc8861
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 25 Feb 2026 17:27:22 +0000
Received: by hermes--production-ir2-bbcfb4457-qnj4k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa4fc1b0f0f7ea73fc2a1c52f3ac0d83;
          Wed, 25 Feb 2026 17:27:19 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH v2] nfc: pn544: i2c: Replace strcpy() with strscpy()
Date: Wed, 25 Feb 2026 18:27:15 +0100
Message-ID: <20260225172715.75756-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260225172715.75756-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261033-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 260EC19B926
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

strcpy() does not limit the number of bytes copied which can lead to
buffer overflow when firmware_name is derived from user input via
NFC subsystem. This is a bug fix, not a cleanup.

Replace with strscpy() which limits the copy to the size of the
destination buffer. Since phy->firmware_name is an array, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

Fixes: 06c660340f1e ("NFC: pn544: i2c: Add firmware download implementation for pn544")
Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Changes since v1 (requested by Simon Horman <horms@kernel.org>):
- Use two-argument strscpy() since phy->firmware_name is an array
    
Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make drivers/nfc/pn544/: compiled successfully, 0 errors, 0 warnings
- Module loaded successfully in QEMU (x86_64) with buildroot:
  insmod pn544.ko - no errors, confirmed via lsmod

 drivers/nfc/pn544/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index a0dfb3f98d5a..b31b5bef7187 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -526,7 +526,7 @@ static int pn544_hci_i2c_fw_download(void *phy_id, const char *firmware_name,
 
 	pr_info("Starting Firmware Download (%s)\n", firmware_name);
 
-	strcpy(phy->firmware_name, firmware_name);
+	strscpy(phy->firmware_name, firmware_name);
 
 	phy->hw_variant = hw_variant;
 	phy->fw_work_state = FW_WORK_STATE_START;
-- 
2.53.0


