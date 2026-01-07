Return-Path: <netdev+bounces-247853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A1CFF8A9
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6BCD32A6C97
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511BB388DD6;
	Wed,  7 Jan 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbaC8ZnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539338A735
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808807; cv=none; b=EAz/FprtEPxAauRtBV0VtKWRvNZGmIw8A1YTUwwEGNMKfGTVM6nazz05UnuAiUpCex3NWcd9x0yMdtKjAFHoIA2jvQxNUjfSbqiVJFjbVwrpO0tkRhNQ+oOoG/LubuhIG6vCCKpTKG1hKd85o0wpZHauL1edxYwti5Qfr+suNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808807; c=relaxed/simple;
	bh=SWSfODdHtG536uPBXwO52DVqxj/FFx1w83m2u7/IZtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afzlOQhOC8OCKsmG4uW/HWq0R6jQgzh5sNg/ETnemlVCl1LRGDSp54qKyD4Ggxn+QhM3tdaeBLDvvxgltynjrvZ4ODroYAgC3OzotJyaUADvOmExUW+GkM4kVoB7g+yZU2cR0G5LRnEZtTrE7KoN3M78psTmki6v9EYoiPxX4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbaC8ZnF; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88059c28da1so20031856d6.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808804; x=1768413604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWSfODdHtG536uPBXwO52DVqxj/FFx1w83m2u7/IZtA=;
        b=WbaC8ZnF1OOEZweQcf3Q9VhM4bPfNutIi/Ws/29iWAT/4/Suaqr6hi47snpu5ibV2J
         3vw0UAoOHNN3CRHNkaXTzgJSx8MGBlc92uQfeiuXjyIttrPlAT8/1u3d+Axjadyf7cs5
         fgp0cbIQbpfU3Ju0ItQ5zuqT40gl/rs/5T8VWRbZbijcmgDEVPPe7C007Sh1afTwB+Kf
         9b6G8lwtFOnFGn9GDaEIHL4rZgfBSAl+xpSXB27cqV6PAa+9757hNKgg99h6LtW/pMEw
         1eIm5Npozjvo2OJPuAHYPNzp6dvIrRpNf4eCX0979o8XfPHRv/Ce62iKtqot2O5m5DmM
         0yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808804; x=1768413604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWSfODdHtG536uPBXwO52DVqxj/FFx1w83m2u7/IZtA=;
        b=NQ06AxNxKnJ/SWVNHsNwvhUg8ZPhjKKcMtWZyEL1e+JakVDn9TpyRFufH7gagM6iEp
         YfFR98ISkN67bdvYiB4dEm+PRpcZzVRrWYOWTyCxdBzN8Aai2U2wqO02P5dzPilAEqEj
         L9H/tuMUHkgxA3TXkHW5bYviAz3Q2GYevyYgRE38k7Aih6MCwqciB3S6wdWEvrbNFexh
         YyYKkrmOoGkx4hjNJFGgLEAZCa3f3i2o4GKpMe28ZeE+woaED/+2iqTzVQI2IvT1d8Z5
         m94G17lfmE9U4h6YCLbLXXCbKn+Wi35+ITargOmHL58LPmwvy1r87kVkLr382MrFlUp5
         u6TA==
X-Gm-Message-State: AOJu0YzVdwN7qBUKGZRYWfPJ/IhIV2I30G0/RinbO2syEcsyaErHyd5d
	hDeMWuqz6UY/EykElqdx7k4i0mKv4zO0O/gsQVn8Kb/sJjjDow7YiYZZuCuhREqGLDnQ2xWrUuW
	/kYrX2cXN0cv8Jw+hm2ZXFUAVriNvBYg=
X-Gm-Gg: AY/fxX6pcfTGqWPztgBY6kvdtoQlCW/iOZ9Tu0bWNyc6uxrbzGjAp2vlaHbiQ9YAmpR
	qK7BLaq6zpITAgu7mSxeD3fBB079Qd3qokCpv0jVBTj3Ub6u6l1v7P3n1ZfvGa3MUbIckgj9KQE
	cjv+HPz96s9aZvt9Nzo7c/vGdj6QX/AxBOW0+x5L8wC1LBORULP7iW+GtwiMS0QIb1q1qt51EhX
	1yJ9RVkzgZz4P0jus/MWi8E9tH5cm7rFDVqbt0+SJUBng6zZst4RbHCbd0aZPf6O6wl4JDu4/ln
	KJZCQzksSUbQxkjFas5Ta1Z9TjzHsI+jh2NcCObaiekwwYqhF6h9WyRumrA6YMC1bCo5bLdcvll
	lV2Bzk7kqPNKhaQ==
X-Google-Smtp-Source: AGHT+IFLJn5QkD9kHtbkxFrqLcFhVa5jF/mNWsJOAPE/WQA+KaxYLFKvbH58cVu3140u5GaLXI+eCml39NL9A1QsHtI=
X-Received: by 2002:a05:6214:2629:b0:888:8088:e07 with SMTP id
 6a1803df08f44-890841aca68mr43809096d6.15.1767808804432; Wed, 07 Jan 2026
 10:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107072949.37990-1-enelsonmoore@gmail.com> <bb532bad-8b3b-44da-868a-5d42b45a45fd@lunn.ch>
In-Reply-To: <bb532bad-8b3b-44da-868a-5d42b45a45fd@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 7 Jan 2026 09:59:53 -0800
X-Gm-Features: AQt7F2rWT9g8y8CPsSaA7haBbPhhxrlmWTTKx77Gue-vcg7a6T4XFHXDvJW8Ueo
Message-ID: <CADkSEUgmpZ4z+erh_VENH0Hp8shF4xUF+Frszfj0Q4YsUnt16g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] atp: drop ancient parallel port Ethernet driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:47=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> Please slow down. Get one patch correctly merged to learn the
> processes. Then move onto the next. All you submissions are broken, so
> you are just wasting everybody's time.

Hi, Andrew,

Sorry about that. Next time I will run get-maintainer and make cover
letters for my patch series.
Is there anything broken about the content/commit messages of my
patches, or just the way in which I sent them?
What should my next steps be regarding these patches? Resending them
with the CCs added would just create noise on the mailing list. Should
I directly forward them to maintainers?

Ethan

