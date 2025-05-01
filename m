Return-Path: <netdev+bounces-187193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C264CAA5962
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 03:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8A7AE8FA
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A81EDA28;
	Thu,  1 May 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="gyqn7DAj"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-55.consmr.mail.gq1.yahoo.com (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A852AE9A
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746062775; cv=none; b=n2mVBKwqf/X336NZ0fTDMhjT3hSoK0FHkJPP2TLprs5OM0OeGpeFeOuWGitykMUc0mz9JmgT9Iz2FQC09SDbPljvSfbOKj0lPX1unnWpc9CpNPEOg6IbxGH04VoOQ+LpqHFzRsDFdX4W7Em89Pigwmqk4BooAxwwSuZvKK33wiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746062775; c=relaxed/simple;
	bh=OeZH0Muv7Ldy5AWKX4jCD4LKhjF3jJInxW5JAoTxAWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=bB0h8L7FHaf2YvUHh3AASQF2K32qpx0Ilq0zDUmNyVFN6xR0O2iN+XnCxwz0FrioBlC2p8SzTZ8eUS1257K+CSLJA4l1KN9UH04ud7DCk94Ag+vemoqgHy9hcmikSI2/O2MzzSmrzJHqYDERV/bLQnNvSIJZcSczkryPP7fVT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=gyqn7DAj; arc=none smtp.client-ip=98.137.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1746062766; bh=2qOVDS2lpahuPfBH9S7MMHyJPh0Glup6HXXgGrMGq18=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=gyqn7DAjdfzC6KvlYbQoOfItYUEL34WZvE8lz5IAS1QiwMZ7oiBke3prF685JUQOY3sjwqJ4SzsaM5Dw9bcZIb+UbQ2FPk+JnbG5tiesQoyDbJRUwUv/qTVHZisnFW9hVQRRgiXRt67VYcEu/kOKxsZOwQdPoNY2cE/dIrc19CU21nstUdW7ijpyY9sC0gwP3KlHaNBPlMAQMy5ZKwEQa4H7AkmyDFd2a1werzCK8f6lyF/p6gpikyI8wBCBjX2AcSNJklNT84DNxj551w6SjE8jGJaExFEW7aZesIEH1Y8MvdCcfnc6zbS4J4QPV+DWLQMJIKjINO5EGhQJflJBXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746062766; bh=FcAC+EwbgVzLOUplo/JFH8W42b5rMPacZ+Up2KOQZmX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=K7a8UKshjXoskkauGu6e3CMPhaVRS0qnypS/QsnsXE+tAKBnKvHpNMTgYpXEGj9Jnogeqpd5cnir157GT5Kb/thacI4biNYDT0ZRlkNm7qQlOXC9lIN7Dxh2sOFflETg6xpidvCCxwuuXSGxwPZYp3XcenbAKjV+pJHBT6At55a2M+8W2gcjgfI2AXQOo+QyG6LqhpsyHYSXatR+NKmVQYV2AiZqbrx+4jqaRy6DiBlleKuN2WkemNkQp0BJTrpLJVt4szUV11HU8/pnMz/kKcBYuxFl2OfhFIfDlnrklw2dUl2d4wCf9P6DoDorxPjlE581Xr6lrIoHR7VLTjfHYQ==
X-YMail-OSG: EaQGMkYVM1n7hz3utXLbdklkpazZgco_nxmn3E7YPhig2d7nU4ZhAgQ0Z1arA0l
 x65yltfNPIaiFr8TTNmK.0hilj7ZuPRIs2BTT1qXupixf3S8t50x8p8KUw6EHzUf6vmq1JIMYEq6
 zDc6WSfjgjfInAYepqjLIRjRJjYm0muNCiG9ujcmph5vIEbvoe8Vgm5M_TbWHocN5qbg12bJcwqg
 nHf2gGdJdSIQKPaokTmwflgmni2ChOcwkSimU8M6c2TDJgNBpTK7fTWyiDSD0KQv_Oyd4ThfEwrf
 BMlQIFg4gklTj9g9idk.na3DO2sHoAFW_OnTi6QT11Jb7ApA79HHuQf22.073uHXreelUXccJgDi
 iJ7SX9QuW7cV.Bo4ptzDOvut81QD6mKl6eGHKAW1Ll78uhJm4EqBuVQqb5DxBhiFhRGp4plrQd5V
 C9dkzYX19gwN9XpSifv1RqArJqRhgmFm3GJinsK3mx5zPwXuE00c4Mr5R6yHA.NeXwPxWG0Lhdmf
 NRcPMMDvveDpxrozB_2PjtISBmmlWOkIwFIQIE_ANGMDkkwZGDXQglQ6HbdDLWK92T6l6cLKMZVs
 HCvpSC3rxVV_hS6I4Tw8aw1yIuWUj9l6FEUpz8CDXbX9XArpH9hVhTXrkgLbXZ0DzqBrgWX2aiQE
 D9Z5HKp568YBzHsmEp_IpU1Ylyl0Hjxee1jK0A71E2qjd2L28UByNsF6Vp8V8rWaOkTMWUbaiLSb
 ReeHMLa9C_BKBkhXB8yFpoIcfctDhQc6tSdYdWj.1MMRfti9xLZoabjmM3VR_tKENZvyx2zovgV3
 XCLBZAWcsMFwqVfCr53atud5EexTdK6.S9xXKh4Ak4.AEImL0WSLw7LrKdA275F3Sh3ycaNZJHL6
 Zo.tKVNtVC5r4XA55HSY2sQAX6sbcpKePTCPDiSppx9XPWiJQBE2eO9uA4oNPhGGSHz2PdDRAneH
 CE_nsS8Gxzl4_qVQmCSCbBvK3JgLs_95mnzcfP4IhvhYFUZQVZ4Lkfqdg1IVFfF55YRUoBc08DtK
 Tq7x9bvK.RaWTRfLFJuE6DkBrqdqW3UcdubtP64KD_1OQeGBEsHwMbljZ1A_Oa1vZBpm7ZOLmf9n
 RNpq16MJtDa3AD2NtPaPpatZA0c9iGbQkbhdBZzBvJYruDbHsHOghiKq_M5YKV14GX.FDJILmuIg
 UfpTdId5M10vehocjw8BKzkxSrSiI.Niv2WOhoTr8rT9ztH0CRy7q0LEH4UXJ9Bj931EO31ywpWJ
 VC2LDg7l15lsoCNH.DxPr9wOwBbtqfzkNDO18EJs3xYgmZjh3k8JfG8UeiEIjFYZ.obJHQjB56Pp
 TLcffQOYcJ2X6e1dbIMqg29WdJ0kS2w3fsfF.0gpXV5Wo7a4Cnpiy6z5GHS3p2aEJ31qiSm66NTw
 b03OMzvl..eqfASTkypUJ1kNGNpqjBAs0vGx4SrX36r7wINYEOyQs7yvZhkKaEMlGZl4P3idBpVy
 4BzpmOwzNiBtgmLvIagGpXpmIjKyljfGqdiC2QTSS8VV4aHoc8qK5EaBLpcF69d2iJa6MtOnBJpp
 T229T0SBzHLkN7ONUslDyf7Uzini0_jQ_qLNtyYg4FHEj5_DkSynuBNBLf.kkEgQFHTqO2pRY5Yl
 JZmPVJHd75ufYZDlDABYMev7vPZGTykNUzdWxHByfovaPshsg4UCzp1lC8EPgSmr1CKMEghleD_g
 3aHDRwjLZb0UdpeTzphRkBE5UT.Yd5bOYEqraWpICZI.RiZjjX6ymyv.5mh2BN0sSyU_4.Kqqj_9
 pQeOKASRXWHSc6kZBxBqBG2I024j1KpDXXX3VX75g7.z.r8F0AIM5yz.MmYHW_x0aAzFUmHecc.K
 Cvm9cuwdtqP_I0_FZ4esDXXJsfYHgoutNtJWnTOxo8u9AZ7Kqvx.Si8GrVt_BGlXdv_WPXE.geHN
 rfrEk.Y8XVgVuI_2DSXi47yP5niTZe57tO0EcYuWiSEasAFTWQfWqaaCCz053VQeEEaBb0Uusrsv
 EmMb2jq7ma32jZ4gGWbCqDoEbU_40B75wBkm38QZ4Ycm3IF7rc4IkHmyZdzh68_X1AzeyapJYgXY
 dOvU0dNq6uSXZJvidexVVNaakb7DSYEKQMwQuQedKAN7MML_SEO5YAucWJM._WHK66LAyFVv3Okg
 rq7X3dPWCktQNspdy27i5kR7f5c0bayGfYVwaLa.Nta2grDEAIkyeV5.Eru1.O8NxeVO__5Y4Ibv
 31PTAyjhxhNDcpPqvRPR6T3qemGr.UbPv.o1EGQAbVLMxLb2p3s81QSW8FVZK2lyyIhss
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 5f964ade-b994-451d-9795-77102c814f47
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 1 May 2025 01:26:06 +0000
Received: by hermes--production-ir2-858bd4ff7b-vtq9f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f513c98fde2aa8d8aaefd5ac53283f60;
          Thu, 01 May 2025 01:26:04 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Ruben Wauters <rubenru09@aol.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ipv4: ip_tunnel: Replace strcpy use with strscpy
Date: Thu,  1 May 2025 02:23:00 +0100
Message-ID: <20250501012555.92688-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250501012555.92688-1-rubenru09.ref@aol.com>

Use of strcpy is decpreated, replaces the use of strcpy with strscpy as
recommended.

I am aware there is an explicit bounds check above, however using
strscpy protects against buffer overflows in any future code, and there
is no good reason I can see to not use it.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 3913ec89ad20..9724bbbd0e0a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -247,7 +247,7 @@ static struct net_device *__ip_tunnel_create(struct net *net,
 	} else {
 		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		strcpy(name, ops->kind);
+		strscpy(name, ops->kind);
 		strcat(name, "%d");
 	}
 
-- 
2.48.1


