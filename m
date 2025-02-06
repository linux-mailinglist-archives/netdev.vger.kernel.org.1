Return-Path: <netdev+bounces-163638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C9A2B166
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5441882C67
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FF1624ED;
	Thu,  6 Feb 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="BzJ2a9ha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC919E99A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867224; cv=none; b=XHLaJA+jV8kaNCtCCN08JxMXQL/U/6W2oAHy93VXpWgG3wHS4+g8rfOUNdxwkR5OoVQpKvt1uqeqiCHQ437s5asxZ8pvfDaPvx7oA0RJcipexPYUtQNC3r71sboruFZZZ9ClJmkUsO/KE2dWlAKp6SegbjbN/bWbzhf8H80s1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867224; c=relaxed/simple;
	bh=MZkfK2lTbRGoT8Ii/polcb28rK/eytN5P/Ez7yOpQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvrP9/go5LbhfSKVUrTD8vuXI/+7OApgv5mMrl3lfJf87Sywr2IiRjTBht7pvvvEGojIlG0sub7SkEAeE2tUi5hQdtxmIhFeNLKk1BRKfU4nDGd81IsfyjCEeIEW5roJb0WhaxsycDJmIItZb37KvB7T0a+GsoqGCpGC6Yziwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=BzJ2a9ha; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f3c119fe6so21782355ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738867220; x=1739472020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZWS20kqs9c+3CnxDS3Fzgm4QnMLxyNZHTj1EHfLVwk=;
        b=BzJ2a9haRTQ437jd2gmiH960Et7cKkb7rNtDPbh/9lwYudpD3jIxaIEgIf1d7uh4Ny
         4sjHTPnlzo28WmVfoVjcM4+WfRq6UT+1jZOF4MPpAoXKvLEjfAj6/ZzLTzhZhymTKoAM
         XaAaaghq/nq41BxDDClCxQeDqXmTlt5OQT76I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867220; x=1739472020;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZWS20kqs9c+3CnxDS3Fzgm4QnMLxyNZHTj1EHfLVwk=;
        b=rvdOM0RnZwspS8x9cOFNZD3iAapb/vdmBRG1vnaZoP2U/dCnn6QBgpDqZuMSMV4x15
         rHzVVy9NB/1d4rsAJ9fyheHvQcTW90SN4PeTVf4IbRUrG3QTsmCxrUwGO7Jd5hwXtigt
         9niIgUlL6ILDAbxs7rKC/BzS/l7dZBFm/CytAB/hH7ZhAQlLWxVUd/cNGHXhrUXr6dDC
         IbOW3hep/owfBYvn60Lq25ah3N3MMmNAa1I/+el/Egd99I22Rdz7xI5KMWHFEXn0JwCz
         xjlaPaDj5RxVg9E5TE3RFUIboLxPgUntQR8FD5LtGku7Kt7rGVXcupMJViq/iteF/qbV
         9qNg==
X-Forwarded-Encrypted: i=1; AJvYcCXq2MI2qMWP+23oZMiiuAUw4+lCG3bK6v84KgvgpUb6sZxnntcp8OPN2M1+CKTg3U1cEan2HZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioOTEz3yiC3RuvGNl4sqI7pd2yhXifVEtfgT1oxCsipeUZMdU
	TE1jyHSbUe9R/6aI9LeF3rwxWL6muzCgI2lX9GgdMjyG9GTbfgluUogg3SuZ4No=
X-Gm-Gg: ASbGncv2VhBFdyoyiJJzOpO/7CZl/qDOo341tuWvoohoCtM4grAHblvA7+qXC7bOVOm
	IL94zkCiXIWJVd9AGs16P/mIJbMv53GbHJ0ons8BjpTGkrRtQd+fLGkzK4Y1FBXit4n/Ag/KTdl
	TO5PUTXwuJf+hfWwB7D0cB8vNlNKhwbZc8pFMWkgKzy/2HJn2PmdXP8mvV4dVLCU0P+ln4PwJlS
	c5wVret7v3NloiW+5LIyh95OMPBsk/4TyecnvtZBzVylaH2DnT+A50035neJVWjXT3OVFieBiIG
	v97zgcXLBEsDNk4dnLAbNTXigLkEYoTrsgyStJFBtUGb2Ns1TqzLVyaxqA==
X-Google-Smtp-Source: AGHT+IFo9j1ajk/Tt6RMe7wwdg1j0XpSjWn7QyBeflmg/QIs9FlX75snei4ufVdUAa7uqMz5vZCJ8w==
X-Received: by 2002:a05:6a21:158c:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1ee03a24f9cmr787997637.2.1738867219767;
        Thu, 06 Feb 2025 10:40:19 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7c19sm1613985b3a.79.2025.02.06.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:40:19 -0800 (PST)
Date: Thu, 6 Feb 2025 10:40:16 -0800
From: Joe Damato <jdamato@fastly.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <Z6UCELdW86ZdcTK4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Laight <david.laight.linux@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-2-skhawaja@google.com>
 <20250205231003.49e5cc3f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205231003.49e5cc3f@pumpkin>

On Wed, Feb 05, 2025 at 11:10:03PM +0000, David Laight wrote:
> On Wed,  5 Feb 2025 00:10:49 +0000
> Samiullah Khawaja <skhawaja@google.com> wrote:
> 
> > A net device has a threaded sysctl that can be used to enable threaded
> > napi polling on all of the NAPI contexts under that device. Allow
> > enabling threaded napi polling at individual napi level using netlink.
> > 
> > Extend the netlink operation `napi-set` and allow setting the threaded
> > attribute of a NAPI. This will enable the threaded polling on a napi
> > context.
> > 
> > Tested using following command in qemu/virtio-net:
> > ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >   --do napi-set       --json '{"id": 66, "threaded": 1}'
> 
> Is there a sane way for a 'real person' to set these from a normal
> startup/network configuration script?
> 
> The netlink API is hardly user-friendly.

There is a C library, libynl that abstracts a lot of the netlink
stuff away and is quite nice. That said, if you wanted to use it
from a script, you'd probably need bindings for it in the language
of your choice.

If you meant more a shell script type setup, then yea.... the python
CLI is (AFAIK) the only option.

