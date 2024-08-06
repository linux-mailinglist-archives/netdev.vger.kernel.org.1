Return-Path: <netdev+bounces-116006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD4A948C3E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092981F23313
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830691BD4E7;
	Tue,  6 Aug 2024 09:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66F1B9B4E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937115; cv=none; b=qPHw7Y2aG9YFWYeTmViv18cVxICOcbZdEu4KKpSBth12SlJe5DvK56UnwGRw/Wz8dxS5niNRhZlp72VQ5YPWsOdQomT4xq4Jxr4Jd72/Xp9M69vX/QGXEoBdAeWZ9IX1qM3hmOlKN4qk9Vitc3yPsbOxj7tfK2hanO+0hSe/hTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937115; c=relaxed/simple;
	bh=tK8185lRiU1pDDb/1Zf5jybK4mY3ctSCSPuNEEOKV5k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uooE9SyPeR4dt11ZBJ9CZhQeR5hjSGFRguiy3nLMjICKUWrSyZHVot6sv0YKJ6ORF6G4rDW/BDzDizwzCcc0ZECX/gpGXhZkOeuCelTLPQycVrHxw4S3pCL20B7sldWYcGEZOjOrdJf/Q4stc2/u2CoyGeI7FP3VQLmTkW7xUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz13t1722937068t7wam9
X-QQ-Originating-IP: dBZ3kglpYazAhLsbC7r/tMY9gS+KxyoDMvnad33CigE=
Received: from smtpclient.apple ( [125.119.244.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Aug 2024 17:37:46 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12603909030801487503
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3814.100.5\))
Subject: Re: [PATCH net-next v5 00/10] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20240805164015.GH2636630@kernel.org>
Date: Tue, 6 Aug 2024 17:37:36 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AADA412A-F7C4-4B73-A23A-ECD68ABFC060@net-swift.com>
References: <598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com>
 <20240805164015.GH2636630@kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0



> 2024=E5=B9=B48=E6=9C=886=E6=97=A5 00:40=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, Aug 04, 2024 at 08:48:31PM +0800, Mengyuan Lou wrote:
>> Add sriov_configure for ngbe and txgbe drivers.
>> Reallocate queue and irq resources when sriov is enabled.
>> Add wx_msg_task in interrupts handler, which is used to process the
>> configuration sent by vfs.
>> Add ping_vf for wx_pf to tell vfs about pf link change.
>> Make devlink allocation function generic to use it for PF and for VF.
>> Add PF/VF devlink port creation. It will be used to set/get VFs.
>=20
> I think it would be good to summarise the overall status of SR-IOV =
support
> with this patch, and what follow-up work is planned. As Jakub =
mentioned [1]
> this does not seem complete as is.
>=20

Ok=EF=BC=8Cgot it.

> [1] =
https://lore.kernel.org/netdev/988BFB51-32C8-499C-837D-91CC1C0FFE42@net-sw=
ift.com/
>=20
> I mean, I understand the NDOs were removed from the patchset (see more =
on
> that below) but there needs to be a plan to support users of this =
device
> in a meaningful way.
>=20
>>=20
>> v5:
>> - Add devlink allocation which will be used to add uAPI.
>> - Remove unused EXPORT_SYMBOL.
>> - Unify some functions return styles in patch 1 and patch 4.
>> - Make the code line less than 80 columns.
>> v4:
>> =
https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-men=
gyuanlou@net-swift.com/
>> - Move wx_ping_vf to patch 6.
>> - Modify return section format in Kernel docs.
>> v3:
>> =
https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-men=
gyuanlou@net-swift.com/
>> - Do not accept any new implementations of the old SR-IOV API.
>> - So remove ndo_vf_xxx in these patches. Switch mode ops will be =
added
>> - in vf driver which will be submitted later.
>=20
> FYI, this policy was recently significantly relaxed [2]:
>=20
> [2] =
https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/
>=20
>> v2:
>> =
https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-meng=
yuanlou@net-swift.com/
>> - Fix some used uninitialised.
>> - Use poll + yield with delay instead of busy poll of 10 times in
>> mbx_lock obtain.
>> - Split msg_task and flow into separate patches.
>> v1:
>> =
https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-meng=
yuanlou@net-swift.com/
>=20
> ...
>=20
>=20


