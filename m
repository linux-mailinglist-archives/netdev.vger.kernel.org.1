Return-Path: <netdev+bounces-130298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDC989FFE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31E81C2277D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E618E764;
	Mon, 30 Sep 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkVzmenP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3318E744
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693892; cv=none; b=jxRWB30IGYof+l9BRiWgUPJPCwwWrWrVUx/H2oetBtTVlZEts/BRbfdAFUn0e59AQtQubxa7w0ScAuGt6ij+epQkclhLKRykvkprSeW8v2M6BKETeA3OsCPE9X2fx/RKj3t+1HR/obSknvPXI7MPU6+EkbXx4+ISfKOFbS4sJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693892; c=relaxed/simple;
	bh=+uyWgyJ98fQfMuxU60GFRofeatiwHlssYr4aXzzEu4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvki8In8lUI0eRPsfMr6K8/P2pkVJLpCAfDZZMSlLnEXo5wsangdQUMrNH6MrBlbbEmrBkBlVNZtK09M79VCPWhOeuJ98RiFtNlnAXFYFuF+9pIhEGsfDUxLDUKBuN39TRe9hn3IxclvFzVyb9pH0tVTaJ6gIcZy9kps3/zfpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkVzmenP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727693890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQtQd6yJgFN1nEDyO9tB7R6YFKbGVROFVNqQrT35Gl4=;
	b=gkVzmenPRxDZim+YPR4UzjtsYDZXyqRIC7LBF9pFHbOXWXERWIGEZr8UIxLFo8Z6Taz8RS
	lVogRld5zK79IfDrwmD9hzDdMQmcfMX4onLm6SFT8Xfrz9r4IakFBOO2SwFAxRQFUfN6Yx
	DoH8GOieWYnWNFUJ0DnqgicejM0JkWA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-32UZ3oE5Mv-svKtfxbt8Zg-1; Mon, 30 Sep 2024 06:58:08 -0400
X-MC-Unique: 32UZ3oE5Mv-svKtfxbt8Zg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d1a00e0beso94993766b.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 03:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693888; x=1728298688;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQtQd6yJgFN1nEDyO9tB7R6YFKbGVROFVNqQrT35Gl4=;
        b=BtOunmx0c9ZAoTIXS5bknuuStiVOsEUE0hk5s+ZRH0HyJpZ7qAMSGK9UzevgWU/mWY
         1SVcApx7UIYoPT9DhHnm/Pn/gq06aDzecvkRxNz/wok4hYUG1oh8C91qU2LutvY5xU4U
         meBsZ9E1ozxxLsGOXH/dlLm9vhCPyjel+98uMIO3z7uOHdtF35A545Klt7PJIu960D+d
         lrXW41Y23NpzYSpgUK/COt1OxcLGoFx9+Ou3nmLNeOeGfWWc9or5mwtq/L0jtv4Em0wW
         eAgIvRL4dn+H6QwVRMztErzKPOpF8U1X4jYibWjBg9NLuTkHxB8R1eUUMSJXrIzKsFVZ
         MQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YBg4ZyE//hhrBNC5fpQbq1lDnMeKUUFtc4DYWlG5L2xXROfdqIlgANlZDQZiMjb78P1PO1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tqiCV446Vnp4q6ZehqC2OLd1CJiNEYBKMDgiJqZn0YkimlcA
	675XQ8idy1XrSVCN9S5i2MtCCqgDAJww9tSlg+/Efvl8haR3KvP3pySsohNe8rQly5XKvK2HDHO
	ckryYbuDMyFkPpQqGydnTp42ExOilaJGwTyE+bAUW/+7p97TlHl1TdQ==
X-Received: by 2002:a17:907:1c20:b0:a8d:2b86:d76a with SMTP id a640c23a62f3a-a93c320fddbmr1195062866b.32.1727693887599;
        Mon, 30 Sep 2024 03:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGHuIsk16t7bVuBeqIkOOcCdNMy8NqwmYcnnTngn99ySvq772YXEHBZWTPrcxOhMsAnkZifw==
X-Received: by 2002:a17:907:1c20:b0:a8d:2b86:d76a with SMTP id a640c23a62f3a-a93c320fddbmr1195058866b.32.1727693887132;
        Mon, 30 Sep 2024 03:58:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777214sm508704066b.36.2024.09.30.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:58:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7F603157FE98; Mon, 30 Sep 2024 12:58:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Arthur Fabre <afabre@cloudflare.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
 tariqt@nvidia.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <ZvbKDT-2xqx2unrx@lore-rh-laptop>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Sep 2024 12:58:05 +0200
Message-ID: <871q11s91e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> > We could combine such a registration API with your header format, so
>> > that the registration just becomes a way of allocating one of the keys
>> > from 0-63 (and the registry just becomes a global copy of the header).
>> > This would basically amount to moving the "service config file" into the
>> > kernel, since that seems to be the only common denominator we can rely
>> > on between BPF applications (as all attempts to write a common daemon
>> > for BPF management have shown).
>> 
>> That sounds reasonable. And I guess we'd have set() check the global
>> registry to enforce that the key has been registered beforehand?
>> 
>> >
>> > -Toke
>> 
>> Thanks for all the feedback!
>
> I like this 'fast' KV approach but I guess we should really evaluate its
> impact on performances (especially for xdp) since, based on the kfunc calls
> order in the ebpf program, we can have one or multiple memmove/memcpy for
> each packet, right?

Yes, with Arthur's scheme, performance will be ordering dependent. Using
a global registry for offsets would sidestep this, but have the
synchronisation issues we discussed up-thread. So on balance, I think
the memmove() suggestion will probably lead to the least pain.

For the HW metadata we could sidestep this by always having a fixed
struct for it (but using the same set/get() API with reserved keys). The
only drawback of doing that is that we statically reserve a bit of
space, but I'm not sure that is such a big issue in practice (at least
not until this becomes to popular that the space starts to be contended;
but surely 256 bytes ought to be enough for everybody, right? :)).

> Moreover, I still think the metadata area in the xdp_frame/xdp_buff is not
> so suitable for nic hw metadata since:
> - it grows backward 
> - it is probably in a different cacheline with respect to xdp_frame
> - nic hw metadata will not start at fixed and immutable address, but it depends
>   on the running ebpf program
>
> What about having something like:
> - fixed hw nic metadata: just after xdp_frame struct (or if you want at the end
>   of the metadata area :)). Here he can reuse the same KV approach if it is fast
> - user defined metadata: in the metadata area of the xdp_frame/xdp_buff

AFAIU, none of this will live in the (current) XDP metadata area. It
will all live just after the xdp_frame struct (so sharing the space with
the metadata area in the sense that adding more metadata kv fields will
decrease the amount of space that is usable by the current XDP metadata
APIs).

-Toke


