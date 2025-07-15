Return-Path: <netdev+bounces-206936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D6B04D01
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FF23A2028
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D1155CBD;
	Tue, 15 Jul 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkLrsAfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426158248C;
	Tue, 15 Jul 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539787; cv=none; b=h3ceyx73txoCJR93x3cDmwhhzecN/OjqOxWha5rXllsMGrsISEpyiR+s8noRdRmQq7RDAD7pbjXzWqIArAT+eDgxjn0iLzXqMXYHiUM86h17c2cqrG9PkX8Y4jcxAfuAQu32ndmD6Ek9L+cQMK0RPy++YPsLkBHv8vr94FLSKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539787; c=relaxed/simple;
	bh=wSWip8wm6Y5A3aqW+xb4IH4zd3fzEhY9pn6vUkhVM9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFPQI5B5+FZrwoF3QhLUk0g14s0SGUI2NCAymKWqfB5EVLyiC96SsvQdC+EF2H6uWQEk4kXt9DQytIHnDkEFsQ7jFQWbZgiyRWcqhodEUsFUCvgNYGNqdyIHG2OluVLMjSyToilZHHElFI4DidznVjecx4QnfVfN2oG4hw0Q5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkLrsAfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8EC4CEED;
	Tue, 15 Jul 2025 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539786;
	bh=wSWip8wm6Y5A3aqW+xb4IH4zd3fzEhY9pn6vUkhVM9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkLrsAfJUz1pKruG817xJuVDIPd6aCBvnXDsLMeWX71L/gQp/3AcU8+LuRBqMdAvU
	 O3+XWexK8iYubalYMDU1H2BX7dzjS24Jn3ORgM7RmwSwyiChyEumKbF5FO8ZKUbQh8
	 Nm5/9HOGg/67FPF0vwDdeFWmLVU/Dd9gergrYxVobXciHBsVoduZdgh3KFD4aOAzzO
	 +VFh/+2CCHH4sC4vVBrhKnxADCXp1XAeRE05Yw2xT+r9O0p6n1tML1RJvZgQF+WHVZ
	 lbmed2U96dHSdevS6GdFsNrmet4eVvne9miFfUaf2KvSihuI0wqY6HBdLSQWJlBZMW
	 z8N7/d+UvMstg==
Date: Mon, 14 Jul 2025 17:36:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dw@davidwei.uk, kernel-team@meta.com
Subject: Re: [PATCH net-next v3] netdevsim: implement peer queue flow
 control
Message-ID: <20250714173625.1dcdb6be@kernel.org>
In-Reply-To: <20250711-netdev_flow_control-v3-1-aa1d5a155762@debian.org>
References: <20250711-netdev_flow_control-v3-1-aa1d5a155762@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 10:06:59 -0700 Breno Leitao wrote:
> +	if (!(netif_tx_queue_stopped(txq)))

Unnecessary parenthesis here, will drop when applying.

