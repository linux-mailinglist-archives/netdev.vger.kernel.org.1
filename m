Return-Path: <netdev+bounces-172580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54856A5570A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8431116959C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D61A00F0;
	Thu,  6 Mar 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5EsDwjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F7148314
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290337; cv=none; b=LZ0ZwxpQx3sJ1fYiTIYjdoFW4YuN1+MCkHPYQzZqZewNLfajd3RH8D9aHfeQriPduJBulLmPgV0pwlFc5i98Z0g4Kz56UTHnu2G8pyp02SPefJIMKc/GlmeMUw4PU8iKDWvZ01zhcALWZgp4Ln155brggeGiKjpO4EVNBjWI1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290337; c=relaxed/simple;
	bh=GI0UL5OnJM7y+AVbBTrozDRaFWwYDcImbdleJOdDX9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4/RxRi2hqlg0gj2oDa1laXnqo1Bffk9x9QKtJVc5cs/B1dPg0nZi6Hilx+oCSocYZSErrHrVnZRqhz/VTbGl972uf3NJTxvUs6dwjc/OXxfduYuTLieHzzx/R4ffV+489gZCs0vGhgZRDqbXJ3MjzTW36wCIH+isHgHk+qpjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5EsDwjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9864C4CEE0;
	Thu,  6 Mar 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741290337;
	bh=GI0UL5OnJM7y+AVbBTrozDRaFWwYDcImbdleJOdDX9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5EsDwjAxnW58Krttmi16BB+ldIXTvAkecyE8lg6b75/k58AsTHNPPsGO+vZ/so9N
	 Xr7x2lujs6wpC6e9qDJnZwHoghho2GV24vYjs+I0Y9IgDfj+Pv/iUS3j7MMFmaCjz1
	 EyJUoQGMfe0MU5sQstiL2x8ijA+CKq8js4M2rRDucOZJvBPeBSPMwZIRZ07+X4poVM
	 KLJNVDgzBSm7rXOOkLbvOokjRH2IbM+gpNjD3Q7O/5X5fO4NfMG6kTsZHptMiSisAu
	 +//OtAkCRdwPyKItO8Rawksd87ZuBSaVnyOT24ipTPd/lg0qlAN9hWa8haD077BVar
	 t4qOYynlYMKrg==
Date: Thu, 6 Mar 2025 11:45:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306114535.21ad08d2@kernel.org>
In-Reply-To: <Z8n4ZNtnHgF1GB8Z@x130>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<Z8n4ZNtnHgF1GB8Z@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 11:32:52 -0800 Saeed Mahameed wrote:
> I thought it was 48h

Always happy to hear your thoughts Saeed. When you have a sec, could
you do the math between the following two dates for me, and tell me 
if it's less or more than 48 hours.

Date: Mon,  3 Mar 2025 14:32:00 +0100
Date: Wed,  5 Mar 2025 20:55:15 +0200

Thank you!

