Return-Path: <netdev+bounces-155220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D001A01794
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305281883FDD
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053782628D;
	Sun,  5 Jan 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6eGI7ba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDA1E884
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038800; cv=none; b=bytBCPK6kIIsJbQfdW3zEeT9LUKo6Cq0/LpgCk8aXAtK99/ploxVCjB/ZNXl+r5xXIZBH3H06QBcrukLOMaGxj1IcZeikhHssAiwsNIoqj1gYACPgeJSA02dpSl4qVz9C8Lp4d0aTYkaRJ0x9tVjOoCRmyKqr4tfcaCFL4u0ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038800; c=relaxed/simple;
	bh=uJHF+cGaH4I66HHivyyAeAVOU0855KNjg9rYdI1uo5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCPvTurJElgByRiOie0wgTHXJV6vYzGPvlJnQujAs9UF5zNqkORPOoy2JTzNdKsjDE3p5/0d2Fv1Mu247148VkyCBy62mNOZjnVYd/PdTBH8hNYJ0zucAkM2SuZI22Q3O6IbOlDOqlg1WVMVaJ1emp/GSMLiGPTZ+fJp8HVXnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6eGI7ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9329DC4CED1;
	Sun,  5 Jan 2025 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736038800;
	bh=uJHF+cGaH4I66HHivyyAeAVOU0855KNjg9rYdI1uo5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6eGI7bajrH1/tXIkt9pIwzvTMqwIohd5DFXHaztKo33/1JHyR80rzoPw2Pzka++V
	 xCCUB0j2VArt242olQGmpBcjsnqzh/uhZsturc7Sv1gMSWpm1xcG+0ivbJ7hkR9l3X
	 vxZNsPukKsbsH20uM45RMmimyRsJHykCXuAwkOLA/hJ6C+pQm2l20iSX3B8InyYq8H
	 3FrU33M8NgcVvAM3Dnh8DfVF5weHvRZBDZrQ8WwZDq/R5SSsUARDf7MKpaWCQbYckm
	 /K+sD07/Pu2ThO2cWQo321LqfXyKgt9BliZJSHxftdAjuy/Cooe5n/cWcevIz3cYpH
	 yQdysvdfRn2KA==
Date: Sat, 4 Jan 2025 16:59:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, damato@fastly.com,
 brett.creeley@amd.com, kernel-team@meta.com
Subject: Re: [PATCH net-next] eth: fbnic: update fbnic_poll return value
Message-ID: <20250104165958.51d89a13@kernel.org>
In-Reply-To: <20250104015316.3192946-1-mohsin.bashr@gmail.com>
References: <20250104015316.3192946-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 17:53:16 -0800 Mohsin Bashir wrote:
> In cases where the work done is less than the budget, `fbnic_poll` is
> returning 0. This affects the tracing of `napi_poll`. Following is a
> snippet of before and after result from `napi_poll` tracepoint. Instead,
> returning the work done improves the manual tracing.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

