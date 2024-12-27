Return-Path: <netdev+bounces-154368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509439FD711
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C527A1D8B
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD01F8917;
	Fri, 27 Dec 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok0ljX9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1E1C2BD;
	Fri, 27 Dec 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735325792; cv=none; b=gRsZ9wH9TnXahpK2kL+ha56PlkkAbwOblUbpBtj/pRt5SxaM0qSus0W9oGUI7rYoj2M3O878yio1ZbNGKA2cDiDp4EV6VVrXAhuazYjVgadxAT4q86pH4pVW6KPRa/TMD317yOYcyK8Cgwg+PcriJ7wGXvIywJHlYdWWrz4HvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735325792; c=relaxed/simple;
	bh=VVnaKLxKXLHodTNBrElxZ5Ilql036EDzeMECki8xmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brlUeJhdgBYMkM5e28AFg6aqPVHxQETNfKrBcZWWXDPh9o756OwS9p6qwJ5OXi7eGVScs0THAIEp3E4wLGq8M77ZkTFNJ8kEzLtxzlFxuM+3HM9Z2ES0PoUVMI1ASaE4bcKd8ZVET1xCu9L89NHL9cdrfX+hRHiGothUzUh+jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok0ljX9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFB8C4CED0;
	Fri, 27 Dec 2024 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735325792;
	bh=VVnaKLxKXLHodTNBrElxZ5Ilql036EDzeMECki8xmF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ok0ljX9zUgtIdkUyKUri/8zYH80viIK7mCnA+5Fk1I0W5yzSF7u2W3MYIX5yTjD5k
	 QMoKilvkh37YCZTgc/8io2KtEQr4r6EO5i5eCd5VuCMKoXLUbPUijqjZ8QwVogFLXf
	 sbk12NLE/tEc8YY3VW7KysuGlpx2+8ymMRGtNHnIdGNbu+jzknvur+m1rBDYsx44XP
	 SgSl+Nwb4NdQBjugtmuo8Al/YOuBfKv3YFOAlm2mmb5rEyezJ7y56C/56QKCYUCK83
	 jR79Bo805RuBIbwmsk5IrWE0krAKmo2PuxYZbnmDM28NcZzRYpSxCQzOM6HfwYr/IL
	 8CCf5dOH5V6MQ==
Date: Fri, 27 Dec 2024 10:56:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sanmanpradhan@meta.com, mohsin.bashr@gmail.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] eth: fbnic: Avoid garbage value in
 fbnic_mac_get_sensor_asic()
Message-ID: <20241227105630.19ab7e3c@kernel.org>
In-Reply-To: <20241224022728.675609-1-suhui@nfschina.com>
References: <20241224022728.675609-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 10:27:29 +0800 Su Hui wrote:
> 'fw_cmpl' is uninitialized which makes 'sensor' and '*val' to be stored
> garbage value. Initialize 'fw_cmpl' with 'fdb->cmpl_data' to fix this
> problem.

Argh, this function should send a FW command to read the sensors, 
it does nothing today :/ Looks like an upstreaming fail..

If you'd like to fix this please just remove the body of the function
entirely and return -EOPNOTSUPP. We'll have to follow up in net-next
to fill in the gaps in sensor reading.
-- 
pw-bot: cr

