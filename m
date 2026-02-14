Return-Path: <netdev+bounces-258716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I/aMMvuWkGncbQEAu9opvQ
	(envelope-from <netdev+bounces-258716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 16:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2513C572
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D573530065FE
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF1277C86;
	Sat, 14 Feb 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2wEituz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNyGp6Nl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3E24293C
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083513; cv=none; b=n2yzdeHZY4TuHImQp9FXGNNGerje+mp3tJMNu2Aj/kLM4dJNnE7bn9nHRwo2NGM4gKGFnmnRkL7Bnrw1ezHeBSGWgmW8PojLb7E5uHuwrM07S0t+H9DuEskl1Xvw+8vJvtY+oSAXECybIa0SjnWHPUW1nXK5jNwJqFsMcn8aBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083513; c=relaxed/simple;
	bh=LHk0CQ5qIzWHPHnrz7jbvcgJxtM0KZsyX+BtTo2wjIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IR62TeyS7SkfTKOnF08dODwDEdX5o2H2FnRrsDRXf1TRFNAffx8CBBT6tuZWWB8XqncsM1Ift9VxwcEqd3GC+cB/gflDtrc/3C460G985MPfgXgXj3H65P1Ced+JJ1MR7YOeylhq8qiyKrlmRRI2lt1Nh3KN/3eMagjtfqJq7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2wEituz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNyGp6Nl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771083510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHk0CQ5qIzWHPHnrz7jbvcgJxtM0KZsyX+BtTo2wjIU=;
	b=X2wEituzDHa0GDX1GlzmQJgW7Mg3z3b5r865NHLo5vM/04fApveSXjR83n6IHWfTimL0UN
	D2hjd2oxVWKp8KYrYSc8wQiHjglQDcZ3g242t0T6FxDdNJJ+kf8j8Q40rdADUyETracGsw
	5y79TgteA2YF/9vMkIbUkGFPGZmyZcI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-0En4-2L-OS-gbEokCJF71Q-1; Sat, 14 Feb 2026 10:38:28 -0500
X-MC-Unique: 0En4-2L-OS-gbEokCJF71Q-1
X-Mimecast-MFC-AGG-ID: 0En4-2L-OS-gbEokCJF71Q_1771083508
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4376761037bso2646690f8f.1
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771083507; x=1771688307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHk0CQ5qIzWHPHnrz7jbvcgJxtM0KZsyX+BtTo2wjIU=;
        b=FNyGp6Nl2h8uGfHJYUcEiE6OkJL5gbcitBiJnJ5BIH27bnuXTj6UBKXy5kW7kTTw7g
         2BcOc291SyLUR9a5Pf5Z4fEjUZB10ywsgEVwENRn8HYhRVdEBO8ni2y7ls+mZDlaj7KB
         YoXYWYDcyMhY23Q3fHcENo8UX7s6rorWZZu5ialzzujK2Hvfho7K2mr0wu1XLvnqwDyl
         Zt9Cxv6sOWT+Xwhd3g0R6OsMJz3xc3AKn/wsBuz7EHeyu47Q6dyt0qEaAgmcdgSCPgJO
         16D9OUIoAG7dyN/Gp5GJ4PI07Jwrf1PDfl4Ct9QAgI+OC5n0YS0k0qDtEGML/ppcPjVm
         RcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771083507; x=1771688307;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LHk0CQ5qIzWHPHnrz7jbvcgJxtM0KZsyX+BtTo2wjIU=;
        b=Q9GpVwj4VHrl0EFD7rzX+T3hD0Wu4vyrzDTbY4PPpTIvF8zhAsYHx12ekWTn97sKAE
         67jTiGsXwW1n+hRysK+j8JQVwfeB8GD4y1SpbDcpywDc5ZhkWf58YtpzNDJiy9riSXz1
         YZ6XeVETcluZudK422nAEr0m38Rdrpx8BJanpmPfRxGPCwwc0JPS/O5+R2+WokELoLBw
         OnCOCvhlJwmSZkw9Vyj/UP0hZpS1IVbihc1yW3zPkfBMLKoN2/5sGGXA9tvRtRUlQyZ+
         i4L52RIQhiwXJBEM1UdrXRGMWaZP1S1VzTLMWiEuB4NGD9t0qa3BoinCQLqkKy4eZzmF
         RQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWGpthK4dG0XDKFVX+hseOZCo8FCWiI+RCSBIKu3l+uQTcf1BV2YerAUrwcQzZuv6y/ZpbSX/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywp904Gv7uWz0wSvAVBbTw487Mhq1frZITY1Q+AX2XbKQRhOmk
	8qmfJkjCft79LOSUajnifZaeQ70I2yw/JL8yhL4qwG3K6qxgpknweTCfaTGIuC4QlWyBavXbsrn
	kx+VEn1fxzeF7wewSRd7AiO3+LQ7Tcbn3auw0RS3ZQ3GMMRncqnZKK4Ti+w==
X-Gm-Gg: AZuq6aJ3abWZ/vNUqA7c44wNjzqRZHo/qRF0E08LmETAx2AoqyfueQ/1KOYuOPGPk9H
	QCqIe3nZZMkAxw5ImHYS6dHltV5eotZM72+ielNT/QUcFyyhS+3wzLQ99rJ8+q59sz9HynEgI1g
	iM+so0rYeBp2ek0MrpDlostqQSniauXrTIyWryg48SpU6NsnB/CiCmkE4eiOuSwwAl6Sqn8+0k6
	G2a+WaSsE9/fjUywTklqs7yq9Bkw2jzqrkD6Z9Nazw+RqH56ULnRM72BokYjX1TDF9UxIknhm7c
	7LLhKamTCYh2Wfv2NjewVz8FX8gkX6C50BZXUuiN/fCsTtmSK1FH4pN6nubDg5fE7hjtEKqPjYw
	yiTWsoOUndW60dDqsIVZK7A4Zwy/J76POrAuBqT6TzSJX317GCxNatc7Yam8=
X-Received: by 2002:a5d:5d03:0:b0:436:36cb:70b7 with SMTP id ffacd0b85a97d-4379d5e2b19mr6654078f8f.7.1771083507538;
        Sat, 14 Feb 2026 07:38:27 -0800 (PST)
X-Received: by 2002:a5d:5d03:0:b0:436:36cb:70b7 with SMTP id ffacd0b85a97d-4379d5e2b19mr6654042f8f.7.1771083507069;
        Sat, 14 Feb 2026 07:38:27 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5f0sm13384761f8f.11.2026.02.14.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 07:38:26 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>, =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
In-Reply-To: <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com>
Date: Sat, 14 Feb 2026 16:37:44 +0100
Message-ID: <874inj72uv.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70B2513C572
X-Rspamd-Action: no action

On 13 Feb 2026 at 05:57:17 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo,
>
> My XSK series (based on top of yours) is ready.
> I won't be sending it while net-next is closed, of course.
>

Nice!
Same for this series, will respin when net-next will reopen.

> It starts with a few cleanup/rework patches that have no direct link to
> XSK and touch code you add in this series. They could be appended to
> your next revision or even squashed (with the right SoB &
> Co-developed-by trailers) for most.
>
> Some contain bug fixes, mostly related to stats accounting. I expect
> some amount of discussion as well, mostly regarding the page pool DMA
> direction.
>

I quickly looked at the patches.

As we briefly discussed off-list, in my plans stats were considered as a
follow up. I intentionally kept them out of the series and to keep it
smaller.
Given you added them, I guess it's perfectly fine if you include
the patch directly in your series (unless maintainers prefer/suggest
otherwise). The same should apply for macb_tx_complete() rework.
That being said, IMO, we should account xdp stats separately instead of
including them in the generic ones.

The one about DMA_BIDIRECTIONAL is already part of this review cycle
(see bot's reply to 5/8) and already incorporated. I'm also considering
the possibility a change that make this no longer relevant anyways, but
I'm not sure as it was planned as a follow up.

Regarding the patches containing simple renames, I don't think they
require a Co-developed-by. The reasoning follows the same logic I
applied to the patch you authored in my series; while I addressed a NULL
dereference, it didn't seem significant enough to mark the entire patch
as co-developed.
The same goes for the style change patch, it doesn't change any logic,
it's just a cosmetic change that normally go through the regular review
process, but if you think it requires a separate patch, feel free to
follow up on this in your series.

Paolo

> Patches don't have the proper Fixes tags, sorry about that.
> I'll send them as reply to this email.
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


