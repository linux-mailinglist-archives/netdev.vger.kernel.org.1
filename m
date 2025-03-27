Return-Path: <netdev+bounces-178005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95BA73F15
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BC51882ADD
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F514AD3F;
	Thu, 27 Mar 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6eYBA/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371A28EC
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743105081; cv=none; b=acPC+ElnZ6LM2CBDDhQMSqo5Zr9n7p+m/yLHcK8YWdZZN3hYNiTPXtYYt4M5wUTgNpAfajzeXi3XMvqlXE2DVHSS8ycOihaQRCVmGpUXB3OajCs5FLLx3ShGrsic6XDzzrKw9v1bvu3Fqw3iNaONmiJDLW/ERc6p8It78mnu9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743105081; c=relaxed/simple;
	bh=3uWMYMi4uqRG5QuBYW/NaGAJgnbtJwxDAwk+rD2aJJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gl4sv60VqonRLZq0CBEISvLPwLz18ZGvbWwCATRgyYfH+qJlfwcceCX1Ygakl4DWosI6WNFmYpOsyxaybCMtaHjzJONW2/o9runcQty9OtRWDyV1DaxVFGNB8umg5hz4abMupbmXOH8/HYPtP12Qq+TXSrIDAgDMgBF6IhoPt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6eYBA/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3780C4CEDD;
	Thu, 27 Mar 2025 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743105080;
	bh=3uWMYMi4uqRG5QuBYW/NaGAJgnbtJwxDAwk+rD2aJJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6eYBA/6x4Lwd+DfytbqN/h/rve4jGUQBxSlBai1RGeX/LLQu+5pnSVUuIEMershK
	 GJIAIJKjjh73Dqs9Q7lq7eU5yIuOmrPBJqGjVioUAwYZ1pC1RnyBH3Z1hAFgd+B3yZ
	 zQz51sEsEZ1XVPfYRMtHDYmyYPa8z2bNiCkMvQ7ZdMbCsNiijzK2hX8Akb8OkqpGfP
	 UEOMUOdnDlE936KUbZ3DTukW4Az2PpRx1wVAIRNvFYX6nVQtrw2KEv7M3C2IwMTFdB
	 Dd9DMshgFeTQ/hwohQ0l926m3rUPKnfxVqGgpWRRsXNFbtf9pnazw3TuMNgovCdUjB
	 Vkn4IJ+BY1gIA==
Date: Thu, 27 Mar 2025 12:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Message-ID: <20250327125119.47b25ff2@kernel.org>
In-Reply-To: <20250325195826.52385-1-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:58:12 -0700 Kuniyuki Iwashima wrote:
> I got a report that UDP mem usage in /proc/net/sockstat did not
> drop even after an application was terminated.
> 
> The issue could happen if sk->sk_rmem_alloc wraps around due
> to a large sk->sk_rcvbuf, which was INT_MAX in our case.
> 
> The patch 2 fixes the issue, and the patch 1 fixes yet another
> overflow I found while investigating the issue.

Selftest doesn't apply after the net-next PR :(

