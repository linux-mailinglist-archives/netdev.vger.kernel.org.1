Return-Path: <netdev+bounces-95402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE918C22C2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4801F22D5B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604816DEA4;
	Fri, 10 May 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq0ZE0YW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99516D9B4
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339150; cv=none; b=RT/Cvau46iAp1ek4mu2rvXC1qp7SvTtS2J063gC6eM6F827wsKrjlWHuATB3qsHAdUHbVEWyA1x+CsXJvPDUL+5itDsdmqBaPT0C9+YONMtRN/M86yn3fOIFv70yCZfGRe3btOGQjiLGAW0JSDKY9eo4eDikMs3BzsiPlmPNqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339150; c=relaxed/simple;
	bh=e7CDYaLdv76IjfQEyZrEwdx8U/HYcWB+P1bFPJ/+/FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eiBmkujOzuibbFgmwiJ4rPK03zYS85ZovoFUt1ZcPIvRyYy8dgRIiQOpHXto7RHTBOYMiCRfHZO0j2hV8E/c2g0QAE7XL5OTojM8Qv9Fl7KKPPzGWIBIN1c5M2FPT+whOHSE4Dgd9mMo82D/LI4il6uyhH/dybvdgQVLYUQfmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq0ZE0YW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715339147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R3nTR4Q9BX2gpizNr+kbtSnm9dIGK3A9ZaLwMJ/FwWY=;
	b=fq0ZE0YW4XYfyFBH6YaqxGIckLmWLt7zwTKMwSavGSHCeD0aMvTj9nzSFSLJdfE+le1JXL
	mjFf4qoGF4gV2Tpn4YjoA8l8nf5qT9kOfRFhU+U4WBj/FRC3GFbnC+I3hAjt6TfA6YKFfy
	8vvRQum2DVHii9nvPLiY/Kg7fdvk1Oc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-IcZKFN3PNrSLJMh6SZMDyw-1; Fri, 10 May 2024 07:05:46 -0400
X-MC-Unique: IcZKFN3PNrSLJMh6SZMDyw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e226454713so3190791fa.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339145; x=1715943945;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3nTR4Q9BX2gpizNr+kbtSnm9dIGK3A9ZaLwMJ/FwWY=;
        b=kxA+b3AhMgrlSUcQEJAlm0/mRmYEjPuPL22GiYa1wYuqS5J1YHNAbFtaDfVs7REoM3
         r/9m6o99e3rcdATd1MJBMMqys65gwQ69dBgDOYOR4qBfRiB4UwiqgBaCVhlmN51creMk
         3EQExl5i61oFypK+IV9A669Vi+nyaiUONqfW5QxcdQl9+gAD/mRr8WHVXWYUGj+MKynJ
         fhFdaf+dQBP70N/j8pVwTx0lVx89w5eGwkoKlxFRvPQvkO1SjWL+F3yydHznGCyKoebQ
         hlGGmuKUUbbIWKN5mzI4GabiauAw6rLOiF5U0D5GJbpc/wgHRQx6bg1zMtn0Vp7bWZUz
         9eGg==
X-Gm-Message-State: AOJu0YwVg5nSJEltlN2iIU8zBhkjO92TheNtkdnIG5/ZP/cpQGT5DzvK
	zqzkdcyxunSYtS4gQWVSEW/I12ZGjrr/VFITsNS5YPhNS8s0L6OYZTqTyMwgsvtb1OLAvaVlACw
	6U0g9zl0IHCyji7XVSrvp1SZXnwXFrJ2JUHbC0moOUmS0jmJ5Qmwujg==
X-Received: by 2002:a05:651c:1253:b0:2e1:cb0f:4e20 with SMTP id 38308e7fff4ca-2e5203a2691mr14925001fa.3.1715339144935;
        Fri, 10 May 2024 04:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM+oD1KmM8Iidt9mwgiK4ZgSOvysylzs6Mg6AuXEOxYQgxj3UTGZBPH1NvJs820MPT7/bM2g==
X-Received: by 2002:a05:651c:1253:b0:2e1:cb0f:4e20 with SMTP id 38308e7fff4ca-2e5203a2691mr14924801fa.3.1715339144370;
        Fri, 10 May 2024 04:05:44 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88208cb8sm94786865e9.47.2024.05.10.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:05:43 -0700 (PDT)
Message-ID: <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 10 May 2024 13:05:41 +0200
In-Reply-To: <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
	 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
	 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
	 <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
	 <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
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

On Thu, 2024-05-09 at 18:17 +0200, Andrew Lunn wrote:
> > > Now the question is, how do i get between these two states? It is not
> > > possible to mix WRR and strict priority. Any kAPI which only modifies
> > > one queue at once will go straight into an invalid state, and the
> > > driver will need to return -EOPNOTSUPP. So it seems like there needs
> > > to be an atomic set N queue configuration at once, so i can cleanly g=
o
> > > from strict priority across 8 queues to WRR across 8 queues. Is that
> > > foreseen?
> >=20
> > You could delete all the WRR shapers and then create/add SP based ones.
>=20
> But that does not match the hardware. I cannot delete the hardware. It
> will either do strict priority or WRR. If i delete the software
> representation of the shaper, the hardware shaper will keep on doing
> what it was doing. So i don't see this as a good model. I think the
> driver will create shapers to represent the hardware, and you are not
> allowed to delete them or add more of them, because that is what the
> hardware is. All you can do is configure the shapers that exist.
>=20
> > The 'create' op is just an abstraction to tell the NIC to switch from
> > the default configuration to the specified one.
>=20
> Well, the hardware default is i think WRR for the queues, and line
> rate. That will be what the software representation of the shapers
> will be set to when the driver probes and creates the shapers
> representors.

If I read correctly, allowing each NIC to expose it's own different
starting configuration still will not solve the problem for this H/W to
switch from WRR to SP (and vice versa).

AFAICS, what would be needed there is an atomic set of operations:
'set_many' (and e.v. 'delete_many', 'create_many') that will allow
changing all the shapers at once.=20

With such operations, that H/W could still fit the expected 'no-op'
default, as WRR on the queue shapers is what we expect. I agree with
Jakub, handling the complexity of arbitrary starting configuration
would pose a lot of trouble to the user/admin.

If all the above stands together, I think we have a few options (in
random order):

- add both set of operations: the ones operating on a single shaper and
the ones operating on multiple shapers
- use only the multiple shapers ops.

And the latter looks IMHO the simple/better. At that point I would
probably drop the 'add' op and would rename 'delete' as
'reset':

int (*set)(struct net_device *dev, int how_many, const u32 *handles,
	   const struct net_shaper_info *shapers,
           struct netlink_ext_ack *extack);
int (*reset)(struct net_device *dev, int how_many, const u32 *handles,
             struct netlink_ext_ack *extack);
int (*move)(struct net_device *dev, int how_many, const u32 *handles,
            const u32 *new_parent_handles,
	    struct netlink_ext_ack *extack);

An NIC with 'static' shapers can implement a dummy move always
returning EOPNOTSUPP and eventually filling a detailed extack.

NIC without any constraints on mixing and matching different kind of
shapers could implement the above as a loop over whatever they will do
for the corresponding 'single shaper op'

NIC with constrains alike the one you pointed out could validate the
final state before atomically applying the specified operation.

After a successful  'reset' operation, the kernel could drop any data
it retains/caches for the relevant shapers - the current idea is to
keep a copy of all successfully configured shaper_info in a xarray,
using the 'handle' as the index.

Side note: the move() operation could look like a complex artifact, but
it's the simplest instrument I could think of to support scenarios
where the user creates/configures/sets a queue group and 'move' some
queue under the newly created group

WDYT?

Thanks,

Paolo


