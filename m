Return-Path: <netdev+bounces-301095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9QOMjYrOWpTnwcAu9opvQ
	(envelope-from <netdev+bounces-301095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:31:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17D6AF736
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:31:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YrmOh2GV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301095-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301095-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18F9301B92D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09253A7193;
	Mon, 22 Jun 2026 12:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AA3A9D9C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131501; cv=none; b=QLVLuyYcfeg8a40FeoWG9TRFPnd6LXWcwhgPDwKFkwrs12wQibbLjVX73s7W5kMBjnLEnokZVtYF1n7F8OoejQ6vkdw6VkIHw/1j6UNwVRi3JyxUuOdibKWGkQJsC+Y1ge3qfdQ0tLhRwYPqssMxGBYe2oIyaO2kFbqS+SZSoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131501; c=relaxed/simple;
	bh=oeqhaPLp8ej9rEGowTO0rZuMYcCiYVDbc+yFv3sa+RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFCG6kba9OiafFdXDl44Cb41RM1g/ypqz0FRbIXsYxk8Hf6HJh3q7UmrwSv9HV2A+QHftswzmUdMgvReV+EvmjyEb6rCDi4o0WZVGa2ewFRPiC7QhFDTP30Sx30EQ00d1lNmYVvcwZPQhxf70xUwhZP5se9HfZTir1+tx5ZttxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrmOh2GV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F871F00A3A;
	Mon, 22 Jun 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782131500;
	bh=YrvQZarvBaqo6562x1DTyzlBVnEuUX8qf3CFw17g3xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YrmOh2GVwMxg8umpXDDmyE1exfsL/3W5IXzdl9M4lKtjZdzGaOAw0FwiSGILT5ysv
	 SOMcqFdC/oIoVFOf0bF2VrLi7PvTouGdEhHEYVQ9emHRpj7fDCDYGYLuv+ugHVTX08
	 xoV42t0/CFp6+GvWx7Ro587G7hklkQxALmebqc+gL8W80fviKakDHkUOMWTOEzzass
	 fG5PSUmxQ4cyE/Cc40+WYN50pRn+1xyDYqn9Wk3GWM648r4Ut/6yOFsOlBZSo3ORR6
	 08iBrjgIW+POD43DEg1f4qgpdPCQnijF2aDR5hg67jeGKm84I+REbTuawJGsM6LoIN
	 JHJwKcwSbiO8Q==
Date: Mon, 22 Jun 2026 13:31:36 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Message-ID: <20260622123136.GC827683@horms.kernel.org>
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
 <20260619-airoha-qos-fixes-v2-2-5c43485038f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-airoha-qos-fixes-v2-2-5c43485038f9@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301095-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A17D6AF736

On Fri, Jun 19, 2026 at 01:37:14PM +0200, Lorenzo Bianconi wrote:
> airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
> index (opt->qid = AIROHA_NUM_TX_RING + channel), but updates
> real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
> channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
> 2), the returned qid can exceed real_num_tx_queues, causing out-of-bounds
> accesses in the networking stack.
> For example, allocating channel 0 then channel 3 results in
> real_num_tx_queues = 34 but qid = 35, which is out of range [0, 34).
> Fix this by computing real_num_tx_queues based on the highest active
> channel index rather than using a simple counter, in both the allocation
> and deletion paths.
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Thanks for the update since v1.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch on sashiko.dev.
I do not think that should impede the progress of this patch but
you may want to consider it in the context of follow-up.

