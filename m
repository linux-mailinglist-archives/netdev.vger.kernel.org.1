Return-Path: <netdev+bounces-261757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPgsG/9PoWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:04:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C041B43B0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D8A5304F20D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F13290A2;
	Fri, 27 Feb 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FXvndWdd"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D25155A5D
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179450; cv=none; b=Mqk+Qdc4Nn9kQNn31TR9G3mIi03IiNPACnkMsQbujO7aEaKphmFq+FAZrZ8TVWlAyQY+RIMoCPSkcM8IcS2saMKrc4UA4QU6+eI3ADouujn22rg9LlmxEGz/eSfjWYiIJCRabjxFeR4ZFejJfdc+9MdhRnprH/V1+SH7E8j46Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179450; c=relaxed/simple;
	bh=2vORYo66yn7LN0cpDhbt+ftJyzsJ6bgxaIEmAJx5oRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsnuwWC7l1r+mer82Y/eTJfzPgCp23Jlvt9ZoOTM5568m3kYyoCHgTnvLUfEw9n398eL5xhUN5fIrfhRBwEkHVSMCbTdUH0HN7Y+CKcSlYmjUGFy1baXQBc/lQ1yKV0EmQUbcxgg+RDHWP6bvtuzRSpQsbxXxA8wN5TwGarwDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FXvndWdd; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fMgnq11x0z9tH7;
	Fri, 27 Feb 2026 09:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772179439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE5+O80MO6biQr60RUXZSDWfawGNaQbWAKOhs7fh93U=;
	b=FXvndWddSvFWqLPXzZb/KifcvGALsYxnGIGqzKA/PMsCH/vq9l05fj8lgxcbALftM+k4KR
	RuRSPPpmzGjWI0T3yTo0j/YdScpR9GpqpPivMIEyv8bDxw7wVdT0s+WfCKwEmzixt6Oc9p
	DJ0PqqDQFO/qggYKzVUi3F78uU693iAzTCzuGFzyYNYQ2qhULkSUaoYY2mC6AlwKonCSMx
	0GDTUnHt65mnAlITIJavfDH4iVJFbwyAfsdPXwPHyvSaod9+rc7nf5M00f1rE3dc8T+qtL
	iNkCPQXTwhn4wgjjFF3l1oCZljwTKgeRtBkS9SvWW9s0EQ43rYGH4XnhZRf5pQ==
Message-ID: <79a0ba8c-91a8-47e0-81fa-275f15ede96f@mailbox.org>
Date: Fri, 27 Feb 2026 09:03:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
To: Daniel Golle <daniel@makrotopia.org>, Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20260226154547.68553-1-joey@tinyisr.com>
 <aaBvaG3M58W4lhVC@makrotopia.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <aaBvaG3M58W4lhVC@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 49eddd4558c34cb98db
X-MBO-RS-META: wswkn4153qy9xdma5jozx3zqyfpxbitf
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261757-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan.roese@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,mailbox.org:email,makrotpia.org:email]
X-Rspamd-Queue-Id: 01C041B43B0
X-Rspamd-Action: no action

On 2/26/26 17:06, Daniel Golle wrote:
> On Thu, Feb 26, 2026 at 03:45:18PM +0000, Joris Vaisvila wrote:
>> The MT7628 has a fixed-link PHY and does not expose MAC control
>> registers. Writes to these registers only corrupt the ESW VLAN
>> configuration.
>>
>> This patch explicitly registers no-op phylink_mac_ops for MT7628, as
>> after removing the invalid register accesses, the existing
>> phylink_mac_ops effectively become no-ops.
>>
>> This code was introduced by commit 296c9120752b
>> ("net: ethernet: mediatek: Add MT7628/88 SoC support")
>>
>> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotpia.org>
> 
> Cc: Stefan Roese <sr@denx.de>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan


