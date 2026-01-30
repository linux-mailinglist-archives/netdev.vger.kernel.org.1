Return-Path: <netdev+bounces-254974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB0gBkIWfGkeKgIAu9opvQ
	(envelope-from <netdev+bounces-254974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:24:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91959B663F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 271343020FEA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FEE331A5F;
	Fri, 30 Jan 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvZxNh3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134133122A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739814; cv=none; b=dfbuN0SLI3ECadotcpMkucWVnlpQIHexQmw2Uqf/PmeIrdCn5bHmJkTFn/3yeH7LKdJuc23WK73aHDEgOYBOquD8QwsTJ9gNntlLL9m/Ep2h1RMbyxlld6j44mwYpGzOKf/DPJNh+zNc9qMO4yjexDVUw6Zbf6bfTFKQbX946Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739814; c=relaxed/simple;
	bh=HCraEFP75ua0fkFO1gkyKieQUIhXrtbGV2X9Egr+Ldk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vExV2Ka7pQYpN19bLekNqWq4UaU97N9M1sUZaEF7wr3C98DeOlYVJv5ebcdyBpftVW/N347tyoxvCkcOeHOErV3YByj7775+NqQGbmsBX+Hcqhyfv+AAixmW54x3zbpn6lkMbbwroBHhfzA0J31sOaXSHOk/xk0yFkfZMBENhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvZxNh3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47BAC4CEF7;
	Fri, 30 Jan 2026 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769739814;
	bh=HCraEFP75ua0fkFO1gkyKieQUIhXrtbGV2X9Egr+Ldk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvZxNh3AyPb5fY18WhSodO/SfsopqzhZBLtqzM7XWJg0rXnaPM+7dxygbmacd+YT4
	 4vcyQr2Sgb9qp1zuGH1XGPWoDYuMxq9V6YylIACAJ/wzFIkUhtTzA9ODKWwbITuLSp
	 I8cNvqoVd/+97NxYsNhmbi7zsZohrNuNoKJoflcRFNo8Vi9iBKRYtxWiVhKDv+yeQU
	 zbXcXvk2m6CunnuY9eOqxYIByxzUz5OwNkSlnSuUR0ZHU1WTn9mPhy7NNQ64KXb9fN
	 16XRMDErOmeQYJgKlt6tYeMlwCSuLCB+gqM5rgFCFLDsmX+FG7rQHt2MkETZChlQor
	 3sqRtVkf3Uzag==
Date: Thu, 29 Jan 2026 18:23:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next] eth: bnxt: make sure we populate the qcfg
 defaults on old FW/HW
Message-ID: <20260129182332.040411b5@kernel.org>
In-Reply-To: <20260128193258.125274-1-kuba@kernel.org>
References: <20260128193258.125274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254974-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91959B663F
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 11:32:58 -0800 Jakub Kicinski wrote:
> The driver now depends on the core to tell it what the rx page size
> should be for the agg ring. We must populate the ndo_default_qcfg
> callback even if we don't support any queue ops.
> 
> This fixes:
>   Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
>   RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3852)
> 
> with fw version 225.1.109.0.
> 
> Link: https://lore.kernel.org/20250421222827.283737-20-kuba@kernel.org
> Fixes: f96e1b35779e ("eth: bnxt: support qcfg provided rx page size")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Can I get an ack here? This prevents machines from booting so
it'd be great to fix before too many people waste their time.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8fc0720c3057..466e0fc6141f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16316,6 +16316,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>  };
>  
>  static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
> +	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
>  };
>  
>  static void bnxt_remove_one(struct pci_dev *pdev)


