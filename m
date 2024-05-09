Return-Path: <netdev+bounces-94946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FB8C111E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51DD1C20DBE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0F15E5B6;
	Thu,  9 May 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U25ifx5E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0358148302
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264400; cv=none; b=smiTnhw2e9R+9Vv7dHkwQK3r/qt712rOEMoWpus1PrBX9ee2OcLLeSZAHg0xsizOm9AqmciwoDHUmFUxH3sHXWRRz3FnoJjij79YVBuOkUtlVWxBGWeG32tZREPxJKGZDn6rxnbMFnIA3/NsTYQFdw0O1sLGbCtHyGPXaFt6Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264400; c=relaxed/simple;
	bh=XfyaPCFWK3Upm68W9wieUDFDjreSD7Kz/QTNUXd94sU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rvx5gZvBY3/FcjrQlloIIRbaTbHpSBoAqGdge2wZRo+jLgu5LTkEXPsfh+162mi4WmHyUGavVKGJc3Yc6RnNh6kOeXiwDQEi4NrfEnKzucTFHbQhbyU8mvwWI75pVFPgMuCJfGnEFJsTP6XAY+uxHZc3/FpNbITr1hT4C8XCPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U25ifx5E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715264397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TNMPX3hSCFMheoL3VlpKaQPuYJ12tT/TnRUwYxQYJ/k=;
	b=U25ifx5EAKsi2SdxCLa9+agayCWlq+4wJk3tLWTmasbGruXwHy1tYIQy8JQmo2WC3fCtMR
	fnjTM+TiD/wpf/bhAptT5UgdhrX091LP71iqG67jza7D9QLDRO75okuatvhPcNMx29YTbb
	eL5Ex5OctQEpMy+WBpkkTaH2Z+vPSVU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-G7SwPBiSP7CIsJFYXTNxow-1; Thu, 09 May 2024 10:19:56 -0400
X-MC-Unique: G7SwPBiSP7CIsJFYXTNxow-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34db05be56dso132821f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264395; x=1715869195;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNMPX3hSCFMheoL3VlpKaQPuYJ12tT/TnRUwYxQYJ/k=;
        b=S0YcGufcQjEX9HJBPM2Cjh/N5Cm4xZa7W5QS3sg97QP4hJM+1YroV0KOEEsJFuK+O3
         1uku0dB/DJpadPxqwoWOx8JQHeLuyxui/cLuGlzMluZLpRPSs7Y4abD0fqHsSnAIh18e
         Gp1pRw7nHvMYI7IDuAHs5zH0WpwqAsl+gEjNEP43RUDZ/OEB74sl1WDa6ns6cq1anPj3
         l+n0QGQPuOSOi7glogbjhF+6l0IUSRIB0tgk7ronl1bXBu4zHCnCzL2dB/tlkGMkLW6+
         zDqvaq2be+J/mYyhj675XIbh9zpPLQjrciQgyX1+94bGOztffQjslLtjjKkLnkEstNg6
         EiRA==
X-Gm-Message-State: AOJu0YzBusfbhLvNy7sX6QnDaAa59zPmSj8uv4bb+EvMYLe0/P0azIMI
	9HP6qAw/+FSTgniCNiB35h4i91vtieLOM2vub16rardElUKdF5tu7zo8l6pkQNtsFm8vzJbPcNB
	tQP1Cz+g6z00kpsDxI0JyXa0JufqywhF1kUFUAfmD9CS1kGI8x4FvAA==
X-Received: by 2002:adf:ce0a:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-34fca6235ebmr3708075f8f.4.1715264395089;
        Thu, 09 May 2024 07:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjKj/IzoYB29EA+QmvH8sufXtGvqK4s5H7TuEJmn45sSv8X/jUaNL2rABvTGitU851IL1dsg==
X-Received: by 2002:adf:ce0a:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-34fca6235ebmr3708058f8f.4.1715264394684;
        Thu, 09 May 2024 07:19:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbc56d1sm1828630f8f.116.2024.05.09.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:19:54 -0700 (PDT)
Message-ID: <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 09 May 2024 16:19:52 +0200
In-Reply-To: <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
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

On Wed, 2024-05-08 at 23:47 +0200, Andrew Lunn wrote:
> > + * struct net_shaper_info - represents a shaping node on the NIC H/W
> > + * @metric: Specify if the bw limits refers to PPS or BPS
> > + * @bw_min: Minimum guaranteed rate for this shaper
> > + * @bw_max: Maximum peak bw allowed for this shaper
> > + * @burst: Maximum burst for the peek rate of this shaper
> > + * @priority: Scheduling priority for this shaper
> > + * @weight: Scheduling weight for this shaper
> > + */
> > +struct net_shaper_info {
> > +	enum net_shaper_metric metric;
> > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> > +	u64 bw_max;	/* maximum allowed bandwidth */
> > +	u32 burst;	/* maximum burst in bytes for bw_max */
> > +	u32 priority;	/* scheduling strict priority */
>=20
> Above it say priority. Here is strict priority? Is there a difference?

the 'priority' field is the strict priority for scheduling. We will
clarify the first comment.

>=20
> > +	u32 weight;	/* scheduling WRR weight*/
> > +};
>=20
> Are there any special semantics for weight? Looking at the hardware i
> have, which has 8 queues for a switch port, i can either set it to
> strict priority, meaning queue 7 needs to be empty before it look at
> queue 6, and it will only look at queue 5 when 6 is empty etc. Or i
> can set weights per queue. How would i expect strict priority?

The expected behaviour is that schedulers at the same level with the
same priority will be served according to their weight.

I'm unsure if I read your question correctly. My understanding is that
the your H/W don't allow strict priority and WRR simultaneously. In
such case, the set/create operations should reject calls setting both
non zero weight and priority values.

> Shaping itself is not performed on the queues, but the port. So it
> seems like i should create 8 net_shaper_info and set the weight in
> each, and everything else to 0? And then create a queue group shaper,
> put the 8 queue shapers into it, and then configure bw_max for the
> group? Everything else is 0, because that is all i can configure.
>=20
> Does this sound correct?

It sounds correct. You can avoid creating the queue group and set the
rate at the NETDEV scope, or possibly not even set/create such shaper:
the transmission is expected to be limited by the line rate.

> > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
>=20
> Are they also available on plain boring devices which don't have PFs
> or VFs?

Yes, a driver is free to implement/support an arbitrary subset of the
available feature. Operations attempting to set an unsupported state
should fail with a relevant extended ack.

> Would i be correct in assuming my driver should just create these
> shapers.=C2=A0There will be some netlink calls to allow user space to
> enumerate them, and display the relationships between them?

Yes, the idea/plan/roadmap is to implement yml-based netlink API to
fully expose the feature to the user-space.

>  And
> netlink calls to set values in a shaper? Will there be a way to say
> which fields are actually settable, since i doubt most hardware will
> have everything?=C2=A0

This was not planned yet, even because some (most?) H/W can have non-
trivial constraints to expose. e.g. WRR is available at the queue scope
only, and only if there is at most one SP shaper somewhere else.=20

> In my case, only one field appears to be relevant in
> each shaper, and maybe we want to give a hint about that to userspace?

Any suggestion on how to expose that in reasonable way more then
welcome!

Thanks,

Paolo


