Return-Path: <netdev+bounces-274334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCxeOanZzWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCEB382D6D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A31D3039EDE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A633A9C4;
	Thu,  2 Apr 2026 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egyFdOow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00930C63A;
	Thu,  2 Apr 2026 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098181; cv=none; b=SLx+Kl3fME90hJtN1AAMUBcALFK3MtqOe7dLpN6vSNzi3JSLVG32ZaoTlEQnlrl6dfGIFK2rsnfXA0zM8u9yvKRGglFk98ApH5izLDnqVqZNKSzHJufgaNnxj0rY+kWutF9tJRHhKSAcnuWnxIZ8BmimimwGx8xkz9cYyS/acf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098181; c=relaxed/simple;
	bh=zplixGIqQx1aEfQIQZXKitp7PGxnwFBp/otDEmmNvLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi12b/oEZwcAu5siOxFvGleieCCnHhCFBDayoS7XHfmbMQsK4T3VueJUZYqA3iAye1XiGOFeDHRcJDB1a4Ux562ebrGbOf2yIGIgT0ugsny2EXdHZdmyt7XBSJhbkYFxxYCB/Z1AfMsDZJLdrGLHANfVc1erx/sjVxymy7dd++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egyFdOow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF5C19421;
	Thu,  2 Apr 2026 02:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098180;
	bh=zplixGIqQx1aEfQIQZXKitp7PGxnwFBp/otDEmmNvLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egyFdOowbVNcjNL2D7HwH7P7nZG7K9sevyl81qwKE8vEmKePf/GHEdPrrZ5nP8356
	 eN6SjsImuhkkRiSHVxdeLdXhNiSbyWFD9izPOFUu7N+/3/m3oik3g+rvrt5zW1qtGN
	 0JXJRJroN9jF1JsGqhwwkzGd4C0hx9pNPVch8BDMWfyRIYxvBAu0tCU0jXZWksUB8v
	 44Lt6gpJM2yKfDJcBc6QrNyCFFPsV2eT6Gi8BwvQYeG4kuXnj3qjcWFPnt/1vXDokd
	 eWQKA3wgsHnSRLf5YiMkvBSht+DLSO7Y0OCg2cs4JBg4Iw80D1Wvd3i3dkgAX9wDgJ
	 xFPb9KAleMWnw==
From: Jakub Kicinski <kuba@kernel.org>
To: pengpeng@iscas.ac.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	krzk@kernel.org,
	bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFC: s3fwrn5: bound the UART receive buffer
Date: Wed,  1 Apr 2026 19:49:38 -0700
Message-ID: <20260402024939.845287-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328113615.37260-1-pengpeng@iscas.ac.cn>
References: <20260328113615.37260-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274334-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DCEB382D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
NFC: s3fwrn5: bound the UART receive buffer

This commit attempts to fix a potential buffer overrun in the UART receive
handler by dropping oversized frames before they exceed NCI_SKB_BUFF_LEN.

> diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
> index ccfcee06ee77..aba688499c05 100644
> --- a/drivers/nfc/s3fwrn5/uart.c
> +++ b/drivers/nfc/s3fwrn5/uart.c
> @@ -63,8 +63,17 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
[ ... ]
>  		if ((phy->recv_skb->len - S3FWRN82_NCI_HEADER)
> -				< phy->recv_skb->data[S3FWRN82_NCI_IDX])
> +				< phy->recv_skb->data[S3FWRN82_NCI_IDX]) {
> +			if (phy->recv_skb->len < NCI_SKB_BUFF_LEN)
> +				continue;

Is it mathematically possible for this condition to be false?

Since phy->recv_skb->data[S3FWRN82_NCI_IDX] is an 8-bit unsigned integer,
its maximum value is 255. With S3FWRN82_NCI_HEADER being 3, the check
len - 3 < data[2] ensures the length is strictly less than 258 when
entering this block.

Because NCI_SKB_BUFF_LEN is 258, wouldn't len < NCI_SKB_BUFF_LEN always
evaluate to true, making the new frame-dropping logic unreachable?

> +
> +			dev_dbg(&serdev->dev, "dropping oversized UART frame\n");
> +			kfree_skb(phy->recv_skb);
> +			phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
> +			if (!phy->recv_skb)
> +				return 0;

This isn't a new issue introduced by this patch, but does returning 0 here
after a failed allocation cause a NULL pointer dereference?

If alloc_skb() fails, phy->recv_skb becomes NULL and the function returns 0.
When the serdev core retries delivering the buffer later, the loop
immediately calls skb_put_u8(phy->recv_skb, *data++), which will dereference
the NULL pointer.

Also, does returning 0 after already processing some bytes corrupt the
UART state machine by forcing already-consumed bytes to be replayed?

>  			continue;
> +		}
>  
>  		s3fwrn5_recv_frame(phy->common.ndev, phy->recv_skb,
>  				   phy->common.mode);
-- 
pw-bot: cr

