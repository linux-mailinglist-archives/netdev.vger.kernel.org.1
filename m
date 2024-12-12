Return-Path: <netdev+bounces-151548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE89EFF69
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCA4165372
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3C1DE2A9;
	Thu, 12 Dec 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cferv90b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A44199FD3
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042796; cv=none; b=tAN5+O2xzzq9OwMtT7t7VEk02icN2JBrmwuWbeBBz0xp6kQBABmUlp6Kx8Pkt42N/OB/DLBkq4WLEd0m5YrL0vT4fY/pSfXbSlvgXBm/FgoT3UWZ3x0HGgOnB1lICepWsebYq0mwYUGVoWxeu4qi11wlwiTE/KL0dqoLYeBVbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042796; c=relaxed/simple;
	bh=oR/uSTr5+GWNNfhF7KM0Y91bZHI1qlHXD//OzY77V9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+47RtJVvAyxEkCvBlIPXJ4z/Wb0A94eCH9BS1WiqVSTFFOyNlLIkCo5lTu3Bzn+ikI+tnAFLEJ1ZASwLzQctUKKA3hzYMnnAGJG/oA7iAIiVr/iMyStE6Z42jT3PQKS82NP5+Lm9BdvnRXLbiaDpi66/NT9I2WcFldoNo1LNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cferv90b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1355545b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734042794; x=1734647594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD9rsf9ii00yY+ms0VR1R7pLgJ7ZdV0Me6Cly3PFX2A=;
        b=cferv90bRS8BAo//w4nii9Bm/1Ft6jcDrx7inRW3kL9BIKSEzO9od5bYWleQolNVSN
         CxrBFLbfKKeXrKwNhd/aX+3qC8yKZwasVRyAuRy4QDfPw2S/yEe+J3CsdWznxLmfl/cb
         ApwVVDqtMVe+OUsc02hfQBKQJTElueoZ3jD6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042794; x=1734647594;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD9rsf9ii00yY+ms0VR1R7pLgJ7ZdV0Me6Cly3PFX2A=;
        b=DG68S1NXXXZe7zl2PuewzOC279L+uegdfZBBBGa5ihW56mU6NxwXCZ+LwcBQFOO351
         3n9g6YwkQha/dRx50gU4mXn+xjH8NDmjFXq1hxmeJWrWb1nT0VPVwRxEj8uAuKSay1vt
         nNQ2VO2rRXP3Fuzk26Ktl1dOOM99j7b12+/lPd3ziIAscp/ZDgRla7NuGrZEbN77NYir
         BFY6dWJaxIAFk+zdC+Y0OJA+kglWEayj+3C2cj3r8PpggwHJaJVE94erOI/n1QLf1zTq
         fyP4TWGS8zONf28a5DKWt5eZOjCUZLFClRL05v4XQrgOp8W3WYwMO5jyC/vnzMBCcinA
         3mDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJhOlyqqlpYCVH/mOvj1mj0kjrCNGMaxp48sGwUzc6UDPyNGQGxPY0dzTvLpUDE6Yo0As5M7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKw7Yk5zIFhp2jwxOkgFOljg1p4c8aAijcWV4br/8i9Ah+HZY
	DcVja6zcv7A2YGtVagltRlFYHRqOPpL7nGrp8QvBtiaYynLTmV6mm1bQ1cE+87s=
X-Gm-Gg: ASbGncva/AUl50vA77jm96LPVCEbQ5hpzrlPd9IJoWq5/myNSGRYVOEPdRSPNpZwhvl
	59f6jWorsH+HNgxQWoBdJ+anQeGHW+RFEjTtb7cYOUzs4bYMuhpiirmdp9j1u+lfy2wIxTiXD1t
	qhrGls0h83fviFPY1mapsYzBgnwzrynbs5mKvhZE+uaD99FytTxXDyr0+qV7bsIyWJBtWLXnnVf
	3v7wXKw7t1tgKOtnXmsQWXZe4We8esQBMgHDcOKNxYTZ4sWrApPfcEPcohvYZXpR4VoRqpFqLL5
	lna3IsLsWJJGESlNUPQg/+g=
X-Google-Smtp-Source: AGHT+IGBhJZFJOsE23TpYp1eNUTDR7TcgwhfQ9p9lzE6GTdMW919AlD7RPLG6833ZIudNlx4NioaNQ==
X-Received: by 2002:a05:6a00:3d12:b0:728:ea15:6d68 with SMTP id d2e1a72fcca58-7290c25b948mr293213b3a.18.1734042794708;
        Thu, 12 Dec 2024 14:33:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e62bb302sm8523229b3a.139.2024.12.12.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:33:14 -0800 (PST)
Date: Thu, 12 Dec 2024 14:33:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
Message-ID: <Z1tkp3m7hNxQ8hF6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20241212222247.724674-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>

On Thu, Dec 12, 2024 at 10:22:47PM +0000, Eric Dumazet wrote:
> syzbot reported the following crash [1]
> 
> Issue came with the blamed commit. Instead of going through
> all the iov components, we keep using the first one
> and end up with a malformed skb.

[...]

> 
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/675b61aa.050a0220.599f4.00bb.GAE@google.com/T/#u
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d7a865ef370b6968c095510ae16b5196e30e54b9..e816aaba8e5f2ed06f8832f79553b6c976e75bb8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1481,7 +1481,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
>  	skb->truesize += skb->data_len;
>  
>  	for (i = 1; i < it->nr_segs; i++) {
> -		const struct iovec *iov = iter_iov(it);
> +		const struct iovec *iov = iter_iov(it) + i;
>  		size_t fragsz = iov->iov_len;
>  		struct page *page;
>  		void *frag;
> -- 

Reviewed-by: Joe Damato <jdamato@fastly.com>

