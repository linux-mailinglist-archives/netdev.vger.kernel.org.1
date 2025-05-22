Return-Path: <netdev+bounces-192567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B2AC0681
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C9A1BA1069
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E92620C1;
	Thu, 22 May 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM7tAZAN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25017261574
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901134; cv=none; b=hjphvs8FaSPx1nuPIV+9BCPCKP1g/XSBBR+BQ/wThMU6e1QSPrFBVenvjkXDZ4gTHzXXgM5m7sSPQco8rsAkHzD/rgMcAIPRTe3PvPsX/Iicj0yBioQpeCtuOu9vGTfnJ9o2Rr77nM83y0vE1+Z7VJ9JHk8tW53axoj16Gav+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901134; c=relaxed/simple;
	bh=XB1DMlWvcWPFzBP+Imok5+hdMej12hjrOWoDR2YlK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNxH4g5YYhSsb/skNh0O0PhR+mesAR7jaFYNv+uVz2I+D1rNbMQSLBjqp+dEMnoYJ0uFNWNfwzd2g1Bp+RWMY1rtLcyng5NLXWPrLFXHx9fPYN6X8g3HxGyyGbxSAp358ynjCtwqGPEdwdud5z7acNTqjb+ttB7S6OkVFHtMGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM7tAZAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7k5iTkA7yVBLFLMB+U1JSV+k17S5HvwfFdvLDBIgyTc=;
	b=FM7tAZANXtmXMiK2UUalW7JuWSf5v2p+9J4Xqb4C0Yf/gL1fUuk7lPRCfGbc5iT33LZBz5
	IupgrJj3swvnLZbHNZgYxUGwEjjk3NB6NiSOT2mj2/BGHoqIeO9XG5XaoDoImLJexAJbx0
	k8BkrxifaUmGQ+ErcacNFBH7uMyWqNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-BU4PJBJFPQawNykhtF3GvQ-1; Thu, 22 May 2025 04:05:31 -0400
X-MC-Unique: BU4PJBJFPQawNykhtF3GvQ-1
X-Mimecast-MFC-AGG-ID: BU4PJBJFPQawNykhtF3GvQ_1747901129
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso39492825e9.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901129; x=1748505929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k5iTkA7yVBLFLMB+U1JSV+k17S5HvwfFdvLDBIgyTc=;
        b=ZEysAMR8xuADWw026jZswYX9qT2AZxnyKNkKaz214SNrEUsRYWiyGC3xt20NjGJTDd
         mTCaOhR9JcqMsyZa9Q7KpUjJfViOW3kNNmBUYcF6LgXRn9VoDoe0OtF47A3NzkKPY4Lo
         H9AFT9xl5776+9i7vckj+OvO53SKWua5j34LkRdH9XeOuRoRZoH3hpDQgQUcEI7ulb90
         JXpgziCpiSugojL62PpejttRcd8BxreWIOLk3CbHRbv+6u5gOiWVqkHG+m8s9dEusTUE
         a4VL6fhukBSPbMcue0TLLwoaMpPojhfpcJI4V4W3nWViMBCcteBelkhL0eE3V1yw8JSf
         sNFA==
X-Forwarded-Encrypted: i=1; AJvYcCUZM0Xpy9KQEP/kxd+AdsWhC/y51nAnonHKov1R9eOcaKBchM517aZqiFXZaEltuEGYjPNRjB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywshx8mBM9h7pQYTFrU7qtiMo+bw2huelyABdDmGF+z765gB7Tb
	vldFjooo8G+dH72aztgctpXznBbgV9Y90AOiI3aD5bPmI8JDqcZE0Dyuz1DsJXdmfFWlMVjO3p8
	rViUdJUCHHMbpyAunZiDbZ4iz+VkMALNsgtGRLOG7A/B6Oh2rn6mmfNNROQ==
X-Gm-Gg: ASbGncs/W3o89lQD5cucthRZLt4+sdQy4FEVS7y9XtK3hDrKeD2fa5HMbFLJ9+Iu2Uh
	PH2W+mNWqJRBLa/8anVmf+FpO5G+Yl8CO5i05qaXqSyQAzqOe933nQ9igOHGsQsfR9jdkHfjrSN
	pt8brR5VmTaAYhdOyUgzf3csMoOp1fAvuRXFs2ZYc/GuyutWg3CdY5sh0XBh8CyQ23SNfzveP25
	gtAckXuIe1O5Gp3PX63PJFp1rUgieqw39OkEm/G56AFSVEecBJDlIakYCl1PiAX14sPTTuIFfLz
	E6xvtcU1l6QXKBvroQhkuoUW/H4jnw71Pe6DSnx77/TqsD2WqY6u10iK/hQ0
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-442f84c2008mr257388725e9.2.1747901128582;
        Thu, 22 May 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJr/dg0WH1mCD/vKgYtxTFY+fPT/s3TzPpEZ0P+tVyaywIvhuNO5rWcBUW3o5S0oEleDuOw==
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-442f84c2008mr257388275e9.2.1747901128132;
        Thu, 22 May 2025 01:05:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd46aa4sm203871645e9.1.2025.05.22.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:05:27 -0700 (PDT)
Date: Thu, 22 May 2025 10:05:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/5] vsock/test: Introduce enable_so_linger()
 helper
Message-ID: <hzkiu4tq7bxucsvjtc6pz2mkm2eoeoeqcygjtykuuo2jcfnbpv@2blkh2sdcp27>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <20250522-vsock-linger-v6-4-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522-vsock-linger-v6-4-2ad00b0e447e@rbox.co>

On Thu, May 22, 2025 at 01:18:24AM +0200, Michal Luczaj wrote:
>Add a helper function that sets SO_LINGER. Adapt the caller.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 13 +++++++++++++
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 10 +---------
> 3 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 4427d459e199f643d415dfc13e071f21a2e4d6ba..0c7e9cbcbc85cde9c8764fc3bb623cde2f6c77a6 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -823,3 +823,16 @@ void enable_so_zerocopy_check(int fd)
> 	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
> 			     "setsockopt SO_ZEROCOPY");
> }
>+
>+void enable_so_linger(int fd, int timeout)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = timeout
>+	};
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 91f9df12f26a0858777e1a65456f8058544a5f18..5e2db67072d5053804a9bb93934b625ea78bcd7a 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -80,4 +80,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
> void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
>+void enable_so_linger(int fd, int timeout);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9d3a77be26f4eb5854629bb1fce08c4ef5485c84..b3258d6ba21a5f51cf4791514854bb40451399a9 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1813,10 +1813,6 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>
> static void test_stream_linger_client(const struct test_opts *opts)
> {
>-	struct linger optval = {
>-		.l_onoff = 1,
>-		.l_linger = 1
>-	};
> 	int fd;
>
> 	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>@@ -1825,11 +1821,7 @@ static void test_stream_linger_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>-		perror("setsockopt(SO_LINGER)");
>-		exit(EXIT_FAILURE);
>-	}
>-
>+	enable_so_linger(fd, 1);
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>


