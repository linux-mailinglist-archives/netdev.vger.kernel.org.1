Return-Path: <netdev+bounces-152038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8787C9F2696
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA9F7A13A8
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFB1BBBF1;
	Sun, 15 Dec 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1c6sCD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84751E502;
	Sun, 15 Dec 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301930; cv=none; b=GdI4TGt33LO6sWWcCe3Z2ULIZACOFHlE6kv8h9CIH6kSViPieQEYU+Gn93Ca5H/PBV2lOU4hsWfIuajPpAon1R+tvPDg38hjCtPGEt98uG7Wmr+zGLCuXSK9r9Bvzny2nOQNrwCOnZkjdlKApI6CJzFBeqgvfIuBEP3oxDR/yFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301930; c=relaxed/simple;
	bh=jg4FMEHnDQEdPeiYG++que5v/uPW0Z20gwcn0XCGsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/cSkQSYyClyUb1ANnHNj9V813mhD9afc75j/N+1Hpxbj1KGfg27G06vZ5Zy73Q+ewd04n/nZQGA7N0BRbGrx4rygJU4p43On40sWLk+bZHroJ48+9RxscssnWJf2m5gLQQZx9ev7mSp9o40z/hb/m9SOaG7MenWAiBaojy0mDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1c6sCD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC030C4CECE;
	Sun, 15 Dec 2024 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734301930;
	bh=jg4FMEHnDQEdPeiYG++que5v/uPW0Z20gwcn0XCGsvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1c6sCD1QFgoPRpIdBJPT8D7wgf9sV55sNu8GDBvcWdNcXZIceUCngz3ypwl3c6D5
	 m80CgXy41RveWw3BeYyZ6iEA+S+h/HCgAm7MNgyzC/dCOcWOfV87z9mGJoQlN8ThxD
	 eF5kR2H6vf2+zBiZWKBDb4yPis/PBWB3oneiu9OxQ+wLM4Pv7Ee1r2Fueg7WkjwrTj
	 RR5HDZuOfjtm8OMiHQDg/8vmBr1ceayKeSIqNjVm6oRLxbbxcxrdmBCfFYhqyh1bcb
	 uIhDyTznCwam2xgPzNa/uB8rNWz7QJ3rY1eQf+EunlEQDwp6zlrL/KtH8Rhn2ibGCs
	 913p6bW7LafXA==
Date: Sun, 15 Dec 2024 14:32:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/7] mptcp: add mptcp_userspace_pm_get_sock
 helper
Message-ID: <20241215143208.3786c360@kernel.org>
In-Reply-To: <20241213-net-next-mptcp-pm-misc-cleanup-v1-3-ddb6d00109a8@kernel.org>
References: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
	<20241213-net-next-mptcp-pm-misc-cleanup-v1-3-ddb6d00109a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 20:52:54 +0100 Matthieu Baerts (NGI0) wrote:
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct mptcp_sock *msk;
> +
> +	if (!token) {
> +		GENL_SET_ERR_MSG(info, "missing required token");
> +		return NULL;
> +	}

Ideally GENL_REQ_ATTR_CHECK() would be used in such cases.

