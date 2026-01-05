Return-Path: <netdev+bounces-247226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F1CF601E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 888523021689
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A528750A;
	Mon,  5 Jan 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGs25su"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC727702E;
	Mon,  5 Jan 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767656251; cv=none; b=ip+6lkaVfw1IGG4T48b4+0JlOhcADxV755OZY7lJQcWaYi7X5FeOSaPLt5+Kb4I4KKz3ptPGLHMLiqtxfn5ETv+xrzNuL+gvK4dtEunSxQMdWp+fxw7zLNaHIE9WNhXLD4KV0+CwCQC13gqz4M+SaRVWZLxrC1gRizOrscMXyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767656251; c=relaxed/simple;
	bh=E4SBxOLmdIbHhQWVj6ALwoTAYF3TwiAlEm9zSMfhBSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGb1CQOFdIqzSqhbx8x6pS0r6rRDTSXEzB8wVVHb6FzVHzb4T6Pque3GliL7muNMXanWPBnQnFXytQC0zd/uMCdGTUvOyXNPgIK9ijdXbriREgve9jmrX5xXhqZBD5+ZjQsAQalF8A7eHWlOv+1h7pPFJwePAs/dPAcCkzDmuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoGs25su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA7C19422;
	Mon,  5 Jan 2026 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767656250;
	bh=E4SBxOLmdIbHhQWVj6ALwoTAYF3TwiAlEm9zSMfhBSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VoGs25suSV0KvnZHllCdGaVSAaQz4FdSK56K1W0BQGG7Y8GX5CqhKXYUT8yEf3ixu
	 A95ZAlyXt2LhCDsrXbeLRzU87id5qNhMEpTsbG2z3njMI6dNtsLX0JF920R7oN+bU8
	 Z/eBbZSYxxaFdWEcyfJxfdGXTNIwGLAcN9+mJ48UmTHUBxnSsSq1PqRIgEhKV0ywSq
	 mnIiQpFyRNZN4t1Z8LktnrBxFQrF9oAvPUKUZxj0Irxnj+VtBpwnS9t2+kMZwP3+me
	 c/sap8UFG6qC0JZW4q8qLN2ootryZja0q6rNacjH6H0i7dfFh8Wl3LH0OGxQ6wGvSV
	 6TW8zTxkCnxwg==
Date: Mon, 5 Jan 2026 15:37:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Protect MIB stats
 with a lock
Message-ID: <20260105153729.0e1241b9@kernel.org>
In-Reply-To: <20260105025139.2348-1-dqfext@gmail.com>
References: <20260105020905.3522484-1-mmyangfl@gmail.com>
	<20260105020905.3522484-3-mmyangfl@gmail.com>
	<20260105025139.2348-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 10:51:39 +0800 Qingfang Deng wrote:
> On Mon, 5 Jan 2026 10:09:01 +0800, David Yang wrote:
> > 64bit variables might not be atomic on 32bit architectures, thus cannot
> > be made lock-free. Protect them with a spin lock since get_stats64()
> > cannot sleep.  
> 
> Synchronizing both reads and updates with a spin lock is an overkill.
> See include/linux/u64_stats_sync.h for a better approach.

OTOH seq locks require error prone retry logic, YMMV.

