Return-Path: <netdev+bounces-143551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C19C2F34
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05561F210A6
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40019DF81;
	Sat,  9 Nov 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQqJN5ZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03F13BC35;
	Sat,  9 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178197; cv=none; b=s+OOEt4TTacBgLTtrpl4uIxKKCN/Uek45pYbByvJWIPmcBI1yvtQu+rpPG+ulAd9gjLDTmUkjh+3jGrh0OjD2LjQgMA6qQfLhNOFc1W8yP7kKNGuLUSVwscnVSr/PkHNFfMjNZP2kNSLhFGuyVTWs/Lh5K5V4MfMmqi9nqzo94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178197; c=relaxed/simple;
	bh=DQ8D0EMVEKfoDRPi30lNWFPGWG1wzBXtILyN4sDibfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqcKx/zSr60oosyv7MAbSrU8xDjlvSUtMw+vsnZFopXXnqFNjzfCZdtUs3IAmmPiIRk0HroRXFSLVQFDBYKUVvkAejroh7HAZsKu04CQVcciruHt7m+7B0slZizyGnUBjX0GGca5wRJIilRLyAFzMSFEp7a2QJepiUA8RNKye/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQqJN5ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C901FC4CED3;
	Sat,  9 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731178196;
	bh=DQ8D0EMVEKfoDRPi30lNWFPGWG1wzBXtILyN4sDibfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQqJN5ZMZlH6v1lX5fAX3kEYAquB4MmA8Gsx1Lm/Zj1usOUZP9rKwB9sKsU/UqJm5
	 M7FMKR0d5yi+NKGhd+lfYuR/GGMFzwZQo3aHI1m3MYn0XWHIh/5jfXC5lKzj9aDY5e
	 rlJ45MVaCSpuc4w+ebAmDtNG3/noI70FLf5w1hCYd2aIAm1L5H6fTULPlboqZeOLlx
	 97DQFa3PdRYDbk5QLGuPemEGJpW45eEfa3tshNIh+1hsLr00HzEH/cN+chrr2KjM3O
	 51MLpWsBRLlaIYohWc6GLKEK5ciSHL5oCSvYREbsJGnqxXTegiP7hv567OSDAE9hA0
	 21HBufPOCuxVA==
Date: Sat, 9 Nov 2024 10:49:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <20241109104954.5c4ddbc3@kernel.org>
In-Reply-To: <20241109100213.262a2fa0@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
	<9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
	<20241109100213.262a2fa0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 10:02:13 -0800 Jakub Kicinski wrote:
> $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2

gcc version 14.2.1 20240912 (Red Hat 14.2.1-3) (GCC) 

