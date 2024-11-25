Return-Path: <netdev+bounces-147276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F189D8E25
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 22:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A33716413F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED361C07F0;
	Mon, 25 Nov 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="mzTrgGPK"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-20.consmr.mail.sg3.yahoo.com (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ACC1C07C3
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570931; cv=none; b=uqKYhJ/bTlrWHz5jY606YEVXObEoPmg3zjHDir/ccZX4M61rJhjVP5GYmGNfjvSnqLCqDjoM8vE6uSMLzQZOZmRhd7vZAzp37YnBJSbtNjsI5n8xfEPPZIFt5x3cgDtwXTmHeERKlYDHxJ38SJfV64tqrowvNFGokHqia8v/qqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570931; c=relaxed/simple;
	bh=6eK4x3vju9hJJoNlFK1G120YazU8r8EO8J7R7KGanhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpmwJYhzYlDM4qmIjrQVJoNIZYAJS8p6nfzVD4BlsX3tGp4oZSqYK2bjyPGIUfT0uADAM9EP2mHu2XIiUPVcPKFP4XlcRoOQY7v7DPtl3zZ1SnuhC3wd4JZa334BkiD0oupf0ybWkj1IPfLk6WDkNRECIuNr9T2lEJbUjVqm46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=mzTrgGPK; arc=none smtp.client-ip=106.10.244.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1732570927; bh=6eK4x3vju9hJJoNlFK1G120YazU8r8EO8J7R7KGanhc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mzTrgGPKaFAXWpMy5j9uYyLnTMlSF+zMmGbGatGYRf9Yt+7ssKiKNun1p++rSGsIxZD+se5jz6HytRCW1jn8yD/4bxVsVp9Jgr/EEk1/l3wFqFNO4ZRZa0SuK1CBxQ4hmkNmq7mlZCi/Tx9xiNE4IpVdK//wqLd4L6gy2wJH++kLQwNzBy9lVPAk46xnmGfKCz9LsvPZL1aHUOzw/t5PkuECVY99cNB5TJjdK5lv/80xC8GSe90IYyQb0oxGCc/GCP/Xn8zhfFXH6yr7VoD1ktg9elI/tfpp2efACBCfqaaRW1RtmQlvoNjSdact+wATPsPPNoaU5FX6MQnB4fQ+Hw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732570927; bh=ja1oYFFTMlE082zeDxJDFjviqcfF4ukBOu9mXJcq5aB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W6gwKs8whGhwBG2D6RgDRxAeSMxdcjDy58jfBTPKPStkzNiocYjfiR6lhrBHtLK0gN/p6WwbUPL1woI5y3sf95owR9GDspSmbDSMTUkBQP1LT3xKa8GNzNYy2ldtwadf+GBKImpDQzam1aNxu6TVf04EWNNOnX71Gi2MJ2H0rizCxCRc9ut4JleP7I3MGK+q9ClWBFMQMynLvRbGBQhF4xnk7ECwcvjfFeHFWz5pANEtOWB1ZGpAmDLjacJVLFJ7ZzVKmQUGUytEv/kg8AvNEyaHiH9cHZ7+vqd/R4A2ixeOPm2LNpx22qTh+2eZrIpfTPTUXDRYq1MKWW2mkuno/g==
X-YMail-OSG: Al35TvIVM1k5e5Ms4ei9etFYA7AqFv1PFmaL3SXAjJX4fJhrTeOXgku6gkRfVNu
 gCPO1674IxS0Z.UflJoPw6Pt2MOpsoSI9Wv.MRDBFUldWS3VlTM8_81JKvOaDNzpqdPumsAMx58V
 zXupgRkAPLVQW7P52pdoayWD5HAgRHz4aVoHHlq77Rs79nP5ed44ZldJ97yM7CBalHPzHYCaxAEk
 tSX91BI_CdiE2RTDX52XsZcBsoHPrr7l1jhqkEEBGJTsLBG0Sr0ZplLYIa.i275MUD2fEYU6d7kg
 vv.q.8uD8b6Z8PiCMrkInEBXOPzsQHAEzm58E6RiFdlj4HdcjDvgPK7sz5e7_qzW.9qLuYvh.Uxe
 RBoMiN76hXn.JFI51aIVHumlGf7kY3nqxJAUfbgZoQ6b4Z.xdfxCaelB_kWUQwhIc4rtYKc0ZzuB
 ErwADkA00E23GPPuv6R5mDbDYc43857BrJwFZ7PvWLa8l0yZXriYBdJr8xRStOrCOP.B1A8epUx6
 AurOrU63j7DPAawdv5YX_SH1KUJxZyY7n0Deb65LzLzfstPvMgj6CMtdR8RjT8bFhJA.HNHNrJ0N
 v151lIa6eRWG1dvtf.mGMI_iNQHjb_Mu.rkB5.sdFbSGjBVTcA2z770wa58SJE8OZum8HM6ZP6Fi
 COV3pnF6suHbeaEE9GdSdvX7i8m1ky9yy504IwUQA50ME_Ptnfem3p8KkX9lMI82xmLWX7zILumn
 rhnxiHDoAAEGwAqTFn7n90nu2Fn8_CXKOVUYjTi4JO2.Z86ID6_3XcglsSdoTyRDlXYrVyGi6eHW
 Z1g_vm_cOzO87BNgVk.Nby87LI5Rz0boz_p6GKAFMFyBTKESkf5q0YXKx9BNUqp7.yN0DwAzFkZ2
 C3vH.MBIteKgFfsDp.5_rDkHOIKeZN_ZWXbPl0UZH188CjReE9r7tXnDtjXS_rkM0KVZ5kkRmAIk
 RnbI6DniKnVqh6lGGSAtiKEgXroU56fwT9Jpz7sGjd3Ka0QbeW88rgfJITNWcQ0PIEZ5toyNMpUx
 2mrBoKiPfmWHpwn4W9vG8l2sFEoIAgdZEvCmOCKydpxCVk13lwzIxBo918KY7_i20uoSLW3i6m5u
 k1.jzxOigJZP60CseoIl0eKBm18_Wz27lV4wIlaJEbKMx_ymVTXplCoDh6MmbBz86koZXJibjoyQ
 eBZwO.BSCmjJ5h.wL.Gg29mshDCLh3geM7SDxq2hUTjszeV3.Yg29rUZgGh0jQgWZrmv3Fjv3uem
 NygEuu7XsKwA_Mlj.Lh51BXFoxFFiDa7Wt1fUXZo_pRT.n_LSHVuluibfG9GXYMGX1Qdu4jGLTDG
 GjYjQBEpfdatAHf.f5jLTOebKC8Fv21c8xHrQInJisvL8lERpNXwhYfVcjQDs55WNGZZYa6WP1hI
 k9rLTORmyZcO.K6Xd2FWN.G89ar4kwD0CfgK3oBZklZ4WZL0Q62we2sjwhuJJO_wBqB4NjZcC9fv
 VN1M4aJYh3ElWr2CuUGySCS9rgBYf12bQjIgrrnq6jIqcZH3vgdJ1KBNqThOwIZZHVTWdvxXHQGA
 8kMjP.mhh12t6M7kbOwoheN7gsvtUpS75n.imQepKNX2Eq.f0f.JVcZE6cOdw91ktMyodCqKzUtX
 US1qAAx3yHlR85rMwQPWIJLi553GDqoHkSbF0JmxbOZ4G_XfZIeaT0DuGKaBYSsnrTxF0P1QXB5M
 TmvW7LK0doC2PGrJn1a72NJGExH8SiQtC1MdWED8mPavRrhT_AJNi9wx6ui0r_VCulpXMO3VrLIS
 X6J65z.VHl4fxL.B6X.kBppNCV6YSuMq0yU9Id5ZuUpDM2N4WLurwlMAyS3UM.CCgoko4D9QuWmX
 Et4W0keJxHYr_LE16MmJFTuW3FbaTJENzhZJ.YlnB1VjZGsXZMHjyCKpFkv1r.TzorrW.bpRlri.
 i0D_piR5YGm0xDOIA7LRlPkpl69_o6uKPY9d62EZpR_4twWtblj9nYPuFoPLU2avBedHyflBWbiA
 PKD2cHSZ7J77hNYN3R7s2FfefD_cDh4QsNDl8Dbkl2i5Z3QtLPAUmgYYwpBnfP.mJE5PwMsZTqj6
 npA.TIDZ3OKWy87eiz.lYXen.BCF9tmmdDNufh6VLW2LXKQMkYWXzt0I6u9dWEjV_zWHy55ZL51I
 PwMAwG06Ew6TGNDYBcEllQJQD3cFTTpY.CgdrWCFzEdd8r_eG3n_XYWoWiKTryvxnFmxTYPz4.NN
 LwrO2P7V0Z2sfvHG_ZXGe9e6Spzv8EykCz0aCOD_.asLo3e8-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 9a50838d-9b58-4b47-a13c-ffae9836dba2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Mon, 25 Nov 2024 21:42:07 +0000
Received: by hermes--production-sg3-5b7954b588-5j5q2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f6bd66b03b94779d3249653df70752b5;
          Mon, 25 Nov 2024 20:41:13 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: krzk@kernel.org
Cc: abdul.rahim@myyahoo.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: s3fwrn5: Prefer strscpy() over strcpy()
Date: Tue, 26 Nov 2024 02:11:11 +0530
Message-ID: <20241125204111.39844-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8e68e02a-2c58-485c-a13e-a4b52616e63e@kernel.org>
References: <8e68e02a-2c58-485c-a13e-a4b52616e63e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do i need to resend it. What additional information do I need to
provide?

