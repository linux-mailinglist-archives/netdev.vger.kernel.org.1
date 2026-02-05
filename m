Return-Path: <netdev+bounces-256968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HVBAJQqhGlW0QMAu9opvQ
	(envelope-from <netdev+bounces-256968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:28:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84908EEB6F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088C8301A145
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407C321F48;
	Thu,  5 Feb 2026 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT3pVjwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A232143D;
	Thu,  5 Feb 2026 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269322; cv=none; b=eDcCLf6qNPRhQjQF0llGlo2alv4QFBtImsA3Iaobir9JHmb+9SKhbWi8pfJvd15mTkzuVg+QyVb7wB5MOjR6Il2Br91RnZFfACAoaL7R1CEYsPqmtQ6QN7QMIt8rQwURVPJeA1DskFwyek3GVJqpPZqgBFdfAKNzO2oYWxmGnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269322; c=relaxed/simple;
	bh=HN9suosZ96f6UTfy0tIXoiy8wzfwVVtWbAAbeE86US0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXt0MukaWranb+XPb7+4irWxOn4M3spv+MNaDpRUVzzfkLIkie9F2XrKdMSuBqaKxLA6NhhJrCsDrpiGH5ZI9GVLy+sLQzDEh+nw+zS6eUcwf+giM37MtWME1jFGlTd89UMFSwxcX9jJUBQqov5e+LJnohOIcJ6tn1OaGHa5ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT3pVjwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05B9C116D0;
	Thu,  5 Feb 2026 05:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269321;
	bh=HN9suosZ96f6UTfy0tIXoiy8wzfwVVtWbAAbeE86US0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT3pVjwKS9o7wLCcQ0oEpmScpe/ZKhNb343vYUnyS/WVZxS48965mN2tDlWIx6C+/
	 SClMGUWu7zuOLtV1sJBniARWy7O7nOhGA4s4HV6ASIDzP+pJfdY1w6/ql7hY3ZpOE7
	 bMylJISeyh1cSQrDBJhljxZJfMsEZCL1EghfBfp0xkWG5RsVs4BFpSu11N6Hmgx8h/
	 axT7goSpE5Xy/OHqPHNesw2ZkkpelKYfDhIc2DubrCAvsxgR4kvZbfFEy+rI9i7YmU
	 HKbImSfh5IPFejINPAfTnNXNLxcAHeqdxUPtWlP67roraQK5wl5P8IEurWmDL1NyTa
	 MPDdfOSk2Ji7g==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	xiaoning.wang@nxp.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	frank.li@nxp.com,
	linux-kernel@vger.kernel.org,
	hawk@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: Re: [v6,net-next,15/15] net: fec: add AF_XDP zero-copy support
Date: Wed,  4 Feb 2026 21:28:39 -0800
Message-ID: <20260205052839.2449416-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203052329.1085444-16-wei.fang@nxp.com>
References: <20260203052329.1085444-16-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,redhat.com,nxp.com,gmail.com,iogearbox.net,fomichev.me,vger.kernel.org,google.com,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-256968-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 84908EEB6F
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add AF_XDP zero-copy support

This commit adds AF_XDP zero-copy support for both TX and RX on the FEC
Ethernet driver. It introduces new functions for XSK buffer allocation,
RX/TX queue processing in zero-copy mode, and XSK pool setup/teardown.

> For TX, there are two cases, one is the frames from the AF_XDP socket,
> so fec_enet_xsk_xmit() is added to directly transmit the frames from
> the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
> other one is the frams from the RX queue (XDP_TX action), the buffer

This isn't a bug, but "frams" should be "frames".

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> +static int fec_enet_xsk_tx_xmit(struct fec_enet_private *fep,
> +				struct xdp_buff *xsk, int cpu,
> +				int queue)
> +{

[ ... ]

> +	bdp->cbd_bufaddr = cpu_to_fec32(dma);
> +	bdp->cbd_datlen = cpu_to_fec16(len);
> +
> +	if (fep->bufdesc_ex) {
> +		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> +
> +		if (fep->quirks & FEC_QUIRK_HAS_AVB)
> +			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
> +
> +		ebdp->cbd_bdu = 0;
> +		ebdp->cbd_esc = cpu_to_fec32(estatus);
> +	}
> +
> +	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
> +	bdp->cbd_sc = cpu_to_fec16(status);
> +	dma_wmb();

Is there a missing dma_wmb() before setting BD_ENET_TX_READY? The
descriptor fields (cbd_bufaddr, cbd_datlen, cbd_esc) are written before
the status, but without a memory barrier, the hardware could see the
READY bit before those fields are visible on weakly-ordered architectures.

Compare to fec_enet_xsk_xmit() in the same file which does:

	dma_wmb();
	status |= BD_ENET_TX_READY | BD_ENET_TX_TC;
	bdp->cbd_sc = cpu_to_fec16(status);
	dma_wmb();

The dma_wmb() after setting status only ensures ordering with subsequent
writes (bd.cur update), not with the preceding descriptor field writes.

