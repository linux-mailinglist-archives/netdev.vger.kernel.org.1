Return-Path: <netdev+bounces-127560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DE975BA6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B70C1F23B76
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6923C1B7917;
	Wed, 11 Sep 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3kkqGK5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52871B14EF
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086033; cv=none; b=YSsRHTSdB3BMi6cM+dceUpu5kmkHsZbueKSrRUgaENf0CIqVpI60wzXEHWGAjC+kAoHRAwD55xy+PIxoMgHFkvs7sZqv01PgYpVb1yfUWHrbtMa0mRHV44qcqAgd71eIBqXZ+PzLRx/3OwJ4ERWntrgZu6FTDX/Kg2Iht/nvuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086033; c=relaxed/simple;
	bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWYSoUuyCiHM6roD/CuZVHxR/6ImU5Lw3M0xqwNSO31O3hjCHmcDIge6mPp0J59sjahGhwvnczAepm9yixBXA5Dop9Egld1k+m3joaDcp1MhQShl7XIhz+qFu5xAzuU14/UMfeWG3yDv3TzZ7fwaMiwRkifvWST/tcF3QEIvrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3kkqGK5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8ce5db8668so38921166b.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086029; x=1726690829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
        b=d3kkqGK53JRhkkKfHz9j6RCdrS7ORF7dUyfp9isQN9qXvJ+3Z4N1n8S5aPhx+vrAOM
         2aSB+GSOlN3qPCEvSEn0Zrh543jgeTevMjVJzTnOUanNa9nelOz3tLaSXxVDadTK/gMN
         ELp4K77C2Fy5Gq545NRQbRO+r/OcjcTaWOs5vc1uJlGi18NfhW4Df732MeFjw0BVr8m4
         SkfqwfgWePcWE6w8yZto0Hpk6LzmQtq6OQBuoTPREC+mhY2FWOju7o0+FjTdwBZd7feT
         +6tcMSGkbxPnpvCY96acjRXu0t2WX1D8C5uum9QzZZa85O4R7ovcinpchLWVbaD3Zr28
         bR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086029; x=1726690829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17TxleIW6R7gWSpmadpXboypIqEFClM/tdQvl+4QBOY=;
        b=c/Q0FYIItzr/jlsqxDy1NKgcr/3VWKkYig1Cc61/C2oavOC2GU9z6aXNOekexIAaJT
         wn0bOWkEdWx1wYvxiXnxj1td2kgm15CcOkqTQaEp12ZqVhQycvMQQDkQ9p3GUiCgz7J5
         Jw0sFqTeoP8dZV1I5IZptLGQb8tetVamH8eNV/bh4mGhg2lhU2CA7Y80RIpDM1wMX3XF
         2gCWLHhMStmeKRcGIsnfvF1wovG3sGcJqzKUZr6/BUP5XMkTXYtPZIchbH6q27WOFDQI
         sNugWbv5W4v9CSkhds6V+4TXtnzBaAINMlm9gltnq3x8SOt9R71aboL1H3wivvvMR9ei
         WFOg==
X-Forwarded-Encrypted: i=1; AJvYcCW7DebH2tplgJF/xoAZiATSofvF6uWCvzsX5SCHT0n8k05Li5+uVf5rf6Mbb4S/3xEFDOcz66Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3u4SpDLlHyn44EX4t7udgI9Sb7KEATU3o0vovpPwI0Kh24Jg7
	arodT8i8dIjP8L3rN6TJP7mZS06fboX1yer2hzZ0IqSOx5+yDU6ZNn2cab+6HSx/lxCs9JY8PcT
	cq35QAenZocBvU1o713JiUmN8tBbGktEZ+hA=
X-Google-Smtp-Source: AGHT+IEqI9RSt59HcZKfkrb3+N2g48eKklIT7OWBhDN7FyBJ5Emwmg/ESMqX7DRWe+MxgciwXRmIHO/h8cjPggNSiKk=
X-Received: by 2002:a17:907:1b13:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a90293b15e6mr74991466b.6.1726086028469; Wed, 11 Sep 2024
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:20:16 -0700
Message-ID: <CANDhNCqHaGYnMKqmVuaUwG_rXjHw--+es=OHNE2M3Gd94kjJ9g@mail.gmail.com>
Subject: Re: [PATCH 07/21] ntp: Introduce struct ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> All NTP data is held in static variables. That prevents the NTP code from
> being reuasble for non-system time timekeepers, e.g. per PTP clock
> timekeeping.
>
> Introduce struct ntp_data and move tick_usec into it for a start.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

