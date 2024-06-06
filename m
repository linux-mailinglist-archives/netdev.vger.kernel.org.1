Return-Path: <netdev+bounces-101433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DA8FE825
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8079286B51
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1B195FE4;
	Thu,  6 Jun 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw6n2Dn1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356F195FD3
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681786; cv=none; b=UR687mqax3YJyD63SMlZLK3WT2z3UKxhZQ58VkZzo/6P2TNv3tBvGPdLDMQ5M7JkQJo33u/nkTSEa75894y7B5DIy7PCpt+heJ71mZoIYxsr0p33qoTIDjYblUtDy6KGnLAH/xzgUaDnmYXs/uayC+YiwvQE62I6YwRqMiIP6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681786; c=relaxed/simple;
	bh=8COOVQ1Ox1Coi4J0CathLQwIHyOU3ahDa45XmoaMXGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnlk8xDPWRNeEl9Mkjxhy4CcfKUaPe3Luyes0/I/UG/KNEUsC3bDVlL41zIsMv13PRPDF+hZpMyHtnRWqPXrbqTkC7J0KuLJNb+vJVAxNLIE2/u/gsRoirAbIQym3i94xvbS/ykDh7dPPSXLQcG1+BYrtn7tlXYrH3431FEwYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw6n2Dn1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717681783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0VY/8EWlQkXSchwIg90MpBtcM/a7Nr1Bq4mSy+G3YX8=;
	b=Bw6n2Dn10xLfUuN2PseQKvljI+Oc9dML2St/SXSyH+XeYTJYM/u8OkzQ3zsFkVrjObKgCD
	D8/19rzvSGZ1mcHWSEIYuyR83lIoOoTyjFNa+npGBSR2W9bt21LRqdkLBYkvl5NtuDHlia
	G3Jj1Q5qBGaglyQtuFg6AM7A3xD5Qso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-n28H9l-vOYOoHj7HLaX7vg-1; Thu, 06 Jun 2024 09:49:42 -0400
X-MC-Unique: n28H9l-vOYOoHj7HLaX7vg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215a7b7464so1450445e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 06:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681781; x=1718286581;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VY/8EWlQkXSchwIg90MpBtcM/a7Nr1Bq4mSy+G3YX8=;
        b=do8ccQTSmOfkbfKAf2401CR7J5z/flBQSg0o7QuzyW1k2HtpWrBRWqthNOBzMyee93
         L4R4P66S2I59yc8uxklukmZhdtipw0j3gX+v7TJs6rR3KxckOmblk1dKYUxtisQ4WeuZ
         X+aTCVgX0yrM+daOOjJr1d8NQMSXuMr04wUkaPe0nJD/wHShg8hH0Yyc43AX4/cN+B6c
         aJiXtyV6vH+ys13JqeZlGQ+Q7UdDSLghFBdrnmIMrJKZAJJxv7HPayeRP0c6nphBLCTE
         zyQXteKMhqANQGZrZf8Kw4ypF+54NwAcbnRXn7H6/g1IEEYDhcXNlyio47gekcsqCiHe
         Jiuw==
X-Forwarded-Encrypted: i=1; AJvYcCWIU6nkmMOd+U5Hs+4MapUfjGkTaMV1qs5qEMosEQMrst/1bFIEvVhu8H+czwPk9fS9NCQthXG7gnXFdlc6ref0zMskOUzz
X-Gm-Message-State: AOJu0Yz0fez/D6ZTMz7zQvwLzlWQuu0aQeaMwW1ufKIPWdJ/KAvBbvU1
	I9hufNDyNRq4yUJj9YZtVXsVlOABhDPu4r1fPomgZsw/gmASZ8n8poGJfop7iNrSpit1ypK0M/U
	sFsCQ4HAGQA16nB8jgGtuNuoXgtJ8hbpOihonFU0wDi0Fn89XXrfsSw==
X-Received: by 2002:a05:600c:4454:b0:41a:408c:579c with SMTP id 5b1f17b1804b1-421562d3f15mr43690145e9.1.1717681781219;
        Thu, 06 Jun 2024 06:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHesOce12AYO+aLCHQDy31QFaI45g2u0yztFUKtSq6u5xZmXziO3huW/gNcNwRe36E7jZ1pbg==
X-Received: by 2002:a05:600c:4454:b0:41a:408c:579c with SMTP id 5b1f17b1804b1-421562d3f15mr43689905e9.1.1717681780794;
        Thu, 06 Jun 2024 06:49:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4216055101dsm10464795e9.21.2024.06.06.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:49:40 -0700 (PDT)
Message-ID: <c0de46a0bd15350620d5d611f07cf87b2a223d27.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net: ti: icss-iep: Enable compare events
From: Paolo Abeni <pabeni@redhat.com>
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
  Roger Quadros <rogerq@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Jacob Keller <jacob.e.keller@intel.com>, Simon
 Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 06 Jun 2024 15:49:38 +0200
In-Reply-To: <a08ff9c7-eac7-409e-8f22-5ad1fa0cf212@siemens.com>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
	 <20240604-iep-v2-2-ea8e1c0a5686@siemens.com>
	 <c518f6dd6cf9e92469d37a7317a6881ebed6a8c1.camel@redhat.com>
	 <a08ff9c7-eac7-409e-8f22-5ad1fa0cf212@siemens.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 14:28 +0100, Diogo Ivo wrote:
> On 6/6/24 11:32 AM, Paolo Abeni wrote:
> > On Tue, 2024-06-04 at 14:15 +0100, Diogo Ivo wrote:
> > > @@ -571,6 +573,57 @@ static int icss_iep_perout_enable(struct icss_ie=
p *iep,
> > >   	return ret;
> > >   }
> > >  =20
> > > +static void icss_iep_cap_cmp_work(struct work_struct *work)
> > > +{
> > > +	struct icss_iep *iep =3D container_of(work, struct icss_iep, work);
> > > +	const u32 *reg_offs =3D iep->plat_data->reg_offs;
> > > +	struct ptp_clock_event pevent;
> > > +	unsigned int val;
> > > +	u64 ns, ns_next;
> > > +
> > > +	spin_lock(&iep->irq_lock);
> >=20
> > 'irq_lock' is always acquired with the irqsave variant, and here we are
> > in process context. This discrepancy would at least deserve a comment;
> > likely the above lock type is not correct.
>=20
> If my reasoning is correct I believe this variant is correct here. The
> register accesses in the IRQ handler and icss_iep_cap_cmp_work() are
> orthogonal, so there should be no need to guard against the IRQ handler
> here. This is the case for the other places where the _irqsave() variant
> is used, so using the _irqsave() variant is overkill there.
>=20
>  From my understanding this is a remnant of the SDK's version of the
> driver, where all of the processing now done in icss_iep_cap_cmp_work()
> was done directly in the IRQ handler, meaning that we had to guard
> against some other thread calling icss_iep_ptp_enable() and accessing
> for example ICSS_IEP_CMP1_REG0 concurrently. This can be seen in the
> comment on line 114:
>=20
> struct icss_iep {
>   ...
> 	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
>   ...
> };
>=20
> For v3 I can add a comment with a condensed version of this argument in
> icss_iep_cap_cmp_work().

Please have run with LOCKDEP enabled, I think it should splat with the
mix of plain spinlock and spinlock_irqsave this patch brings in.

> With this said it should be possible to change this spinlock to a mutex a=
s
> well, since all the possibilities for concurrency happen outside of
> interrupt context. I can add a patch to this series doing that if you
> agree with my reasoning above and find it beneficial. For this some
> comments from TI would also be good to have in case I missed something
> or there is some other factor that I am not aware of.

It looks like that most critical section protected by iep->irq_lock are
already under ptp_clk_mutex protection. AFAICS all except the one
introduced by this patch.

If so, you could acquire such mutex even in icss_iep_cap_cmp_work() and
completely remove iep->irq_lock.

Cheers,

Paolo


