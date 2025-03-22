Return-Path: <netdev+bounces-176851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14792A6C868
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 09:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8123B087A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF71D5173;
	Sat, 22 Mar 2025 08:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3611C84C4;
	Sat, 22 Mar 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742633484; cv=none; b=KiZJ2H3zRSizuyNFQXpB+kjJU7Dn0FpEAVFampgtUKWNo2zNxOOQYU/NrcOml744s+VP9AcYQT5F9Gme6IEc1+r/3sP6WOW3GKio8oI1tRvIEJ0p2z0ndPbbJCSHM1vcrtYvuDzboQpsVsdOyWRLp4BoHt4UFheS8SmqzzBVieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742633484; c=relaxed/simple;
	bh=At32rju/yV5aLauwKsQSs8qJKaXZha/WRnvle3eQCWE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WngHEpBhFrr7aFHm3jMcoC5kAruUFq7pcahd2gIzEW5OWnqdfQGEM5Q1s/0T9TGOBQWtkkAnclHWs2jhEKwfpCFlQgmShFmpRLPM42PBLBzzmOGHCwDExSGc4F6qjJNI8RKZp40kH5NGMnGxcNKoYYCdYcgnLUI+QzJfXC3JoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.53.6.152] (tuc-211-227.hrz.tu-chemnitz.de [134.109.211.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 548BD61E64783;
	Sat, 22 Mar 2025 09:50:56 +0100 (CET)
Message-ID: <49df3c73-f253-4b48-b86d-fa8ec3a20d2c@molgen.mpg.de>
Date: Sat, 22 Mar 2025 09:50:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Keith Hui <buurin@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: r8169: MAC address programmed by coreboot to onboard RTL8111F does
 not persist
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


Keith Hui reported the issue *MAC address programmed by coreboot to 
onboard RTL8111F does not persist* [1] below when using coreboot:

> I am producing a coreboot port on Asus P8Z77-V LE PLUS on which this
> issue is observed. It has a RTL8111F ethernet controller without
> EEPROM for vital product data.
> 
> I enabled the rtl8168 driver in coreboot so I can configure the LEDs
> and MAC address. Lights work great, but the MAC address always
> revert to 00:00:00:00:00:05 by the Linux r8169 kernel module. I
> would then have to reassign its proper MAC address using ip link
> change eno0 address <mac>.
> 
> The device appears to be taking the address I programmed, but r8169
> reverts it both on init and teardown, insisting that
> 00:00:00:00:00:05 is its permanent MAC address.
> 
> Survival of coreboot programmed MAC address before r8169 driver is
> confirmed by a debug read back I inserted in the coreboot rtl81xx
> driver, as well as by temporarily blacklisting r8169.
> 
> Vendor firmware is unaffected.

Do you have an idea, where in the Linux driver that happens?


Kind regards,

Paul


[1]: https://ticket.coreboot.org/issues/579#change-2029

