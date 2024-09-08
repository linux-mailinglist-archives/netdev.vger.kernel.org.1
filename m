Return-Path: <netdev+bounces-126286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD297087C
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C0F281BFF
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B816FF5F;
	Sun,  8 Sep 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J7BJBp9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A1EACD
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810870; cv=none; b=glj0KeW7B6Q6FJgaSNpDXdthCpLCuZbBhwXAU+0riWt5lbUS/GS776oDBP+LSu6MhkuLqmGTRgyYbkn4AK0Ft4N+LcxerQNmKKTpuLitxa39mFCxepy0eXI9cpKnxoF8e/xsAxtUnl999j2g0P7/ybIkpn1P6DNgCdaJeDk2RR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810870; c=relaxed/simple;
	bh=24HNk1C6ld2rgaeYFXV6BX+v4f/8wES1gqoF+2YuCr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spa6btb3vuaH76T+LYlCYQLDDpWWIp/jUoTmxsWBCkW5SULEOyX0eT0i1CyLqI/nQTxe4MxpffSzq9Z4O55k1ltJicn/+CKP2rwpgKHmYX86Lu5z5uYRCycflAQaMhyfCHoYfP7wLFNemSGhkMCkuZSeIvYtIfBs+/ZG0/9lJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J7BJBp9L; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3c34e3c39so5196303a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725810867; x=1726415667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhDWgkw0nnz+RwF6BrjZhhfiVO9eU07rs1BodF5roic=;
        b=J7BJBp9LRNQmrq/BN9W7FjOXcFqxQCE4GfvqD54rmILxsZ9wrPmrwrQmEhwdAmDlIk
         U7jFk2v1Kll3u1hlcqmRJaJ1I4n0G/X410beeYlDppuwSQLmzFy4lR2TiJKPNo+O7z3i
         QYyOzSdr7e0uCgLIkV2o3mvYTaeXYp2mFFZsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725810867; x=1726415667;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhDWgkw0nnz+RwF6BrjZhhfiVO9eU07rs1BodF5roic=;
        b=t6El5moMARMt2yh0Q+caL4l9xt7GSS+hfqCtdbb6RZtlbb00OIx8Bqz3EijiIjJv62
         NHv26Axd8gqLAHfso/O4iJUfjvPdZiDpz36KyhKl9X4lrofZ9kMCmBXIMIuSSO9fY5IH
         fG+mwmr3iL6CMRfO46xbs1GYEeRfPPKK9hAjPCYB1TUBQQanYsPe7qtTaDhdIYotK2gc
         67865SNSClErjVl6UYDqtkjrPeClteLZn+TAfJj0tqtHPNlEE3rRy0c+TOp2aQm/gjSZ
         y0R4B0CALh0/r36bLBioF+PdIUm1+JH5zYRn78y5wu8fXdmKEv+F6dBO+HFlgm4f+/nY
         emLA==
X-Forwarded-Encrypted: i=1; AJvYcCUxOejxUcD8OiXqT2PnmaQ2kYVhV/7zkJOQwp0ruLL+gIKnnA+2kmX7Gh7okUurUvcIyhFlvw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVHrcyPyLb6Hsh7560MTGR/tz7biF6/kHQ8m5Ej9JBJRBsmxd
	blHe1qxemW1KTvVNLYucvrxZuh4i9XMuj3lkbOAYDZHOjh+JdxiAI8Ab+tcEYrQ=
X-Google-Smtp-Source: AGHT+IFTISnG2M2e06EVDZYB18PzKN52r34MsC1GglYcSeZ2qJ2fwpSkFA4vpVfCmslbnbpGwhNzPg==
X-Received: by 2002:a17:907:9718:b0:a8a:780f:4faf with SMTP id a640c23a62f3a-a8a887e6106mr599622866b.47.1725810865961;
        Sun, 08 Sep 2024 08:54:25 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583fc73sm219159166b.34.2024.09.08.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 08:54:25 -0700 (PDT)
Date: Sun, 8 Sep 2024 17:54:23 +0200
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <Zt3Ir5aV_BHcTgKk@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org>
 <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org>
 <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <20240902180220.312518bc@kernel.org>
 <CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
 <20240903124008.4793c087@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124008.4793c087@kernel.org>

On Tue, Sep 03, 2024 at 12:40:08PM -0700, Jakub Kicinski wrote:
> On Tue, 3 Sep 2024 12:04:52 -0700 Samiullah Khawaja wrote:
> > Do we need a queue to napi association to set/persist napi
> > configurations? 
> 
> I'm afraid zero-copy schemes will make multiple queues per NAPI more
> and more common, so pretending the NAPI params (related to polling)
> are pre queue will soon become highly problematic.
> 
> > Can a new index param be added to the netif_napi_add
> > and persist the configurations in napi_storage.
> 
> That'd be my (weak) preference.
> 
> > I guess the problem would be the size of napi_storage.
> 
> I don't think so, we're talking about 16B per NAPI, 
> struct netdev_queue is 320B, struct netdev_rx_queue is 192B. 
> NAPI storage is rounding error next to those :S
> 
> > Also wondering if for some use case persistence would be problematic
> > when the napis are recreated, since the new napi instances might not
> > represent the same context? For example If I resize the dev from 16
> > rx/tx to 8 rx/tx queues and the napi index that was used by TX queue,
> > now polls RX queue.
> 
> We can clear the config when NAPI is activated (ethtool -L /
> set-channels). That seems like a good idea.

I'm probably misunderstanding this bit; I've implemented this by
just memsetting the storages to 0 on napi_enable which obviously
breaks the persistence and is incorrect because it doesn't respect
sysfs.

I'm going to send what I have as an RFC anyway, because it might be
easier to discuss by commenting on code that is (hopefully) moving
in the right direction?

I hope that's OK; I'll explicitly call it out in the cover letter
that I am about to send.

- Joe

