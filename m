Return-Path: <netdev+bounces-37760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10707B707E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 43D5E28131C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16833B7AC;
	Tue,  3 Oct 2023 18:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9343B2B7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F07C433C8;
	Tue,  3 Oct 2023 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696356239;
	bh=i5SJqPcjVPyVB1ildzpV3oWH+KGv0OBRnSp5zrfjEQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfcA+UvrJwLDoVISbmRAJ9D5QZE3zMic+ZBol+Bh8fY8Kx7FM7Kkj8yU0JzljCV0C
	 NQBgwJTA2Ev6OEqyeXnfjG5ex8FcXasqyBOHjjZRAwsRW47ed/g1enBj50EJseoacN
	 lcWAfjrXCfn9Wc5L78Ri4QiqWqf8kE8coGw7YLj5tt+7saV9yM3+BIYjt9BtU5yrkJ
	 Ekw1dScZfJrVHvBreRtdC0gUVX6rLMew9X8mXIciAEoRgxo6ZiL4a7BVFtvV3K/zyy
	 1BkFlFh6EXbKSJ0N62VZFmVV7VX1KuQhOmfmdZoXfWNIC+MrfN34rQq8tnEdUXh9xJ
	 yqQEKdZClhK1w==
Date: Tue, 3 Oct 2023 11:03:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <20231003110358.4a08b826@kernel.org>
In-Reply-To: <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
	<ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> +			  &nfsd_server_nl_family, NLM_F_MULTI,
> +			  NFSD_CMD_RPC_STATUS_GET);
> +	if (!hdr)
> +		return -ENOBUFS;

Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
multiple messages". 99% of the time the right thing to do is change 
what we consider to be "an object" rather than do F_MULTI. In theory
user space should re-constitute all the NLM_F_MULTI messages into as
single object, which none of YNL does today :(

