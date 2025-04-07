Return-Path: <netdev+bounces-179844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AAA7EBEC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03350441E9D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8D2288D2;
	Mon,  7 Apr 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfAzk2gr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B3209F43
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050065; cv=none; b=Fze4rDtL8JN8ufxRwNhCjpgEv6C0oAK+QOefGCkGJyS08rWnU/xxjbcY1RWZJ+R5Rq7TMH+SrqcDmZCKhUbBfPRfIS3MmIFlZv8/GTq2Y7NijibsW8MB9krScSjl38IZ1Snqh6XMmflghqJAZdZkIvKQN15PTEKvvZeFZgCqaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050065; c=relaxed/simple;
	bh=8D/71t7XnMqU/Lte39FaN2DJ0R2inooJjEMShEvaKG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ubbrog+xuyEV8hofvbNZBkPV9hbYZrXT9p/EnuKmpw+hZh7adgk8vas6o6vft5h+ljs2Px0VhMEYmH1EZ1jSM+iRg8Stq7+mECtiU0UQ6nsRg4bX2cyAAv/7+pKQTRy3MqdeMB0qxk0K87qrwzAxECBQWXGEANfztoMIfI1MQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfAzk2gr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso31136255e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744050062; x=1744654862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D/71t7XnMqU/Lte39FaN2DJ0R2inooJjEMShEvaKG8=;
        b=VfAzk2grok5JvpcU7dNTsQG5ZwLbvVYrOzblWS3xamiEp49OY/mEQu4rASyRv/OWBN
         t71m7kmPG4jBXKv1vgFWvEJYTrAWwEXOeqQRXrlFzhE3ttJcWUJaQIAe2eiGsJKOl9aF
         +zTZF2cgwzD4QVMK8TsI7M4mmWbv2uu+zjQ3+4Cq/rDDUWvZyIpgHOik9N1zhg/S2/qK
         HV3E2K1l++DlTLYFAYQanBVZn8/Yt7OhET6+tBsxJ3cZwnM1AmWPlVJmTmkeifLi3ivo
         yr0ejbhxp44DRVbUTMVE3F2tXMD3v4f43Vv9mg1YCBlZMjEj/uEbFAOwrQWgV/0pVDP2
         kKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744050062; x=1744654862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D/71t7XnMqU/Lte39FaN2DJ0R2inooJjEMShEvaKG8=;
        b=pUVDioQEfx2r23rzWhVzOC4J3O71WKVqNdpwxbG6lMQ0V88Lqgtn5E37XoAc6E6ryN
         +m0fCitsdj46wLvDcwXwT2vHwd3dA4N5Ju2JVxWiJpy0a5RC+x+9nwV0I9y6OzIC8L12
         aI7c5pK+6QwI7a3oWerERkGtg/4mTcylfaX0G2hyBdA0cJvzHAJTvrJ+iu0U6o+x6vuX
         TiGVZrw749/ryNS9EO8H4vd8Lya1y6rVPS3mbN4Ps8szltwCSeLZzVhbS+eSrZtM6FMN
         QDa5jtGkdgzJdmzI3J3KXdzh1HZrF24bnDgmxUofXLJ1QXWzt0G07sSm9x5WT9+1ijwo
         T6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7JDE6irBxhwLamklI9Vxhe8PV4ctNxkJO7ZAFOyjSx1eAX4m+RTqK41yWiehdNvCTEMxryAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQ4O0ms5boT/yRITGwRax+uAd6n84oexo+Ki1Fi0M8VQtwWdE
	+ENrmHLl7ebKMFSYF368rg4SMx4iaz7wkJ+TEz064Gfmue6+QkvJsKuB+EZBeM8L6sD4EVYBXhT
	afNUjt7bOjPSkmUHILvfZKG2ulyk=
X-Gm-Gg: ASbGncvpvgvwBHaTuLgmAPwqU47NvVWE0wC7+UbhcmBEqyLADhlEiaxHdwofXs78Ee5
	t8B3d7vrXFimhtC235Iy5m7jbyPNlinAXR+AmhD78kQEM1OPfDlJ7jUBbBwWPgiB16VwAYaPBkN
	50aT8gCYnDQYP7hegCS164+VQT0iqar6ImuxknNBBEAtL34ljKQmkjlKDhIc0=
X-Google-Smtp-Source: AGHT+IHEXbai8re53y+ucJ0ZDMDF9PL4C70QJjXniHWg7AJxLBqVKdIfV3u2aKKrAl6FOneRvfNMR+YHtbOp4dRxDgE=
X-Received: by 2002:a05:600c:35c5:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43ecf8cfb86mr141454555e9.15.1744050061537; Mon, 07 Apr 2025
 11:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch> <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk> <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
 <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk> <CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
 <20250407100138.160f5cb7@kernel.org>
In-Reply-To: <20250407100138.160f5cb7@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 7 Apr 2025 11:20:24 -0700
X-Gm-Features: ATxdqUFovVv1rB1Wh9LBK7fz-0h8zFqFOpNphe2UTV7vTFKzBhRqw2lILENxzDs
Message-ID: <CAKgT0UdaeXS=7YTnTSdRO4hyNrSbxuM3pDdmE=1JCvkizUYrZA@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 4 Apr 2025 09:18:30 -0700 Alexander Duyck wrote:
> > > > Yep, this is pretty typical of SOHO switches, you use strapping to =
set
> > > > the port, and it never changes, at least not without a soldering ir=
on
> > > > to take off/add resistors. There are also some SOHO switches which
> > > > have a dedicated 'cpu port' and there is no configuration options a=
t
> > > > all. The CPU MAC must conform to what the switch MAC is doing.
> >
> > I don't think you guys understand my case well either. You seem to
> > think I am more flexible than I actually am in this setup. While I do
> > have the firmware I can ask about settings all it provides me with is
> > fixed link info. I can't talk to the link partner on the other end as
> > it is just configured for whatever the one mode is it has and there is
> > no changing it. Now yes, it isn't physically locked down. However most
> > of the silicon in the "fixed-link" configs likely aren't either until
> > they are put in their embedded setups.
>
> I understand this code the least of all of you, obviously, but FWIW
> in my mind the datacenter use case is more like trying to feed
> set_link_ksettings() from the EEPROM. Rather than a OS config script.
> Maybe call it "stored link" ? Not sure how fruitful arguing whether
> the term "fixed-link" can be extended to cover this is going to be :S

Arguably understanding this code, both phylink and our own MAC/PCS/PMD
code, has been a real grind but I think I am getting there. If I am
not mistaken the argument is that we aren't "fixed-link" as we have
control over what the PCS/PMA configuration is. We are essentially
managing things top down, whereas the expectation for "fixed-link" is
more of a bottom up. Where that gets murky for us is that the firmware
in our case did the top down config and is just notifying us of what
it did.

One thing I wasn't getting was that pcs_config doesn't actually set up
the PCS. If I am understanding things correctly now that will be
handled in the mac_config function. It will need to adjust the signals
running to the PCS IP in order for it to get into the correct PCS/FEC
mode, and then the PCS driver itself is only using the mii interface
to access the registers on the device to tweak things. It isn't
actually responsible for changing the PCS interface mode, just taking
care of any remaining configuration setting things such as autoneg
advertising.

The other thing I realized is that it looks like we might actually end
up using the XPCS driver. I also think I understand somewhat how they
may have things working as for the 25, 40, and 50 speeds at least most
of the management can be driven by the external pins so you can say
whatever you want about the config, but it will set itself up based on
what the external signals are telling it is.

The only complication is that we have a PMA/PMD on the end of the link
handling the role of CR PMD and it is behind the firmware so we will
have to see what I can do to make this all work. In the meantime I
think I can build things up slowly as sort of a reverse onion working
from the outside in starting with the MAC and working down toward the
PMD. It just means it will be a while before the upstream driver can
see a ksettings_set call as we will be fixed with the XLGMII interface
at the start until I can pull in the XPCS driver and then start
building out both at the same time.

