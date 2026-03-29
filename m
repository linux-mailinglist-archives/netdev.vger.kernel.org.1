Return-Path: <netdev+bounces-273027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C5iNTGmyWlK0gUAu9opvQ
	(envelope-from <netdev+bounces-273027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:22:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8E354473
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2719300DE36
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62E2C08C8;
	Sun, 29 Mar 2026 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw99ntM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1628371;
	Sun, 29 Mar 2026 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774822958; cv=none; b=HfPH0zCSjEVAxxQhkarrFRokvm+yfgy5grQpOQmoVRZMmiBKpGGKC/Cbt5mXZmTfR119+t6tbm7chQU6RcUql6x/kKuVD4RKHh9q3L1ch84ozH8xI4GaYwa6V3o2AYipOb/jDLLNtahoQyMAJjMzps2rh7roojw81QKpOW8IjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774822958; c=relaxed/simple;
	bh=W/lQbU4TcrMiqCciGbdlDKp78ihMXAxzfH5vgaNPrfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn/amnjHhDU2h5h1MBBfbO2ZfPBtXF6IevBI0xuoABtuL5EBhGvM6bSjq2+O0HWxHZ47++LcSpnooxYQ2Xr3VTVTJL9RuxNOYGV058dTS1JqAunoXUjDwWPzFOBN5c2+g88Qg6SQJ8mukPkp4kiM8LZ3ACmV3TaKDlcQC38JA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw99ntM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49FDC116C6;
	Sun, 29 Mar 2026 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774822958;
	bh=W/lQbU4TcrMiqCciGbdlDKp78ihMXAxzfH5vgaNPrfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bw99ntM319iiihiH/xvIW0cHd9LiL8IXqGgOPV9c2OH/VgEuzvwPg5ubYXTLcRSwW
	 R5Q1Wwuu2pb8hU5hRYor2GrNjtV1CDqgV5mHSaPtvLlJykB4qns+jk/wUHF5Lb9lHc
	 IrSvvKfHEpm6Z4YpZLMtVxid6htRWJj8kAbhwo/b+4ypt4ThGuqr7utWls1fjCKjbE
	 U/zlJfDKtq+xQyFBmw1fLqxBM/xFhjr6dE3Prrk2Svwqisc3MLxHSe7I82JvGQ7w84
	 OkDYE9oEZtJlQubE63CBvskPig58Rco1goth0eWHcLd+/Q5qSKqAVaIWN6Zzw5k/3o
	 fEzMduFXJY3HA==
Date: Sun, 29 Mar 2026 15:22:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <20260329152236.6ad729e6@kernel.org>
In-Reply-To: <20260326235238.2940471-10-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-10-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273027-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CA8E354473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:52:28 -0700 Joe Damato wrote:
> +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
> +				if (dma_use_iova(&head_buf->iova_state))
> +					dma_iova_destroy(&pdev->dev,
> +							 &head_buf->iova_state,
> +							 head_buf->iova_total_len,
> +							 DMA_TO_DEVICE, 0);

Do we have to expose the dma_use_iova() stuff to the driver at all?
Could we have a function the driver is supposed to call to clean up,
always, and what the function does is up to the TSO lib?

