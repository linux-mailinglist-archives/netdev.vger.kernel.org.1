Return-Path: <netdev+bounces-192319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C38ABF803
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9A47AC1D1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36A1DACB1;
	Wed, 21 May 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEd/FJqj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B214A627
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838505; cv=none; b=t4iwWp4KpmGaqfn4KBRiVsITkmuEpWnAifZxQPvixY9Ht4zaXeC7j7vfmVdZERAk3m5XwgiMznW6wMY33VMqCFrHUMJEl69b2HPRMPm6tnCJLwInLqZlYteZua+Eeaj2wataIBHwXeIwqbhKxvlZd3iEQxRlNchDWXcRdhy2n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838505; c=relaxed/simple;
	bh=fJrz4e1Ti/Jt27bWzNcWF73I0K+Q9z0Ka+LDgDGAiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6onmz/fosdBU/v2e+XnW68JuP0XJx+W5iefD4HdtQAeCpINjM8rmqV81XDSwJ91lvTUmKcRUo6lADuzkxOUUBQLcTWRXFqsx21bLYzLF5I8y2hLZrZHz0rzkdRLi0DZcvBfwxRpH+GSzGktLq18tIRszSYAhx7/ChVV/yWfunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEd/FJqj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747838503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDesXKTayHxGjIGY1j8G0o6g9UGYHXMrYuHHOq5gQRI=;
	b=cEd/FJqjuEwN+FiBB+vAgcFNTKcrRa7ndIC45HqR0iO+wN0X2OJcC2U4HgAdIOsTSBgTF1
	jWIsZytTPHvrJJ0Q+v8b1MmoDwndSkAmWY07tJJpssOfKltofYXEwvAJ6/1lN65X2a/rom
	TnypONEuRrap9YkOyNGHDc4exmq1jdA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-OeGvqQFCN82wrSjPQWM5fg-1; Wed, 21 May 2025 10:41:41 -0400
X-MC-Unique: OeGvqQFCN82wrSjPQWM5fg-1
X-Mimecast-MFC-AGG-ID: OeGvqQFCN82wrSjPQWM5fg_1747838501
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60211a1705dso2022563a12.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 07:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838500; x=1748443300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDesXKTayHxGjIGY1j8G0o6g9UGYHXMrYuHHOq5gQRI=;
        b=CIOSbSLmimNHgOgM9t+yR/kwaQ+Mp5Y12j/wvlohEFGXNreXheRSGfaQFANHhNgYqb
         IltgHNaGLoZt71MOqKeKJwGMBjBiTrtF17qPpdcfoW5ODhHK1C8QAH2F3zs81/yFJ+1y
         nKWeMZGnC8VUUvBl7yZshdhfigR8YyvUYdelaI+D7GtDwbWbt2yWYFzwdcZNPkI4lS90
         EZqovqBW7vTtxKGeUI/bsZ1WIr/7IBmlF61L9Wo8benz+32GM4ygBIKkFIr/HgmQjT+q
         o19f8+sOgV9/4zhF5F7qFVPdVJ41YqkV+QuBraMgR3o8GkpS3IN21sZpwkmrU81gPt5i
         mKFw==
X-Forwarded-Encrypted: i=1; AJvYcCV7BqrglM7+phEBDzPRndCJauWA+pI8wSnqi4lmwVci6O2Xv1SUg5QaTI9q0fZSGFD1c3ZUzck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3dC5bPdFKzFSxjQZ/8QUPD7MCbJeu453ANnJYiXTg/bhLJ/K
	TBMkcaMErYRulN3AeIRumSxTrgVjcFL5Yn2y/4Uw67CrhmRcFT5nPcN41V3Ydt9C+JTM1tCsdWe
	VEEfFvBuRiZLhyme6OD/tZ5MlFS6+/VV2esx9FH4Wfcq4YhGr9Gopbc9CBQ==
X-Gm-Gg: ASbGncsw+tKKnwyUgtHXXfgi+dljM+GTdco3eaRAxUp+11hd4oDhOuHcwhPCeBJpYnP
	S/Dsdr6lF3NixDdhdsk82NloWZ7C3Sw/vM4VUzjGnfVyhclrBeVd1kiM082p017jYEFOFqFgjcz
	4lfgI1hQHJiDvgd86EwDQWEP95TpTpCQ258RehhvR2cHBM9Ht6C4E6C833FHOmecvTv5bPZqxTa
	ZZc9kGZ77GI9f88H3A179RyfTsecUU05AcBK0hwkDnlrX5eKhZCrXdOOdnOMC0ap/X8t7MDDC6a
	5uwdkW7OmxU7argEWlBvaJvQuywVp/qYxiBb/cOEsFaZCE/e8GpZhcmlOIzh
X-Received: by 2002:a17:907:e916:b0:ace:c59c:1b00 with SMTP id a640c23a62f3a-ad52d42dc34mr1768467066b.5.1747838500580;
        Wed, 21 May 2025 07:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE66RxXKL2W6d/q5voawNHWMt+eYxa0BkwW3PNFANgomMqz2eIeLzBYh2MlVa3aFRZzUSRf1g==
X-Received: by 2002:a17:907:e916:b0:ace:c59c:1b00 with SMTP id a640c23a62f3a-ad52d42dc34mr1768463566b.5.1747838499992;
        Wed, 21 May 2025 07:41:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dfa4sm914996266b.57.2025.05.21.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:41:39 -0700 (PDT)
Date: Wed, 21 May 2025 16:41:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/test: Introduce enable_so_linger()
 helper
Message-ID: <3uci6mlihjdst7iksimvsabnjggwpgskbhxz2262pmwdnrq3lx@v2dz7lsvpxew>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-4-94827860d1d6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250521-vsock-linger-v5-4-94827860d1d6@rbox.co>

On Wed, May 21, 2025 at 12:55:22AM +0200, Michal Luczaj wrote:
>Add a helper function that sets SO_LINGER. Adapt the caller.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 13 +++++++++++++
> tools/testing/vsock/util.h       |  4 ++++
> tools/testing/vsock/vsock_test.c | 10 +---------
> 3 files changed, 18 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 120277be14ab2f58e0350adcdd56fc18861399c9..41b47f7deadcda68fddc2b22a6d9bb7847cc0a14 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -823,3 +823,16 @@ void enable_so_zerocopy_check(int fd)
> 	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
> 			     "setsockopt SO_ZEROCOPY");
> }
>+
>+void enable_so_linger(int fd)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = LINGER_TIMEOUT
>+	};
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e307f0d4f6940e984b84a95fd0d57598e7c4e35f..1b3d8eb2c4b3c41c9007584177455c4fa442334c 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -14,6 +14,9 @@ enum test_mode {
>
> #define DEFAULT_PEER_PORT	1234
>
>+/* Half of the default to not risk timing out the control channel */
>+#define LINGER_TIMEOUT		(TIMEOUT / 2)
>+
> /* Test runner options */
> struct test_opts {
> 	enum test_mode mode;
>@@ -80,4 +83,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
> void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
>+void enable_so_linger(int fd);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 4c2c94151070d54d1ed6e6af5a6de0b262a0206e..f401c6a79495bc7fda97012e5bfeabec7dbfb60a 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1813,10 +1813,6 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>
> static void test_stream_linger_client(const struct test_opts *opts)
> {
>-	struct linger optval = {
>-		.l_onoff = 1,
>-		.l_linger = 1

So, we are changing the timeout from 1 to 5, right?
Should we mention in the commit description?

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
>+	enable_so_linger(fd);

If you need to resend, I'd pass the timeout as parameter, so the test
can use whatever they want.

The rest LGTM.

Thanks,
Stefano

> 	close(fd);
> }
>
>
>-- 
>2.49.0
>


