Return-Path: <netdev+bounces-289195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNBIAEmeC2p4KAUAu9opvQ
	(envelope-from <netdev+bounces-289195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:18:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F07574EE2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E593015E27
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872C3016E1;
	Mon, 18 May 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpRw/8Nt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84721405C5C;
	Mon, 18 May 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146309; cv=none; b=U2lzZUsqfpJl/nhuMe5h0oAxIV2Ear22hnj8rk9VKJTmZrxaKhvYBT7BrEVstXn/Gw/6a5TWVYq/beOprnBttqHpHKgp4gg49HOvcpl5uiQOK1cOitSONPrmXBccPNPnyJ2pZlS4Vf0Z9KKRUeaEmu8xGWo8IgC43zNPwmkOZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146309; c=relaxed/simple;
	bh=hSrUietGsWm4nbIdz8mtePDymIlbVtfyxxCKrDmNEik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHEssEzPsy+4lRt3cY4tuPXl+/g8GKXvKmWHxg5vfE/jyI3gmrl3ev+NxIL+K4odHtNhJajUMU8Es/H7cQd1Ul6nuTQxhgI4jQIC7g4CgGD3vaJzoHlGe7R8Fpd56E6TpQ9XatjduzH9gi33g5mbim7WWhwRJCZDGb18HU0tX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpRw/8Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A00C2BCB7;
	Mon, 18 May 2026 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779146309;
	bh=hSrUietGsWm4nbIdz8mtePDymIlbVtfyxxCKrDmNEik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpRw/8Nt6yO+BBPAie79YSEvMfXtWiReT8HGBfDWNZZnaOPKUNFBwED9UB0v8G/88
	 lHkaWHon75Pr+Qj+2IR+Rs+CXxyyzjt6mqbx/UZ5muUuXVMszlKv6EUE5L/ocPWXqi
	 8f8gXpOChRXW24oWtBs+ePGo8wCi2HzvYUpXX2pmZsC/EUHN9qpUCLT7iXkU19OcwY
	 jqh5FSzaE0Vw5fJ6vcKnXAXOHC1G0HsG9KtNPejHpEzCAG9WHWN6FRhDBaIb1d0Yv5
	 nkaDMpUFyNrPCgA6v5Ndzokzq9uZfiXDS2ifJnCgLESEjizzS2W6sUbhuSq1LDJGag
	 0dC/SDmhRVSBw==
Date: Mon, 18 May 2026 16:18:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Message-ID: <20260518161827.2ac4766f@kernel.org>
In-Reply-To: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7F07574EE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 12:47:09 +0200 Jakub Sitnicki wrote:
> +		/* LWT BPF programs cannot access skb metadata but can corrupt
> +		 * it with helpers that operate on skb headroom. Drop it.
> +		 */
> +		skb_metadata_clear(skb);

Sashiko has a point, right? Is there something in LWT which would
prevent us from working on clones?

