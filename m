Return-Path: <netdev+bounces-94971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566798C1226
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D2B2102B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4E16F271;
	Thu,  9 May 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYCTG2cm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E916F26D
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269427; cv=none; b=CmBbZEZLeFeaP6MhcHFr0eCV1/rd+xzt4/FFO6R2gMIKEANFZy++4d0n94I/gKCIyFK7D4UYa2WlSRTYAkVHEi9iDwXMiS4S1X004RQ+v0uIVVajWAdTJUpch8bLI6A2n1/hrNC0ctCppj3WIAgPkNsdlDCSlTQDx2lmCpO4qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269427; c=relaxed/simple;
	bh=eG8GyQ/nguAwOU8FmcJiO7uTFYxjB0DwZFN+hk4Dxqw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kojpWMYfykw2iGLz7QKwrrKP5Iq+PyaP1h9u6wxWhUtM8tWS0/Ef0u+Jpd0fsRbu04qcuwJvopaJ/n4kmL4yNuxjzPEIxJp1DeolIiZiLSSkz7z/WMa2ixpkoX2RXOR0t4gn7bQI6Ie9WX82vuNrHVy5dDKEgpgjiVFdfirHpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYCTG2cm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715269424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WRbuQMlf/oFV4yFcPQ1qOZaLJsJqGZLRnvhLIo1GK6A=;
	b=TYCTG2cm3Lk3QkqSc3bNX1MR27MIkwn4LU20mI7z+mvmlk2fQ+DKvNPHZcJ1cyIhTUh6rM
	SY3hZGS4PV9tLl5z7QsIn/XgyDRog3NZernd6doDTOIc7XQqS+zeGyFFzLhL2m9JsCCfvT
	MbL4E+QW9lHyjJDsMx8bbEVyERrULBk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-kvhvg7CENry_UdIVT5fNUg-1; Thu, 09 May 2024 11:43:43 -0400
X-MC-Unique: kvhvg7CENry_UdIVT5fNUg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34da4d75ceeso105184f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 08:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269421; x=1715874221;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRbuQMlf/oFV4yFcPQ1qOZaLJsJqGZLRnvhLIo1GK6A=;
        b=kIgpgyLu54dINdn2UVhpHJ7wqNvH3ZaloYZKoVEO0ygQklr9NdLNfxU8ee/Xqqahat
         2bAeWmkCja5/IBFv8C4JQt9aWJdhPTf0Ya5CtncIpktRlpRqPK9S29ZcnnfbPug+R6lm
         YcKbUl4wvbdfGCyCpP3Nvd0kPd1+GumBSVZkitBLc/aIVI1kVqPlwrl2B8KYuJlU/qVS
         Brmd1kQkIDtZqEYe7rGwcQcBR+n2OSA4lx8i++eOS8p+kY8LPdR+oBgXLWeqb7EELwgL
         8CWboJiRgdtUTFPoRMEMgY642aKqf/EDcrjMFTZWFA99e089pTUAgvCk++cmNUKp0zbO
         XnVg==
X-Gm-Message-State: AOJu0YzxO8RrjbvtntFelr3I0Av4eZ0siT0rBjBXyzVV0ZhZC2TYH5Jn
	9bhMzN38lXcSrqUqx0fh6ENkwVRtT7u1HTkz0r3JvMCG92KCqM55Ray6S1rdJvlg6mIvT0kwIPm
	okCbVJlepeoyESyng1HhitEJ9WzUnZpC4cP6F6R8qaGraVqQS5U3U1w==
X-Received: by 2002:a05:600c:3b0a:b0:418:2719:6b14 with SMTP id 5b1f17b1804b1-41feac5a400mr471705e9.3.1715269421633;
        Thu, 09 May 2024 08:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE0y+fRh3pJgODtJ7M+vn7NGmnJ5nxrfTNftbqwNxmvILl8plwtczcVkzTBy/i52wDMv+0Ag==
X-Received: by 2002:a05:600c:3b0a:b0:418:2719:6b14 with SMTP id 5b1f17b1804b1-41feac5a400mr471475e9.3.1715269420858;
        Thu, 09 May 2024 08:43:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfc6sm2023007f8f.72.2024.05.09.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:43:40 -0700 (PDT)
Message-ID: <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 09 May 2024 17:43:33 +0200
In-Reply-To: <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
	 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
	 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
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

On Thu, 2024-05-09 at 17:00 +0200, Andrew Lunn wrote:
> On Thu, May 09, 2024 at 04:19:52PM +0200, Paolo Abeni wrote:
> > On Wed, 2024-05-08 at 23:47 +0200, Andrew Lunn wrote:
> > > > + * struct net_shaper_info - represents a shaping node on the NIC H=
/W
> > > > + * @metric: Specify if the bw limits refers to PPS or BPS
> > > > + * @bw_min: Minimum guaranteed rate for this shaper
> > > > + * @bw_max: Maximum peak bw allowed for this shaper
> > > > + * @burst: Maximum burst for the peek rate of this shaper
> > > > + * @priority: Scheduling priority for this shaper
> > > > + * @weight: Scheduling weight for this shaper
> > > > + */
> > > > +struct net_shaper_info {
> > > > +	enum net_shaper_metric metric;
> > > > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric =
*/
> > > > +	u64 bw_max;	/* maximum allowed bandwidth */
> > > > +	u32 burst;	/* maximum burst in bytes for bw_max */
> > > > +	u32 priority;	/* scheduling strict priority */
> > >=20
> > > Above it say priority. Here is strict priority? Is there a difference=
?
> >=20
> > the 'priority' field is the strict priority for scheduling. We will
> > clarify the first comment.
> >=20
> > >=20
> > > > +	u32 weight;	/* scheduling WRR weight*/
> > > > +};
> > >=20
> > > Are there any special semantics for weight? Looking at the hardware i
> > > have, which has 8 queues for a switch port, i can either set it to
> > > strict priority, meaning queue 7 needs to be empty before it look at
> > > queue 6, and it will only look at queue 5 when 6 is empty etc. Or i
> > > can set weights per queue. How would i expect strict priority?
> >=20
> > The expected behaviour is that schedulers at the same level with the
> > same priority will be served according to their weight.
> >=20
> > I'm unsure if I read your question correctly. My understanding is that
> > the your H/W don't allow strict priority and WRR simultaneously.
>=20
> Correct. There is one bit to select between the two. If WRR is
> enabled, it then becomes possible for some generations of the hardware
> to configure the weights, for others the weights are fixed in silicon.
>=20
> > In
> > such case, the set/create operations should reject calls setting both
> > non zero weight and priority values.
>=20
> So in order to set strict priority, i need to set the priority field
> to 7, 6, 5, 4, 3, 2, 1, 0, for my 8 queues, and weight to 0. For WRR,
> i need to set the priority fields to 0, and the weight values, either
> to what is hard coded in the silicon, or valid weights when it is
> configurable.
>=20
> Now the question is, how do i get between these two states? It is not
> possible to mix WRR and strict priority. Any kAPI which only modifies
> one queue at once will go straight into an invalid state, and the
> driver will need to return -EOPNOTSUPP. So it seems like there needs
> to be an atomic set N queue configuration at once, so i can cleanly go
> from strict priority across 8 queues to WRR across 8 queues. Is that
> foreseen?

You could delete all the WRR shapers and then create/add SP based ones.

> > It sounds correct. You can avoid creating the queue group and set the
> > rate at the NETDEV scope, or possibly not even set/create such shaper:
> > the transmission is expected to be limited by the line rate.
>=20
> Well, the hardware exists, i probably should just create the shapers
> to match the hardware. However, if i set the hardware equivalent of
> bw_max to 0, it then uses line rate. Is this something we want to
> document? You can disable a shaper from shaping by setting the
> bandwidth to 0? Or do we want a separate enable/disable bit in the
> structure?

I documenting that '0' means 'unlimited' for bw_max fields should be
good enough. If the NIC can't support any kind of shaping it will
reject with an appropriate extended ack any configuration change with
bw !=3D 0.

I guess we need another comment update here :)


> > > > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > > > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs device=
s.
> > >=20
> > > Are they also available on plain boring devices which don't have PFs
> > > or VFs?
> >=20
> > Yes, a driver is free to implement/support an arbitrary subset of the
> > available feature. Operations attempting to set an unsupported state
> > should fail with a relevant extended ack.
>=20
> Great. Please update the comment.

Sure, will do.

> > > In my case, only one field appears to be relevant in
> > > each shaper, and maybe we want to give a hint about that to userspace=
?
> >=20
> > Any suggestion on how to expose that in reasonable way more then
> > welcome!
>=20
> We might first want to gather knowledge on what these shapers actually
> look like in different hardwares. There are going to be some which are
> very limited fixed functions as in the hardware i have, probably most
> SOHO switches are like this. And then we have TOR and smart NICs which
> might be able to create and destroy shapers on the fly, and are a lot
> less restrictive.

As a reference the initial configuration status has been discussed
here:

https://lore.kernel.org/netdev/20240410075745.4637c537@kernel.org/

(grep for 'Transforming arbitrary pre-existing driver hierarchy')

The conclusion was (to my understanding) to reduce the core complexity
enforcing an uniform views of the NIC defaults.

The 'create' op is just an abstraction to tell the NIC to switch from
the default configuration to the specified one.

The default configuration means 'no restrictions/shaping beyond the
link rate'. If the NIC has buildin shapers it can't disable, it must
initialize them to match the above. In both case the kernel view of the
default will be 'no shapers added'

The 'delete' op will restore the default for the specified scope
location. If the NIC has a persistent shaper there, it will update the
setting to the default, or actually delete the H/W shaper if possible.
In both case the kernel view of such scope location with return to be
'no shapers added'

My understading/guess/hope is that is possible to implement the above
default with any H/W.

Does the above solve your doubt/answer your question?

Thanks!

Paolo


