Return-Path: <netdev+bounces-97825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F788CD642
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CAE283BF1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE16B641;
	Thu, 23 May 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0Jwi1Lv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DC2901
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476102; cv=none; b=QkEB3rCyxldD2a+bz8LbL+fIHPfL+UvI7r8ybwd+zPsVWnFMGjK5FceTGTuB33Dbbq1EeoZ5Can0d9E7GqrAwU5MwCXsGRjSZ3r3AX5mvM1cm2Rbe8Eyj6fCNRlMZXIodrUkP0vjMd0tw+0w4zZYDBFqlXWDhBruPo9/mvT0pKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476102; c=relaxed/simple;
	bh=IXR7S6Gc+F3sudLsZ8LWQ+6UJawqmAovn5NH00L+sI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2nO+ewOCxTswqGK92IpZ0CYUHsfa29jyFHFoy/fQRL70ScoPYMtIhWE8kMNghEOk6sjE1EhwKncsgr7pLO9SLk+iXFtVys4nywoOwqtPuGDimXs1JBbiXyOLDS4rXDFNLtaUWtd9R0Ee46TN6lI8XnDUIyw1Rhr4VZ4EAV3Ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0Jwi1Lv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
	b=R0Jwi1LvTtjeblyOL1lclj2ZEvTnTTRLg41l4MkQv/HR4xEP7tF2+m961Rqu4TpQ5oAd9/
	jrrAn73lG+op0ABDFKhL5L2PwoTSkyhGN2U5W+OGSM3vlHnwGJvwrNQx7rGXk9viUdLWn9
	tjMm8iWKiScMzNTmN1f3wE+TKh1HJgE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-xrfTH3txNaeX2zDpEGdM4w-1; Thu, 23 May 2024 10:54:57 -0400
X-MC-Unique: xrfTH3txNaeX2zDpEGdM4w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e1e7954970so12879541fa.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476096; x=1717080896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/IspulZ7ogp/9/Ev8vDQ4CFOVYGCYWHCfNnAnEppwY=;
        b=bdrzmtNt1MJXfPNJdHoLpTkte3N1TRulfu+FA7qt5y9cpnlXUKFJ/rllKl3+B2JlsN
         jGkWmBameNtP8S+kZQwVHFDdx35zo4cQp+xEE5l5V6gWE6ZB78lrFh5QssECz3MzF2Ha
         ola+FL6cVaQewU3v0Ujz1h3GJflI+FjYCUfbKl9sWlS/cigW8GYWNxcUmrGsC5BO7emN
         Jc5I5/1k0BsLwj935cCVsUp3mA1sS2zuKxUgwsZEvLvUKv+5mdItgBLJ84iP0PgE5RSN
         gHDkvZlJqzJsUBwLeFRXu0JsucM0HPJRLLGqO0mLqlwmNhNsWnc1VqawUOjhTqrUxb8D
         WRYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9dJavPMKMxpsK1Wgaw9/ghX4ckclDSiiKrUJedfjufuUOxcziDQ3Y3wlxpHPRNjaSKgWb6lBbucdAEk1QDIUzLJY2Rvxn
X-Gm-Message-State: AOJu0YyQiyRU/CXWBtzEKRw+dCODqo5zA7CNBfC1X666k7zQMbPfrggC
	eYEo47+MqL+88Lvmw5JqdENJ97sHeKnq/OnBXsOt6LnmkSlENyXvXBtW4Td5LAN+HBhVt5qhXAl
	fKX7rdWZqUxArSVaf1tmeWDIwUdVqMfoR/XdfqFR/lTOJQSYyLQ08VQ==
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723541fa.33.1716476096193;
        Thu, 23 May 2024 07:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC0bLoBdXb54NPxLQ4coOeZyHZBFadFkv6sukQZSvxP4AKs7iWObQtZZHt9eGMKoAkua8+hQ==
X-Received: by 2002:a2e:9042:0:b0:2e5:4e76:42df with SMTP id 38308e7fff4ca-2e94953fb10mr43723241fa.33.1716476095561;
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm1095429066b.67.2024.05.23.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:54:55 -0700 (PDT)
Date: Thu, 23 May 2024 10:54:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 0/5] vsock/virtio: Add support for multi-devices
Message-ID: <20240523104010-mutt-send-email-mst@kernel.org>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>

On Fri, May 17, 2024 at 10:46:02PM +0800, Xuewei Niu wrote:
>  include/linux/virtio_vsock.h            |   2 +-
>  include/net/af_vsock.h                  |  25 ++-
>  include/uapi/linux/virtio_vsock.h       |   1 +
>  include/uapi/linux/vm_sockets.h         |  14 ++
>  net/vmw_vsock/af_vsock.c                | 116 +++++++++--
>  net/vmw_vsock/virtio_transport.c        | 255 ++++++++++++++++++------
>  net/vmw_vsock/virtio_transport_common.c |  16 +-
>  net/vmw_vsock/vsock_loopback.c          |   4 +-
>  8 files changed, 352 insertions(+), 81 deletions(-)

As any change to virtio device/driver interface, this has to
go through the virtio TC. Please subscribe at
virtio-comment+subscribe@lists.linux.dev and then
contact the TC at virtio-comment@lists.linux.dev

You will likely eventually need to write a spec draft document, too.

-- 
MST


