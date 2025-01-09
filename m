Return-Path: <netdev+bounces-156827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F5A07EDE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1C53A7665
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62F1925BC;
	Thu,  9 Jan 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EzCvHiCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6318C93C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444182; cv=none; b=g1h3lMpx6Blopx+FUeo0gSuIDcKVXAwsWHoZU2HoK4OiK4AyHrKP7qd2uNi1lWEndWFBSLA1Jj7M1o5o+koKTyVUTwHGVHsLXYTpuQMO7eeIRSQ+HB5+9n+95juISK+M/o6pvnDDjAMGLDoVhf32bUgIRFR758eGc7+31iXtVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444182; c=relaxed/simple;
	bh=x3uYksfOoCqvS4XniyEV29UETSR2DPCFoV/TeVAweyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPmOCM3Vol//sMaGFX3Yc1LTHA+bHvWVolG/TMPRH30SXI7atlWNB2Dfdf5EN0+AprZ4TKtI4ZPgo3KGcMI7g/hXZYxtV1sxSko53uA+SMzdQjm3uwCUVIketSlKSFlMj355jlg4vY8tiqCfivLxtw2ZI8qsRvnNI/wdTRZ4Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EzCvHiCT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so15910155ad.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736444179; x=1737048979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZHhPMMDgJMypLywgbNALwEdp/HyHOu1g/oZooCDLms=;
        b=EzCvHiCTSE28neDl9j/D9H7k4H+oLv393N904jPbz2MkF9ndMSDAsffGPSTmjOJr8C
         9ssl7AvcQSrhKfiEmrcWE+lkGXs+XFHUgf1EB3w/WTAX3WzrsSrecGWl843Rw38TsG0T
         jUeEclRUXeq+8wQCT2vJkoTXiXsX1W4uHMWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444179; x=1737048979;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZHhPMMDgJMypLywgbNALwEdp/HyHOu1g/oZooCDLms=;
        b=kmfz7VQ8XvwA1EE5B3HcZqxYexKIR+va867L8sZzi4cfElN7FFlYInFmU+J8NG65BE
         ITeUpgMwhBiexjeOZ87l2eGoA6+utaSJfI/H5KKQHD9o+97GQl7G64C4R7ZJhiexVdVh
         bgcVWvxBHp56JDNZ40Dv0U01onpXxamNuvg5hIB7LnY2Tits7wQo5QH3pwQRiol2vPev
         6iafyr5kL1Qa/9rmGAlEhCsdZyyDzz9Gp/OO0/9/8v2eW6wS3O0gYjkYECsHbKrtD1M4
         f65m+j8473+f8UIplrdReGgOeiZIFH72TWbTx08YsFqscqXUM57ybw7ikbT/yS2SeCP9
         aE7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtbNnC55ryfkXBwO5OdGJWv+pJn/RQk7wS0Qam1aZecqnjzTHMsdxxLGj0CJPkG76Rq0BPzwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUFTkdcCK9RX9DMJAKt9pcK5ChFjMpoIS9JZwipPCRV5k53JS
	FnbaknEZt5ONj/8uMF7U/X/HUoRONFCN9Z4d3Agdod6gLHuVu0OCh+47Vak7eJE=
X-Gm-Gg: ASbGncsj6h8WXFXell6Ofg36HMV3G1TBh4AoB1BJBsAPNGwI+JxtH6XWOpCouGXteua
	BfZ/4DtqP0NP9LeT9+VsuOiTB+71Gbi4sGFavpvi9ZkAhXhN19uoazeBONu0If1BF6eNUGF5ceQ
	2pTkvNWuvc90LqN3y7dZe+Ib0wj8IrUtnzO8i1JtE+B/TrT18qDoxtNlEfVDP33cdhseQ2yWfsI
	y8RnsexdGyakzqPdzKvzx98QeQ4sczPR4oCTvsCVgM+EqrWUay7KVCWlrDr+wKKI20p8NlBQypO
	2QNyvea/3sA9CRXQwQdfH7A=
X-Google-Smtp-Source: AGHT+IEa3zYxpMXCXFOwlLMPkEEXePt9PsXFMZbJIFnWJoslOR8muwkSZIVXyD3D5iar6ke0LsXsVw==
X-Received: by 2002:a05:6a20:2591:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e88d0e2320mr11880124637.16.1736444178914;
        Thu, 09 Jan 2025 09:36:18 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405489fbsm59505b3a.24.2025.01.09.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:36:18 -0800 (PST)
Date: Thu, 9 Jan 2025 09:36:15 -0800
From: Joe Damato <jdamato@fastly.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca
Subject: Re: [PATCH net] xsk: Bring back busy polling support
Message-ID: <Z4AJD97LFmjfCrc2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca
References: <20250109003436.2829560-1-sdf@fomichev.me>
 <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>

On Thu, Jan 09, 2025 at 04:22:16PM +0100, Magnus Karlsson wrote:
> On Thu, 9 Jan 2025 at 01:35, Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> > assignment to a later point in time (napi_hash_add_with_id). This breaks
> > __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> > stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> > __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> > Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> > to busy-poll AF_XDP sockets anymore.
> >
> > Bring back the ability to busy-poll on XSK by resolving socket's napi_id
> > at bind time. This relies on relatively recent netif_queue_set_napi,
> > but (assume) at this point most popular drivers should have been converted.
> > This also removes per-tx/rx cycles which used to check and/or set
> > the napi_id value.
> >
> > Confirmed by running a busy-polling AF_XDP socket
> > (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> > from /proc/net/netstat.
> 
> Thanks Stanislav for finding and fixing this. As a bonus, the
> resulting code is much nicer too.
> 
> I just took a look at the Intel drivers and some of our drivers have
> not been converted to use netif_queue_set_napi() yet. Just ice, e1000,
> and e1000e use it. But that is on us to fix.

igc also supports it ;)

I tried to add support to i40e some time ago, but ran into some
issues and didn't hear back, so I gave up on i40e.

In case my previous attempt is helpful for anyone at Intel, see [1].

[1]: https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

