Return-Path: <netdev+bounces-150007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C59E8815
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AA4281107
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE41917E9;
	Sun,  8 Dec 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="jULaYa/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774C14F12D
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693042; cv=none; b=JzQaWUlhu/UmbqxLeNHDisPTCTjl0y+mpGw6ztvP3AMVqc3vrbUH5Y8oNHWhxpSoZhYt7pw5x2tLGcSzP5jNdqdzTv4PDZqx22rpLyAX2e/HKa32+NhJFaTMDKWEnZeZ5lb3P8+X+2ISYQT9h26L8Ql5bL4xVupu91nOUNEpaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693042; c=relaxed/simple;
	bh=v1ou5OK9vlcIs0m1eAXvnFQXgm+szsUMwxBu9AcbstA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfqK+JlCpNTHdWDhgspoztY3fKdMJJ3sT6zPkn/j6xi7LRcLzEVm0bVtMA1KGxu3v81c9074i61I3SMf/hzTgl+HkYFHhZ0F2eVHEo/FKNA/5blZwboVPvRonBKhoNJbE+wiGyzgQCnDYz9USeDTpuvjeFsIdawknAf2L5Ueyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=jULaYa/d; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so4143078e87.1
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733693038; x=1734297838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEwrb6JPwGQOWmyZ7iA4tmQr1VpNDT5lv4aceoIB/eM=;
        b=jULaYa/dLt+BhjugNPPqaGrwlMbGi6ZNhVx971DeSDdhJj902VIBgcfxqxFGvvbdR3
         Gc3JKW0ktzbCzfE1a5UvJM08GhvypxG5v5h1GNJ/tjRYo03SRwMbQ3+V3jF85MUGS0y7
         fdxVQ8sIxKFmP2Rrl6dCjpOIeBSjZdN6XTscYrC8x4K3tznMvetV2WI9w9V7mQbHmXXe
         rLQ57Omsy6ROQah0imqPB+bDti553ohDKOAaRuG1BVo4Tos16rQ+qhLGX7eDgTH9B0tC
         VgHhPH2vP3lH9qRxWdz56qtqOYSIUODHvsGBhupf2EtteLaJmHIKXhMvu64QbTHQS1of
         /u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693038; x=1734297838;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEwrb6JPwGQOWmyZ7iA4tmQr1VpNDT5lv4aceoIB/eM=;
        b=k5rBYjZ5e3ISBCJQ0LELh0Ffl99lHlKLD/58BMDIGgxoKuJ9mwCogeKz+ly0YZhte7
         MSIY0UUfW2mjrxCdJrOszpsLAF/WszhhviPq7fNGOamodHko6M7EOGn8ggSvGQmQKxdU
         WdylAlcBzyrvhygwufbGRElP6rycvZt33tPyRCWCVABiYDAqBA2BxO3k7prE7NLV7Yxi
         hZxEypdK4A3Nfpy/nbUad+e35xPtdJryoxM3F7ybiGJOcVvknap0W3XMlhZ2PCJWto7N
         QXJkhzK6NT1+yWzKQYBiHczb5faWJc4CY5ZFDApKmFQhOwZMDGJeMIfOO1eHNTX84AKs
         wpGw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRDaKvxki/6PaW0M/koXnUYxcHmFvqJuIDZCj060dPUt+H7HQ9A7B0JvsnZGaE+tXniS4hQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEp8eA9sYrcBTkK5JVEMf4G9liVzhG3lN3qlXfdkOpfhf6CyxR
	Gc1bMRWhNs3u7BvrednCasnupvwQjjsEFVbh8l6y4srE3hoLTOQeibTX1pM7rXE=
X-Gm-Gg: ASbGncvbMwPiZM8EZUOm++QSu/cupMww7ZWy7MeRBFmXS9CZJfgVh3KBWg0BOEXotNo
	g/7ItkLLbkHxU51H5EPRh92XZBU+a9HNc1VbjdDTUuS24AIIeToFEhjZQaSFVpQaOeohl68GG8b
	E1xj2e5GdujyawLcxPXmBhuZ1ou1al9G72Z/7VfxwCTxsD+HvVU5gcuL+UE0WPHy1byIM9e5qEo
	b2J0DImkH84vJQUdDPSDR6s188c39XZlqImNboeUn1dRjT9TVXzqGC2MrebPw95Bb6dx/1W3ZHy
	DYF9fz8=
X-Google-Smtp-Source: AGHT+IEek7AY1+v9efbvxZRZv3E35UrGmqhk3PnsTVHLzaKu3cNZ3EYMC5wudEHbUuoXzInvM3ZhIA==
X-Received: by 2002:a05:6512:b87:b0:540:1dac:c03f with SMTP id 2adb3069b0e04-5401dacc17dmr688584e87.37.1733693038210;
        Sun, 08 Dec 2024 13:23:58 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba6b8sm1170090e87.125.2024.12.08.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 13:23:56 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
In-Reply-To: <9ba73b5b-1b76-48b2-9b37-fd8246ef577a@lunn.ch>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
 <9ba73b5b-1b76-48b2-9b37-fd8246ef577a@lunn.ch>
Date: Sun, 08 Dec 2024 22:23:53 +0100
Message-ID: <87ikrt98d2.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On l=C3=B6r, dec 07, 2024 at 16:38, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Dec 06, 2024 at 02:39:25PM +0100, Tobias Waldekranz wrote:
>> On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
>> > On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
>> >> In a daisy-chain of three 6393X devices, delays of up to 750ms are
>> >> sometimes observed before completion of PPU initialization (Global 1,
>> >> register 0, bit 15) is signaled. Therefore, allow chips more time
>> >> before giving up.
>> >>  static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
>> >>  {
>> >>  	int bit =3D __bf_shf(MV88E6352_G1_STS_PPU_STATE);
>> >> +	int err, i;
>> >>=20=20
>> >> -	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
>> >> +	for (i =3D 0; i < 20; i++) {
>> >> +		err =3D _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
>> >> +					  MV88E6XXX_G1_STS, bit, 1, NULL);
>> >> +		if (err !=3D -ETIMEDOUT)
>> >> +			break;
>> >> +	}
>> >
>> > The commit message does not indicate why it is necessary to swap to
>> > _mv88e6xxx_wait_bit().
>>=20
>> It is not strictly necessary, I just wanted to avoid flooding the logs
>> with spurious timeout errors. Do you want me to update the message?
>
> Ah, the previous patch.
>
> I wounder if the simpler fix is just to increase the timeout? I don't

It would certainly be simpler. To me, it just felt a bit dangerous to
have a static 1s timeout buried that deep in the stack.

> think we have any code specifically wanting a timeout, so changing the
> timeout should have no real effect.

I imagine some teardown scenario, in which we typically ignore return
values. In that case, if we're trying to remove lots of objects from
hardware that require waiting on busy bits (ATU/VTU), we could end up
blocking for minutes rather than seconds.

But it is definitely more of a gut feeling - I don't have a concrete
example.

