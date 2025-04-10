Return-Path: <netdev+bounces-181432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C0A84F99
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411E89A2A77
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53420E003;
	Thu, 10 Apr 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODCwvPht"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF720DD51
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323923; cv=none; b=QaTUemkp3Vumzpf6nSz9aj/PhTmbHzv1xyw7omRiXI5XflLtou7qLa3VPD39UC38l3clNJEWpWQBn4shf1wqA3Y9lvu2EfjS9AluI+Sm9PVNck3N9lluzj/+iCZMknd4coV2LlczT/a/XXKEU6Xahh2vVgy33m3ICcQjde4Ew6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323923; c=relaxed/simple;
	bh=mfywADYqJ4ew9xI3CclYYcgrZFl/YoOSYDIBc9Dd5cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmTGb0M1HSNp9O3XsSWZn2MjdLiqXCfcsJo//vwI3bLQDFru0BfBbCffmOA0KkxaJJsKuMSdhROyn2rueEAEXhpR88lhqFZaGSiDarqBXBZXvnG2m105+odugWcAE2hCl2aQum4/NPwAzQ5/LQFvvDYly+l3JzQhR9H09PjgIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODCwvPht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744323920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYR4fCas43gwQw++5uVITo+VmUSNg0r33Tx+gqd6wEw=;
	b=ODCwvPhtAlOznRhuW3gn6LYvi0U256nNQznMxqZ+b53kHFhpx7wdrLxeuynL8X0Azws62e
	dwaHPaGJX7rzLF1Wk3w1m++7h3XaAGc6MFn4ajZ44EORHNLH3lh+GOr1wKFQMBuaKz5OrD
	hqB0jZzyZUEyJh4UUPx4l42QGonpBV8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-yy8NJML9OWK3HZ1QGpIVcQ-1; Thu, 10 Apr 2025 18:25:19 -0400
X-MC-Unique: yy8NJML9OWK3HZ1QGpIVcQ-1
X-Mimecast-MFC-AGG-ID: yy8NJML9OWK3HZ1QGpIVcQ_1744323919
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e7be4c906so12212939f.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744323919; x=1744928719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYR4fCas43gwQw++5uVITo+VmUSNg0r33Tx+gqd6wEw=;
        b=diqL5Ew5BIQmkO+JeIZRtBtN9AAqzk/sRlFtVA1rcJgRj2JZ4RlPfDVtg3/Bixg4b0
         dkcD2VSXZH9epu75VzyBpmMHOoXFoeUyQFYW14mQIIuj55WyWhy52+cLgbOHtsXvRswz
         5cJ5a94Ar4U4BawZo7hiPieCT1Fc50cnzMjPTLn4dANEL32seNEgKXJNevbzgJj0nkyj
         X4dXgvHt4o4LRKz82PJfmHOgV5YHYZQ6v6LdoNelip9goeYpAIU5MmfIWOxDnVIz+RA1
         pQwKxoR9cy5pLKW/QOEErPo0e21v2asgkjyO+9oTSKkIuEzXXTaLXKbQRsbbF1z4G9fR
         XgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0G/lwvclAdLaUj9RTu4KXr/iZDwtkVLlsqgWMxs2trk2dWN4qVEs2Mp2Emcp0hCENKFBMp+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jxi/lOoRAK6x072Vs32b2S8LBWGlSMCcD1afQfVML0u+KlAJ
	NYlwzrhP/pf/YRUaWTsjVhi4Z3RINt0EDTgTkVAD7TtgFXxGJ0PUFRyCFINHa06ILFexOhRD7V+
	f0bT/5m0zpkJwQKKBep0jfqZudLVIgYoOOLqLJIcfg7582+EnolRRMg==
X-Gm-Gg: ASbGncshcZpTL5AjznRwc/7TXRoWccJAh9DrL7pVO0g3zKR3P9d5kjrw04HdT3m4ZZl
	NkI5TvEwk8SAdvXx9qkuTqCfGQsr3TVRMjW+mvdStnJ3kAWcb/wRKC9EqPZXyb0MHT1NNSs9Jko
	695xHwI5ARSlT4P0y6cws9eik6buaUaUIXm9L1keEuIiBdwupi69RZY5UWfxwPvyTjCDIFMg6JS
	qsKSzrY0MG/Awai0jmK2slBEOJ07GBvQSdSk0yqD7IvaouIB9YgsO7QhguZoC1vEc861c0bp8BC
	zYI88mq4lp1SuNI=
X-Received: by 2002:a05:6602:134b:b0:85e:7974:b0ff with SMTP id ca18e2360f4ac-8617cc2c796mr15149939f.3.1744323918873;
        Thu, 10 Apr 2025 15:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQkXdAZ+OEzU4A2DZsacWYyZwm7ExYFaPxcS4RRuyEG/aWoQJVBgD7p6QneavEDnZmQ4ZUXg==
X-Received: by 2002:a05:6602:134b:b0:85e:7974:b0ff with SMTP id ca18e2360f4ac-8617cc2c796mr15148639f.3.1744323918540;
        Thu, 10 Apr 2025 15:25:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2dce4sm941729173.110.2025.04.10.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 15:25:17 -0700 (PDT)
Date: Thu, 10 Apr 2025 16:25:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, David
 Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, Yong He
 <alexyonghe@tencent.com>
Subject: Re: [PATCH 3/7] irqbypass: Take ownership of producer/consumer
 token tracking
Message-ID: <20250410162516.6ebfa8ee.alex.williamson@redhat.com>
In-Reply-To: <Z_hAc3rfMhlyQ9zd@google.com>
References: <20250404211449.1443336-1-seanjc@google.com>
	<20250404211449.1443336-4-seanjc@google.com>
	<20250410152846.184e174f.alex.williamson@redhat.com>
	<Z_hAc3rfMhlyQ9zd@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 15:04:35 -0700
Sean Christopherson <seanjc@google.com> wrote:
> On Thu, Apr 10, 2025, Alex Williamson wrote:
> > The "token" terminology seems a little out of place after all is said
> > and done in this series.    
> 
> Ugh, yeah, good point.  I don't know why I left it as "token".
> 
> > Should it just be an "index" in anticipation of the usage with xarray and
> > changed to an unsigned long?  Or at least s/token/eventfd/ and changed to an
> > eventfd_ctx pointer?  
> 
> My strong vote is for "struct eventfd_ctx *eventfd;"

WFM, thanks,

Alex


