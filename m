Return-Path: <netdev+bounces-197705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C1AD99B2
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 04:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E340C4A038A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648754654;
	Sat, 14 Jun 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJKDG5Se"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D76D17
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749868903; cv=none; b=EEXMay2CMC66hhhKJx7So8CFWQlXoBnUHyAV74iDxasnj2fPLmMyxyBetf9wutopFfXI4jcSFophLQDeCRJiHP3ACGfdv1upHYVLUFxgbxt/MYaPBrqFhD/F0Gid5HgU3jslcWPn6FzwW8bUA2GjuM1ffNgQh3aKKj7YTRIQpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749868903; c=relaxed/simple;
	bh=pjpmAaFla2SFS9mrocaF+iweTLQPPrgLhxPktz4zL+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI7Cg8kEeR9wgIl3hRk+gJMAhhjbdO7l37j/P+AZC/W+mT37ZP6ovbMre+xhDwIElC+YdKwYZ5d63WV8rWS0currmRcuKVxKXNgy7yJjOy+n+XiZ7UF1ZdkkSEiW3gwTFIL+CMdUjuYSNHaf7IJpxvmipeskgSUjLIkCu0W+BqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJKDG5Se; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b51f5218so971069e87.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749868899; x=1750473699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doPzRJPVP3/xe4/aMYowFwbSzXC9NI8C9CEdrJvNyeE=;
        b=dJKDG5SeW7gNTOrA+S5bXuJTaNb5egWFA7u/qJUAPwYwgw656wmZE73vMJX6q6DZd8
         WhVC3zX15TrbLqwAE5tHimxdXYasPxAZEI9AkCxgFF080gM0yKmIBNte0x0fZ/toori/
         7KGKADA402TzHlisLhJ7wnr2IYRB3VpIsh3mGR586OMvMUBFbPszJvDnUyGTYE9uNzbJ
         UWl4IZVtCI0NwSsSb6Yg2qv9pLRlz4kfBbY3S1vyCajBOoOH13JvGhMjYBmKLnoYyUV9
         uIw2TFd+6guJHSdXzYgW/2Syh3iJF9QpiYmI3dEP6W3cgTBmThSd9pg8RiZlXNK95P97
         GXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749868899; x=1750473699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doPzRJPVP3/xe4/aMYowFwbSzXC9NI8C9CEdrJvNyeE=;
        b=jHYVgrJW8woI/PQIKr9FPPN1TdXL4S5O1u28C3OHlNSgq5i3dfPWXkFU4P/Jqyg2yG
         rbeIMMV7sUOZ5FdmmctTZvddpJsL1xFSV+9HCy+LMn1y+n8VXUz5SDUS15SCCwnQ9fA7
         MStlLJ8Z5DCtrnuVRdtHlapSEEVGfASeMkon+QrU9a3obTjqN0QddbbnWeHpDclnjav/
         bsijtJuUfU793v5xeJczFSH0ylJEw9Mj07y2A3pekXEUEYesFWJNwgArf4hhqI0YElkN
         YCw64HdwjnWJETv+ybHib0Oujusj+B61WesZDsYXdu2wcF7dMR2fTh3IOhw2J9t8PWjU
         L5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuSsswyu/5tig8CPgWt6MMjzQrOyL7P0FAOIyDTthKP9/jcQoayG2Hpv6DrItoWU9aUnJg1og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMfRKdXggTNOVzuuMADreNiz+weIAI81HkVBBW5UpcEu0Krss
	i8ejJOxoTSw5D8KPNebJxdc0SP8OhIYCNtVf8fBr1ZrI/tr2gaKpMXL//yyqhK7446acl98VZ4q
	frmpkD9+gQu8vx5FEHFfr9j0krFI82rap+EjVmtw=
X-Gm-Gg: ASbGncvz5t2ZZtxGdpza3VlbyGEM0MODZbXgf83yKIr2fAwlFwU6do/23JJPNrKJERg
	q9jWtGwBemv8bxSpAVpHCTK7XlhS6+Ft4ie2FGCH+Hx0MRDRXdVIBu46dXVGCnkI47TelARPnZE
	MPzgScHZzFFMK2RH0Cg7dkBu8BPspuUx/8sCQzE+HvMEGFEtIut8HpThCAGgQiYwK1eg1wZr0=
X-Google-Smtp-Source: AGHT+IGyKmLcxos7EcwvVgM6x3f7yo/MjLs4DGE0QOIk/6EfA/xQL0wbg2vDDJZFztxwGG7zsTTPyp1k4n3wV6k8L+Y=
X-Received: by 2002:a05:6512:3191:b0:553:ad28:210a with SMTP id
 2adb3069b0e04-553b6f43b84mr330715e87.51.1749868899145; Fri, 13 Jun 2025
 19:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.350061049@linutronix.de>
In-Reply-To: <20250519083026.350061049@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Jun 2025 19:41:27 -0700
X-Gm-Features: AX0GCFvDzGMYapzpRturPw50nvQKFTA7BYWBgXb8VydIajUfsXGekrmW0-EEmG4
Message-ID: <CANDhNCqXMnEOC58PN03M+9-=DSty2FoZpJDz+OUuzd08uQdoEw@mail.gmail.com>
Subject: Re: [patch V2 12/26] timekeeping: Introduce auxiliary timekeepers
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Provide timekeepers for auxiliary clocks and initialize them during
> boot.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> ---
>  kernel/time/timekeeping.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> ---
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2630,3 +2640,11 @@ void hardpps(const struct timespec64 *ph
>  }
>  EXPORT_SYMBOL(hardpps);
>  #endif /* CONFIG_NTP_PPS */
> +
> +#ifdef CONFIG_POSIX_AUX_CLOCKS
> +static __init void tk_aux_setup(void)
> +{
> +       for (int i =3D TIMEKEEPER_AUX; i <=3D TIMEKEEPER_AUX_LAST; i++)

My only thought here, seeing its use,  would it be better if
TIMEKEEPER_AUX was TIMEKEEPER_AUX_FIRST?

Acked-by: John Stultz <jstultz@google.com>
thanks
-john

