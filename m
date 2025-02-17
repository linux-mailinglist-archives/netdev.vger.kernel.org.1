Return-Path: <netdev+bounces-166970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B856A38352
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C47A16A96D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969D21C16D;
	Mon, 17 Feb 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZU59D6wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026021ADB9
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796373; cv=none; b=KyO+OZPOzmubLCVnCtCBQr/YdAmm3D2w3DA3nwbWbBJr5p8enPB5CPtwHI6+NbfRR59B26WQjZpHbWNq+o4peVQPrKrFSWpi6R+PZ1RwlaSFnvEzMdCOiiTL313NJiu6rbqhInXjqpAnsH0XVaXJiNfdvptp5UuurNUlZuGVn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796373; c=relaxed/simple;
	bh=6UxApZbLBGau6S5atdSL0jd/Tar6i7kAvdFASHuiDHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MlJ8y/vy4xvkgKUbGuuBakGiboRNgMmbGD27wUCUFN+zmg/uTuKlh9Bflo03mSOXWYSiKS6i6CJE3xASs4mBB2dkWVBWfLerhX3Wexk0FdbzTCkIDhfJXbn/2csbXejkvelbm7kxfEWQlzvKpcGwrCWmCTl2TH7Fh+DzkhHnBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZU59D6wk; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso10785625ab.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739796371; x=1740401171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imuHlOVGZN9G1+b4pMyAik18tnwHQmcoRbN++9g5DvE=;
        b=ZU59D6wk3RPaFGzQRMhx1ODHyzGzNI+3y+JCVIgZZ936L3esVZWW+pCHald+KSqI+G
         wQ0ZZ+9PdGxGSNhRAzdmGFsXGQGPV7GTf394mAsZaEFqzUs6NUr3iNqdFLGehZ/YB8Ah
         PWcy7VP1bnnI3XPP93/RfJVkqtH9wh2YrF335s6SGvOQWXw3MAbYf1urdiA3RFyPSrnc
         tKDXCWY/Wmoj/SUGy+u7u19rw3lmFQicMq4OGYH2rahvC838pPhgVxT1pHjD3Un28Qk+
         uHqUZmMhtOZyP/NMM2sqPbFrKFz23tAnd52ANeKcnTQEZD+rbIWFe8DvkVl7TP2wNfuk
         AKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796371; x=1740401171;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imuHlOVGZN9G1+b4pMyAik18tnwHQmcoRbN++9g5DvE=;
        b=Hvku+CLzwJsmxVzJxIB7b6PMEu2V/+XzbQmPBq74lhTXwypgc4KDXmIKX/8TvYciqk
         jh7gmPH0T8ULDY0y6kN+yVaHs3jxcXWz75WSpbpJYWEYSW6t3CD4hCyL/mDkEHvisCen
         /EwlMLGNU2tyigNWx9ioLH2LI6H0e/2Mzk2TuSJA+Cn8nnJn+Ems9MtfSnFEkcmYso3L
         oyqin6+dAj0Yyfgcesvp3AgSpEsp8//M9xwJ9ICnfOrV3VPpIMyCkzmHEYqeVx/9ReE2
         TbZnQt2r/c5lbX4GlPdZRNveB2mFFg7RPORRivvcm84yJZHXKLj9FM1ZaC84H7NRmMen
         tSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWfufPoWWx8UWZDi+IIMh3VGy6dapBooOJ6rI/8OMsdaNBLr+AMTFViy1CHFjLxsX6iTSx+Jh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCoLFBsSF9osPNtyZfDkoquYz3t7wEn+tDJa8hZoZ5yZu5dJ1D
	otLdFaXxGubrxdfT3Bxn/JB2CuN+Nh1NvXYis+lF2O4pb04zf+gQ6qmoaTbJJm8=
X-Gm-Gg: ASbGncuZ+jUsFRDiUpvVgnoQNUV6vQKBjwfKjzPQG2E87af3YqL2vpjUOVcpW5pItVQ
	yxqIDhgUXFZyjN0T3G/fFegm3P/Vlwa5nLnrpIwLC2Vn332+Z4SrPA+ql9aXE5vh0YemmxhDfK0
	A6eNvYm0RMZMTrXFSVUegCQvMuwR4TQa/ZSu8udturR1V8e5uzjUpB8CYcdl+ONDBaYxUJXr8fe
	oFeNDEye9Bs66GhL7CBDsYkay4v7bRR8EoSOBrepgXleuIOMBs3LE7143vT9zQ5Tbm5txeO/QEu
	5p2FCDQ=
X-Google-Smtp-Source: AGHT+IFDTfs1Vxn2hjyHtnEBa1Q+Vakh+5p/Cg6QDyXSbnxDmedJ2oPgTZIB/21B6FFdPIg27A2ReQ==
X-Received: by 2002:a05:6e02:3488:b0:3d0:101e:4609 with SMTP id e9e14a558f8ab-3d2809df3a5mr81794695ab.15.1739796370934;
        Mon, 17 Feb 2025 04:46:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee81857773sm1247159173.66.2025.02.17.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:46:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 David Wei <dw@davidwei.uk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
 Pedro Tammela <pctammela@mojatatu.com>, lizetao <lizetao1@huawei.com>
In-Reply-To: <20250215000947.789731-1-dw@davidwei.uk>
References: <20250215000947.789731-1-dw@davidwei.uk>
Subject: Re: [PATCH v14 00/11] io_uring zero copy rx
Message-Id: <173979636951.644986.4694104673663127682.b4-ty@kernel.dk>
Date: Mon, 17 Feb 2025 05:46:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 14 Feb 2025 16:09:35 -0800, David Wei wrote:
> This patchset contains io_uring patches needed by a new io_uring request
> implementing zero copy rx into userspace pages, eliminating a kernel to
> user copy.
> 
> We configure a page pool that a driver uses to fill a hw rx queue to
> hand out user pages instead of kernel pages. Any data that ends up
> hitting this hw rx queue will thus be dma'd into userspace memory
> directly, without needing to be bounced through kernel memory. 'Reading'
> data out of a socket instead becomes a _notification_ mechanism, where
> the kernel tells userspace where the data is. The overall approach is
> similar to the devmem TCP proposal.
> 
> [...]

Applied, thanks!

[01/11] io_uring/zcrx: add interface queue and refill queue
        commit: 6f377873cb23905009759b7366b9fe85c2a6ff37
[02/11] io_uring/zcrx: add io_zcrx_area
        commit: cf96310c5f9a0d542db99c887742811425ba2ec0
[03/11] io_uring/zcrx: grab a net device
        commit: 035af94b39fd13751abf5f0a2948c9eddede55d0
[04/11] io_uring/zcrx: implement zerocopy receive pp memory provider
        commit: 34a3e60821ab9f335a58d43a88cccdbefdebdec3
[05/11] io_uring/zcrx: dma-map area for the device
        commit: db070446f5af8c7a384b89367a10cddbf5498717
[06/11] io_uring/zcrx: add io_recvzc request
        commit: 11ed914bbf948c4a37248f2876973ac18014056d
[07/11] io_uring/zcrx: set pp memory provider for an rx queue
        commit: e0793de24a9f610bd8ce106f7033b3966e7fca0e
[08/11] io_uring/zcrx: throttle receive requests
        commit: 931dfae19032d13266cf1fac080cec66469a2042
[09/11] io_uring/zcrx: add copy fallback
        commit: bc57c7d36c4c9c352ed13d98a4f1e4dc27919d6a
[10/11] net: add documentation for io_uring zcrx
        commit: d9ac1d5fc9510a170eb43e8c129b8e1cd5e1c3e1
[11/11] io_uring/zcrx: add selftest
        commit: 71082faa2c648a2adc1167b37565e195a8df1bc7

Best regards,
-- 
Jens Axboe




