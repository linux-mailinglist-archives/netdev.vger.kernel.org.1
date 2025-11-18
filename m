Return-Path: <netdev+bounces-239582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE8CC69EA3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCC184FA847
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD783559F7;
	Tue, 18 Nov 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nne+YwCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFF347BA3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475210; cv=none; b=qaSbeuWzBt+O3/6NxlQ60jd8UPgLbvMiFmUOWRiEEXtDOjp7LXP7FoH1O7OCuB2dDnhW1hywiUPArSKl/sqwdcQM3uKTIfgQeLIn9jXur+2xUUom04z70nZCaJO5dGPQG7tphugwU5Roi8FrfUkarfrLbEi2vbulhamMjHkOwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475210; c=relaxed/simple;
	bh=HQUBK4MNv/SXU5ezJKyox6AQ7/NM49FiMg7jsCvMZ/w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xf7pG06NwcdRG21vti6uYd7bbm1dCmlk7rzz+pAIhBEibqpazYXQByORDNAGK0H32PduPYZnwNXHKfnr6IU/wl8+nVuDD4TWIJTXB2NZOVvVySwECSUWao76CQBvlYuzXFEUulf3pN524fT/x6fOQpZTWHE50fjUgfU82ldFmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nne+YwCX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d71bcab69so47482047b3.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475208; x=1764080008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLS+ljDA3ONh+IzG9dzAki9ZmyxqZdSzP94WFziG0+w=;
        b=nne+YwCXQJbCRSPxb7g47EXQNrwVa/g6KwH53yc+Ji0W/sw7fvDDfCwrEsSzkesDAa
         ekC9whtGVoYrx8fCDz0emKaz/r7RUr3aJzZcsvgVpPJcDgvVpwPGY2BQMuVMTR4hCsEN
         GNhFEYojo+lAVp4KRinKyMdthR9kK2c4hLgFGsTsZ2d69w9CPbJyBGzr0Wi4U2web9hI
         KjsGw/2XDs4Y4DyrAs7l1cQAgFawkGHqzhRs3F94mc2ms/I+mcsiY/Qek3vENIqIXFTh
         HcedXW5MoXi4XCzzh1VtwS5Jpl5P2c7Ce5Jtez0+9jouX2zqm/pYutElFsFf0aqw8fFc
         mriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475208; x=1764080008;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLS+ljDA3ONh+IzG9dzAki9ZmyxqZdSzP94WFziG0+w=;
        b=ihAzzjTfUlGVZZyOV+Fd0vEC07gH8GoN1heu6DSHuxaBUfgiDTqLr0NgiFleqM6Em8
         pre/iqAjknGLHfq9CRX02sUf2XUj2xcMqfrKz0CoO09UpbBv526lhBVN7fgTZnXt/Kjt
         EldhrVsvmJhqA+MviGKosZCbIABNwvOrWPwVjZLaBLns8z7QwgNFCSBeEJMSom6tiox3
         3BazAmgUPcZPxO+UV6shCuF408T4Fs9BsXxTOEBTK/EmICO0kto9nhFkuusm91+pAdCv
         iJikep9QZf0Y86PpKcmRp7EfbKKnBSwRsBp3u7Bm4ZHfTnnk336JBE2m+Ag6/wZILPra
         6AXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4rZjrmMvBISLT81kGVzDIDfLESnI4ePUsjeOq0UKW3LB8i1KJzwOs9ChGGrdaXZ7to5ivobg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AA5ey9xgXKmuUc4BwsXgcvUbNB4bIoh6r6UpqeqV2X+seeOw
	biQdoTzvZ9n6rOqs/jGof4hj8tp/sWOtj+O9BkiHVJOB//8CKqZGKOmc
X-Gm-Gg: ASbGnctAZK9kbbV0e0xTrSjPWu35AQGU+4AN1vnF0Z7OKtJQMMSil9Q6gAnIatPjf9I
	8NBFSQzjVaNEvZZAlRmXG/yhX9XkinmMNkeNIqWHrARQZxN2fqXZOvvdSrEWVKq/K3FXzd3xum0
	ZrRRzoXEz8+7HBqK51in+gRu7gFuifFR4lkwevb4YsiYT2acd/efIrzpsjeKPcDsKCl+/Iiy5qc
	B8BvMEER5lMt4dORg5Yp0QVBMu1xmUDjb1jwEpLB+9LUkOwSF0Z4XQQ9deeYcujas48R/rCeH3Z
	EeDiSaX8oAe2PA3/LocLTGFECVxOR6w4mpbA1b7pWPnWOIWpcQOiggmJs3xglsF5lj9KEytsEIj
	3IIWQnFzTAo2xY16moOL0s1T1d7XnIEYJnjFwRcZiYjQR6lT/gEzp30dlWGhyvSalnAJxuGALNz
	E9BDrvNGFfFI7AuuqIHtTX3tOnUauroJ7cVL/9B8u7OwmBSfWfO+vkoSOdzOf/TK3Y7+g=
X-Google-Smtp-Source: AGHT+IHgSy/PQp+8usU/2GA+MvxgTlVGrnZkbhS6n3nlE+QkTkTY7hmkNE9CD+jFUePzw0+lAB/nZw==
X-Received: by 2002:a05:690c:25c8:b0:787:c849:6544 with SMTP id 00721157ae682-78929e2580amr155150137b3.5.1763475208112;
        Tue, 18 Nov 2025 06:13:28 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7882216723csm53160337b3.50.2025.11.18.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:13:27 -0800 (PST)
Date: Tue, 18 Nov 2025 09:13:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24bd73d3718ec@gmail.com>
In-Reply-To: <20251117205609.4b0fa035@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <willemdebruijn.kernel.31c286e47985d@gmail.com>
 <20251117205609.4b0fa035@kernel.org>
Subject: Re: [PATCH net-next 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 17 Nov 2025 21:11:31 -0500 Willem de Bruijn wrote:
> > > Note that neither GRO nor the Toeplitz test fully passes for me on
> > > any HW I have access to. But this is unrelated to the conversion.  
> > 
> > You observed the same failures with the old and new tests? Are they
> > deterministic failures or flakes.
> 
> Deterministic for Toeplitz - all NICs I have calculate the Rx 
> hash the same as the test for at least one of traffic types. 
> But none of them exactly as the test is expecting.
> One IIRC also uses non-standard RSS indir table pattern by default.
> The indirection table will be a trivial fix.

Ugh yes we've had a bug open for ages internally to add indirection
table parsing to the test:

    The (upstream) RSS test is too simplistic: it calculates
   
        queue_id = hash % num_queues
   
    Real RSS uses an indirection table:
   
        queue_id = indir_table[hash % indir_table_len]

> For HW-GRO I investigated less closely I mostly focused on making sure
> netdevsim is solid as a replacement for veth. There was more flakiness
> on HW (admittedly I was running inter-dc-building). But the failures
> looked rather sus - the test was reporting that packets which were
> not supposed to be coalesced got coalesced.

The reverse is a known cause of flakiness, due to the context closure
timer firing. But unexpected coalescing definitely seems suspicious.
 
> BTW it's slightly inconvenient that we disable HW-GRO when normal GRO
> is disabled :( Makes it quite hard to run the test to check device
> behavior. My current plan is to rely on device counters to check
> whether traffic is getting coalesced but better ideas most welcome :(

We probably have to maintain this behavior, but could add an override
to enable only HW-GRO.

Alternatively, just for measurement, a bpf fentry program. But that is
a lot more complex than reading the counters, which is sufficient
signal.

> > > This series is not making any real functional changes to the tests,
> > > it is limited to improving the "test harness" scripts.
> > 
> > No significant actionable comments, just a few trivial typos.
> 
> Thanks!



