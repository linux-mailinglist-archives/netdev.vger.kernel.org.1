Return-Path: <netdev+bounces-116325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E4949F47
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4813287DA1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506911953A9;
	Wed,  7 Aug 2024 05:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8F19408D
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009378; cv=none; b=nO04f/VskSTPIMielACu1MqLE2aqE9ikmcTA2HRwx11WkTV/9qy3TbQII5NE7IBVpHjwKG+Gf++8UlQlcgOdGcaDlidWxXCqyN+P3lnptWntyqnTt9t1meqm1g939oqwFbDjI7QuJJ16obT7L8eekSHpEXkOIq4xrWUmruQi/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009378; c=relaxed/simple;
	bh=xnGsP+1OdZJxHM1PrvNg7PQYCLUaOKJl4KoZSAwAWtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L670WDZ1wz/yms3n58C/HuqkxDwTEH7HtLuY2bjMsHcJxclv9mWMCmRNHezPtgdz2k2zEEQf6EwsBOGAl+kbs8HwoHE9YX5Lq+avyuXZxt6/82bchjEs9UUJG9TKv+1LlV6yqy9EwjlYel6tks2t6D2KnIhsIryrGNUWq3HPIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz11t1723009338th3cm3
X-QQ-Originating-IP: ELvYu1tqzvdSVucL1tR6r9E6YFk07zADEw2nScpqwGQ=
Received: from smtpclient.apple ( [60.186.245.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 Aug 2024 13:42:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6930022033209959896
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3814.100.5\))
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
Date: Wed, 7 Aug 2024 13:42:06 +0800
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CF76B28-E242-47B2-B62C-4CB8EBE44E92@net-swift.com>
References: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
 <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0



> 2024=E5=B9=B48=E6=9C=886=E6=97=A5 19:13=EF=BC=8CPrzemek Kitszel =
<przemyslaw.kitszel@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 8/6/24 10:25, Mengyuan Lou wrote:
>> When use rgmmi to attach to external phy, set
>> PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
>> And it is does matter to internal phy.
>=20
> 107=E2=94=82  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit =
media-independent interface
> 108=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal =
RX+TX delay
> 109=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal RX =
delay
> 110=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal RX =
delay
>=20
> Your change effectively disables Internal Tx delay, but your commit
> message does not tell about that. It also does not tell about why,
> nor what is wrong in current behavior.
>=20

I will add it, when wangxun em Nics are used as a Mac to attach to =
external phy.
We should disable tx delay.


>> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
>=20

Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")

I just want to fix it both in a1cf597b99a7 and bc2426d74aa3 commits.
How can I do it.

> This commit indeed has introduced the line you are changing,
> but without explanation, this is not a bugfix.
>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> index ba33a57b42c2..be99ef5833da 100644
>> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> @@ -218,7 +218,7 @@ int ngbe_phy_connect(struct wx *wx)
>>   ret =3D phy_connect_direct(wx->netdev,
>>   wx->phydev,
>>   ngbe_handle_link_change,
>> - PHY_INTERFACE_MODE_RGMII_ID);
>> + PHY_INTERFACE_MODE_RGMII_RXID);
>>   if (ret) {
>>   wx_err(wx, "PHY connect failed.\n");
>>   return ret;
>=20


