Return-Path: <netdev+bounces-175672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE5A67121
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BBB3B7D51
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30C2080F6;
	Tue, 18 Mar 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib3c9nwE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3241FF61A
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293415; cv=none; b=Y6rrNuQZ4XxMqOPKwQIep57uKCi4y/VR6USwbaby9kYJB19bhWkGvehk4kM6+oG9XwhJ0q36a8hPxEtbfra2w/lZ+srFAC1FHHF3pCdEuaAFvdYaKLihNITJWjCsntaTKWKZkSxj5OFp6NHpZ2kxmsW3+22eWhy4fyRVrtWkq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293415; c=relaxed/simple;
	bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3WL6YCRI29eRLjin7CnEw9uAdZEBDf0VNUUGO1Ee14+5RujH54/NCtFS+nThX6aWw5XUvMgTUONjZFlVGEOk0dQkmKBbe/GgNZBqR+11NSifKHQ3zcRpZ4W6O7yhxXz8Tu6ctheAM8B2wh9sCmdFi/ElmpG19YT+LcyZ5umAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib3c9nwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742293409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
	b=ib3c9nwELDYrrI292ukohrF9jF8bTR9WFSKpH0hTtv6pkapFYQGXvGr9QOv8dB13rQyGam
	B4pFiRlrzcKLzFbfhAYqhYF4vqqsCxAAjrrav7rgAN7Gu8khCSwj3c5RQUzE+OnAq+HMtL
	VDycQFxW9t3TV34ZJNi+873DxVmQXR4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-pSVuFmE8OUSEc2hNc3bXcQ-1; Tue, 18 Mar 2025 06:23:28 -0400
X-MC-Unique: pSVuFmE8OUSEc2hNc3bXcQ-1
X-Mimecast-MFC-AGG-ID: pSVuFmE8OUSEc2hNc3bXcQ_1742293407
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e6caac1488so6151617a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293407; x=1742898207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
        b=m7uljq3kBF56x+SVbcapwCUCMDsH8MHlZR6iBnms34nCzRfQvJ5m4r9wqDhCYqBNPh
         w32jZR3Zekb+gJMbkpBNL6U7fArKUeguUmAQzu2QawoyP9cmT+26eqe/hnvcPzxJ6xON
         2Cg3MLdxbsIskvoz35dx3EdJgnUwuBgrEaGEt3wYntitg6weOxTLNFvN9CR/V6p4qDia
         CsrqT/mKPhVcCY+NSnVSFDkKplh8243JNsYLlefsN+xMipzqRRD+Dfb55mvOWk71HqHv
         wQSV1gdFFqAHQ09dFbfTwsKIDRU6h9hHawLKKUmacEAoHaWZB4eLSW+D8K6TTlmb7iJK
         mkow==
X-Forwarded-Encrypted: i=1; AJvYcCXfpTYQ8qRuZZ8EOGHgcewRGUaQQcjmDVpTD7gK4X+tpg/AhrENAzbAEqNZABTPBZY4w2XaUho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tZYZLbaCfbv9UauPL9IFPOvPjQAWFsKFxMdojubPLCV3rByB
	ggJ48uKU0NiwupdmRPnB0KI1v9thGwFJx1keKwTAnPb1U9B4WT2STGK68GrDOuCLG27aNKGnBCx
	WUvLCNqqLF4mVJ6BLxwI9z5b3gvHxxSQHBRQaBQoeXRGWkyn95OavuFrQP8KYJIH6/kLZAuwV+G
	uIecbWogHZ26k/CvueSyBV1cx+I4yL
X-Gm-Gg: ASbGncvppVvOlsmhH+0pLLgKucV/yEVdQW1ok5yWjjLecy+EtPKE+pnKYWeV1uebz8o
	DN0y/O7tzyXt25xwqUIuzRRY05zGzQqRPjsur0quvSr5nbMaDwIHhs+cmNs9IxOkFDGZHKgLzSQ
	==
X-Received: by 2002:a05:6402:2746:b0:5e0:4c25:1491 with SMTP id 4fb4d7f45d1cf-5eb1f0003a8mr2755910a12.7.1742293407132;
        Tue, 18 Mar 2025 03:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjyrDRk1usiBEXrUhkwIqs03+nWpkGjuY57aQwx3IT25kzIUISqmC8GAQ0nzFy+hG1pV9t2z5H2wCr9D8rn8k=
X-Received: by 2002:a05:6402:2746:b0:5e0:4c25:1491 with SMTP id
 4fb4d7f45d1cf-5eb1f0003a8mr2755871a12.7.1742293406690; Tue, 18 Mar 2025
 03:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313173707.1492-1-quic_philber@quicinc.com>
 <CAPpAL=we6VkyBXBO2cBiszpGUP5f7QSioQbp6x3YoCqa9qUPRQ@mail.gmail.com> <xogief67mb2wonb7angoypj4ddvvecyrcsnncqitggpij6ssim@fo3psnqqhovp>
In-Reply-To: <xogief67mb2wonb7angoypj4ddvvecyrcsnncqitggpij6ssim@fo3psnqqhovp>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 18 Mar 2025 18:22:49 +0800
X-Gm-Features: AQ5f1JrBFyW8xkFgMxVk6GGg-rvzIxamknFWt0oP1OOTPXdljbsO7bXLrfDxGHk
Message-ID: <CAPpAL=xiQ0x7Vk55of1=-Hm0ijsVQkeLixv65WJc-J0sL9Fnww@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add virtio_rtc module
To: Peter Hilber <quic_philber@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	David Woodhouse <dwmw2@infradead.org>, "Ridoux, Julien" <ridouxj@amazon.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Parav Pandit <parav@nvidia.com>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtio-dev@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:14=E2=80=AFPM Peter Hilber <quic_philber@quicinc.=
com> wrote:
>
> On Tue, Mar 18, 2025 at 10:04:07AM +0800, Lei Yang wrote:
> > QE tested this series of patches v6 with virtio-net regression tests,
> > everything works fine.
> >
> > Tested-by: Lei Yang <leiyang@redhat.com>
> >
>
> Hi Lei,
>
Hi Peter

> thanks for the reply! However, I am not sure which virtio-net regression
> tests you are referring to, and how these tests would be relevant to
> virtio_rtc. The virtio_rtc driver does not have any relation to
> virtio-net ATM. Reusing virtio_rtc within virtio-net has been discussed
> in the past, but not done yet.

First let me introduce the virtio-net tests which include
ping,hotplug/unplug nic device, live migration under stress etc
scenarios. This test was triggered because some of the monitoring
conditions of the CI tool are general. I will change the code later to
avoid similar things happening in the future. Please ignore the last
comment from my side, and sorry for bothering everyone.

Best Regards
Lei
>
> Best regards,
>
> Peter
>


