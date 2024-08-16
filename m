Return-Path: <netdev+bounces-119256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F0954FE4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E7C2818F1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F21BF31C;
	Fri, 16 Aug 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="lq2t3IZV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBF1BC067
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828747; cv=none; b=Y4M+47JTva7at3x/QY2Gn5/HUjO+OAoqGpp5TG4DPWDKB2wP/bjJHZGCKu2r4Sw9cSnn1DmL2H17D9TcCABZ+L07bhTlBr+BL7VfgrIguoSYM+LgWP7lehjCEbabjzeWBP8PwxQOdOeO+jp/FoWKAJM7u5aj/7Ehjuf9I9CTCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828747; c=relaxed/simple;
	bh=tgqG3TeqTeZOFhwCublZsN/IJhXBEcZamsGcYAjPc0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evhqB7PF9CmdoEffHu5TxT7ST7JRdnPV1JFbLTMw0befPqcbwaSx2b29VIniG0X64LXFY4GAJGiBXxAOyP3fXJb/Il+rxMuAEwvS3Mm4ApdOv17lRgJt9wM3EesVIfVRaeshBSxNV5HHoDGsJsw91DL1PuVhd4PforyxkBLuWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=lq2t3IZV; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723828728; x=1724433528;
	i=foss@martin-whitaker.me.uk;
	bh=e1XpSjp00q+hyYhtYini4hedWN48eN5y61wq9kLfwY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lq2t3IZVFm9zQHMrgHigQabrHbwEsCtBsxdhar4fz5mDXSM68WjT7STHoXZNXfEv
	 4RBcu+hW3L+x5xCjxLE6mBJN9jTyEvCpNLBZkw8pn01VF2j5hyxj6dwqQRuLnxdAX
	 FvrX3TKQ0cnYgTUC0qdDeknNQEUXvLTm+a3MG04eyqRLNUcDwBwsgCLKC9IfGzTM3
	 F7oVTGU19XhtcYAiYtGC0+eRQCQSUypwY8S7FBBgbFRkArf67JFBH62Q4j1pDmhG0
	 tvp8A3x7fNVMw5iDBxJrV3C1YeOGWli247+vOwWPanklcOaWcxGsFtQT0vbOV0SZ5
	 jjZJyh0+eSO5QfLRZg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.14] ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MHGPA-1sRrR21VmS-001GHZ; Fri, 16 Aug 2024 19:18:48 +0200
Message-ID: <b21de19d-db51-4d8e-b9be-d688f1c71be2@martin-whitaker.me.uk>
Date: Fri, 16 Aug 2024 18:18:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: microchip: fix PTP config failure when
 using multiple ports
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, ceggers@arri.de, arun.ramadoss@microchip.com
References: <20240815083814.4273-1-foss@martin-whitaker.me.uk>
 <f335b2b8-aec7-4679-993a-3e147bf65d1d@lunn.ch>
From: Martin Whitaker <foss@martin-whitaker.me.uk>
Content-Language: en-GB
In-Reply-To: <f335b2b8-aec7-4679-993a-3e147bf65d1d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DnlSBwS+vu+7La/kx+E/0WyS5hmVbYwOsLk4YYhVE5FJUblYDTJ
 vZjKaPjdKq9dIt8ttmWR3O2f2C3YXzaMvjZe6fKvIs2D15HKgIFz3HSeC0DVYyyGwOxwWb5
 a1quGOLm/P2SjRdrzklcbBxW9UAwn5bFp0r/jB4bWck3QvRxvEHE2VHupBModT409sfc192
 4E/3XhIkPJ8dc9l3n4PUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mqwgUOvN41Y=;/4maKZ6wawzQ0+/RtN53dlj6O5V
 mCftwddKrBDpG2j8lc+5SGYqPOdHT8bkkB2WqhhykQg7wdefo7RlY8wd3kiUllXJlyOytcimo
 6+xeIVXk4G4yfsuSrjLsLNTL73MYhaL7APPqemsD52AhC2Yo8mDZ6x+XWA7BU3t5yDEO/AXNR
 cgWhQHx1xqSHOEhqSeNMVO046Xs3uuUJI13qx/GJuD2dX4K5lH5idIuVbGSnc976tGF9l/ZuB
 FA3mwzzMi9OOGZFKvr+PjUKs9BhU/dzbbseQumLEBVc0iBXRdX7PjZE0yUqRdr2UKmD1kF4kl
 4XEQ8raHgXmgeYvxko1i2VK3684ok7o3MMLo6niaIU5ma/jrdsNUY6K2y37ueFzrosqeFyf+9
 ORi/TCzxnnPkahtURv3bMLh2ymRcxCimusdLUiGmrKfVHO+OmKj2G4M+Fyhw0UbM0dkwbYQZP
 QW4S3FKKomEh9KRouy+/E0i9KJeNhIFLzN2fDE+4m1WWgKlMP5mDVJ+uty/xgv946FJmV7Uzo
 yGRT9NE2FF++EqQVDQBljgFI7nzbdDLupr4B++1KgSNq7QByEM3q8u0Lcz8nlPa51vfKFRyuM
 jQ6AEpW/lTEylcRrRbubXRkwcW259JH58SDuyQiddKvGhFNlGuhkhmNksiqPJPJb57Xev0h5F
 Qu9J9Bjla7MZswUBZrdwT085ILiGfXS5zqirF6yBTAETfwIwLWpgo+11ObX6oG2q6lQNKHkYu
 fh3ncXoHzQxrG/+Zp20RJ0VGGbpziS0ww==

On 15/08/2024 15:38, Andrew Lunn wrote:
> On Thu, Aug 15, 2024 at 09:38:14AM +0100, Martin Whitaker wrote:
>> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
>> will be called if hardware timestamoing is enabled on any of the ports.
>> When using multiple ports for PTP, port_hwtstamp_set is executed for
>> each port. When called for the first time ptp_schedule_worker() returns
>> 0. On subsequent calls it returns 1, indicating the worker is already
>> scheduled. Currently the ksz driver treats 1 as an error and fails to
>> complete the port_hwtstamp_set operation, thus leaving the timestamping
>> configuration for those ports unchanged.
>>
>> This patch fixes this by ignoring the ptp_schedule_worker() return
>> value.
>
> Hi Martin
>
> Is this your first patch to netdev? Nicely done. A few minor
> improvements. You have the correct tree, net, since this is a fix. You
> should add a Fixes: tag indicating the patch which added the bug. And
> also Cc: stable@stable@vger.kernel.org
>
> Thanks
> 	Andrew

Hi Andrew,

It's my second patch. Yes, I missed the Fixes: tag. It should be

Fixes: bb01ad30570b0 ("net: dsa: microchip: ptp: manipulating absolute
time using ptp hw clock")

Will you insert this, or do you need me to resend the patch?

Martin



