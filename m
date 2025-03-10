Return-Path: <netdev+bounces-173523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D91A5945A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7750E188BEC5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D02288C6;
	Mon, 10 Mar 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g+sNguYq"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C357225413;
	Mon, 10 Mar 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609636; cv=none; b=AZh4lkDKHu4CKfodoXqy+QMDlemRkXGpdse3NTAcwD55v4xjKe9EWgAs0jIrZKkAvrJsEf/mn1nKfnz0qUuZSmbJ36sosXih/mlNyYeCXUvYmlSZcmIEYmnLmekHD5GKcpDPABIBYv9M0z5L7/BAZbvFaQrqh+cs6VFShd0EX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609636; c=relaxed/simple;
	bh=vK/TgnIZyvdL0hDlShnuvalPvRRxRIKI1qEKWTLREVA=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=oTUh91oFocaGHAy9mBconoWLtg/S3eoKZDA9PKFUl6/+1TNkaFKt9XCo0BIQAPEb1RU4Zr03/wXcwpcQZjQANJ06GTRJdkUQ8/vCMPfNNdxGniDqJlGH05dxGTjehiBt8E0Zg6wsk0nJvvkr90HAz/WoyW9GD7G2xVlOdxylGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g+sNguYq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741609620; bh=WkCx060iOy43w4Yye4pXYXhvwRUF2PXnYXTMpaw7xas=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=g+sNguYqcku0ZeaZ/ngWqYceajbkSvb1W+O12eT2gUfvZ97o/BXmQnj6v1MoXz9VR
	 QvqMD7O9Zz8ZYxm5znMf61sA0K03DkKY8kzlvSr2jjj71pFbUJtGTlTNQicPKkUEV4
	 xZwdiFPragetD/EvtjJzoCxA6PnosDvi3YnnH+Dw=
Received: from smtpclient.apple ([59.66.139.231])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 66F0309E; Mon, 10 Mar 2025 20:25:47 +0800
X-QQ-mid: xmsmtpt1741609547tqvjfmzyd
Message-ID: <tencent_7C72D4006818B37C695B066E0AFD5F94380A@qq.com>
X-QQ-XMAILINFO: MF096ickW6xYEl/mYlfV9grOILopNqOQoEmD1Cp6RVGcFTcAXEHvfJdU6yPp55
	 hTsB3CfZdbJ0eHBlqOOmgnzuhNthp5TQcdIaezX72nDWS6SqsfqaBAiDJ6MujraDxyN02KnIBlRi
	 qIDVOSBHrU9MI92SPRjcM96ec/aFYCtISH5Ub9Wxi3Wkek/JGznunt5mRnm/ggJ8qJrpIuwBUSpI
	 dvFFVOoZPNl5LwrpLDjxKTXb1U+nXQB4iNx42bUDqnYJHdU3ZzNh0mTYZg1nHiqgIxOyWXGqMJq+
	 43ZvZuzSeezokMN6H+7iZqARRyZ48I7kTo68AgTypkkzmMe/eChagCxr+9yXntoorpWpM6WgUHed
	 Q1ZzayxdHpwfNPTJwkr7ysarD9pL5CYoInif4iCqUBnVxWTM899/ex/hV4Z9KNMB+BFlPMwosg8l
	 6U/HfBGZoTKlpipRtwRGmyGBLY11Hiau/oaXHOHyvldog/p5jBLjOPZuuEadoCMzPjZzKoArEijk
	 Xdyh7MW+hNU9FjLmYuDqILxVQhTKN0oHf8fYC00C83VT0w0WL1W43EmbtdWddyUKLngQtfBPqrBw
	 xV/8gHNZQ9dVlx+7B6yMeJBKYrtQQgT5qvHZN96w5EYbx6rpAHhORMN6aUdnmzqBUNs5U0VJBPMo
	 1CJ2InWR+Ux0gLACPJKAjoyfmYGupHwJValAQLPlx7nvgxz1CJidKFiPsuebC653NGbGG5GF4tt5
	 l8h8GehvKik7A0q30q1Lb864S8r9YASO18KDgjEnaYGNocCQ7VzX4XLSJuBWb+y0SVSSInKXD/Wq
	 n0XcBIdHaesJxaYgsDOFTaZNGF4oSoziYgk1yj6kb8HngzIhoON+O1A9lFTfW3c+hkOOFKAI7imm
	 L2NXFb5HPhEKtGrKudi4MxmzZd2cZzDnpSxlfj3IwCrTjGdPKd1G2eHeEKBZAXxHQ/kK5wXLuWdk
	 X1k3T0SoppLfVHzm/6XAxzh0qKX/6dsk8iyvkx9XkBQf5Lx3YtWCJP/4p9zwz6XvMRa78DyQY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 1/2] net: enc28j60: support getting irq number from gpio
 phandle in the device tree
From: hanyuan <hanyuan-z@qq.com>
In-Reply-To: <c8553dc9-2d8f-4d4b-a381-f87660c2ee99@lunn.ch>
Date: Mon, 10 Mar 2025 20:25:36 +0800
Cc: netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D289843D-4962-4A6A-897C-0CF4A53A7EAF@qq.com>
References: <tencent_83CBDD726353E21FBD648E831600C078F205@qq.com>
 <c8553dc9-2d8f-4d4b-a381-f87660c2ee99@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 20:18=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> My embedded platform has limited support, it only provides a
>> hard-coded pin control driver and does not support configuring
>> pinctrl properties in the device tree. So, there is no generic
>> way to request the pin and set its direction via device tree =
bindings.
>=20
> So it sounds like that is your real problem. Please write a proper
> pinctrl driver for the SoC you are using. They are not very complex
> drivers.
>=20
>    Andrew
>=20
> ---
> pw-bot: cr

Hi

Sorry for my previous low level mistake on the email format and
thanks again for your patience. I agree with you and please ignore
my patches.

Hanyuan


