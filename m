Return-Path: <netdev+bounces-218841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06083B3EC8E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69792C057F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68C3064BC;
	Mon,  1 Sep 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsR2pyMP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D273064B0;
	Mon,  1 Sep 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745090; cv=none; b=i4oA6s9z0M9uljFegWZSuBPisCGcRObGxDuFDmS/wdO3izDQDinMqY0/8mb9mkfK4wazY/ascjJFsCo50sDoh1Ced6JVLWB/OmT8MCe/qWa4/C1oW0aqTcRwCgyGId/mtvMEhn2UkKC+shdgzYNS34v41YQO3Pc1NYZ1N2ffkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745090; c=relaxed/simple;
	bh=W0/vkHZkSSNFK/yuj8SNDNtB1faiBFA+1Osc3JV1P90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUTo4i2LW+9dgzi1Mc8ToWuRFAs4MzCal0dvGuJO7ydEVS+3eVy0MHSTXnnfBpBZ4bvAATTSCQu8A7BZkdfi8xK9dTlzdFFSKCaXqT+Gj742b7za3elz55smo4j7AzHBh4wnnthCtEgs6dLxnza3oc4aB8eBit+OVT9HMBycc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsR2pyMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D932BC4CEF0;
	Mon,  1 Sep 2025 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756745089;
	bh=W0/vkHZkSSNFK/yuj8SNDNtB1faiBFA+1Osc3JV1P90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsR2pyMPWq9qbf61RSRzJE7tpIIJvB+1uVhBPaJMRJGCt5oCAl4mcwji90g1ytx2D
	 NItJs4/T41kEwMtGIH3BWv0coM451pWCPHeCAxOMgPZivm9BCcBbat+TqkZKaHFbVW
	 +rk+Z/GzDhgQyxkWkzrfFk9n7XNIip0JKSIfqGsnZX2LsubEokL0dUo/fNXb3f64Vk
	 JYM5yyhULm+15nAVBzXoiXEICmhOsO8Xjwotd+uwvD+qdVMt5DunAplu75drYOJgLY
	 1zMW604R3q0pd8OxSDt+WRpu7pnSLLRsHqG0Xbt/zpXfubgWJngfyoPo4FHqlPdwOW
	 w405lXl64JWhA==
Date: Mon, 1 Sep 2025 17:44:44 +0100
From: Simon Horman <horms@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>, donald.hunter@gmail.com,
	edumazet@google.com, hare@kernel.org,
	Jakub Kicinski <kuba@kernel.org>, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, wilfred.mallawa@wdc.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] net/tls: allow limiting maximum record size
Message-ID: <20250901164355.GM15473@horms.kernel.org>
References: <20250901053618.103198-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901053618.103198-2-wilfred.opensource@gmail.com>

Corrected Jakub's email address.

On Mon, Sep 01, 2025 at 03:36:19PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.
> 
> This patch adds support for retrieving the negotiated record size limit
> during a handshake, and enforcing it at the TLS layer such that outgoing
> records are no larger than the size negotiated. This patch depends on
> the respective userspace support in tlshd [2] and GnuTLS [3].
> 
> [1] https://www.rfc-editor.org/rfc/rfc8449
> [2] https://github.com/oracle/ktls-utils/pull/112
> [3] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

...

> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index 95c3fade7a8d..0dbe5d0c8507 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -87,6 +87,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +          name: record-size-limit
> +          type: u32

nit: This indentation is not consistent with the existing spec.

>  
>  operations:
>    list:

And I believe you are missing the following hunk:

@@ -126,6 +126,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - record-size-limit

 mcast-groups:
   list:

...

> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index f55d14d7b726..fb8962ae7131 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>  };
>  
>  /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
> +static const struct nla_policy handshake_done_nl_policy[__HANDSHAKE_A_DONE_MAX] = {

Although it's necessary to update this file in patches,
it is automatically generated using: make -C tools/net/ynl/

Accordingly, although the meaning is the same, the line above should be:

static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] = {

>  	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>  	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>  	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32, },
>  };
>  
>  /* Ops table for handshake */
> @@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
>  		.cmd		= HANDSHAKE_CMD_DONE,
>  		.doit		= handshake_nl_done_doit,
>  		.policy		= handshake_done_nl_policy,
> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
> +		.maxattr	= HANDSHAKE_A_DONE_MAX,

And this one should be:

		.maxattr        = HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,

>  		.flags		= GENL_CMD_CAP_DO,
>  	},
>  };

...

-- 
pw-bot: changes-requested

