Return-Path: <netdev+bounces-236261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15214C3A73E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1D1A345400
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD2303CAB;
	Thu,  6 Nov 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV5Pn6gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435E2E7F27
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427244; cv=none; b=nfAuwIFTv165FEV56r/wedz4KyeCHTL0ST6yxHeC13egPPwqiKbGC5EemJzP4D2hioeXVmO4soYJozF+Bb1c7FWHHEw6+DjWIoGZNmFZGmblbG4KYWoTNJkUbX2tYNjs7FCuqCJKledLst0E7SudX170SEwplJ7ssreKMlXxv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427244; c=relaxed/simple;
	bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doPwROdwT2VtkER5Qysqx+QEZvhoD6SA+nXkUpaG0tcbE4bw1a8QaPBnoQoGJEK9XRK5WT8D61lpPpN8JIUxH7RTwI7BhvxWZK2n6PBH66kSWEE7qOgxV8FMd/hJ9Tey9m90e/CS08rCpyoRVIugcFKCCHC/5jMktzEt2qFtPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV5Pn6gn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89c433c00so8596171cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762427242; x=1763032042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
        b=rV5Pn6gnT4Q7LcRnxkiij/NfBeYHxoIeJFZvjPdYZUl/9A/r/UheF6pJy3tAPg/Lcq
         33KUW+jTduemo+byS1u9gzcFcE47vluC7J4wpHj9xJN0Jf0rztnsXdUhdN0OPQMorYBv
         dHFB6elLRqCx9DdXigCdSnwlgLlK3O/qYfZW5ajj/OC3YIsUvQ2/Zz8apKIlKcQR7x9L
         uoNc8Kst/W1h4u9GUsXR3LPM61K5fY/U3JrxvbcFEGgTD/9ZHdaYY+LWGpVHLZb/vIem
         VGAyqQe2QDKqZ6zwcnZpz5lRCJIq8TQ10NbpjgRyyZa6oMgloCB6sIKiy6qmUGMmgPa1
         Lo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427242; x=1763032042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0ZdH+nx0rZ/pZHZK3BneUY8rwzBPM85uI4MwicRmNo=;
        b=JGzk9OjcVjLdD0fYa1quT1RcxJ4FmZEt3n5pJ1LZySkfDEslKhSTY/oS3x36bxbQxd
         meAJsc55AfWUxzAsUl2DYFP1v22eub7b9kk8iGF65RusG4oXnsIt3gm8hqd4zBVRW3Of
         +omQfjcgDeFVbjnc9fuiCs21LAy6MXUX0ysGFdSGBxO8LBoqy8LtB35gbtXG6eeQr3b+
         LTP/8P4L+NUBmR2XCS7ETuB/frduD/o+jaYcoIMxrVsH+x8ex+mcszs9N6dMKdXMwztL
         KPsE89fhUHBmHzDVzcSQqtlWDoFXbvXotW2dZNgBFDuuu9eRrSTwsoxRvMNWl/2U+L+J
         pnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6NFxuY4LVemw8sfmsTw2HO1eqGZvSw6NExKHK6SwZ8YOTKvoad5yRvXJiVNRkMr3HKJS3PVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgdNQuvSJhmLhtgzYAd11YJ6VWAhMNlDkFP9EG5t7P2KkdTeY
	6ajJhUahhFp6Q6aJbGwbsty2UqfnaMm88f4ZcODiJKYamT1MW31r9dkvN0+swQEMpDqidi+ygby
	kJv1sSAg5RJ6nIeQo7qGuX7CIIeAvc1xBnXpq7huc
X-Gm-Gg: ASbGncu10JPLOCyrXuqdtM18wXk2GJ+uZKwWKDTk92N2/RRP0Ig3EGqnZNmShSXKzuO
	616wf5XiYQhGMNUbzUV6GRg9XeEV3pUlWj8qka3wprdobVNSI3caAGRyyXiK+8wrqAQ3VfQO2IG
	BM0e8cjBNvCJEB92QdEwcGwU4yGGFeJweJA/+/GENmE/WD7SuWfSKKcCN6TOx8SzP08s9UqSHQE
	uL97nhAM9EREjuKN5tuP8FEUBtn1sJqfjSPZ9/5Ns2QgsFgcZIsPvxMaBhNDCtUmMkh4c0=
X-Google-Smtp-Source: AGHT+IFsyvu6ZTz0rAtb4IsdFmSi8tGXLk/9EUNnH5UQ3mMWlgq52v7rMBO/1u5TYQrjkJOaQBFPj5cYnlhEX0kYgZ4=
X-Received: by 2002:ac8:7d8b:0:b0:4ec:f940:4e65 with SMTP id
 d75a77b69052e-4ed725e7ba3mr63858621cf.51.1762427241397; Thu, 06 Nov 2025
 03:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de> <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de> <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
 <9ebd72d0-5ae9-4844-b0be-5629c52e6df8@tu-dortmund.de> <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
 <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
In-Reply-To: <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 03:07:09 -0800
X-Gm-Features: AWmQ_bm5Kc1656Fqyva8wNAL1lgqqHH7XdmS84y-uVKeorIZqI78IoRwP5JyG48
Message-ID: <CANn89iKpsVStgFLNzx8Nv3C-qRZdY9R7_Rh1mWWxf4MN-oTAYg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> >
> > I compiled it with CONFIG_PROVE_LOCKING and ran iperf3 TCP tests on my
> > USB2 to Gbit Ethernet adapter I had at hand. dmesg shows no lockdep
> > warnings. What else should I test?
>
> That should be fine, please send a V2

BW, no need for a cover letter when sending a single patch.

