Return-Path: <netdev+bounces-186571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0EA9FC99
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0CD1A825CE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2620B21F;
	Mon, 28 Apr 2025 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="kotAu3yC"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB971EB194
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877368; cv=none; b=fTir090Mx8GWFRyycYZKQMECElfUedW9A51gR+Pk0Sy4eBYCaXjKGo4ojMaGTYNynXvEfsqItg+UMcbnv3rQ4/HaoFYrpV28WAiCAzSrEY90Cy7kmSGTsHuPyl4Bd4Lc4j/XyrEe3665vcCR0z6va8IXztD1q2gYGp1y9VlidxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877368; c=relaxed/simple;
	bh=UK1WR5qcbjzmeuxtiBz6g3s1ELshNbYR/RwkJXnTAIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=TzAu3k1qKmMvueB1WyvywptrYrOSIZYOR7VvZBtiCUYYl+vLPreBdQ6Fwws6YlPltZn0TYPYYSWPYRsnkwLxj5iKzofTvCXOTeN/DVITPGbEG/Ef27HbceT8rzjLrhXDLKFkROnNk8yFcSFQfXMMQ3ya0WADmomZzyieubRUa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=kotAu3yC; arc=none smtp.client-ip=98.137.66.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1745877360; bh=xrQ402hDmXhIGLMGlTkkKu4IW3npqxbKqXFrbo82aDg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=kotAu3yC9yx8BQgH6sTdzeANGRWHY+2gp96mr3T5LQsD9E3RhJYzTCXfX9LxzeR4H0+IAo5qoW1fxT4RmJ7vnye9gazaftsJW6eLrgz3D7H78GG+kogfKOxSrpYXG0YavXUFDcuTTX9Ck8T7oxM9m0LRV/E0zaA4mfv+5cuEOfxW5aulwJDdwcTMrkN3pCt3m8UMcp4DMV/eR7Z+1of1md2KrEUva2ru0SczM4MySbvec7qLzV3B2bcm2mdOgfDWnJqQeV0a2Ekvs2S1JjUIeyhBv2U+rsKknnEtRaiHkg4mMJbBD3NXXLPWvHdFuOtxH7NyBLUaniJEYL9c8soOSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745877360; bh=SQ71c0k6ZXxnkcMzwXIP2dtgjNvRhgTZQpSNGqp+Pqx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=scn8zC0ArDql71aIx15kbnqKj9sPs0Ph7p9LnQ7gzDeciRxQqP54dwM9nJZsof+grEDx4MOn0JsBJoVW749ZZ6pgIgkOD8A9V7+leBROJT8NFs63E1/yRSbDr4J2AZFIPks/1rcueFlxDfjw0d1JsHewrQcDeKqU5mqk+/bqXQGHkG9+LA2Uo9wpcCYmFMFKXFqTyrqUOVHW9uUXuZR1rnPCPVKqes/JzhWshR/a1tQvGmU45/Tgwqpbl3VPqUNyVPIAJjpfFBdsnnSBRfIMMJO4hhpmgzsQYDtzfXu4c8N/5tmPd9eJ7cCSbjEyvgyaOQB7i+iS1Y6hEg8DWE4vYw==
X-YMail-OSG: da.KyFcVM1kcBABO2iZGVhpDe4DL_sa2kRmyQuRrac3YW8ma_1VacHJbMsQmCKs
 fKItt_M5Gw2bwTon3xnjlNTOwSCN3qcr.xC0uhe6JOM2gaYDEWNaV0XxQjI7uNHxmP0QcGeGlDEa
 RPdQBajEEQRrfHThAg0NEy7gCYQWO893qj3ihu4LJonvp6cbpj74SRcekOpxlx24pLCL9OfyK3uW
 NXRe3MhBMhkiYPDIDLPZkaLXKqFXh_LP0_hOdnVjcdHtaua9JyB4JYjSlgDuUlg8BRhcp1lTEtW4
 kao4xICR20wQfEzMMiJVqckUV0LvSmBy9.20ah9z4J9QnThCq.2m7BNT5YER_RQ9gzjKXxKPpHTg
 3VoMxVP605mXXezQgOmprJXimQX0PgfHcXYRrXf7gAIqKCoeNNxDWLnhxpQlQ.v0wzoaJx5UjNla
 0ok9wAFotIfqw.7jp6XlnEMnxE3Wj9hEOWqgHhxNQMOvJy4Loas02ewWSOB0nEUs6p9l2uuGWoTl
 kTQ3racmOEWSECjqHti0QStBvSx_6hXyS9twkEke82TaCtqWLLoYpQKdihtNml0mQeBpv2n92lov
 neyNGORVp0Xm0MmaBQbEFl93mNNntuJt2Hul3X.CglDdGFqfgq0dUq4qhgiv5Tsqbw5rrGhI9c7J
 pe.bZlWg1jjGU9BvS_5CMy8H1J.Mk1Ws7VS4RHVCP11xYf1fJRTGeG5JhXhJdto4UysPamhQJW_K
 BhBB6I92dJ1VvEUai77HqFXz7B_5Eq4kIG2iB3s5aG2_lRFQCIDRkPat0Ag0pvgkByChC5Irxs1b
 yTtl.RMliwrjk7410pHkiCehI5bhYm8.sNdzolTdCV4Cgk4rSw88Z6If.H8iyuuagndcoLZE.H7S
 HAmdu0yj4s8gHiYe9l5e2.hCnYq6Oj7vSQjlZqfOb3yHh5HU5WNI9pSMHsus41tJO1S4_TqnTuyK
 nOO688Ooxtqlz6UXIHhVKqOXBDnBF8TIHlSOfav81Muptk6phdXuKtk6tn1fhyVi8erlRPvRlGCj
 dIE9t9FxAV_gRltH0_uM8Qa8QC4tyuNDv2OjjNjWEhVuf4_BF3BKbRCg0dX2tl..6QZiA.feg09S
 594xI0X.rrz59olAAF4mS8Ozso5YjLFlJpPsZjzMdlVU7JSpYL.6uuC_.HZN2tkCP07VFqIt5gHO
 MrJ0zj4RU5Mk8JG9PJBWJOaVsEhLgENHuKWIvOVDWZNoBs3Ff_leUr6yXOAmny52Yy6V32lqRjjX
 b5pBO993ght6oNM9TMH57v6mWUoW9usrD9kSIuIiQHr663Fp6yafH_N9ytIaMpXEUafjmf7b0AI9
 1sPjqNcDdejRBb5XTRYWC68gWsj0OwZiLt2pP8vADQfvjmOP1AQQnOYMeges2npJvqoD0s2yzyeb
 tZj0fDUjd51gGsKThS6p4C8NS0zFl6TSEc5R1.NogIlMgGrpZ.a6ZI8s6quLj4ad8OykL6s9UrJ6
 emZ8HNqAK5ZhOibQGLNaWwzN82ZUUpZE.PsMWozFX_juZ.yJUOkRskJ2PzEtAXQZpsjriWq7j2aM
 pdhW74e0WZvKAv1Blg5MnUeQrYzDcfqVmw44zXcI5NSbXH2QT5je0sJ4SycZekJjdurXHmOSeDI4
 6K3A7TEH5xLAraaj4dKUvAIWhNLQK6VIL5UMtRJ42ygl_FVqtTkfhbEY0j.909OT5h0n5eEbCh8J
 Ov9D_uNvkpUgEW05taCHXJZtFsZFukFnqYokJkFcIUCJc16gdHajQ9JDRRzkr6FTg_3DKNlbJoZC
 kDmtOq3RyR8jDyWjvqBjhihUhWXhf4Eu4OATQ2IqTm7J9aFxTFsbobCRQJyYmdLygV_EDxylxRRu
 JjQMJ0pgNbil_P._ascuijCJQPMnrwYx7zessarOf.MFMACZ6igPHG1oRMvqe5CunXChGWxq9D_.
 mS_voqM12R7w.GL3fZVqWd3HVuznn9qQjf3bhvtfQVKsYVN7920gNTc5JdDnl3CdArz3P9H5hC2A
 UX6VaXcMjeQqu3zBPwauZCubrxeZCVCv3UpP8il0hBPcDjddc1iNvTfGUI6lRFmgQh0wmepgFY20
 oJCjDcE9yazJ4.myF4PHAj4gSQD_kihGtMgTcAa5Xvp1Vvn252qy_ckxIomV.Syqkewt1iWlq8eq
 w3eTSOKmvSVMrSaaDaFsgT69YtlgHeZTbIvgUQgmQYAh7c5NqZ3N6YXyQv2s2ca2yf_MKK92A8q1
 uWDXJq564yNg9wNey9wsG5ujMcemwA9IOpRST3cVi.7S_cI0NHvZ34MYC6ZkSFSzm6g--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 23f2c882-767b-4d23-a227-ed68ecb7fbb1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 28 Apr 2025 21:56:00 +0000
Received: by hermes--production-ir2-858bd4ff7b-mfhj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4064065ebd14d1b300d04e09e97902b5;
          Mon, 28 Apr 2025 21:55:55 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Ruben Wauters <rubenru09@aol.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] tools: ynl: fix typo in info string
Date: Mon, 28 Apr 2025 22:51:09 +0100
Message-ID: <20250428215541.6029-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250428215541.6029-1-rubenru09.ref@aol.com>

replaces formmated with formatted
also corrects grammar by replacing a with an, and capitalises RST

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 6c56d0d726b4..0cb6348e28d3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -392,7 +392,7 @@ def parse_arguments() -> argparse.Namespace:
 
 
 def parse_yaml_file(filename: str) -> str:
-    """Transform the YAML specified by filename into a rst-formmated string"""
+    """Transform the YAML specified by filename into an RST-formatted string"""
     with open(filename, "r", encoding="utf-8") as spec_file:
         yaml_data = yaml.safe_load(spec_file)
         content = parse_yaml(yaml_data)
-- 
2.48.1


