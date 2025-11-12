Return-Path: <netdev+bounces-237919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B2C516BC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4709E188D692
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649A2FD667;
	Wed, 12 Nov 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVB8SZcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F82D663B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940511; cv=none; b=gmWLjWUR4DtKUzmLYFzLqRysHF6kPG2hi2wHTa11rD/MigZdnuTwY7L5PB+JvDEm00dyseVRGFxB23LeKW71dhyq5l1xUfFjfEjAdRegs+h3EdEhj+iwBhtDzO9ql8ncDqmVs/dmG+a4KS+dZe3HHxDSM7P1SxuCEi3Q1hn7Aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940511; c=relaxed/simple;
	bh=JzWa5cmpuL02EcwiyxuezlKJmiY3ZEmIe+nFZo6Oovs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppYixyNjBAW3IGJxYWEvb3ZS/CXz8Q/m2i104/OAKDP2jhm9E84gd/+fNRAxdRg/JmnRevQwszo9QHJ+A2ehVeCLyBjkl1Iygi8/odYkD75dMYgfBv/BceFxORgeDP8UpA5m1Fuq06I3C9QEqzxXAjZ5MV6mG7afZvCKl4pN/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVB8SZcV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7810289cd4bso639740b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940509; x=1763545309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujwbOpQwkx0uyDLqpzauiYWcelx5Hsb+Va99s0w54ek=;
        b=LVB8SZcVNI28MFMqR5FNganLlCpCzcEfGiV5Kan9RBs0rjQH1YWtxmjdjYeW8UWjtI
         tRNBTglXmMIjdhmufGoKnGq00T7V7AHgfZZle+tqhxBEHmrb8fA3gg2yqhJeVbaVQsgb
         31UkNfR/hIlB0xjJDXhZsrQEGG49Ejf3iEwIHjURlrVyngM/j1UpicYvVAkuMdukRara
         pAifw79o/y1g3FuFk5Hn0z8ntXjKJODo32QcCsK70yqkNxhw6uRL2qKWXW2/Zxeszsh3
         3t8ZKA4vh0i0dGfDn4U2Jn/wuVvkVOD07GwoHSpvEfNJwFMxnOrm/wWUppO+oyWs9ojV
         XRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940509; x=1763545309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujwbOpQwkx0uyDLqpzauiYWcelx5Hsb+Va99s0w54ek=;
        b=q/D9h/N7PkjQK6Dr0ttOvgi7n8caPUVuh6xqN/7icFttPiQ4OGASyOnh1qOMAYCqlv
         SC+qT9uB/5v8uhISkgR6bR8P0XJfuBz/rfErT0XRDcsM9RdZF0zNfvUlqQAkVh9GLOzr
         JYF63+OEtrEBK/QYENqELNDp759gtG5kNfpquyOh/EAWf96iIXOM/IyT1Rue/S+9uELV
         iPCwTDZDX1WPHTjQyQDIgSrUsWCoKKBNDaaIzO6jdYKuVbxEe55kknpL9GXQeWrL5gjn
         7BEgYPuEtBHuyKiuOvs3oyR4xCc+atJuftxK8PO48L3ki+QfrZ0uouQzLpkDp8XTZv+O
         eCOA==
X-Gm-Message-State: AOJu0Yze/AmIorXSncXYA9ZU83uIYJqgD4qSRUxDimZ2dwDoNEtVCsdO
	xJ+J84+TG+t83deAxgSL9GzXHwkwV82G6udCCOfLKFxv5BUqD/HFzCq0kj+o+yN73Vw=
X-Gm-Gg: ASbGnctghljknMveH7ahdm7cj0mVVQ1U6TczzcUNoFfFr8TZfsqmMCe8kAvgj2dh9cW
	kQRcugUOLOEmBlazDeLIR2+bqVbUInwtP88dUFymw7BqiGTf0P+X1UbduPZ37n5JdSSw7fBaDUf
	qwwWULaeMWKNoPXRJUTuANkAc+jFHKTxkf9mesMm1K4ZezZXDwnk8MoBQdoGrIwaDv6RZpc6Ssb
	f733kWU7S1EuNQMSWp9Yhx7zLQc7nrNqkOK78vBMVuGPjF7WGxtYMJPhO6ewyM9lGBSsXOui7NE
	vB4l6F8y/DaTPio2A7mAywbx+tDDhCSL5PK0rgBlGFvSlJ4V3n98raVXiIt1/HLJeMxBbR5p5vU
	hnCzwoAG6uewHnKkhRmbie6WBov1cTRtQYC85FAbWR/xRMrX8lhSojhbm0NQt5c1W5hPFWyuQ4y
	rWn+wG
X-Google-Smtp-Source: AGHT+IFlN7zA0sO9S824wzejbKS6M3AXrKyVevna1fRk253SlETWibSX61HjTzzCjzwRGiblzdnbPA==
X-Received: by 2002:a05:6a21:3392:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-3590b5060c5mr3260910637.45.1762940509566;
        Wed, 12 Nov 2025 01:41:49 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf1896a115sm2247871a12.37.2025.11.12.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:41:48 -0800 (PST)
Date: Wed, 12 Nov 2025 09:41:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	m-karicheri2@ti.com, arvid.brodin@alten.se, bigeasy@linutronix.de
Subject: Re: [PATCH net 0/2] hsr: Send correct HSRv0 supervision frames
Message-ID: <aRRWVkY4LghIA7RP@fedora>
References: <cover.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762876095.git.fmaurer@redhat.com>

On Tue, Nov 11, 2025 at 05:29:31PM +0100, Felix Maurer wrote:
> Hangbin recently reported that the hsr selftests were failing and noted
> that the entries in the node table were not merged, i.e., had
> 00:00:00:00:00:00 as MacAddressB forever [1].
> 
> This failure only occured with HSRv0 because it was not sending
> supervision frames anymore. While debugging this I found that we were
> not really following the HSRv0 standard for the supervision frames we
> sent, so I additionally made a few changes to get closer to the standard
> and restore a more correct behavior we had a while ago.
> 
> The selftests can still fail because they take a while and run into the
> timeout. I did not include a change of the timeout because I have more
> improvements to the selftests mostly ready that change the test duration
> but are net-next material.
> 
> [1]: https://lore.kernel.org/netdev/aMONxDXkzBZZRfE5@fedora/
> 
> Felix Maurer (2):
>   hsr: Fix supervision frame sending on HSRv0
>   hsr: Follow standard for HSRv0 supervision frames
> 
>  net/hsr/hsr_device.c  |  5 ++++-
>  net/hsr/hsr_forward.c | 22 +++++++++++++++-------
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> --
> 2.51.0
> 

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

