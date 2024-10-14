Return-Path: <netdev+bounces-135220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36E99CF20
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9626B1F22B3E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F571CF5CF;
	Mon, 14 Oct 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhNta/wC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23B1AE006
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917258; cv=none; b=b0u22tx3YTTlu+pefdMC8SYWL37dzwrmYv2hG6nmC945CUoCe7co2k4E36n3ioOc4I40oovVRNsxd7dgisJwawsjx5aZ2FvQqgiqxykj4a3FdF3VGXH+xcXo1m0eKRQN8dWKbujmlReZCFHYDfKzhlDhDg8fQCkolZ1cj4bCK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917258; c=relaxed/simple;
	bh=doj0P5GhKM4YIvj+TDuAKBnEepWgnnzHNTT95DMXkbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5zYZGj/BY/trzBe8FF8e97A45yj7iPZV++7BkEKUzfpnLO//NdZWmJxycJ63mir4UcoXN+HV10D+P5t+2hvtlR6FEaQVQ84aYBxsKnFbe8q2mXG0e1YPEJEktpazPiiDemctJX9f0s/jC1f+jlyodSzus4DQKCDRmV14PsiUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhNta/wC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e52582d0bso1382519b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728917257; x=1729522057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+SOYGG18L/eqmyP2BFsCgTBDLF3yHS8aNOV5qOU8R4=;
        b=BhNta/wCMvA3X9eoiqcNX/0ZA0GaOzSNdd3WHyqg0rUbnnbbzDy/XkHGOcGP05Harj
         ET26pgxRO8Ylnm5xFSXiazrE05MDONTi5krCcLbSIcSmlqfIiihZOaCorerwthX1osGO
         d+IZc19PAf+KzF+LlnXlMl3AkUbNY10Qc+dBypsf8Cy5aes5ZpuHKiRbpN7XHqWhSItV
         6MrjVFRC4WJFqHgwb4hY1vrcMFBxh64RsSW0N1fuRbRVFJ/S9HFApkQ/IS6AdDER/EzP
         R3fq/ZkmdGS6ayUPftjVhMkJlxPVteyj5Asd92X4pnUuqjU5siVjm4l4UUHsGI+cqHVU
         DaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917257; x=1729522057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+SOYGG18L/eqmyP2BFsCgTBDLF3yHS8aNOV5qOU8R4=;
        b=N7HG9KmKaTP/2iqfUc/8LVEZ/sHzpWeHHnL1q+wBc5oIm8AO1rkmZO55umhEGERPyU
         FBABQiezNoPbewyK8e50vQAczHBOUGNWs0JUCfzodvPYoBAJzGYdbeD1UtJw4Dhsyj+t
         xlPZNMtpfgucPPUxU0rNK1QTxUep/KmTOnzhS9yYf+KnV+uP0zYkTMva2B99+V6etboL
         Q4NE81J3QcpzRAj1tWo/XEfhOsRYVbB7GoYLOSJdI8zSI60rDGFdOsxCPtVMcph8Cok/
         rPqdin+0KkzNrYYUWijHJeLhdqUH+qvD4l3o9trjqT99xdOH8fujozCSEfJ6uMFGYFhc
         gwzA==
X-Forwarded-Encrypted: i=1; AJvYcCVcijsXgxZZ/Vj7gsGL50Z4UAeI48gulWR5MFhVnd0PlmbXuEcY0pFgfjiScwAhXGyn/0NNGaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6G4QxmKGllsNb7vL7isaDzdvoAPz/Fc2eo2inAlS/3xcY0rF
	nHZcrrpQHFPxeIPqqeEek79af+ROcBZGko3j5dlm2LNVDVpR2MoF2AQd
X-Google-Smtp-Source: AGHT+IEdn/Pt50YyqH/6AYFzofmbnErNXDIc5vzdlaIUW+dHFN0Epy2f5RQlYhLtct+OhdwAPBxztA==
X-Received: by 2002:a05:6a00:2d26:b0:71d:ea77:e954 with SMTP id d2e1a72fcca58-71e4c17b537mr13444538b3a.14.1728917256555;
        Mon, 14 Oct 2024 07:47:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e576b2020sm3827506b3a.102.2024.10.14.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:47:36 -0700 (PDT)
Date: Mon, 14 Oct 2024 07:47:35 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <Zw0vByssO2j6wfxI@mini-arch>
References: <20241009171252.2328284-1-sdf@fomichev.me>
 <20241009171252.2328284-10-sdf@fomichev.me>
 <CAHS8izPh7kwnvQtxwqGxka_rOe0fB21R7B167j2guJXkve9_bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPh7kwnvQtxwqGxka_rOe0fB21R7B167j2guJXkve9_bg@mail.gmail.com>

On 10/12, Mina Almasry wrote:
> On Wed, Oct 9, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Use single last queue of the device and probe it dynamically.
> >
> 
> Sorry I thought agreed that multi-queue binding test coverage is important.
> 
> Can you please leave the default of num_queues to be 8 queues, or
> rxq_num / 2? You can override num_queues to 1 in your test invocations
> if you want. I would like by default an unaware tester that doesn't
> set num_queues explicitly to get multi-queue test coverage.

I might have misunderstood the agreement :-) I though you were ok with
the following arrangement:

1. use num_queues / 2 in the selftest mode to make sure binding to multiple
   queues works (and this gets exercised from the python kselftest)
2. use single queue for the actual data path test (since we are
   installing single flow steering rule, having multiple queues here is
   confusing)

The num_queues / 2 part is here:
https://lore.kernel.org/netdev/20241009171252.2328284-11-sdf@fomichev.me/

Anything I'm missing?

