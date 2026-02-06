Return-Path: <netdev+bounces-257378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNdINMVJhWkN/QMAu9opvQ
	(envelope-from <netdev+bounces-257378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 02:54:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA47F918D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A18330058E8
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFEE2550D5;
	Fri,  6 Feb 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuOxFJ+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827822068A;
	Fri,  6 Feb 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342851; cv=none; b=V7yybiSfSntVw+jsI5VL90i7UMhBmO2ftTz1N7O6wXeL68wipXnlUkcUph+f9N4yJIgxyuBTGxad0iyZwaKF+QljgTzeTmo8P07VLhUD9OkkMllhTEcWvxy7C7jJFpjlKk8itutyKv51+hikXBwHCeThaYuw7mNSkdGwM/mB6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342851; c=relaxed/simple;
	bh=5J3kMshGAuQBNb43c32R/D42M6M9n/bqmLxIbWEwyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfDOZMRpbX3ZqVENGd9cy26Qxz3hiDN19EtJHNwJb27s8d05pxpfLMOtQXcCV5wEIW3mAv/xVu8B5RCRInPfCZyv9mCOj3IJPcrwGZ7TIJEwFMhMcrGkZd1DjjSO451UOXcCBEPROgu2Xokq+Vhh8rqp7qbEntyE2PvGWZQeUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuOxFJ+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1E8C4CEF7;
	Fri,  6 Feb 2026 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770342851;
	bh=5J3kMshGAuQBNb43c32R/D42M6M9n/bqmLxIbWEwyAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JuOxFJ+4wxUl1w911PrccY2p3Vmohj2BvL9fBMt1cWe/0L4OK4QPqbUd3fy94/Mcf
	 6V43l4m0aLTlQSxxUxPf4hj17JW7JZD9P1/iHdt5D7QkKC1BGyK9z65SH09Z3oTCDa
	 ljqWhIuXiDyG8kEJ3beU5HL6/T2d5rVuFWHTe1BLMi1zBxYS1LkEggFv9V4VuzlXnQ
	 5t161dfkh7E3JuMKyLaOredWzSUQTmlQR2/7C1kgO0oycAUgZmLy1xr4hNfP8f7DWg
	 haIZ33cCUoa8VVXPp6gxDSZhasWB8pxbjqzmfd+Irqyx6BD/kOUM6nRYyEwXYUqsHw
	 xw2DRGYeSIzKA==
Date: Thu, 5 Feb 2026 17:54:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang
 <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF
 Foundation)" <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGniiJrCrnJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <20260205175408.30ab72a1@kernel.org>
In-Reply-To: <20260205134046.pggwyosutj7ggi4i@skbuf>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
	<20260203105417.2302672-7-larysa.zaremba@intel.com>
	<20260205005901.gnju3zmqimtgeu2b@skbuf>
	<20260204173401.282899d0@kernel.org>
	<20260205122953.lscemcctayrvszdu@skbuf>
	<aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
	<20260205124638.hxzvjiocephzlrk3@skbuf>
	<aYSZw4wbd-nvLTuD@soc-5CG4396X81.clients.intel.com>
	<20260205134046.pggwyosutj7ggi4i@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257378-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3DA47F918D
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 15:40:46 +0200 Vladimir Oltean wrote:
> > > I mean, it should "work" given the caveat that calling bpf_xdp_adjust_tail()
> > > on a first-half page buffer with a large offset risks leaking into the
> > > second half, which may also be in use, and this will go undetected, right?
> > > Although the practical chances of that happening are low, the requested
> > > offset needs to be in the order of hundreds still.  
> > 
> > Oh, I did get carried away there...
> > Well, one thing is shared page memory model in enetc and i40e, another thing is
> > xsk_buff_pool, where chunk size can be between 2K and PAGE_SIZE. What about
> > 
> > tailroom = rxq->frag_size - skb_frag_size(frag) -
> >            (skb_frag_off(frag) % rxq->frag_size);
> > 
> > When frag_size is set to 2K, headroom is let's say 256, so aligned DMA write
> > size is 1420.
> > last frag at the start of the page: offset=256, size<=1420
> >     tailroom >= 2K - 1420 - 256 = 372
> > last frag in the middle of the page: offset=256+2K, size<=1420
> >     tailroom >= 2K - 1420 - ((256 + 2K) % 2K) = 372
> > 
> > And for drivers that do not fragment pages for multi-buffer packets, nothing
> > changes, since offset is always less than rxq->frag_size.
> > 
> > This brings us back to rxq->frag_size being half of a page for enetc and i40e,
> > and seems like in ZC mode it should be pool->chunk_size to work properly.  
> 
> With skb_frag_off() taken into account modulo 2K for the tailroom
> calculation, I can confirm bpf_xdp_frags_increase_tail() works well for
> ENETC. I haven't fully considered the side effects, though.

+1, also seems to me like it would work tho I haven't thought thru all 
the cases. We do need to document and name things well, tho, 'cause
subtleties are piling up ;) Maybe it's time for an ASCII art
for xdp layout?

FWIW my feeling is that instead of nickel and diming leftover space 
in the frags if someone actually cared about growing mbufs we should
have the helper allocate a new page from the PP and append it to the
shinfo. Much simpler, "infinite space", and works regardless of the
driver. I don't mean that to suggest you implement it, purely to point
out that I think nobody really uses positive offsets.. So we can as
well switch more complicated drivers back to xdp_rxq_info_reg().

