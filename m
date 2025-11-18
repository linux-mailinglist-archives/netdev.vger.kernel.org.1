Return-Path: <netdev+bounces-239735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A050FC6BD6A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AAEE029BC1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0332D9499;
	Tue, 18 Nov 2025 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcIQsOLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7F81724
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504262; cv=none; b=aeSZ0N8n0mukiQkjld4CZNMo8vm7IsiAKdFeCmArqEnBiLrvn+T2b9zX/SkSrxbcpteGGOWF+qutRSNdhN+Im89BUnCaYJqWwzYBi4k9jUtzKwhtor5o2peODNb8SVlGN9/mJ5kLBjTffmNohmcIbujIQ6+UnWUDRVB4/PptV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504262; c=relaxed/simple;
	bh=Fm1hMJEKvc3TMM35FxahGHGLObZ3balopH1Jpupsryw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9Fgvr6ZOibadZBG1s+ivJaiTXrU2R+yk+JcxNC9Hz0aAYPmLq73KXu2zGV9U2OLbxNVt9EmHQLpmOt3pCqbd+iJHxfYeGE88/oxapFJrqhchJgp/pEDwiryvvibWZlV6sboDLy0rUoO3wNmiWQ5IX1Ej0GKCn9QVil8+ttrW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcIQsOLT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298250d7769so41420555ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763504260; x=1764109060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fm1hMJEKvc3TMM35FxahGHGLObZ3balopH1Jpupsryw=;
        b=LcIQsOLT/JDOCNxKCVcevVHZQ5QzaYBso9Guth4a3g1Z1StnN6vdPYXuj4mcem79aW
         meCb4geWuTvbpr2pjjh4aT0PEnyidDKnCvW6cNibxsoykqP/0BEygPztyIqap00tT1zX
         GRb4uqQhpPw3OAbS/urQWkgMR0ERqoOvU0sMuGQe+4ZypshsciFYzRFVpgK+xI2ZEw/D
         9U4d5QwnKMfNjxR70XS3hlvKbDc5Av+7apa+4l6zZzXYF4lpq4Ly8lW53d3nVkPBj3l8
         nybXKO4zrRolirCCPCdmdP4AuMlqjB3uBoCkNO3bRHL37aHBtBWMtgCS3Fm30dMfnjsa
         nbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763504260; x=1764109060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm1hMJEKvc3TMM35FxahGHGLObZ3balopH1Jpupsryw=;
        b=b39GPP+Gi/NXlvmJz8Y8z/snNQdNcd9+q3L+t7/2eL7o0b845biEHWYDpOcPXlYO6e
         cNC9VM5wT+ktUIp/Clfpeebws7TOw/fuk0FId8qA1Xb0FjF3dkKhG2QC73sMUcEjaWzl
         BMbeCBqO88q268WwVIZZStWbzzqCjLrzOM8ZeOxMocYYMS/TCweSNtAIfUi5VfR/SRuZ
         Mvsfy7Rn3zZ9XMf6x3ZNYtNJCr0ABzmdTRHA8aFnq6G4Q3mnMGhelXk72mdZSY2C9tbz
         nixOR4grknezCprwK54Q0Wa6rLjIVjSMpI+4NY42jTfDRXDaL6p71ZeKgksCTwQqS7Ik
         ms6A==
X-Gm-Message-State: AOJu0Yygvb4xCcAEnm4QBxhCqHc6F9mZdd5VAEG426s4rS3YJp6v3Ptn
	UEWLXNs65wkAgQLsl7ka0jNSBxejgu+S0zM/fW4UFLCmwY5n1wHRmJsksPJOKQ==
X-Gm-Gg: ASbGnctF66GEj6BVYVD4BldmwHHQzt7RMsI7MvSvOGkKZbME1Ww9PzKFS7OxC7yeCfl
	vDIxIsUdARQZhwkzXgGinFLs8RRzjPB1LTtnDEHI/pNvHPToHG2qzJ93au5twyMER11GgOb3uPx
	OkBA12iMK/2yUk+uv+JKK3bX8qMAYOm5k/z+wStl/14imPGOwumC5zT1vBO4ZTh557SFGHE4OoV
	oNO/G/Y5AiZnr+vAfemct7Pzq6RGFDlPqunOPaZ/ULYcqAJp9DGKV8KVvx9GnaAw7GogB7Bml6Z
	z2/L2W/Vd8fRZQMp9WZUdbI9zN16HTOlha+KiJe2uN8jzZkpC3LVA0nUHplvj0j6aFk02go5GSy
	ia60Zov7MDgz6OLXbGu0ap6jfQZn25O+SuLWpvQUOlPc7rtK2zkZGm15rOSBoFlo9u4RYS7VJ/E
	gMgH3WRws3/lcccqmwYu4hAGBFArMEedgRDLc=
X-Google-Smtp-Source: AGHT+IFcNSQ/fYHdGTePk8jD/2uQ87pIirOUY0L57cyTe2jz+9VH/BgcC2J48tjVnzcdiqIc6RZ28A==
X-Received: by 2002:a17:903:350d:b0:290:94ed:184c with SMTP id d9443c01a7336-2986a6be347mr197352315ad.15.1763504260341;
        Tue, 18 Nov 2025 14:17:40 -0800 (PST)
Received: from Sphinx.lan (58-6-247-80.tpgi.com.au. [58.6.247.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e54f019sm148640845ad.15.2025.11.18.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:17:39 -0800 (PST)
Message-ID: <4f40294f6e970c7c39c5eda9c98fe212005e4af4.camel@gmail.com>
Subject: Re: Bug: Realtek 8127 disappears from PCI bus after shutdown
From: Jason Lethbridge <lethbridgejason@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Date: Wed, 19 Nov 2025 09:17:21 +1100
In-Reply-To: <cc1c8d30-fda0-4d3d-ad61-3ff932ef0222@gmail.com>
References: <6411b990f83316909a2b250bb3372596d7523ebb.camel@gmail.com>
	 <3a8e5e57-6a64-4245-ab92-87cb748926b5@gmail.com>
	 <de12662baa7219b4c8e376a9d571869675a9a631.camel@gmail.com>
	 <cc1c8d30-fda0-4d3d-ad61-3ff932ef0222@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> ethtool -s <if-name> wol g
Running this command resolves the issue regardless of the Wake-on-LAN
setting in the UEFI is enabled or disabled. If the command is only ran
against one of the interfaces then that interface will appear on next
power on while the other won't.

On Tue, 2025-11-18 at 22:43 +0100, Heiner Kallweit wrote:
> On 11/18/2025 10:09 PM, Jason Lethbridge wrote:
> >=20
> > > - How is it after a suspend-to-ram / resume cycle?
> > This machine is having trouble resuming from suspend-to-ram. I
> > doubt
> > that it's a problem relating to r8169 however since suspend-to-ram
> > doesn't work properly even with r8169 blacklisted.
> >=20
> > > - Does enabling Wake-on-LAN work around the issue?
> > r8169 behaves the same regardless of if Wake-on-LAN is enable or
> > disabled in UEFI.
> >=20
> Thanks for the feedback. Enabling WoL in UEFI isn't sufficient.
> It has to be enabled also on the chip:
>=20
> ethtool -s <if-name> wol g
>=20
>=20
> > > - Issue also occurs with r8127 vendor driver?
> > The "10G Ethernet LINUX driver r8127 for kernel up to 6.15
> > 11.015.00"
> > from 'https://www.realtek.com/Download/List?cate_id=3D584'=C2=A0builds =
and
> > runs flawlessly on 6.17.8. The issue is not occurring when the NICs
> > are
> > driven by the r8127 module.
> >=20
> > Drivers SHA-256:
> > ab21bf69368fb9de7f591b2e81cf1a815988bbf086ecbf41af7de9787b10594b=20
> > r8127-11.015.00.tar.bz2
> >=20
> > On Tue, 2025-11-18 at 20:49 +0100, Heiner Kallweit wrote:
> > > On 11/18/2025 6:07 PM, Jason Lethbridge wrote:
> > > > Hi all,
> > > >=20
> > > > I=E2=80=99m reporting a reproducible issue with the r8169 driver on
> > > > kernel
> > > > 6.17.8.
> > > >=20
> > > > I recently got a Minisform MS-S1 which has two RTL8127 NICs
> > > > built
> > > > in.
> > > > The r8169 driver works perfectly well with these on kernel
> > > > 6.17.8
> > > > until
> > > > the device is powered off.
> > > >=20
> > > > If the device has not been disconnected from wall power then
> > > > the
> > > > next
> > > > time it's turned on both NICs appear to stay powered down.
> > > > There's
> > > > no
> > > > LED illuminated on the NIC or the switch they're connected to
> > > > nor
> > > > are
> > > > they listed by lspci. The only way to recover the NICs from
> > > > this
> > > > state
> > > > is to disconnect the power then plug it back in.
> > > >=20
> > > - How is it after a suspend-to-ram / resume cycle?
> > > - Does enabling Wake-on-LAN work around the issue?
> > > - Issue also occurs with r8127 vendor driver?
> > >=20
> > > > - The bug occurs after graceful shutdown
> > > > - The bug occurs after holding the power button to force off
> > > > - The bug occurs even if `modprobe -r r8169` is run before
> > > > shutdown
> > > > - The bug does NOT occur when Linux is rebooting the machine
> > > > - The bug does NOT occur when the r8169 module is blacklisted
> > > > - The bug is indifferent to either NIC being connected or not
> > > > - The bug is indifferent to CONFIG_R8169 being in-built or a
> > > > module
> > > > - The bug is indifferent to CONFIG_R8169_LEDS being set on or
> > > > off
> > > >=20
> > > > Attachments include `dmesg`, `lspci -vvv`, and
> > > > `/proc/config.gz`
> > > > from
> > > > the system exhibiting the bug.
> > > >=20
> > > > I'll be happy to try any patches if that helps.
> > > >=20
> > > > Thanks
> > > > -Jason

