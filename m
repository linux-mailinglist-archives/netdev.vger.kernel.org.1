Return-Path: <netdev+bounces-181433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D64A84FA6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9341B84B55
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9720DD51;
	Thu, 10 Apr 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wmw2JlM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5471DE2A8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324142; cv=none; b=S5UleYktNYp1K2i5tJMfubU2yM0QMpzpHsv+1xloXCthUoUoC8UQfqMPW8Lz0YnHWPZWxw60FVnFaHGBMruZ64080I/FSZcMJmVj2tjutd7qoMh8PeZamIT0fKFrqizoP9BEYC+ArnMi2SaUXc6A2+Zpd0AotdDNNIAwWm+DRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324142; c=relaxed/simple;
	bh=ctP3y6Sh3iYOaqJsqQWRSfKmUoKTryO1D077fye25Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXwIr3GhmUwedvgi5pz2EMAiJluLHnijJC+PAkucY2zzlbQRP2YkGLDCjcX2R2JXGgEykh5Kc1TK/RrQUGAXxaJY1hSW5BS4pTIE1RqX3+dUCfX9wNkZDQTEIYxI6z7s5J4riRJwdQDcw1WyRokQb8SzsDG/wY9MyT3XapE2Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wmw2JlM2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so2355385a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744324138; x=1744928938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n/FwtPj3AAf74gbLffBrAWfSmzkE40dm/SUrEqLig8=;
        b=Wmw2JlM2BbTs47lBGZRsZypvNCA7FkA+KywSqHSy2oTpbMBH1KcUfJlajvXGPfeQIZ
         LlNljnW0JP7zwx1XAGTEcrcwXlKNpcLlEgR2Wq7n9N3pSYA9YeAtSXQ5s06NbRUdFH45
         2vIEdzukcg+4PzO/SgKeQnmtgVDjcAkVmDTmlrLqR+9zc4Q//2mEZqZWdLS3MnFum44X
         EUHfSE1cLD4rHncrIN700mPeS1z+0IqFSUQjFtu1FQtjuXFBrsYyP+x5TVrwheCe298e
         cgTpTxVp20BAgCE7Hj3MXaoWsTmFPVkhILTnYh1lQ+4gbv9Wif7VdAzGV3DjNlp5yP5x
         ZiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744324138; x=1744928938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n/FwtPj3AAf74gbLffBrAWfSmzkE40dm/SUrEqLig8=;
        b=v+RRvKbv5bairf7kgNa+iTxQMstJi7oiNaZeBEw7JvrzmHde75Tpn2lf+bYzikuJiI
         1d9gU8guRa0cefgCvkgIhCouFNcp1wilZwIWr+M1oFl9uifiXnQ8hcJcyh1QPn/lAdEa
         sW+U6E2yF7/IiZXOigpRplC3fFhI9GR7UnQPZrE+CG2Nrhw+liSWg1ZY2QhJZUnwxO7f
         IKhdXqK0sn6HK9Zi1IWXA8N6GrHlryyt4/Ldzm9N8v3Y+pGipG8qxhKQQC6tqUJwEG4V
         41DIrM1a39NQe2HHlgjqYQKFuLixBVgK7ZiZud+CmiQ26oaVSMw/5m+yzzjSduZUg716
         JTMg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ciJ8oNNUAWzcPSkRVYKnTCZFymgkWXiwjsmZuze9vjNh6URVgHJJE73CCNHUyoy2JGR6KMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdQtIFevTwjl22GY9RzBo+S3f7G8JTMSceqq4xGqAQrchd5OM
	JHfaHKny1FLL+9OGf0D0ZxmklwmvY6XCCMtvlA6+ONfsq3557f1rA/sMN5pwdbaueVJIRagGxMk
	uuyFfNrEnq3pm/3Am1H5joEUcOP1h4gN4+IzG/A==
X-Gm-Gg: ASbGncvVVd6nbGO1EjNyEU79zlvTn/UlJdP+p6PTAc7MDS3KRQOGXe+AEiT0bND8NVV
	SI1+Jgg72R70k5HaWPtTtNe1i0RuLKPouqMdrflLdHYq0n0w2Rvr8Lmv0gSxD46eHmodxGDdYVI
	GQbQEBWBous5dXSL48FOD0QFgkf4C2Hi5BOUZ7Jg==
X-Google-Smtp-Source: AGHT+IEPSCK0d+fSYNjqn96/dj4+5mPpvYHcyJ0yLDuA6dnarQOi/CVsvuSExvJEyZAY7mhwfsL1Ulq/JS7+j6fbYkE=
X-Received: by 2002:a17:906:6a0f:b0:ac6:bf3d:bf45 with SMTP id
 a640c23a62f3a-acad352f4edmr32885666b.36.1744324138189; Thu, 10 Apr 2025
 15:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407232017.46180-1-jbrandeb@kernel.org> <afcafd64-d7d8-41cd-8979-c76aaf4c1b04@intel.com>
 <8580a516-0bf0-49f0-9431-cb8f79fc4f83@intel.com>
In-Reply-To: <8580a516-0bf0-49f0-9431-cb8f79fc4f83@intel.com>
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Date: Thu, 10 Apr 2025 15:28:47 -0700
X-Gm-Features: ATxdqUEHlXoVSViGR1ujxyLA1yqOXe9xtZpBR8XJBQkjnvrlvbDwJHyxoEjLCEM
Message-ID: <CAB1XECUHTeA30j=NpLSQxTNx-KFaDzo55Bksj9UCZg=pHHNCCw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH intel-next v1] ice: be consistent around
 PTP de-registration
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:01=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 4/9/2025 2:54 PM, Tony Nguyen wrote:
> > On 4/7/2025 4:20 PM, Jesse Brandeburg wrote:
> >
> > iwl-next, not intel-next :)

The brain rot on unused cells is severe it seems :-)

> >> -    if (pf->ptp.clock)
> >> +    if (pf->ptp.clock) {
> >>              ptp_clock_unregister(pf->ptp.clock);
> >> +            pf->ptp.clock =3D NULL;
> >> +    }
> >> +    pf->ptp.state =3D ICE_PTP_UNINIT;
> >
> > Hi Jesse,
> >
> > It looks like we get a proper removal/unregister in ice_ptp_release()
> > which is called from ice_deinit_features(). From what I'm seeing, I
> > don't think the unregister should be done here at all.
> >
> > Thanks,
> > Tony
> >
>
> +1, I think a v2 should just remove the entire call to
> ptp_clock_unregister here. It's the wrong place to do it. It causing
> problems is further evidence of this.

Ok, thanks to both, I'll see if I can spin a v2 and eliminate the
extra cruft. This might also explain why a second load of the driver
fails to register the clock after the double unregister.

