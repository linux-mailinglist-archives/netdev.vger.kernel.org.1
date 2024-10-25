Return-Path: <netdev+bounces-139011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096669AFCBF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368CA1C210F9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231A1D27A4;
	Fri, 25 Oct 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGYJQPBg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CA1D1E92
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845483; cv=none; b=WhIJKkwp244R3tF7gIZEXkdRtujil1G+mRht6TIyuwAGbBVcbXv/niOtra6X69GrJAXuqO+JffZVqht6XByblNycsRkiMuFkn1Ee1ACeuUK3klBoRdoMjMtCDJa+HCfW7JRikobvH+6q7hP+BGRejOwZ86nH2to080P+GlCkNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845483; c=relaxed/simple;
	bh=nVtFuA3MUXFT6qe5Nc+wclnoMmIuimggNWMscKvWImo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oARKJ4Mg2At7G+GkRt1Jtu0aGAXlSJe7FB5zYGXJ/KHIzeN+fu5YtFvOtRU4H2kPmTjXUKmgQkFwMgJpH6zYDu4jyyUpG9rH1sL5M8vywGB6zjU62LX85TuayaF34xsSbJYyFdOd3Hnqqje/+ijhusC3bYOVdF+JN8zGoPcv6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGYJQPBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
	b=YGYJQPBgSea4wTDCfDPiddN9wWnUhya7tMEO2oBv0TSNCXXh7gBf+SxHcDmnZa2sUX7lNv
	bQxmluH1NcBu7nvBROTApQo9CLiqypwSIwSd22ir4rOf1Vl4m4Ee50FzKuMsZeIxhpbsMI
	bqo/O2UMvAMBiarnzPCzYNPh35lu70c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-GeFN8YJcPu6dLbjSUO50hg-1; Fri, 25 Oct 2024 04:37:57 -0400
X-MC-Unique: GeFN8YJcPu6dLbjSUO50hg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b15c3ad7ceso223196585a.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 01:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845477; x=1730450277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
        b=pBHDt02ceYeDPorFzxj+mcFWAJQaKFkAeIgU9pI/ynb/T1QkO0O+t4NTYmotOP0K8C
         FbPb3zAGkqgFFj9iJhieEW+P2MEFXcr4FA27mvqZ9gwr1qdOVkVf7lxalEvG6dAJ0mPh
         hRGVwOmjInvNSIjt856TMNcRySx2fGQgcvU0CcDdIVBeAjEWWRafD7QBU8EUxBmXAUv3
         lpIxv/98tRpAYqVV5PRZD4MHQqWm+BRxI3HsksjSPMGeaoe66jhC/gPONiRNWp3n0bmO
         vPVPap+hte7aEUVhwSEWXntrJu9fgX1CrfCKapXfUjR+nOvg0WIGr6imy5t3oqfQMH3N
         NLSg==
X-Forwarded-Encrypted: i=1; AJvYcCVzip/3SpYvJK63Qygiht+RlwaDiy4zEJundtU0qWVaoE2bH842Zj++qpFc9Ie7HdrMEmw8vaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaSBa/HnHiqg4sZCOTbaOm2ZaPNXnAu17iEtc8zfnd1T+L/CS
	wP7UtVVuF47bHzfuaH7Mvh7kfcyo9naTlQurG988MR5P21/TFdg0c+RO25ojdhbUxl5r08TUjo4
	5/NbbJ03Wn+yNyjAD7QzH0V3A8tiEzFexHPhxHsgfwiGRzCDFTocdaA==
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614541485a.59.1729845476847;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuQEjcQhlSNMj30aQpJXJBOGKeqEjdKKGecMohH0UZa9AyzJnLZNXjh+x9iFwZinN8LX18HA==
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614539785a.59.1729845476495;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a57d4csm3713716d6.132.2024.10.25.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:37:55 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:37:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v2] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <pdgrhpta6qqwa7r6zexqikcybkllootq7qwbe36i5uf3fpbavb@v4vyiclg2cis>
References: <20241024161058.435469-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241024161058.435469-1-kshk@linux.ibm.com>

On Thu, Oct 24, 2024 at 11:10:58AM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in test failures.
>
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v2:
>- add "Fixes:" lines to the commit message

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> tools/testing/vsock/vsock_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 8d38dbf8f41f..7fd25b814b4b 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>


