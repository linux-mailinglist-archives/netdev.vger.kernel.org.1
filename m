Return-Path: <netdev+bounces-187485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708CBAA768E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A516460B0C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82125B1CE;
	Fri,  2 May 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F19b31gk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4725B1ED
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201578; cv=none; b=tLg/o0W8Z9RsuSbFh4FvOo+yKOb4hlDFVl3zN/ACLFSXlsRqc0ys03cFNZ1ByAE2I9gj6NofAvG+7eickUhaTdnvC6m04KFpgdla5q+m/FFaBG3Q4pQuWSDktv0eQmS9ED1GdKiRaumWVBASAo03tAf73pq/XQJqahIMrkLeKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201578; c=relaxed/simple;
	bh=byOrUSsEOpSIyajuw0Q2H0DNNQZ13wezcUb1dsGRvt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MLp25v/Tfd3xhq6vm9t7D0kNB4OVrWiu0BgryRljElAU3ScMF1cd+WnG1w5M3dsnXs6ch1ypiAI58fssNlLBkWaeB9lSV0GH26d/RKJ8AVzoYRIVXEww97UZaYwv5/rd2E6oeBJzS0vPoIW0ZBy3lHEW/Y9cSt/W0De1Dqij69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F19b31gk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746201575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCdtyBucBLgyJrIWE2a1E5opSPjkTpqCOuhdn8D/y7k=;
	b=F19b31gk2ZL+Ki8dyGv4gZlCvuSkNIC6vSLE/Z+NkgcxjIuxxJT69HuPEtfz0cEBM3nkHA
	duyTy30iXNYiIaZHcnqdub1xx9O10/SWxuAMWNJLSTqwdZAkr3n818LR+h4j9J8eZaKFZR
	FR4AbXssl+FtmHkp3WOBFKkOwlsasE4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-OhhTSyC_MrCtn129hA3vNQ-1; Fri, 02 May 2025 11:59:34 -0400
X-MC-Unique: OhhTSyC_MrCtn129hA3vNQ-1
X-Mimecast-MFC-AGG-ID: OhhTSyC_MrCtn129hA3vNQ_1746201573
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5498963ebc3so1366398e87.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 08:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201572; x=1746806372;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCdtyBucBLgyJrIWE2a1E5opSPjkTpqCOuhdn8D/y7k=;
        b=mOJvuREZ0cGVYw+B+zv6YVRdZHOQ7H7FpXGvBrQOUtm2GpCGKP+kjRF8INku3/dqUJ
         wn91RSVPHcJotHkTD/c+XzyGMVvaTP4SlKBXsNxNYsu7J2i/XWM4JoCAa8PSFjrvBopx
         l/Imi9hmBZlIP8kjk17R5TsNtBNxjD57X9feKhj5RZT2W3Qcz1jnwZT4WdYH08PIMIQ6
         nznKXY+lRUcJy+K6WrKvpq6nMmZ6RO/jywz6erlVQElIDkwo2mQ+y7enQVkT1ANz56LY
         QXKNGuUQWZlWIxhKjff78U7DMFowf4JRkUU8eshViAgr8SOwgmPS87lwUwE4raLefJZ8
         HPiA==
X-Gm-Message-State: AOJu0YzmBvV0s8CP3DJepvf2MwoCzTykzb8UD597jO5nQtkAsyDaB+O7
	zqTUjU+yfdp5ZfrRiqNd/yUrtuNOcQnWySMDvwqcrkFLCLKzJD5hiJEFoFUgcIkzPmqZkHIu5qZ
	p9q8rATokST08jOnk5EtHoXuLZGKQs9cpECxadRdKV0Mc/Bfal/vNOg==
X-Gm-Gg: ASbGncsdNEsxgVuGghXh/1PBxcIb1GdRcjRZIs4rnTuAsuwBUUXpbSTTjWVFRbzgEBR
	HUArEC1pXobmcuYrDj4oisQPIA4MAggnQHyVJD08iQPNUJE5ey9TP9cjuN4hSchI9gn4bPcIXex
	Gi4UwARqXltJip8sxYNfu+ix02mIy5wawKxV4WzTk9mFsQvKxmo5pEGcbg1YfgygqNW5xeS/NBz
	snkvbITBOtTLSVDxv65xcNKAYwyOlUbYa/UkuW3tdYr5KR8+RYRXKgaayvPRm1hTnf4Iqe3zMsH
	seB2AV/m
X-Received: by 2002:a05:6512:2c89:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54eac2347b5mr1180035e87.45.1746201572623;
        Fri, 02 May 2025 08:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbbWQ37DcyLp6u4Y7JWsAcBdhHWVsBBDog3Y4p3ar8KI2Q/GPFrZQ6gXIgWIBs257ALgTY0Q==
X-Received: by 2002:a05:6512:2c89:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54eac2347b5mr1180023e87.45.1746201572225;
        Fri, 02 May 2025 08:59:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f2160sm377797e87.190.2025.05.02.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:59:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9AB7E1A0852F; Fri, 02 May 2025 17:59:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250502150705.1sewZ77B@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de> <87ikmj5bh5.fsf@toke.dk>
 <20250502150705.1sewZ77B@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 May 2025 17:59:00 +0200
Message-ID: <87frhn57i3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-02 16:33:10 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> > @@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> >  	local_lock_nested_bh(&system_page_pool.bh_lock);
>> >  	pp =3D this_cpu_read(system_page_pool.pool);
>> >  	data =3D page_pool_dev_alloc_va(pp, &truesize);
>> > -	if (unlikely(!data)) {
>> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -		return NULL;
>> > -	}
>> > +	if (unlikely(!data))
>> > +		goto out;
>> >=20=20
>> >  	skb =3D napi_build_skb(data, truesize);
>> >  	if (unlikely(!skb)) {
>> >  		page_pool_free_va(pp, data, true);
>> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -		return NULL;
>> > +		goto out;
>> >  	}
>> >=20=20
>> >  	skb_mark_for_recycle(skb);
>> > @@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> >=20=20
>> >  	if (unlikely(xdp_buff_has_frags(xdp)) &&
>> >  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
>> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  		napi_consume_skb(skb, true);
>> > -		return NULL;
>> > +		skb =3D NULL;
>> >  	}
>> > +
>> > +out:
>> >  	local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -
>> > -	xsk_buff_free(xdp);
>> > -
>> > -	skb->protocol =3D eth_type_trans(skb, rxq->dev);
>> > +	if (skb) {
>> > +		xsk_buff_free(xdp);
>> > +		skb->protocol =3D eth_type_trans(skb, rxq->dev);
>> > +	}
>>=20
>> I had in mind moving the out: label (and the unlock) below the
>> skb->protocol assignment, which would save the if(skb) check; any reason
>> we can't call xsk_buff_free() while holding the lock?
>
> We could do that, I wasn't entirely sure about xsk_buff_free(). It is
> just larger scope but nothing else so far.
>
> I've been staring at xsk_buff_free() and the counterparts such as
> xsk_buff_alloc_batch() and I didn't really figure out what is protecting
> the list. Do we rely on the fact that this is used once per-NAPI
> instance within RX-NAPI and never somewhere else?

Yeah, I believe so. The commit adding the API[0] mentions this being
"single core (single producer/consumer)".

-Toke

[0] 2b43470add8c ("xsk: Introduce AF_XDP buffer allocation API")


