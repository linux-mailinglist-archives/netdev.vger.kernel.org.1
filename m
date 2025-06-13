Return-Path: <netdev+bounces-197528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371EAD90AF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0AD1E379C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F61DE89A;
	Fri, 13 Jun 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBmBn18a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AD1ADC90
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827009; cv=none; b=j4EK3kvMBkGT+QosaWLEdXadQvx6JG6mldFAf4BwjA+2/0J9F5Vg93GgSj3Dpf6w4xaf2sg5AKrNtEhlyVKC2iSkgonEe0MBkxkrB4B51wTT4UNtzGvhYe/bdLy44eYTEc9xng8zc51c8J6gR9vsaKpWdAOpus98IM9MlA2baJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827009; c=relaxed/simple;
	bh=cRYeyi32ANevS1OvWRG6UViBewsU9VurRmT5/ra/CsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abqCEG7PpcNM33AiWOFT9vhOC6mQYwenXRhzmJS9eW5/A4oOnYRuA32TQU4lf3EO6VLDAZTOw9SiQMH/sB8StslDtnXOJuYyp0pby1bnQ+FjxCg8U9a052Rwh2DD/ldSVjpgcD3M3sI3CY0+gBgGuJgkOg91X6z3SJQx1vhzBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBmBn18a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749827006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPptdkmUQWyY2NUgk5R+pR8otplw7JGCI3XWawz+SuI=;
	b=dBmBn18ayX+VEMMrN1GwYiINtWEYNoqqSAK/yFWBgh8jD/rqpeSaVoS6huOmWplkatC7kz
	BHnP4RJr8fRJRnIJacC3d+WzHirh6jLg4klSrS4bP0VPaVA3FlY/D3JOQuw71p+griIagb
	ZsiSdeuJmnlsPi6dXg61V03Ve3WGdpc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-fDnHDKP6MXqFbva1MvepHg-1; Fri, 13 Jun 2025 11:03:25 -0400
X-MC-Unique: fDnHDKP6MXqFbva1MvepHg-1
X-Mimecast-MFC-AGG-ID: fDnHDKP6MXqFbva1MvepHg_1749827004
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1374278f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827004; x=1750431804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPptdkmUQWyY2NUgk5R+pR8otplw7JGCI3XWawz+SuI=;
        b=tWg7TnAeRa22E8v/uKNk8uaUg3p4d+rK3rtQi8kN8/UAL9IhpHIEefN1K73CF4h6mo
         p2TzkeTGlWTW3ggvwycPnxF55WxFzTEEJgh49+K0GkLodZysJ+sBb+WV+2TFSQL4jDYe
         3986Qi3V/FqTParttTSFIoT6TMkheqP7OoNYhYwVIuOpXax8+9zd2RMkLErrfypaFjF2
         OOk53gzXhAD8lTHwqRmkwh7TimnzjW6XbpXphi+ZbtFCJh037abetNaSG0SjETUKQ9gm
         TCJ/ciTuvfACW9/iLmtx9cOPk2NVM5Y0hxTElYyIVFnrzJ0yZfvXD5Ev2Eo2jTBJt4BS
         gRjw==
X-Forwarded-Encrypted: i=1; AJvYcCUSaVqCxDMuL+cRZwnt8kY4ntEvmfJYdNmnqosookpjnc2emWJRTChpJJS/XTa8hfxvCykVfIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyarhMT6oqKWdiVMEzm5HK4o1eh6SwbSsQqzHVcdZGHU7rgRX8f
	V+H80oipw6cTpmiA/rw3jQxc3ZGr7Kt5nOgGJJGUlXzHUc/WdN1BUWP0dCrVfeHlvqsOGyKDwjd
	EXmSSCMV9uu5hZ4egNKvy1dso3HDjXByyyt2oF84yv2Keifui0/1O2Y2SJf2vGlZGSQ==
X-Gm-Gg: ASbGncugpNcgpUIztpV09ptmHtjBfU6MqFh1XmQguvu/pYNJtrwgsESt2+HbAVzQZJG
	ewkcBKnpW1Rbins7t6fgtJCaPwzLRm9T1FCn6RuyB8meyjbX+sYDt23cWnk6H3WfytfDvEwnXkH
	pagyLQIk8BKOXnFO6pB9/7FMD2vhMMqBP74TMDadJTHDm2ln9+xKx2h3FywPvd603dHSCodX3sR
	h9/sFLsr8whi06Orpv2GAaM+dlihXDWmi8XlvkM1EnnJjQntBVqtLFDyhE+qePUczlX9NTjr0Gz
	5ezCDf9fDEBtdFtKrl6SLFyrtOY=
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr85629f8f.26.1749827001377;
        Fri, 13 Jun 2025 08:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuYvZ2dAnZ8I/GhdBHLLhfs4MPExbGzsgktXxUps2HvDq2BLjqswHaLgKzUuLhLc98dafM3A==
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr85548f8f.26.1749827000681;
        Fri, 13 Jun 2025 08:03:20 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b27795sm2607608f8f.71.2025.06.13.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:03:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:03:18 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] vsock/test: Introduce vsock_bind_try()
 helper
Message-ID: <wt6dvbknnrm7wygcaflwh6jwkox2vveii3hr6qhiepbyetg3sr@y5iuhennusag>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-1-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611-vsock-test-inc-cov-v3-1-5834060d9c20@rbox.co>

On Wed, Jun 11, 2025 at 09:56:50PM +0200, Michal Luczaj wrote:
>Create a socket and bind() it. If binding failed, gracefully return an
>error code while preserving `errno`.
>
>Base vsock_bind() on top of it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 24 +++++++++++++++++++++---
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 3 deletions(-)
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

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


