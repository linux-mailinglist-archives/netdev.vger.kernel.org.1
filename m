Return-Path: <netdev+bounces-262395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WImyAng0pGnwaQUAu9opvQ
	(envelope-from <netdev+bounces-262395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:43:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B781CFAAB
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DFE30156FC
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05C2D97BA;
	Sun,  1 Mar 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="mf8783d+"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84E1FC101
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772369007; cv=none; b=l5IVLGb2fbQkpbuZJP02OjS0g33Ic4LIMtcKS6Txhh57Aealrn8q19y0QHXlmInV0lJaOorV86+oKEwlbpfCdbIoElo35FLMDVsvrlOEe0Gq427h1INywr4IwVAjzlGTK7btOhR6iBqJB76HEJciGRHUDKl0rH9MWl06CgpkgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772369007; c=relaxed/simple;
	bh=0n9CQEnb8/1swuDU2igeiPoDmdNypCeegoMYWhLBwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=QVMe9Txqq5c145MEaQ3kUGDTAJGLKm5xh3FfywKECqBVdcKH2nQCJ059/WirhN1PyY0snbTw0AfDi0dYzEXAXIuo/TBT0v8rP/hRX0XqUQvf1rvze/peTa2x4k/fqZovt5xc9MouAey06hKZd7IyWn884zD1o+AJWRR6GXOYsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=mf8783d+; arc=none smtp.client-ip=77.238.179.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772369004; bh=IQJlk8l41h57Oau1XI+KCQR7I6Tu4lnhPIT0mluCmjY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=mf8783d+Cw0j3oJ+NJGZQpY94g3jXpALCtgZ3J4nKWBxeupITiS132VRdymULh569QicdlypX5WIYZ98qg11ebsY+4zkBfasiIqJbDK/rHO+W5BjRszU7s2q6NrLYYHPvau4pLMlGmKRpmsKCFxJhoLGJow63cZo8yHqR5TKJl8BJeYme9SAnDx25inEYv5F3PEzbSFjn54jbmqsbWHflDN3FEHb5jZgxgETCtaXuNmK9OS90FkUO4wyhFJwedoYu/jLNf1nllzxyxuxoJJb02SJjAV6vkKnQv+GbuwSKTO5jLfT2NO3SygKLbI765+4njkrEEJ5zA2XxsyzNNN4YQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772369004; bh=DKCDPSmS6qKS9qwfJsD2i6JucQETasoL+IHFNm/juoJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gJJSV981dw1SCrM2f2sB/D458wWst4ehkLH9rIFB02o8gIOqLpIwVR2zuDrQAFV9915zmMC3lx9k00ADPAL4y/+ox+KCrPJfg+/mkLofYBc5ZvlHnPZEDXvBpWgdAd4yQoIsl/i/TiWVJcYPU9JHKJX2Lz1aLtzi0SPVik3xMxoyIjax4zidlerFkHnJcmdZmAstcW8O+Hmo6uqvqHR9g54FwqSY770o5kPnriHkQVZX7e0hkMYTQU9vtWq1ZFYK4+W2jkUwhIiy2+UpfqSFzvNGvkXeLaGah4E3u1Mdn6r+am9Jk15EaDPslNRdFpI1va3uVXo89XtCqjaFZwEH5A==
X-YMail-OSG: 5bNjWD8VM1kGNY8E0NVmMHTH5ZkY.nbNffkbzqDOQ5fFaSbWfqW6Y9aqDjXH1Qa
 ldN22FVc5LzyEQC5Wj7tu._ipG6v7vMXQnL6kp0.M4AJDKvsfd3LMVBXUajmwlY3yxfINawRFCFG
 eEvzKHi_zsOwMhDihPDhdiCfsHLSnYXnklelxR.gSfmcMda0CvWdjRb9z.HJNH7mY4cii4VvZGdW
 iY4KNntQK4ng627Rv4_fNhr5vAm4JypRJINDgJLyqz1hUvk0X9xKGtNqv7vP5z50IIOhcg84s1fG
 zZO16UZXUP1qap.P8nN9JX.Poi2kxpctFXE862G4GG.NcKBfaOtPMWbIXZEzjQ4xvEVlvHRmtHAQ
 wn4RJeXIBHB.RfssSXL8U1rd_kOdyqXsh9x.rcjvTsPn1dwB6_JfGm7BgBisYTrPgPTVeNu39Y73
 5gZoz3EqGX_MfAl4w5.gzlc0Rt6iVH2Pr_gqQ.yq3AgG4vWalsvWNINub_YcGECLWHk7KrkZpW2q
 awmmSljiZ0vs7zFpV3HXROwHzhyN8TbBOa9akwqqrSqwDYIyJkZnrHymxEGsbNO62xCgd2zdKF5a
 cYHCPyGAJ3rn5dudezJRxgoVWf9nzfSh2tojprTUX3XywMeoo6_eCx3uSx_PeL7meJbFVnn9pWLH
 atCgmowYuXzQQ20VbPohoYmZF6aizcupGWDk8ZsvyLmUMISv_hHXiEWzrHzciQtX7N3nWHaFhC.F
 MWTuJcHSJ2eKeCcPOBustBWP0mcuwI.RsLjC0XM6Qd2gax4gETgSDybBAKtNBL6fyQoMlwUC0kES
 mwpz7Fl9ynozNIK0MMfgqc9KJv5i1gpW.XBG3dWoIB7t9InP8bg7r9hPqlfi.nZY8Rh.pHQCWHE5
 621C69oYDQkPi7nkGLxUQCxBVG9tNT6Sh5C6FH6N_44Gsm5oMpzMA9ZV4Hlu9vZRiwLjE9Q.F_uH
 5IJpzZOta_oPVsf9I2YZirMkwt4.IOAoGt.WjyhXBQITTV8BNYVGwKprCAb1o2fvIz1vUmGAIHse
 d1Wjn7jSjSLgclDhXaDZQlIghTrPyzvD5pEAOOtyBUT2Hu_59X.cWK3WEIS86QNUt_LPC19yv7q.
 xL3fQ_5i8QoK4YVcBciwgwBnR90JukiRxstoLtY6bs8E4b15EhFosSfWE5RS8WMiOL5vZtSnhNZY
 72VuEnNh4I_4arc3Qvrim3fgFBdh4arJQ7Amia82t6CQAt.eTr0YKmTEXvc8nbEHjgjnWDZ2IaIs
 sSztf_dAcOviUE8x_eQb_EVMrYoWgovNnpPqZ3ZVLKQj_59k50ptFAAdstIhnvYkyV63B4yjJi2V
 G2xwe9YrzwC4x7St0Cgjpbx.NbamcKJMmUoXMzde4y5j3Zgq2xgYNOE5FWRgYLwSUgGY6yEb0HEf
 Cu6T2GE_pqDufyz5TYAsKH0oFGXpnAVno4MvoDByV.CzdCu7JQ6txBKQKy2hDUhpoCK5keVZt19n
 4xydnwLI_avc.2isyl7vDS97jhIEA.mYQibK4FjX81khaIfNIpeJAiBiFox25TgW0_D2iDXlk.Zw
 1KEVPfpjZ5khNkVX8tPgRakryw5_MWJENbKaNLedsJCN3ovkdD_rD6Y86dRvk2DCqFZr2SZjtZCu
 _t1ivogDIa2IUhbOZjuaDoNd3c1PE2fcRdJyYSewTqFXB0Y150NDGD_xmYHOt4Ntx9HjBhTOASF8
 nsSP.DTgLXrn8Qbn7toUVGAM5rT2SBAbQcBXPiAd0IciBH0cdhr1TeXaQUgzSX.Jb2oqXnQw0NFf
 c1tWBQSXZbf1B.TMIqopYQe9KJWGMMF7LFpcaoy9jmbaouOzLmLR_5dMRoqoKiPfYAvGZwLCy6nM
 kkXgkxl3aTD_K4_mZdTf46vO45MeJPH83v0NOgeMqRRoFJlduzzMLxNjwxtkIdGMgnqVAuNG6VRA
 225e_QGMGWeloL8Y3Z_O0f7dTEVjn0d5E7TRcnndYvL6aqxx22Mins04uVYZN4mu.v4XNMcBo8z1
 yFMfoxyZhnqvJrtl0EGQe2n0LZwkXvpZJwZpqaAj6DKVfioIn6vO3XjUK_4MJnNVD.2.C5S0oeEP
 yO7tLBPYf3IcZ18KhcEd2anabnY_8IGjVrmnTnwOMgCqiLPOGRWZSDaA686YkVZYjwF2zhQ4igVr
 L4RSOM9wvzMGJojmFAjccAvOGCs08Aa_pk6Ff3DLcrserjaV5fxMBIQSmKfkWjstGLte0I1bTOzW
 FN5DXHJqAD.LPARHoffckwusgFATHK.PbfBV2DIPEQCBM_dZrIqc-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: aafc7c08-e6ce-488d-9f72-c2072f5681d4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Mar 2026 12:43:24 +0000
Received: by hermes--production-ir2-bbcfb4457-d9ssk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 269077dfba5a73e3246f5329f26f66e4;
          Sun, 01 Mar 2026 12:12:57 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH net-next v4] NFC: pn544: i2c: Replace strcpy() with strscpy()
Date: Sun,  1 Mar 2026 13:12:54 +0100
Message-ID: <20260301121254.174354-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260301121254.174354-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262395-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email]
X-Rspamd-Queue-Id: 38B781CFAAB
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since phy->firmware_name is an array, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

This is a defensive cleanup. As pointed out by Jakub Kicinski
<kuba@kernel.org>, firmware_name is already bounded to
NFC_FIRMWARE_NAME_MAXSIZE via nla_strscpy() in net/nfc/netlink.c
before reaching this driver, so no actual buffer overflow is possible.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Changes since v3:
- Reworded commit message: removed "bug fix" and "buffer overflow"
  language as pointed out by Jakub Kicinski <kuba@kernel.org>;
  firmware_name is already bounded via nla_strscpy() in netlink.c
- Changed submission target from net to net-next (cleanup, not a fix)

Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make M=drivers/nfc/pn544/: compiled successfully, 0 errors, 0 warnings

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


