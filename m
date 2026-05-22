Return-Path: <netdev+bounces-290695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBppDlYGEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976D5B0033
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F30130022B1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6834CFAE;
	Fri, 22 May 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PVnczy+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A034181334
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434833; cv=none; b=Gcdd6SoF+C0WhBoUhQiHyISBTGyI2oTDL2PrZSn/BYSxaMCVBktH63GH/MFzynTHIxVfVH7Ia1cGKVoxJQ4CpV4Pf05MNv/AqwHc/1QAk6YM6qGU4uTBQy5qMdBU1eNdPIl471Jy1ZIocxl+WNq5DDa3TSacdCHkJ22Ap4JDZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434833; c=relaxed/simple;
	bh=cBIIzKRtPzAS7TxxLFteQjXJWf4etq8VBj2AuHXebv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpVKaDSzJm9vzmB87hIEeU0jP/QFqCtPas3wJWoEwE+QCG0DlB6RjR15+WUECmTKYRP3gxmbmAxqKd5pi3CNbpom+Cdz+ZzJN9VC1Z4CYm2Rp0xNVG/1grcsg/m7lsuUMDRtoEnXqZrdAJ2laAfQDbxPERdyuj/pq+w1kiNLaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PVnczy+t; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4CAD6C2C656;
	Fri, 22 May 2026 07:28:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A39BD6003C;
	Fri, 22 May 2026 07:27:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8449B107E8C9D;
	Fri, 22 May 2026 09:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779434827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r7DiGSD8fFaoe5sMzVIi8WS8FbDmeVFtAB0hYij7sPE=;
	b=PVnczy+tfci59N4HQ+pIRo6sqDjeRG5LfyVii3CmDXzTlveudrCYgquS1gcyAfhak2yclw
	lxPzIM5581zbzSsAurO5h7zih/RET+b2+u1perD3u8BGp6hbCdqLQ1Pe5ip3TvVkm9EZXe
	92grLx/VkLI9r/8CIsFQTqR+it5TOgQkJxINxIR+NbR5FJir1s4YnTg4X2EJ0Ka5jBo2Dj
	UsGG5aDkuIq8BW966p6XTgVefaktc00dFCvsXMpMK+TEu9zYUH3Yu082OBGu4tljHNd9J4
	i314+Pglua1Iwe4OohJ9mRenOI0MmbGjR2rc/hg42v8isZ2GonZsmiuomcUmlQ==
Message-ID: <e2bbdb18-2af5-4b3d-ab2b-87615581e6bd@bootlin.com>
Date: Fri, 22 May 2026 09:26:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] net: txgbe: fix phylink leak on AML init failure
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20260522070749.1634542-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522070749.1634542-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290695-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8976D5B0033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/22/26 09:07, Chenguang Zhao wrote:
> Destroy the phylink instance when fixed-link setup fails.

This should probably be a fix then, targeting the 'net' tree with a 
Fixes tag.

> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

With the above comment sorted out,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>   drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index f0514251d4f3..8e301e7d1148 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -521,6 +521,7 @@ int txgbe_phylink_init_aml(struct txgbe *txgbe)
>   	err = phylink_set_fixed_link(phylink, &state);
>   	if (err) {
>   		wx_err(wx, "Failed to set fixed link\n");
> +		phylink_destroy(phylink);
>   		return err;
>   	}
>   


