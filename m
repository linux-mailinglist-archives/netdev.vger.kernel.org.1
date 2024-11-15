Return-Path: <netdev+bounces-145475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4C9CF992
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73931F23C56
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EE18BC3D;
	Fri, 15 Nov 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6OCMAlc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013617E00B;
	Fri, 15 Nov 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708382; cv=none; b=T3qMsKy1j+CmCU7VIM1cUnHf64355qIcWnf1eKPE8aSdWDaH8qr9vfNVYIM1CH3QMYXUgHdCqAFs4PGzo0Cne0F1Mut9Fr95D7LlVZC0FzEWYtPXusQlTMatPci7Irg6b7WyluaB3IIJGsnaa5L4Tiuyzl4T3+t5/P/fx/GwN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708382; c=relaxed/simple;
	bh=QwZlqEWn+UJO1Eivd0eFJik5IdPPUk+DSfabTGEAwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbMXbKHmhwrOarFKw84o537vvk3wt+8ChhlHNelTTRSeYCcu2Uox/+dM4XbdPlSlNV3hOTx43zbOPpUTK77eltUAlqLTno4w+vuWSEoJENreYvFzUCS33tPhu/Zi+Lw2O69PH0lY8xfDgq/6jdvq78e0jWURig9La28D6fSuAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6OCMAlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C6AC4CECF;
	Fri, 15 Nov 2024 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731708382;
	bh=QwZlqEWn+UJO1Eivd0eFJik5IdPPUk+DSfabTGEAwY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6OCMAlc9urByYbMiGU4OQOLSFmQRZOYtZsDmfltGzZ/sHUo3HYG8XVfUuVAzC+wM
	 5EUNXzvFu4PbaMBdbTMuY5wpk7nh+dpaZm/8mO35gM9XQia1GBm5feKFUIziCy1fNZ
	 nRptlLjR2YhByYydEze/nWkqzgDQFRvJrAWchAK44UzR84/sWcoZV0EbKMnrgughTI
	 hJ/tCDhHqrjoTHRHfVF7SJsBIjUEgzv4bpmzotPO9XUocRfWSQxHVpc5C92w9g5CgF
	 2JtGwkWMU6ppc8/1sblGQOoJUfcQdyfAW81EVNvhcl8SxuRrdYAIzqWk0Ar32bcHqu
	 TmgapeeziB7xA==
Date: Fri, 15 Nov 2024 14:06:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: uevent: also pass network device driver
Message-ID: <20241115140621.45c39269@kernel.org>
In-Reply-To: <20241115183346.597503-1-mail@tk154.de>
References: <20241115183346.597503-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 19:33:46 +0100 Til Kaiser wrote:
> Currently, for uevent, the interface name and
> index are passed via shell variables.
> 
> This commit also passes the network device
> driver as a shell variable to uevent.

Can you add more information to the commit message for the 'why'?

I'm guessing this can only be used for local one off hacks, or 
can a generic (eg distro level) naming policy benefit from the driver
name?

