Return-Path: <netdev+bounces-294905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RtrTGy2LIGqW4wAAu9opvQ
	(envelope-from <netdev+bounces-294905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0003563B10B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iIA9+Bcu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F320A307D1EB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53024028D3;
	Wed,  3 Jun 2026 20:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D83402BB6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:14:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517673; cv=none; b=YsOy4aCcyNOGOGnSU3wXI1ba8l7+luHa1zPR5FPfUzktXTmz5s9mt3kcMwPy9i1EXBogKnPis/5G6ah2Xm3yp6etpbIPMLRmc1qJknUZ8KNSR2eUHyx+tHLV9jueJqYscK/HR1p41qWUysCk1eKr7Oa8/KJeUhXAIrUTZYM2nQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517673; c=relaxed/simple;
	bh=sU7a+cepX5Yo0+ifY+l6yrlTvgf21pD972JHq2GklJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeeJzFI0P7mHhNm0xg7Ys+31fCC3uUW8B6TSOJbETzmzJ9DJxqUTo1kxkq+4I4nA8rbI5uRXaG1k66dchTsUmHxl6WFFD4Dap3hbNg8uNojkR0wPBVxBr/zS9FFA6OdrUCqNHhYwbqNuaaLA71KLmZnYX+7cKtvEZJm4PkGvi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIA9+Bcu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3A41F00893;
	Wed,  3 Jun 2026 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780517672;
	bh=uXXxZ8FqhgPcL5gSEGJG8WHkuHR2HXsCZkOQLVDE8ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iIA9+Bcujh2XJOug029cRJ57fG4IiDUEMcuFERvMchutZIsdI9j87UIa5KC5Sl9AK
	 AHWihb9Ktf2RkJFOZXiAO+0qq8S4SfT3GBKolSqqKRUkPHIHDIZ80BRrJRjj1gb86k
	 EGZa60f3LQ+wgM8mCMhvIgYsr1yiranjjdexkOXd5Wc/7TI8yePDDkBmdW8oIJHphX
	 kfIzwiTav+dWB3KCzpeXLyUEH6WfGv5DDbljKN1YnFXy92acJCeoroTPXb94Qo6Fv1
	 S61VrIs5mPf16IgblEkmOxxdiSYVoXVFP1j6fi9gP819cAkF0ba244JFBAjJ2NtOFr
	 gBjlnC8fkTcTg==
Date: Wed, 3 Jun 2026 21:14:28 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] geneve: fix length used in GRO hint UDP checksum
 adjustment
Message-ID: <20260603201428.GJ3766816@horms.kernel.org>
References: <20260529144713.780938-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529144713.780938-1-atenart@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294905-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:atenart@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0003563B10B

On Fri, May 29, 2026 at 04:47:00PM +0200, Antoine Tenart wrote:
> In geneve_post_decap_hint the length used for adjusting the UDP checksum
> should be 'skb->len - gro_hint->nested_tp_offset' (UDP length) instead
> of 'skb->len - gro_hint->nested_nh_offset' (IP length).
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260521131436.748832-1-jhs%40mojatatu.com
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, an AI-generated review of this patch is available on sashiko.dev.
I do not believe that needs to be addressed in the context of this patch.

