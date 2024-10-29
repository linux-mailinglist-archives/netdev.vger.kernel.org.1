Return-Path: <netdev+bounces-140145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1C9B55D8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC6F1C208AF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C3209F4B;
	Tue, 29 Oct 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="Ro6GcXx/"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-21.consmr.mail.sg3.yahoo.com (sonic311-21.consmr.mail.sg3.yahoo.com [106.10.244.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477120606E
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241433; cv=none; b=PYBdgi/oFqXBg9SyFp87NpNp7608cBjN0XxTdrzHlcYy0UAJgAu3/1weksEwYfgAn8Cz8AoPzVhPIwr+f5j6uuIQdACE6nn++f3yyNAeru6arerky6gp3pGCLsbWirONUO4DLKuBFGb1tVbANrhEU1vy+ncUJ3S3itna11CtlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241433; c=relaxed/simple;
	bh=w7HW4iNMeHO932LTBNDZgLJxyPb5FGS1JRxdU0k+BxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=TOaaIOnbq4C//gBaWAtdLUKRAm0S3KW9y4GeYMiIo1yHxwkV7XWgm8b5YdKjfqkSSaCHHzqDr5IqUDVMVRPo1g6YPZOGm2arW2PpOJeM651gWtBF+OEC1mnSWgS45rdQfYZ7HgcvWVcsO5Hq5/QI0qvAywGR8+HGWks7oVAlOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=Ro6GcXx/; arc=none smtp.client-ip=106.10.244.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1730241429; bh=CANO7+oMA8nkkb8BNVFqkHt5bjmgbHDSwStgzlrk0qQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Ro6GcXx/2XbHUXDkzSObKdFfUkqh6MbsGvhrVTPyXLNEeI5joNUA64uKUAQlzA3/wVEElfF85R+4U+5sBqCaJR4bsLgpkWN7B4HMn2v57Gc5tXqyqiV98tfg9P3fanbcQy0zZ9Xfcs8HfwNmO2WLYlb7pwew3oGjrzR9OLdPEfspVfLdNmnuKrMly4oiTLYkxgbIP0VzwaChKgFnlgOogeX1AyEs8sf4GfKJ6odFq0JEiwXBnN8Dv/lSaKmv6IJ6jw9tMfqIYauvcaFaduij345OSgf53Rlo60PRarVU5ErHsPcHjO1rXyuKEp2uNSzpD0b/Sh/nMGh6DERVt+2qow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730241429; bh=3SbcNv2gRCk6nEdfbmtRs9SDajxGzD5ezxbqg4fELyb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=a3BkdiFI8RAALNlKG3H+/MpwwjSar23T3FMClw0JhHEngCWNFUJPMWC8erdKeMmU323CmePogv32+OKmn5ePnOtiE7D4sLezihDwKzZpuE/DJKO/Ix2u1RXffudPtilFFqJ6xKoWgWDiNQkh1cklYXpher4mj0Nu0dXCsRQqeHFPYaSoO7xw8MKdnSekTJEkoskoARbS7VusVGJRmSobFLcnO/vMRoZT39cHB8bMQnmyVtHAQdSRaIDj9s8HOor1/w9vJcpNrqg5j/AGqUCbwdnxv4fgZduhXKSHH6UFRVlHqME/YZJleSnTn21gsYZkoFs7jgN+FXK4AGR3RXpogA==
X-YMail-OSG: beuo.ywVM1k0CI2LLdS3x3SqFoCdAA_DHi6NaiQwY6DjMjaN2ZQZ7EulSZJ13QP
 0c2X.P_rbsNT8oB4Fjw5tT9CtG8uEMFZziucXI.9KRexKCZGY.GbdnDGzXmTgQpzkP_fjH763_4M
 bdr42fleEt276KxW9NpJ6IRrpKD5JIOTXn6bU_NCSSC__nVm4PPHGEBQo_DgYNJgXmBljQW5tSd.
 n0pWJJMiayazTrJIMy0g.g_G7r2PWwMENO4XmDkMgvc_V1nj8NIrJQ1YHg6zKWevo.MFQuysypJi
 CmSXAYdoLypv59x81fya6gnbOq0fbmOFIj9EmDUJ4.MdgDv09s0NBUTS_D4NY9mg3il1TWraI.89
 i5uZV1ONnj_I4EiFdN75ArzPt6jYZNQ7peaeOUS07dtpE1tce5uRvFrw1j01gklbp_lE6Q1H.VU3
 kGCggayFkpmnkXyygmI1LpRGz14wocu1HZ4JCiTlEU167jgio1th0Qeov1WzeIMZPGcE9HSzvNF_
 4vpjee0Uxf35KqnIBlFcoBaG__FlOdnKliyhVUbgOx3dbkvjl.sFuTUdM.nzBW1VFXE4mkHBhsC6
 5wht328csCwDRpRV8FkY7CmjhLTaE8CgrF8kq6ZWat6DPITTgnKKexwn8uzHS61dnLHUP4Pp71eO
 neW6pCg3mg9qRnld20hgXH1.7bJGhT..d41YznoYTWMALxys1rDSyPZ.dJcAgbK6RGS7MAadU51S
 B.Fy2vaKVFx8WxO2imxj1BGTlG2yDb48M7p3hskAMdzlLXce4OOntVaworq.jasfMUp16Dob5eVY
 JwoeMSSqZP581NQ2UYa8IMko49d.LGgFm3D6rQqsolEbSceKH4hZZVaU3GSsNmSDYOZQD2ajxbNl
 7L7Txc254ktCgTtzWkVoaczoRUXSiGjSpZbXHt9CWoKXtJCeJO.9juvnBtbHkBxH41ugLQ3VSDbF
 4F8boSpACF90ZOMnBRW7Rc.1lqCWDCq5aKbtR3ez9sTcDw9spPB4lYIumQQiKH57qhgMnS3Uq9.T
 wDUz.YbmnXqN37BlLLbOpxXPHH4PhCFIJA4E5XoOibbh55uFDh7UoUONLdtsCA2286aUJrR5UOHU
 avcwUglDr0vOP5NuSiJI51pEo5yZW6QJb8bewBXc50YwyssEHTreZoZnfJDOGsp5tB6AecldDWuP
 ppasrwaKLpZsZnUpY8rOupcLWqxhG7UZANENZATckmnREBJePFk.HYq6q6.Dl9Y02L3iUuTSJE4B
 TOz8nBn8bV1K5lluGGKxTcax5rNxL4kK6LlmWdYA1Idixouva6QE6kYfjLQkU7P3OyotnB_eD2yC
 4ViLNStmm5.yefa7ZXG2BzLe68drqzxkoYJZleTwjesOtdrKzMSBxD7NYwHAAaYcSjyvayl3cufw
 CZUXXKbckbFe9UpnEt1mWlReqQR6oF2bxtP5vqsfcS5Gl0IB4PZb0dsaMds9LGsUVm4bvQQBhvE.
 9msKSCxoeX7_q1YPhdGjjDQF1RNK9qvHGjcpEacK623fyAf2U7LpVeFgOa2cgHF3xOjFggEO8eV3
 oQpLcQVGHR07e5cyU0UvZ2TR5_N8GEwMPW8.6Q0m7hTL3m.R4poM0l3MZ2X6onPzStR2trVd.JdT
 j4EG_sqmMDL2LBpkrlkG02Hzcg4spzg693hHWkuH0F0s0tXJ8dDaZ8DNiEQDj4nmgp4DCI8IE3Zd
 ehwk874BIrh9EAFXiIj43i0yygVFGnIU6mmVFz85nuZrW7o1XEZbhBc65tcw8C3msjQUIAiWbSiF
 wlKPDhnpjXT8xN_w4UcMc4MpykF2IVvtB.GRdSRk7KE3fK80WrJG2a4zxJ9DbaD8TgfHNnznNDPW
 Yere2c78LCVDIuLZ.Flh2AtTe5xXzfFCpdBHgWVI_IlOkKCEO_TWJdY68a9fqjAh5yM.s_H53IDo
 3eEhqxV8L3Qlid660u_mh_DP6COUv_.SuKqNgqhvqSNutNANJcJIuJEkiY6Ztidguyi2zjgMovhi
 svvYhLxh6QruLCJ8qwxdpOmyxg_lbvCIiiP7egXDRKnMH9utM4gPYuyIvCWxs4CkQ2.lOdqx6nqI
 MEMwZx7VVar_op.4c7IMderF7j5joLavR1B908lNPtWMUTi61S8xPltQzAIb3pVZyzUsMk6uzTtk
 BkMrjV.ToVR7bOCBUYeGmH_M4uOqMYdFtVcT35LqoaqIAc2ef6Nau9KyJuQC4C4NQI3QGOdpPwCG
 Lx_p7NHNlY.8OcUMXgrQAgnuYsL1oPe24i8aqY1k-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 320644b0-bd48-41df-87f6-9d2cb6f7bc86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.sg3.yahoo.com with HTTP; Tue, 29 Oct 2024 22:37:09 +0000
Received: by hermes--production-sg3-5b7954b588-2czcw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 30c7e69c8517e1fdffb1648896dbbb2f;
          Tue, 29 Oct 2024 22:16:48 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: krzk@kernel.org
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: s3fwrn5: Prefer strscpy() over strcpy()
Date: Wed, 30 Oct 2024 03:46:34 +0530
Message-ID: <20241029221641.15726-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241029221641.15726-1-abdul.rahim.ref@myyahoo.com>

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors [1]

this fixes checkpatch warning:
	WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/nfc/s3fwrn5/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index c20fdbac51c5..85fa84d93883 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -469,7 +469,7 @@ void s3fwrn5_fw_init(struct s3fwrn5_fw_info *fw_info, const char *fw_name)
 	fw_info->parity = 0x00;
 	fw_info->rsp = NULL;
 	fw_info->fw.fw = NULL;
-	strcpy(fw_info->fw_name, fw_name);
+	strscpy(fw_info->fw_name, fw_name);
 	init_completion(&fw_info->completion);
 }
 
-- 
2.46.0


