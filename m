Return-Path: <netdev+bounces-176513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD6A6A98A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E85F188F801
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC491E500C;
	Thu, 20 Mar 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="NwgZSNyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D661E47C7
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483693; cv=none; b=sgofYuvd4WFvjeueKcj3qeNT0IHoqYnrcAmboT5xHhDJgkTqRmWt4OJ16Jfy4s7sLhxkZkKuCjaFMHO4S4C+PgIaB7k1wLHMOsJQho9H8phxRZbgX/2ff/yCqEsnWHPpqwFyqw93OQC2pR95yD5Gyk236Dot1HGVDraK5es/b0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483693; c=relaxed/simple;
	bh=GMHlIyX2APDk+8n9Yv81tJsQZh0XlAwyX+eoVGH52a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb4kTWPsDcrOF6Ej9MZfxetC4PMtVBT1ZKb3JQsFscTGp4T6GPRzTy2afvQq5EJKfFzumzYVK5zfZK5rWQEuLNKfwZ7kexBtaSbUjJDbyO4GrLUWokP6WdXv1KzIpNVJSWxAXcRZ6VhlO85XqHr+fQ8ILLRCD1N2CC+mW8qkRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=NwgZSNyK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2aeada833so180322966b.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742483690; x=1743088490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VNEco5K2sqIqRycrnv7EELdPKrcWD0bV22XzZnUiEM=;
        b=NwgZSNyKmUWnE1j+iGXeiPK5jy6+LhD3ksNB1HFMgU1GIFfyda1Wss/mUsUoLY9Wx2
         cZgi0ECdy3WKnnKMFXBJyaVTr84TMG6U6Gq0K3UzHoesEZHcxq1ntO+3yhqU3etjZ5fB
         JNodij+83FIM1fPngPu+89EQv2MEEMPqoBlldppmpAtxOuaXvl/BjF4VaLE1Whvy7Lem
         8QPn33yqdGHsy6zVY25fBwoN0UkPa7B9e/A6FH1895qfwc/0KrNMOBBYONnsP3DJyrek
         AMGxx2/vGJPrpM4axDCjkRudmNvEz/zTTvROfRHhi6Z/iNHZK7pERpLOxS4eLgFlUga2
         te7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483690; x=1743088490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VNEco5K2sqIqRycrnv7EELdPKrcWD0bV22XzZnUiEM=;
        b=hXET1ZwP5afGAoRfK6zjTpipgWvcSRQ9NBPCRS9Zo1vCm7MllCCheGXcAQI+HT7DRk
         qDH3hTzQ04SNt79FDbP92wP2Cqh4EkDPkgKlPHCW76cI9XoPhjFjjTIi2sz4t2l+bOYo
         3hKmLUjdrP+rVZ8x4qVQ6canfCj4bfAMA30pqpUQtzXUu9tMzRWm+g2y1Ex7B/8znhqS
         Z+v7ZsshEys9rMhmsqO94W56E3hM+lGsEcgcmgQboNfd1JSVVx5VPBLXc09XL2X8aSQB
         ePKHnSi7yxoVCnwAm9s/y4hHQ3l3SdNr2+2QycQMGIjUG9mRuF5piHLKM/I25u2/6dKW
         iJpg==
X-Gm-Message-State: AOJu0YzcNj579jfSwzmIoe9ilBJVxAKYkmNc35Ar/ULg/B4Ed11OARsD
	pxjh77gg8l0cCn/9yGdx4SyV3FRluTdZvAZkUqmfR9WOVFIWU2lNDi4fpxhMfrRFFxh+ell9Kgc
	dl2njXdLMUNqA4DssBFat1MFr0bXW7ZWpDAfb6ZRB62JxfNFGq+M=
X-Gm-Gg: ASbGncssAdeq8CFI5ujzWA9ivcq59uUv484qi0YUQMqKUaJxY/vYf6gbvBIfQqqJ/vb
	i9VWx0V1Pg5L6Eolfmt1JUZmdN2m7hrqXrRkzKcR+uM7M/BbMeORt16lWpAYod29v+xZGbGjtDY
	LDPkK/mZsEiuhLsNlrdDcGUuE00lXHuPqzbF15gXbGYCFJgyDqlTopjCno
X-Google-Smtp-Source: AGHT+IHw9B3eIh+7O6m5a7MMCmWfbI+MUr7p+GJEKJgvM8OlY03vChqO+8j5LsjkebFS0V1WQRjht1Im6iqVqQUXcec=
X-Received: by 2002:a17:907:72c4:b0:ac2:d773:f5f3 with SMTP id
 a640c23a62f3a-ac3cdc7a98dmr369847566b.29.1742483689784; Thu, 20 Mar 2025
 08:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <6c63cb1a-ba98-47d8-a06a-e8bacf32f45a@lunn.ch> <CAGtf3ibFAidzpFKm1o5zmZF3Neu8MgdXp_n_Wt+mv8M9YZhhug@mail.gmail.com>
In-Reply-To: <CAGtf3ibFAidzpFKm1o5zmZF3Neu8MgdXp_n_Wt+mv8M9YZhhug@mail.gmail.com>
From: Kamil Zaripov <zaripov-kamil@avride.ai>
Date: Thu, 20 Mar 2025 17:14:38 +0200
X-Gm-Features: AQ5f1Jo-49wNHEwOYK_Z837vCgK6xD8eSxGFSiR8O2vky17lBbThyMM4BfQWmhc
Message-ID: <CAGtf3iahrq5pynj7cbWsuY=RSRApciCf5N9wHbUf0SpPuh5Q0A@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I know, but the issue is that it seems there is no way to read
upper 48-63 bits except receiving it from
ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE or setting it inside settime64
call. See comments to the
https://github.com/torvalds/linux/commit/24ac1ecd524065cdcf8c27dc85ae37eccc=
e8f2f6
commit.

Kamil.


On Thu, Mar 20, 2025 at 5:12=E2=80=AFPM Kamil Zaripov <zaripov-kamil@avride=
.ai> wrote:
>
> > > 2. Is there a method available to read the complete 64-bit PHC
> > > counter to mitigate the observed problem of 2^48-nanosecond time
> > > jumps?
> >
> > The usual workaround is to read the upper part, the lower part, and
> > the upper part again. If you get two different values for the upper
> > part, do it all again, until you get consistent values.
>
> Yes, I know, but the issue is that it seems there is no way to read upper=
 48-63 bits except receiving it from ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE o=
r setting it inside settime64 call. See comments to the https://github.com/=
torvalds/linux/commit/24ac1ecd524065cdcf8c27dc85ae37eccce8f2f6 commit.
>
> Kamil.
>
>
> On Thu, Mar 20, 2025 at 4:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
>>
>> > 2. Is there a method available to read the complete 64-bit PHC
>> > counter to mitigate the observed problem of 2^48-nanosecond time
>> > jumps?
>>
>> The usual workaround is to read the upper part, the lower part, and
>> the upper part again. If you get two different values for the upper
>> part, do it all again, until you get consistent values.
>>
>> Look around other PTP drivers, there is probably code you can
>> copy/paste.
>>
>>         Andrew

