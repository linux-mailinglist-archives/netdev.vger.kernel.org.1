Return-Path: <netdev+bounces-117385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AF94DB18
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00621282AE5
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737AD14A4DE;
	Sat, 10 Aug 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="MmSd2aei"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-20.consmr.mail.gq1.yahoo.com (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8B7E574
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723271370; cv=none; b=L5F5SzkGzMy5Xvbm40s0E3PeT9NhTQGmjPwPlk+UhAYQUB3EDKX0Pv3Crz5rHH2AXEcC1VCOfLgWjJ380SXuNOzrpnHru2kuEuvSYsR4fLqHUN5FX/G1k9KYv8bYMsuqLqofRdoCwgS28eeENYoSr/X3uct0kT3UnijRzRxkWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723271370; c=relaxed/simple;
	bh=p6B9UYEzKuRPbhunWlc7K3GVsMAhS9tVmrRXiJNj27I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=SaUgJ8n/fTznzNiQgK+LG3hQsMJ2FsvU1sFNArDBk4O9RXKmVMTXYscJd7NdBs84q8pGzPmgfrXRgm1fx5snqulnLAfqBBfWy1xnfS3z/vU/1Fx4Fj+rX9M9QVPxI6jnTEJK0aGmmLnjzgWksiPrLT2P6ML3Kzm3OxpWa9HaMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=MmSd2aei; arc=none smtp.client-ip=98.137.64.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1723271368; bh=vfRgJHwjFT4eg+NJ87PLmehAORH8hcL8vjl9IoCH/iI=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=MmSd2aeim5TX0mlEfrWFdQ4t/63xRqdp0HVc4BnN9kl3a8p2rrkc8kTvqxhiZRfxpGJzWSvsZsEMUFbTj87a3qz9QmX8UdFQyjyDrFUHeEr2gbKFZ9V4mlzQ8aGz3MBaBVZpFXRg/z0cGPTltf6GA4d9WHrKdOnA1Fkyy10rk1P5EyAuQKNE1AsUKKISrK8coMsPjEsc5LEnjFxG+419VGD1ErHG9XFDfXengIZ88hSsBTspmkgE9XFhW1c70rpWotlpnPK6m/1bKu5ZJGABa0ciaJ/7yO1QtoqaPJ4BgiYbfuZgUhr3NagvVJKRMFgqKaXLo2EQ5DjkAj1UhHR4oA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723271368; bh=+XudnEOZL4eQSAtpIsj0P9lwqNZ+BfRHSKLs6Ne+MIQ=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=jw5klZoGy0hpPATPqk7pSPR6rpYwixir77aYc+w5FD2SeKYuIeBis8NwYNHNBB/VeS7/39i3Elmfu7DDTINuflwlENT5o0W4uNBz5bkj+tof9JkGF01gBMzEtTxjyesJsKgB/ZhDr2/kxjriqK8mqjG86Qw702OnlSuuik/D7EZ+YYuEuULH6CbuNseXTc81PU4k2vBBsOvU9m+dOg+y819YijUO52crv+DokfNTKIwK3uSJTyzT7l/ksKBfEwve3Y1OLJMrmop2VgdwUnG6rqQbAIgxwafIwWB3m4N/df8pvWwOy8MLOpLVobegZQ2HlLINSRw0u71xT38RTdUjXg==
X-YMail-OSG: YP3NhK4VM1k.dFOPfkHYYWn47uUp_ivdlAEst0kmlZgEmVJT._A.dd1c8u7_IF3
 F5SSUic3jAoHRXbz.MsIZpUS7XNSfVWFR6IvW3BrAW2ymRTPKH2BysMZwiWBQxag_Fsvfn8zRRQU
 gzjghOHTTBQ7z7AP5Zz4SJ.BUF.p.U1RegxJ7rRdI1zPzbmkVvs37SJ5E9Nc7VWBeYlEDWgze0_M
 WcnByVc2h_hOGyGYbfrxwY_2FxJbubHpsaZyPCr8Qi4ez8ruX0NkLp3Nls0YjmgmYhcORVaXJucU
 LVqvW4x09qa9UybGlTI9exKVl8TPvRqv.Er5Q_2dL_iK27HuxsvsVf4iVGLac1QGR88gfn25EBSz
 YZvu.zUIqVPBdGVt0kmxJxdypR2futkHNtZw8bcKPk846iojKp528TlT7VcxTwc7diq.Kj6XIS29
 NSwTUAZ8LjFbv5dGorqYFdOKyuYTUbcNmfe2V.KCGJH3fQqwDQ8xu4gFPugNNyizvcGkRx768bkX
 RahvUewIXlDQNCgT7kjDv_HaFatcL.qP0ZelOwdBu8VeP_ngSh6jwT5A2RN9S0fsQ9Cb2wPmSpiu
 UiB3KwJh0pQuxHBpN6DWMcsgmNfgB.xPv9LRA7StO9rVsKpf0A3Q4oIP6hXED6Zd76AQW2pNOSoM
 5g4.zunGrXxrJ3R.EUiXvoDNXkAKUcuUP6cYpi0heZkQyRxf6r_jaSTrc.Ll9bKWMYNZ5ApqYGaW
 mIGr9eQGtARWEp4tCNxHpeAE6Jc_GlfAN5a45UO7uBSt3mYfZ4PpRJVooJPLB3FH839wMCkfZR0N
 PHvbHS4HH3bOv3poPUla1WMunGpBHJBch25wLz9nuVH_QMkQlc1gCAFsPO6n4y_BtvEJ_tj86GcE
 H9Syi0wM4JSlADs03bDYhZksq9HejvJqLRoo8gMWh98RgTsyV1OC3XJKCsahqNErzmiZJ6I_DvvU
 .mRoJ5_sk.L3dePbgsvgZjWngNYa64AkTyDyRI7QQIh7vbSsPEHeod0bLXDiR5Bdae75hN.JkQRS
 Fqw84Fx2nO5cYnnVnMnAzgsYlZPsszdoPhclciuoyyTIAnDnQzD5eVRu5Es0.dVPtsjPO0kQ8NV3
 8eLq3lq9Te5dx.0ZvythU5dVGuisSnlGjgSydaiqT54ZT84FITA1JRqRMYH40hzCMfQFkPWCRAO7
 So2hzwy04FVNjIA5eFf1GDptVSl3YXjsMD69FN9iSf8p38CKTirtfiFbzRSke3d9m7ziViXN5.q1
 NYYbJo83UJk6i42Fy_9JEU17Z672SaRwZTJAs.TC6uSN9dK1GlZLhwSHGayo406JlWLK.a_EfdYG
 .M66qTifZC_DlSSASyGNiXHXG0OeqaKGh1VVSS.KlOAPLE4aGUGTvHcuvvd6Jw0ea_TtggwTdur.
 VcXYJHvvUwPcAQttnr05cHpHWOnjv84pu6dk6c946hzNC2TjosyGmUuDKiIN.pK4VHFN5z8j0bT3
 amZVr.9jbXFFoiI5Yzk5a5fYqmFSSMmXnZyqfZ_o0dQMuPbbCMr4MLMhskXYsSAbiBTlI9TQTGSP
 IaQ3ZGD28.Yq5AzexBsBOHp5vIX5.BG8quuQFrg0pUgFYpDIsD.oWpt95KTB3LDBjHQ7aTRQKFw_
 Tjqymtt6N_QwmVn.8VdUIKHI_cdS7dlP_4YzFN7bgmywT8gzebN0HTnzQJGixSoKdnlFiEq6qEFC
 mI7JQOv3dsmgshMHJaYKtK_46.JhVCgZPj0gt_svzXbTNU2j_QIyiZJPtrtFGorQ8tVvDFigGBFm
 Gp9Hp4ByhYB_ENo9eeYTKOq.Xjt4E1S2DI6fbJAX4f8BrCMoDx7iXFsWHLRqJRjrwBl8JvMuC6VJ
 wLkHjmhtJxkMf7z75iredNuP6eoWG5tkX6wuvg5LJEtCt1po3aDZHaKkE_w0G2UkMFW9z2_M9HsZ
 cQ1lPhs4Z_WEVDKLlcsb3M7JerWROUo_fzy49y5a6UHSKM2yHcWpag3W861978QwOoInZv25pcdc
 YUlSxFHMOPbcj5kgzWPvRnYfm1q0_KZtcECAQ.KNDJVyPz.1OAjov9_DHl2bxVH7xTCPp0Sy9Wnu
 ikCL_1qhxFQD6hzs1UtyWDQwSaAukFNHA8t6vyZAfWWEPPVqYkSPSRVAoiDCxGyKxZcr4hsuXNC1
 A_O00L6hmop2M8T7vuAqNj_QpGUpNBuzXwaxNrgY4FzAuMPb3BLCL67hf2.LHt4Mw4jm4zcD0zzH
 sIRKumJpbLwHQ.lNSNySqvBYhpA--
X-Sonic-MF: <canghousehold@aol.com>
X-Sonic-ID: d3e4af66-85b3-419a-95a3-de9577545506
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 10 Aug 2024 06:29:28 +0000
Received: by hermes--production-bf1-774ddfff8-xth2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bf3c492558b6803b130b631105e12c46;
          Sat, 10 Aug 2024 05:48:57 +0000 (UTC)
Message-ID: <5753567a-527a-4c62-ae6a-c09ac9535a69@aol.com>
Date: Sat, 10 Aug 2024 01:48:55 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Cang Household <canghousehold@aol.com>
Subject: Advice on Using ACL on MT7531 from Userspace
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <5753567a-527a-4c62-ae6a-c09ac9535a69.ref@aol.com>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Good morning from EDT...

 From my understanding, MT7531 has MDIO bus for management, and the 
datasheet says 256 rules are possible. The datasheet also suggests basic 
IP Header, and some L4 headers are capable of being filtered, so it 
would be quite nice to offload some ingress filtering through the switch 
chip.

does anyone know is it possible to use any userspace tools to interact 
with the MDIO interface of MT7531?


The overall goal is to build a zone-based FW based on two ports from 
MT7531. The ZBFW should be completely L3 agnostic, such that it does not 
rely on IP forwarding, but rather perform filtering on forwarded frames. 
This is a difficulty that when I bridge two member ports of a DSA 
switch, the hardware switching would kick in and the CPU port would be 
completely blind of what traffic are passing through.

Is there a way to turn off DSA switch offloading between bridged DSA ports?


Thanks.
Lucas.


