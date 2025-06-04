Return-Path: <netdev+bounces-195053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A6ACDA91
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA08A176B1D
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D428C5A1;
	Wed,  4 Jun 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpzKGokT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862125C801
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028123; cv=none; b=EYUnc1WCOhSbLpT74vNqpFSKJ4lKAloS/bmxU+/0ooDVBGs0TPsSinxeAdUYnJlnRBsevLWomXJK/kTe2vtjgd1f3Ii0TQRzciFLoyiDyyAi/d3HuNv5ewXsiRfNnaMk/BjoYS8Zjk6Elakq6KYOpORmL4O7ITYrhj0jbghx+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028123; c=relaxed/simple;
	bh=ykSrUtJRVrG5C3ewZuDK3v3dKTB5s3CoywV9b/oL5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWYXrF5h3qlYJSYxkk/f8AG2xdgPH2FOyRR6aVSss+oalISvk4aiXa511x4h3eO7QgG250squ772j0qp0ySWdFlyX7Di3H/E/RvE+DEQ3WHH6Ki3KBYkSencFNHItr7IQmSZo0xlLXLia1JzhNVO+cSj2QNsVsYEGsPg0qskBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpzKGokT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749028120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8Q0qUknm0Tw+XsQ3Iumz4ckG8TiyaKNLtuTt/FSDJU=;
	b=HpzKGokT3stj0gcQE+HPVZrvG58YfBm2j2leBxGpU9WbJNzgTHLeddDJFpQxmJT/K7bXDF
	15aQDZ3Df9R2sjMAjJE3DsUHf+50qcMS9f8ai718I0pkmhpoeNSfF+u5RtoqnChGTpdZGt
	Z9zWbt5O+5/+gPctYVjwoDXwhLJCKPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-_flHhZ1AOTenDX-6_48shg-1; Wed, 04 Jun 2025 05:08:38 -0400
X-MC-Unique: _flHhZ1AOTenDX-6_48shg-1
X-Mimecast-MFC-AGG-ID: _flHhZ1AOTenDX-6_48shg_1749028118
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3425329f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028117; x=1749632917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Q0qUknm0Tw+XsQ3Iumz4ckG8TiyaKNLtuTt/FSDJU=;
        b=V3shnbOS9/PRXtSSrmGWwKBexo6xr/Ax9PlwrwIBs0qorUNsZsC2SZCINpA8V7q/32
         iyx5Sb94CYoX3EjDj+IGulpf3mwjCrBmB/ICLtkEo1BWkXokfDVzkCUZmFjWRmoliNeW
         RXYXY2uasD7MrlScQe+x+BLFO+ZR3RDHi7tPXynVVSIYv+MamtzeMfpsO0BgnQi4peb3
         cKsZ3Lp/+7B6oc8Q3kwAhj5CZ6fpKMbCvoslnn451jacpD0lbfBMTT3K5w3YShoN0m16
         BfmbO1VOqU4SLCppGf7DQ0f4/2CPG9w34T6RHdccY18X0nMRNH75CfUZhfo7oarqXiSs
         O/nw==
X-Forwarded-Encrypted: i=1; AJvYcCXMY4dCXdI047T7ALlZsMdpV2eBR0fWogCyb6ZyuuwpUekH3/NjHHOoMqfiHkzfN+cm7qV2I+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0TvDQ0O7Tz2Ql5U30tG7+9cBdVplSyO396ADLuMEPAtXpXQm
	d+/x9CcYC0mpWs3Fq/CrZHU2TvCE9wdHHfvk/lVwQgIH1p/W4c2dfCtFFw6CiG6Kyjf1AqQ7pWT
	pJrNs/ldGdZyWldndgVjPs0/pyocbnbL0L3qKo1y8wj7bbIqd6vMaJJTzUA==
X-Gm-Gg: ASbGncuUC3mHV5VjmXyfMklRrd5j8jyEox7ncSTNmjuh3V41SXTPd8jLeXV/ulz7T6I
	smgyu3Isf+fD4iPznQ8g4lVTR2zvFU+3QM4N0yDWt924JNL+LoQtsRq6oMAczzbAdLaJJNocAMQ
	2m6aark7qdSenfN3iApA0vZKjDy2hsKbI2tzKNa7IuNTL6UETohZhw7W86v3WYjFOMcTXGGISNC
	Kc+Cw+opnXMuV38pscczwqiAh3VieFH8LXB2MHaLUR1h4IadbvRv3CX9XdrqnQLNV8/S3otZXqx
	oD4cdWfB3Tb6vh0=
X-Received: by 2002:a05:6000:2888:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a51d903439mr1437404f8f.19.1749028117604;
        Wed, 04 Jun 2025 02:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcO2c2+diZvmUbgKDdnVKUNfMxIQzDrhP//nieF9e6yFt+1DNHaJUFNS9crcHuZE3m2IlpVA==
X-Received: by 2002:a05:6000:2888:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a51d903439mr1437378f8f.19.1749028117040;
        Wed, 04 Jun 2025 02:08:37 -0700 (PDT)
Received: from sgarzare-redhat ([57.133.22.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5215e4ce1sm871363f8f.37.2025.06.04.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:08:36 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:08:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/3] vsock/test: Introduce
 vsock_bind_try() helper
Message-ID: <itgkguzg4egcqi6y65cq5wky2vpcbdoxa34vcwgjh72rziy6uo@7bp6x6e4prxq>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-1-8f655b40d57c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250528-vsock-test-inc-cov-v2-1-8f655b40d57c@rbox.co>

On Wed, May 28, 2025 at 10:44:41PM +0200, Michal Luczaj wrote:
>Create a socket and bind() it. If binding failed, gracefully return an
>error code while preserving `errno`.
>
>Base vsock_bind() on top of it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 24 +++++++++++++++++++++---
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 3 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85cde9c8764fc3bb623cde2f6c77a6..b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -121,15 +121,17 @@ bool vsock_wait_sent(int fd)
> 	return !ret;
> }
>
>-/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>-int vsock_bind(unsigned int cid, unsigned int port, int type)
>+/* Create socket <type>, bind to <cid, port>.
>+ * Return the file descriptor, or -1 on error.
>+ */
>+int vsock_bind_try(unsigned int cid, unsigned int port, int type)
> {
> 	struct sockaddr_vm sa = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = cid,
> 		.svm_port = port,
> 	};
>-	int fd;
>+	int fd, saved_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
> 	if (fd < 0) {
>@@ -138,6 +140,22 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
> 	}
>
> 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
>+		saved_errno = errno;
>+		close(fd);
>+		errno = saved_errno;
>+		fd = -1;
>+	}
>+
>+	return fd;
>+}
>+
>+/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>+int vsock_bind(unsigned int cid, unsigned int port, int type)
>+{
>+	int fd;
>+
>+	fd = vsock_bind_try(cid, port, type);
>+	if (fd < 0) {
> 		perror("bind");
> 		exit(EXIT_FAILURE);
> 	}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5053804a9bb93934b625ea78bcd7a..0afe7cbae12e5194172c639ccfbeb8b81f7c25ac 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -44,6 +44,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
> int vsock_accept(unsigned int cid, unsigned int port,
> 		 struct sockaddr_vm *clientaddrp, int type);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_bind_try(unsigned int cid, unsigned int port, int type);
> int vsock_bind(unsigned int cid, unsigned int port, int type);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>
>-- 
>2.49.0
>


