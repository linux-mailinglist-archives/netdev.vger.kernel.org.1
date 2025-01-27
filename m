Return-Path: <netdev+bounces-161089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997D5A1D443
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ED41658DC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1071FC7D3;
	Mon, 27 Jan 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4LFtC/T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D50179BF
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973165; cv=none; b=tfLbhOftzp25ZndAEUiE9TXAAyKNRsVNN0qjkIw0w4hiQID4VBFa41yQJqXcnyFhzbg0vlDfziN090K9lt9ITnMZOXYWPvqmI5YMIqZTdHFWmXuKrj14KtmlIlGloeqWB3SioiV54Eutt9E/oR7b1pZwQ7Zy2P7DXZQdeDtfZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973165; c=relaxed/simple;
	bh=f4kuP3kPi2iwoUVmTxtYwBxsgiQ6s9IGCOTzHU6FzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3ikYKm9xHcGZswzpy9rprtMNY4r5P3UU9lP5ZvPSEG7HesmJnxsgKyBkkNy5IO70bF04oEnV/ilRizw+eHa9GVz6mWv9qZsZYHcSmpr50KLjf+50NKV55DwLagDLKgahUBceWoBoJhcKC+XIHD2zbrT0bIC33ymoYLKYkCDxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4LFtC/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737973163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wxwoiVNHZR6knFBhHXMO243q012+HP9yK2j6Zj8JpQ=;
	b=E4LFtC/TAqCGpYYJh6GkXjx/RmWesw77ZfFhJi3tBqsdntNxlIngzg8zo91MKIrGaUJx0a
	t3/KIloF9QM6HENp9qJRvTqA9vvf+We78xBt2sZ5MBik97XFHEhzriyU6r7LE8ybw4Gg/V
	o3XuPM6SAWvL+5gRJt+/1gfFLm4BWEM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-PLyxxvAJONyUIC0vkTSxuw-1; Mon, 27 Jan 2025 05:19:21 -0500
X-MC-Unique: PLyxxvAJONyUIC0vkTSxuw-1
X-Mimecast-MFC-AGG-ID: PLyxxvAJONyUIC0vkTSxuw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43582d49dacso28934165e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973160; x=1738577960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wxwoiVNHZR6knFBhHXMO243q012+HP9yK2j6Zj8JpQ=;
        b=EEzL0bghqHM/Lg07QJV9xI/7J5WfZoRyvHxlADjNnJHOIN9agMBpHik99piI/VvWQb
         5VGA8DZOKhEMgaHP6sP9sLda5vULn7N8Qs//2akczbIUnz06ET/QLX0NamLY4PQBNEZd
         vSt2KvkKZYrOw8dUrcwWSpW+ZWylo/UwT13OP/Weu0NG5AoZ9I6kAUJcFd2UNMuXomPk
         M/EvRUMbxdRekaw7ulaXAfTRF3sSf1TN2zBScy5BUT83JB5CmxRohX4d1AB9Elye3ToN
         i59TbwIKrRekc0409omtwuvM4uTNZaS/SGy9aiJx1wlT6ouH83iNM+CWyeukaLtGvDRy
         44Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXlaFAuhgmNqH667CkXDQt4AUSAtqfvOy8zxbpo7+WpYUrBirmh6+mndIuz76k3rXP1GeD3tpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QdnCDSfx2DP6eBc+9ftAMooNWpD/kdo/H47814Db2N/8UeDw
	o9a3SxT2hRIqGghnrh5QZC4OlvK4MKBbAFNtI/kbrTFsvZAS8zDPtZDWLZZR5qURHZfAbm5LnTL
	V0nY+21bnfrVFhfPPgsD+728QMW6SUSH5HI7AI9srrbhXpURadVEF5A==
X-Gm-Gg: ASbGncunPl7PDJ6VqHGtJodfMEVKpszY8iJEWb8avpXrCK8kOlxtxtjz3mPGrOjyEDb
	flAQ8Nn61G6tnYkZzTwgULlwhnA98T+147r3+CJxzR9UeCUz1ST7nPxCRL9bA6X+VcklkwBLa5L
	8Cn56yy7MrAHidkjUHwD8QTPHj4uM6/3V+HkXhvjhfiFF5TX+byUo3ttyEg+XaOQxW0IbJYy/40
	K7gkvujDHbe+nKNK768mRlOYhD34K+ZOXFC/KJHRiQkowLGJfU6SkaP0n5hHbo6w0lcBtaKFDfW
	LdVvnaZ1sELxeSQmYEeY6y9XBD8bBySFLtU=
X-Received: by 2002:a05:600c:1c88:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-438914315bbmr288202945e9.26.1737973160005;
        Mon, 27 Jan 2025 02:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+uNkhNY4Sr+kofXLHqUrkbXuBRXy66lOwxZ71b57hnvGpX8rACbgBe64idAhp9RoINbnq0A==
X-Received: by 2002:a05:600c:1c88:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-438914315bbmr288202765e9.26.1737973159677;
        Mon, 27 Jan 2025 02:19:19 -0800 (PST)
Received: from [192.168.88.253] (146-241-95-172.dyn.eolo.it. [146.241.95.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd575468sm124869515e9.39.2025.01.27.02.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 02:19:19 -0800 (PST)
Message-ID: <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
Date: Mon, 27 Jan 2025 11:19:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-9-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> +	/* Each iteration through the following loop processes one packet. */
> +	for (; skb; skb = next) {
> +		h = (struct homa_data_hdr *)skb->data;
> +		next = skb->next;
> +
> +		/* Relinquish the RPC lock temporarily if it's needed
> +		 * elsewhere.
> +		 */
> +		if (rpc) {
> +			int flags = atomic_read(&rpc->flags);
> +
> +			if (flags & APP_NEEDS_LOCK) {
> +				homa_rpc_unlock(rpc);
> +				homa_spin(200);

Why spinning on the current CPU here? This is completely unexpected, and
usually tolerated only to deal with H/W imposed delay while programming
some device registers.

/P


