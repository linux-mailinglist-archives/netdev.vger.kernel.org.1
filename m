Return-Path: <netdev+bounces-74785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E169D862C7D
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00EE1F213B1
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B117FE;
	Sun, 25 Feb 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgjcVYxd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EF1C02
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886199; cv=none; b=ECkr75WgYjd0vDyzVyMW+I+GE3/oeLpA+piRgz5pNv03X59PdbBkSjAVABnlVdrfA1RV2+bJKRr5eJszblIM1zqU9np6iLPn0jNxdaiGl3m1R4EWsyHNeP8yYRM1cHTx6HbydhY4LFkX0CpCdEl6TsPO7Dqi3j4gHP6cxjtaJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886199; c=relaxed/simple;
	bh=9B+2BeOw+n3w20l2b6FqF0v3lMa8shFU5BXeDS8AVPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUryU+EplLBiqGOgyY55Lpu74W5Rt7T67siymjNpvnMbp/wkcklItV1NDPVpC1RuMnaP1PtFvid5+rJLY+nqfmLFmpENxu2u1xl2msbTCclqcn+nQDVWt3GdhIjoJcXxWEGW39pbKH7hqx0+nOrVLS9JNJsCDwhIV5ppy455h0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgjcVYxd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708886196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZEq0diEaLUF4L8U9cR+8C5ZKogp3u8CPnZrw1WiLCo=;
	b=cgjcVYxd7sWbLUvImrBjNNbwxgyITQ+PQZcZ75/EfOew1M729fUBJVAAW0rAzsii/Qp0mm
	3sG9kzdCdcWj+/4JNU6rKRL294u2aZ3chTW5cPzoUwlOiuTJg3SHEaQROMAOXw7F1Jwk/j
	/6R1KL9xoOly101oIeXAUb1erl4V2HY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-1zLZCNxWOlqVXuTKK_s3Bw-1; Sun, 25 Feb 2024 13:36:35 -0500
X-MC-Unique: 1zLZCNxWOlqVXuTKK_s3Bw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d308b0c76so838756f8f.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 10:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708886193; x=1709490993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZEq0diEaLUF4L8U9cR+8C5ZKogp3u8CPnZrw1WiLCo=;
        b=xMRykuPJX2rR+fr95daxc8GKL9dcuiTpc4xi9z8jeVdtE3mhlU/u9Bm3uIOou5tmyd
         qQlc6QumB1c5rl930khzxnSXULJnNO3RPrKo3GjwNfwJpDtt/tPQ3/HULFiUmVIjJpwl
         vjkUro2Y7GzQgywaPBJO0SbzbWLfwap3O0Wk4eEu+h9FqWNPT9HtsncYCXt9FH8Gcm/4
         m1N80d14CnJOPeeV5g9n7Asdv4OBl2/e9qrAkmdtLPKEjpdelAUQG54T7FZSjanXKMyh
         Mbgw36yR/BAuyccxhr7pm4G0v5qBxx2QE8dzj18vifhUxLXtVwpsKtYRyegXIKtTv/Md
         fghg==
X-Forwarded-Encrypted: i=1; AJvYcCV31+TKxSRFeeEZSPdRwZfmKvwMajaTShRNVmZ13Mj0UGrRlMrPzPPU0F6Vv4zLQCzR3g3ecORFDjJvDoe4eGRfBF0WSiSm
X-Gm-Message-State: AOJu0YwiyKsFRQ+MTSJDBaxQtBPefSClMzy450iFB305/50zPc/vsoL6
	JTQwTZPbahYcGPeheLScEMzQ+khJSxAUssgdUG/VYOlhVY78YREw62Sk75aEYV0i3twTh9s+hdt
	vuy6H/91CpdHjAKJLumBDpfblDEBG/UcZ+FEr1DM9K3PewkUSaAVV4Q==
X-Received: by 2002:a5d:6d82:0:b0:33d:c0c3:fe08 with SMTP id l2-20020a5d6d82000000b0033dc0c3fe08mr4137538wrs.0.1708886193205;
        Sun, 25 Feb 2024 10:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF48RkT7VwPXQKidMZjToD5EORG8LIwxMKogbRe3FaAeiUlI05OowCGgS44cLU+s/JBPA6qxw==
X-Received: by 2002:a5d:6d82:0:b0:33d:c0c3:fe08 with SMTP id l2-20020a5d6d82000000b0033dc0c3fe08mr4137523wrs.0.1708886192781;
        Sun, 25 Feb 2024 10:36:32 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600016cb00b0033dda17f5b6sm142761wrf.115.2024.02.25.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 10:36:31 -0800 (PST)
Date: Sun, 25 Feb 2024 13:36:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Taht <dave.taht@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, hengqi@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: Re: virtio-net + BQL
Message-ID: <20240225133416-mutt-send-email-mst@kernel.org>
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>

On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> On Fri, Feb 23, 2024 at 3:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Hi Dave,
> >
> > We study the BQL recently.
> >
> > For virtio-net, the skb orphan mode is the problem for the BQL. But now, we have
> > netdim, maybe it is time for a change. @Heng is working for the netdim.
> >
> > But the performance number from https://lwn.net/Articles/469652/ has not appeal
> > to me.
> >
> > The below number is good, but that just work when the nic is busy.
> >
> >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> >         BQL, tso on: 156-194K bytes in queue, 535 tps
> 
> That is data from 2011 against a gbit interface. Each of those BQL
> queues is additive.
> 
> > Or I miss something.
> 
> What I see nowadays is 16+Mbytes vanishing into ring buffers and
> affecting packet pacing, and fair queue and QoS behaviors. Certainly
> my own efforts with eBPF and LibreQos are helping observability here,
> but it seems to me that the virtualized stack is not getting enough
> pushback from the underlying cloudy driver - be it this one, or nitro.
> Most of the time the packet shaping seems to take place in the cloud
> network or driver on a per-vm basis.
> 
> I know that adding BQL to virtio has been tried before, and I keep
> hoping it gets tried again,
> measuring latency under load.
> 
> BQL has sprouted some new latency issues since 2011 given the enormous
> number of hardware queues exposed which I talked about a bit in my
> netdevconf talk here:
> 
> https://www.youtube.com/watch?v=rWnb543Sdk8&t=2603s
> 
> I am also interested in how similar AI workloads are to the infamous
> rrul test in a virtualized environment also.
> 
> There is also AFAP thinking mis-understood-  with a really
> mind-bogglingly-wrong application of it documented over here, where
> 15ms of delay in the stack is considered good.
> 
> https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141
> 
> So my overall concern is a bit broader than "just add bql", but in
> other drivers, it was only 6 lines of code....
> 
> > Thanks.
> >
> 
> 

It is less BQL it is more TCP small queues which do not
seem to work well when your kernel isn't running part of the
time because hypervisor scheduled it out. wireless has some
of the same problem with huge variance in latency unrelated
to load and IIRC worked around that by
tuning socket queue size slightly differently.



-- 
MST


