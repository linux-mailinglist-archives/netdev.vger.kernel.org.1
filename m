Return-Path: <netdev+bounces-130088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D1988261
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3B5281C9D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D01BC086;
	Fri, 27 Sep 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNAkwGJe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B31BAECB
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432674; cv=none; b=NkXrbTzuePRkZXaTsM6itxaww0G2HKTtD1HzcEWqoMYnsN1fn3QVQabWsgl24QUi0ZxDiFSdSk4UiKoB84tqKTW//mmMgvEBZLHAc/qDJxUA5mkjCzjvNynDr3tnAHznKqyCDkrKMHsT/AwK9x/RNIN1NrVwE2GjiKAygJSaeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432674; c=relaxed/simple;
	bh=XIxx1Gqnh8W7x2jrzbkG+Yz0hMarOzuqSzj35yPNitg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kfm25gxi7DWicPzltYgvKpSdX7oFNS9NknBxlj33mixDC65CcIk/5q3nmEbqtyDx4yxDK2hEYCHqCOaPtInfKivb6r4VsJKGYS8Gy4AjZqnq7GZnyLCga4RMcgCABVeIG9gj2b9cMpnshkHukMCgahMt/AHIbPz4ZxW6z56eUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNAkwGJe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727432671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIxx1Gqnh8W7x2jrzbkG+Yz0hMarOzuqSzj35yPNitg=;
	b=ZNAkwGJex5S1spnwY74V2/EaT0cH/3Nr5aPxKxrEh0z5dKSa4WJ26WxpmANnWvczbvEHm3
	nqE5etzgSGCWWQBBOkKBBxTldYEv/5wcknRl+RZXHclTSdPvj0RzWfVaNMICt63cBZY+XB
	RLHFlocC6j8/780eLxEwcR8HIgr0ROE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-_y_3El59PZyQ69w8uNO_WA-1; Fri, 27 Sep 2024 06:24:30 -0400
X-MC-Unique: _y_3El59PZyQ69w8uNO_WA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cda7514f8so254757f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432669; x=1728037469;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIxx1Gqnh8W7x2jrzbkG+Yz0hMarOzuqSzj35yPNitg=;
        b=L+uISh9pBLEkkfOMCNFdAKtF5gBW3sxwl9wJ0l1whfWn86ZQ0TIU++YPM8u97E+8K6
         yUDIKPhqkxD25/f+VA8GBemQcxyVFZ7Drw3QiZYqnV84aw5cW2IO87GypTEFtFikJwZt
         uIWza3iHevkDwQoiDCc17D8d07dNBS5LzYj5ZZ1HRUWVuWWs4gvWaioaKkAgiQks4VJd
         B/wuv+aEWJCC5ws6Tt9hGzv6GDAeqK9wXLsxOpHnS7Mx01gaNmVQ7EGG59+SMmKg4JfH
         1UgUcoPspfaZQAbPAqgtRO2o84mOc5BUi2ErHJANWJiruCqzlgdm8jfs1GyPYEk1uxoM
         fQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGIqdIAD1ZEUU8xF4VlyWN+NTOG9+PCwUquzT1nG95dE3VFQTyC8YOQvztpf9xr/52IWtLqFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zFmVHzoE4rKtv/UCH09DzIx9QuKSLSSePlZCZWPwXVTbKMoa
	QfwTgVPzz6QqbR0ePRNVwoEFRW3ebYnG35uBEkqeuLs0sBO3eGU9ckB55amXcCvJT/dQ3R7BWf1
	sIqnDp81MxRIH0MRjznuXp4qUNR/4Jrf53YDgk+x7viu8DcrDnsS/OQ==
X-Received: by 2002:a5d:5408:0:b0:37c:c4c0:4545 with SMTP id ffacd0b85a97d-37cd568c351mr2074551f8f.10.1727432669168;
        Fri, 27 Sep 2024 03:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzn/Hgbyr1j8TFmWW8rLoliM3ZBfnFOOaG1RI387NGbgDvZsVbVAlmnlZnn5QvDNrkUnRcIA==
X-Received: by 2002:a5d:5408:0:b0:37c:c4c0:4545 with SMTP id ffacd0b85a97d-37cd568c351mr2074515f8f.10.1727432668693;
        Fri, 27 Sep 2024 03:24:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fa48sm2035752f8f.66.2024.09.27.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:24:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 64AE8157FD23; Fri, 27 Sep 2024 12:24:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
 pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, kernel-team
 <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 27 Sep 2024 12:24:26 +0200
Message-ID: <87ldzds8bp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arthur Fabre" <afabre@cloudflare.com> writes:

>> >> The nice thing about an API like this, though, is that it's extensible,
>> >> and the kernel itself can be just another consumer of it for the
>> >> metadata fields Lorenzo is adding in this series. I.e., we could just
>> >> pre-define some IDs for metadata vlan, timestamp etc, and use the same
>> >> functions as above from within the kernel to set and get those values;
>> >> using the registry, there could even be an option to turn those off if
>> >> an application wants more space for its own usage. Or, alternatively, we
>> >> could keep the kernel-internal IDs hardcoded and always allocated, and
>> >> just use the getter/setter functions as the BPF API for accessing them.
>> >
>> > That's exactly what I'm thinking of too, a simple API like:
>> >
>> > get(u8 key, u8 len, void *val);
>> > set(u8 key, u8 len, void *val);
>> >
>> > With "well-known" keys like METADATA_ID_HW_HASH for hardware metadata.
>> >
>> > If a NIC doesn't support a certain well-known metadata, the key
>> > wouldn't be set, and get() would return ENOENT.
>> >
>> > I think this also lets us avoid having to "register" keys or bits of
>> > metadata with the kernel.
>> > We'd reserve some number of keys for hardware metadata.
>>
>> Right, but how do you allocate space/offset for each key without an
>> explicit allocation step? You'd basically have to encode the list of IDs
>> in the metadata area itself, which implies a TLV format that you have to
>> walk on every access? The registry idea in my example above was
>> basically to avoid that...
>
> I've been playing around with having a small fixed header at the front
> of the metadata itself, that lets you access values without walking them
> all.
>
> Still WIP, and maybe this is too restrictive, but it lets you encode 64
> 2, 4, or 8 byte KVs with a single 16 byte header:

Ohh, that's clever, I like it! :)

It's also extensible in the sense that the internal representation can
change without impacting the API, so if we end up needing more bits we
can always add those.

Maybe it would be a good idea to make the 'key' parameter a larger
integer type (function parameters are always 64-bit anyway, so might as
well go all the way up to u64)? That way we can use higher values for
the kernel-reserved types instead of reserving part of the already-small
key space for applications (assuming the kernel-internal data is stored
somewhere else, like in a static struct as in Lorenzo's patch)?

[...]

>> > The remaining keys would be up to users. They'd have to allocate keys
>> > to services, and configure services to use those keys.
>> > This is similar to the way listening on a certain port works: only one
>> > service can use port 80 or 443, and that can typically beconfigured in
>> > a service's config file.
>>
>> Right, well, port numbers *do* actually have an out of band service
>> registry (IANA), which I thought was what we wanted to avoid? ;)
>
> Depends how you think about it ;)
>
> I think we should avoid a global registry. But having a registry per
> deployment / server doesn't seem awful. Services that want to use a
> field would have a config file setting to set which index it corresponds
> to.
> Admins would just have to pick a free one on their system, and set it in
> the config file of the service.
>
> This is similar to what we do for non-IANA registered ports internally.
> For example each service needs a port on an internal interface to expose
> metrics, and we just track which ports are taken in our config
> management.

Right, this would work, but it assumes that applications are
well-behaved and do this correctly. Which they probably do in a
centrally-managed system like yours, but for random applications shipped
by distros, I'm not sure if it's going to work.

In fact, it's more or less the situation we have with skb->mark today,
isn't it? I.e., applications can co-exist as long as they don't use the
same bits, so they have to coordinate on which bits to use. Sure, with
this scheme there will be more total bits to use, which can lessen the
pressure somewhat, but the basic problem remains. In other words, I
worry that in practice we will end up with another github repository
serving as a registry for metadata keys...

> Dynamically registering fields means you have to share the returned ID
> with whoever is interested, which sounds tricky.
> If an XDP program sets a field like packet_id, every tracing
> program that looks at it, and userspace service, would need to know what
> the ID of that field is.
> Is there a way to easily share that ID with all of them?

Right, so I'll admit this was one of the handwavy bits of my original
proposal, but I don't think it's unsolvable. You could do something like
(once, on application initialisation):

__u64 my_key = bpf_register_metadata_field(my_size); /* maybe add a name for introspection? */
bpf_map_update(&shared_application_config, &my_key_index, &my_key);

and then just get the key out of that map from all programs that want to
use it?

We could combine such a registration API with your header format, so
that the registration just becomes a way of allocating one of the keys
from 0-63 (and the registry just becomes a global copy of the header).
This would basically amount to moving the "service config file" into the
kernel, since that seems to be the only common denominator we can rely
on between BPF applications (as all attempts to write a common daemon
for BPF management have shown).

-Toke


