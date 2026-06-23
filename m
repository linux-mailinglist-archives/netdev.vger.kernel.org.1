Return-Path: <netdev+bounces-301340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3/KSGApiOmqJ7gcAu9opvQ
	(envelope-from <netdev+bounces-301340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7C6B6523
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:38:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="dR/pNPqm";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301340-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3FDE300E627
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89A3CF97F;
	Tue, 23 Jun 2026 10:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BB3BCD3B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:37:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211078; cv=none; b=NKJ4bhdul+p4VE6L6G3cZ9AeYx3rOMuK7EVTazbTE6Sbevfg8IQWr5ldSsJ17wDNYALM2Dd7Pop1Tt+twaH9knosdl+HT655GXwdKXrMsDVi9Zjl/24lRIza8ZUGbnaqFVmODt23QNaUblr9YpzH91ajj5GjBzp4QovMu5aq01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211078; c=relaxed/simple;
	bh=F0lWHich17ro5kZgJuSZkFLXHgg4vtCzy5fokX/57QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKEOHTwN4SoUqqi/XQFN74xnOOIbEJUUOnqxNZ74ubOJxxNBw9e32sWiR//WBcMX1y2plqlArq2YylD2K7rsq5fAyweeSLfGhGlCrVpIZA5M5mFzdc1uKudKLdgGO5zrfQkfM3+dvAbk5CXyU18VEK3ayDpLcvEhTa4zVVHNub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dR/pNPqm; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso33791715e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782211075; x=1782815875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Pxf7hxBtP7ouHyfk3Z/0xdoGsaVp7SuP+oRdBV9wI=;
        b=dR/pNPqmbEPVXwKXhizMJL9dacWwlZHo8eKOkSKxnOJCbOugo+VwLgHSdozDXYJfYc
         c+9uUXUcKCisZjh7v4/BF5wnstKoZSLXVjxFoGbHlKqDsNdlzDG1XjlGfgCVz7sUhG5E
         +vfzKuJZD4vG54WepLaafslvlGwVH3UO+L2tUMYPe5iEH9NGsu79s4XuaXwVURz344oj
         WJ5svQEVC29GuAOOYiMeesRd57IuafA9eXUvZKGI+MWCgI4OERnVf8o5pZTRiPOtGgnC
         edbq/koy1T05egCJ0v0YbkP9/5Owpoy6uGLsxmInkreCHzWQurGhEzx2FPXjdxNXGjoF
         KK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211075; x=1782815875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Pxf7hxBtP7ouHyfk3Z/0xdoGsaVp7SuP+oRdBV9wI=;
        b=ggFAb9mq90Uh4N9i8ps9LYAbt/IJ7XwJDyiwSuEXTtFVYXCSPqlc8O7DR9N+j2avYB
         vpaUlyFuHL/jNMzSjYNf+kb57JxdZvtMvj8DMg4R8DqVHCa2DK6e1CgJPk9bwJKSGEAC
         kDoOrgKGxrA5eonOShMPHvYcU+EilgODikfETedHJgWiDhemm4aVJBi0qPvPEcWoav/8
         jhMZsSRUQOTM20Y/+4q3USBvWtLgTb7Li5MNPXzdyzT971ZWxdqak23qi6Tyq7woz9VK
         aEaj6nZq8InBXLGJQ88lW+XOcTUbj0Cb4yG8ClnWL2tz1Pg8eDw35AmBTBFy/oZNsmj6
         szHA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZpVufRTNKMcDww1UrTQSukJs1juOmFg8/4jWsgRXO4aYnxQLuJZ02PZRPVcT03U0rHnzv1TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWAuP5AfGO7XDbJBuXPgdIGViGlFpcLhWFLEHwkWcxZL3asgDX
	x59O34ijipbLrKpz8DHT+GiM/U2X3oL5s+qnVopn69MvUBCv93GqNgFtLWkgphtg1gI=
X-Gm-Gg: AfdE7cn3LpNRnoycvP0smVHa6+ziTQ3kL+qBPhT6XSvEIwgxc7qf1hT4RLER7xJpcyk
	gQ38k2mbsMHXeD+VzqSysFW5EvoUx96/lACXLWRbKPcQgBOTarr969+6e45Krh568XX/qsE0N4w
	28zPVrX/ZSGqY5XLNRC3EdLsmPj0V+MtrYcA/jV8b1m+xFaYoJ33vdJ+dSo3SAR06TZIfT7NEDL
	0isUHuG4/cH1T9GzTvYaJ85s2AK2aDQNhuAN6z9dxRDs8MWG4EbsH/HZwhZCRjK/kdwaWlP1Nyz
	DHiMUDyl0AfwZP2EK4wdRfDzIjxwafbz/dmCcNTLkIX/xtWKFMtLX9rKaSAQ7v7Jf79rPkbWneA
	Qf0TQakiVg/jk1PQ4qDwNNC8Uh97T50F3MM+/C8FALEHyNRRq4H5vkkiUlsIm6mZsAFQIiccAJG
	LYRCZ1CgD+VEW9pTCOXTMKZQ==
X-Received: by 2002:a05:600c:5493:b0:490:e89a:b221 with SMTP id 5b1f17b1804b1-49240e7bbf5mr309944975e9.35.1782211074437;
        Tue, 23 Jun 2026 03:37:54 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd33dafsm402853825e9.8.2026.06.23.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:37:53 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:37:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "Schmidt, Michal" <mschmidt@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, "Vaananen, Pasi" <pvaanane@redhat.com>, 
	"Oros, Petr" <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Simon Horman <horms@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <ajphdp2Bfsp_54ME@FV6GYCPJ69>
References: <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
 <aiqkZhNdt-WhglDg@FV6GYCPJ69>
 <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
 <CH3PR11MB8749910F17977B951A8B12CA9BE42@CH3PR11MB8749.namprd11.prod.outlook.com>
 <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301340-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.dev,kernel.org,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,redhat.com,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:from_mime,resnulli.us:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0D7C6B6523

Fri, Jun 19, 2026 at 07:07:52PM +0200, ivecera@redhat.com wrote:
>On 6/17/26 1:59 PM, Kubalewski, Arkadiusz wrote:
>> > From: Ivan Vecera <ivecera@redhat.com>
>> > Sent: Monday, June 15, 2026 2:00 PM
>> > 
>> > On 6/11/26 2:09 PM, Jiri Pirko wrote:
>> > > Wed, Jun 10, 2026 at 05:45:46PM +0200, ivecera@redhat.com wrote:
>> > > > On 6/10/26 3:04 PM, Kubalewski, Arkadiusz wrote:
>> > > > > > From: Ivan Vecera <ivecera@redhat.com>
>> > > > > > Sent: Tuesday, June 9, 2026 4:59 PM
>> > > > > > 
>> > > > > > On 6/9/26 4:00 PM, Kubalewski, Arkadiusz wrote:
>> > > > > > > > From: Jiri Pirko <jiri@resnulli.us>
>> > > > > > > > Sent: Tuesday, June 9, 2026 10:51 AM
>> > > > > > > > 
>> > > > > > > > Mon, Jun 08, 2026 at 07:03:46PM +0200,
>> > > > > > > > arkadiusz.kubalewski@intel.com
>> > > > > > > > wrote:
>> > > > > > > > > > From: Ivan Vecera <ivecera@redhat.com>
>> > > > > > > > > > Sent: Monday, June 8, 2026 5:48 PM
>> > > > > > > > > > 
>> > > > > > > > > > On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>> > > > > > > > > > > > From: Ivan Vecera <ivecera@redhat.com>
>> > > > > > > > > > > > Sent: Sunday, May 31, 2026 9:44 PM ...
>> > > > > > > > > > > >            -
>> > > > > > > > > > > >              name: gnss
>> > > > > > > > > > > >              doc: GNSS recovered clock
>> > > > > > > > > > > > +      -
>> > > > > > > > > > > > +        name: int-nco
>> > > > > > > > > > > > +        doc: |
>> > > > > > > > > > > > +          Device internal numerically controlled oscillator.
>> > > > > > > > > > > > +          When connected as a DPLL input, the DPLL enters NCO
>> > > > > > > > > > > > mode
>> > > > > > > > > > > > +          where the output frequency is adjusted by the host
>> > > > > > > > > > > > via
>> > > > > > > > > > > > +          the PTP clock interface.
>> > > > > > > > > > > 
>> > > > > > > > > > > Hi Ivan!
>> > > > > > > > > > > 
>> > > > > > > > > > > How would you control this in case of automatic mode dpll?
>> > > > > > > > > > > Automatic mode DPLL shall be controlled on HW level, such pin
>> > > > > > > > > > > brakes that rule and requires some driver magic to show it is
>> > > > > > > > > > > higher priority then the rest of the pins?
>> > > > > > > > > > 
>> > > > > > > > > > The NCO pin can be connected only in manual mode. In other words
>> > > > > > > > > > a
>> > > > > > > > > > DPLL in automatic mode cannot select NCO pin (switch to NCO mode)
>> > > > > > > > > > by
>> > > > > > > > > > its own.
>> > > > > > > > > > 
>> > > > > > > > > 
>> > > > > > > > > Being picky on DPLL_MODE for enabling feature is not something we
>> > > > > > > > > can allow if it is not related to HW limitation, is it?
>> > > > > > > > > Could you please elaborate why it is not possible for AUTOMATIC
>> > > > > > > > > mode?
>> > > > > > > > 
>> > > > > > > > In automatic mode, the pin selection logic is defined upon prio. I
>> > > > > > > > can imagine that if NCO pin has the highest prio of the available
>> > > > > > > > ones, it gets picked. I would be aligned 100% with automatic mode
>> > > > > > > > behaviour.
>> > > > > > > > Is there a real usecase for it?
>> > > > > > > > 
>> > > > > > > > [..]
>> > > > > > > 
>> > > > > > > This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
>> > > > > > > configures priorities on the inputs, not manages the active inputs.
>> > > > > > > This brakes that behavior, the SW driver would have to manually
>> > > > > > > override the AUTMATIC mode to be fed from such NCO pin as it doesn't
>> > > > > > > exists on it's priority list, HW cannot pick or use it.
>> > > > > > 
>> > > > > > Correct, AUTO mode is hardware feature and it should not be emulated
>> > > > > > by a
>> > > > > > driver. If the hardware does not support it then the switching
>> > > > > > between
>> > > > > > input references should be done by userspace (by monitoring ffo,
>> > > > > > phase_offset, operstate).
>> > > > > > 
>> > > > > 
>> > > > > Yes, exactly, so for AUTOMATIC mode HW it will not be possible to
>> > > > > create
>> > > > > such pin, which means that NCO pin would serve only a MANUAL mode
>> > > > > implementation.
>> > > > > Basically this is something we shall not allow to happen. DPLL API
>> > > > > should be designed to cover the case where AUTO mode is able to
>> > > > > implement
>> > > > > all features consistently.
>> > > > 
>> > > > If you don't like the proposal from Jiri (NCO switch driven by NCO pin
>> > > > priority -> highest==enter_nco else leave_nco) then it could be
>> > > > possible
>> > > > to handle the switching by allowing the state 'connected' in AUTO mode
>> > > > for the NCO pin type. Then the implementation will be the same for both
>> > > > selection modes.
>> > > > 
>> > > > Only difference would be that a user does not need to switch the device
>> > > >from the AUTO to MANUAL mode.
>> > > > 
>> > > > > > > The real use case is that any DPLL can switch the mode to this one
>> > > > > > > instead of implementing MANUAL mode just to use the feature with a
>> > > > > > > 'virtual' pin.
>> > > > > > 
>> > > > > > I don't expect this... but it is up to a driver. I don't plan such
>> > > > > > functionality in zl3073x as the NCO pin does not expose prio_get()
>> > > > > > and
>> > > > > > prio_set() callbacks - so it is clear that this pin cannot be part of
>> > > > > > the
>> > > > > > automatic selection.
>> > > > > > 
>> > > > > > Ivan
>> > > > > 
>> > > > > There is a difference between particular HW and API capabilities, with
>> > > > > the
>> > > > > proposed API we would disallow the possibility of such implementation
>> > > > > for
>> > > > > existing HW variants.
>> > > > > 
>> > > > > DPLL NCO MODE would allow that but as pointed here by Ivan and by Jiri
>> > > > > in
>> > > > > the other email it would also require the extra implementation for
>> > > > > some
>> > > > > configuration - device level phase/ffo handling.
>> > > > > 
>> > > > > To summarize it all, I don't have such simple solution for it.
>> > > > > 
>> > > > > First thing that comes to my mind is to combine both approaches.
>> > > > > Make it possible for AUTMATIC mode to also set "CONNECTED" state
>> > > > > on certain kind of "OVERRIDE" pins, where it could be determined by
>> > > > > the type of PIN and embed that logic into the DPLL subsystem.
>> > > > 
>> > > > The possible states for particual pins are now handled at a driver
>> > > > level
>> > > > so the driver decides if the requested state is correct or not. So it
>> > > > could be easy to implement this.
>> > > > 
>> > > > For auto mode allowed states:
>> > > > - input references: selectable / disconnected
>> > > > - nco pin: connected / disconnected
>> > > > 
>> > > > > Basically, if driver registers such NCO pin it would be always
>> > > > > selected
>> > > > > manually, and in such case all the other pins are going to
>> > > > > disconnected
>> > > > > state while DPLL mode is also a "OVERRIDE" or something like it.
>> > > > 
>> > > > I would leave this decision on the driver level... Imagine the
>> > > > potential
>> > > > HW that would allow to switch NCO mode if there is no valid input
>> > > > reference.
>> > > > 
>> > > > Example:
>> > > > 
>> > > > REF0 (prio 0) -> +------+ -> OUT0
>> > > > REF1 (prio 1) -> | DPLL | -> ...
>> > > > NCO  (prio 2) -> +------+ -> OUTn
>> > > > 
>> > > > Such HW would prefer REF0 or REF1 and lock to one of them if they are
>> > > > qualified. But if they are NOT, then it switches to NCO mode.
>> 
>> Now you said yourself "NCO mode" ... I agree that it would be a mode in
>> that case. Where instead of running on regular/built in XO dpll would run
>> on NCO and user could select it, and this would be addition to regular
>> behavior.
>> 
>> I also agree that the pin approach might be better/easier to use, assuming
>> frequency offset for all the outputs given dpll drives, it makes more sense
>> to have it configurable on input side.
>
>+1
>
>> > > > 
>> > > > In this situation the relevant driver would allow to configure priority
>> > > > and state 'selectable' for this NCO pin.
>> > > > 
>> > > > > Perhaps the pin type could include OVERRIDE in it's name to make it
>> > > > > less
>> > > > > confusing and needs some extra documentation.
>> > > > > 
>> > > > > Thoughts?
>> > > > I think _INT_ is ok. In the case of TYPE_INT_OSCILLATOR it is also
>> > > > obvious that it is not a standard input reference.
>> > > > 
>> > > > Jiri, Vadim, Arek, thoughts?
>> > > 
>> > > I agree with you, the driver should have the flexibility to implement
>> > > this according to his/hw's needs/capabilities. If it implements prio
>> > > selection in AUTO mode, let it have it. If it implements manual NCO pin
>> > > selection in AUTO mode using connected/disconnected override, let it
>> > > have it.
>> 
>> I don't know 'current' HW that is capable of using AUTO mode as a part of
>> HW-based priority source selection and use such NCO input..
>> But as already explained above, this is special mode of regular XO, which
>> allows DPLL's output frequency offset configuration.
>
>Lets keep this available for potential future HW. I can imagine a
>situation where a user will prefer an automatic switch to NCO mode
>if there is no qualified input reference - automatic switch means
>that HW will support this (not emulated by the driver).
>
>> > > 
>> > > Moreover, I actually like the "override" capability for pins in AUTO
>> > > mode in general. It may be handy for other usecases as well.
>> > > 
>> > Arek? Vadim?
>> > 
>> > Thanks,
>> > Ivan
>> 
>> Agree, 'override' capability of a pin would be the way to go for this and
>> other similar further cases.
>> 
>> I believe a single approach on this would be best, I mean if AUTO mode
>> needs a capability, to switch from regular behavior to 'OVERRIDE', and
>> 'OVERRIDE' is only pin capability that allows such behavior for AUTO
>> mode, then similar approach should be used on MANUAL mode, to make
>> userspace know that such pin is always available to set "CONNECTED"
>> and make the userspace implementation consistent on enabling it no matter
>> if AUTO or MANUAL mode dpll.
>
>Proposal:
>1) new pin capability
>   - name: state-connected-override
>   - doc: pin state can be changed to connected in any DPLL mode

Needs a bit more description I think in real patch.


>
>2) new NCO pin type to switch the DPLL to NCO mode when connected

Say "NCO hw mode" to avoid confusion (I already spotted such a bit
earlier in this thread)


>
>3) automatic-only DPLL
>   - should expose NCO pin with state-connected-override capability
>
>4) manual-only DPLL
>  - does not need to expose NCO pin with state-connected-override cap
>
>5) dual-mode DPLL (supporting mode switching)
>  - if it exposes NCO pin with the override cap then it has to support
>    switching to NCO mode directly from AUTO mode
>  - if does not expose NCO pin with the override cap then a user MUST
>    switch the DPLL mode from AUTO to MANUAL to be able to make NCO
>    pin connected to the DPLL
>
>Vadim, Jiri, Arek - thoughts?

Agreed.

>
>Thanks,
>Ivan
>

