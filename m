Return-Path: <netdev+bounces-224529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F311B85E9A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CF97C3794
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91C2F619B;
	Thu, 18 Sep 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG4pwe58"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAB31195D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211601; cv=none; b=YOKPcImH/OMJ3mN+Ve9bakTSfBzB2syRrEOhm/88zz1AQmV2j3T+1ztKMZ4AyX2VzkW77EXvsTcWUeC4D7l5C7G6tQ41isCuQHxfB9afVroqaf5uJYEFIWqOBK5I6H/gUwgWvv3gWVHuJes6L7mxBbpjBompfMjDCOl18qVeWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211601; c=relaxed/simple;
	bh=P+Wmf0yqfouH3Oi06gJJiikblIWfpXgZcHs/2usguFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkehAlesQMFVKtDXfQhoqs1Ap/qav+syRYlTKkIw0UKHAs8+PJ3NO6S724TLqZ7dHK6dfe1nWg5SNOvyf3BR9pwZ5ikGzMyB2CZF4rlbS2vClkwvfCMBVM9hMYluZdp2Ay/XNSXIRBfWKkQIuL9CmTff5oUk/nC45QD71ie3fUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IG4pwe58; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
	b=IG4pwe5890UhSMVh8eKMNvPwYKV7DfxT9iNyQ+8nlEQ1LJKoEPr67Zjq/udp0TnuSa3mNz
	IBFCkq04U4VCqyPYjzmKeIYQ7C2LuYeqemHP6m/88zZLihR/PJLn9NMzEtqmLBKxqXx4lr
	WX13UFcOA/cv9rscD+15Qb2zrmS2Mu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-s5mRPRIMPayaAAc4lAk1Sg-1; Thu, 18 Sep 2025 12:06:36 -0400
X-MC-Unique: s5mRPRIMPayaAAc4lAk1Sg-1
X-Mimecast-MFC-AGG-ID: s5mRPRIMPayaAAc4lAk1Sg_1758211596
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3eb2c65e0d6so856319f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211595; x=1758816395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
        b=BptIh0swhYryp3eH8a2PSCaHNEiOjTYYqyAiDVYbj9MzaLTy/dLOjayKnmYK8bbnk0
         SJnbwG9x6HTXq5TfU08zLE38Pe8L8JYZk3eX7SM0m+nNLieBUlDiJ+64fHrCDGC5SRgz
         VY4eFuduilnMmCiYYj5hrfuSJr+rVrROwAl2e5Doim6tt3Z9Nf5/aZbMBS3mFSwYUTnX
         7fKUlvrcfWL6iXF2xyRxrfZB4azD5RtgiUV/5CFfofYdlk4DNiYVVbz3lp8dYkIDHQx3
         hKtpapsXlCvw4luzyu/x8fGpckYpmeZEH6U/u8c0IQIqE4ADMPd2yDDsxopsmRKFFpLH
         rjcA==
X-Forwarded-Encrypted: i=1; AJvYcCVwn/j4PCCKmlaGY0OtfrpgKMNpCTIFuFQpuPCfWISTwAHgVWXvTSFz1hSyniYR95aofqUji+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUyi+slnbqFqAGyro/OFdltBaoTbzw2aBbLgfeEQ8pkNCqtuS
	mqiToBiHNfTmnEzk4+RC4Z9QO0V2kq7ITfV/qDXXRVna2c2yONTyxuWuenVZ06+xJmOY4LvTDgF
	w1xU9G9ugWkz+t4QmmCzlsTM+RR7NjQzPgEm8bW3kOG2Z+tFspne3R373owqs83wq+w==
X-Gm-Gg: ASbGncsAwKb0pGhDE8Q+QajPiRPmyFbDw9Noq5ysWlX9d1kztIThcsmNN2qVUow7Lkw
	8cAsK0+rDzxPYLrUTL3PUfallKzQpN7fnUZ1A6QsMLEk4mXm8yPiq9T6DIY2ucYee+AUKl2Scn9
	nTF1CX9Vd1vz4/KAXf/oRthuMsbAqyFaiHi9Q8eaS8cFMLjFX38N18zpMa+0DcwlvCaJ3tzAzWf
	UbqXRFGKGCgVLUVTYZRQKpZCKoFQQxGXFdZFUAgxnTEvWsWze/EikZBLX+H4A8V3JfvmATfGzXZ
	E5l0mOQ/L1EEZSBHFs47MyCIcaJUwzraDuY=
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207934f8f.40.1758211595335;
        Thu, 18 Sep 2025 09:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk3vFxLumDhq+BR9Bo4nIsWcXRAcKMyNyvcVzS+eyg8tV4+vQBxrdk3o5AQ7UyoiyFo7QtNw==
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207900f8f.40.1758211594963;
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7300sm4062735f8f.34.2025.09.18.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:06:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120607-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154826.oUc0cW0Y@linutronix.de>

On Thu, Sep 18, 2025 at 05:48:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > So how about switching to this approach then?
> > Instead of piling up fixes like we seem to do now ...
> > Sean?
> 
> Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Sebastian

Yes please, if Sean can ack it.

-- 
MST


