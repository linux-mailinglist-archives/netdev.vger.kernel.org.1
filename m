Return-Path: <netdev+bounces-249833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A684BD1ECAE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDC2300D48C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1B395DBE;
	Wed, 14 Jan 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OPWt0T5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2B3557EA
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393989; cv=none; b=GC6uL1XJxx7Y5KFQhQwBoe6vdETvJ9OOjsPXR7ST1rq5KnLgX7xH73yTCEm8nvyotfQc4bws8SXurAhlPFu63Rq5X3a6TIMlXrGBa7a2DDe9BUNteu7pfCzjkN1UspihWk18ANO0Q7J+xIg4PMhk9m+YscRQxLRvNrgWSfY7kkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393989; c=relaxed/simple;
	bh=agxatYm5mUbN++KbSQ9n748/3c6GkMV4Ub9NYi5fR9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZlWDQF3x1HxabJ51rpVVSnLFcTVALzm1FiyNiH63WsBpGRJoj30WqaZrCk+9gnLTX2iV4BN+pjFvkMDut5jQ0zs9AMF8MuKQPMyiT6Ga20WrPNyHdD/F7MZ/+5o9uekRGUISrQwMl+XLZeZW3a1yiMoRUYpQ1/82cZNltlLvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OPWt0T5P; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7c76d855ddbso2858978a34.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768393986; x=1768998786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/79JQOY2vgvGddRC2TVOlm5nKGEv4fVyeyaPqhKG7U=;
        b=OPWt0T5PNVJSyu0HLdsVezlHTiUL7hIUxXyd980iPwDtaEl5yHRywAS5IyBh6TCXIo
         ni2ZjaBanCu9XFGHYSZtq7ZLb2De/VOqF3PUKVnVJ/6kN4BgxhcftEc/7WTFRpKG/8D4
         VczpN6kNNThmV3Dzix/KBWl/lxaINyoNUTRqwWUrd5tZ0c161IZomu0AI4FAH3jcD+ns
         yB7WGeGtk7RhM8XUIjfRiOUSFVWf7/xsRa2yyf4cFfzmJZ+bwPNkoeamjoTU0BU+TEqY
         NOLazlf4eY+5NBR1K/dN719m1+FFeBdAjIgqDhcenmN5ZuzkeYdTbEmXxNX6H0lBIIbA
         WxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393986; x=1768998786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/79JQOY2vgvGddRC2TVOlm5nKGEv4fVyeyaPqhKG7U=;
        b=gJfdGsFOikNosJ6Mn/DC4jLEO8rrTqM0IBVx7xu+Z6A8/DLkGtcI4u5E8c4DYuOgC0
         OUL23ngzv7+TDetlJYeVEOLiFczpg3k97tGZ5QDYJ7TWHw82GlQjghoPdjSyvZdb5xK/
         f4AQhhE9brmConpPqKZpmfAsGs5v7TjKc1DG8OVc7HRoQ6DCNnVxEcts+tAfbe0eNXle
         K+RTC11me56tbrvUEGMoeRF0zsAIe42r4gpT7AIRkvvCIuZ+zA3T96I+gjaArUqhjq4h
         Zlse87WspTlvCKK8L2OhB2Rl+5TWSNx1F/EkbmGBZMiSiKFwRgQgEf5QbycQ3eSDDk/R
         6bhA==
X-Forwarded-Encrypted: i=1; AJvYcCVAHNfxhU72kQcbHaYowEpbMi2byWunD+ZEaSMylaCbbIQ0jsxI16MnGZO0Q4woRnaiYr7gA8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZuak1GzdpDfvtLI0NM7VBi/56zNWGX3ZJcOQ5kGS8NDMdRTC
	Zcu7ZU2VMpGuEOPeOWJTk58cyyO7nzkzax2rcdKVlYpxQ5FX/V/mHKf5FBIx1WKm0IY=
X-Gm-Gg: AY/fxX6EN8AZ/TiX7oDBZweoumk/3duM+bVPralC63/ol4hGBSKINIUBRxebWS1DpwK
	AoGTC2QqgKdH6vEYamE6Wos5qGNZizjQXUFejZkRHqIyvkTJ5AFEtCzUqyLPc/aWXWGpxp3IWyq
	ZhC3LexW55zIAWjPj975gpe4UfA2CDVOAaIxsMD5arm8jRnjHBAsckXdF3L4fNef2a8mpy2Vxsw
	AWgnzZz5flPcpOYqe+heMckQ+is8+RS7sWCtALL8bV9GercrqcNmcThbuB8uvfWsoynGQyqUPp8
	qYq7n7Ja3j9b39eKuvc3rleDnbqq6vEF3C00k27iEob3ZrItrwwAVlCV1H+8zADesJOKZb3gwkJ
	JfxV0G4j2EPu8gj6C6taim8XIPJDUG6tbe3FMx3qZAyTT96BXlOCe1xq+B6hegdkWeGeF9Zv6/R
	UyBs8=
X-Received: by 2002:a05:6808:318d:b0:450:471:b9ba with SMTP id 5614622812f47-45c714302ddmr1785761b6e.14.1768393986332;
        Wed, 14 Jan 2026 04:33:06 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:bd])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478d9c17sm18199756a34.22.2026.01.14.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:33:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  netdev@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Simon Horman
 <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,  Pavan
 Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  Tony Nguyen <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Daniel Borkmann <daniel@iogearbox.net>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  intel-wired-lan@lists.osuosl.org,
  bpf@vger.kernel.org,  kernel-team@cloudflare.com,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Willem Ferguson <wferguson@cloudflare.com>,
  Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <878qe01kii.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Wed, 14 Jan 2026 12:49:57 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
	<bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
	<87wm1luusg.fsf@cloudflare.com> <878qe01kii.fsf@toke.dk>
Date: Wed, 14 Jan 2026 13:33:03 +0100
Message-ID: <87ecnsv0g0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:49 PM +01, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org> writes:
>
>> On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
>>> *BUT* this patchset isn't doing that. To me it looks like a cleanup
>>> patchset that simply makes it consistent when skb_metadata_set() called.
>>> Selling it as a pre-requirement for doing copy later seems fishy.
>>=20=20
>> Fair point on the framing. The interface cleanup is useful on its own -
>> I should have presented it that way rather than tying it to future work.
>>
>>> Instead of blindly copying XDP data_meta area into a single SKB
>>> extension.  What if we make it the responsibility of the TC-ingress BPF-
>>> hook to understand the data_meta format and via (kfunc) helpers
>>> transfer/create the SKB extension that it deems relevant.
>>> Would this be an acceptable approach that makes it easier to propagate
>>> metadata deeper in netstack?
>>
>> I think you and Jakub are actually proposing the same thing.
>>=20=20
>> If we can access a buffer tied to an skb extension from BPF, this could
>> act as skb-local storage and solves the problem (with some operational
>> overhead to set up TC on ingress).
>>=20=20
>> I'd also like to get Alexei's take on this. We had a discussion before
>> about not wanting to maintain two different storage areas for skb
>> metadata.
>>=20=20
>> That was one of two reasons why we abandoned Arthur's patches and why I
>> tried to make the existing headroom-backed metadata area work.
>>=20=20
>> But perhaps I misunderstood the earlier discussion. Alexei's point may
>> have been that we don't want another *headroom-backed* metadata area
>> accessible from XDP, because we already have that.
>>=20=20
>> Looks like we have two options on the table:
>>=20=20
>> Option A) Headroom-backed metadata
>>   - Use existing skb metadata area
>>   - Patch skb_push/pull call sites to preserve it
>>=20=20
>> Option B) Extension-backed metadata
>>   - Store metadata in skb extension from BPF
>>   - TC BPF copies/extracts what it needs from headroom-metadata
>>=20=20
>> Or is there an Option C I'm missing?
>
> Not sure if it's really an option C, but would it be possible to
> consolidate them using verifier tricks? I.e., the data_meta field in the
> __sk_buff struct is really a virtual pointer that the verifier rewrites
> to loading an actual pointer from struct bpf_skb_data_end in skb->cb. So
> in principle this could be loaded from an skb extension instead with the
> BPF programs being none the wiser.
>
> There's the additional wrinkle that the end of the data_meta pointer is
> compared to the 'data' start pointer to check for overflow, which
> wouldn't work anymore. Not sure if there's a way to make the verifier
> rewrite those checks in a compatible way, or if this is even a path we
> want to go down. But it would be a pretty neat way to make the whole
> thing transparent and backwards compatible, I think :)

I gave it a shot when working on [1]. Here's the challenge:

1) Keep the skb->data_meta + N <=3D skb->data checks working

This is what guarantees that your BPF program won't access memory
outside of the metadata area. So you can't rewrite the skb->data_meta
pseudo-pointer load. This means you must...

2) Patch the skb->data_meta pointer dereference after the check

Since deref happens at some unknown point after the skb->data_meta
pointer load, you may no longer have the context pointer in any of the
registers.

You might be able to hack it by spilling the context pointer to the
stack in the prologue, like I've seen bpf_qdisc does. But that I haven't
tried.

In general, I view it as a seconary issue since you can use a BPF dynptr
to access the skb metadata. It was exactly for that reason - to hide the
fact where the metadata is actually located.

> Other than that, I like the extention-backed metadata idea!

That's what I'm going to work on. I look at it as an skb local storage
backed by an skb extension.

If the user wants to transfer the contents of the skb metadata into
local storage, they can. But the extra allocation is their decision.

[1] https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-call=
s-v1-0-1047878ed1b0@cloudflare.com

