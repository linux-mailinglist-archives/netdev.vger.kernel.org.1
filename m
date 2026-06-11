Return-Path: <netdev+bounces-298105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ApWHMWmKmqquQMAu9opvQ
	(envelope-from <netdev+bounces-298105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69108671BA6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=j+q4BITW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298105-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298105-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 092373030502
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C43EFD05;
	Thu, 11 Jun 2026 12:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540F3D5C0C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:09:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179789; cv=none; b=YT+LWlwK7j32uqgfnA+vexcs0WDBkM/ywI4SRofhO3fbjbNf/BVpV9/sJeHPlU8Sk5lFPdlKiTEFIkqTi6HwTesdeXmu2wcqhsG6Y698Wji91TsS98B6Yqvbhl++N8qz5h8+SGTeXelZlavTvZxCpVLUGvPc704CMkuOV9XVUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179789; c=relaxed/simple;
	bh=ZjK56lQ40XRSCfovrLM16CvDySf903CFFII4+zH6ckI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdDOm5O30siSPMId2wrIZ0Eljn2ui9AKP8PxrwD0u31JSUZlze03T/fKRy8FNPFwnMqV794QVVe3abw1wdQfMROXE9AV+Irrr1Htz7vjPIBOjHDkkw796XtQz/uhhuO5SMy5rzfFGep9CCERIfKd38ZWAQCqxdQtqkwyY1kwaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=j+q4BITW; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so37747755e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781179784; x=1781784584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgtDqbm68IM5KDrf7YAIfuu2gtjEHLe1UjPl7Bx4Kfs=;
        b=j+q4BITWzjb8AZQbtHkzqdkXr2ptzSogU8G0b/m2hr/NXI4xRJfW5b//NigFjLM7Yt
         B3CVLNA2j9+WtNaeR+iNUkirmtCD3T91YqWmSoyhUycvWAyhScbOg/qd3JA0GVDpNLn8
         rIIn2PJO5rodhVEFRq4FlpUya5YTd2181p5Oiqcnl9b7acBCRHUSSJzVWOR0PyUXou6P
         r/zZDa/cJQNsdWA5r37tiTjdcNJ+2VkSMciqSHu7WKzfuUYbnuSwCVHOaMTTJ9yuuf1I
         iXypoumc2cYep9aXi+KAiFpDd7FLEhBXPeLI+YujKSUn+FAn2VAOjEktioxBjJcjbSo8
         Q3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179784; x=1781784584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgtDqbm68IM5KDrf7YAIfuu2gtjEHLe1UjPl7Bx4Kfs=;
        b=PR1WciyqRv1vyhNkDSP2FD4CT8iZq4R8LZKgPt2SC4DjI/ZdBQLiqTL/nS5Q+farsz
         mk/0NKib0YWKnYz3qk7jlLtARK3tqYQwSZjJzSA6mCimUI55F7Ia54CR0B/oeAv+evEw
         Ye4rTPxdGhpv6tKDCLM1/SsxRph5n4fzkJhYT4KNjaXg7XL6uIVyCdjClXvbC6E6KeKX
         cufV2ur6Ozo20pedR0xnenS6yKrYntqkUxLS8c0WIg/XPTLnzom9O1FL/X41OyLI4nxj
         vBpqsmw6cIyc0XYGX/fTy89Q5o+ZOjEq9/zYFSJjsdrkCbxnCey7twsQ7JJJHe4a81jR
         Jx4w==
X-Forwarded-Encrypted: i=1; AFNElJ+12E9fKmnxvhIdL9ieI0nTuTdX+prty2vPkITZ6Nwgv4APP9Y0SDghR7Gk4lfiifZNVQ5DaRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTOlZ7x770rBp6hxgZuZDw58ZIz9dl9xarqJdv98O27XsIHdg
	VxH6tKtrwgveZSxnc8PNY0d0Tq5RbNocUZYiDeIakUczFdkc2+h1TkqEkpXBERLrF0M=
X-Gm-Gg: Acq92OFhfdS3/1qPqnj+DJWI/IyEQ122oCjNFaDWYhKBR6SODOCzAAqLd4YSLenq3VE
	Y/u2SBFoO4+dm1+X/tcmA7zSDozlCTSvEWqYom9Ma9jEna1v/bclqcBEkxTRmTFeM7S3lAqL2qD
	5LF2jATE5BjZ2MPSa499HfbLep1EsInHIwuO1UT/Rvo9SQ11wrcFuTWq6ntJLJf8tPiCUVWRE+X
	jwadkTUVM51qEM5wv9LsZsnBuoRL+xPHwPk61KglvkjjbcXa1g8MtnvDjr8XkAbuLBLPNFxeFF4
	jC7ccwO6RhPq+dCWuoMVJ9zqhN+5T6xzq0y7cWHpWp/F4lULgjP1vr8HJBwX55HpseKEfI8R3S+
	HpxNMjU+KNgJDEJaMgs0at5yRKOPF82UzGAHJSQe01jRB+bEgpfyh9JMKIchqdLoM2BQXKgOOKK
	PfM/clwQUOH8kfCn9mLrORqdTU6VhXazQVAyxFGdqzupc=
X-Received: by 2002:a05:600c:8b25:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490e55b96b0mr35436165e9.7.1781179784256;
        Thu, 11 Jun 2026 05:09:44 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm78603105f8f.15.2026.06.11.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:09:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:09:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <aiqkZhNdt-WhglDg@FV6GYCPJ69>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298105-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,redhat.com,microchip.com,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69108671BA6

Wed, Jun 10, 2026 at 05:45:46PM +0200, ivecera@redhat.com wrote:
>On 6/10/26 3:04 PM, Kubalewski, Arkadiusz wrote:
>> > From: Ivan Vecera <ivecera@redhat.com>
>> > Sent: Tuesday, June 9, 2026 4:59 PM
>> > 
>> > On 6/9/26 4:00 PM, Kubalewski, Arkadiusz wrote:
>> > > > From: Jiri Pirko <jiri@resnulli.us>
>> > > > Sent: Tuesday, June 9, 2026 10:51 AM
>> > > > 
>> > > > Mon, Jun 08, 2026 at 07:03:46PM +0200, arkadiusz.kubalewski@intel.com
>> > > > wrote:
>> > > > > > From: Ivan Vecera <ivecera@redhat.com>
>> > > > > > Sent: Monday, June 8, 2026 5:48 PM
>> > > > > > 
>> > > > > > On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>> > > > > > > > From: Ivan Vecera <ivecera@redhat.com>
>> > > > > > > > Sent: Sunday, May 31, 2026 9:44 PM ...
>> > > > > > > >          -
>> > > > > > > >            name: gnss
>> > > > > > > >            doc: GNSS recovered clock
>> > > > > > > > +      -
>> > > > > > > > +        name: int-nco
>> > > > > > > > +        doc: |
>> > > > > > > > +          Device internal numerically controlled oscillator.
>> > > > > > > > +          When connected as a DPLL input, the DPLL enters NCO mode
>> > > > > > > > +          where the output frequency is adjusted by the host via
>> > > > > > > > +          the PTP clock interface.
>> > > > > > > 
>> > > > > > > Hi Ivan!
>> > > > > > > 
>> > > > > > > How would you control this in case of automatic mode dpll?
>> > > > > > > Automatic mode DPLL shall be controlled on HW level, such pin
>> > > > > > > brakes that rule and requires some driver magic to show it is
>> > > > > > > higher priority then the rest of the pins?
>> > > > > > 
>> > > > > > The NCO pin can be connected only in manual mode. In other words a
>> > > > > > DPLL in automatic mode cannot select NCO pin (switch to NCO mode) by
>> > > > > > its own.
>> > > > > > 
>> > > > > 
>> > > > > Being picky on DPLL_MODE for enabling feature is not something we
>> > > > > can allow if it is not related to HW limitation, is it?
>> > > > > Could you please elaborate why it is not possible for AUTOMATIC mode?
>> > > > 
>> > > > In automatic mode, the pin selection logic is defined upon prio. I
>> > > > can imagine that if NCO pin has the highest prio of the available
>> > > > ones, it gets picked. I would be aligned 100% with automatic mode
>> > > > behaviour.
>> > > > Is there a real usecase for it?
>> > > > 
>> > > > [..]
>> > > 
>> > > This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
>> > > configures priorities on the inputs, not manages the active inputs.
>> > > This brakes that behavior, the SW driver would have to manually
>> > > override the AUTMATIC mode to be fed from such NCO pin as it doesn't
>> > > exists on it's priority list, HW cannot pick or use it.
>> > 
>> > Correct, AUTO mode is hardware feature and it should not be emulated by a
>> > driver. If the hardware does not support it then the switching between
>> > input references should be done by userspace (by monitoring ffo,
>> > phase_offset, operstate).
>> > 
>> 
>> Yes, exactly, so for AUTOMATIC mode HW it will not be possible to create
>> such pin, which means that NCO pin would serve only a MANUAL mode
>> implementation.
>> Basically this is something we shall not allow to happen. DPLL API
>> should be designed to cover the case where AUTO mode is able to implement
>> all features consistently.
>
>If you don't like the proposal from Jiri (NCO switch driven by NCO pin
>priority -> highest==enter_nco else leave_nco) then it could be possible
>to handle the switching by allowing the state 'connected' in AUTO mode
>for the NCO pin type. Then the implementation will be the same for both
>selection modes.
>
>Only difference would be that a user does not need to switch the device
>from the AUTO to MANUAL mode.
>
>> > > The real use case is that any DPLL can switch the mode to this one
>> > > instead of implementing MANUAL mode just to use the feature with a
>> > > 'virtual' pin.
>> > 
>> > I don't expect this... but it is up to a driver. I don't plan such
>> > functionality in zl3073x as the NCO pin does not expose prio_get() and
>> > prio_set() callbacks - so it is clear that this pin cannot be part of the
>> > automatic selection.
>> > 
>> > Ivan
>> 
>> There is a difference between particular HW and API capabilities, with the
>> proposed API we would disallow the possibility of such implementation for
>> existing HW variants.
>> 
>> DPLL NCO MODE would allow that but as pointed here by Ivan and by Jiri in
>> the other email it would also require the extra implementation for some
>> configuration - device level phase/ffo handling.
>> 
>> To summarize it all, I don't have such simple solution for it.
>> 
>> First thing that comes to my mind is to combine both approaches.
>> Make it possible for AUTMATIC mode to also set "CONNECTED" state
>> on certain kind of "OVERRIDE" pins, where it could be determined by
>> the type of PIN and embed that logic into the DPLL subsystem.
>
>The possible states for particual pins are now handled at a driver level
>so the driver decides if the requested state is correct or not. So it
>could be easy to implement this.
>
>For auto mode allowed states:
>- input references: selectable / disconnected
>- nco pin: connected / disconnected
>
>> Basically, if driver registers such NCO pin it would be always selected
>> manually, and in such case all the other pins are going to disconnected
>> state while DPLL mode is also a "OVERRIDE" or something like it.
>
>I would leave this decision on the driver level... Imagine the potential
>HW that would allow to switch NCO mode if there is no valid input
>reference.
>
>Example:
>
>REF0 (prio 0) -> +------+ -> OUT0
>REF1 (prio 1) -> | DPLL | -> ...
>NCO  (prio 2) -> +------+ -> OUTn
>
>Such HW would prefer REF0 or REF1 and lock to one of them if they are
>qualified. But if they are NOT, then it switches to NCO mode.
>
>In this situation the relevant driver would allow to configure priority
>and state 'selectable' for this NCO pin.
>
>> Perhaps the pin type could include OVERRIDE in it's name to make it less
>> confusing and needs some extra documentation.
>> 
>> Thoughts?
>I think _INT_ is ok. In the case of TYPE_INT_OSCILLATOR it is also
>obvious that it is not a standard input reference.
>
>Jiri, Vadim, Arek, thoughts?

I agree with you, the driver should have the flexibility to implement
this according to his/hw's needs/capabilities. If it implements prio
selection in AUTO mode, let it have it. If it implements manual NCO pin
selection in AUTO mode using connected/disconnected override, let it
have it.

Moreover, I actually like the "override" capability for pins in AUTO
mode in general. It may be handy for other usecases as well.


