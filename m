Return-Path: <netdev+bounces-177852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAEA7210D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC82188B264
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448723E25F;
	Wed, 26 Mar 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2bUjXcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4A1A315D
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743026261; cv=none; b=u7TnYlFI/hMK37jwcwow/c9yK08xEY6T+iC0FAWLBVLLDoUAhwvr/RwJvOvF/7iC0/13JoSLvuGvBfqvwC4CGYn3xakoUPrakR2KK/FcbpPXnifWTxEfKarYKO73ssk4xacobwssrPKyu4iQIs2c3t80EmA0tIfcRRLs2XB0UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743026261; c=relaxed/simple;
	bh=tgBkZMKOwGjkOBeIPquaoDq9TymjZkB1ZPGlai2GbA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEdvhi+C8UIcJIR4wE1Veusn64zpXJo7m3rWNCecIQQkTrv0EEY6ytCjd6a/mBFtfRfS1fc/FjmVBJefbVPgxScR2ewfg6AD4ERUG4RviCN9I8xB8YZtD/XttJyExJOG5NJ1/T8fI29m/CfDW+ftWHuSMHKW2al3J6UauAbtS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2bUjXcI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so7023415ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743026259; x=1743631059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NU156XBldR3xPSQ86+oHwUfWbnJpxP8+N7djVfRsjnk=;
        b=g2bUjXcISWCOIW6m9vW15zGRcPMg9t8VnHwmhkhX3+yfdFvllNrD0tMW2yk8bsZVIM
         ElOh2H4KZftTSJGD7QyvSFTV/ki/0VIMFf0WMPiC9sN8He297SeWbiUgDbl7bkvH+Sv7
         HMn1AxVBmJNzmz/4OrMgyMHYruoJ+OILUtEqtPaN03I8Ax9ZRGKlcrMOqpyfHlaf1/ER
         lOnSme3MpVWl8Pn+Yp1HSpK2hcAulDHwdBH7GPQmBYApxTyxFgSTcgw+wLk+djZK2z3I
         7y/5Iy9SHEYEf9dE2JwDEYH3EzlQCVo0BkG065nyw+r27SCjd8Be/TlDwA01Da4sYotZ
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743026259; x=1743631059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NU156XBldR3xPSQ86+oHwUfWbnJpxP8+N7djVfRsjnk=;
        b=qthvptH5+cvY0VoKCPiGcCj97DtCNkAAbpVh41ntJkPy9mBrxhWrIL1sJvEVK6S9t3
         DaOoGrtKMnxxaG3m8mEGoBsjM/u2r7dXPt4FtmWrO/bY7cGPaMv6DMqZF4Sp8L3zd2MJ
         mhDffMXaTbhz+e8NFywzomrGliJLzpot22S6lUeJ/KzinA3DktUN6192ddwRGWJeiHd5
         kBW5S2alc+rhPkJTq2RGAi2ih3Txeh7EWlUDkiSk4a8D2KhFHXsUihy8WO7RrX9sYSC5
         6qBjjNUx23fPa4BtYvZtKvgXiF53MuGHo4NhEolUuTn/oA4tOX+FEye40GXnxDbY9IPZ
         y2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2CPckNHTOYcuPDFOzi2ztvXQEQBNisonx0NYi0bv7Gl57xaIXoAltIpn22cNQZmIWiYqbFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpZJbkBRcgVCKh+mrcv0cWxzU9acwhGrh83AtFFchIXnN0xlL
	HhNi5M/fRBu0bCqN9yhzcqITUNSwCMccARrpD5F7YsARnXVuvew=
X-Gm-Gg: ASbGncs/G3cInJsAoMeN4Cy5ZDu4+DBB98tiW/I1vx9CXh0yg6S0UJrt2yVeheDHWo1
	jj18AUvazRmSzRiq2IKsgk3uZZ+FFF8/Qb9/Lm2azXdx7HU5wCCTPznfjtg9b/8XA6syowh1+T3
	7NPrWsNknsyOuCG5M14OcqVlqRjHsUultso9Yf2Fl6tkGW1+wKR2SBBqFxN38lXujVqY49QJm80
	sZBdC3sRcjABGKx1UebKsWBQ7zUEnYlZq+ACK+3vmEkcZ/DQyJrK1bpsrdNzHKjh0l03AwpCJuA
	v7LhqzrnQx4On/CJDADFwssLzr08tuMg7XGJpHPbhhRz
X-Google-Smtp-Source: AGHT+IGoSyB4GwHJBy4zSHIOsuyWHfiUG7BUPzABsn8w8SAr4+qwv1M6vTLZP0UbM5iCHn+I05syuA==
X-Received: by 2002:a17:902:f644:b0:223:4e54:d2c8 with SMTP id d9443c01a7336-228048adb18mr17127815ad.21.1743026258936;
        Wed, 26 Mar 2025 14:57:38 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f395f4sm115368425ad.9.2025.03.26.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:57:38 -0700 (PDT)
Date: Wed, 26 Mar 2025 14:57:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
Message-ID: <Z-R4UUzeuplbdQTy@mini-arch>
References: <20250321021521.849856-1-skhawaja@google.com>
 <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
 <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
 <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>

On 03/26, Samiullah Khawaja wrote:
> On Tue, Mar 25, 2025 at 10:47 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> >
> > On 2025-03-25 12:40, Samiullah Khawaja wrote:
> > > On Sun, Mar 23, 2025 at 7:38 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > >>
> > >> On 2025-03-20 22:15, Samiullah Khawaja wrote:
> > >>> Extend the already existing support of threaded napi poll to do continuous
> > >>> busy polling.
> > >>>
> > >>> This is used for doing continuous polling of napi to fetch descriptors
> > >>> from backing RX/TX queues for low latency applications. Allow enabling
> > >>> of threaded busypoll using netlink so this can be enabled on a set of
> > >>> dedicated napis for low latency applications.
> > >>>
> > >>> Once enabled user can fetch the PID of the kthread doing NAPI polling
> > >>> and set affinity, priority and scheduler for it depending on the
> > >>> low-latency requirements.
> > >>>
> > >>> Currently threaded napi is only enabled at device level using sysfs. Add
> > >>> support to enable/disable threaded mode for a napi individually. This
> > >>> can be done using the netlink interface. Extend `napi-set` op in netlink
> > >>> spec that allows setting the `threaded` attribute of a napi.
> > >>>
> > >>> Extend the threaded attribute in napi struct to add an option to enable
> > >>> continuous busy polling. Extend the netlink and sysfs interface to allow
> > >>> enabling/disabling threaded busypolling at device or individual napi
> > >>> level.
> > >>>
> > >>> We use this for our AF_XDP based hard low-latency usecase with usecs
> > >>> level latency requirement. For our usecase we want low jitter and stable
> > >>> latency at P99.
> > >>>
> > >>> Following is an analysis and comparison of available (and compatible)
> > >>> busy poll interfaces for a low latency usecase with stable P99. Please
> > >>> note that the throughput and cpu efficiency is a non-goal.
> > >>>
> > >>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> > >>> description of the tool and how it tries to simulate the real workload
> > >>> is following,
> > >>>
> > >>> - It sends UDP packets between 2 machines.
> > >>> - The client machine sends packets at a fixed frequency. To maintain the
> > >>>     frequency of the packet being sent, we use open-loop sampling. That is
> > >>>     the packets are sent in a separate thread.
> > >>> - The server replies to the packet inline by reading the pkt from the
> > >>>     recv ring and replies using the tx ring.
> > >>> - To simulate the application processing time, we use a configurable
> > >>>     delay in usecs on the client side after a reply is received from the
> > >>>     server.
> > >>>
> > >>> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
> > >>
> > >> Thanks very much for sending the benchmark program and these specific
> > >> experiments. I am able to build the tool and run the experiments in
> > >> principle. While I don't have a complete picture yet, one observation
> > >> seems already clear, so I want to report back on it.
> > > Thanks for reproducing this Martin. Really appreciate you reviewing
> > > this and your interest in this.
> > >>
> > >>> We use this tool with following napi polling configurations,
> > >>>
> > >>> - Interrupts only
> > >>> - SO_BUSYPOLL (inline in the same thread where the client receives the
> > >>>     packet).
> > >>> - SO_BUSYPOLL (separate thread and separate core)
> > >>> - Threaded NAPI busypoll
> > >>
> > >> The configurations that you describe as SO_BUSYPOLL here are not using
> > >> the best busy-polling configuration. The best busy-polling strictly
> > >> alternates between application processing and network polling. No
> > >> asynchronous processing due to hardware irq delivery or softirq
> > >> processing should happen.
> > >>
> > >> A high-level check is making sure that no softirq processing is reported
> > >> for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1).
> > >> In addition, interrupts can be counted in /proc/stat or /proc/interrupts.
> > >>
> > >> Unfortunately it is not always straightforward to enter this pattern. In
> > >> this particular case, it seems that two pieces are missing:
> > >>
> > >> 1) Because the XPD socket is created with XDP_COPY, it is never marked
> > >> with its corresponding napi_id. Without the socket being marked with a
> > >> valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes
> > >> napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs
> > >> softirq loop controls packet delivery.
> > > Nice catch. It seems a recent change broke the busy polling for AF_XDP
> > > and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
> > > broken and seems in my experiments I didn't pick that up. During my
> > > experimentation I confirmed that all experiment modes are invoking the
> > > busypoll and not going through softirqs. I confirmed this through perf
> > > traces. I sent out a fix for XDP_COPY busy polling here in the link
> > > below. I will resent this for the net since the original commit has
> > > already landed in 6.13.
> > > https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=oxa164_vTfk+3P43H60qwQ@mail.gmail.com/T/#t

In general, when sending the patches and numbers, try running everything
against the latest net-next. Otherwise, it is very confusing to reason
about..

