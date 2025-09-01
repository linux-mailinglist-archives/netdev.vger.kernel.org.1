Return-Path: <netdev+bounces-218720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1CB3E109
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E257A9AE6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98AE30F800;
	Mon,  1 Sep 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2ep3R0e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2B30F549
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724857; cv=none; b=LVOvq326hntQRaR8qV8FOvXXsPdgTuciqThlSuorQml+UWdomcwORAc1gpInFY81tkwPuN8lwj9ZaQv4kHXht6wijhYtNbUYTuhMr/6eli3vH69mbvD7PQeOBzR+WaOS8IkJSSPAE0w+zTWEvtm6jtzE1++KSUnbqPRKRgBy4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724857; c=relaxed/simple;
	bh=tRPHUUr8jac2+pMZxNzhPsZb6N3jgXYWUxiG9fGUN9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ShKzBPlJ681ZTg234SmqSA8vOLs3X2EfS9vHcoaN4MRpWsMg8tk157WkEVswt/QrHJnLxLzKR1yJCaKTt7NO3CO3V6vIOzjF5wnoaFAisAZDTvXZ0X93/8FzHNfGBmRkeMW258aGJ8MLiWqvMeettac6URAcMoVUEH6y52tZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2ep3R0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756724855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeyR90kJgS2mYJEGVvh/bOgIfmtxoV36tSEqfoHaceg=;
	b=a2ep3R0efD4kHlPlLuvERcS5WKCfeMvpL/pZ0LQk/NApzpE3Qfi/+2wbwIaKzngqeRX1vL
	5gyTEsut8Usrs2MgYn7tlDjjLGVXAVbxXPGOatrkqqHm3vYu2XHeUC3AuQTAdkteol0d7Z
	0/hAqcVOU3Rw9mq9tR18UW4UEfJfWNk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ttq6JcvUPD2VfzRZLfZF2w-1; Mon, 01 Sep 2025 07:07:34 -0400
X-MC-Unique: ttq6JcvUPD2VfzRZLfZF2w-1
X-Mimecast-MFC-AGG-ID: ttq6JcvUPD2VfzRZLfZF2w_1756724853
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cd08f3dfb3so1356953f8f.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 04:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724853; x=1757329653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeyR90kJgS2mYJEGVvh/bOgIfmtxoV36tSEqfoHaceg=;
        b=BD3gaoM2ZKPNzFn6ueKiSdeapmpDhWpmBCz8K0fVfTqpMBhZHY/Hz/cXSXyKeCtaKy
         FBPo1Wd5lQY54MqzTEzB43YN8uxQY2kjRH2oPgl7LXMQxn+yEqmHU6DDO4vQGzD5r9gd
         Smd6UAutAHZ0B8aiW7ISeOG+A++xOA9EGSGHxjZIn19rkcqs8UDcPcv9dKyFI5tCzipi
         XTjKcgYPQ9iP1W+e8sy5QKpYTCu481ISqP7VYxy9EvNMI19Ioh+tDKjzXIWjuwPFnxKS
         JVotnld4wknP2BmxXS3NAUnkNPIlFkigj7MsTHlqSWGYVDsHJdZFFrdd8Bw+CkdEAIZr
         eSoA==
X-Forwarded-Encrypted: i=1; AJvYcCWPNvRRiHG7OB67Tgiyrx368I4/7ts+2M5QS2jolC223e4pBVgH+HbHHgIhUVJoHTuNHU7lda4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dZi1AS5pE2JRcDxQpmVPUrWoP2ZI22S558Cm6z1fjE8cI4jY
	/D++ZMZi7+A82SLV+giEqt6dR2DO8oZoR/m+VBEDAnC+WutImc3strc/IWjRC0PYRHcg9l0N649
	6VeAYOaN/Rkv8VpAwOHQn16ZTIMxzw7q+dKpMw/RFDbc3cs0iiAUqt6aiBg==
X-Gm-Gg: ASbGncu7nYErKkavuYMM7zbIbGU1cq3VstzQu4eIXQhszUPec4VCwe95fpwYS4L4gMj
	R2TpPCzTZZjrMxskbT8X9ek4es184Cw5tDr/kE01WrU06MOP857L0WsGMbAft/OZjQvn454eSln
	z0JJgyK+2VAvIKMLo442JI20xgMr2Us1UZirSz3LlhP55x9rUSwmbP4Lq+q7rQGlQVEL4ftYnMQ
	1LFoXnuK/b+DHdG5bAHOowoI8BqCxpjTCditeYHoblSCwMMRdNUKwADLh+p3sYyskfY2F/S3v+x
	OwiviYaLUjK8TqmRtt1WerD6xWAb2+0KUg==
X-Received: by 2002:a5d:64c2:0:b0:3c9:58b0:dad4 with SMTP id ffacd0b85a97d-3d1dfc06dd9mr5343787f8f.35.1756724852907;
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyQ/gTmJddE7MzkBzMXSEOkRhnYpYqf4H9E+J7ETOkCkNOir2xgQgyDgnguhb4xD0Yb+SJVg==
X-Received: by 2002:a5d:64c2:0:b0:3c9:58b0:dad4 with SMTP id ffacd0b85a97d-3d1dfc06dd9mr5343766f8f.35.1756724852520;
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:151f:3500:9587:3ae1:48f2:e5d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2722sm15020863f8f.19.2025.09.01.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:07:32 -0700 (PDT)
Date: Mon, 1 Sep 2025 07:07:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in
 __vhost_worker_flush
Message-ID: <20250901070709-mutt-send-email-mst@kernel.org>
References: <20240816141505-mutt-send-email-mst@kernel.org>
 <20250901103043.6331-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901103043.6331-1-hdanton@sina.com>

On Mon, Sep 01, 2025 at 06:30:42PM +0800, Hillf Danton wrote:
> On Fri, 16 Aug 2024 14:17:30 -0400 "Michael S. Tsirkin" wrote:
> > 
> > Must be this patchset:
> > 
> > https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
> > 
> > but I don't see anything obvious there to trigger it, and it's not
> > reproducible yet...
> 
> Mike looks innocent as commit 3652117f8548 failed to survive the syzbot test [1]
> 
> [1] https://lore.kernel.org/lkml/68b55f67.050a0220.3db4df.01bf.GAE@google.com/

couldn't figure it out yet, and I'm travelling soon.

-- 
MST


