Return-Path: <netdev+bounces-254410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM+6K3FXeml55QEAu9opvQ
	(envelope-from <netdev+bounces-254410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:37:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D828FA7CFF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A66533004637
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE15335BB4;
	Wed, 28 Jan 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nzQ/l0Gb"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B736EABD
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625452; cv=none; b=UyPWO9oNoaFuUPC1nTNA7ggx/1I8Q9tpBeenLL0q3lDCqwHFYLRnQa/3BoNM2C9c1Mfn8G221LRc1/aktQn0OH0pidG2KJJkznRHaPKLEe76+ih+v8lmb4a1mqBkCpweD5ecIK6nxzAG5mKi17k/xCjBb0JwKeriQOqniKz1k7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625452; c=relaxed/simple;
	bh=4kjkTYxNQW11oVA9POYh0geshLO3N3MT7nsipEm3MaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRVtok1abY4y4x5UlDSDEeyWqtsns/fBNDpkbJcLjRlEIctyEdVW1K8QkWQRa/CHLfxt5eGJACL4jSG2deAKhGpDofM07+ZJ7ZK4OxkqHg7rPh/Re8qNsPfxDsfRtQTPUiAQtdxuG1JzzlmKyymaeTnDzLLGBMimwtgzFWrXR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzQ/l0Gb; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e989841a-6dc1-49e1-a4e2-773a5a1d144a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769625439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kjkTYxNQW11oVA9POYh0geshLO3N3MT7nsipEm3MaQ=;
	b=nzQ/l0GbaU+NBH+noBsS9SXMu0av8A18VB9MKKlZt0VT+pKwCPE6bJ9kObBuGUej6ofPfz
	kVO91O0HLOGTvHJmIo1QOy4I0Gvkajgbx9oxKt8CIDPib9i2rI9ahmHxTcbYWvSk5xdpOc
	BHpzV72SIVZCKHmvSAf9U5Mb1+ETLKE=
Date: Wed, 28 Jan 2026 10:37:10 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: don't touch dev->stats in BPF redirect paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Gal Pressman <gal@nvidia.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com,
 bpf@vger.kernel.org
References: <20260128161030.39870-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260128161030.39870-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254410-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,iogearbox.net,gmail.com,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D828FA7CFF
X-Rspamd-Action: no action

On 1/28/26 8:10 AM, Jakub Kicinski wrote:
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

