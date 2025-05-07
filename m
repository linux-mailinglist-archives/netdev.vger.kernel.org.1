Return-Path: <netdev+bounces-188741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22862AAE671
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A84980C8E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D928CF5B;
	Wed,  7 May 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H61aVhr6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020D28C2A5
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634713; cv=none; b=ZjBHoqtQpniVlFcjYbFPpkpJqRJ0SKJU60tX8SakbaxDqKJ+uGJP2FQp04SX0uDlne9KwD5X+ufgBfaEjMkD5GMYNnSA4K8aLlPfNI1FodYzPhqxe/dfO376tdAxx/FllUIPTgXOFpxdn/56vX7s55VZgB6qi93iaF6glx0A6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634713; c=relaxed/simple;
	bh=bWVXWi6FNTmsC6XQcQl5QLoeoLqMPPpdOvDyzqsEHVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hod0fAufeiEqyLN+EJqzerZa4gMeEYXGcQOaZPrbnTDPLuNMtB1B4R5SKTdiSDyg8Q8QVBmURSvQmsaV+GdwH0//IiBMdL+PCJuHxkp1XS1WZKIGnJkyqqB1cv2BLqER1JWNvBDvPO7gh2if16BZmZ3yuxJZ0S9vP11uZKaWbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H61aVhr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746634707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39nLFDBfyFezv/758tbb1M4Ol4SxY7Fer6M45n6qLAM=;
	b=H61aVhr6a4C06legg8oIs6BV5Oy10L0zbDMeDORlpI7EYjmpb3brmVXCkQmnkuY0F9T2+b
	O31b3r2HB2q/5zalnpzLSSdsGob1yCmSaMSNpQUnQW4I5V87+X6jkdP0Ub0fSbYi737D85
	ZWlmN0A/gGTCy0aAPn7nSGfpjgT1KDo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269--KbgfGn7NiGFQ4RXHAXHMw-1; Wed, 07 May 2025 12:18:26 -0400
X-MC-Unique: -KbgfGn7NiGFQ4RXHAXHMw-1
X-Mimecast-MFC-AGG-ID: -KbgfGn7NiGFQ4RXHAXHMw_1746634705
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acbbb00099eso604020466b.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 09:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634705; x=1747239505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39nLFDBfyFezv/758tbb1M4Ol4SxY7Fer6M45n6qLAM=;
        b=mrIBFnp6vNgIyJkOkqR8gKjU3a5/+1Ku6IJB68zdlGEy38E0u3JwGfMI808tUN9y9U
         Ug6hpHQ0ck00A6AAlQKyHedsHdQXnm/X6ERplGIJuq6/Nw1aZABnrcSBQoB0e+peEUfU
         nZ3SSMgDpYAOTj+8jeJIINAfbyhjhsB0DoYzTpjnJFeWKW1wK7K+xh2QD6cX5D1vlATH
         h2uqUFXYiEkhYSmRuXHTMCLOHl+w+ZIgIYqG5lGNMf5QPAPQcoIeTDCgO78ukho9vbSg
         K3qb10PnC7WEI2KefGnjmyC8wXTDISv4EDH/vnK9GzqYYjKWoNIbzHsgobPCXrx9frp2
         D4UA==
X-Forwarded-Encrypted: i=1; AJvYcCUps/B4WkXYTduajb5MT6YtxVLWYIt46t5H1IspMbAjDZz8AK/bEjs735EkNQYl2b6R/pLKcOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYQmM6T/3IZGF4QTIr4FCXOxz11roALKjI5YQl+HvlfQHgkhP
	vLGe8uxGs4xU6YU2ajMnAHOnSiBRxMeeHCSvFXtEMiNSXW2nxbPJHkDmNR6wK9GgF8u/1jgezqm
	K+lSRpX0lElNRI4avo4ga2mZsEWx8rrAZ6Jd3xM0YloFJgHzIyNNWnQ==
X-Gm-Gg: ASbGncubrrERA5b3G2wOt4wRD/B5wrBVRums15ROPrsZej6QoFhBRb6u2ODfkQxwkXL
	WdWwrIUxSTAQfvnrU4bdDHMOMxEbYZTwYl627uCExLfl+Ml88a5LWF9/nK2wtm85jPJHhI0fYUB
	EKGhVP4Ao109Pl4LGONTf6PcC2j1v596NZ0DXJlvfeWRvl9y88TuI/kgSc8Nab4J0m14Ge/vxFE
	P89u/FgqFj6Xd8/reFjw5zenoY7Q0I4uYUlmD6YzI5FQDpAHXBNd246PfrZ0iLCrhZlMB2i0rlN
	1wT2jXYq3Fvh55xy
X-Received: by 2002:a17:906:6a21:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ad1e8bf2298mr431573566b.27.1746634705136;
        Wed, 07 May 2025 09:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcpsNEPHJMDyuwXMw9YaT6C3LUO/0nHh1kX9E1tgCGACOK+8BvvpnBj9Yg4yGqdZN/AhWgIA==
X-Received: by 2002:a17:906:6a21:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ad1e8bf2298mr431569666b.27.1746634704432;
        Wed, 07 May 2025 09:18:24 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.183.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891e980bsm920838266b.76.2025.05.07.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:18:23 -0700 (PDT)
Date: Wed, 7 May 2025 18:18:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
Message-ID: <CAGxU2F5XeRs+4Fwrf_LhOjhjxaWOocpZDQanOc+mcDyPFRHCfQ@mail.gmail.com>
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
 <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
 <689ab62a-7800-497d-a9a6-3a81e256f98d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689ab62a-7800-497d-a9a6-3a81e256f98d@linux.ibm.com>

On Wed, 7 May 2025 at 18:01, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> On 07-May-25 10:41, Stefano Garzarella wrote:
> > On Wed, 7 May 2025 at 17:15, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >>
> >> These tests:
> >>      "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
> >>      "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> >> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
> >>
> >> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> >> have been received by the other side. However, sometimes there is a delay
> >> in updating this "unsent bytes" counter, and the test fails even though
> >> the counter properly goes to 0 several milliseconds later.
> >>
> >> The delay occurs in the kernel because the used buffer notification
> >> callback virtio_vsock_tx_done(), called upon receipt of the data by the
> >> other side, doesn't update the counter itself. It delegates that to
> >> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
> >> more than the test expects.
> >>
> >> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
> >>
> >> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> >> ---
> >> Changes in v2:
> >>   - Use timeout_check() to end polling, instead of counting iterations.
> >
> > Why removing the sleep?
>
> I just imagined that whoever uses SIOCOUTQ might want to repeat it
> without a delay, so why not do it, it's a test. Is there a reason to
> insert a sleep?
>

Okay, now that I think back on it, it's the same thing I thought of when 
I did this.

I guess in v1 the sleep was just to limit the number of cycles.

LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>



