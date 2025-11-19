Return-Path: <netdev+bounces-239844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 290FFC6D04A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C84E9F5F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93D3203A1;
	Wed, 19 Nov 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXVFxZ8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147431ED94
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535614; cv=none; b=SJsofBcBgr+us1Qnw0yKxMz5AwWwycB8H8PWxpBzMmU/leCtm5b+bakq19uapkZoBcsVcjZL+8VapWM31llaSHmTDeVyZj6+wFKcZ645KDlIQ866JELlIOZxtYk2x1eN4OXUBrlD0v18/W1liAIEO3zya9PWA2cSipGKaODW6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535614; c=relaxed/simple;
	bh=C//nuYD3sxHkRsF0MUS3JcPxXHu6tsvLTGpo1KWoX8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjBDuFZQFf7+OL1S0Y7FBZumy0lhWX5HArUbnBVOw4XbJP4cI1zY0fbGJckZu22ALbMwqzrPgpD9rtyiTX4zneZDKG5s0hnQSqgvz0Pc2S9TMbTXxQBti1qj01bTAEKTgvxV2cYNz2iRUc1c5IuYMjlC2A1WhSDisftDHEf7XEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXVFxZ8n; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63fbed0f71aso5377827d50.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763535612; x=1764140412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKXeN3lXoFJirsuBqwPBgziYWBaDW/ia3ZuQKR5DhYI=;
        b=XXVFxZ8n/0Mxoes6NTrD6J6HE2ApckRM59j+uJJoVdlNsNilMn7tcpDgGyRBPyYEZc
         c7xI66Z+FHdPtfqFDIAzDCmVbU7JgGnthd27Ha5VDrCQiSymiwJkyI62TuWy0Xcrza7c
         zQwx3sm/OSPbE0BaIKwUhNONibMHIjRErZW98w4gw5/JFeLfr1rIv4oaFaMar5bP5mlT
         J9gxnI7UHd8sRN4AjyBzIU+QSrJTxBFP6x+qAlm0PL7V6GPLwYsGR1N6yNA28sU/KATi
         cvoVnB+bqWHxKPtE2K6caCR/LY45053YZFAA1etY1EEaIdQ37+ZiesrrZkAoaHp3UaYv
         t42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535612; x=1764140412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKXeN3lXoFJirsuBqwPBgziYWBaDW/ia3ZuQKR5DhYI=;
        b=q7ZX8Ss9OwOnMtiowHHQB1IGrlV3OQZE9u/vXDsOhRggvy+ltIyKqClyiTPpBT5lNM
         ZlvHFMgrEYh+FkLLAouk2vo848CWBIG0YPVNcg6IgX0wEBf0l1nOyM3n5vd7s6CBnOtZ
         GA5YCcJJqRkveh4tknXXz8q5bb3lTWUzORA1yeaHCidAI6LMLNvSQWupGmQdWkdX7yIy
         t3LhhczNqTYYfEqXVI6+rUC52lVHfsjJBUkwSxbUNRE3oaMtxoGisyUTQ/Xm39KoWT+f
         wXxUxhNpDh3Nz3Ug1pKlDC42sBU6cIQmfQlxJy3eTWUlp3+y8z8J7zVDoiGG1RjbGlej
         E0eg==
X-Forwarded-Encrypted: i=1; AJvYcCXWUXAcAV67b9qQcWQWJuZl3dN5H9HbLjNtTQfRAzyfrCBG3CeaNZfm2Q0YT+ilAHHmrJOEddA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBFqKOJZS5F84MIS/dKc03Wod8vkUAOV/PDGHoAdLLMWCr0b7
	rJBbYLS8Z52VTEl+Po2QRBkzEqL5cTT8eMpGnTXg6eLvcAf5fnUxGDZyE5+RzxZn/pKHgw3RbcL
	UI0QGk31a66n2mDuqn4IDdTwgeJGKOHg=
X-Gm-Gg: ASbGnctxUZAkaUcpotCULsdAiXPBzfxhOcKEcqwYWAhbhUVjJHbrsfkuLOOIgjfUc+h
	9X0Moy+SjOp77QNNep/c/ODU+BMmcWkG/PwmJ0qwsVNeAHL/qgUl64rsqoX/vk8Vjim5iAZrAcW
	DG2VVVv1PHNJC1kSXe3JS1rsP3xPE+yPuzgVbipwbh3RXMNfPL8uUx4SZjcCm4dS6qT6IogcQTQ
	JBWyfNIFKNP7BWnhMfbevAbH+SsiAjVZYmNCLvvXiyxpY73PQWb1ScPB1XNyy2lGtQavBMwlT6V
	rG48AiZhK1BFJDRBCBg/46S9i4M=
X-Google-Smtp-Source: AGHT+IEKoWpPlSpd7U4NDw/b6BWiTAb0dv3Nfymh2sNbb71XM40guLSJjJed5KV8LAKmRs+9ZZwvdWafkh9Z5A2lWi4=
X-Received: by 2002:a05:690e:424b:b0:63f:b446:7019 with SMTP id
 956f58d0204a3-642ed19f069mr885869d50.64.1763535611915; Tue, 18 Nov 2025
 23:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch> <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch> <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com> <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
 <aRzsxg_MEnGgu2lB@google.com>
In-Reply-To: <aRzsxg_MEnGgu2lB@google.com>
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Wed, 19 Nov 2025 08:00:01 +0100
X-Gm-Features: AWmQ_bmfL2RVzkRfFQkrMvx2GF_t6pB3lLmshM-uCOdJh4qG2uKH8Dz_mCBhx6w
Message-ID: <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:01=E2=80=AFPM Fabio Baltieri
<fabio.baltieri@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 10:31:54PM +0100, Michael Zimmermann wrote:
> > One thing the out-of-tree driver does, which your patch doesn't do, is
> > disabling eee when in fiber mode. I'd suggest something like this:
> > @@ -845,7 +860,8 @@ static bool rtl_supports_eee(struct rtl8169_private=
 *tp)
> >  {
> >         return tp->mac_version >=3D RTL_GIGA_MAC_VER_34 &&
> >                tp->mac_version !=3D RTL_GIGA_MAC_VER_37 &&
> > -              tp->mac_version !=3D RTL_GIGA_MAC_VER_39;
> > +              tp->mac_version !=3D RTL_GIGA_MAC_VER_39 &&
> > +              !tp->fiber_enabled;
> >  }
>
> Heya, don't I have exactly that diff in the patch? The second chunk
>
> @@ -842,7 +843,8 @@ static bool rtl_supports_eee(struct rtl8169_private *=
tp)
>  {
>         return tp->mac_version >=3D RTL_GIGA_MAC_VER_34 &&
>                tp->mac_version !=3D RTL_GIGA_MAC_VER_37 &&
> -              tp->mac_version !=3D RTL_GIGA_MAC_VER_39;
> +              tp->mac_version !=3D RTL_GIGA_MAC_VER_39 &&
> +              !tp->fiber_mode;
>  }

You're right, no idea how I missed that, sorry.

I've also done some testing with the out-of-tree driver:
- (my normal setup) a DAC between the rt8127 and a 10G switch works just fi=
ne.
- RJ45 10G modules on both sides works fine, but HwFiberModeVer stays
at 1 even after reloading the driver.
- RJ45 1G modules on both sides works after "ethtool -s enp1s0 speed
1000 duplex full autoneg on", but you have to do that while connected
via 10G because that driver is buggy and returns EINVAL otherwise.
HwFiberModeVer was 1 as well after reloading the driver.

What this means is that the fiber mode is always enabled on these
cards, which makes sense given that the out-of-tree driver only reads
it once when loading the driver. I guess it's either a hardware
variant, configured in the factory or detected using a pin of the
chip.
It also means that it doesn't matter to the linux driver what's
actually connected beyond the speed you want to use since - as others
have said before - this seems to be fully handled on the NIC.

Michael

