Return-Path: <netdev+bounces-176054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE8A687D1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DE4169E1C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05482528EE;
	Wed, 19 Mar 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFaZWvAL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366C252910
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376088; cv=none; b=LOtOBGjIrNqcAc/dKDa0oF67SW5uBcbRrV5eDr1tY+wvfWLonrVQyKT3ePPD+8MN/iCoDCBXN0Bq7ak8nd9K630e1FNiVuvgMs7DqkbY+WhGr/0QZY0wEOi1RR7Z5+gI8D3G9fzldbnHsbgeuzJnQgbYFfZHt3MehqoutCh82/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376088; c=relaxed/simple;
	bh=hayqKUFA/zQJSjM3dzvjLdtKtJ8WDFXlSPyW2SDZhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT6kZh2m9qj4C5gFOsrHRcf1xNNzxirjunraC7iIb/GLKFrTi0Chz+OoybAl/3mMnEgZlVswJC8I06pe902hLenv05LPnZvSAqjnXEjEYuytTeoBEkeR/yjJD9ZF+NkmIkyP5vlAdLikVmwHXgPNEQMkANpd4Wn+2t08D+AiIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFaZWvAL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
	b=ZFaZWvALGZAqvCJ9cUKK+jQsa0KX6D/poQ+lTLyGJQt81RvaZ03hSzkc0B3J4/9o/I5UGX
	7xuLm3f7MZHZnv0qy4AN7n+c5dgWTyZtMDzjqdrEOi8at3SzBaxv5cvfH/wnvA69qPdlO9
	6KiLb4YLYZZAie2fegUMobC+61mTCbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-cSV0OKTbOWyX1fw6JdeUww-1; Wed, 19 Mar 2025 05:21:22 -0400
X-MC-Unique: cSV0OKTbOWyX1fw6JdeUww-1
X-Mimecast-MFC-AGG-ID: cSV0OKTbOWyX1fw6JdeUww_1742376082
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso19105175e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376082; x=1742980882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
        b=Rvnauz5ZLAka9tsEI6u04TT27pxqhpfS3JglNJhZ/XKsWRmfJvS264epl1+yJy1C6v
         QCRAsunAQeA1XR+tRmG+3S7AqnPjEG8NAN3Cz123ChEKXFT12+568EZMFB7UDh/kYDZn
         1q7SuQMC6dFdVTaYRkA2isa3b2H5UmeQ+LyD+pRdQuhsvoi/wTrx29uzzT654hekYTnF
         w+TF0RLKp4MjBHUk6ovufkRYKCczB6Rqr/OJREO+4AqPixneOgpzIC71CzH+1ZywRbqp
         PmgYJ5QMRVCdqs/U68edfq+KIA608ZU5OBStqbL3i0JWitT12rT8Y+/9qhh2veEhov1n
         YbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUR6xvURvIkOgz+BnRUWbgn2GV3ayatf+VcqinMUjph8OY9YG2NcKqX3iLJQoHIO8uuWxOtDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFj3t08dmengOhLFQa/z4sEgKD0KYYtYzI7zvtFOyORMsoiHCo
	xcfMYF65wJVwF7LEM8+L1LRt3f7rryVexbcZD/J5jBDd5u8o2NZj5L1QgK4e2eSuMIIQD8Q86kg
	XrTQJvRsj28ZuN6BYnbPJ2aflDvZo88d4N25zBfbNPFX9TekmSewFbw==
X-Gm-Gg: ASbGncuV0vYQh50UOuxgOvUeYV08xAgb2D7iwW2A+UUDmQDm7BhPV5SYz+qsZwKedHF
	SELQc3iC7v1thMH+6uTnB96C2osof6mCd8BZs69PBtCvi3eR2xJmgZQnybJ8DzouIU9tV12QroK
	OzWeBgaTkP2llN/FDRLN3y6S7EL5nbCAhBRUSlQkWlTDK+yXLubwQQ6W07u5uRk4DhtK9E6HhHr
	MLDvxeMwXDyOF6Hu9pqH42guBNyyaPNwJzcbtW9GrO/rq+mR/o4gG3q89YmfGydbDVE5gT2hV1y
	pLPB6ss2IA==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15053285e9.3.1742376081593;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTbAy+ec2vOHg58y5rxcFbvt1zKhjrhAbtgCtsF91K96gkFV7iO8cXVF5jgAUnN+dJQoKFQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15052755e9.3.1742376081050;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm13000475e9.33.2025.03.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:21:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap
 update and connect() disconnecting
Message-ID: <20250319052106-mutt-send-email-mst@kernel.org>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:22AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may disconnect an already established
> socket. Problem is that such socket might have been placed in a sockmap
> before the connection was closed.
> 
> PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
> sockmap. PATCH 2 selftests it. 
> 
> PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
> code as well, but winning this race variant may take more than 2 seconds,
> so I'm not advertising it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

vsock things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v4:
> - Selftest: send signal to only our own process
> - Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co
> 
> Changes in v3:
> - Selftest: drop unnecessary variable initialization and reorder the calls
> - Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co
> 
> Changes in v2:
> - Handle one more path of tripping the warning
> - Add a selftest
> - Collect R-b [Stefano]
> - Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co
> 
> ---
> Michal Luczaj (3):
>       vsock/bpf: Fix EINTR connect() racing sockmap update
>       selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
>       vsock/bpf: Fix bpf recvmsg() racing transport reassignment
> 
>  net/vmw_vsock/af_vsock.c                           | 10 ++-
>  net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 9 deletions(-)
> ---
> base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
> change-id: 20250305-vsock-trans-signal-race-d62f7718d099
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>


