Return-Path: <netdev+bounces-184606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD7A965C1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E77C174C00
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A120C03F;
	Tue, 22 Apr 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR/WdhVw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EE20B806
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317286; cv=none; b=j1HEo8/AEXq5+JBJuMvt2NzVaB3iSSxPYCswp5KOOGuuHrvJdrbqsMNXIBHZZSpMdIbcI44I2W5m7SBfVN5H1EMtQ1nDq6Bbv9PEfbUI3LvQXXjld/Fv5Q03YASvShzeM0IsAMGFaXZRIamjBTcuIvXFkuN/+nNvuf/yZRG0S98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317286; c=relaxed/simple;
	bh=TYTDUcslDoOfEDL8WgCEKVmORgs+59nZqp7WHQ3s8xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXNp2QetW9VkIKquX0Ed2fCcONGAqLIAX2K/ij9mIwCsjMJJGVWR63fmFgBkt3zPyCoVXB+7zo0GZbBgwWTGyk+4UmYVDNGROBuJ6602nbScQCs6ETrEryit2HhU8fEwrb6Bah9fyIbEinx308B0lWOdv1qFDwgDPXsbZgh+2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR/WdhVw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745317283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0ZYpeioJZ2jDB/cEJqcZLeqV9YgXQFIexoS6m6z+Q0=;
	b=LR/WdhVwp86LYAwOwolgPlaMyH1R8ort3YYxCeCKAq3PReegaZ7p2UyAHu+3fUxppglKHj
	O6YI/6ANCVbMxgk6GhlP0l5Hf29TO9/Hg2ECilkg3zYUcruuy9bhX/SFNg1Ah543tzPatE
	+23Q2daz8TBmG4Em9sej8fLyFJXtNYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-dYt9JvYnNTCABE-iYPUsLw-1; Tue, 22 Apr 2025 06:21:22 -0400
X-MC-Unique: dYt9JvYnNTCABE-iYPUsLw-1
X-Mimecast-MFC-AGG-ID: dYt9JvYnNTCABE-iYPUsLw_1745317281
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1428540f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 03:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317281; x=1745922081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ZYpeioJZ2jDB/cEJqcZLeqV9YgXQFIexoS6m6z+Q0=;
        b=JXEmQ9OO339dWtpJiMHPt9C+SAca4qbYkIrEodoKSXiFWgtV8RTZ8zHjZ14CE+KlPe
         lyi+pJzGkzlZa3bhdtl4uLZ6Aba4XHEGi7WSIADtfIQJQmtLctC+ly9GXS1uClGKGN3I
         IqDvMwy2QgZhBmH6BvTQmXhxtDoIl/hvNbxyXDbZkIPfzIjnPNNOejV4KQmQG2hDRwWz
         vmdHVlEqPeo2s/ySdcsTRjR6HmlR/CPigR7DkSxIZl9prDq2jQutQ40CSnxAu+NKsER8
         xdklOv2X9QLJBssKS0ydDNiXmbpP688ajdds0xf5U7io7lADevU1jpKspvvHrU/hKceY
         IEbw==
X-Forwarded-Encrypted: i=1; AJvYcCUoq/cbj8oJnJCXNzTRbmBfbDGJn6kabJw5nRuy2dYECXW/xfELx9zc5b6QhcVFwjvurRFN8c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCzuunJWgDvGoZ8S72PcVKzLP+v2i/l7ZpRQs4HGu8jK9OHKo
	hQjOm8fuj6zXL4Mc4g3uSU7vusf0fJ1ZQgN8v7a0NwQ2NxaloIMrbm804acD5TubVZeoNOTFGAR
	RnfgNs3jzc0O9feAloyhYUMhUJQgkrP4J0y/4K67xqIFWiPm4vCTZ9g==
X-Gm-Gg: ASbGnct2nB+jqDsqzYfNMtrV407GL8UceYJy98Q9Wex4+4ZqB0y5Kr7EvOanNkzBALZ
	wTKjvr2/QRUwwxX8elIRXuI43TJP1NeqZokchBqwM8t68pTRdDlgjkkdKmZWJkKTeu+A4k8xVwG
	ewRTK6agx42JdgeMY2AxbVI3W2crZ5R9s+UcIa8tOGVqEBwmyK3QId5FUIX4mv2mhgmYHU56srw
	xFrzBWBzbkrezRWifAkNJHaObk+p+EqUycxez5+OMU5lPPqU3yY7IuI9QhcfdKR/oXqU7obbvwe
	IT0GMoHso8nG8TIup4V1tWEYtJI7w7/j9snE
X-Received: by 2002:a05:6000:2485:b0:391:4559:8761 with SMTP id ffacd0b85a97d-39efbae004cmr11182250f8f.36.1745317281290;
        Tue, 22 Apr 2025 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtTZCnU9DNSZC2KRCnxqlkBPAHgyu/4YMJ+l9HN4PfmL5c/0x72KL+BpoC5GVKi5gVTnYkew==
X-Received: by 2002:a05:6000:2485:b0:391:4559:8761 with SMTP id ffacd0b85a97d-39efbae004cmr11182234f8f.36.1745317280932;
        Tue, 22 Apr 2025 03:21:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4206fasm14515005f8f.2.2025.04.22.03.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:21:20 -0700 (PDT)
Message-ID: <e2921eea-1430-4626-9419-eb04dc2ec23d@redhat.com>
Date: Tue, 22 Apr 2025 12:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 5/5] sched: Add enqueue/dequeue of dualpi2
 qdisc
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415124317.11561-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct sk_buff *skb;
> +	int credit_change;
> +	u64 now;
> +
> +	now = ktime_get_ns();
> +
> +	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
> +		if (!q->drop_early && must_drop(sch, q, skb)) {
> +			drop_and_retry(q, skb, sch,
> +				       SKB_DROP_REASON_QDISC_CONGESTED);
> +			continue;
> +		}
> +
> +		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
> +			qdisc_qstats_drop(q->l_queue);
> +			drop_and_retry(q, skb, sch,
> +				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
> +			continue;
> +		}
> +
> +		q->c_protection.credit += credit_change;
> +		qdisc_bstats_update(sch, skb);
> +		break;
> +	}
> +
> +	/* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
> +	 * or HTB crashes.
> +	 */
> +	if (q->deferred_drops.cnt && qdisc_qlen(sch)) {

Since commit cd23e77e6568abfac6354dd3f69d5b154e60e342 the qdisc_qlen()
check is not needed anymore.

/P


