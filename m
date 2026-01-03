Return-Path: <netdev+bounces-246679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5473CF050C
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F04F3009437
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393F21FF38;
	Sat,  3 Jan 2026 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i61FtrGO"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CE1E89C
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469092; cv=none; b=W2fICsc4RCG7aqUawWnSkStiTmMV7QJYmNUIetOr43z2d6ITATdGEPGd3uyaXkp2LjUh094F5ev7x4K5lhU+QWjpmgwYlbnHc4xTQHwsajue/X2yjvA7Ft1JsyFaIFf+oto8du1uTG5Bt4XB57vNduTkKjXXxuzeu16/BqCfCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469092; c=relaxed/simple;
	bh=DQlVojBIWBDVQ/uKUVKkpjNMbo3nIAL5iHFqQAf7rX8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ez7kjSXZLD7tz6XMpiRLHMv8UsA8Qm46VQwReR3fnH8kyuN2tAonEY2X0iH03xexGpTHxWINkL1L0oj8jDd5d+7JSpi5cNWXS2SCQEbiqqRQp60bp+8417URpzodGbvWe457rX9ow7bhzmlI3tkEId7C0z0rrWThf2lCpGFjkvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i61FtrGO; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767469090; bh=DQlVojBIWBDVQ/uKUVKkpjNMbo3nIAL5iHFqQAf7rX8=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=i61FtrGOhfVnnH9gAw2ZOIEw82M6RM9sqy+THBsah0mGF/ZBmJWff9hRE8dPtciFEtv1Tq6L2JLzkIwfGlYHNqfRLl3fOWqbihoG5gn2PmCiRN4U5W0islMdt2mfVylcQ6IhZUWVAe8Y+TCOuJsyVXByB+Bt7MeNj+1PBySPr8iS5qpR5NOkC0ND5xrTirx9gSg814yYOgnGQmjuZEHuLy8l37rpZcCO0HH39HkN9P/Q/eEm/E5qQ43uDAlZByyosp+T56kuz27KU78fS2/uGsiaU/GY3aA1D/V5aDWYWLG0tQeAhP7uepA1JcN4uqVD0J28osEY2NTCGaK6RZRQHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767469090; bh=n4ogjYTrLRqjd6ZvsiWqL2raLfxRAkDThpKIZ4peRZ2=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Dfgk2g6CL+JbXRjrd9K6xk0mjLEzwUqYN/ptCT86XEfmN0wNokX0W16TdQRyrVRx9PZpLk6kA3cZURhBZQ7YSt7f20QZZ18Kbinl6MnKqOdk/8KK7hUSwTqPy2yphRDrZcE2Av6Vi3bLay3SpEaAtnVRGJbd8J8d16hr9W22sbasQ1V+mlhprPnSXCPvtFoYZT5nfvXFVitUzz/1YD0jHdYDtIpmp135mnl5p0WIZExlLSv20u3x/cT1LCLgyikmdpa1zfFOWmQ8AkN7hHbSgJ4290GfgOduHYlpG9cQ9Ph2ebPV+QE+yqBIMhNnxiGLZe84DMScMcC3D57f+SMqrg==
X-YMail-OSG: JxS9oCEVM1k_I1nAIdgurLSb9cQOFv9WdrmM4FGKlwlNr3F5gCxhh6qbKPhrkrX
 3MCe_DWC29lwCpdncvQL8dmEyEXZDehmUyONPopZ_EBRVt3_A7IOeXyBQSPOnsYa1gtSL0fL8EI2
 n0TvEhOaTWB5Sr9wpIALthoJB1h8luDbmkOkXmNtswpVzawXVq3PHsjD0eWoo11FUd4ZIlO0.iFI
 nx5Kpr90COKaYtTkU8c9O0al747pt3HdfFAP4CKEo9epjBqKBDcYxDDujUHTf868GCKYLKLpjkgc
 bz49AdZ2mZ71NbSJniO85q0LrvcEdhTr1g5o3YGKnMxilfpg4U71UpKu0DjWEDz0qVx0kAObq7z5
 NOECRBvHGnyzxkeIRMOpQda0nSrC4NibWq8fgF.TRfe7YYS2J_UOr7jKBZHa8HkSKmfenh3uu5qx
 dP35ZUPtrLeHVBgq9UQ8RZXeagi7Y6ykEgR5IQNnDg95VGrKxU8yWFu1oeEwCDn0ODBt_tXEPJRg
 DxcGvg79UXCipHQo.chAd4jdpLXKhSryxTN8kGi4RfkEvPavBaZJBxT5NSeJRibtOO8wtHxpsJLP
 CuwmwJh8Ki2kf4KlTtDHLIWe68At6DnvQc38d3vPaUC7hYaZMqKWAHd2HwlUL12i9ZmTKdy8Bb0G
 X2Mk23w2eYcgzPpJTI2iyhD_HVFqslK1Gu_HKFDVoQ857U0KOnbuFpFFiJFw4xBVdxvCB7Q5eggD
 ZIuFef6Cr2wgSi4Xcgk.qvHI88D40ArKjPbEi7eTeuXh.VhiucrfSZ6BvVjphht5wQkZTZIjm_Uv
 PVBf50wQMWfV9hHJyov9FZ0zWVCAVy6Cu6pq5BVq1nxLuR7Aoueo26BuWI2zUxkjWRlGRA9lKT7m
 O8RInwoj1fPZQIfQUtLK1HSLELpnyR4amD2lmTTllGpE2R1BW8.csj1wZ1g0Owfx.m8j8BJWw2Mi
 zi_jqnR9_3dB0IPqdavKermQTFyYCxGFziis8uzgDhaDMBqltLGZBFUaD7L.HS4vgvPNdpEfIDJB
 fg6XiYODyKIrmSszaKiyuFMQnelqJpMVouazGF5LUOCx4Gy3I5i_u4gWT7.svFGFFXGitDe6QTZ3
 DLWaeoG27Qn8OeSHPwUm57SPzu.yMuQSWkmTByrMsiZ54d6x5sJXDnSX_lErrCp5laIj5CxHJiPB
 jmlqjyYpsoqypP9xjvT1iuq7QrXoXSOnftkcLclTV6LXA483bCx8BLK_fN.MXY9qWZtLB5e92l3y
 4uaIho.LPdMFUaw9ZHpp2rzeJtuPOa0lfjap_VH2cqL4CdmxGA.N9YRkyMBYgoTNALDnnP2dSJNj
 6EQtjJc1xVLYq_NqsQqO_vSvqdfjxJvP93eHNwzuUraNiPRMqRw6CxNyTmo2ZpG9ZXX0ZadfoZp.
 JaxN0UrPTiEvChHhF_Y9sv2fslsNHNbQMLSsTqdQYRHyubTD0M6SdN2BCFKgVICjTDKQT662ONPI
 RlGJzb4E8D6QtRdTXcK6yDm2GwsgLOFFWiRrXorZEP5tUTt.GF0poZgbT0KMVFGZCGtzDhpyIDeM
 KoG4b84hltsqkYaqtK1aPsy799MvZFle3OBfmtc.edfg96RxDo_Y8pkdtM0LSuk0KTy9.v.pg92W
 yveH0mY5MfHY1rdHETJ307ltibyBkIBw5sgGGCS1OKQJ.smKEjiYIKl91_DfMiz0Om8Obj4FZ2eD
 PMCNzvc8_q1K0YgjetAyl.Ev7eJrflnL4erGwJge_WRRiikfxYKxikmkG4kfK_LLLYKgHvxcNm0V
 u7gwYF0g1mHmMf2R9LmtulVLtyylBYuIHmygWfLosHii6Hn_KSSMDNeG_Z8Rfc9ZRqvZYdUyanpP
 .PQd_mENKtwa69WjMjBLJ78cDInuE0p_oSCQpP0nMrXfSyIo7Ajrj2LTKDdd8z2I939jEuvQMVtX
 FVYvBtGp9pDKH2u.E.iUBk08GnpK4h4ekY2sKa79Lq91f4x.5d1wPLqzJRmd6LJuQyu59R9aYveJ
 sCny0VZ2eDVjQKmB6GmF812km1TeGLHvG_VaoOdLvN6xLlzX88ZvKg4EUPpP3US4s8mey9EGvkWy
 A9qzC5FYIq4wW3DcDj4wA9FGendNXXVqdmV1bSoBvSCMgoHjHBAAEdF.C_.yFhTQoGntCWg8C7Tr
 VHeAwlDcOrtQAr2rLvNHVtCL6jhksHiYMnyRXVX2nVZDwHSBn9_y7SxQVixarBDLLI99xALsr1Y5
 oc7x8FZYpUOdzvNDbQbqVl58VNRtrtxvcxg6C42CtmP13u5EtVD.DEoItW_NXlf7MzJcLCV5cCTS
 0iBGEmS6v.fj4BUxBYxEqGSB3F1yz31ZgMUHdMJyZ
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a4aa690b-f024-44fb-8e1d-16c86dfd679f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 3 Jan 2026 19:38:10 +0000
Received: by hermes--production-ir2-7679c5bc-fqlcc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c7c579c8fc352a3d43a5f55db2ba1b4;
          Sat, 03 Jan 2026 19:17:51 +0000 (UTC)
Message-ID: <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
Date: Sat, 3 Jan 2026 20:17:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from
 rx_packets
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
Content-Language: pl
In-Reply-To: <234545199.8734622.1763313511799@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Fixes: 4af2950c50c8634ed2865cf81e607034f78b84aa
  ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2180,8 +2180,7 @@ static void rtl8365mb_stats_update(struc

      stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
                  cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-                cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-                cnt[RTL8365MB_MIB_ifOutDiscards];
+                cnt[RTL8365MB_MIB_ifInBroadcastPkts];

      stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
                  cnt[RTL8365MB_MIB_ifOutMulticastPkts] +


