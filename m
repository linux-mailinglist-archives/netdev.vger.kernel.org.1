Return-Path: <netdev+bounces-246779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6459CF1232
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B29300D433
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FC254B18;
	Sun,  4 Jan 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DjHWiaSX"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4B2550D7
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543924; cv=none; b=SyGFXIHXSOboOg5u3v04MRjhE0wagwevmxhoyo/JaOUA56gaEItmw4AMsIji3VIqAp19tzFXILtqk06Ux11zvf7XQx+jPrFb2GGRjTacAvLpHnH0Ah9ag0/SfvKelD1qKfjVN0RFNLVRKfEqSetnCdxZEMBMOX64GEpYuwtILg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543924; c=relaxed/simple;
	bh=AmgSimxVD/vOsQMk0Uo8iTy+UgGjDrEb40VunIKC+7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=HyMWC0YHMNNZSuDr1erMWoNUWybYfy3fKz2/wpuGNuayhC5jp04CU8vQElzsdrOeJQmIOyIekcf/NoUldv+C/Y0bRAN0dxC5tlZcPTGcgk2f+fPSsLnZrMVWyHnUxT2t5Q71PweU8Z8WUJa+1t9In2wi1VXD6YRjm4qynE1FwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DjHWiaSX; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767543921; bh=AmuOqubs3NdPNaUd/yN3XVtFUZ9a66kcV51BQbDaoT8=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=DjHWiaSXbAa9kQQrYVl6BPnftvkNdaRNCn6EYlp1QN8J5k+z4MBo1XFM0SwnPVBGf+x4FSgqWPPNYsoURkQAFUx0IwpkKaLYyd7dv5luSmVxWqwlI0/mf8NWktaAXMOHEWJcKIGV2El0ZAf6vmELX4DSuP4j0xnZIUbXFiYPaKBWDQhZARq8EEHQs7GVhjQLNDE8OQM2cuWgB8MG9TsRMnnKr7Fl8hyQ1o9bC12xKbd3cTnJPYDy7PhpwSD5D/8dXnzAsPql/9G2RjdzQ6r9VtDWPTD/vorrI3ZtfaKVgsmjPR58OmJy4us/19Dkuh6qrGe+Rd9puvI3RXUj8EkwIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767543921; bh=LYkCPPo9XmvsU5In/R7fODVSEf2iSUJD7JS2Eze4SjV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XSOqh4VG+dGDfM6lx0eHKip8ocWwSE9tBxVHSwgDd4mNXbYFCl6Jp/SL7RxBsqtiyx6tJW4Zb1ueaPjEU+z2ceNpyui7Mcung/DazmlfzSM1Ws+YoKF4z1ajtRLBd4I5K1ulBooZo2QkWdzo+pM4tJXkcrmXcn6P3LSDsuqg7tbtnslz0DTkJHmGUZE87LKd1KHJ0cxYZuG9htMjOiihsrXJoD9S5z45C0ZpnEstUFDB2tt33txkv5n5oUG99qZbX+ggIVlMNA1571CcqANdguzpKFAxWcVoCHypgKM+ATjOUYM79Lpzs/mXOMEroQ0dRpP4212ADaYjNlRPTbAXAA==
X-YMail-OSG: 6QVRlAEVM1kXLs7HaCp6dyLztoPmYhOqWUAUn.9CUPBhJhCM1ETFxOTRnFS2n5I
 _VyAoILhfT5yt.L9M6nlGvW13iXtUrEJIW.pFdteVpv70dA21of7eQhcReraxKzHyGKQkcMApMYU
 fN1dGIvMMEuDJC9_.saxnbdvjAeNbf3Do6AUz5kM8DeESwoYp794W7bEtEEbbmGDX9FRD3hOSKnT
 UL7I7_fQiIFwXPhBfQ_K5U4j.KQaqXnKdHhK187dzy9Xp3ixwbLcmYOEMeTmM.PWUvjEubddrbLH
 RnAVFHkZFjL9OiL1YF0exP_HnkvCTnHEbovIZOEMSL5i5ig2qXkKb31kxbxEQMXCIgXfAoijpZq1
 qz7Rgac4qKZ7iKk8yKc.NP4UKQjk8HKk0cEAOIfcnIgY9iLFmwMg1owPyIu0S_6tg9lZbabS98Lx
 .RlSuhBhtW5tgkzHwbn9NTSg5nTvBC8euEH1EpxpXhu8oeEvcJ65w0iwAmsI39z6fAZ5Am1sZUC7
 d5hWPrNaoNhU99C4zAy2Yyxg3MLAJLquYhV5J3UDBbiERaVX6PfVOqu08vR1pU68JFCiIhME2rzh
 26803qrQvnm5rf.0pVQmMcub5Zozce6OYxIOMVdooJVDarwRGg9SQq94Q2.8H4ditmOsQQp2.ilx
 I8UiKl6NgV8Axpks1w1qRs0QUVIuYdREfWrmD8jtQaLzXfiseJwfP7vAVyCCemWwURErOBPq8VNK
 gsj8j_4YvaDuOZFz8Ta.lh5dZWHSgq_V_YB97jChYTbpeORyHZSoNKxjQE0TdjuBgp.RUju5OZ4g
 yJkSx87SQDT7QiRcNZMh2VEbF_zrRoGV4F4oGi8VKzmv.UB8UhXeXpbIbDG.Eb3YjYH0DdzG1ZGM
 viYvTuPhb6GR55c.6Qhpx3kmC9zpRmduuQPOJ6IDAc.3U9vqri4sWC51WlkqCkcMsk0sDal1aX3H
 1Hmqnkvn4RwXz42uRYRBtYVI6V3MwwYCkCpqi67h4y5QGd0yV6g7QvakgE.b8aTkittsEWklbRZj
 BeVIVKu0YAcl40oCKiMoKVXCdt5Xv6xkM74CwwLTo0N4jaRo5.DX7kWOnIExAzifODi8im.n58ON
 GGU2DJCDHpovjFxfZv3lecqSwIrgU.1JpVKpH_3MGAvzRzkjJr1KX9HfVuIv0Tny2PTXY4pLdvhx
 oSQTprlnrmvW8kdbZV.4CuzAgSpKy1.XmkpIx5yZwOqWbTcT75ePRgtQDB5myyyJe66EqDK1Uk_i
 uGo_WkArrVyYOJkJzwFqELn60xBOa.W2C.uknMlGK.89wTHKlM5AmQSjB8HuiQPLNuLBKfDXarGE
 HDQJy0Exa80lX_u_FfApUUFRreoIn98j3yEB1gLyzyJQk0UIHmcw0tYeQxMCZIfL6V.v1cnvAxBJ
 HrO9787nyucz0_JStHHRXYz4xbzZsw9Bzs7n2oXGvEmYKOHW9qH0ISISkIik1rbIEVNKHEc7bPzn
 XLmJPJEIlxKqqfyqf9gCx3H0bcY9RNMVJAJp2BcLUJ_FEGSUSf7j2qhpx4XV97QXvhrcEDisxjPL
 jvXBjnGUdWbLzvIMXQsIRPnC.GpFO1h1YFVDOpVlRpbPAGQEn6ihYySSB2FCAlhOXBP6yFrthq8p
 7nf289fsocJ_sLt9PPo8eGtcTgA6iG9vOjkf2vizE0fjq2Mx2R_68NtmIj9Sogron4i0qihNFauG
 Fsur10v.czWSfmo9IM7AvrFIGB4..OKX7Ny50pUC5tcukwVPMCRspbqRca6ekV4OMtbur8ssgOtC
 OQAa0H2DgY4udzobeCYdTmiFEvjY_OdagtTaEG.rAMWKgSHRWUy1Pwmnlk1xy1yyOBFf6.vzM8GZ
 sZxBIPh8bGFRhYmqyGQeL2_AKJuWbzdkvtXMP76f4dxu8V2Z0qfvn0VSAyfznUyg_BX8OzG6ZgVm
 PsMlN3F7aaK9hlJTYTDeiBZ5eV2fOol7PGSvioUyLDcBoTVX40FLwcxHJY8LT5nN3jUI4jXmQD_V
 fddTsggDLnc98XOGtyAYLbSWkt3WmcmhcfOloYXb48L_Wh33xHSdshrsDOtIRLscyb6M00KGhkzP
 haw86fBr55GsschcfTjp23clsEmxl7_ApTIXQC1wXL3pUemza0IsmOLeJFqFB8MJoqef7qyn.9WS
 j3ErnReHCEiWnZIhKeZnMqW3vJl7Ho3FITPs5v.sQnMy5D9Xqj9rlEXVKwdWV6DN05JTz2Mbn6Eg
 U6H54ViLkfjFPT_100pjcvd8u2hpKqVR4Do_rVGluWYXtFVgQSVdjUTRMErv11yGLOKlU8D_kXSI
 iwIy7JUDSmtgl75bK2KpNWCumxXA7
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f2f00ba2-0d2f-41e0-943a-251fd8dea252
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 4 Jan 2026 16:25:21 +0000
Received: by hermes--production-ir2-7679c5bc-npsgm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dffd117603d14ac5a384a6888b70c3fd;
          Sun, 04 Jan 2026 15:54:56 +0000 (UTC)
Message-ID: <1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
Date: Sun, 4 Jan 2026 16:54:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from
 rx_packets
To: Jakub Kicinski <kuba@kernel.org>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
 <20260104073101.2b3a0baa@kernel.org>
Content-Language: pl
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260104073101.2b3a0baa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for 
RTL8365MB-VC")

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2180,8 +2180,7 @@ static void rtl8365mb_stats_update(struc

  	stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
  			    cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-			    cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-			    cnt[RTL8365MB_MIB_ifOutDiscards];
+			    cnt[RTL8365MB_MIB_ifInBroadcastPkts];

  	stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
  			    cnt[RTL8365MB_MIB_ifOutMulticastPkts] +


