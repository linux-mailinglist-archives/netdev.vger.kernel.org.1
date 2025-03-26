Return-Path: <netdev+bounces-177862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09791A72427
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4811775CB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83231A76AE;
	Wed, 26 Mar 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQZ7CalM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD84430
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028356; cv=none; b=IY7SSEAJVhRtVuThph+cBvrsm0ot+H8dMlxjVfJ/WiQ8EYnCVWWfyA0Lmt5IYkOOytDipAQOxMpTjm2UrNHKu4EGfSXbhsCACRTyCVKW31WQFyX5/RcSgWUeuoPzZLOIy9O9X2Bm4VZA46MgA5v52xRjSTyGZwJQi7zdXxWmvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028356; c=relaxed/simple;
	bh=HpNHCrLjHqej6bHNanQrpZJ4KXbf0zMnqqiMAEfO5Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5Ij2BcaFo1VK5F+d4pViuu/9hHDWPF2u8abx02sSMzUoga44BNzbaFIPzVIyhBoP2dFIPZfQCrtn/aFoav3c3qR/PeFGb0OLyP1748lmHCzBSV/q4+1jLZYtySqF+9zZt5m2JlTjOxu47ZbYKQWjJOi+N8xhOzM77YML/8fiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQZ7CalM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223f4c06e9fso6774835ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743028354; x=1743633154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x62n46ttBDrsP/WTxvtbpEXchF2XU29wB0NPbhYyMZk=;
        b=LQZ7CalM3tlb85NGZcjew11TwZXXM0AQodLBd6mAt1OiY6ipRyzUUWdCgCzkRx8koZ
         TT5Dy4sfPXfZcw+xrwEtzCReZWJKPfVDHq63SJkcTapgJSh5VAKZ39M4aUkQ3Lk2qvOF
         /WRf1k3+VHcE3LTyhEkn3kTX+YBNg1dl4DBJQjbTCoYMfImxuiw2xpNTu3+Y+vt5TXfA
         RXFXb66t0u4qu/jRFJpRPrcdminDsB50hwQoJ+1fyZOCwvKzwIUkaPnY080haBKefQn5
         K1UJdFQltwTOWZJnvkANp5WRKQ2vRNek24aF/O08S80eO0RwQTbONA6LyVSEifM4MOxK
         0CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028354; x=1743633154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x62n46ttBDrsP/WTxvtbpEXchF2XU29wB0NPbhYyMZk=;
        b=lzJ+GPIu7ARKRhy2nzVG/004vkSb9yyWitQeYxKVFfDPxFCKveARQW6Nmclf2s/IyJ
         o5mAXCAby0mLdg+DpisW+S/nQcoFYWXakHDjPovUHAoeKZ7J9KGSGubYyUHodUvgYC1X
         enkXPnkW7v5M+Ljp48shKpBZ8eNyRkGj2mh7rqsng6lLxJGtUI8vyOZXctmvo0l0b8Px
         2gJG/cOLtVVcCU9GS4cFGOtcXtU+gxp+b3KxopHdyQsURWFXn5xd4Xi01zXEVuNmIeR0
         +SJvgFALJoOPPRlBNc1f9JJigAnFhQ0JYt1rkiqqmragM3YM/az1EyNzuoha1ynSv+r+
         rvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/gth+Pe1cV6obn4fY0k8aEkYwlaNe0R2++vk2k8tx5AdnChPxsnglHXVUaNE3wvWMKAl/UKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5xh9y4yMfgrAxo20o2aCn422Nq7whLjRR/ouPycrlh0Pkhcy
	IA9IS19+Ha/jFOGx+Pzr30lpsIds0/7rtMZ9cYOCDTHjReLqQtU=
X-Gm-Gg: ASbGncti72cDMgCt12ZVoPYIMOdXRHSHSa2PgTrCQIRNB2+D2YpZb0ebT8CKATjv3xH
	W3iS8I+XhsA/gRz2liMWxDXb9LZ0USunoTp6v02CZVblGXW2ksIQX46yzOirgRgkiIhGIKyvZcv
	KUZrPcdbVBUkufqC2T+jVk4YWHGnvfpBCF4KmW+4ameio/BppXGX9T09WQ78qP9kuNNPdT1ZPHa
	K9bpVuWFu92DRSyy7SiidbEfhXl/piZXE44sqaapg7Vl++BgTAOZpRTr1ntgO/NxkVqb0HAmNo9
	xurZrD83xMc3hycYCdq01QXNXp2xGCqtqQJ+xYauT43e
X-Google-Smtp-Source: AGHT+IELsntz/H0pCZoRzHmBGV0brFVd+n6PEZHF3u1xVENSn69XfxrVOVrLJ3mKpmKdDV5mAsdG+g==
X-Received: by 2002:a17:902:f601:b0:216:4676:dfb5 with SMTP id d9443c01a7336-22803b348d5mr20487225ad.21.1743028354260;
        Wed, 26 Mar 2025 15:32:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f56d7asm115345885ad.105.2025.03.26.15.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 15:32:33 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:32:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
	mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] Add xsk_rr an AF_XDP benchmark to measure
 latency
Message-ID: <Z-SAgPijHtVP6S3n@mini-arch>
References: <20250320163523.3501305-1-skhawaja@google.com>
 <Z-Hdj_u0-IkYY4ob@mini-arch>
 <CAAywjhTzmupd=ehmve=iDtK638=6_yKyi9WOM9L=tG2CM4n=oQ@mail.gmail.com>
 <Z+R9d55KFikYXGm0@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+R9d55KFikYXGm0@boxer>

On 03/26, Maciej Fijalkowski wrote:
> On Wed, Mar 26, 2025 at 02:12:17PM -0700, Samiullah Khawaja wrote:
> > On Mon, Mar 24, 2025 at 3:32 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > >
> > > On 03/20, Samiullah Khawaja wrote:
> > > > Note: This is a benchmarking tool that is used for experiments in the
> > > > upcoming v4 of Napi threaded busypoll series. Not intended to be merged.
> > > >
> > > > xsk_rr is a benchmarking tool to measure latency using AF_XDP between
> > > > two nodes. The benchmark can be run with different arguments to simulate
> > > > traffic:
> > >
> > > We might want to have something like this, but later, once we have NIPA
> > > runners for vendor NICs. The test would have to live in
> > > tools/testing/selftests/drivers/net/hw, have a python executor to run
> > I agree. I can send another version of this for that directory later.
> > > it on host/peer and expose the data in some ingestible/trackable format
> > > (so we can mark it red/green depending on the range on the dashboard).
> > >
> > > But I might be wrong, having flaky (most of them are) perf tests might not
> > > be super valuable.
> > 
> 
> As you said it's benchmarking tool so I feel like it should land in
> https://github.com/xdp-project/bpf-examples where we have xdpsock that
> have been previously used for benchmarks.

I don't think it matters where the tools live. I'm more interested in
the general guidance on whether we want to continuously run those tools
on NIPA (on real HW) and track the numbers. Unfortunately it's gonna put
extra load on the maintainers in terms of tracking and acting on failures,
but it feels like it's a good direction in general.

