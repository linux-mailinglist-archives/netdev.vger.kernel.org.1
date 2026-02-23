Return-Path: <netdev+bounces-260005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QClRDtE6nGlCBgQAu9opvQ
	(envelope-from <netdev+bounces-260005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:32:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 254291758D9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D1F1301FE49
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C886361668;
	Mon, 23 Feb 2026 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjnuurU0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU5Lcjoe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1F34DB44
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846347; cv=none; b=D1Io30o76AJWNGI31jurl68jNmk1tQ9LDe9by3NL7FpUJ/OYSuA4vn4NRyh2cJ8NCQG18puztfp15Ig4kP4nn8DDLG0bij+SNiWtefziJeDM0ql7JLHZJ66o4QD3u+TW4XeeOeG2/el2qcDNL0XGiBt5rlALEdGdkTp9pRCBj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846347; c=relaxed/simple;
	bh=W5zrbs9uXFemU0SM1Ldkz6CuI7dETwlvOyXhvibTCyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rW5W+gmmi4IcJ8QqpUtudDt1mpoKIjXHqcJeoFKCTpVyGHeUKuHJL6qwYfpuF4wyOQQahL3UlpqI2KkWhnabbckmDAlRGy2XI1nf235zUi1ltcgq/YJCSN1TJcXhUCU52VLjGJeu4nduXTLAED4LVRd65oSyZ5BoILJq97xwSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjnuurU0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU5Lcjoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771846345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
	b=WjnuurU0/yo68Ia6wvII/N+aDMeQ8xg3SULGT2gBe/K1BPLZVbcc7Gofbhid92OMR1clCE
	WGFKOzHPxluFJkpJhLJNZciG5xXA4RnZ0tBUw/30YAehD8KQUvmqq8f5HzzYMm5VlId1YT
	hS499UQQpmuknTjwJgzmuI/o5YtEyTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-mAi76GWKMVWbAg3KAQk1HQ-1; Mon, 23 Feb 2026 06:32:23 -0500
X-MC-Unique: mAi76GWKMVWbAg3KAQk1HQ-1
X-Mimecast-MFC-AGG-ID: mAi76GWKMVWbAg3KAQk1HQ_1771846342
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837f288194so35790495e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771846342; x=1772451142; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
        b=gU5Lcjoe/QCNN2uOnlDRGfdevdN2c3Kd+iiGjpBvXwoFPgQpqvf3nK440b8w4Exqxl
         1Bm6DZZJlZ7Ys8lazxGhSqxVVJsM0hFFdG7L9XFgptRcnDEVb5WojBs01l5+1deqzbCS
         QhjEMAEIed2UG6H/omR8OHeTF7GDp0tRtVvBkeYi95hEgZvFOLtbatVxLnCsrkWBFukS
         D4/jVJ1OU9nHbft03YTQyG6qjPFjgq9U01HgK0H7F9EKVQQPWw2MetCpoXibwcqwhNEh
         kz49iaDw/1dN0cFd+PTGGaVanK/v8DUSFD+3w/NoaFbbVFzyDG+HURv36jsvawqTp+bN
         n4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846342; x=1772451142;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG2y1gHosJIJuzVfk3SqmU9QwIFbQp0Z8zPn21NlI3E=;
        b=u4ttSkKzRrkrj95wxWdgkEP7FOR3Kdgf9FUhxPjf0i51voaQpIVEqljzDXZRSrO61E
         w0Y8KpNVhcd9eSLinB0fNPa7786zrKYDCfdh2SKWNrkvmwmRdaq8RJR7wULcBvVvk660
         pEofdd/IbIKhhJI6Kh0sHdy3oCm5z9jLcUXDyXGq3d7d4ucSBwrJB4X/ZHoHZshNcYO/
         TZdTtroZAElZKG2K3QVfZmf9Wm7zorPHOcOgmxQXovrwsVHt8kuwuXfqOYPeCZwCoebo
         eDZckhxLoHpIUu3dbK6uMuFhVC8TwJ9vuwFjJXeQLt/jhwYGJJbrfl+5wO6NmMYPxTVe
         mRcg==
X-Forwarded-Encrypted: i=1; AJvYcCW1uC3L4QFW5p+bTS8UVpXbfkl+sAJnwXberISdNsGO9XdIwQnXy0gaqLVsTC5tnMSPS005Ai4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcJ08zcUyV8dYtLVsYgBaAEQoFKBM9h3SS4MAkXhA8KofvHin
	M9Zg4bnCC+NFLVs802UEUOb+VJnL4gB6jYkjf+9i/xvqcko3mvgauGy7CpN30RWthPXZgsU/KnG
	gKiXKoRsy15gCqXXZfuaH6q69LxBFtfxhx0bDJmXNam9zpFCwtn0LeQF0qg==
X-Gm-Gg: AZuq6aKSKzajcf2Fy4uwtIn0Sr0cxY15L7YhScoNo7eEjB49tjziXwVN4m1UvYc+nCX
	n4g2fVO8gtjMczxbusB5PZ427Avr60w2mA7rN4Ypm8j2kIX14mwY6wAhwEMTDnFwDB/rJL99PbF
	fUDtqN24LsQ3ekKSQDXpO85Ii/L9hX3Sn4NXzb++6izltyrD9I4qrKXW9fvJdiceRA+5T4a4JYB
	95TZSO4SaDuQuwr1Bjw8dnpkydTFAQ7akeJiNB5nLKEpmVyfrVt5sXAp9ghYCgb2nmz+kR9gE5/
	EcM7CyztUnfZOJY6ukkM4zjpp9+3EuVsUj5rSU7tsK7e5wENOPtXugSQOtukc9kAMqfmu56kkEN
	4MjtpbIWH1inN5vENDjIwnfBdcqYb2mSMxoKWyxq9OW+AMg==
X-Received: by 2002:a05:600c:3516:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-483a96377c9mr136371045e9.24.1771846342309;
        Mon, 23 Feb 2026 03:32:22 -0800 (PST)
X-Received: by 2002:a05:600c:3516:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-483a96377c9mr136370475e9.24.1771846341844;
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm272520885e9.7.2026.02.23.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA84B5166F6; Mon, 23 Feb 2026 12:32:23 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>,
 syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
In-Reply-To: <20260220193039.7129-1-kohei@enjuk.jp>
References: <20260220193039.7129-1-kohei@enjuk.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 23 Feb 2026 12:32:23 +0100
Message-ID: <87ikbnofug.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,enjuk.jp,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,10cc7f13760b31bd2e61];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 254291758D9
X-Rspamd-Action: no action

Kohei Enju <kohei@enjuk.jp> writes:

> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>   v2:
>     - fix formatting, accounting that max-line-length is 100
>   v1: https://lore.kernel.org/bpf/20260216201428.65641-1-kohei@enjuk.jp/
> ---
>  kernel/bpf/devmap.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..c8c49d86a403 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
>  }
>  
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> + * least 'max' elements.
>   * Returns the number of ifindexes added.
>   */
> -static int get_upper_ifindexes(struct net_device *dev, int *indexes)
> +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
>  {
>  	struct net_device *upper;
>  	struct list_head *iter;
>  	int n = 0;
>  
>  	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> +		if (n >= max)
> +			break;

Hmm, how about returning an error here, and aborting the redirect
entirely? This silent truncation to an arbitrary number seems a bit
surprising, and very hard to debug. With an error, there will at least
be an error tracepoint to catch the failure.

-Toke


