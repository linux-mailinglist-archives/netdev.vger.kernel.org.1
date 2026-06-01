Return-Path: <netdev+bounces-293808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BDoFKOnHWpbcwkAu9opvQ
	(envelope-from <netdev+bounces-293808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A4621E3C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660D630D19C9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF43DB32B;
	Mon,  1 Jun 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYEkAadI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21A3DC4DD
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327294; cv=pass; b=msbzpazqdcsNe5La7UpO43nEc9C/13TKGp5Bu5j9J+BiIKAZk9QIj9AytZ+8azdTEm3o+LNOzJAtPnqrhIjmgvEnIHSxiziPLU1eIV/9UMSDL/M5kfz0L9A2Z0ioyikcEqvqI5Nj/B4CnENGoHwyBbo9yl/bqSAmp1uYbBajbzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327294; c=relaxed/simple;
	bh=N8UbMuv5XKqhb/axtOv02XGC4/UNNXGUVCoZD7wZ3cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFucyEobUEr8ygal8sRSS3lo80dJ6+V90mITbR91TZfPQ0d1BCZ6J3eU/FxyVHplDzfqSOu+TMaTx1+o3kWPYT/wNYHeNCZcMH3OCTseGvVLOtYy4AA7Vj4SjXmhmIY4KlLQJ/5tqs9MJ8sbkr5mtFq9Iif/AL52/RXfe9k8JZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYEkAadI; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516de78c4dcso94912691cf.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780327292; cv=none;
        d=google.com; s=arc-20240605;
        b=R2gSKE7MaBsc6xvAAfWPDkjoG7FAjRPacbS1tyyiFe73x751UZNL34X2pxbD04Pn2o
         d3sEv7DptVqtPKuFzcnFiFWHBzNY1I8iW+SurEaTwBV3G+KVOJNEoRUlGvoagC+9A+z1
         abvbJTESMfiiIglkrVWj3vRKJcr5dXsfuFQi6qQWAGC44bqFXR6pVQN8SLsPfG+ezz9r
         ptL+dU0xy0oYckXvinHq6+Px3Z+4U5aA7XnGUY3g8HLcv8G5e9NLyL0lB8exjSxD5UWj
         V1tMv+/s0rHevALn0C+gYHfCHibKXmWI48YRL8leZgc/sBftu0IxdV33NZX6TDNI34ti
         iE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8UbMuv5XKqhb/axtOv02XGC4/UNNXGUVCoZD7wZ3cM=;
        fh=STckHJpoU179ezaKbaZBIOeOQ7o01SB3m6VHSkszw4A=;
        b=OXD/5cdcACtKKZyo0xB+VIRiFIXjsuuwjefA8goAi0Z1hBLxhvQDjh3Wvpii6/KCmD
         w/sw0yyD5UNHABZrPAaMHjQHaAW9ESx2UjHymE4U/KHOKFxQfnUt4VmMrK7Q8V7Ojo5g
         d4OFi0j9bqB62m5FDGwc9+ZeaKIzmHI5UYW8psAtHpYhrBKa0FfMRhC4OHeqSmzBSZhK
         yavYNP0OjPlik4vqkAbc5ByLJ00faLvNKASkD/skOE/BQ7+sNnbcX+Nr8wSjflT27h36
         w3oUWuXpJAj7af+J44z2NneRAQIOfw+MsjNN1RGrTt4uSmkW1/C9n8x1qRUiwTuh0/0x
         VRdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780327292; x=1780932092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8UbMuv5XKqhb/axtOv02XGC4/UNNXGUVCoZD7wZ3cM=;
        b=oYEkAadIk9bRD6YnUpvCZ1JhmbgMvEEhs1UiYFQHUol1R3f6yXRYOjoXco3pGLC9yd
         bTWNx/3PiIAxeJjziVoxc/4C8v8OxiHSV1sgMKdkb1BdL0vjsvWEIm/nLFUZ5MhL8exx
         SsfT795JCoFnQT8+GxmDUc3gb3agdqhxeHTDuw5qTlcrCYbH1lyWcnOEI3o557CL3APT
         d+e5ActV8tdcFSlYRgeNHZH4D8c0f/4l9q14y0LFU7L05iKUqztvBe+De5dKgGV/OeGY
         8TweiDyE0WT+IxPA+Uvh0QB3eTT6gVKWXVEwILRiwQgwgvuY9wuGPZMCt/oMF4RoXFfG
         NTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327292; x=1780932092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8UbMuv5XKqhb/axtOv02XGC4/UNNXGUVCoZD7wZ3cM=;
        b=VZ2uHDwxB0Xz09s9tgD88HS364efaRxUvuzB7RS6vwxaYcgVKOJqOPR0rM1qVqeyIj
         MQPqO8YVE7p2PUtoOg+TGONIMhy6euL+eZfApEka9VJYGyEcZxsShZ6AU1avllI7FPMH
         PVCcI3M5eFbwYVq5o7aJieSC4qcb+3sQ5ybTFs+JTr4RM/NYcKAlmZSBGe2t1qriliAa
         Tz2SzAamfGNYrRQKy/c3hlz9RuN/a7gdchA0fMMKUY9nXjcfjAB4Hi28pYTFCmWdgvd1
         LJ+xgGVBGsS64ZPfyj00hJ958YUOy37t73e75oaQLeDqFyl+OCd1UixuZ8zgCbGu1i/+
         EgXA==
X-Gm-Message-State: AOJu0YycGpom8EwpsfRddKVX2Vbe7cwYK64C6Mi04yaIKjtrLEqrwoxB
	EUkcPPQIPxuWpFUIsEV+82w4iUbtxzV7pjBxJ2kr2h0Lf2JCKaDe8DRQ/qmV4Spi++SWS5OHZnq
	BP4NJFmhs844QfvoSm4wMASCkLip9SNMPTX7Kv8+AAZwcRjKQJu73VQd8
X-Gm-Gg: Acq92OEWUlLYbf98Y7KM5dZe4rD1aD+VQyjQwWEF5oBoNlseAc4G/3zo6E5IJuzDzEX
	Y0cnVDUT66Ctev/qDD3k82t/PFQ6DRpcncgc5z2TVg8a6Vuy76PtNynlSKaesAyy7EiQE1AC5BW
	DX9FPI896LXmQgNVnHbYoA93u6lXR+sh8kGJENADtcl6mZziRYMuzrx8yk5sP5c+LNBGfnmmKSC
	tb1tFr491rJTvUecoLdMEwfkb3vSFMhtjn4IAVQeBYmDdypGGL4IMXQd3w2DVBF7bxga8wCND7O
	1rmnRrUlFtKbGIKS7yv+00KGrlchnt2XRS9OpH8nrK9z911gqUHKJyOES2KONMPkf0Dpi9hq6jV
	BXkN0X8d7Buv86zM0Ts9u18GkODsulvKCVc6LPd4=
X-Received: by 2002:a05:622a:8319:b0:50f:bd79:2643 with SMTP id
 d75a77b69052e-5173a778b13mr132407231cf.34.1780327291129; Mon, 01 Jun 2026
 08:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531160812.68020-1-jhs@mojatatu.com>
In-Reply-To: <20260531160812.68020-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 08:21:18 -0700
X-Gm-Features: AVHnY4JgK3h115mDowJ-DCNS2f0MvGCwYoGulBm_lnlX-w3ZWSwPdHB8y-N52GQ
Message-ID: <CANn89iLdY3rH49vCw3hNpcfunObY6G3JN+=-Nv-GK-8iYziXwA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred
 freeing for action lifecycle
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, kylebot@openai.com, 
	jiri@resnulli.us, vladbu@nvidia.com, linux-kernel@vger.kernel.org, 
	security@kernel.org, stable@kernel.org, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293808-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,mail.gmail.com:mid,mojatatu.com:email,openai.com:email]
X-Rspamd-Queue-Id: B32A4621E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 9:08=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> When NEWTFILTER and DELFILTER are run concurrently it is possible to crea=
te a
> race with an associated action.
...
>
> Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

