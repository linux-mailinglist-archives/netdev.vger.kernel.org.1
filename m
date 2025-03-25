Return-Path: <netdev+bounces-177519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8AA706D0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F5B1893A95
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75778F24;
	Tue, 25 Mar 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejxUUphI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689025B690;
	Tue, 25 Mar 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919859; cv=none; b=AOwXujHu4/Bi1oABQANJNtFy12o06vXO2zFqD5YANZKmy1vRNuYklakqFhdB14twEVGPAwF5u+UtmZ2EpPm+xQV7PTpBqHUduorHr4TBk4w23gX+u3jatpM3OKdVQRbBHesvNFc1DacxkRS98yvlb138/j49wmgq2IKpDzzbDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919859; c=relaxed/simple;
	bh=dp0QigW2JDWCaPz7XLW8KpMWv3s9S7++LnX6FPDZiv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVFycDYF5q+MqHU+ylUDPkB1PHU7esZ9T5YfVpdze8d7o0Hr8qUAnqmkZbhcemadNBdr2KOo/lGCc6f8uL9i9P3l8b4wYhp9nIYOB7d6q+VHrnFS9PEy7RKblF1s4NmUhHDxKg3I9vk+sSYrO+qC6yDheMFpHbmkZaApdgrXJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejxUUphI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c0517142bso60646811fa.1;
        Tue, 25 Mar 2025 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742919854; x=1743524654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C1/usvIFyLSs5yFp+wOyBQyH2xf/CvbmJQ8he3sFaE=;
        b=ejxUUphIuW5TQMBae/jXtzSroCBy4r9MJkTkXVHAFEwCYRKsfaHLWO/Q9P+iyhVr1t
         O0CRW1Z40Juy+AJ6o9o9FVREZx+uN4WDpvJMzaYNjSJs80roW1KXn1HzkOxFhX6BMro6
         XkJQ3K1sz4YIdxWtCnCyl4RML8tECXvrkNv4pg3leT12qhPS2t+mEtT4Bi49lpey05xe
         VCEwyvRoWi1oCs3igbQpRp4SBejtxfzN9NiThkJlNXeZXJ+9WVm27mAvijyQgOhlTZhV
         GXOEy0cH1u+7k7/EUria1KAaKu7o7ywNddTTcCuHgF4gYrgKerCg4wDZmMceSp/idPvW
         bRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919854; x=1743524654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C1/usvIFyLSs5yFp+wOyBQyH2xf/CvbmJQ8he3sFaE=;
        b=S9dAyWTRf16R/Zd4Pe4d05fpZv2Ww6gq7o9eFcUGRIwrACbhc4ML1M846kJ/7HiBcg
         UVRVum2uXAIFN9NqIUl1PZNYUlmNwF7qgd95m7LJW8C1FD6oVducDPop8YyzCO/V6M5T
         NrHYQ/AyPSY9IOfJVkIBs994y0OmIlk41w9TUcGHK0aN0psClQp/KsFehWbNY92jbMDG
         CIfarF3NrG69sdKsJJs74BSgbhr/SzI4VWIg2XliJv75xOSFQ4jwgitI3jTnVoiTTDNl
         vRt+ac+i+oLDmf98A9aQhu+tDtnIjuFy8iEyJ+56ttE0Wks4PQlwqNv4rQxydpAU6FMC
         mpPw==
X-Forwarded-Encrypted: i=1; AJvYcCWe7dV9x5YcuIgJdB6ex+Pcz8pcUFkdXGZOas3E8+WbXsgMAOJAaJiLtK2wnoWGbQQGvqpqeAYSci/etUVv2+o=@vger.kernel.org, AJvYcCX3Mmq81Lu64X29kV/BJL8u1aaP878s8QTrsQP5yEzT/JAgALfrjELfzLYVD+cfXf1GVNl6zkE4@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZA4pkDmhvgcrwboJt7c6MGc8yFRnyhTJDAIWSZcvWmVMJHBx
	czV735+wH5PNLI5Bxn3yKN5X6VTrfgfNcL0Tl7Ll3Qolq1d/lZAtGdKXGBNXvWEGjjxOIYtmCAS
	GyTTHr3LShJTQ7pDbh7obz/FGW8tq4GQ1
X-Gm-Gg: ASbGncttR8lO/h9bfCpy0iuRTIvf+xC81byiTts0E9vLAezcdpeJ8nkeZ14TUDUcQfb
	IDSI+iCO15u368tmdLVDhSe697uAMrzptM5uTNfegdMHuSeU0tVAzPp8GDGPsre2Hr5iFjpiNDT
	GeoDKoFYNxJmbFu4v0vF1nVhy+
X-Google-Smtp-Source: AGHT+IHwVTxo+FhJO8tPG3J36nfvxCrBNkEXvgvr3XM3H97AORyumbcnjBKTH+aZZ6fFtne/Wq5NLQyjYnJgd1oVBAI=
X-Received: by 2002:a2e:301a:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30d7e23845emr62394431fa.18.1742919854128; Tue, 25 Mar 2025
 09:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320192929.1557825-1-luiz.dentz@gmail.com>
 <CABBYNZ+b31WUEB_H=ZWCvjOSGMpoHpxCZZs5OrMw2uaqbCxQqQ@mail.gmail.com> <20250325081803.4fa1e08f@kernel.org>
In-Reply-To: <20250325081803.4fa1e08f@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Mar 2025 12:24:02 -0400
X-Gm-Features: AQ5f1JrgXj50HMuKi5hb901ZgKMfUbLULi8rDrfZsR4GdqfeklB17Q7j7Bkq3WU
Message-ID: <CABBYNZKU_m4RPhKQ-G1h3EyQK8r1en49f21Ow6Zw2Hq9e=hb6w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-03-20
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 25, 2025 at 11:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 24 Mar 2025 09:07:42 -0400 Luiz Augusto von Dentz wrote:
> > >  42 files changed, 1890 insertions(+), 268 deletions(-)
> >
> > Is there a problem that these changes haven't been pulled yet?
>
> We were behind the ML traffic by significant margin, see:
> https://lore.kernel.org/r/20250324075539.2b60eb42@kernel.org/
>
> Could you please mend the Fixes tags?
>
> Commit: 25ba50076a65 ("Bluetooth: btintel: Fix leading white space")
>         Fixes tag: Fixes: 00b3e258e1c0 ("Bluetooth: btintel_pcie: Setup b=
uffers for firmware traces")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>         Fixes tag: Fixes: f5d8a90511b7 ("Bluetooth: btintel: Add DSBR sup=
port for ScP")
>         Has these problem(s):
>                 - Target SHA1 does not exist

Will do, lets me prepare another pull request.

--=20
Luiz Augusto von Dentz

