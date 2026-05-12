Return-Path: <netdev+bounces-287204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGu9NGs7A2oL2AEAu9opvQ
	(envelope-from <netdev+bounces-287204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:38:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94251522B30
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76EF4309CF09
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412423B4403;
	Tue, 12 May 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpyNFn3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36035958;
	Tue, 12 May 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596367; cv=none; b=YeccS3BjXtKqR7Jdy1dq+EvZieLTYzPxhJa6C+jNb9CCVSRY3dum1AmYP6NLD0fwhI3WdRbGr622Z9PgNBY+J0OnKaUK1S/t6VeVsdeRqo3UveV/saA+73fN3c8oiJCJ/k4RZyAd8kFr3Q+8ur6pPiJYTD2rNCPeSMJUyvuyd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596367; c=relaxed/simple;
	bh=y3QM0+OVP2mJ84raPj/jp3E4v8AyEL0XEzOLGP/ypyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOL0bptRl7irmiSJWmrSqAhw1fx/llHk4Le7rDvOHQCzMUMR14OugbjYbfFUZciKYrlSBSH9w+oVwqcRQXS7uLrwp7aiIzxu+ki9JrV3LeHuRliKYsQ9Oq+51ado1OBM3RIryHyFsyfeNl0t1VTyyFQzoHP0R4yxqrczKiCuWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpyNFn3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6CFC2BCB0;
	Tue, 12 May 2026 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596366;
	bh=y3QM0+OVP2mJ84raPj/jp3E4v8AyEL0XEzOLGP/ypyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EpyNFn3AwjiUk3PMNr6UO/vqEYY0IZx27wR+ZFKgXuoug28RfhwTXZ9/TGPd6KXog
	 wdpeRJDd02NAkrC4bMwhTMrTqhUckqR0BXtPm7UGXFXwHPMr5FgplQXGaQ6qnzK0jc
	 hefVwjEr3GfuPEcnaD206w/pPe2VFM9hOzcVNUZeRrsGlDslHHqAlBkUfV7YCW2sDp
	 36kJVZHBx4zBd3g+PJFopYPM8jGf1mZGOmUpx+Xze+fbQ4bHUY8m0HUR9KzciDsRxF
	 Rmn21j7eTL1dPwii9Rg2p9rCzHbq1KWb/o79uawYikMWWHjI1dR0YzA0PdmAFl75Yl
	 8G+EH4z1XvbNg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
In-Reply-To: <20260509084858.773921-5-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-5-maciej.fijalkowski@intel.com>
Date: Tue, 12 May 2026 16:32:43 +0200
Message-ID: <878q9ok8ac.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94251522B30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287204-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,all.your.base.are.belong.to.us:mid]
X-Rspamd-Action: no action

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> veth currently runs XDP for skb-backed packets by constructing an
> xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
> skb-backed xdp_buff into an xdp_frame. The backing memory is still
> skb-owned, so veth has to pin the skb data and frags manually before
> consuming the skb.
>
> Use the generic skb XDP helper for skb-backed packets instead. This
> keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
> xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets that
> already arrive as xdp_frames keep using the existing veth xdp_frame path.
>
> veth still provides its own page_pool and xdp_rxq_info through struct
> xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
> metadata kfuncs that need the skb continue to work after a possible skb
> COW.


Hmm, so now if veth with native XDP redirects to a native XDP NIC, we'll
end up in the generic path? We'll loose some bulking capabilities as
well, but maybe that's OK.

I guess what I'm saying is that some performance numbers would help
here! ;-)

(I think it might be some accounting bug as well, but I need to re-read
it!)


Bj=C3=B6rn

