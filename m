Return-Path: <netdev+bounces-75281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8E868EE4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0691C209DE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BC138493;
	Tue, 27 Feb 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDI9vCvZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02555E63
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033819; cv=none; b=m31iyN1IszPM0It0BU/ivIJSiPRcOz/tgPwXYPpPI2bZJ8VlQSNwzQ8oB9HygpGi263ZFT3uLqrbQEpSTQHmgoAVlZrwAOHOC16m81eTvQBQ5UAALm8JGuBliKQH0EtxQUKuKagkwrlmZGnD+OZPLmUOzOV/dKMRoIlCTAJya1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033819; c=relaxed/simple;
	bh=TykmOZ98idwj/yiY2IviqszKG+mDx55ADNLPGbJ5eVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSPebRAy/cdZPrMVYqZFKBsANBhxIuLJRiDJQIWCpPlh5GAUZ2WdrZL7Enp4rNhxctdpSAzwwiCyhgHjqdozj4R9E6+cpzfvdAQ2wCc48zLfvB9Ft34Z7Zu3wTPtAQgHLJNaZfGtKKtdQcJPLg998XoIkcDPxTVoxoirgnsA3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDI9vCvZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709033816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g6AnsYMZAQl9fXXJqgQN0ICNtLr3q7f3fMxWo1iJHRM=;
	b=UDI9vCvZh7KJA0V8vrPfQA1BiIpxBJEUZYJU0LBBmkwlrG/IoHzBp9oZMTGygVeyLObmeZ
	1lqgdTIJWcqTzKnJXpJg55mOg1LRoJHL8BLfG70rGfFa5xcbBq9D+OU9uTRAIHruchLuNf
	vN9BMrj39tlZR2EDWgRJDpLYf6v7HU8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-a9kki--JNQmZOQrFwGAvgA-1; Tue, 27 Feb 2024 06:36:55 -0500
X-MC-Unique: a9kki--JNQmZOQrFwGAvgA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d25a6cc0d7so9473531fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033813; x=1709638613;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6AnsYMZAQl9fXXJqgQN0ICNtLr3q7f3fMxWo1iJHRM=;
        b=r3vGTudjED8iNC7kGU7qki04HWXOmgsJJtIc4BEzwGHxCy3suaBiMdfXKCpX2XJPRY
         BFVBFQaOh+Z5rFZn68q/BCz3OISimYnJA34PhrdBMZXUtMWN+68UK+l/8HnaoaLy4t8k
         jTCGKPQxeSdp0ioBqeCi/N30W7uxjboPEYHSsScElPIBfc9toJLq8kUQZ4aaF0eucTKt
         FrGOEEcsTAOpGPOw/xSnEGEmhy9cYc7EwyEFO4xU5fsATSp8n6CAbP77umS91j0VNuXA
         JQIQWeBEE8d+36H97fbWP3znDUa2Fob90nAldFSuqTga+aaQtqwhgxUIXyVxKCoOFtmh
         kwtw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Q4unROqsnqroFxMienASpAaeOoyZmlVp9pAZOM1kj4J1XWHLKvJLv3sawF7YAnU73o6Pr4VN3J6I2m/XII3mG2x2+eHm
X-Gm-Message-State: AOJu0YxijrfhrGanZL8a9nAfdKHM3fM0O7s5IINVK1biFvYagsw9EIhu
	d4a7u5JXZx8kWBs6JTMcT/qcKi1DXZR+SzPCUWPhgTXsHKbGNTzQV6Ct7F0Uq/enptiDs2Fwwwa
	32TV2aZWaGfv3bUXi5k3Jf/ku7uJ3JecajrwBgJpv8Eij6vM75jVZRjQfOmO9LQ==
X-Received: by 2002:a2e:3511:0:b0:2d2:4308:97bd with SMTP id z17-20020a2e3511000000b002d2430897bdmr6330945ljz.5.1709033813633;
        Tue, 27 Feb 2024 03:36:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG2qExjeB9wN1h7RI3elSVdhIiVWMrINwmm6RX6wh3m06LPxRUHtkBFy2W1R51q/9kELSnVA==
X-Received: by 2002:a2e:3511:0:b0:2d2:4308:97bd with SMTP id z17-20020a2e3511000000b002d2430897bdmr6330935ljz.5.1709033813258;
        Tue, 27 Feb 2024 03:36:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm14703056wmz.1.2024.02.27.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:36:52 -0800 (PST)
Message-ID: <2e6eb578782dffcc8481992ba39181c74e2a7f80.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 13/14] af_unix: Replace garbage collection
 algorithm.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 12:36:51 +0100
In-Reply-To: <20240223214003.17369-14-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	 <20240223214003.17369-14-kuniyu@amazon.com>
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

On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 060e81be3614..59a87a997a4d 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -314,6 +314,48 @@ static bool unix_vertex_dead(struct unix_vertex *ver=
tex)
>  	return true;
>  }
> =20
> +static struct sk_buff_head hitlist;

I *think* hitlist could be replaced with a local variable in
__unix_gc(), WDYT?

> +
> +static void unix_collect_skb(struct list_head *scc)
> +{
> +	struct unix_vertex *vertex;
> +
> +	list_for_each_entry_reverse(vertex, scc, scc_entry) {
> +		struct sk_buff_head *queue;
> +		struct unix_edge *edge;
> +		struct unix_sock *u;
> +
> +		edge =3D list_first_entry(&vertex->edges, typeof(*edge), vertex_entry)=
;
> +		u =3D edge->predecessor;
> +		queue =3D &u->sk.sk_receive_queue;
> +
> +		spin_lock(&queue->lock);
> +
> +		if (u->sk.sk_state =3D=3D TCP_LISTEN) {
> +			struct sk_buff *skb;
> +
> +			skb_queue_walk(queue, skb) {
> +				struct sk_buff_head *embryo_queue =3D &skb->sk->sk_receive_queue;
> +
> +				spin_lock(&embryo_queue->lock);

I'm wondering if and why lockdep would be happy about the above. I
think this deserve at least a comment.


> +				skb_queue_splice_init(embryo_queue, &hitlist);
> +				spin_unlock(&embryo_queue->lock);
> +			}
> +		} else {
> +			skb_queue_splice_init(queue, &hitlist);
> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +			if (u->oob_skb) {
> +				kfree_skb(u->oob_skb);

Similar question here. This happens under the u receive queue lock,
could we his some complex lock dependency? what about moving oob_skb to
hitlist instead?


Cheers,

Paolo


