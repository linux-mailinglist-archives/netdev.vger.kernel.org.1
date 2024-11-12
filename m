Return-Path: <netdev+bounces-144083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22799C5844
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CB41F22AE2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51349143736;
	Tue, 12 Nov 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5zdWNpi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D513C908
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415746; cv=none; b=lbz/kviTfoAA6JFOpIZ47KvImXYEzhgKC+5UIMFRn+Oi8PojiM3MGGvnJdLrQiM+qXhls00fnxlzY/6ZIqTt8Vj/2JBxnh5kowIo21D25HfHkprGWc2gFYJ8r49C+tnAMD65DHnoQGUYzwmv18TyvY7/1w7QUjC5yUOAS1Twt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415746; c=relaxed/simple;
	bh=tO2DFX5hpPjovQKxGltnLka0mrtQgk4SmhGgjXzyU7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fIBuq9EQFSnzVbEjfLPKxpOp4aaSZlEeUVyjSTMSRQ12wmVV6oqdjATWXrX7SoNO5DGnQVj3juIWbevEenM2aIXWMOj1U4dfbLqvHigyB6E/6JPWLVjNcRhXIQTzWeTKW79+L/9f9cQZDJV4tyIdADfFmMJK7F5fU8nSBN8rheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5zdWNpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l72p6+5vAW8EV7pNrL52Yl3/6leWAr3UfpwvnjLecyk=;
	b=Z5zdWNpiRNFILCUuElvbS3NZmuONd22X7NJ4c9VIBh4qUAOJpkIdJRlLqIJWQMpJBerlJP
	9T7D4jXN7Kh3nppr3+9IZwMXdjKi0oGP6ZMBPDoVlDqKmuEZWXMGdqqNDJ1nL33HtEcuiz
	GO7GKOZbeJcl7z7ULEsPffrmT7Mqa78=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-IZOxY5pRM-2mZeG4S0GkOw-1; Tue, 12 Nov 2024 07:49:02 -0500
X-MC-Unique: IZOxY5pRM-2mZeG4S0GkOw-1
X-Mimecast-MFC-AGG-ID: IZOxY5pRM-2mZeG4S0GkOw
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e600565aa1so4278303b6e.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415741; x=1732020541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l72p6+5vAW8EV7pNrL52Yl3/6leWAr3UfpwvnjLecyk=;
        b=mMJihvZtph4HWLfSOhnPp7i/0xOn03v6PET53qIhV1znIyBHAos38fRNE+29aTgX0S
         MGgn1rWYkJmG85KjJvzTzZuT7do7+/NQkyjjyyKffeCWN+X6ip/7XFEXQGYh7RHSyTgy
         2Pql1sMfQjhQXLkvNPLARhxb5/M2Td5QUXkS4Y4vtQVqM71bMp+AApsN9ZLC1rkRQEvz
         Vh+DuDK4pdwXTbvAbO+/In06QBDhLmVNdbtNOGAhJ2LRtBNZs9u7z94okzdOSdOQ9aNv
         y94Z2QcVTn13eCaCRUysMuOWg5cZE5AV0EUch065T5tJvj1zmbabtFmxrFqme0styIuD
         0BRw==
X-Forwarded-Encrypted: i=1; AJvYcCXlx1mZ2bCtPRqynFigXXnrnyRiYG9gMlhuzXAM5TRWEOFQ9QmYuqBBZUCe5ns9wd5J4/9lozs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXwDkx2HKnNDcqVreP5DkarJoOl9xfVmB6VqruafQ5MbOt0vc
	qhKZIVj748wUmAkSQd3sG1j1mlLUUcMnOwUsF+xRRcoTIjwxzYEobXu88jxcNJqvnfVkiadzxht
	voX3/qc0P0uZFfG9wxah6/TL5QsDdK8pzFaRlq37i1fPv7mIPktqrXQ==
X-Received: by 2002:a05:6358:6e88:b0:1ba:5118:ebee with SMTP id e5c5f4694b2df-1c641ea6f2bmr658006555d.8.1731415741585;
        Tue, 12 Nov 2024 04:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqIUm2AqLWOl43bH4Dc+V7W9b4DHpDjnOPXRxys0bKVgesz4gERPMAgv1SVGD/ZW/baY3gw==
X-Received: by 2002:a05:6358:6e88:b0:1ba:5118:ebee with SMTP id e5c5f4694b2df-1c641ea6f2bmr658003955d.8.1731415741304;
        Tue, 12 Nov 2024 04:49:01 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b384sm71399376d6.91.2024.11.12.04.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:49:00 -0800 (PST)
Message-ID: <e03fbb80-2f44-465b-9152-d85302b9454a@redhat.com>
Date: Tue, 12 Nov 2024 13:48:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 6/8] cn10k-ipsec: Process outbound ipsec
 crypto offload
To: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jerinj@marvell.com,
 lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-7-bbhushan2@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241108045708.1205994-7-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> @@ -32,6 +33,16 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				     struct otx2_cq_queue *cq,
>  				     bool *need_xdp_flush);
>  
> +static void otx2_sq_set_sqe_base(struct otx2_snd_queue *sq,
> +				 struct sk_buff *skb)
> +{
> +	if (unlikely(xfrm_offload(skb)))
> +		sq->sqe_base = sq->sqe_ring->base + sq->sqe_size +
> +				(sq->head * (sq->sqe_size * 2));

Not blocking, but I don't think the unlikely() is appropriate here and
below. Some workloads will definitely see more ipsec encrypted packets
than unencrypted ones.

Perhaps you could protect such checks with a static_branch enabled when
at least a SA is configured.

/P


