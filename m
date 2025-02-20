Return-Path: <netdev+bounces-168148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F062A3DB43
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B37D19C1182
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F71F9ED2;
	Thu, 20 Feb 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+v2MQ9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24151F9406
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057900; cv=none; b=ItebiTGSYfKKLcn79JjbVp5ig7x21rZ3kvKsgTC+1izhyqTs+JMvojGP5tFFh0Su7qiYLZ1GE0KnaK/2px8aZYL0skAzqKrmP3BJnumNQyuDDIRudh58LRrdVDSXnGZ8aTZzhlr9ci73vyR8122aQeBybvAzNEEND0Ru6/8F6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057900; c=relaxed/simple;
	bh=7a1BlqGGAMdkE4Q7YG0s9fBpMjOUUaFkfa0GejocbjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeLEqv9hM3pfZ/1oz2715Rxk7hG6VUMOZ3N5Ki8Extuvq4RImuQtsC806e84jqa8oeCu7wS/5F9832kSHxvmZohh2Jqgt84a2oPB/yV15VuTKBGueVkPAnrpvyO9tiYIV7VLOiCCZdM+D/s0UJEDxGHmJwEKviB4imiFq1NbJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+v2MQ9b; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so1229302a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740057897; x=1740662697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZufNWuhJDsOFpRFBlRneEH0EHU0eZhooBfGSfUtEon8=;
        b=i+v2MQ9b3A1RdVwQAaUXqtRrSo4KMeDVwc1MVfDW8dinYWNxgdQ/hqPsheWF4HNBty
         pC7B9jz4UsuItYRh5/ZaIi75KHX+hrqw2HpLPt914AeSujoN4zInBhWkikw5cwrkaMzG
         waAci0s6yBr7Gz+dUOElQF1hfQyeKJZW182TyHM/zZ94CKomZSRcs7IMo844jQKTv0PP
         TZp2O3iZtk1GUQcwSiuAN3tTvgWOR2eUAdEkX/GgEjU8GWVkWUBVmJUP58oLPMtTgxdE
         GpL/bNhvx2POuEetqb30oHEXulyNixuyJTE3hmpYfaUndH61DFSArRrkmkIrURqLWAvA
         a7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057897; x=1740662697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZufNWuhJDsOFpRFBlRneEH0EHU0eZhooBfGSfUtEon8=;
        b=tqmIKgawyCWHHHUh9hnIQJnZzAZUthk+qtXOv9q6ghutLEJWiE23xkJMyd5Uye476E
         JTKLhOSuv8xyDEzMHgGVgewvsv2WkrHkYjTjhnCGWYDfaL5dzZXSGfg4bWqQhgJESHwj
         leV1TN3CZPTwazRQshBqxGtrwCwn66ltpmJVzTcqWiRtL/KPhSKTG/eAcMJWF7ogqdOl
         k5teOzRRViSznHaAUnWg0/4E3hD0Swvyn5CEWTax4bBq8T9BCj5qquysBPFiJ/1OuPPC
         A0i7x3IprErKRkgwf+IIT6NkN/9QvxjEJ25XvXLeC+lawgQnscaVVsO77JLH3fMlaOO4
         yJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaANEePU/Hgzr1GJeNox52F3a7/pKwnAZ7bBOJ3wcopEByN/YQnEBcOW0rwgKIKmHB/beXAKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECFclc0lZGI/azixgBf68g/Fc0z1mYAaMunihCK9xYfSh8xGc
	6J9l4zIUMWPlVCMjzfHy4dSb67xGRMSPf3fE4kGf330gRyX2PWlBB6PdBIXTai9xUK9g+O5eO1E
	SEutX79lmfxMzs6gV/uMqE0DTzKKJuKKBw+NQ
X-Gm-Gg: ASbGncslFNpAOqBWCvQ/xh72TtYPSZgihhyR+gsZl6IVsH/EYozeeUfa7+T2Gboi8+2
	a/3fCOaNcNV0BKhUWGxvCOfSvVqrDaSVRP0mGCwRc5lYfSqCaokS92Yi1Pby7FViRUKC3YUYkex
	K0rIxjaXohEwbBxXxy26pF6+aN2bS79w==
X-Google-Smtp-Source: AGHT+IHEdK4CwEN/VZyBxdcjFk7td5Eba9sf4I5UtAfRHy9vDJBSlX+WXF8qMxIyc7Wt/LZGPL7nhaqmgUq84gQVdAI=
X-Received: by 2002:a05:6402:3897:b0:5e0:818a:5f4d with SMTP id
 4fb4d7f45d1cf-5e0818a62b1mr21873198a12.28.1740057896759; Thu, 20 Feb 2025
 05:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
 <20250220130334.3583331-3-nicolas.dichtel@6wind.com> <CANn89iKdYXKqePQ5g5eU9UGuTi4fZaxwWy2BK7D+F2wkQHAXhg@mail.gmail.com>
 <101c5d62-d1e9-4ac4-a254-5aeafeac6033@6wind.com>
In-Reply-To: <101c5d62-d1e9-4ac4-a254-5aeafeac6033@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 14:24:45 +0100
X-Gm-Features: AWEUYZmuLXTMh4o7db2soV5DB_xAhcCSv9d9E_R7CvXOQK7wyXYgRStdelkPal8
Message-ID: <CANn89iKeTVp456WjapzFz5owvJ-af7EeGP7rB-O9K=GXi0F66Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: plumb extack in __dev_change_net_namespace()
To: nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:22=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 20/02/2025 =C3=A0 14:17, Eric Dumazet a =C3=A9crit :
> > On Thu, Feb 20, 2025 at 2:03=E2=80=AFPM Nicolas Dichtel
> > <nicolas.dichtel@6wind.com> wrote:
> >>
> >> It could be hard to understand why the netlink command fails. For exam=
ple,
> >> if dev->netns_local is set, the error is "Invalid argument".
> >>
> >
> > After your patch, a new message is : "  "The interface has the 'netns
> > local' property""
> >
> > Honestly, I am not sure we export to user space the concept of 'netns l=
ocal'
> >
> > "This interface netns is not allowed to be changed" or something like t=
hat ?
> Frankly, I was hesitating. I used 'netns local' to ease the link with the=
 new
> netlink attribute, and with what was displayed by ethtool for a long time=
.
> I don't have a strong opinion about this.

No strong opinion either, I always have been confused by NETNS_LOCAL choice=
.

Reviewed-by: Eric Dumazet <edumazet@google.com>

