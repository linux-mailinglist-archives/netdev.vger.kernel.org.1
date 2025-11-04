Return-Path: <netdev+bounces-235455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C41C30DC0
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B54E839F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8905A2DA765;
	Tue,  4 Nov 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKUpoTnA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0elEMjD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D22DE200
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257729; cv=none; b=u63aSxEKxXRD4xabmTcd9OrWqOes3wCOTbUoLZapZpKBiZNTeHKAJ0Md9Ova0ZFK6+UfQiGA0lnZAbRRISwjp0gb9aETG4TXgGR7oFIqC14pAC1fziTQJrY8s0JKxqS+acb74p16mH2MMxvyYmNgUld//rgFkh3At6+q0IR7aNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257729; c=relaxed/simple;
	bh=siDD7cjBMuaNTHwQly3VC8x+1gNlvhrCrFOU/ZhsCNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8ZB/zxXccLVu9tQXPIenShd2DzIvKemZ98DCZor8sBwQf/meVVN9wsuIuZfr5yTLf7s7i43M96JThVq9osQiIQ/JIYBxO9zpq1dY6e4u/6qgxFNiL9L6KXGFY+dziCdJ8SRuscsRAfl8p2DHp6DLecyY4FtRDsSEQkjN+XRTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKUpoTnA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0elEMjD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762257726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssdJLqXoynRieLG0swAQ2kxDsi5M4pN7LUYQOx6mmIg=;
	b=iKUpoTnAVHxp2KwDPqLSvydsEtzkLge1jncSXoFil7H4ro7iwZtSyY1btoFOpGVEdcrAop
	fk9YmysQyyetKALG9m/w063i6c7zSYrFH7XEjoRVX+I/6oTA7eIQElXmtV82GfDBiXxyER
	AINUB2ASqL+NLBZeTdbw+RuxxJZTiIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Ytd9aW7MMhW-GamcG7qzIw-1; Tue, 04 Nov 2025 07:02:05 -0500
X-MC-Unique: Ytd9aW7MMhW-GamcG7qzIw-1
X-Mimecast-MFC-AGG-ID: Ytd9aW7MMhW-GamcG7qzIw_1762257724
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4771e696e76so55013025e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762257724; x=1762862524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssdJLqXoynRieLG0swAQ2kxDsi5M4pN7LUYQOx6mmIg=;
        b=Y0elEMjDenT2G3KxN4nffSB9MsLujKvstr6X8WQWEQMvpc3waWEPtan7RU7T0zt0+l
         kSpdKoT8mR08+JF7Yr9wQXHMyZJS6ec1ZPbdE1hOPhRvMJEeBYjqw3RvJOTGZlkFBZ3U
         gUVoiWlNbCQ/apNjTTDoWuj4nKEHToM2e3Mz1LXzLq8m4jVpXXP1/tK3jfc/Bx56lzJ3
         EfSl9H9jDhL845QIPXZYR7YpnXuKvf8fvMpqeYloh+R7hQTnlKqdRWpvQhRME01GNpsq
         r7P9gl5cuxbHtS8z5qVQO7T6+vUJZFMEmdkb+suci1HGatTHm8yx0SMsqtSqEaZGgDjg
         SpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257724; x=1762862524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssdJLqXoynRieLG0swAQ2kxDsi5M4pN7LUYQOx6mmIg=;
        b=JYNV6vdOgjjBJmWCv1gVpQtSbHOdelO2JhxA07p7sPEG1VjxQf4SzL8BLIdsJjTTN7
         KNkh8qN5J7O1/Xcrm2H3yzst5Z+lsgJ3rSPTD+WZuRmQn/qeQtGtbY+ESatWf90bsCn5
         k++Udxb00H1su+N8q+xK+S12MOSDHCw3gCoWLJiu+ICJLbQ8Zjr1Bb8+71FmTFnjVHUK
         RqE6LajM1XcpDJ/YA+vAtLPDEiWqCW3T26FqjbdGjChAHzE6RzXTbX8xQLxHiKq8YTLK
         674LwUDBYonYEciGFeYKwMYv8+opVReeebJ9XBShcys5BnIVPUgRP5rMLNTnFpARpaT0
         CYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rApUhqBG0CcDZ9UOYZRKyIzr/K9vm5hWL/bNSziyzLZHZ1a40tsc6VbXCFCJa3stUAiqukE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOf2W4jqZQAFmoWvpWXYxxnNkBOXB3QtF0XeR/C8Es7lGKfJUL
	nJdT25TGvKfiCKDccHBJP8PBs9R970C916ZregJSkhNBIjZyas8SmgsQE+DTHbXGskb2OXJlcEC
	RdUf1Ytn4vQHSK67yuX0BkmfSxjae6x6YueYepMrAJiXIAqAgTAGsfKioHg==
X-Gm-Gg: ASbGncuoC+KBbK+/UncDmbOX3Ki7482FcNMJpiU057YIP9IgC2t3L27guvYfrX+OTyg
	ydEWxppw4dMGlFxD1fOQ9V48Y70rira5RsD9SxZ+oKDewJ/xJAxmuurGeLLbHs4WKGGeZxwUwzf
	hCt3QVGnSNCV1m6WWdY6p/0ziQVOuQ3phuqgE+ePIaSnFkbb5hSdL+wzjFw/IF4m2gWD/gJhojb
	7SSmOgaF9gsNGk6f9pc61NrkWxW5NoY8d/C8otqFyVaaNByYiObBejhLFd7em0GeSxsCyuQIfR8
	8nNXomS70LSuEMN7Erg1G3JOzUQSHNtCZB9Qhbw463QMsNcFkEQJG2LO9oXdGyp5LruU3NzSbgf
	zNfwJLOka8sLEVG1c+jwvTPkjBfFG3e8U/emD916aCSVG
X-Received: by 2002:a05:600c:828c:b0:476:651d:27e6 with SMTP id 5b1f17b1804b1-477308a8967mr141058065e9.36.1762257724144;
        Tue, 04 Nov 2025 04:02:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEauK+mynBX5rWHPCWx1RsWJ73mWra6y4dymOB8ucAA4aBwaSotD7FEFCtCpoVpD7tQTjZ43A==
X-Received: by 2002:a05:600c:828c:b0:476:651d:27e6 with SMTP id 5b1f17b1804b1-477308a8967mr141057435e9.36.1762257723669;
        Tue, 04 Nov 2025 04:02:03 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477564d83e2sm31565865e9.3.2025.11.04.04.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:02:03 -0800 (PST)
Message-ID: <43ea4062-75a8-4152-bf19-2eca561036bd@redhat.com>
Date: Tue, 4 Nov 2025 13:02:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/15] quic: add congestion control
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <32c7730d3b0f6e5323d289d5bdfd01fc22d551b5.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <32c7730d3b0f6e5323d289d5bdfd01fc22d551b5.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> +/* Compute and update the pacing rate based on congestion window and smoothed RTT. */
> +static void quic_cong_pace_update(struct quic_cong *cong, u32 bytes, u32 max_rate)
> +{
> +	u64 rate;
> +
> +	/* rate = N * congestion_window / smoothed_rtt */
> +	rate = (u64)cong->window * USEC_PER_SEC * 2;
> +	if (likely(cong->smoothed_rtt))
> +		rate = div64_ul(rate, cong->smoothed_rtt);
> +
> +	WRITE_ONCE(cong->pacing_rate, min_t(u64, rate, max_rate));
> +	pr_debug("%s: update pacing rate: %u, max rate: %u, srtt: %u\n",
> +		 __func__, cong->pacing_rate, max_rate, cong->smoothed_rtt);

I think you should skip entirely the pacing_rate update when
`smoothed_rtt == 0`

[...]> +/* rfc9002#section-5: Estimating the Round-Trip Time */
> +void quic_cong_rtt_update(struct quic_cong *cong, u32 time, u32 ack_delay)
> +{
> +	u32 adjusted_rtt, rttvar_sample;
> +
> +	/* Ignore RTT sample if ACK delay is suspiciously large. */
> +	if (ack_delay > cong->max_ack_delay * 2)
> +		return;
> +
> +	/* rfc9002#section-5.1: latest_rtt = ack_time - send_time_of_largest_acked */
> +	cong->latest_rtt = cong->time - time;
> +
> +	/* rfc9002#section-5.2: Estimating min_rtt */
> +	if (!cong->min_rtt_valid) {
> +		cong->min_rtt = cong->latest_rtt;
> +		cong->min_rtt_valid = 1;
> +	}
> +	if (cong->min_rtt > cong->latest_rtt)
> +		cong->min_rtt = cong->latest_rtt;
> +
> +	if (!cong->is_rtt_set) {
> +		/* rfc9002#section-5.3:
> +		 *   smoothed_rtt = latest_rtt
> +		 *   rttvar = latest_rtt / 2
> +		 */
> +		cong->smoothed_rtt = cong->latest_rtt;
> +		cong->rttvar = cong->smoothed_rtt / 2;
> +		quic_cong_pto_update(cong);
> +		cong->is_rtt_set = 1;
> +		return;
> +	}
> +
> +	/* rfc9002#section-5.3:
> +	 *   adjusted_rtt = latest_rtt
> +	 *   if (latest_rtt >= min_rtt + ack_delay):
> +	 *     adjusted_rtt = latest_rtt - ack_delay
> +	 *   smoothed_rtt = 7/8 * smoothed_rtt + 1/8 * adjusted_rtt
> +	 *   rttvar_sample = abs(smoothed_rtt - adjusted_rtt)
> +	 *   rttvar = 3/4 * rttvar + 1/4 * rttvar_sample
> +	 */
> +	adjusted_rtt = cong->latest_rtt;
> +	if (cong->latest_rtt >= cong->min_rtt + ack_delay)
> +		adjusted_rtt = cong->latest_rtt - ack_delay;
> +
> +	cong->smoothed_rtt = (cong->smoothed_rtt * 7 + adjusted_rtt) / 8;

Out of sheer curiosity, is the compiler smart enough to use a 'srl 3'
for the above?

/P


