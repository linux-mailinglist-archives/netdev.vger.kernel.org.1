Return-Path: <netdev+bounces-215402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D6B2E723
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAD5E31E3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F952857CB;
	Wed, 20 Aug 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E799pwJy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3E1E7C05
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723894; cv=none; b=rwgskzarCbzKvlGL/dh07EF1hWpf2QDGsSrK3VrnNZLkgd9QgOJvVFdEVTlH6wnIL5rV6tQTGWA4Z4HBN2iRSXOkZHkJin1HuocH5PAQQ5zfCcOxtBGA8jgleyifglA84PESzDgkSnpfDwj8pXKNce2Z40xfViP7ZkAGFCG3rXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723894; c=relaxed/simple;
	bh=IKJbwqq+ssNGPLwPN3v4e0iOAM+LPgDURBWPrEr0kJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEay/zU0FhqANjCPh/KBHVnPonclsdc3xG58KeZMZe8FxnUC28Tg3djMYZ2TjR31IHFtUDDhMjj5jyPZDgqsHFd3T1kH9CmVy5Psy39hO5SGCTlyycFQ1Rb8mnzuwHBczsecc9dWuM3jqtGl6PdJgkYPhD1Mnh3lcluNwhCijQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E799pwJy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755723891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ2M3ssKjP0d9Xh1Ek+WadutufEi9zJhnd27cRI5G8A=;
	b=E799pwJyiEyXC6RGZCie6YWT8CI0632nnmp1+E5h2RJUZbRihmx1RswBrmOBml3RuFxcLd
	gEYma9lrfLp1Fh+ehwDNpXZDYfWOBSZOzrOIbwLSxGnkFE5fsB6e/BInwqYPgA67D51t8h
	dBu8a2Qm07vT2qZ6LIHQ3i5Acdq7lwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WTOab4DQME2YjXrsPlR7Hg-1; Wed, 20 Aug 2025 17:04:49 -0400
X-MC-Unique: WTOab4DQME2YjXrsPlR7Hg-1
X-Mimecast-MFC-AGG-ID: WTOab4DQME2YjXrsPlR7Hg_1755723888
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4134a34so223656f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723887; x=1756328687;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQ2M3ssKjP0d9Xh1Ek+WadutufEi9zJhnd27cRI5G8A=;
        b=gpYM+fpiliLZIQs2Ut6xYgca290HxHiYiDTC350IC+IWj8GC2bb1wB8llM3kglgMQ6
         opexSOW0xyxsnRU/jSXdcPJQ4CfsyGkvMvgH7DuffsiRI7pI/AFrYXHLdStQNytau+eE
         AZiVxnk8l4H4Yk4indBejWT5fMdn9eBvRaw2vguraNdi1xzTVMMYTl2NsOLGWhHjVx6v
         0Fi5T4Je18g1ymG4kwj3T+H2VctGYFxA3CYfHygM6o+W32DFdYQRj7uNxwiO94z/OHoj
         q2D3+7s3PcRhovW6Qmc5rP0zlohJj2ygbl702uPkC8yk1TWJZbtl0Q96s3DryhnyBlX8
         6xqA==
X-Forwarded-Encrypted: i=1; AJvYcCXaP1D/K2amsvEhz3G7bKDczKZLOGpsSI+pMeNx856clNiDNoa1tkAOBCdU/mKfHdbtoUWFEU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3w9zUWpfCEN2/PeawbIow2UxsbX3FsoZIhpy0M8bAaA8BGcp
	xQvFSiy+s2tx/PY4CgTCsP/Zn4YJAnujUQtpH9MrcPx9rEN9pqnHtnNKtisJw+4GRN29AprKzvY
	PV1GT0w2GCd0mw7V7WPVzuy0c7FTbIyz3fOPhZCBV9ZgV8xanPPWvYFygagjmUCncBA==
X-Gm-Gg: ASbGnctit7oNZnNpaSNKMlJEO2V7F7GYMwZ242F5LwP0O1VoKBdtKgckH+n76bCvvuf
	9NwvIJhms0RjTieN4GbGJLokIngADfAQWlKdrlEVPm2acwvrPDHkXQa4e1bOeBbHRidD14ePWVg
	QqL9cZoFeAO4W9wBfbZzA6lTvRp+v7Y4QX0v86ygFnfcjG+cHI0RzXonRYotJZBwdGwdB3ww+BR
	e2oirGISXhGhU/fFJWRBC3JKNKjXMpPVF8bu41IiCq2bMEL70qyfMzFXiLsfv2clRrfpRquTr9R
	RwymCE03hHB8gT3CyOOlNpFMp9NkjfwbBEiBYS3iIqOLBH2zyYk=
X-Received: by 2002:a05:6000:2911:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3c49596de8fmr158911f8f.26.1755723887514;
        Wed, 20 Aug 2025 14:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENTGvNEwXbMl+xZ0oyhHsf6vLUKYl8/dRuAw2oc1UIlhxoMdK7YtucqNa4pIrp81fAdXgyKw==
X-Received: by 2002:a05:6000:2911:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3c49596de8fmr158880f8f.26.1755723886994;
        Wed, 20 Aug 2025 14:04:46 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c33203sm47048595e9.9.2025.08.20.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:04:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:04:45 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH net-next 5/6] netfilter: nft_set_pipapo: Store real
 pointer, adjust later.
Message-ID: <20250820230445.05f5029f@elisabeth>
In-Reply-To: <20250820183451.6b4749d6@elisabeth>
References: <20250820144738.24250-1-fw@strlen.de>
	<20250820144738.24250-6-fw@strlen.de>
	<20250820174401.5addbfc1@elisabeth>
	<20250820160114.LI90UJWx@linutronix.de>
	<20250820181536.02e50df6@elisabeth>
	<20250820162925.CWZJJo36@linutronix.de>
	<20250820183451.6b4749d6@elisabeth>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 18:34:51 +0200
Stefano Brivio <sbrivio@redhat.com> wrote:

> On Wed, 20 Aug 2025 18:29:25 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-08-20 18:15:36 [+0200], Stefano Brivio wrote:  
> > > > As far as I remember the alignment code expects that the "hole" at the
> > > > begin does not exceed a certain size and the lock there exceeds it.    
> > > 
> > > I think you're right. But again, the alignment itself should be fast,
> > > that's not what I'm concerned about.    
> > 
> > Are we good are do you want me to do the performance check, that you
> > suggested?  
> 
> I think it would be good if you could give that a try (I don't have a
> stable setup to run that at hand right now, sorry). It shouldn't take
> long.

Never mind, I just found a moment to run that for you. Before your
change (net-next a couple of weeks old -- I didn't realise that Florian
introduced a 'nft_concat_range_perf.sh' meanwhile):

---
# ./nft_concat_range_perf.sh 
TEST: performance
  net,port                             28s                              [ OK ]
    baseline (drop from netdev hook):              26079726pps
    baseline hash (non-ranged entries):            18795587pps
    baseline rbtree (match on first field only):    9461059pps
    set with  1000 full, ranged entries:           14358957pps
  port,net                             22s                              [ OK ]
    baseline (drop from netdev hook):              26183255pps
    baseline hash (non-ranged entries):            18738336pps
    baseline rbtree (match on first field only):   12578272pps
    set with   100 full, ranged entries:           15277135pps
  net6,port                            28s                              [ OK ]
    baseline (drop from netdev hook):              25094125pps
    baseline hash (non-ranged entries):            17011489pps
    baseline rbtree (match on first field only):    6964647pps
    set with  1000 full, ranged entries:           11721714pps
  port,proto                          304s                              [ OK ]
    baseline (drop from netdev hook):              26174580pps
    baseline hash (non-ranged entries):            19252254pps
    baseline rbtree (match on first field only):    8516771pps
    set with 30000 full, ranged entries:            6064576pps
  net6,port,mac                        23s                              [ OK ]
    baseline (drop from netdev hook):              24996893pps
    baseline hash (non-ranged entries):            14526917pps
    baseline rbtree (match on first field only):   12596905pps
    set with    10 full, ranged entries:           12089867pps
  net6,port,mac,proto                  35s                              [ OK ]
    baseline (drop from netdev hook):              24874223pps
    baseline hash (non-ranged entries):            14352580pps
    baseline rbtree (match on first field only):    6884754pps
    set with  1000 full, ranged entries:            8787067pps
  net,mac                              29s                              [ OK ]
    baseline (drop from netdev hook):              25956434pps
    baseline hash (non-ranged entries):            17166976pps
    baseline rbtree (match on first field only):    9423341pps
    set with  1000 full, ranged entries:           12150579pps
---

after your change:

---
# ./nft_concat_range_perf.sh 
TEST: performance
  net,port                             27s                              [ OK ]
    baseline (drop from netdev hook):              27212033pps
    baseline hash (non-ranged entries):            19494836pps
    baseline rbtree (match on first field only):    9669798pps
    set with  1000 full, ranged entries:           14931543pps
  port,net                             23s                              [ OK ]
    baseline (drop from netdev hook):              27085267pps
    baseline hash (non-ranged entries):            19642549pps
    baseline rbtree (match on first field only):   12852031pps
    set with   100 full, ranged entries:           15882440pps
  net6,port                            29s                              [ OK ]
    baseline (drop from netdev hook):              26134468pps
    baseline hash (non-ranged entries):            17732410pps
    baseline rbtree (match on first field only):    7044812pps
    set with  1000 full, ranged entries:           11670109pps
  port,proto                          300s                              [ OK ]
    baseline (drop from netdev hook):              27227915pps
    baseline hash (non-ranged entries):            20266609pps
    baseline rbtree (match on first field only):    8662566pps
    set with 30000 full, ranged entries:            6147235pps
  net6,port,mac                        23s                              [ OK ]
    baseline (drop from netdev hook):              26001705pps
    baseline hash (non-ranged entries):            15448524pps
    baseline rbtree (match on first field only):   12867457pps
    set with    10 full, ranged entries:           12140558pps
  net6,port,mac,proto                  34s                              [ OK ]
    baseline (drop from netdev hook):              25485866pps
    baseline hash (non-ranged entries):            14794412pps
    baseline rbtree (match on first field only):    6929897pps
    set with  1000 full, ranged entries:            8754555pps
  net,mac                              28s                              [ OK ]
    baseline (drop from netdev hook):              27095870pps
    baseline hash (non-ranged entries):            17848010pps
    baseline rbtree (match on first field only):    9576292pps
    set with  1000 full, ranged entries:           12568702pps
---

it's a single run and not exactly from the same baseline (you see that
the baseline actually improved), but I'd say it's enough to be
confident that the change doesn't affect matching rate significantly,
so:

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

...thanks for making this simpler!

-- 
Stefano


