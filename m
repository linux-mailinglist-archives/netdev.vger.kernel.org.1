Return-Path: <netdev+bounces-218898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DBB3EF8F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC5A7AE6A0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043425B1CE;
	Mon,  1 Sep 2025 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK+4NMdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B121C163;
	Mon,  1 Sep 2025 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758366; cv=none; b=NpsnDBRc0QfBTwbP4/YZNoF2sHIiN8jysZ1D4Juv/NGImEr7vqum5RWEvDMVzlqSV993ctNrDo7eW4FYNumLn9S4mqHXVKp/CjcT1cXRrsjKjFxnApvB5F8yGH27CW21JLkF5tzDXwctxUhTyogxo41OB0InH9MclmJr85kzHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758366; c=relaxed/simple;
	bh=HSzKTvbAycoKDXCL84Xg2m4JzusqkGWLVEio6LmMQq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIwN/qsQzUAVvxeCro+3uTaq/12VtHbsfsMSA8fVT2LJfZ3lhkXpVeRilSkxKb1J7kvjtrZeqFT+UMBPqsE3DlgUqbijCkFvaPTrZeGejdvCczYVygLWfLcxqSk7jtT+jQ4FYlMMWwHgUEsAEOLL/6LU3jP/2B0uzBQiVGDOiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK+4NMdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCCC4CEF0;
	Mon,  1 Sep 2025 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758365;
	bh=HSzKTvbAycoKDXCL84Xg2m4JzusqkGWLVEio6LmMQq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hK+4NMdy0WH06e7/xNoWbkHEuYGIRdXCdQje7+86O+/EtOuX4VsHsTeIuY4QSG86s
	 bJ87dabIqpegLVQMJ2KBkaZWTe9qdJ7pzfOZ9BPItd7wy59yeWYcWyH31raVzlK8gY
	 CurBAVpYYkitLDOxeqK7BjibdeO0lX5drMYB8yaEhiT6QMDGkCMHfL0juYKRUdHnVP
	 ZU5l3j3tw2YVIyJcGBMgkSCHddPqfF2F4Pj6x1DwQiEuaNZS1ygAWn7f7ETVMooEwR
	 y77lm6VmB9G16W9qfF5nxiZT9aMSo2/l3s3y9lk0lhVGryuEjQzwwmq6G5Gwudkis/
	 C5e+1NtCYW3mw==
Date: Mon, 1 Sep 2025 13:26:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] net: stmmac: use us_to_ktime function to replace
 STMMAC_COAL_TIMER macro
Message-ID: <20250901132604.6706ac82@kernel.org>
In-Reply-To: <20250829064722.521577-1-zhao.xichao@vivo.com>
References: <20250829064722.521577-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 14:47:22 +0800 Xichao Zhao wrote:
> -#define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
> -
>  int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
>  {
>  	int ret = 0;

There has been another change here in the meantime.
Please rebase and repost.
-- 
pw-bot: cr

