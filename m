Return-Path: <netdev+bounces-236546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04AC3DDBE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F09F04E061E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6630C63B;
	Thu,  6 Nov 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SO5Z8Nw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43962EAB81
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472024; cv=none; b=FscMnp/DU4fdrD9gfmzFbjzbV6nQj1Hojq2D4mRvdk+QU4mZr+vOhHW8dHwUQy3Hh26yyjacot69si7LaIlp2AIgabMORJoAmEudLAr/ND0QqOTuh0hgs1mugazZNMyBeSGW0ikisusdnJUW1xaIXX6burP3RhsTf+v64jSEhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472024; c=relaxed/simple;
	bh=uVa+80SqJp0y0RXeeFiN28qeU835AOXtHIdVY/1wNKc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CpOYa+vN7FFNSQ0SQCEdC8CMddFZTt++dPxZEetATA88GlCEqCJnteQh8g6+tAfL7cW5gPLNodELBxtxJo8WBwM3iQJiZ0CqejaT+68fSMQRbRi3SjW/AVuBx0dUD1Gj8PAajnxjfj7zt3yrV6IoshPw4UHwBiUDxFLWDSvIBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SO5Z8Nw7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-880438a762cso1225446d6.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762472022; x=1763076822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+pBzK7/wpXJADn0lLoNWn0nWhhGMwMp4Bi3akJQRuo=;
        b=SO5Z8Nw7QC83kFEa3nHqUWqRSMAX85wFAz6ml/DVJjcg/CBpmAg7tuIHz2cn56LrGj
         4rB6uKfitRX+3biIMgC75OwY5FOPBCb8IlUKWoGaydNKgp1GpeQqSNRni1Zt/PKUb4Su
         xkEvd+0PjA0KQhT9hw46Ek1vhFF4dCXSmT7SqxsvsWxu3dBq1ljfE16tqxl+rKOOymD1
         KWoJlEQB2Q74RuLMk7fx6BOWAyEsCqv6Z6pXc0kiY+uLNAjBKJbkTN7YXjo9xJG8sXbl
         xZqNpnb/ogn2SYQDqWL+CTBx0hQFWBzpujn/DHq9ypTOn5kFLH6DwIpiYKNUEyPCAouv
         i+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472022; x=1763076822;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+pBzK7/wpXJADn0lLoNWn0nWhhGMwMp4Bi3akJQRuo=;
        b=iswFI8zxCx3OLfzEtvDamEKck0y444ci/95KeN2dU0v4Bz8FK01mlLDqORgaNADnK8
         kuBJuUg3uVGoooIbUhMEYQYjPLyXh5ZFvXvl8aky7tU4a6YJQOlMwIi9MRj6N22pFYdg
         24JgLEwwtaCYDnezxSFqDloaaf8rk+nT2v1AygQuQJ6s8Xy1boGa5wqAhq/UGDfU5JAe
         Az6Ni6LOOX2g4cg7wjftfa0j39G9YvCsTtdAFz8sNm2do429uJQRNY6pFDpzdTNV7LhG
         Vfh9GE2Q1cwawKTykXmoXYkJQ7PklC2L4QvVVVfFc6YYbd5l2b4bBifv/Nc7M7EKvIp6
         qKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4UdIE3gxFtBIr3y5BhNnN8bjMJoEyy7LLRmNlsehZnYCOKyI+OzZI5lq4/zGegFsis/mDhVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOJHTaUwFS2Cu27SXhTqzBdIWzFfMN2L8PEXGUlPqqpDmRwOh
	LciK9VWtQ1kEaQ+2ni9bdmis6qjGqGjQeMI8H8F9csWerJzP1M/n+Bb9b1MT0UGY2Vo=
X-Gm-Gg: ASbGncubtGtb0KXR2lKpsmEHWGmyyCnAk1Vx45zPp8Lq/jk/kjP2I6aFZ7BB8+T8sob
	DMUkA5JujKB9Obyc72cGJs6JdicNB9Js8voSsIyH0COsgh108nOlUXS3QFjAd3l7oLh0XxRCzPz
	dUml723HJrvvBauE/gRd6Pg/IWzzQHLfIuEdtGsrZEj6WMK5rUGiCutjNIM0K0+Xp+BA80oDjWk
	Z4hWH2vcb1Mx22RHj4wvAyyEP3I1iMFsTpeUr1h+nzx/Ao+qj/xl5MFO+jsZn3E4Qu2fmRvHZwd
	Q9vZF/w/Hs9N75y94faQ+EF8lUXFJJSoEM5gkzgWg6J8VDz/6ahXlWsWdAsYxGfSqm84Clx292C
	AGR7jiCcAVVzQBPN0aouTedFuBNmw+v/JJSkSMPHfsUKOY+gZo3UDtEzkbTXfGDT8VRxMw0E=
X-Google-Smtp-Source: AGHT+IHPKDYPPwfhjep5UH/Wn3BeC7cqCWtW+YSHn4/RaMpF3isc03s23Ya/Ab3MhZWrU8KdcUe0Bw==
X-Received: by 2002:a05:6214:dce:b0:880:477f:88eb with SMTP id 6a1803df08f44-8817678c77cmr18435436d6.66.1762472021649;
        Thu, 06 Nov 2025 15:33:41 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829c83edsm27627626d6.31.2025.11.06.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:33:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 David Wei <dw@davidwei.uk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
In-Reply-To: <20251101022449.1112313-1-dw@davidwei.uk>
References: <20251101022449.1112313-1-dw@davidwei.uk>
Subject: Re: [PATCH v3 0/2] net: io_uring/zcrx: call
 netdev_queue_get_dma_dev() under instance lock
Message-Id: <176247202011.294230.15780174146072373826.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:33:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 19:24:47 -0700, David Wei wrote:
> netdev ops must be called under instance lock or rtnl_lock, but
> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
> Fix this by taking the instance lock using netdev_get_by_index_lock().
> 
> netdev_get_by_index_lock() isn't available outside net/ by default, so
> the first patch is a prep patch to export this under linux/netdevice.h.
> 
> [...]

Applied, thanks!

[1/2] net: export netdev_get_by_index_lock()
      commit: 0da5d94bbc6af079f105264849dc3afd01b78aaa
[2/2] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
      (no commit info)

Best regards,
-- 
Jens Axboe




