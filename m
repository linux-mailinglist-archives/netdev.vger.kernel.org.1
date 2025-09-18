Return-Path: <netdev+bounces-224531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D084B85EC2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA310188C302
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E13112C2;
	Thu, 18 Sep 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0+V8rjS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBB21B9C8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211959; cv=none; b=XDIOnibGxPLB6OL11qaEZ/yggZJ/CUhgZbZeXNrUiUIATDGRC67IIQJ3raAym25q6C241qQ96wnwtevc2BtTbdJKxmXxhFuaJwJWysbEwyzaricX10qU8/PrXVnDSvKgVebFxyWlv7dKOa3DCLlDqiVy9sT2r5V1i40S8nrekBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211959; c=relaxed/simple;
	bh=3ChuK9dLT+j/JKhhXXw790DwdOdULGToKTA4biGxyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF3qaKLsDIx0gQSifAVJSrP3mE7Rv6aJQj8EK22GjNbzD+noDE1eFAys9n54Q8C3ORQv4elq5z/uO0iXI/0dY5GMX2ooWTPGnGtakp5OHzw5w6fTWHqPS5BxCoHWAlDVODa6cLkF4ltLd4fIO1GsNEk20C3bCKVxb7C8iyt1vAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0+V8rjS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
	b=N0+V8rjSNpNPPLUn+zBSQhuZwsO/f9PZI28D/a6NJzH7IyXJrHRJaw1P3n0TAoqLwSY8Bf
	3W23I/xVyTESXbdN0LcjVCWmEIDuSXbHhaQxk1DkQG1Lo/j+fy3ylenaHYB2NLy3ywJyph
	qVjBa96QDbMwU7MZa1dkXSdSnNsmIdY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-sTK65XSnMNKltkQS1BxMBw-1; Thu, 18 Sep 2025 12:12:34 -0400
X-MC-Unique: sTK65XSnMNKltkQS1BxMBw-1
X-Mimecast-MFC-AGG-ID: sTK65XSnMNKltkQS1BxMBw_1758211953
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ea1550f175so541759f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211953; x=1758816753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
        b=SnVIZ6lEzD1YV/owmB0uQ6fpcCXVApvTxcA4Q/x7hZ2xqQYIsiXhRAmM85ROH1O0JY
         8XzjFkDy64FwitKbRFQlwJWLoNDSnc2kA3ZQNsHmnxFn0vVToWsxGVUTNpw6/7my7QuZ
         CY5ewHSSWlU5GHQjGi58IYiSepdMpb+9Q3rDm9kQCGnjS1v89KoSgJJCclFNlrO7obAm
         ddoDDgAXCOz7rLGSoJeNBDZMxTTGzM/mU65zAgYJwL9vM86gLm3d/Xh+RKzpz1sRVoUA
         Eiy41AaX+UBuPtON14yp5i0j7vPDXXK0AhP8rYT5LGnfi22chvC7GPWYhlxjj+eAfnvz
         Eraw==
X-Forwarded-Encrypted: i=1; AJvYcCVHWPGhFhy+Y9peO+gRxlJ7O5Ou8sQ4zviowAOE9+Tbqa3ZT9Guu4UakS7efl7KVlSpOiGYDS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOFEkm8iNsarNQfJDPvetnND5Z0vUbF70uAGxsmdfgMwzvHD4
	rLLD0z46Us7cQyOtQY0Tn2vTVFupQOrjnt75qUl57MCwNxyHQ4eHFwX4OIxyFB5llYedLL4em7A
	zhRNVeeNN2Z7+dvq1pwGNNOx7Pyckst33xzhT/Fp0TnWQ+WXX3HuqTKYO5Q==
X-Gm-Gg: ASbGncsfoGeR8yqZ6R00HunTY9CxbKIJTK00POfD5gqquxxUfU+omHGW1sdj97j/lyL
	vddpEbXclYfHRYb+vPP6V16uW3y/TJptYjxod3IgZq/rxfR6dM+Xy5u6ibpm5ounVRRBJm/hlvu
	gC29K+6ROWTuP7pWhwl5MDGQgCJvZGQZytJOGWUSAJ3YlVdg825pqNaTl91uL8yqriftbAAjsJz
	Tl9J3fPwRgqrZYehF01qRBjf+Y5JfRakfc7v7qPHjC+H5npypdB1SUjmRcakCya1JFfmB7cHAsE
	Jo0UfXqeUnSDo/idt5AcXAsplR2MZMkDNQg=
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499611f8f.55.1758211953354;
        Thu, 18 Sep 2025 09:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQNjD7OmqbUX0lKdSCUxk8S1FFLIR2TIUSd05xm5nCE+NLCdpN93A3STkA7r0Jij+RWM8oVA==
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499570f8f.55.1758211952931;
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm4389523f8f.18.2025.09.18.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:12:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com,
	ashwini@wisig.com, hi@alyssa.is, maxbr@linux.ibm.com,
	zhangjiao2@cmss.chinamobile.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121009-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
 <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>

On Thu, Sep 18, 2025 at 05:45:05PM +0200, Filip Hejsek wrote:
> On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> > Most notably this reverts a virtio console
> > change since we made it without considering compatibility
> > sufficiently.
> 
> It seems that we are not in agreement about whether it should be
> reverted or not. I think it should depend on whether the virtio spec
> maintainers are willing to change it to agree with the Linux
> implementation. I was under the impression that they aren't.

Ugh. OK I guess I'll drop this one too then.
That leaves nothing relevant for this pull request.


> I will quote some conversation from the patch thread.
> 
> Maximilian Immanuel Brandtner wrote:
> > On a related note, during the initial discussion of this changing the
> > virtio spec was proposed as well (as can be read from the commit mgs),
> > however at the time on the viritio mailing list people were resistent
> > to the idea of changing the virtio spec to conform to the kernel
> > implementation.
> > I don't really care if this discrepancy is fixed one way or the other,
> > but it should most definitely be fixed.
> 
> I wrote:
> > I'm of the same opinion, but if it is fixed on the kernel side, then
> > (assuming no device implementation with the wrong order exists) I think
> > maybe the fix should be backported to all widely used kernels. It seems
> > that the patch hasn't been backported to the longterm kernels [1],
> > which I think Debian kernels are based on.
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/char/virtio_console.c?h=v6.12.47
> 
> Maximilian Immanuel Brandtner wrote:
> > Then I guess the patch-set should be backported
> 
> After that, I sent a backport request to stable@. Maybe I should have
> waited some more time before doing that.
> 
> Anyway, I don't care which way this dilemma will be resolved, but the
> discussion is currently scattered among too many places and it's hard
> to determine what the consensus is.
> 
> Best regards,
> Filip Hejsek


