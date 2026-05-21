Return-Path: <netdev+bounces-290522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB4yJ+UrD2q3HQYAu9opvQ
	(envelope-from <netdev+bounces-290522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E945A8D00
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A3831EF128
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7127A47F;
	Thu, 21 May 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz4cbATQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994C23372C;
	Thu, 21 May 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375548; cv=none; b=lTFR9uzsbgy/dCx2IVGOrQi/nLtNkKYhFecbOAUfIVCSZA6UukjgWLKatks06Mg96CskcKHGj3C+UKa3Nr6fEn22eEeGmnv9R6NE65TEjnvG4FG7gCn0Hi8LrRj8N2lx2frHFg9CFMCZCk72+XkwmQMbLWmlXvuTR3Qo1Onw8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375548; c=relaxed/simple;
	bh=7vV3U47dqceEoYlPJPQkAdHGPir0Dj/4Tzkmt+VmItI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjy26Jx7LXHAfhxgZvLI3HilHPnxelsPkhMfSDd8lAVbHjYKc+5yfLYaCwfR8RDlbW5ZGgzza8yVmTPoP58mTfmj1tK+zF7Eijs8jD0jDZ6vl//C5Lup9/Azc/ZcUul26OVeKDtsWt0hbgdQaf4JxtzoHXHnUU+1g9Z/ycLU45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz4cbATQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5E41F00A3D;
	Thu, 21 May 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375546;
	bh=u8Y8KDCejJZHIqnWx5pY4uc1dK4z52Fxk1r7C+1ecbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cz4cbATQW3NxW6y1zb36mbRj11yX2PUdrz6T9oLdRg2L4IX3u9WMRUGFL+T+IWpOV
	 S7aat94BXSeYmu5ZN1aoBQQldNyy0rwkTBjSLI9cMRKmgrGylJrI2aXFsSo/curE2G
	 JyREF4Y0MeQS5NQwGcEovRFPAmzcWKLA7SXXwwW7EGFW5iU2d2x5MGXBymbCuBxW6H
	 iJiLSZpuVg3yafWmo4AxJZPPeGIuvDIeEvWTxWd4TwQs63b1LO7bdV2mxVtCKK/EtU
	 Q2FubrIDm4R8EX7Vn5fwqD2kEw0lUS4qB39YdyBV9KU9CLe6QwP7Jr70kNBcIPUvHH
	 pTk6SqlhgpS7w==
From: Simon Horman <horms@kernel.org>
To: yun.zhou@windriver.com
Cc: 'Simon Horman' <horms@kernel.org>,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bongsu.jeon@samsung.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
Date: Thu, 21 May 2026 15:58:17 +0100
Message-ID: <20260521145817.1990235-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519013042.3459906-1-yun.zhou@windriver.com>
References: <20260519013042.3459906-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290522-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2E945A8D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

This commit adds skb length checks to nci_core_init_rsp_packet_v1() and
nci_core_init_rsp_packet_v2() before parsing the CORE_INIT_RSP packet to
prevent reads of uninitialized memory.

> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index 9eeb862825c5f..36e49fb7d8941 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -50,6 +50,9 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
>  	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
>  	const struct nci_core_init_rsp_2 *rsp_2;
>  
> +	if (skb->len < sizeof(*rsp_1))
> +		return NCI_STATUS_SYNTAX_ERROR;
> +

Does this length check break the handling of valid NCI error responses?

If the device returns an error status, the response payload might only
contain the 1-byte status field. By requiring the full sizeof(*rsp_1)
before checking the status, will this return NCI_STATUS_SYNTAX_ERROR
instead of propagating the actual error code from the device?

>  	pr_debug("status 0x%x\n", rsp_1->status);
>  
>  	if (rsp_1->status != NCI_STATUS_OK)

[ ... ]

> @@ -87,15 +94,21 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
>  				      const struct sk_buff *skb)
>  {
>  	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
> -	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
> +	const u8 *supported_rf_interface;
> +	const u8 *skb_end = skb->data + skb->len;
>  	u8 rf_interface_idx = 0;
>  	u8 rf_extension_cnt = 0;
>  
> +	if (skb->len < sizeof(*rsp))
> +		return NCI_STATUS_SYNTAX_ERROR;
> +

Could the same issue occur here for v2 responses?

If a command fails and the response payload only includes the status
field, checking for the full sizeof(*rsp) will drop the error response
and obscure the true failure reason.

>  	pr_debug("status %x\n", rsp->status);
>  
>  	if (rsp->status != NCI_STATUS_OK)
>  		return rsp->status;

