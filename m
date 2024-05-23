Return-Path: <netdev+bounces-97894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B28C8CDB47
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F298C284178
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10DE823AF;
	Thu, 23 May 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="IVR0eGaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15484DF9
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495565; cv=none; b=fYT50yxsRCwPDwf+2r3AbJ9uxAqiIspt6tCWLA3Qeg16ttJ2nsegV5x48h7UHCbkrMz+hPb8qXX73KwWUNwdzeY60zSUmnGs0B1tOAgfaROsIQIrmIApvYj5lklYnS++nTVzzBn44Kt/jLMXVQTb+VIVy4EwBwf1V5H0OH0hyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495565; c=relaxed/simple;
	bh=+7RW3iQ9z30pDv0i0aKuBqbzu4DqBboYT9/8JPzC1ZA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kkkuxwtbGG74+RlDrsG1u75M0e32SlzsSf84TeeGZPivxwIr2OsXAlwwbOGp3JPz5+d5wkpMWdKF29xbsO0M/UtsNFYf+/wCfMoOLHe3q9RzzlPLJIswRn3YSsbgXU85XBxvZTKnvuzcNzaVt+Nd4moszE4e38bual2UERICtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=IVR0eGaZ; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1716495560; bh=+7RW3iQ9z30pDv0i0aKuBqbzu4DqBboYT9/8JPzC1ZA=;
	h=Date:List-Unsubscribe:From:Subject:To:Cc:In-Reply-To:References:
	 From;
	b=IVR0eGaZoske0Gyl8Oapk2BIvspIIZDILKRGdW8FboRhmTMEMRTRvVLrPuC8rz+24
	 xeiDu5kBu+kQMUb1Gq+AKMtMBqeIZPKYWy9LAOmEG5p1XqqL/QQRgIQyW5ueVWkGN4
	 Tyj17hlgt2hAuK7pZ/YqNS1aGAvUUevBIE3DwRzJhFKmcadCnqxvHwbPgBNuTdCABL
	 5tNqjhkpTKfEcYpSM6vWiFrlw6C1SDzW94BeExX0/G1BE6B0hMTNRCvpFPEougf41B
	 QK2lJNWOA9ojGUH7oiF+cZYtY8jTy+1EIGcfcRVgyiodM/Bh6EK9+Yay/HC8U/2vdm
	 3qqnIF/aZ4e6hx8UC7kkDz7kL2q/R3Gd8roF/O/8EIphfGgRCQpPfH+GIcZLgfeCdp
	 NumiwXzV6XCig37T5XJNV5Hqkl1Yd3Ik4y/kVDgKxUwrSBhOjczoiV7rM+LhCDiy1N
	 gR3O7X4DY7AW16Z68qOfXxYXXL4kmlcvoNn1t4DOzHyTvA2oymY8No2CKYBd2dre2Z
	 tiatVsuC8aBWRoYMTkE+Wmh0YDVDMqfXOnouUVCPpy3tUamHat+EzK1Zs3AHDi4gz0
	 esOLI36Fog5/+uRvAOlsvEkyyHXxBYjw+P3d3UeHjRXoHZUKckow69Y4bGfQllLyR7
	 8RJ/QoH/2IeYDmj/z5/B7oDA=
Date: Thu, 23 May 2024 20:19:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: kernel.org-fo5k2w@ycharbi.fr
Message-ID: <3531fc467a80bf02b83b94707fc3039b51ecd4c5@ycharbi.fr>
TLS-Required: No
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: "Jacob Keller" <jacob.e.keller@intel.com>, kernel.org-fo5k2w@ycharbi.fr,
 "Jeff Daly" <jeffd@silicom-usa.com>, "Simon  Horman" <horms@kernel.org>
Cc: netdev@vger.kernel.org
In-Reply-To: <decbaab6-a9ab-4aa3-9285-0ffa98970c59@intel.com>
References: <decbaab6-a9ab-4aa3-9285-0ffa98970c59@intel.com>
 <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature

> One more thing: Could you confirm if this behavior appears in the 5.19.=
9
> driver from the Intel website or source forge? I'm curious if this is a
> case of a fix that never got published to the netdev community.
>=20
>=20Thanks,
> Jake

I can confirm that the result of the =E2=80=9CSupported link modes:=E2=80=
=9D section is identical with the Intel ixgbe-5.19.9 driver:
uname -r
5.10.0-29-amd64

apt install linux-headers-$(uname -r) gcc make
wget https://downloadmirror.intel.com/812532/ixgbe-5.19.9.tar.gz
tar xf ixgbe-5.19.9.tar.gz -C /usr/local/src/
make -j 8

modinfo ./ixgbe.ko
rmmod ixgbe
modprobe dca
insmod ./ixgbe.ko

# eno1 is up
ethtool eno1
Settings for eno1:
	Supported ports: [ FIBRE ]
	Supported link modes:   10000baseT/Full
	Supported pause frame use: Symmetric
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  10000baseT/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: 10000Mb/s
	Duplex: Full
	Auto-negotiation: off
	Port: Direct Attach Copper
	PHYAD: 0
	Transceiver: internal
	Supports Wake-on: d
	Wake-on: d
        Current message level: 0x00000007 (7)
                               drv probe link
	Link detected: yes

