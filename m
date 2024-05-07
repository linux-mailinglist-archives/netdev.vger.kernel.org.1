Return-Path: <netdev+bounces-93969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037308BDC61
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844541F21DC2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88D13B28D;
	Tue,  7 May 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1sQt8m2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714D13BAE8
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066794; cv=none; b=UlFXjRd5SZQmuy/3yPT2WE4Nf7eVo2TYsjq0QD2kMKcrQXfrJNmIxh+OzbRgdGDCwNA4mwxvbrTngWEHRHdm0JexBBzzvdhrU/Ce+4NmZ8XC82eUOE7TYneEUaMSGwBoPVt7nq8o2VlCOd7eL9FiUGENKOpPRTlcT7yKq/6OdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066794; c=relaxed/simple;
	bh=7MpXiMgQGHLmxQ0OdtXnlBwuru1G5DYxHpA08m6Etus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jUtzaG41l0C3KPf8zvuK6gYuc8JY4hUeyvU09rFnJPkODww8M+4oMDfdB3L+z8DZ4OBMjeQMiz6+8kX2nFeCbc98dsjvStSB0Ki0X6FeGercUIActc6k9zjbo6sTQ9DUIOs4WCts6SiGz96tNoaijPyyVcrUpM3Gjyvf/eI7hT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1sQt8m2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715066792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sfy45R6lsrRAD/roDDebjpPvuoKjWVqjyuul7mT10uI=;
	b=J1sQt8m2t+9XQTltPY9wY+D62YgygEJrzkDtmEfu9nkoKIDIwGmBbW4tUVBGrR+sUjAz6a
	1KNszhwtAcRaBgygkbRxorkbYy0Qy6OLRcQbGTfyPwwCKHOIInYXmg2Ta5hOQkHVl6JAGS
	ZGTOMQyw/UK37b8EYJcJcuDn2Sya/0g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-zH6zOZgzNjujKePu13WOjw-1; Tue, 07 May 2024 03:26:30 -0400
X-MC-Unique: zH6zOZgzNjujKePu13WOjw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e1cb7b0816so3506471fa.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715066788; x=1715671588;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sfy45R6lsrRAD/roDDebjpPvuoKjWVqjyuul7mT10uI=;
        b=uQN0V6NnE9UuNUoEh1RC1z9cs8PtfVJKOs1cDQXFcadj0CM4F6GTFdrG6LWydQfgtk
         xZj25WJjjhsH40C/mblevmhWUo2ZXb4pu8WzFXD4SgLBgLCkha+Qiv9KrK6YIPlKUfB9
         OJ0EY8ShiaIhkQe8fteA2xL+a7a1u/fCbappGTXbacPVGxuZJjQqZ4sgc4DBGb/q3SqF
         g4Nd1ksD9kJ+K3UgBuF3lcDVs7IJ/eP14S6lxbYHsjCeQZVyiXbFMKee14Aaw0Uj8+gx
         sKV0QgsEEV0fCCRlaFKAON0KhiqsQ5PMlEQLspZPPC7u6LAAYDKcwY4YP5kWR4BYPXyu
         AUFg==
X-Forwarded-Encrypted: i=1; AJvYcCUqf24BgNn0QQz43VKVOZ0nWXin7xHePpHk1reZB/TWSOm9+x1zgRVyb+mHfEpSAbbJHnFewngeD2R1tVie5kok/TxIjnRn
X-Gm-Message-State: AOJu0YzJ62sq1qjEBUPNU94bx8f5ks/SwHgwOQevKP85l2wKTAF/P2WS
	TlAce2y0VzZ5BPE/aXKhG+4aOCRTvZQkSltIZovmUpCWq+HGJShrRwb03KImEHqR+gixhULPOQx
	/UzLUeun+p1ZDegDr1PfzQdrKh33nWBOf6OVuMzkBhIATVEq03RNmkQ==
X-Received: by 2002:a2e:3c0c:0:b0:2e2:177c:5f6 with SMTP id j12-20020a2e3c0c000000b002e2177c05f6mr7654399lja.0.1715066788578;
        Tue, 07 May 2024 00:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd7MvIU86f0xnKGs3qNXdmJyKYKW8CPvoXT0BGxokQYzfy0jqdHpJPZlR/EW/P+Itfg/iXGQ==
X-Received: by 2002:a2e:3c0c:0:b0:2e2:177c:5f6 with SMTP id j12-20020a2e3c0c000000b002e2177c05f6mr7654382lja.0.1715066788131;
        Tue, 07 May 2024 00:26:28 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0041bf5b9fb93sm18692524wmq.5.2024.05.07.00.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 00:26:27 -0700 (PDT)
Message-ID: <03c25d8e994e4388cb8bfd726ba738eea3c4dcdf.camel@redhat.com>
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
From: Paolo Abeni <pabeni@redhat.com>
To: William Tu <witu@nvidia.com>, netdev@vger.kernel.org
Cc: jiri@nvidia.com, bodong@nvidia.com, kuba@kernel.org
Date: Tue, 07 May 2024 09:26:26 +0200
In-Reply-To: <20240506203207.1307971-1-witu@nvidia.com>
References: <20240506203207.1307971-1-witu@nvidia.com>
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

On Mon, 2024-05-06 at 20:32 +0000, William Tu wrote:
> When a system has around 1000 netdevs, adding the 1001st device becomes
> very slow. The devlink command to create an SF
>   $ devlink port add pci/0000:03:00.0 flavour pcisf \
>     pfnum 0 sfnum 1001
> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
> spent on __dev_alloc_name() [1].
>=20
> The reason is that devlink first requests for next available "eth%d".
> And __dev_alloc_name will scan all existing netdev to match on "ethN",
> set N to a 'inuse' bitmap, and find/return next available number,
> in our case eth0.
>=20
> And later on based on udev rule, we renamed it from eth0 to
> "en3f0pf0sf1001" and with altname below
>   14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       altname enp3s0f0npf0sf1001
>=20
> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
> through all existing netdev and try to build the 'inuse' bitmap of
> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
> every time.
>=20
> I want to see if it makes sense to save/cache the result, or is there
> any way to not go through the 'eth%d' pattern search. The RFC patch
> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
> scanning all existing netdevs.

An alternative heuristic that should be cheap and possibly reasonable
could be optimistically check for=C2=A0<name>0..<name><very small int>
availability, possibly restricting such attempt at scenarios where the
total number of hashed netdevice names is somewhat high.

WDYT?

Cheers,

Paolo


