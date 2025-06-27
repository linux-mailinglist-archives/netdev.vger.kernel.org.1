Return-Path: <netdev+bounces-201750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DCAEAE50
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4081BC6BB4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6271DB95E;
	Fri, 27 Jun 2025 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3y1Ge8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4941D63FC
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000742; cv=none; b=KZGX7xsjGEiK8vf9x1Bmbpfs+sDHSSe1bZBSlT2IjivAhvgLuzfh5R5g7eJjm5BRYVTmeSi+d+dF1z0glpLI4B+f002Mx3UTYHO0ovzNBwZvaAzw43oOSe+mwWEYCQ7klnKQ2awkzpFgHsgoAAnZZ+7Qsgwq290Z1Gx9v5zphzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000742; c=relaxed/simple;
	bh=uIye7ffYxRe1aj/nL4Kj9OwVydMQ9C81AyEC1pdrgBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEhY7PFACq+ygzjm31dhYItruqPs1q+7+OHuAe0vt8bzO0VAbvL9pg3jLjunkXhcvruWxzXs0KkuwbGqn3buUPxewsLjKxnEnHfnaN1aHZG9a7VWQVHUEJHgi8Kxwc/plbxVjwMgyE3hYHiXJ0eK9qAtlx8aNyJitvHlcx2Adg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3y1Ge8e; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-555024588b0so1648758e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000738; x=1751605538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf9/SME+Lnr+OxDNQZdzbpnAWX5mL997K/xhcs2nDIk=;
        b=S3y1Ge8eIVzoqoRFv9Wdkc4tPK6QQcNer/tvvce2skvuLdap9HKwpQruuIcRJKmqQk
         cYljQgH2WNJs8NmyeDlBmFMtqtC6XvsmdrGofwkPQjW4nwSq4jhabPqzEBA3F7KbMoe9
         9FuNeoD/hkH2lAJD4mgLfiYrptF5AzUabc3dRcZ7gASc780trAZbZkEzUp7kaqR+ZBhX
         IV26GYgaNgypSXlmv2+eEAXwgTdyUIW5dirSQRxktv9bWfUrmWq+Tc49IHN6pK+xc9s7
         Qw2cqJceGiFWGl7ddEynMgpO8DjwkJYPYA2uEC5AtFFsIEVL/umXKTjxN8pdpeg/xNLd
         2J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000738; x=1751605538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf9/SME+Lnr+OxDNQZdzbpnAWX5mL997K/xhcs2nDIk=;
        b=hJjsd3FhgHvNhl/uvmM2RF/IiHG3tzD/btLB6gUP1jL06lV5VlZ6mIRXK7fzzkIEv4
         yHK28kymK6NicIywMgaeJV2tj7e3IzHECfbfXFfGuSAlXVzfaNw84XM6JakkidehRr7K
         MukcX/ismu0pCsgxOXOvvySQPp1ykNoz+XG36bMnUwrMheBjJVeDHJeTpJHXfNvLaq/3
         DrhplTE1kHt5YBjnvH4yzO5K0M4Rge46QvSVfYVNz8BD3wZ72drD0pRHqcXb7BVwQj17
         rIE0xMd2JSQTioLlhQq+z+fsTWD3Q7y0Q9Gf1Q2+58o3lT5YeHOonmtY+rwQenhvAyqP
         sDQw==
X-Forwarded-Encrypted: i=1; AJvYcCUoh9fPsQa9haf+xduOiEyemSffiIq5JZLLsa79kFKJbRcsZCnDWKOvgc6oFdPsfAfG2ghY8LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlL/FGYv6JujsT5x02eWQvTGL9lZb59T5P4xbRujcBuaX8tJqj
	9IXk/Dosq63ONpvwVagmEnXdkG69UUIory4hK1eMJl4KNoLhNtvU+ZAQbIfM9L+v0ZlccSAFeT3
	Fz7SRtmyTze+hlr8CiOxz5M7hBNdvdxMWzEmJReU=
X-Gm-Gg: ASbGncscwjjZAoCb0qDfKNLnN849wp2J0UJHa2CSpSNxeEoe+D3qxP7S1Ey/iBN6g7k
	HOUsMV2PSwo8V396NFfzdvGv5+7hnHfSAQbxGm+13RKuw9RHbhsBwLSIVhnavqk5XqxG7YYEtEP
	/BL5wHL//ggEJDpd0DtR3x0s5eUhqeyRgz+xRTb36nfvqet+V2Zt5GOUizOR1K33H/Qsmxfy5a
X-Google-Smtp-Source: AGHT+IHxMdjZLi5zdWFPxgNJl3H+FXj+B0DtRSD7w9LvBGgi4rorsxPqXascidhMd5oHNu9DiJmvCC4It4bH59cyZ48=
X-Received: by 2002:a05:6512:3053:b0:553:a490:fee0 with SMTP id
 2adb3069b0e04-5550b7ea031mr633573e87.10.1751000738369; Thu, 26 Jun 2025
 22:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.382451331@linutronix.de>
In-Reply-To: <20250625183758.382451331@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:05:26 -0700
X-Gm-Features: Ac12FXw9hjSNp0HR-ZscbMYiCPvydKhabPLUOL7jmSTHRCYJFisVMbyHu9-jLKU
Message-ID: <CANDhNCoduoTdzN0v59fnJjndu9cOYkSLZg8Sb_csnNx6CaOOJA@mail.gmail.com>
Subject: Re: [patch V3 10/11] timekeeping: Provide update for auxiliary timekeepers
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

On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Update the auxiliary timekeepers periodically. For now this is tied to th=
e system
> timekeeper update from the tick. This might be revisited and moved out of=
 the tick.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timekeeping.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> ---
>
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2762,6 +2766,20 @@ static void tk_aux_update_clocksource(vo
>         }
>  }
>
> +static void tk_aux_advance(void)
> +{
> +       unsigned long active =3D READ_ONCE(aux_timekeepers);
> +       unsigned int id;
> +
> +       for_each_set_bit(id, &active, BITS_PER_LONG) {
> +               struct tk_data *tkd =3D &timekeeper_data[id + TIMEKEEPER_=
AUX_FIRST];

Again, a nit, but I'd use aux_tkd or something just to be super clear
we're using aux ones here.

> +
> +               guard(raw_spinlock)(&tkd->lock);
> +               if (tkd->shadow_timekeeper.clock_valid)
> +                       __timekeeping_advance(tkd, TK_ADV_TICK);
> +       }
> +}

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

