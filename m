Return-Path: <netdev+bounces-278838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDfMHsO832mOYQAAu9opvQ
	(envelope-from <netdev+bounces-278838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7063406613
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66AB3083FE8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B23DC4A0;
	Wed, 15 Apr 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDR7JnJ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B744334C17;
	Wed, 15 Apr 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270405; cv=none; b=YGduebCuZMYC2h07QPFp61bhlXwzScwo92wEvT6Pe4UyMkdSPvAXhwJbdiGE1kF1S5MIRzm8vllLDTYl6PhOs7MG5AA+Rw6FVunsu6yzeZ3JGLRXFFv+suS6VI7IyaCAa7oMl6UO2A0opM8GkjA/rPaCP8GE2SNzP8w1JAht82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270405; c=relaxed/simple;
	bh=a8mDYPz1M6wXk9VaiA8wda/mu1hXkdRK/6Aw1zc3d7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkzZwoT61nCivxl7XxLOXnuoaXzPG0+MHNEXUMihGZyIOe5aDEnFVzSvGWpD6hYhkJZBgtoXBIqzlSlOZ1Fva+luWg9N2PUi2CMt4mUQz2MOQtEOIKKAV5VVYTZlZNgUayE/gHJ0ESrPswJQLX/A6Vpenwdnz1iu4qeL8AILn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDR7JnJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6CEC2BCB0;
	Wed, 15 Apr 2026 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776270405;
	bh=a8mDYPz1M6wXk9VaiA8wda/mu1hXkdRK/6Aw1zc3d7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDR7JnJ2voaF/uOHFNKKwOuuvY9g/JwJsXK4/Gm2/AZyKHjRdH5Mrg9kdFi8A+KmN
	 qLsrHtVNOBbnppRyyf26514i4RkBop7DhdAQ6ezopPC5q4jC4iBc9UMGzf1iraO67n
	 CrfoKCnazPjNDG0Ud6jPi2krp49MRoWF99M9J063n+54vRYEo88uFmQXAwjxwNsLVs
	 vIm9t2zChMHyVHqt5ZhxDyJhCmtfzt4qaW/9bp0GvHy+j/n/c55IwNMYZJBcK/DW/N
	 nLrRqcxnh+PIhn8253KaFNr1Wl+wqBAlEIEEB1QOT5fGq78ec8rADC5do2iZus2aWb
	 T0B4ymmpnZtpw==
Date: Wed, 15 Apr 2026 17:26:41 +0100
From: Simon Horman <horms@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfc: hci: fix out-of-bounds read in HCP header parsing
Message-ID: <20260415162641.GO772670@horms.kernel.org>
References: <177614425081.3600288.2536320552978506086@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177614425081.3600288.2536320552978506086@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278838-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7063406613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 05:24:10AM -0000, Ashutosh Desai wrote:
> nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
> to struct hcp_packet and read the message header byte without checking
> that enough data is present in the linear sk_buff area. A malicious NFC
> peer can send a 1-byte HCP frame that passes through the SHDLC layer
> and reaches these functions, causing an out-of-bounds heap read.
> 
> Fix this by adding pskb_may_pull() before each cast to ensure the full
> 2-byte HCP header is pulled into the linear area before it is accessed.
> 
> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>

Unfortunately this patch seems to be whitespace-damaged
and does not apply. Please address that and repost.

-- 
pw-bot: changes-requested

