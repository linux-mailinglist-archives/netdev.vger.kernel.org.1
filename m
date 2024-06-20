Return-Path: <netdev+bounces-105096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4BE90FA54
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB811F224BA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5DF184F;
	Thu, 20 Jun 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm4UImDw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0521859
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843642; cv=none; b=heUNKOI37Sd5ZNMBYDNfYiW/Kn5RoEXPmGJ9LyGhQkBLxojLNMoJXanmvqfkhualDBUJH+kAPpyGpOQyQ4gTXRQCVNlp/f3BDcvr0LbS2dSz+fRpQIJ1+DuwwkexM8IuNGL5ODvOaK6UZlf+ck/0p3fM2xFZV4FYmuiBdb2ZKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843642; c=relaxed/simple;
	bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzLNZsjsmGPyb/Yv6TktuzVKGAmTAJWlPUgGVzxlHUJ3FRYKB8m/IwwQwXNlPyKk7tDtOs/xr/YaAnQb1PVRyBwli202rqkVB+/Pt63QMWJlC93XN1xE6W3VyeLeB10+gwizXYPs50CjenY3zG8YNoR9J6jRIxyYDKwE9h4S4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lm4UImDw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718843639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
	b=Lm4UImDwBzz2oLrxwB+jwdOTZ8kUVglLWHISUdzPDHwe1zfff+H2O/Pb3G9+Ahqvb584Mg
	4L0E05eomDmIa2ZR6yJG9VnNVeJYcntRd2v4gEtLfsY1CQf2PcBeMRM2E2DGwJpBk6ARDZ
	o9h1fg51Pm4a/r/JYLX0YTsuq3su1A8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5gn9S1r_NN2Gdb0UmaLO9w-1; Wed, 19 Jun 2024 20:33:54 -0400
X-MC-Unique: 5gn9S1r_NN2Gdb0UmaLO9w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7eaefaf08so142289a91.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718843632; x=1719448432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
        b=az1BQSOo+v8x9OP/oVi/W01iWkDq3L9qcs1v9j0Y30m14kko68px9Far0VkULTx/+R
         eNnMzH13J5XgTI7q6PQjTMTvMpLwLF9DpTJnd37Xw4yum5UVv5sThv0QwyCXgY5OH9+U
         WFClR7ySAGAd41oUrbT0206vKT+uW1rB21C4cemDQbLeyMxRwm74rUqCdLWIiszkWdNW
         wsTpgH/Lw2REP3sEU16FxgZ5eLKjdTJj4FroLVAG98t+y7E0s4MFVt2xJbjqCBrM6DB3
         lHG1/QWq3gSuDG2xGU0hG8aPXjBsJJJAfZGFfGVUlgRYo1VGPh4dUzSqv5Vp2+pyxJsS
         m3kA==
X-Forwarded-Encrypted: i=1; AJvYcCU/q4dPZ5X1msBzNARF44YXBUsxIe/xzjk1NVNJuaEHXF8dUQLDa2VE1quUeoEvHEAFb6fcN+Q1QkuFBdhqWPJcaNtHGaMg
X-Gm-Message-State: AOJu0YxeczpKeFJu7254W3fDqsiPS7uLUBqYXqKDhiPmTFw2Fe5X2uS6
	iTLPWxIAJX1zM2UypYnwpAxV1Gic8Btrr6XaWj7JIf58yZtNFd00rmpgvz3204JyhyaUih6/E26
	uq801NfmvtfRyyc5S5h6FBTEGiJitxLo64NBba4nM7YDTJ5MF6yZUryd3yi/Z1ShbB+5BPpKdvx
	jfNvIEq0n6GQP3dhtZgh07aykW/5ln
X-Received: by 2002:a17:90b:104c:b0:2c4:caa1:5e3c with SMTP id 98e67ed59e1d1-2c7b57f3271mr4227852a91.9.1718843631976;
        Wed, 19 Jun 2024 17:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq+Z7JSIRE9JqtdLNc0Ec8Z0L7R4p1vPsXN8rKEfVUHHCJEjYvMlAxMkD+6e/BB2Yt1IRjsLNE1R/orwtgN70=
X-Received: by 2002:a17:90b:104c:b0:2c4:caa1:5e3c with SMTP id
 98e67ed59e1d1-2c7b57f3271mr4227840a91.9.1718843631428; Wed, 19 Jun 2024
 17:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619025529.5264-1-lirongqing@baidu.com>
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 08:33:40 +0800
Message-ID: <CACGkMEvJ2HUaRW49NBv-vnDXPkUuv=c0-pcnCk9E=tV8gB4UUw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:56=E2=80=AFAM Li RongQing <lirongqing@baidu.com>=
 wrote:
>
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
>
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


