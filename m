Return-Path: <netdev+bounces-282590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED67Nxy18mmUtgEAu9opvQ
	(envelope-from <netdev+bounces-282590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CB49C184
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253D23008D11
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DEB274FE8;
	Thu, 30 Apr 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUnci1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A738261B9B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513736; cv=pass; b=VxGIxLt9H9kZLitpj5cfKXXRkIxr33SH2KUulzokrWWASzuEmjR1yE6Ven+GDeXQWgqHV0U9ksLWup76odykZiZnjFpxVDb+qk1G/QXR+5+Kk0pKdJ49Om2b+zU+vRFqXRXy31SF/Vh7LiumlY5Ed0waqSAvqvE+xSKGBP8zLBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513736; c=relaxed/simple;
	bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rddMeSQEDOCvwcXs9Tijvvf5rhvrMq9Smge/L9TEP3jCVPvCMrAZOcfmZDjpkDo0hKes8iAcGqbHEHZDvp5SHFsFQtQcdibhLdVBLJ+e7b43ADANyI1VxNc0g6UjYrCOqFWAVod1/1xKxojB+HoNW1N3aLjGoPp6AX8nXelxhMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDUnci1J; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8aca2726f61so6278466d6.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777513734; cv=none;
        d=google.com; s=arc-20240605;
        b=duZTsqNepNP/Vpph/7COR0HR0t6JbI2av5+6MGFZHrzloPVJdJl78YPG2LROVJCb9Z
         ja+PfQMKBsEln0fC5Y+FU5OHrHVxnLaXHRr1i9Y07HyCnO2C3BSQgYKnMbgDKezd7H2M
         j90jNQ0xfa/JKkD8fmAZVSCiefOby39HpeIT93nWNTsSxyn5c6Pjnhb8olDmqlL6dzjM
         7Ve7kvUiLN+5PMUcuPFO/mos+cDx6lFz2SKAopl+jaOR/8hCbQ9Ck6DN3hKZHvW8KiP3
         ZhOjpfwTvt+amrhmg044FY5hZcv8PQI55pb7xbxQayv767w1Ywkmf+gsLKW/ZuLmwPti
         NJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        fh=vAlDPZgThCC6etRTHHhmGYq1pRJwYWxyKtIdxCdY4B8=;
        b=JlrnHM8+HW7lz0+rAyDVfFPZPWxayQMS0Pwm/S7h29r7+DVD/QzZz1J/p7bULdq/Dk
         fSH7MefyKIxVFIOEpRmHFUaTFcdtQU72d7gLLADt4Inp5tFoh7mGEzthba1UOeiejmop
         IQ0fPSTnESRkrVrGCOfdfjXfBIFBNVrXp4JLEUoCc/JETryFGv+PZqjBUhymERT+vu0Q
         qTDBNjNgy78GyDpk5C4BIaY4mpFg9XYN7Dkm8AvcJvjZFnamrpN2k/X5jUuM80zrj2mn
         2yAJzsq4IDdBLf0/me/yP7rkNQawWUcvVwsgdGMt4QF3URV4ACX4tPbxgZblmg9d25Rx
         /m8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777513734; x=1778118534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        b=rDUnci1JgHxQSDhZfk9wGYqdUKCeE41E1Z6ulxH+PRJE+u3zPlkL5255OKnQp89giO
         9wp3twjquQqjFmycL207huBV0z4+tE0A5CpC956c9Nz+y4c/P+pwlAQD6qUH7zuUMBkR
         5UhzGa6Kba9EsDvjZHQSmgS9tbsFnssMuIgHgaJX/gUmBOv76Cpu4sl8upP7edZDLwN1
         TlmOEOtbuSyEofB/gL7T8lb2LB/DNeKj8TRPcFz0jJK8P8mS2QKeWC7HchKSYS/3vHqO
         +96svf2s9bjHL+s+HhGzb22YsmmwNOV5d7Zgi4a4LPyUVANo/k6ISxl45aJ8weKl9L1Z
         eoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777513734; x=1778118534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        b=oWuZ9qvbQd3FjDyCIniYorMh7ry47nR4IVyTKPaH7IXTS+UwNZZOD3zLewjFy/U3Sa
         Ma9+IaLH8YQhd4QURkrOHvhzlCJu1nVxuGToieiyCYkfLjtF6MTROEL9lAaBJjxvg+aO
         k/2VVM28+9fGUPKi31OwWmus0TMTIvkv+CtVPcXDzxoYZ1Iq9eCwP4splw5u2p96g4u/
         K4Q53uYI0xfTbfvoI18Hs0PhEPr5MAEs6cyhYYTiD55HN5kTOuuYTIpEXCRe1SiM/JrA
         knXwFxI41Las07nlXSRb52eqN9KycrG75U4dQcimm3DEdI52Hghnm/zFzUWlWv3/TPwi
         aw4A==
X-Gm-Message-State: AOJu0YyAjmpIW18vb2F/dbFXvDX7yRLxn8nw5xLZd7ubZCiZVxG9ghRY
	ludk8/ABrlMDRtOCf50wOw2kXG0u2IM1A9pmbm1JVpCpCH4CHLZGMjv4Wm3mPLTPCjcitXzaSz4
	6o6sb1hE5NFEeM5vVRws/eo6ZTo0QAFc=
X-Gm-Gg: AeBDievrgpiS/HqeZ8LJ4Wei5USVMG/h4vtnzI4EdoA5+L/4k3vPBL9xCBTmPrfayA4
	NfBBX6lBucOVi9p+jtuvICtn+RwAfICBbiu62gcaMzE/FNuZdjisxwWF9BT9xxeAmzvg/07sL3f
	IOuIibM/gbdlMRxAd3r7eFwqpBYxvPTFOqVZHkeZg8mC5szc9dacXtR+XzSuroWTjszEKIBTj7n
	hpT0YCjFyEnIeqVt5TJ3H7d/M9ADRjz7wF+x6Bi1Cn+nD9tXV841GpVS6RzVIPEp/E2N9as7+lL
	XhTHwFp/mOBadU95LjUnBglcaGGcW7qkYo8Fla6/fjzq0T6egZk1Q9+icjEpw5bCza+0dT4pZeF
	+iaM=
X-Received: by 2002:ac8:5dcf:0:b0:50d:4601:e335 with SMTP id
 d75a77b69052e-5102ae5de21mr13700191cf.54.1777513733882; Wed, 29 Apr 2026
 18:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428030826.47509-1-enelsonmoore@gmail.com>
 <20260429175421.014bb28f@kernel.org> <CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
 <20260429182701.28edde72@kernel.org>
In-Reply-To: <20260429182701.28edde72@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 29 Apr 2026 18:48:43 -0700
X-Gm-Features: AVHnY4JzAmcEdxPyItkj_q8Wxw9A4aKJfDhdvIkOsOY2k8ahbWf25THMCYHvnm0
Message-ID: <CADkSEUgYtyoGNAyVJQNUPvpaGZdn-L6OzE9qP+T-rDt8AVmgQA@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 391CB49C184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282590-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi, Jakub,

On Wed, Apr 29, 2026 at 6:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> That'd require us to know if the device is going to be used on
> desktop because for datacenter NICs suspend/resume does not matter.

Good point - I was thinking about that myself. I would be fine with
only marking it as broken until it can actually transmit and receive
packets. What do you think about that? Of course, as a maintainer, the
decision is up to you in the end.

> Maybe it was written in simpler times, maybe the help message was
> aspirational to begin with..
Probably both. On a related note, I think something needs to be done
about some drivers staying in staging indefinitely without being moved
out of it or removed. The most obvious example is rtl8723bs. Eager new
contributors have spent an inordinate amount of time cleaning it up,
yet it is nowhere near ready to be taken out of staging. One major
blocker is that it doesn't use mac80211, but changing it to do so
would be nearly impossible in its current state. I think it makes the
most sense now to either remove the driver entirely if no one is using
it or add SDIO support to rtl8xxxu (some work has already done on this
out-of-tree).

Ethan

