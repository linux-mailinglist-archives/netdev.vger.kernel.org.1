Return-Path: <netdev+bounces-130127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC50988776
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C21C2111A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234C1C0DCD;
	Fri, 27 Sep 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RcKDltfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B51BFE18
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448378; cv=none; b=pxPkB7LXp1XlFsIwUv27ci7T3ESK+OP5xg/ubY2jyTgSD7hTgQQKSDb6iWOmU2MtVl3+/AQaqMBwPe+AT8waxmOQ7i6EhM0kweBJWmdJ249JVDjQbUcFl4ogIyP326aZ+jttkCYC2NOZyOTdPnPbJ7pML7yOa9yUpb1ABAGc4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448378; c=relaxed/simple;
	bh=pBWJEvr3pPNxkYgYQljnvrufA5be6F/pvfPSHGh2Rs8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JwT8L3Hpxm54o6Z1UwCkNoISGbkKhLIQDCpQQw0pUMmnh5ADfAMJ+cLbILpUd1XKralf6uQjltTISH32l1Ye2sVWy5nWfDFI7aI/wKnbKvxnVbIbb4QQdIfXVkloAcyPGXFg55MQHpgMPIWq4zfUcQEdX6hcIiLjXRZVeya6Ioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RcKDltfd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso18725425e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727448374; x=1728053174; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBWJEvr3pPNxkYgYQljnvrufA5be6F/pvfPSHGh2Rs8=;
        b=RcKDltfdKFMuB3gmY3/6G/ow3defwq6xP5YW6iYpMN9YQPjFTlQJV6WLWsiGsmurSX
         6oh/USm5FJFuP09xFjpH1I8uwQE4ZsanpY9AWTLH1t22f+7mKK2QCgS0XetJV78ZP9Nq
         1e31VyTQ2CplRQt2orboSWqhtMhRBOs1yNTNQg/ZibiGNRdrEQNCrARKjc33oV6zR9FB
         hER9zebsSgO/4mI6pay5/KH52BqO4WWo1vLNyyah7vFdEPT5HUiuZN/KmLfq33P95BuO
         jvETGXMvBKrrR0Rw5UpW8H0RR0YIdLqd49rAkY0loAK7LTNqrCXvTtG8Jfi/qh1U21+J
         ACIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727448374; x=1728053174;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBWJEvr3pPNxkYgYQljnvrufA5be6F/pvfPSHGh2Rs8=;
        b=GuzGOSnu5npAJVVl4bw8VfY+AzzWm8wJWM/3jMd3R02O2LtFhALMp9T8mBPdk2QGnd
         0I1CzIvJedhpFpbvIpdDkbChlfJzz+xuqSRydb9jFuywaJwrUWJxD47Q/aTBYhkCCJch
         o18ok/Li/hPpLM8UkPZA/cMjuQDl8GtlOf7foGFzp4Eu5lurMn2G0PS84CCJ5FY+9uwV
         G1C1sMH7hdZeTOtT/96vr7B1XYEszqKZxlv7SQRB4fsnDHsY0KGTtp6s0kwhQgrm7tGV
         8WLG+o4PjEcuK78E6FgGvdizhzM81QIhcnfe4xvCS6dflpKl6+qpWYf0byDmOc4lgpzV
         ZGJA==
X-Forwarded-Encrypted: i=1; AJvYcCUFtW0xO+hM+38LjQ2Nku3a47qDdAvH9FdaqWiAl9PifR4WCrxq+WCTb+JlAklePFRRlHfHY40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkS7pWqkKxZsJEws0kTERHSLihsj/PuvyJAlvgW8c4Z66sf8aQ
	R8eLeegdUlNtlw1UzSv9/mo/GVgHuOYm8Zeqe3WwHpf7FV8RXqW8V4b0Na4fnW8=
X-Google-Smtp-Source: AGHT+IHQKLJJrUYp85Jvw0HbSR1wOzuqg4xDJnjF9OQOqaiPfBjqrgxkyqZicn79MqwipuNZXWMuZg==
X-Received: by 2002:a05:600c:3155:b0:42b:a9d7:93 with SMTP id 5b1f17b1804b1-42f58480fb3mr22450835e9.28.1727448374086;
        Fri, 27 Sep 2024 07:46:14 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::241:20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd2e67sm28973095e9.10.2024.09.27.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 16:46:12 +0200
Message-Id: <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, "Lorenzo Bianconi"
 <lorenzo@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <kuba@kernel.org>, <john.fastabend@gmail.com>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <tariqt@nvidia.com>,
 <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: aerc 0.8.2
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk>
In-Reply-To: <87ldzds8bp.fsf@toke.dk>

On Fri Sep 27, 2024 at 12:24 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> "Arthur Fabre" <afabre@cloudflare.com> writes:
>
> >> >> The nice thing about an API like this, though, is that it's extensi=
ble,
> >> >> and the kernel itself can be just another consumer of it for the
> >> >> metadata fields Lorenzo is adding in this series. I.e., we could ju=
st
> >> >> pre-define some IDs for metadata vlan, timestamp etc, and use the s=
ame
> >> >> functions as above from within the kernel to set and get those valu=
es;
> >> >> using the registry, there could even be an option to turn those off=
 if
> >> >> an application wants more space for its own usage. Or, alternativel=
y, we
> >> >> could keep the kernel-internal IDs hardcoded and always allocated, =
and
> >> >> just use the getter/setter functions as the BPF API for accessing t=
hem.
> >> >
> >> > That's exactly what I'm thinking of too, a simple API like:
> >> >
> >> > get(u8 key, u8 len, void *val);
> >> > set(u8 key, u8 len, void *val);
> >> >
> >> > With "well-known" keys like METADATA_ID_HW_HASH for hardware metadat=
a.
> >> >
> >> > If a NIC doesn't support a certain well-known metadata, the key
> >> > wouldn't be set, and get() would return ENOENT.
> >> >
> >> > I think this also lets us avoid having to "register" keys or bits of
> >> > metadata with the kernel.
> >> > We'd reserve some number of keys for hardware metadata.
> >>
> >> Right, but how do you allocate space/offset for each key without an
> >> explicit allocation step? You'd basically have to encode the list of I=
Ds
> >> in the metadata area itself, which implies a TLV format that you have =
to
> >> walk on every access? The registry idea in my example above was
> >> basically to avoid that...
> >
> > I've been playing around with having a small fixed header at the front
> > of the metadata itself, that lets you access values without walking the=
m
> > all.
> >
> > Still WIP, and maybe this is too restrictive, but it lets you encode 64
> > 2, 4, or 8 byte KVs with a single 16 byte header:
>
> Ohh, that's clever, I like it! :)
>
> It's also extensible in the sense that the internal representation can
> change without impacting the API, so if we end up needing more bits we
> can always add those.
>
> Maybe it would be a good idea to make the 'key' parameter a larger
> integer type (function parameters are always 64-bit anyway, so might as
> well go all the way up to u64)? That way we can use higher values for
> the kernel-reserved types instead of reserving part of the already-small
> key space for applications (assuming the kernel-internal data is stored
> somewhere else, like in a static struct as in Lorenzo's patch)?

Good idea! That makes it more extensible too if we ever support more
keys or bigger lengths.

I'm not sure where the kernel-reserved types should live. Putting them
in here uses up some the of KV IDs, but it uses less head room space than=
=20
always reserving a static struct for them.
Maybe it doesn't matter much, as long as we use the same API to access
them, we could internally switch between one and the other.

>
> [...]
>
> >> > The remaining keys would be up to users. They'd have to allocate key=
s
> >> > to services, and configure services to use those keys.
> >> > This is similar to the way listening on a certain port works: only o=
ne
> >> > service can use port 80 or 443, and that can typically beconfigured =
in
> >> > a service's config file.
> >>
> >> Right, well, port numbers *do* actually have an out of band service
> >> registry (IANA), which I thought was what we wanted to avoid? ;)
> >
> > Depends how you think about it ;)
> >
> > I think we should avoid a global registry. But having a registry per
> > deployment / server doesn't seem awful. Services that want to use a
> > field would have a config file setting to set which index it correspond=
s
> > to.
> > Admins would just have to pick a free one on their system, and set it i=
n
> > the config file of the service.
> >
> > This is similar to what we do for non-IANA registered ports internally.
> > For example each service needs a port on an internal interface to expos=
e
> > metrics, and we just track which ports are taken in our config
> > management.
>
> Right, this would work, but it assumes that applications are
> well-behaved and do this correctly. Which they probably do in a
> centrally-managed system like yours, but for random applications shipped
> by distros, I'm not sure if it's going to work.
>
> In fact, it's more or less the situation we have with skb->mark today,
> isn't it? I.e., applications can co-exist as long as they don't use the
> same bits, so they have to coordinate on which bits to use. Sure, with
> this scheme there will be more total bits to use, which can lessen the
> pressure somewhat, but the basic problem remains. In other words, I
> worry that in practice we will end up with another github repository
> serving as a registry for metadata keys...

That's true. If applications hardcode keys, we'll be back to having
conflicts. If someone creates a registry on github I'll be very sad.

(Maybe we can make the verifier enforce that the key passed to get() and
set() isn't a constant? - only joking)

Applications don't tend to do this for ports though, I think most can be
configured to listen on any port. Is that just because it's been
instilled as "good practice" over time? Could we try to do the same with
some very stern documentation and examples?

Thinking about it more, my only relectance for a registration API is how
to communicate the ID back to other consumers (our discussion below).

>
> > Dynamically registering fields means you have to share the returned ID
> > with whoever is interested, which sounds tricky.
> > If an XDP program sets a field like packet_id, every tracing
> > program that looks at it, and userspace service, would need to know wha=
t
> > the ID of that field is.
> > Is there a way to easily share that ID with all of them?
>
> Right, so I'll admit this was one of the handwavy bits of my original
> proposal, but I don't think it's unsolvable. You could do something like
> (once, on application initialisation):
>
> __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add a nam=
e for introspection? */
> bpf_map_update(&shared_application_config, &my_key_index, &my_key);
>
> and then just get the key out of that map from all programs that want to
> use it?

Passing it out of band works (whether it's via a pinned map like you
described, or through other means like a unix socket or some other
API), it's just more complicated.

Every consumer also needs to know about that API. That won't work with
standard tools. For example if we set a PACKET_ID KV, maybe we could
give it to pwru so it could track packets using it?
Without registering keys, we could pass it as a cli flag. With
registration, we'd have to have some helper to get the KV ID.

It also introduces ordering dependencies between the services on
startup, eg packet tracing hooks could only be attached once our XDP
service has registered a PACKET_ID KV, and they could query it's API.

>
> We could combine such a registration API with your header format, so
> that the registration just becomes a way of allocating one of the keys
> from 0-63 (and the registry just becomes a global copy of the header).
> This would basically amount to moving the "service config file" into the
> kernel, since that seems to be the only common denominator we can rely
> on between BPF applications (as all attempts to write a common daemon
> for BPF management have shown).

That sounds reasonable. And I guess we'd have set() check the global
registry to enforce that the key has been registered beforehand?

>
> -Toke

Thanks for all the feedback!

