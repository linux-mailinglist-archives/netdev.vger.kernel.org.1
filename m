Return-Path: <netdev+bounces-281561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHNsLM0B8GnYNAEAu9opvQ
	(envelope-from <netdev+bounces-281561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:39:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85947C375
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B962E3011066
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB723183B;
	Tue, 28 Apr 2026 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw0Gbr87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577C40DFA4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336777; cv=none; b=T9BYcy/uLEz6v6T9nqBiATn9uHbmahHPQXgPiiZEDCO0C7qxQoy4eNiM3EpVf/mHumGJr0THKWnQVFDlg9y5MjN3I8CHFsU5ttos+urwRQwYt86qJ1gas6CFn3exnKKyitX4SR7n5JeRCIbpUBs6xFDvKyBEgCWXJTnu+ySXaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336777; c=relaxed/simple;
	bh=MAMa6vTtoi7fNc4aPZiXN/+o69qBE5qG/vNxRIzbVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BionrUYlsb2z2AXifqFFWuXNbNgB6xiIktdTjKyP2Kk0ipRIatIpH5Oq5btBP8oUlUJ9dboUVXGL0DNuH0BLTdScCd9QJG9KGxZRU4vB/DIlN03NN+BMsFm6awQOe0iw81r+WDjdnyflv2q5ws93H4NW9EoFzoL0a0bn/qwdYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw0Gbr87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE42C19425;
	Tue, 28 Apr 2026 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336776;
	bh=MAMa6vTtoi7fNc4aPZiXN/+o69qBE5qG/vNxRIzbVq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zw0Gbr87pxsFVokdtBkbeZ9bq68xGjDw+5kvhWpP09imCFPucT1WlCr2qWrXAeFfu
	 8f5XD9YYjZV/mdfmaEAE6bt9LsJgKUKdcEWHk/6tNq0Oa4z5thUX0Nd9v5ccx67wrd
	 kybbxAECg5sKbVhwk727idDuZZn9PzTsDUdUZwkT3cMRe97pm2OzeqY9NR7TGvY0c+
	 CL+inC1bgBylJPVBy+NzYmMerFvXsHD/20rWqxR+TmbkuMTUfLQCHIHprLfD4y/6S8
	 GcCAIdWneunTY5PTNiHg+A4lGWmU+iXClVmFNaZkEdez4lIWHZ5NdyeBjBMioUJAzt
	 G4IO/DdQRUozA==
Date: Mon, 27 Apr 2026 17:39:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
Message-ID: <20260427173935.6a1e36ee@kernel.org>
In-Reply-To: <aezLa2POvT0It5AA@lore-desk>
References: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
	<aezLa2POvT0It5AA@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2D85947C375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sat, 25 Apr 2026 16:10:51 +0200 Lorenzo Bianconi wrote:
> - Does the TSO checksum calculation earlier in this function ensure the
>   TCP header is in the linear portion of the SKB?
>   This issue is not related to the current patch. Moreover, can we have a TSO
>   packet where the tcp header is not in the linear area of the skb?

Don't think so.

> - If dma_map_single() fails partway through a multi-fragment packet and
>   triggers this goto error_unmap, will it break the Tx ring contiguity?
>   This issue is not related to the current patch. Moreover, I guess the hw is
>   capable of managing out-of-order descriptors.
> 
> - Is it safe to map fragment data using dma_map_single() instead of
>   skb_frag_dma_map()?
>   This issue is not related to the current patch. I will post a dedicated patch
>   for it.

I don't think it's an issue. Unless you support DMABUF zero-copy 
the skb_frag helper is just for convenience. I wouldn't bother.

