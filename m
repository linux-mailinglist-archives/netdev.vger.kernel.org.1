Return-Path: <netdev+bounces-105004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430490F6DB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ADF1C23C83
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C726158D8E;
	Wed, 19 Jun 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihorPu++"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D8158D69
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824677; cv=none; b=ioo4kpRXeJ+ej6rne+P1dt5kM7GyMBR2sAaKmfIQXZspmbTnJ9LFznm83s3grKDSoZaxxdOso9Y9EgFlzCtfpb/q7x9yOs/3VijNS0A6mAijJ7XWa3kTH9LJlAK8mvSYOeMFB4l75SJfg8fx5ubhkRzzW2ZA4gNnNsvLGpDWnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824677; c=relaxed/simple;
	bh=Uj49eKs4/aH/vQGPqOYhUBo+DBjEjfaEUa8IPmvAz3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJQDP2jok1EJcC4AFNN3ij+j7HJ3Ks0tC+i+YYQMJbZqTLdY1429ESncriw7Mn9oAfrJgZChbVrn0iwnSMeHPgpc3z8bisnye2fsIlXgDr3TeBZOJRI4kVDMI0r/HbyBXVvRUsGYuIYxBe9v483e2+eym6QMNbZQux/iVKLcBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihorPu++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718824673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9dreDaHw4LwDZpQses9LLZsOKK/RpMulbBO3lTSR94=;
	b=ihorPu++K+agr19KSBgSk2yGgRir6AflUg2v4nf9G9vCIAb58MHX6iC15kxI2x/MEVE5Ob
	xi7rYgSVngqCh/FPrjv7an/RIXBsboe4NampZCh8Mwf9RbqqY6GKfPG+oddzPV7DJmQE7F
	4kVX38B5NEeWj3r8wEu6DrfWq8Cdfd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-D4WIx6knMxGm5MuVw0ab2Q-1; Wed, 19 Jun 2024 15:17:52 -0400
X-MC-Unique: D4WIx6knMxGm5MuVw0ab2Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-363520c91b1so59099f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824671; x=1719429471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dreDaHw4LwDZpQses9LLZsOKK/RpMulbBO3lTSR94=;
        b=SKH1I9Z/ZlEcNsllekQZGt0asQWSTNA2cP3ntVG5JeB7MH7Po9GTlFVCYwMyef0hak
         1AfaYJs4QJPhtcagbA3BNd0iVPFhhZKavdDrvBqajW1ZtXVsktzRu5A8cPlkW929lF6p
         7VFBESXIlE0CBgxD7t7FctCrCoGPBkVPsACgYWPFh6qpbAQk5T4RUYA+wsnHAAZoYxim
         0v+hQQ6i24LV3xLhYPeYyZgRTGKhCijUTPetfAifATSZ0DRBfrsGe/zNDqIdZD69oL7i
         zO8VfLImExAemIJOcFJrhgwiMLTiUd68uhB+s5Ydm6DLGJPvEHpDHgSkhhkDP7xFB6ZK
         9gUw==
X-Forwarded-Encrypted: i=1; AJvYcCWAnP0JnUhtWWdPsno2PykPx2ltRZcRJNxC+Rguo8bEta5J//7H7b0AgNd39eR6wOI+uurEYxRYbC3z/HFHr4tFi501McPy
X-Gm-Message-State: AOJu0Yw+1kZ9ws7njz5xBYGwpmaCZHdfKxrIyQ8FwNBEaJm0XPhoz/Ug
	PI5eYOO6GsY0AObo5anOHMBioPZxf5ZmokEiRIHjFlXDXn1m7A5weu70nQMn3T73Tjl3SgcBX3S
	wxxlZpyK2wNHvQGnRdGEnN0MmVBZhPqi7EV7JYRSYP8549ipjDEJtrw==
X-Received: by 2002:adf:cc8f:0:b0:35f:d57:a698 with SMTP id ffacd0b85a97d-36317c79b07mr2511323f8f.31.1718824671390;
        Wed, 19 Jun 2024 12:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFryhNHxXPqBrlUMjzD7Unl9K0r0EjIW5NugD/ywGyBorAkR0U593R+b5+gKho57fKeTx5fEw==
X-Received: by 2002:adf:cc8f:0:b0:35f:d57:a698 with SMTP id ffacd0b85a97d-36317c79b07mr2511310f8f.31.1718824670912;
        Wed, 19 Jun 2024 12:17:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm277768855e9.7.2024.06.19.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:17:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6CA841386124; Wed, 19 Jun 2024 21:17:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Sebastiano Miano
 <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Samuel Dobron <sdobron@redhat.com>
Subject: Re: XDP Performance Regression in recent kernel versions
In-Reply-To: <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 19 Jun 2024 21:17:49 +0200
Message-ID: <87wmmkn3mq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 18/06/2024 17.28, Sebastiano Miano wrote:
>> Hi folks,
>> 
>> I have been conducting some basic experiments with XDP and have
>> observed a significant performance regression in recent kernel
>> versions compared to v5.15.
>> 
>> My setup is the following:
>> - Hardware: Two machines connected back-to-back with 100G Mellanox
>> ConnectX-6 Dx.
>> - DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
>> - Software: xdp-bench program from [1] running on the DUT in both DROP
>> and TX modes.
>> - Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
>> flow at ~130Mpps.
>> - Tests: Single core, HT disabled
>> 
>> Results:
>> 
>> Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
>> 5.15                      30Mpps               16.1Mpps
>> 6.2                       21.3Mpps             14.1Mpps
>> 6.5                       19.9Mpps              8.6Mpps
>> bpf-next (6.10-rc2)       22.1Mpps              9.2Mpps
>> 
>
> Around when I left Red Hat there were a project with [LNST] that used
> xdp-bench for tracking and finding regressions like this.
>
> Perhaps Toke can enlighten us, if that project have caught similar 
> regressions?
>
> [LNST] https://github.com/LNST-project/lnst

Yes, actually, we have! Here's the bugzilla for it:
https://bugzilla.redhat.com/show_bug.cgi?id=2270408

I'm on PTO for the rest of this week, but adding Samuel who ran the
tests to Cc, he should be able to provide more information if needed.

-Toke


