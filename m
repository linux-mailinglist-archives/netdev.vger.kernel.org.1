Return-Path: <netdev+bounces-155301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C184A01CB4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 00:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726947A157C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FEA1D6182;
	Sun,  5 Jan 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="EIEHD50V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB261D6188
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736119834; cv=none; b=S2VL6Yc/yoo4MMhlHBU7Rxsnots+Isdn/rmCyl2+j1axDPZb6f1wHFWYYz3AvDsMSo9nzLue+dPVGZfC2RzHjjVzm12eF1J++UNmoZrR6+PetOBc+YBBWzwAWqPLk1evhyGvh5RFSr1BqxbG6Bcv841v5l06MO9bYt2kYoe8I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736119834; c=relaxed/simple;
	bh=EpynQ9nW8kIVP8kcKLlLLnja814bTO/NCR8uMbFGz3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTjpNu+SJks+JbHuIoe18mYjN43MEPbFzqfqGBBu1OOw3mS6P2HW6AcbdmVRIW2O8KUn7xjld2ZjVFcIl48W+DkGSVYYFGrpQZbEAFoVQpOHGkwVldH5UZw4Ny6LExJ+aUT4taJ6KQMFmb25TVvFZE1qmk+79rmEviLK38mVdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=EIEHD50V; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30039432861so155315291fa.2
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 15:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1736119829; x=1736724629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOLxu6427oM6Y4pgiMghY3GB+5/278OLfTvreWGtxe0=;
        b=EIEHD50Vq6deiUSm6aB/guNwUlt+NLtbyK5Ul9AcSHxytJyzxOcktjVzv/HTgzhIXC
         JuBgCUhOt3ABKL7NqNuYtaFOCL1hNBMiorJ3w01LjgyKr5UuWZ7eG3Vlq8jO9MXykUSl
         bwW09TZc/Nd9IDcYYXSM9M63R9PRssyyJxbi2RibQfQBPNyMkxikCT5KU/mCGV5w5Qu5
         9C3TnXVKkkJ+FTVbKacTXjBsWeRT0F1p5hZ2RghzsdAINj5Ni0V2BcjJpa8uViUjrN0z
         t+ylZ3k3Zaw6zu/9j+RpDBlD+R+RqXY2motH9b+lXTmVetZxTRRJ2e1OMeGBszPBIkbU
         WlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736119829; x=1736724629;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOLxu6427oM6Y4pgiMghY3GB+5/278OLfTvreWGtxe0=;
        b=BMnEi0ppJChiOg6YdYT6h3Yb1lA9B44ESMBtNDXkxAR+HvLQNwcM6kng7JXiSdsrsl
         +5RJ5ypib8/1UN9eSiTqhCHW73qWX2WWS7WKA9ZoJXHxD947eBqpyE7O2pB9x/BPHm97
         y+qvp3Es4tUlTV3B7XGdHslHQhfXVX/euAGbO5HmbTCvzmjeie/V27yw3Aer9LAVW5x1
         7XbS1ZGL6i/cxECnZrkcWH9Ozoh5OfccYXxqov0xl8XbMlnhhbxIe82CS514D3M+p11T
         fFzVCJ6VPYEGcy8fJENFEyQgmDxz5INAcvIMr3OQOlx3x/DrrXKDQz6durrEyD/PEh+u
         97oA==
X-Forwarded-Encrypted: i=1; AJvYcCUI9SEKVo91chZY8xXdryj/sXfDeBbj0b+jpVbo7aLhhljOulMI307cgJI3cpLyP6b+d0cdvCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6b8l6UCpgIB4Dal1qNKXwafHvD1u2vDVl5PsVOyw8ovjHcWL4
	p6FZflFWTbwkYHYUzA5TFJdAwbB11bAI1Kwayqxm6mi9KCiOxdd0BxJ7EMSWKUI=
X-Gm-Gg: ASbGncuA/ybnzbMbCfasA0cO3NFcTvlilfXtkueD4ZMYC9L4D1lzQ+eYUQT1PZt+LH6
	JIMmkOBEGaWiQ9fOpGgZcqKH/cywX2pFCS0A2W3fDMVYsUPt4wfXS9bo6wMF/+aHKs0qly3PztN
	3CKO4CyAGJ5NFQim7mTjcyKPJi4741n5NBO4iqwa7y3xfWKLDdK++OQ7GscbAHLvtlWeNrsdfr8
	PYRLsMOwmispqGq3VOpqk07uVz/MF5RFg69G8bdkULdA09Ws8K1XUugI1fS9kGQ6ri36xyWpp2H
	GVPzOcr+a74q8g==
X-Google-Smtp-Source: AGHT+IFmJaMx8LiG+zjnxSFmfeWEIEKM8ooBjDAs88EAb6iUNAJAKTPUW/j5u6CLMyBgnfe2H1X7DA==
X-Received: by 2002:a05:651c:1a0a:b0:300:3a15:8f1f with SMTP id 38308e7fff4ca-304685c2ef9mr221928781fa.32.1736119828293;
        Sun, 05 Jan 2025 15:30:28 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9bb7asm58734141fa.46.2025.01.05.15.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 15:30:26 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com, marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
In-Reply-To: <Z3ph3P9AFankiZxW@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk> <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk> <87pll26z2b.fsf@waldekranz.com>
 <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk> <87msg66uh4.fsf@waldekranz.com>
 <Z3ph3P9AFankiZxW@shell.armlinux.org.uk>
Date: Mon, 06 Jan 2025 00:30:25 +0100
Message-ID: <87h66c7sa6.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On s=C3=B6n, jan 05, 2025 at 10:41, "Russell King (Oracle)" <linux@armlinux=
.org.uk> wrote:
> On Sun, Jan 05, 2025 at 12:16:07AM +0100, Tobias Waldekranz wrote:
>> On l=C3=B6r, jan 04, 2025 at 22:09, "Russell King (Oracle)" <linux@armli=
nux.org.uk> wrote:
>> > Host system:
>> >
>> >   ---------------------------+
>> >     NIC (or DSA switch port) |
>> >      +-------+    +-------+  |
>> >      |       |    |       |  |
>> >      |  MAC  <---->  PCS  <-----------------------> PHY, SFP or media
>> >      |       |    |       |  |     ^
>> >      +-------+    +-------+  |     |
>> >                              |   phy interface type
>> >   ---------------------------+   also in-band signalling
>> >                                  which managed =3D "in-band-status"
>> > 				 applies to
>>=20
>> This part is 100% clear
>
> Apparently it isn't, because...
>
>> In other words, my question is:
>>=20
>> For a NIC driver to properly support the `managed` property, how should
>> the setup and/or runtime behavior of the hardware and/or the driver
>> differ with the two following configs?
>>=20
>>     &eth0 {
>>         phy-connection-type =3D "sgmii";
>>         managed =3D "auto";
>>     };
>>=20
>> vs.
>>=20
>>     &eth0 {
>>         phy-connection-type =3D "sgmii";
>>         managed =3D "in-band-status";
>>     };
>
> if it were, you wouldn't be asking this question.
>
> Once again. The "managed" property defines whether in-band signalling
> is used over the "phy-connection-type" link, which for SGMII will be
> between the PCS and PHY, as shown in my diagram above that you claim
> to understand 100%, but by the fact you are again asking this question,
> you do not understand it AT ALL.
>
> I don't know how to better explain it to you, because I think I've been
> absolutely clear at every stage what the "managed" property describes.
> I now have nothing further to add if you still can't understand it, so,
> sorry, I'm giving up answering your emails on this topic, because it's
> just too frustrating to me to continue if you still don't "get it".

I agree that you have clearly explained what it describes, many times.

My remaining question - which you acknowledge that I asked twice, yet
chose not to answer - was how software is supposed to _act_ on that
description; presuming that the property is not in the DT merely for
documentation purposes.

I will study the kernel sources more closely and try to find
enlightenment that way instead.  Thank you for your time.

