Return-Path: <netdev+bounces-122090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2195FDF3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06351C2114C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9E802;
	Tue, 27 Aug 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="f5LZyku+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB551FA4
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717963; cv=none; b=qW5dsS2wClgs1TJdALPW0yDDhEEAMVOFkJ/gUjKcJ07cw0m8OlXChoeSSU7a6WxNDxXK3bCQLQhccXSRDCzXzm1lIz/u6wtEO/wJymSi1QYGWupwy03XnwkQcIXv1Qf+Wv+1O3q7AosX1RlfLGVr628X8LMcGZnZduSNa9iBOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717963; c=relaxed/simple;
	bh=FxGMeRyWSlt8qmgkJSUx2Q0BYH5hVrhUn5fQVXOQYp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF9CMpiWg3ImTvvFBrHr5rm7obl0sG3qb23oRzAEeqCPBD7/W4jvucOHPw5GUTBG7pYB0+oKTLLlSnUl0c53YR2OqdtqOSrYQZcW+RFH738I5te8/TisNSIab4UZ4sz9KUra/exJV72GVFji/YtbSBmlDcOqYHhPmOOTFRVhqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=f5LZyku+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3da94f059so3387308a91.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1724717960; x=1725322760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHl71JHCuvA/VjksZm8ocNbN17JY7/DIpAEt2j1O0E8=;
        b=f5LZyku+m45Zyg1bhUX7eLO7Qws88fV59mowJVKGfEbqaoWGTcwFVFjY/TqpaYDm4k
         NiqBxqbYnt/5mHp6cnspRg5IYgZzQ3X09ZJh1U/gEXFz+kwUuBYnhTSfjxFQ6HnWSRKY
         8WCjapD9ogRzbbnkejOg2TiudU2txLbfN+emKeWJo01lnKtYDfDNjLpz+tDmVQ/Hx5Op
         yQxe3QykgtQeRSiYFJfZLrFRI6mB1igOyzHKTxKm19jBij2VCWueEefM22fPDrE52o7f
         GBhpsfC0fHvq1KTDtSrIxKTdYf/pTimeCQ7YCgydRonIcOlcm3/mtpvWULygonQAvzaz
         RnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717960; x=1725322760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHl71JHCuvA/VjksZm8ocNbN17JY7/DIpAEt2j1O0E8=;
        b=fZ6H2Tv+hwU94ePlTMR6Bf7wBT3EshbBv3UQrL1nhzIbfLdvSwy6sY437z3kSpMjP+
         wYyyR6FxAP6+X4cjep29UoA8FN0bOioDtXGD6uBqc/XV1TsIBJNZ3iYz8j2R4YXBtnAo
         fw3OdXPc3JEBLpFB0xKVR2WtXdZ5LkzpRvR9Us8rjbkSTSprWBGl1b4gFUtFeYW8qi+G
         Zv4lDtPAbXuo3KJgtcojGwC7urL5UFQcsHevC3+ZpAXv9i2TFsiu4o1sKSA0ZKj87S3/
         s74fgM9HGgjRjT93QZhCNiyCLHYqNCyxg5GDhoCeAaN9GLYWucKouNbt/EeILkaUkPrR
         NDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWGQjvqPjMqITsev3wRpi/bkzFnoKNT+PZ92F6uWt1+SYQNWs2poL03PJ5svqGppFLoiyApJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMXeENwauGylPeiUcnqhxLAFTCvUi56GNmfG/ffM+48BzcscU
	uSt+77GkUkJcwDc04DYdHaIL5j8WsfFtvgmGjyr9FKehuD4z/1LY+hQ3y3o6IL9gPDD2k4aAwMN
	alE2LpA==
X-Google-Smtp-Source: AGHT+IEAc4i9Ay8ONNFATsT7xd5EcMWKfg+fSBt5gVKFxPp0BTIiE/tb6Jc3IO0glaNFPKKDpjk7Bg==
X-Received: by 2002:a17:90b:3ca:b0:2c9:7cc8:8e33 with SMTP id 98e67ed59e1d1-2d646bb298fmr12601117a91.13.1724717960562;
        Mon, 26 Aug 2024 17:19:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1cb45sm10566157a91.52.2024.08.26.17.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:19:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:19:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Liu Mingrui <liumingrui@huawei.com>
Cc: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH -next] af_packet: display drop field in packet_seq_show
Message-ID: <20240826171917.55444272@hermes.local>
In-Reply-To: <20240826092625.2637632-1-liumingrui@huawei.com>
References: <20240826092625.2637632-1-liumingrui@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 09:26:25 +0000
Liu Mingrui <liumingrui@huawei.com> wrote:

> Display the dropped count of the packet, which could provide more
> information for debugging.
> 
> Signed-off-by: Liu Mingrui <liumingrui@huawei.com>
> ---

At this point /proc/net/packet is a poor choice for extension.
For example, ss command ignores it if PACKET_DIAG_MEMINFO is available.

Better to add new netlink field see net/packet/diag.c.

Maybe time for PACKET_DIAG_STATS with name/value like ethtool.


