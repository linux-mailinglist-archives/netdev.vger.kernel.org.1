Return-Path: <netdev+bounces-150008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA459E8818
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 22:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20E21884754
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C107C6E6;
	Sun,  8 Dec 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="KrKoRsOE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D11DA23
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693550; cv=none; b=L6DoxeCPs0oRSvGFacCzWo2EIQ2aTKz95KWdLo7TxNp2144rphILRto5BMfW/J+AxUt1ThO6bJBuWaByMQuMlYwflMu6pibdcc4eMcZ3OTbj/o3ipb7TMEmHFfRGcWRMoo2FfkfgQo5I1g6wWgsZLs7iUU4saRoybcXUNszU44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693550; c=relaxed/simple;
	bh=eduGH3g7w2g/s7d7hu1HsXXNg5CYQX9q8acbNFc87qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s29tGWCP4khzsdn/i/aouxEpVhArWfpY2AfuKEw5aafbMcsjrO3Ke6wlTe9EBuTbizutlg0I1rm8Vf19CF7N/s4ka4f4T6n8EwispoyTYgbwW/MJadS1XNmr1OPjOzIjM0E/nYe+4EzzTedPf2GvDsz5qI4axNU5nm/mwpA4Dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=KrKoRsOE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c52000fso515379e87.2
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733693547; x=1734298347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnTulHhlm8ZGbhxq+dK9wHiXj9v5YTy48iJLQ0rKg2E=;
        b=KrKoRsOEB7ZgXGH14r8BtVXDL5NIlrphFthcmf5rMIFD0vTHHrr5OnLCot21Z/suFY
         LbYuOeDI8CxrkTQiiMI309Bce/VLVtFIjg/D0sKm+3AbsxEnG32fiTtpRdKYVywvvwLf
         Pz4JHMIxutMcN9B8bgznPHRY6Y57ScCZ2hCP30SqSsITchRHUJf7Q5dU6QeCdD8kkrd2
         ViE0FP8qvWhhGbvcl4lyl6tfAi9TThAfOHXnWLQjmesonwULG3rW3ffD0HtBrnzDwOC4
         Z9oyASpiquLGXYoBRr2laj5Vqbjle+fqwic1S89xMX/sc3/LXvsELijeK7cQnLqJzPBu
         C7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693547; x=1734298347;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnTulHhlm8ZGbhxq+dK9wHiXj9v5YTy48iJLQ0rKg2E=;
        b=mlYIYOZFYILf67GlkWaCnfjvM19qZhBk0OX000B/CpA37si67R3yr8+S5GA7Z57oZM
         q9X45GPQ/GSbuXx3eeaz3QDx9IfTKrcGfLYB1FK+YROQzLtoxUP48tOir5jtBJ59g9OI
         UAdiZHNTZFaKWBJg924eWQbycCvhtZ6+qE371jQGlPCks38jnFBmu1R0hzFRCI/tWxH6
         uWS9hkFgCWqGMUAf4hAWhgL6BzeHOarExw8EfnSXvYmE6whfd30dnNR7nIZhLW/WwPId
         dkTMGv0aQMEpgC7SnxrEeYx3MdgoyhoPmQbbE5g8WDsTggeGJtr9p3Nh95wvus+xjjcr
         JRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWYM9WdA3v0lg2WZLgAAdtsekbYFJp3jGmHt5QGaH8tVEIWU66Pp6BM0yFykl/4xtIDBXWUuX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2+Cr87PmgCKaSbRxx0qnpqMuauAfx+hCRGdsFbBVm3HFyWqL
	IiZY0zQgkHxX/yNhD1RFqKc+CeaPFhAqN2B5FRoCHY7jWZ7uLyX05JTSI0XwplA=
X-Gm-Gg: ASbGncsYwsKONBWYosFAiPFmUdE4sNo30MLFVzPuxqAdwQGGgTR4UsF3fDv8nduIGUf
	YKmK+g7VH7/artQGhruanwRhXGDV5UV7mJd91ivUeHIHKAPNgrFp+koKcH1/Aly+KcnPNOdeUXH
	4sCScW4GE2LyyWwcfHlnl5GvVTWHDgeFyrgyyVHWvyY7Y/XiBPeej89u9fojf2LGPw1MOTf1DnE
	ZH922DwSG4CRcsrHsL5mIdauQg/qfpo5iVUFoRaLvnUUxwcbi3ao03Mzh1/wFzunLGdTUbiSDcn
	hSV7gLc=
X-Google-Smtp-Source: AGHT+IG/PeWbrioapeDCzlQfn1CCyBW2ixrYW+W46eK5xlJT3otsMgZS8yRgTfake0iW55OLpG+Siw==
X-Received: by 2002:a05:6512:23aa:b0:540:1e74:5a15 with SMTP id 2adb3069b0e04-5401e745c17mr632489e87.54.1733693546804;
        Sun, 08 Dec 2024 13:32:26 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22975009sm1207522e87.63.2024.12.08.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 13:32:24 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 netdev@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH net 0/4] net: dsa: mv88e6xxx: Amethyst (6393X) fixes
In-Reply-To: <a01c7092-2642-4091-a085-07272b450471@alliedtelesis.co.nz>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <a01c7092-2642-4091-a085-07272b450471@alliedtelesis.co.nz>
Date: Sun, 08 Dec 2024 22:32:21 +0100
Message-ID: <87frmx97yy.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On m=C3=A5n, dec 09, 2024 at 09:23, Chris Packham <chris.packham@alliedtele=
sis.co.nz> wrote:
> Hi Tobias,
>
> On 07/12/2024 02:07, Tobias Waldekranz wrote:
>> This series provides a set of bug fixes discovered while bringing up a
>> new board using mv88e6393x chips.
>>
>> 1/4 adds logging of low-level I/O errors that where previously only
>> logged at a much higher layer, e.g. "probe failed" or "failed to add
>> VLAN", at which time the origin of the error was long gone. Not
>> exactly a bugfix, though still suitable for -net IMHO; but I'm also
>> happy to send it via net-next instead if that makes more sense.
>>
>> 2/4 fixes an issue I've never seen on any other board. At first I
>> assumed that there was some board-specific issue, but we've not been
>> able to find one. If you give the chip enough time, it will eventually
>> signal "PPU Polling" and everything else will work as
>> expected. Therefore I assume that all is in order, and that we simply
>> need to increase the timeout.
>>
>> 3/4 just broadens Chris' original fix to apply to all chips. Though I
>> have obviously not tested this on every supported device, I can't see
>> how this could possibly be chip specific. Was there some specific
>> reason for originally limiting the set of chips that this applied to?
>
> I think it was mainly because I didn't have a 88e639xx to test with=20
> (much like you) so I kept the change isolated to the hardware I did have=
=20
> access to.
>
> The original thread that kicked the original series off was=20
> https://lore.kernel.org/netdev/72e8e25a-db0d-275f-e80e-0b74bf112832@allie=
dtelesis.co.nz/
>
> Since the only difference is the mode =3D=3D MLO_AN_INBAND check I think=
=20
> your change is reasonably safe.

Yeah exactly; and since that only applies when the user has explicitly
stated "the PHY will communicate the link information in-band", then I
don't see how forcing the link state could ever be the right thing to
do.

Thanks for providing the background!

>>
>> 4/4 can only be supported on the Amethyst, which can control the
>> ieee-multicast policy per-port, rather than via a global setting as
>> it's done on the older families.
>>
>> Tobias Waldekranz (4):
>>    net: dsa: mv88e6xxx: Improve I/O related error logging
>>    net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
>>    net: dsa: mv88e6xxx: Never force link on in-band managed MACs
>>    net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X
>>
>>   drivers/net/dsa/mv88e6xxx/chip.c    | 92 ++++++++++++++++-------------
>>   drivers/net/dsa/mv88e6xxx/chip.h    |  6 +-
>>   drivers/net/dsa/mv88e6xxx/global1.c | 19 +++++-
>>   drivers/net/dsa/mv88e6xxx/port.c    | 48 +++++++--------
>>   drivers/net/dsa/mv88e6xxx/port.h    |  1 -
>>   5 files changed, 97 insertions(+), 69 deletions(-)
>>

