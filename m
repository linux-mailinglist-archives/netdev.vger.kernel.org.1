Return-Path: <netdev+bounces-223446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58189B59317
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCE3A60EF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062B2F7462;
	Tue, 16 Sep 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhyWo/GN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB125BEE7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017649; cv=none; b=q2pEmbkrWWT0AO9aIqRlBK2qyudV3Pg+oPFtk5whWKucBN1p8Meu01LhqZON5OA9wXJHV5VpGemZfRqvam7cmWucL2D6YKRP6RJL/N+VmSa9mM1vyo+QCGGIzWMH6WLqVU1ir9JTL1Plsm4x7+fvwTBBai0qffHb39waGDUJBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017649; c=relaxed/simple;
	bh=t1CGsLmRseTDMjHCAQSYYlHyux4jf49a9WLjXvcVWMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX34Yt3FdJIaFp27FriHX0sWmWD/BMhz/fzeI7vbydQo9aR8PRZ895sRr/4oIN1BW+RWOyJvakZvUuDeLAanqCIEoeIOx9pymiL161Sso+lcRhzS+o414P4W2ul5zOrYTenQKBDjIGDa25gk9S65paxkTiXbu6Lg25GK3nQ9tUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhyWo/GN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758017646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAd3pWfH00u/dRfljKfYqFKQEcCgbbxEBoapt6p9E50=;
	b=MhyWo/GNJBB5Q3cl9Jwwg0ykVn3poEOsM8Lm5gzphQbZRZfFM/yg9JKpGUQUofFphxv+yH
	HwSTpHtJfsY1eeuqU4C1iN+Tytt71tIU3ZhbSGSGT6YIgIrQ8XFTMscZNN4CB/w2JTG0Q4
	xlL+zUD1LHAe4rzbZ2MFaju7lwj7hVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-uv8yF990N3ijRdFZpC5Nfw-1; Tue, 16 Sep 2025 06:14:04 -0400
X-MC-Unique: uv8yF990N3ijRdFZpC5Nfw-1
X-Mimecast-MFC-AGG-ID: uv8yF990N3ijRdFZpC5Nfw_1758017643
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f28552927so9117705e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017643; x=1758622443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAd3pWfH00u/dRfljKfYqFKQEcCgbbxEBoapt6p9E50=;
        b=l+qyqZrG06PYSXx/HWCnhiaZxdybnK/u376BgD+eAKbD/BdyIIUv90D907KT1KOXas
         DhkR9S8/LCaABSkTuaItogcc79IhEbQitHoM0cZ51mugvqaQqhthNfJkNgnN5KvoRcF3
         iGcsuiInXAxu7KkWHjjABxLc/grqKjDGgYHO+/rCFi4T/Lo0sEkShQHpeoWvBHNuSX+S
         5ObcNdRqvl+//tkUe7vek3wO6WgCpGuSxAPve28EohW2n3vOtmWJ576PpflWsDlD4gnO
         iXf4UMNO492d1wZvan9+AfKaaAMIeR8akCb+T95k8JpqVcrusOjMQFcSXRxAKpHDVmdH
         iEWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYyYM6ZWysq/xm1R7/Z6YP3aFmPScqA03eyL9t2vHgE/NdXNwfU3PR2/ZlBWy9VIXxeEbDrRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4owbOY8VVqHYFETfPzh8nddXU36sMQH/Xae9kixzzSWhhbnqG
	XikUCZuDxt1F+Bi3AX4ExsM5rjjNxeskOEnoU44dLlflVec1Y0RlbB5rTzsUzuUacQNTRS+24XJ
	NmdFwqPENGs5wzA9lN9Ohug5itYcMQscWFh4xiQ9R22FdqsRCixIgZKk5/bi4B2Kvgg==
X-Gm-Gg: ASbGnct7JXzIei/Ndiax4Nlg0qi3YZD1ZzA35CPA608Dhzs9AFlgHaqbUx501juIu7q
	24iSHQpWr2NTnu1p2Aa0x2NIWiycyLE1R5Tg8T38tvOk+vHU5BN+zelFsDP39nUTax/cfWET8FS
	TMqj5ev7Nh/rJZjt+GP63K9Lq8CyaYl2mQeOtPePXIvGMkR1UJUjsIVXhQr42MABwE+/zURuc47
	+7gfI3MbhgGt0H7lIwxF7aRizsY9BYHal6TzOS9/0EW9R/FxWz0NB5qE5gzCpt6Lnr+ssUdtJW9
	czynqKeo6Gc6/wPAW7FboA6rbFesrGRXbsL6zPAkJgo/BSwwTz9fV7UedLNvucv7SCQV4xxexuH
	nOI24pxy0WDu6
X-Received: by 2002:a05:600c:458a:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-45f2218d97dmr157750105e9.33.1758017643131;
        Tue, 16 Sep 2025 03:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+KQvwhoABvwO63mqI5Pbs9VkfnrqKtMRd3VEV/4QtMfsLXHddFPY73MCYM3IBLR8UCpZhLw==
X-Received: by 2002:a05:600c:458a:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-45f2218d97dmr157749765e9.33.1758017642732;
        Tue, 16 Sep 2025 03:14:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01baa70dsm223870985e9.15.2025.09.16.03.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:14:02 -0700 (PDT)
Message-ID: <b22af0eb-e50b-4d5c-a5bc-eb475388da10@redhat.com>
Date: Tue, 16 Sep 2025 12:14:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] tcp: Update bind bucket state on port
 release
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>,
 kernel-team@cloudflare.com, Lee Valentine <lvalentine@cloudflare.com>
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
 <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/25 12:09 PM, Jakub Sitnicki wrote:
> Today, once an inet_bind_bucket enters a state where fastreuse >= 0 or
> fastreuseport >= 0 after a socket is explicitly bound to a port, it remains
> in that state until all sockets are removed and the bucket is destroyed.
> 
> In this state, the bucket is skipped during ephemeral port selection in
> connect(). For applications using a reduced ephemeral port
> range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
> exhaustion since blocked buckets are excluded from reuse.
> 
> The reason the bucket state isn't updated on port release is unclear.
> Possibly a performance trade-off to avoid scanning bucket owners, or just
> an oversight.
> 
> Fix it by recalculating the bucket state when a socket releases a port. To
> limit overhead, each inet_bind2_bucket stores its own (fastreuse,
> fastreuseport) state. On port release, only the relevant port-addr bucket
> is scanned, and the overall state is derived from these.

I'm possibly likely lost, but I think that the bucket state could change
even after inet_bhash2_update_saddr(), but AFAICS it's not updated there.

What am I missing?

Thanks,

Paolo


