Return-Path: <netdev+bounces-227145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8CBA918F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F15D1920488
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24762FDC29;
	Mon, 29 Sep 2025 11:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6C1D130E
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146375; cv=none; b=OS0ozCsWXRcJflwPtCOokao+MtVk5W/LiHdVAvyW1paii0S2wSVfTj5ikkyuGFE84bBHa/Ez0J+aBBkjdxc38LLYeZJek85Ovl4vlJh8xuHfz9WJc1WMNaPOQ3ZnUqPxmA9akcsH55bZuqebZIVYCpb1U00LMhfHRxAfFpskEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146375; c=relaxed/simple;
	bh=KXcR6uVKoyTYJdw+jLcVY0jFs5v184nA56KqYt7kLiE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GPnRy8ddoq9uSLtPFhnutfrMqROqIDgvrdQEROIgIps9hIvKGjEqjKVynwzUxmJ74GwUwB9Pa5J31lPza7ZyICOyG4rkgnQAR6i7sYUi3Fmw1ezs1TJhBiwKIOQ5SDaMquPQ+dgR/ouG9CH8F+WYBB3/KCsajiOXS4LrWWUaBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.90] (213.211.178.105.edpnet.net [213.219.178.105]) by relay-b03.edpnet.be with ESMTP id 8EspUXaGNDy9zwqS; Mon, 29 Sep 2025 13:46:02 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 213.211.178.105.edpnet.net[213.219.178.105]
X-Barracuda-Apparent-Source-IP: 213.219.178.105
Message-ID: <d73c74c0-5832-4358-a18e-1f555e928e79@kabelmail.de>
Date: Mon, 29 Sep 2025 13:44:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: [PATCH RFC] increase i2c_mii_poll timeout for very slow SFP modules
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
X-ASG-Orig-Subj: [PATCH RFC] increase i2c_mii_poll timeout for very slow SFP modules
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 213.211.178.105.edpnet.net[213.219.178.105]
X-Barracuda-Start-Time: 1759146362
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1817
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1759146362-24639c284f10160001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

originally developed by Marek,
commit 09bbedac72d5a9267088c15d1a71c8c3a8fb47e7

while most SFP cages do function properly in i2c_rollball_mii_poll(),
SFP+ modules from no-name vendors=C2=A0 seem to behave slowly.
This gets even worse on embedded devices,
where power constraints are in place.
i2c_rollball_mii_poll() could timeout here.

dynamically increase waiting time, so the phy gets more time to finish th=
e job.
It it beyond my knowledge how much the target gets interrupted by a poll(=
) call.

A better method might be to add a kconfig option "allow very slow SFP MDI=
O",
so strict timeout errors can be detected where useful,
and be avoided when the kernel is built to work on embedded devices.

Janpieter Sollie

--- a/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-19 16=
:35:52.000000000 +0200
+++ b/drivers/net/mdio/mdio-i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A02025-09-27 14=
:11:59.406323627 +0200
@@ -248,12 +248,15 @@ static int i2c_rollball_mii_poll(struct mii_bus *bu=
s, int bus_addr, u8 *buf,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msgs[1].len =3D len;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msgs[1].buf =3D res;

-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* By experiment it takes up to 70 ms to acce=
ss a register for these
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * SFPs. Sleep 20ms between iterations and tr=
y 10 times.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* By experiment it takes=C2=A0 up to 70 ms
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to access a register for normal SFPs.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Sleep at least 20ms between iterations and=
 try 10 times.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Slower modules on embedded devices may nee=
d more.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Dynamically increase sleep to avoid wasted=
 i2c_transfer_rollball() calls
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 10;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20+2*(10-i=
));

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_tran=
sfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)


