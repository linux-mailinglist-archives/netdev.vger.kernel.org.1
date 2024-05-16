Return-Path: <netdev+bounces-96673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701368C710D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 06:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940181C22AD2
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145D208D6;
	Thu, 16 May 2024 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJHpKd+r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714514AB4
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834950; cv=none; b=Ezq/MuYEmVuOY9KaHdVXgiFHIQkYb4K/L1VnFbxz7KSVozPew0c+NP+LQy1vS5ZjpkkyAS7Ou3bgpYmyjRMvGmtC764YhPRUZecvB5NrYmQeuBSGCilNEk1huAlffrDJOZznyLun3rjofMR1q+3vImBTUtHTRXtTn2V8C9IBcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834950; c=relaxed/simple;
	bh=qLZDBF5EWCwproRuemf57u8gvHVkIMpQFM7Cuf8J1rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agLyxh6vWQo08EKYjAM/dqwvZuE+P6zQoX8nepe3rU8Exvb9B2Mr3G/UFU7KQDq8+yVCC1CpDFgzUjX+Y3JhCYQEcstL2LxDigr+9RvT52HjLgLYUHHbnVxknMwlG2yMn3sA1JeoBWPcyUrhDS43ctOoK/k7Eg/2tCRcfRmvgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJHpKd+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715834947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXGIN3lTx6JmVu73hytVZe24/+ZGwq7tQPSepFAG6Ps=;
	b=GJHpKd+r9bjxFiTOGQC7tkZJcGFmP+yvMyYQp2cRmM/m8/67VdnyCBPAQGESR8NpT8MKwh
	j6ZMiDxRb9gFpQBi064cXpVStVtm2ObsT5n/Vnh82UKj+LhlIEwdVuy7nxRWZI/C2S95Ti
	2KQe6l77NzRKbEk4TIfRIXBAgrDMpBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-iPL5EoawOgaBUtuH-kBnug-1; Thu, 16 May 2024 00:48:51 -0400
X-MC-Unique: iPL5EoawOgaBUtuH-kBnug-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b6215bcdf2so7280983a91.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834930; x=1716439730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXGIN3lTx6JmVu73hytVZe24/+ZGwq7tQPSepFAG6Ps=;
        b=iU4uptzOHF4jN9KtPxEpQ1oOOYmVIAXbJwGsfo0l2Eb8+5oH+fRdl8sQaSoKboanaN
         aVGZrZ0rCKfWFHytOsJEFZ3yPr4EW3YkRo9xPxDspxE7SGTuqGVmqnx0244KLhcPc1oD
         yAkWT9Qmnn6liwBd+pgsxvObSI63upvhbyKZkbLMmM0/tdj4/PXnZdG79FA56Fss9O0Z
         MyN3C8N29cBVXERnbNHVzN5SRPKEBH0EoUc/Skmt9dh+keeWcruWVVtnInK9Isz+6mVp
         acqSYkFeHhkDHaB4qk3qsz6LWAnxBJryoy+08zYaBXM4c4g0NZIqDBIKVZsj0BzcCKUs
         IU2A==
X-Forwarded-Encrypted: i=1; AJvYcCUr2c15EZnet4X0SvibjvBmc6AmFnnYo19ZzK4zp309wjCZ3vrK4q5Z7eTjRyjCIwcSKWDbf4zdXQR9YYSxO1qqEg47F+xA
X-Gm-Message-State: AOJu0YwFoHgRiye/wqu4IdOzuhZ+DfBLUbLFYe8QeJ/Krl5kcvsNMk6t
	w0CAyrzmJqMll997SFTuT5S0Z8tPYBAfv3Nvr5FKy6WqtKS5N7L+bqGw0gL4aJq3XzwDcV39iYZ
	zdpkacNd0Ijzg0R6RmhmDDQkUHrziyGbv/gihVigy1MlkkPU1UJSwGM68dSKsl9nZM4E03fWh98
	lCOQFG/F27KTb37ns8ANBhS7rDCrRW
X-Received: by 2002:a17:90b:124b:b0:2ad:af1c:4fc with SMTP id 98e67ed59e1d1-2b6cc76d23fmr15154538a91.25.1715834929986;
        Wed, 15 May 2024 21:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4IRfRXIFfQnuhk3r7xQUPBRdzs0tIxWZqixotZ5qq8Y2oueZ43GZWpesIXvDQS/HD/Dky6THvLmhbN3MZsuU=
X-Received: by 2002:a17:90b:124b:b0:2ad:af1c:4fc with SMTP id
 98e67ed59e1d1-2b6cc76d23fmr15154527a91.25.1715834929585; Wed, 15 May 2024
 21:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion> <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion> <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion> <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion> <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion> <ZkSwbaA74z1QwwJz@nanopsycho.orion>
In-Reply-To: <ZkSwbaA74z1QwwJz@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 12:48:38 +0800
Message-ID: <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 8:54=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >>> >> >> >> >>
> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
> >>> >> >> >> >>
> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >>> >> >> >> >
> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
> >>> >> >> >> >Thanks!
> >>> >> >> >>
> >>> >> >> >> More info about the BQL in general is here:
> >>> >> >> >> https://lwn.net/Articles/469652/
> >>> >> >> >
> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in th=
e past
> >>> >> >> >mostly I got the feedback from net core maintainers that it li=
kely won't
> >>> >> >> >benefit virtio.
> >>> >> >>
> >>> >> >> Do you have some link to that, or is it this thread:
> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e=
1bc3@redhat.com/
> >>> >> >
> >>> >> >
> >>> >> >A quick search on lore turned up this, for example:
> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@=
gmail.com/
> >>> >>
> >>> >> Says:
> >>> >> "Note that NIC with many TX queues make BQL almost useless, only a=
dding extra
> >>> >>  overhead."
> >>> >>
> >>> >> But virtio can have one tx queue, I guess that could be quite comm=
on
> >>> >> configuration in lot of deployments.
> >>> >
> >>> >Not sure we should worry about performance for these though.
> >>> >What I am saying is this should come with some benchmarking
> >>> >results.
> >>>
> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
> >>> queue pair:
> >>>
> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
> >>>
> >>> RR result with no bql:
> >>> 29.95
> >>> 32.74
> >>> 28.77
> >>>
> >>> RR result with bql:
> >>> 222.98
> >>> 159.81
> >>> 197.88
> >>>
> >>
> >>Okay. And on the other hand, any measureable degradation with
> >>multiqueue and when testing throughput?
> >
> >With multiqueue it depends if the flows hits the same queue or not. If
> >they do, the same results will likely be shown.
>
> RR 1q, w/o bql:
> 29.95
> 32.74
> 28.77
>
> RR 1q, with bql:
> 222.98
> 159.81
> 197.88
>
> RR 4q, w/o bql:
> 355.82
> 364.58
> 233.47
>
> RR 4q, with bql:
> 371.19
> 255.93
> 337.77
>
> So answer to your question is: "no measurable degradation with 4
> queues".

Thanks but I think we also need benchmarks in cases other than vDPA.
For example, a simple virtualization setup.


