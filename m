Return-Path: <netdev+bounces-234802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF4C2750A
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F76D4E1036
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F120A5EA;
	Sat,  1 Nov 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1k9rlyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0D15E5BB;
	Sat,  1 Nov 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958488; cv=none; b=Y1BquLeIsopTJq9/Pipj3zhQhQSeul5Tnpqt6F+cV1vV9OlGbefZ/bPPrXpQlXnBj3NtE49n1biZVGX8R3FnY+vYidp80SAl5doNfq+zxTN1Tx+pxRE403XNL7afbhFuOZN/pq98BAlNvk2DFp2Qr/Lkg/1F3G78dvmGXSvC8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958488; c=relaxed/simple;
	bh=Eo5T+ScCv4hBpdgIgzhuXEDLTwYWGx5IuWl7TxgQP/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6uEJnsdfMMQ61dKkAzv+Abe6dZikXLqlqYfnnTwbHTXlL1m8mWRD75rxTnhr2RCQTCFLjrVmSOoO+H1TfUWg8MIoTkTOUcG7Sg0Lt6RCtN9vs14PF+bsg0REexPxVGaFPfMdLF06pqxZyqbMWEItC84YfkH/QRptvLCOlDLl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1k9rlyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72753C4CEE7;
	Sat,  1 Nov 2025 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958487;
	bh=Eo5T+ScCv4hBpdgIgzhuXEDLTwYWGx5IuWl7TxgQP/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1k9rlygTMElVgSJxGl1zjYAwkZHvPEzwI3KNPMTiZcN3Q/+uTKa4BYIh30y+7o0x
	 0sXOulMsPRLgWdIKbuFYeDtZLIZlCWZVcdqnTPdxEbaqJQOStr3m5jvpA38gX/dWO0
	 /cASAb4HPftOQi8II3FgM4bYaPlrnHYQkosfZkqc3ACRIOHALrAGbM+vSGx69pZXp2
	 VKcqFWil6+WQ6l344DeJ6cGAyqI8mZxZ0M3giChOyotTBJWHwytOo6cwZkrESdj/eF
	 MQkyqSCP1iG2lYTb9wxvmOKXKh31mfaD36chnmxjJJgublyJpdZISewpXd0EI6ACJx
	 M+FfTU6tAKjMQ==
Date: Fri, 31 Oct 2025 17:54:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthew Wood
 <thepacketgeek@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netconsole: Acquire su_mutex before navigating
 configs hierarchy
Message-ID: <20251031175446.24e280fa@kernel.org>
In-Reply-To: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
References: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 13:50:24 -0700 Gustavo Luiz Duarte wrote:
> There is a race between operations that iterate over the userdata
> cg_children list and concurrent add/remove of userdata items through
> configfs. The update_userdata() function iterates over the
> nt->userdata_group.cg_children list, and count_extradata_entries() also
> iterates over this same list to count nodes.

Teaching syzbot how to create a netconsole would probably go a long way
towards catching these sort of issues. Looks like right now syzbot has
coverage only for the paths that don't need a target:
https://syzkaller.appspot.com/upstream/coverage?period=month

