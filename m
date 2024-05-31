Return-Path: <netdev+bounces-99610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260D8D5798
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB81F237E0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684E5258;
	Fri, 31 May 2024 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhNdVI1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1924A32;
	Fri, 31 May 2024 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117797; cv=none; b=CJazmRfXp7fVlBfe8Qako2VaEy9XE4608ht0k3tiQJq5ZzTUJ8xBURpo4LXP+EWgQav+Dq1N1X8E5f9/za2cP7FuZOL55q7dBcBLO/aYprFYU/Q/vxL2ubXKR1ZnGNzDUhmjFDFEz3xB1ey5TFaap8e7WqIGs09q+TSBXSkq2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117797; c=relaxed/simple;
	bh=oro5FWTaQPiJ2tyUXMMR7TeJBV9ue55I13Gyl5XK/3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhcPNgPgZffSuxOcr772c7HUaNpbfyC+gliP78FZUBv+rJUhKW/sSSdFUSZKc2UrMEOwH13jNveQMvb2OgmH1lxhRe1KTaKTMsYC/TjExAmD++DEUOj1eA1U/rmgZ8ZJkFHBk4scjl0Pi1b+zNQMldDhhQipVRwldcPgtMcsj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhNdVI1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF8DC2BBFC;
	Fri, 31 May 2024 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117796;
	bh=oro5FWTaQPiJ2tyUXMMR7TeJBV9ue55I13Gyl5XK/3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhNdVI1sgJtLD0Tkyo0B9CHslrqYxbYoZc8tOZtdEgF4retQ8zdpcRb7JhQAwNvVJ
	 R5jFY0CQNgwsG3J+tLA4qyjlvwRuMZH9WB0o5TWmXd1hFsYsGv8K1mrqD5dopYHmS4
	 trhYSib791lgOG7vdx0MYSRYmwnswo3ABk6hnV8umncx5GtzquSgT4qaiqFCJM+lMx
	 vb7LKPb+e0NT4s6QIMRafgZd78APBuQyKYvpL/A9VoJJAHiLaRs/3/25wvhZ8fK8Er
	 7xyzbsIyfkNBZ9MNEPq8YE128A8be7YWJN4vk37zWtBKbXJvMhalngYu/ofPEqffip
	 Ol6ffmX1vphbw==
Date: Thu, 30 May 2024 18:09:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: <netdev@vger.kernel.org>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/4] vmxnet3: add latency measurement
 support in vmxnet3
Message-ID: <20240530180955.4e542935@kernel.org>
In-Reply-To: <20240528233907.2674-3-ronak.doshi@broadcom.com>
References: <20240528233907.2674-1-ronak.doshi@broadcom.com>
	<20240528233907.2674-3-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 16:39:04 -0700 Ronak Doshi wrote:
> This patch enhances vmxnet3 to support latency measurement.
> This support will help to track the latency in packet processing
> between guest virtual nic driver and host. For this purpose, we
> introduce a new timestamp ring in vmxnet3 which will be per Tx/Rx
> queue. This ring will be used to carry timestamp of the packets
> which will be used to calculate the latency.

How does the user access this functionality?
Please provide more info in the commit msg.

> +	if (VMXNET3_VERSION_GE_9(adapter)) {
> +		adapter->latencyConf = &adapter->tqd_start->tsConf.latencyConf;
> +	}

unnecessary parenthesis, please fix all such cases in this set

