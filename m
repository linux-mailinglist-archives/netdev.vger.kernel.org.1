Return-Path: <netdev+bounces-258892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CZLGwwik2kX1wEAu9opvQ
	(envelope-from <netdev+bounces-258892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:56:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E723814445D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B78130347B1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306630FF06;
	Mon, 16 Feb 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx/YoIjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD830EF71;
	Mon, 16 Feb 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249643; cv=none; b=dZBzAFoxfgZgfSdiMVTyWrt+3k5Fil1OgsI/OYMJ8jiwI5ZuM4ZEMiWA1TFPJq+oSPxVb4Ns2sM8H0J3/+AXmv3aLJGQfeGOFuyLfAoAQHwbzP9y5KC1UjPz00OeEzPTKOGqfbQIE9pptBtUncVOkXcUCXLqp5XIArW3nar54I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249643; c=relaxed/simple;
	bh=XOBgEIM7Lu9hd+RuAv/bHWbuHCTf1O5fu12o+3qT31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0XOhOq4obMBFGnyDeuioWsggQ1webAwEa/1kROjN8G1OmFo22rACzxxO46VoQ5pOncIAlFAsb7C2x+Vuq+92dsOoqPgVQxzPwJ/FRW4OCQdvYIWst6yxZj4trzpXjelVCdvRLCa/E/TKKTtBj33o6DWJdR22/zWHs294FrA8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx/YoIjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B128BC116C6;
	Mon, 16 Feb 2026 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249642;
	bh=XOBgEIM7Lu9hd+RuAv/bHWbuHCTf1O5fu12o+3qT31A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx/YoIjMAQSs1k5yfxgt+kE6A/usXZpB+R53mPHZX1we+0/JqTXIxBH5ALUOKB4jg
	 ZJrri+X9jWVcNz0I6IjJHKxvyqz6wW63F3hXLBkh93u8vx3vHKbt/HmV8dlI1MmXyi
	 F7mLCkXy3WCPFMTtAKLRn3TK1AjlyghEUTykxrguF33tEMgKVO80ST5TpD5HpjezwF
	 7z+yXmnuuxpStD9r4xaVlt0UaqBf7HXHrUyNhNTSH26Hv0e5VXwsXigDcdsQpckeSd
	 C8TlZDCHlkVvDW1F1ZyLvPE4q5LRvpB5a1U0rhx47IHz0I6J5ipPQA65CLL5d7lz5q
	 sB/Y5ellxURWQ==
Date: Mon, 16 Feb 2026 13:47:18 +0000
From: Simon Horman <horms@kernel.org>
To: Tiernan Hubble <thubble@thubble.ca>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenz Brun <lorenz@brun.one>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: fix reading SFP module info on some
 AQC100 cards
Message-ID: <aZMf5mhI3TutuPvT@horms.kernel.org>
References: <20260215212609.193815-1-thubble@thubble.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215212609.193815-1-thubble@thubble.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E723814445D
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 03:26:08PM -0600, Tiernan Hubble wrote:
> Commit 853a2944aaf3 ("net: atlantic: support reading SFP module info")
> added support for reading SFP module info on AQC100-based cards. However,
> it only supports reading directly from the controller's hardware
> registers, and this does not seem to be supported on certain cards,
> including my TRENDnet TEG-10GECSFP V3. "ethtool -m" times out when reading
> certain registers, even when I increase the read poll timeout values.
> 
> The DPDK "atlantic" driver reads module info via firmware calls instead of
> directly reading the hardware registers, provided that the NIC's firmware
> version supports it.
> 
> This change adapts the DPDK firmware call code to the kernel driver. It
> preserves the old hardware-based module read code as a fallback when the
> firmware does not support it, to avoid breaking cards that are currently
> working.
> 
> Tested on 2 different TRENDnet TEG-10GECSFP V3 cards, both with firmware
> version 3.1.121 (current at the time of this patch). Both cards correctly
> reported module info for a passive DAC cable and 2 different 10G optical
> transceivers.
> 
> Fixes: 853a2944aaf3 ("net: atlantic: support reading SFP module info")
> 

No blank line here please.

> Signed-off-by: Tiernan Hubble <thubble@thubble.ca>

...

