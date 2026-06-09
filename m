Return-Path: <netdev+bounces-297018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSMJNO7zJ2rz6AIAu9opvQ
	(envelope-from <netdev+bounces-297018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAA165F4B9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:07:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=mgPkDCW3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297018-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297018-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28A6A301CCD8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1B3FBB6B;
	Tue,  9 Jun 2026 11:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C139B4A5
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003192; cv=none; b=Y8ETdoAGh+JhVdlUCSEqXacTWoIXkOU83H5eWs0fwna3rgLqxXBa1gRdtdw7x/WJV7ixMqI1bsb59FbB07e3x6lrTvmDb01K8jvZdF8n024z4bF8qhTigncYwZZ96cxiSCbjx5lbix4y5Eae5l6WZqsvxEJ7DEfNwwLBK7k3VtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003192; c=relaxed/simple;
	bh=+SqEI9oSMPALSE0Kzp1qHsg5DdBfNBNzZ+rOkJjrhFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avkvwP//Fm1ZgTirhWs6pqAkSMso9rEXfGjH5Pc3laQV4RFinF37Z4MjfKXQ3KtyIugQ8UrACj7QGXB2JJFZuoDUUUZzSBKb8+9f2CSspApDLzG5lfIb/Od/rj/jsFIDS2iO12nxOiUByqreXGlsUr8b09dKktsmRLnvfNW/2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=mgPkDCW3; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso45677845e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781003187; x=1781607987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMrf+M67Ik9/dX+BZr6j9niX+OkNNmCoLuQbKvuVxcQ=;
        b=mgPkDCW3ZopiDe8lRKQZQkv/YPusZiZoPBAD4XR1qIoaSIDFU77mP2ZITXQ7YABgbU
         fyN7Lvif8syX8qU5IHvT52rwoJuk9msHhnc0/obw7F2PZhydGxcWKR2WCsAU9M8DwAO1
         lmkqFW62cF0dBNSe+q6MbvZjqB4xgLsU2+5FW38qimJ1uUEHRD1R05cv7td/W1cmxjwR
         QiuEcjwVu1YfADHee+bZoCcBcLgiv4CkrAOC4K5ykqRhgsrgBw5PSJQgeEyjrm66CjTT
         TD201seNiEJacNoarv8logls7lM57l3nMtRwi32BkIQ3lzYhG1T8najoLiq9tzN1U1cA
         ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003187; x=1781607987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMrf+M67Ik9/dX+BZr6j9niX+OkNNmCoLuQbKvuVxcQ=;
        b=hZMBsCiA59d6nH6ZV7HVOyx+AjtyjpJMWMKmbFjb2Pkq3G6tEyYw7aGLOjk+naX9SN
         effYvTdS/jZg5vJIez4f+uGtbLzpFrQWGv7uo3fV9nGc8gQPPPYhK1yKbOa8WPSw6LoA
         gBDaFzMIG0vY+Gs4NObeX8rzgH7gwwgKCAfmvK9r3ZV/yVN2JVsRttj7ieWC91Oy40zk
         YvXVzw7zIhvv35lLUxBe+4LbsHv4dgzsseCIqcwPi5aifmp3YOx3LR9j10A3uve3mJG/
         PAEGalPQ1MH2U/tIC05Spn3UaAySDlZLmGlLfmN/ZjiDvu0tkL/lKEz6GRG46cxDpbjq
         GX/g==
X-Forwarded-Encrypted: i=1; AFNElJ9MXHUOJhNUxQn48swBojbwS8/lsfkg7CQbI3vvZwtrFwGHw26MsYfVt4E49rHBbiGslDMTX9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2c7RmQ9Pmq6p6pGfszWda5Imzas8sdLK5UdV9eZcRRHYZlq8z
	9bklTXIVaGi+dTTtV+wUN/xG0euigOo88V+vZrxJzRvrGYWb/9XGRxlEBUpb6VpZrLk=
X-Gm-Gg: Acq92OGIFUdDj3WwyUwB0lap7u66BJWLgfd1yukWC4ekF9M9mzik1utx91CgOzt8xuy
	87KvT4uoZ+ZVqt4qHEPjNUnwA3lzYh9V01SHP5UA4G/Zu1tRh/XOosmOWmp21bcEy0N/5lST6cf
	xqGcII46YZ1Jo6e9U2w4IhcDWAnxt6kvRw14P1oZLQsMS85jppzt2iVkapHZxQGDtbwuI6AFTrL
	fzsE1g4PDUjfh/daCHTBbcfjF2m8A5ELTVnzc3CEQAyfGOsDF0zd9WElgsG+1zuZDpd+e2qiSwb
	kkdlB0qjpWjVrSoWa28S28j/3o0/d7T07RGGKPi0abkHgVtCSXf1m8sfyW1ZDReRJMjYwxXMASA
	hgaIm+fHF+3m56P2BNyD09u3As+QliQh/XgFBmDb9t1byfhpLXf9keMReWUSp/BUJ31jE7bDuwg
	+uI5fSqOPJlgYEmDzxAIaUCE/WmZXeu+za5I2CgAyEJTuhhgdpyp978g==
X-Received: by 2002:a05:600c:674f:b0:490:aef9:aa3b with SMTP id 5b1f17b1804b1-490c26263f7mr315729835e9.32.1781003186857;
        Tue, 09 Jun 2026 04:06:26 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm57443482f8f.22.2026.06.09.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:06:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:06:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Michal Schmidt <mschmidt@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, 
	Petr Oros <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <aiftnkuT9IP31qUm@FV6GYCPJ69>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
 <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:ivecera@redhat.com,m:kuba@kernel.org,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-297018-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,intel.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,microchip.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BAA165F4B9

Mon, Jun 08, 2026 at 01:33:56PM +0200, vadim.fedorenko@linux.dev wrote:
>On 04/06/2026 17:42, Ivan Vecera wrote:
>> On 6/4/26 5:16 PM, Jakub Kicinski wrote:
>> > On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
>> > > > Purely going on intuition here but feels like NCO should be a mode
>> > > > (enum dpll_mode) rather than one of the input pins?
>> > > > 
>> > > > More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?
>> > > 
>> > > I had a long discussion with Jiri about this and we agreed finally
>> > > that dpll_mode represents a reference (input pin) selection strategy
>> > > mode and not a DPLL device running mode.
>> > 
>> > Long discussion? I see 2 emails ;) Let's hear from others.
>> > (thanks for the link BTW, _if_ there's a v6 please put it in the cover
>> > letter)
>> 
>> I called him... he explained me 'why?' in detail.
>> I also appreciate others' opinion.
>
>Well, NCO mode means manual operation of frequency tuning. Does it mean
>that different tunings may be applied to different out pins of DPLL
>device? My assumption that it's not possible, and in this case NCO is
>property/mode of DPLL device rather than single pin.
>
>@Jiri could you please share your detailed explanation on "why"?

Since the "why a pin and not a new dpll_mode?" question keeps coming up,
let me try to describe why I believe that modelling NCO as an input pin
(DPLL_PIN_TYPE_INT_NCO) is the right thing to do.

In the DPLL UAPI, 'mode' only describes the *input selection policy*:
MANUAL means userspace picks which input the loop locks to, AUTOMATIC
means the DPLL auto-selects the highest-priority input. I know there was
some fuzz about this semantics in the early stages of upstreaming DPLL
subsystem, but eventually this became very clear both in code and in
kdoc:

<qoute>
 * enum dpll_mode - working modes a dpll can support, differentiates if and how
 *   dpll selects one of its inputs to syntonize with it, valid values for
 *   DPLL_A_MODE attribute
</quote>

NCO *is not* a third selection policy - it is just another *source* the
loop is disciplined from. Except the source is steered by the host
(via the PHC .adjfine() path) instead of being an external reference.
Think of it as a virtual pin of some sort.

The object we already use for "a source the DPLL can lock to" is a pin,
so an internal NCO belongs right next to DPLL_PIN_TYPE_INT_OSCILLATOR,
which is already existing example of a similar virtual pin.

By having NCO as an input pin we reuse the existing model instead of
inventing a parallel one. "Run as NCO" becomes "connect the NCO input"
using the same connect/disconnect, pin state and pin-dump infrastructure
as any other input. No new control surface, and it stays orthogonal to
mode: we don't have to define what AUTOMATIC+NCO or pin priorities
mean, and we don't grow enum dpll_mode and the supported-modes
bitmask that every mode-aware consumer would then have to relearn.

For the pin info uAPI exposure we reuse the attributes pins already have
- the output frequency offset from nominal is reported via the pin's
fractional-frequency-offset / -ppt. A new device mode would need
brand new device-level attributes for the same information.

Having said that, I think it's a perfect fit. The only "real" pull
towards a new mode is that vendor datasheets call this NCO/DCO a "mode".
But that is HW register terminology and we learned many times in
the past that may be more or less misleading/incorrect wrt the uAPI.

Therefore my strong preference is DPLL_PIN_TYPE_INT_NCO, no new mode.
Honestly, I don't really understand why it would make even little sense
to have this as new mode. Perhaps I'm missing something, if you can
describe it, that would be awesome.

Thanks!
Jiri

