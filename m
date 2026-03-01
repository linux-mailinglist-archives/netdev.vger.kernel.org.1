Return-Path: <netdev+bounces-262403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD9ZHG9QpGmadQUAu9opvQ
	(envelope-from <netdev+bounces-262403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:42:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE31D03F5
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 814B6300D4C1
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01632B985;
	Sun,  1 Mar 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="e/jfrqx7"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039552DCF57
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772376172; cv=none; b=ThQXmqDBszNPvzNRFCVTvpFL9A2JgD5Qxfc8KzpjOPYsY1RAm/BTnYs6Zp89ZgFdtsmMoDLWarzQkhAnQuxPY3zioOBU+7W+KvxvsCCBQB+tdPTkVtDXBq8RVwLjgW7cG1CUoEnSMXlvShZ9jmwQMfVn3F6dJdh10UXSE3mXFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772376172; c=relaxed/simple;
	bh=Y30/DMT2fyEnrkiMHLmdKsokZViHT9X9FsI+xiZ5QU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=QDq8U8pn5EKabRtauVDvyhmaPxRbTjkmyowftCbsAyvI/zEv4G2nPRG3s1h4FEqKMrkHWT+Pn20y+237dsX1k/66XT4v1etAHk+c7FONAyRAMkykx4hh7zd9kisZ2RKHm82RyVnFjrug/m/VajY3Mx5AkoqZKsCoT76dCpFf35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=e/jfrqx7; arc=none smtp.client-ip=77.238.179.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772376169; bh=sAfcO2tKkbAwshCSU81kjhr8s+MW7NC07javySPgZxM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=e/jfrqx7O6bs8w3rlJEEZUyO9TNeLSL3/rhs2I0NC6dp+XrWd0GW74lSgHDkw0hICnKiNRNpwcK0NbLhGneu7SAhmUc5CrCQOgFuHgu7yj3G7jujNGc7pxnJEysPZ/OO8eujni/bYaaeMS5xEr7lUPoylVo9Q+s6TRZBCYNpWE0Zc+vrs3gZ9dsXAvOVzXAiVm3J8QXNp04Lx31XDbQsp2nDglEVTSF6Ea1Ght/A1hrhode+yna6/7qL7YllzMuMNRx81R2l/aLObhjQpJTa/y4EBJmSF0tkvXz3ZAxA+6bM4zmpKlsOYswUqtaeGoOhOvOFlAm0qc2mZ+45k5K2tg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772376169; bh=AjUfd9NfXANo8ZB883fLv0J5UeDdyYj0NFlK2jfzHlO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QxQzYB9eLvEL6alzeD02UvjCpJRnq4IHog721GQRX9wbc7cOtEI8ji67FPrKv8mL8cMCenoq/uQmCCdq56lO2KqT/LhS9UkyR4/qEvo8aHftQl/v+P3yCN2TMxY+gyKFTxFjZprl70DyOOqW6iKmFDOZyp96JkpibY1rQMQVKLH6CfO9q6SlUoZGaWzPwlYEj84enG8V2gDtb9JZJs5TtwMyMcso2BTR1+VftTRa/xxYJ3sXuTClqhNiYRhfzrqm744M8Jff7pWHWGxK+UTgXIzTNnJdeekyxCWqp34DNBH5sy83+JG5QSbHUn3GrTjnZ5Ra1z7ZEFYK3jsEecbSJg==
X-YMail-OSG: j4awCKUVM1k7xU8xkhDmBkzRlIxn5sVNTM1QzVuxL2zsZBeeCxipwTqaqXaXOcH
 AaBRKOMBArRM3BkDv8bYk8vIHnKIf7HCo8zIt5Xf6es_revzHBLkM_Ux7dpHXoxAv9Ljbt_BWXu9
 zI1iVz54OP2UJp7EOED9BmF9nCAYQeBGhiXkRDwaQYnNrJq1Dd6uiRKWIT.mKWbXftOhZWgpIprD
 o5PFGEjibYUPmAGbSFyZSvSeleStpLjtmSeYKVG9nxrB2KTrqatxwzjoeOduP4MTHbN4tBn.ZY1C
 pHoE8jlwxsKZleQpaHeBw7.2LPGzD3XARDBmvslbQn7laIPiA4rfbcpOg5BQpICmdUuQxYnXFM0N
 vugexSZNMFCI28ESXO7I9Ryh93cTCPJdojDojZR_lH4o4CgqdjEJT7c2tOqq1YXk_kBQvqFXJaZD
 hguFEihWBxUzHldgbE9XS5T6QldKb71gvGYEvkn5PXdGB17mJ7sI6EbIte.bFgiZJTeYxKXp96Wb
 yxclWtgDGyxTamAgqXO33pI9Jprpyfp4PWtH_K7MNPnrlLSo_aPRwUq7MNf4AdWx4DSrs8rQ2s_7
 buzUUIPtN3M9BOY9hzbBFp_QpOv38SlgyqUKKn6xoncHCbVgs0_9TKfM38dgaltl_s0LFpUgxqyB
 t_dRmwQM8tYBzLOSqjEcGWYrRyoU95VAzfUa9dnwfb4_TJ8LJc.CxzKaiEps60FSPvW_ywO14PTM
 O_idcNgyOZxZhRh59wGFE1irIKXFGm.GjWouAXS3sXpqld1a53fWBJIfEhwcsc.63QScpzszDidp
 GhtmVxJSyXfNuF9q9HzvB8z.pEl0Jgh5wDjVgisMbVkCEKgCm4BzhzJv2FuRFLZ5BbI.MfsyUtG3
 z.trz3AGcBZX.izO.0LJAISB7pmPNr_51XD7b_H1nUCwE_xDRCJO6t40oTl8r6zbXqjSCOYXxXtO
 NmybeZPuZOAAWDumMQtn9dMCRIgNA7PychoE4iBAoQb51a7rvCfkTWAOV5whUdjAwAIoSqHESC9.
 cV2cUKdIFRIaL8uTsR_P1T_vGFUqu3of3Rj_xYhL0YTu33CfbMQF.rc6Zr4BEVUACLCg0ouKTOEy
 ZGB57CGxCvqr0MuagVbBJUkgAwfZJwxR_LanCxlZAuN_hCq4VNeDFcB9zRdS_oSyTt6G1RSP1XxH
 plyJAbo8K9uX6jKOka3773SWKTIVa15fZNb2zac3zq03XzIeT8uqZv2wwc5Ts4il56AN8TI7CrfW
 gXkQdks2qa2dY20YNLcwGndPHk5ZvAORfFwIuOBV549S8HO0kBhRgkI0KjkUK48MqybkxUsAInix
 HxpBgNehbchoFZCoeR8g6KOJISFIwxlRgDsR9ZexqcR6.SxcNZomOUWp87vOP0h2KgXD1Swt51kp
 Aupd7DgcC2ZpizCbeSXrHdrnvPlHnpaBaYAvWups6_mwjVmIbLJd7U5O4SdosOKbuAGjIOlIlxih
 sYBHDQtKcu7d3qVMOPCUxF5TIkd1wCRvvgzwgc9dB6i85wT5j2SJj5SC8mBCZsjILsJLl3T70qnQ
 EFj9xIkqfpGAV6NN8M6Pa24diHiVBj2QU0.QAOBBG9Z8k_HI3V.hxlOSxTgArtFqWf0pwE1oebBp
 yCc_qhnzlbN73rwg6MujiKUo0WUxUvhuAVcyP2nDQKs2aOHzJxW7tz1CfaehOu8YeSu4gLY1F2ge
 u8f_CoV2lL3lcN0mGRaDxOxtrNoyzxWJHxB8xhkNZboDQlPxH1ii9N9STcRubzTzreZT6dQwERvp
 UeeUdFV3jaL5.56AGJrz16Hd7UIpohOMIgjcJvrYW.zN4ABIrGY.PK8D_DkXln6aiLc4Af4soiNp
 bn9X9lgDb17PUnt86pxxjLr9PbsmynnWdToYGMMaqaIAXDH5l54Kh_chXwQGI7pgG0Nj1Rhapf.f
 5E03WnwoPAyZVpZwsZG5yqe2p1U7n7OdX4FI7z1ELJwJ_FoWsRMuqQW_SHERjpeuYpfWqn5XtyIE
 fZ5Sb0BagyRSMG.K2eQDKXtH4zf90zkxcwuCyQS1ArNrXiKhHe_Hm2n7E_6MDNoFeBdYX4NVQdlk
 zQI3sOLbiNjNrtqhoIDT7Blpu7p6T1ewPAnRA5AZt4j0jNwfWCbT9tKxDOuC2vacfNL1onsft9r7
 _QxmgSayAYlTZVbaPxZmz7NY0U0Sfm71aFA5JffaNk4xPISfuTToTNpF8TDKs1mQcXoXV1RAS7ea
 cLt5CNGAyNeNOWfMzNATyNWrXJJPTNVV9HrsQqZ8v10jLNYN6iR0XNwiEVn0-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 6f99c639-e7de-4a52-ac68-83ad1e8f14bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Mar 2026 14:42:49 +0000
Received: by hermes--production-ir2-bbcfb4457-24w5t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14cab0c90c40f6bb7347a93a7e086354;
          Sun, 01 Mar 2026 14:32:40 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH net-next v1] NFC: s3fwrn5: Replace strcpy() with strscpy()
Date: Sun,  1 Mar 2026 15:32:37 +0100
Message-ID: <20260301143237.217397-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260301143237.217397-1-tomasz.unger.ref@yahoo.pl>
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
	TAGGED_FROM(0.00)[bounces-262403-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15EE31D03F5
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since fw_info->fw_name is an array, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

This is a defensive cleanup replacing the deprecated strcpy()
with the preferred strscpy().

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make M=drivers/nfc/s3fwrn5/: compiled successfully, 0 errors, 0 warnings
- Module loaded successfully in QEMU (x86_64) with buildroot:
  modprobe s3fwrn5 - no errors, confirmed via lsmod

 drivers/nfc/s3fwrn5/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 64d61b2a715a..9145deec7f6c 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -454,7 +454,7 @@ void s3fwrn5_fw_init(struct s3fwrn5_fw_info *fw_info, const char *fw_name)
 	fw_info->parity = 0x00;
 	fw_info->rsp = NULL;
 	fw_info->fw.fw = NULL;
-	strcpy(fw_info->fw_name, fw_name);
+	strscpy(fw_info->fw_name, fw_name);
 	init_completion(&fw_info->completion);
 }
 
-- 
2.53.0


