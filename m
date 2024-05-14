Return-Path: <netdev+bounces-96408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6D8C5A8B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5213E1F2311D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAEC1802A2;
	Tue, 14 May 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDtJzht1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DE2AD1C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708957; cv=none; b=DQ04d9PowrWwijH5y12+B4f3STlcGVMznV6DxLxYwqvylshN6mr628ufyHlvFFzByOkwruc9fXnxlevclB5oYSFSwTU88UAh6feXP9JGOZ72+SPqPF/7QEJPt7YdQPAcARE5FRcbiaPtckS9TLv7GpEoPIw+jOPk4uv8ZQxZgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708957; c=relaxed/simple;
	bh=Z4k2yMiTbZYDV/ETJRssrJDrw5rVkBItIYIpyQmM43E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvjztbnEBNb0sQamkTBNS77veGNTPp2nNO61eFo+0mUrr7RUB7AWCkkWkWupzEH4fshMwHqxrZTSv3xYnxoxZp2TuTfEQTXSoepvSMqPJd4uQ79XPWSod64Y49kPN8MmRtxXi7u6Hagjvjg6wt+nvOWJejiedleBWt4a0AERVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDtJzht1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F8C2BD10;
	Tue, 14 May 2024 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708956;
	bh=Z4k2yMiTbZYDV/ETJRssrJDrw5rVkBItIYIpyQmM43E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDtJzht1j52zw9RUhirUvT+Cpd3jGFQy7B76EvtWFOuXISgXrZzvU6//LKzx7/kMs
	 xqw9j/x5zQ0XfyI08pSAIm/zbIkfveK/BUBYSQKNOt9hxUVZD596bKrwGDJeSddcVz
	 EW6ogkQO3clI4e3l9A3W4IGCvJNDCo3j/vKDebksGOZyS1nxGMm6DnPXZR7SVmdUrj
	 oAL+kOh0ZH5vKWeYwa0CRuTk8VSw7eVWccuzUbCJE2pClGDZFf83ghI37cG1EVgu59
	 Mx8oFDZuvFETvwKVMnr+hhclxHyMfelBXBpcOPKGk6Xq56YOnA7eDDVV6SC/WN7tOj
	 l2Ct5C/YPTuVg==
Date: Tue, 14 May 2024 10:49:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for
 GRO-scheduled NAPI
Message-ID: <20240514104915.500fc7ad@kernel.org>
In-Reply-To: <20240514104739.2d06fb10@kernel.org>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
	<ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
	<CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
	<e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
	<CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
	<20240514071100.70fcca3e@kernel.org>
	<78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
	<20240514094908.61593793@kernel.org>
	<cdaf9e9a-881c-4324-a886-0ed38e2de72e@gmail.com>
	<20240514104739.2d06fb10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 10:47:39 -0700 Jakub Kicinski wrote:
> enable NAPI 

enable IRQ

