Return-Path: <netdev+bounces-269040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLInGZ+zumlWawIAu9opvQ
	(envelope-from <netdev+bounces-269040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:15:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679C2BCD94
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1CD8304FD49
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628533DA5DE;
	Wed, 18 Mar 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd36vT0o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMEkVcO7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A33D9DDE
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843007; cv=none; b=pZAasnTNAHINfjwXJZGjl2Cz6YqccbFoOUer6n8VywTPc+9ZGKRpDy3EpXY7X8ASmHXPtyo6uBCWzc7AcI03psoI76Z1l+etDr7mItwV33BgFJuDAOtjUZA6VJZjuYdBebnXS4Q4g29cvdZVj2xfRxbnCIRrlb8E3Enf8UJ4hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843007; c=relaxed/simple;
	bh=sS8EMwx3yn4V1yYqUYo5FR1HNVDX1hx21r0s6HXSv3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufZm1KPrpB9MkPHzNMhwMe31zxztyip5QA6+cmFt+pTKfiGaUaUb1RNuphFM/TFOHivsXzpXMFsMm3JOtnkci3lTk2lVMp7IH4Cuwzd++GrOsSKHQZnwDolLw/Qdy33/dmHDdK2nV8inHJOwjjN2urLmYNKUrHhawHOWM1txyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd36vT0o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMEkVcO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773843005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5fd1oB1XpU5lZ9zPQH4Op2uE6KrAjWmWzWTPZtcsio=;
	b=Cd36vT0o9aWjp6PaET4XbISMplM2lrtsj0IdGvOU5tdMxCXfjXc6qH3xp+SnfBrsnzvHXD
	B2LB+y0qmif0kXLYhq7iXZCq8ige/+UdJZX2dBjoKNk9t+X2fSozzPIazLmMPiLx1c2Vzs
	vN1YfuDal2MaBAgKB+0zqtmQ1HHDUQg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-MQO7fyVKN_uTvGPYiNpC-A-1; Wed, 18 Mar 2026 10:10:03 -0400
X-MC-Unique: MQO7fyVKN_uTvGPYiNpC-A-1
X-Mimecast-MFC-AGG-ID: MQO7fyVKN_uTvGPYiNpC-A_1773843002
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b3a675316so3157845f8f.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773843002; x=1774447802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5fd1oB1XpU5lZ9zPQH4Op2uE6KrAjWmWzWTPZtcsio=;
        b=MMEkVcO7b00FEQvn00JTPqBj6t7qVfNuicOle60uw4YZL6IuomBHHaEMLjv3/Kh8Vk
         IsnxaYOzO+rMBLApuSs58uZcWohVvVRVFGpmTrQ0KIVLHbE5smC25zpL2K5TexKK6xao
         s9E/vFJP8hk2bfVEonOUs3jWAJexEOzj6JWIjBiJQXl6n5itu3/fke08JqRvnBsMNXU2
         Z2yXbrC7QgIcoYVraX7MzNRqHWahYUGDEJqloBxYFtnZTuoNWj1lcTp/K548fOvO29eu
         CPHIsJhWxWk/rSZZh/eq6XssORLv2fG0SiezfThyUYidGsiupisSZlFV6lU9hu95VLmn
         ++Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843002; x=1774447802;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5fd1oB1XpU5lZ9zPQH4Op2uE6KrAjWmWzWTPZtcsio=;
        b=SaM+E8JOwtWxJB2Gmw6u5v4Ss3yhqZc2BbpaU8TJuAzCyj+PbOHjeeIYYaW7A7iQxo
         z2kuoeCdVuEIWjZhPlw9WUEX8AyqcMR6ZG2G4IKeDLd1TRUvL19Y55nXlhr7a2Zwt3xI
         m76GuqBJQnwnYdAQCWXAXfVQ+Uwm7TDh9WG2ALcymorQkaZdLfs7AkpcEb80MbeAAVhm
         78RCv+qBE8R/Ds8UO60bLFeRWBy58CQWnki9yrli+WCTXxjnpQeBRuV/wMQT4782lRlq
         VEgPinydJDavb7RjefrlSsGbnGyOnpSqHiQcksZhHVogjQTADdNgEoRUVgm53IolTTSo
         iUQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEK9kbNw7vTmx7MVQLaayEQbmZeQrrrDQX1AveFWwKc16aOo1FnebSn2WKonN1zLgOnvMZPqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMiAKNkay8ALsDuryIsbmoLNxl3XVF11QnJUtK2eNJChJsMqS
	R4COdTkiHQAolbnhWTXFBoJtqJJVAtVzpAFmSf+8e2V7UsQ4QNnLs3da2ozPE3VaMTghHiKby6H
	vI0Ohuzn2fumB3MVhyzF6l4+izhAjbm5tW3/U2cQCrqGfu4tl5VI97sHwLw==
X-Gm-Gg: ATEYQzx0tcshFaiVFJNwttrgeS7XR6+6jssX8PTk5/CVW+PPPxYhuy/ffXO+fHD5jUW
	Q2WURl3hgSLNasSDk8NGmN3HFv2Psz8diNn/zGvaYYv1sLxjaN1/JU7sngLq9QiCCg54rzxIu8z
	Jxh2cXOW9UWJ4fLpphHKJkgOQRHN/GuMQZ5+q6oKmIXRIPf9WBv14YYdNzNrgg7Fd/yogBvTuzQ
	Kr2Y55e5nuWurrUXAW6R22iEkOWpHXx1qjgDu6IWrB+qEMnPsp9M62puEUvBYoLZRBNOzu4ojyz
	cVKKgWOl+gKunKcc2gwahFrz1UhAW9SDGVcizYfHz8cx7CYrRgmC73CVyQ/RINMV3GqyXu0QhT4
	Fh3CL1K5X6U3e5Dt9fPMoyNghoccIaMpFKQPUxkfJNNWX/qRC
X-Received: by 2002:a05:600c:c178:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-486f45729d0mr62586705e9.19.1773843002247;
        Wed, 18 Mar 2026 07:10:02 -0700 (PDT)
X-Received: by 2002:a05:600c:c178:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-486f45729d0mr62585685e9.19.1773843001645;
        Wed, 18 Mar 2026 07:10:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f463c9f3sm32416535e9.3.2026.03.18.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:10:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 167115A31AF; Wed, 18 Mar 2026 15:10:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com
Subject: Re: [RFC PATCH net-next 6/6] net_sched: codel: fix stale state for
 empty flows in fq_codel
In-Reply-To: <20260318134826.1281205-7-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-7-hawk@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 18 Mar 2026 15:10:00 +0100
Message-ID: <87pl51ns93.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269040-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tu-berlin.de:email];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0679C2BCD94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hawk@kernel.org writes:

> From: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>
> When codel_dequeue() finds an empty queue, it resets vars->dropping
> but does not reset vars->first_above_time.  The reference CoDel
> algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:
>
>   dodeque_result codel_queue_t::dodeque(time_t now) {
>       ...
>       if (r.p =3D=3D NULL) {
>           first_above_time =3D 0;   // <-- Linux omits this
>       }
>       ...
>   }
>
> Note that codel_should_drop() does reset first_above_time when called
> with a NULL skb, but codel_dequeue() returns early before ever calling
> codel_should_drop() in the empty-queue case.  The post-drop code paths
> do reach codel_should_drop(NULL) and correctly reset the timer, so a
> dropped packet breaks the cycle -- but the next delivered packet
> re-arms first_above_time and the cycle repeats.

Nice find! I think this is worth submitting as a separate fix, no?
Probably with a fixes tag:

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")

and possibly this one as well to aid stable backports:

Fixes: d068ca2ae2e6 ("codel: split into multiple files")


> For sparse flows such as ICMP ping (one packet every 200ms-1s), the
> first packet arms first_above_time, the flow goes empty, and the
> second packet arrives after the interval has elapsed and gets dropped.
> The pattern repeats, producing sustained loss on flows that are not
> actually congested.

Note that this only happens if the ping flow actually gets into a
dropping state before emptying out. Which rarely happens in practice,
which I'm guessing is why this was not discovered before now :)

> Test: veth pair, fq_codel, BQL disabled, 30000 iptables rules in the
> consumer namespace (NAPI-64 cycle ~14ms, well above fq_codel's 5ms
> target), ping at 5 pps under UDP flood:
>
>   Before fix:  26% ping packet loss
>   After fix:    0% ping packet loss
>
> Fix by resetting first_above_time to zero in the empty-queue path
> of codel_dequeue(), matching the reference algorithm.
>
> Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


