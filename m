Return-Path: <netdev+bounces-165132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D969A309BE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC19188C25A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA831F4262;
	Tue, 11 Feb 2025 11:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980B1CEACB
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272680; cv=none; b=goMKldh/gGYCwdHEQ5ZEeGD9rkiGtcMkpTIEz5hpVfPy8f9UUCd0EXgv6c2A5koeIQWXcVLprWxIrAI+cP2+0TMIsl+mz41BsFVqkF+p0nCbizHEh3JH3loazrrUXf0JnAtepilVSZBkRQLNUcRPNMErRITcOJ6B4VprbuQ/2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272680; c=relaxed/simple;
	bh=K1d0tx3PaHBtI6Q44wAHQKRnhl2rM8eeQ97J0PsPlGw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TarPtvIsmOTKE8ovboOAbIj2HZs1hkMZwunmoLz/406dVT7Wm1kH8BTAdxR/uxkgNPAwG63V35FBWKA2XKseXO2KYMnEkGyMD2qE1UaVi2PTxMc0ag2KFWXwhQABu6yj62/INncIESpLkHc8EoPVVtLyodospQwPohfP+2xHGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp89t1739272651tofnbwrp
X-QQ-Originating-IP: P5U8U1wrOZTiqP5qZxqquvqM2S7v0NeiIWXNSWTYSw4=
Received: from smtpclient.apple ( [183.157.104.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Feb 2025 19:17:28 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3854022505142321806
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH net-next v7 3/6] net: libwx: Redesign flow when sriov is
 enabled
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250207171552.35446145@kernel.org>
Date: Tue, 11 Feb 2025 19:17:15 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC1A7A5B-0648-407D-8F2F-0B300FB47710@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
 <20250206103750.36064-4-mengyuanlou@net-swift.com>
 <20250207171552.35446145@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NNC6H2+gqsu3zZEbTjJQ2jv5TkyPOFD8iLBs6Wxqtb5OpjBwz6t1vpBD
	VB8TL2gB/KpgBFVj7toKUrOdR5rIT0MSg7VP7SQr4KyPEMa3ddphECF5xPWPeD5iL+voKll
	s1VGlHFbn51lR6i/fFyl55XznQ7Dmfim5kGu/UO31mgNytuAgAsAGt8WX8yVXbMBVMTqug7
	3zW5QIlugST8zhBCU2Vz4YvM5l3/jP8tSKSZ2uih2m/z854GQL4noVdNio9Ddwz6dwQVp+o
	29yt+HHIjqUQ01YgMvxT77B3MjxG92SDAcentkUmPf3R0s4Oi+9p3hW96nQAck6FDSTdIX3
	VTcJn4rA1ehL3FICa/3WBtnMS4BUf7rjQeeOkNw8oPQImbZBg3Js7KiD5+ua0mEr8JLBTUn
	lmXgnAcl2jBIfxQ2CisWO9GbEIgm1nn/TMYnmP7I0AXqqriutNHLFUcPndjO13l3+KQ3Gl5
	OFHEqkM4kccE1Ot1/tiotF6ZECdH5UhvXXVuzX7CbYCG4JHmsHnJKqIanzb8oMZRPe+c2SD
	z8hD4UHNxf8CnS9dNeR6n77hlvc0ELGw1YMVzygGsNJVpkXxzsMF+ErRL/b5JMY/2ObvNtw
	uV+nIS5gs6QvEv4QHQKjsJGa2bFUKin1LdnXvHyb8bSXiZXx3Al1wYRr0hDuXzBwBVg888p
	WWlHSvkjMnAjI0lamlDcMYVwTMCeKqem6dGo9OajsU1PnKgavQuVZpiXRnkseDkU3s6Qple
	zV/b/Zm2brbG/2Nql2PpZFLZvl3IX5R4u4DXwuvwFm0AEcxGQ6DCwxLV4lb8SCwR3YOOdIe
	6P+5wGB6D641/SvZxlatY56CM9IWqeesqEIOBxxidW4AnNI4qMU9IJ0FlfttPLrXZGxoxyA
	8BGToab/OKXyWVx7rtXnjGPo31UtBrOj2/cyJl4+UXnD2Bj95HF4J8F/Ny3+58M+ZFy4Ox+
	2NyFLXeSkJWmcyPjWGCyRiN5ATsxftDjQp0JFCRX5VZmJ2VLEPJsVdJNZS7w4gZzLXG3A01
	dnt7VlBkmNSX6OtJNVJFK4Kw1gCUs=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B42=E6=9C=888=E6=97=A5 09:15=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu,  6 Feb 2025 18:37:47 +0800 mengyuanlou wrote:
>> + vector_reg =3D (vfinfo->vf_mc_hashes[j] >> 5) &
>> +     GENMASK(6, 0);
>> + vector_bit =3D vfinfo->vf_mc_hashes[j] & GENMASK(4, 0);
>=20
> Can you add proper defines for these fields and use FIELD_GET() ?
>=20
Thanks for reminding.
>=20


