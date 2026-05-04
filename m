Return-Path: <netdev+bounces-283745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eORND7hV+GmWtAIAu9opvQ
	(envelope-from <netdev+bounces-283745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B043F4BA089
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A73301652E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2D2EA168;
	Mon,  4 May 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvufxi4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838574C97
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882279; cv=none; b=fZRvHzKX7oUv7KiLLEcHZXFym6KRtNxuE/9pI5Y1rfbeapce+bIzxf1cr5WKLoHI6hMVk2kYt9vuYBda3sS4pcWjvOJ7zWz6ghiVNfVLl81lQ4lNXslUkzAhuQlLIgNgaydwCYF2Pf9EIXSt8hfbJAkK6sxGyyFqWzdY7mWZstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882279; c=relaxed/simple;
	bh=hBrj2lSJTLetwTP2wz6GowWY14Ggyw59DxllDhGpQHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9zCQSX5p2pZuJfD4eljJelbkIZJRR4ozve7pG7A1V5alHGD4WRZwksKzDG9VPGV5k+KB4Xn0/jdVlL0bT/L8ESMoUO3EYxRVpDEzicWN0GEcamSuCOiln+g0qQPKujxCqqaiNeO4CpwCMTR9O4Qpw6Wu6WoyuCPT3I1Gc7A5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvufxi4g; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3652546e41aso714602a91.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777882278; x=1778487078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JMYtbUj01a1nUxyIuR4eIbeTRMLJqB5qPkqXXsohEzg=;
        b=Vvufxi4g+y3iSewiybyPuqLpxrlTUp2N+mSh//ua9ozm9Ltu7k+iSLzZOUzn6geVQH
         VDZO7aqvxvgJw5Mq0577iGaiQ4sfWaylCgn72Ab2VdsTQ0KhJAQTiiDIZWLyLOzhCJM1
         dyGU3Mg5yudbdf8RicwHPGDiLCtLUAU4Q0H5QcW0KJuA+txKDVOTHWzpJv4QwK9WxLPj
         /sZy5z7SbIO8RMiqXpwh3Rs8nJVhGNyw8gOU32QkCZVKx2gDupazUSBV6w8XAJfiJ/QV
         J7+pvR6k7BTKc0UQub+8pwi5wNxMiQlz2AGZY852ZM7UZUWpIr6uI5l8dr++g9bgh6XQ
         sCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882278; x=1778487078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMYtbUj01a1nUxyIuR4eIbeTRMLJqB5qPkqXXsohEzg=;
        b=KejKHJc7zrkhRvGhrAwF5H347AqLyELb0Q8wo27qU6OsXkwREXTK0nhKVvg90AKuJz
         IFl1P+ST2SvtMGhIoPXYvKnSAS34J/geuolm9XtztfXTxeBdT8dT07PvXTnq8ZGA0QDR
         RxiEleYzmRQslemks5+0UTiab6CApSgiGfVqsx8ah6a0QVsnr5+sLOqjm96pYdY2ruOv
         qJ8wVcn3k0TzSwD4Yt3C/rSgdtZbOXqPBa7A9a/eDI7JL+AAKJ2fJjZpEf3jCcxckTXH
         1ifBQ9a73QQjCdR1sob/GfrTpAabnhBTiBD3MTlMnt2PfURuD4ERgSoKNC3/z3lHGQZ8
         7r1w==
X-Forwarded-Encrypted: i=1; AFNElJ8d9G0TNpqyc7o7IRsHm9V1MWxKyNG+oH9+ftIMXiA4CwAwSckOLb2/kQ7CcxfhDXi4+zI8uZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nfSHnamZBfoWDuqqnZhgiKbJ1h3qc/TeWc+XGzLQ5tWx8wjl
	LCaeFT312x1xZFT3y6qvU9c0wGYMG9DG5eog2ehZJnuKo+glE7y5C/Nm
X-Gm-Gg: AeBDietPHkS8sRdpelBPkpMEMyQVmqXN37ECnMz65B8mCPbp1bpDr6pzKG9ANQ8+8OM
	vg+/7o39cD667V8yQ+epaeA4zG4B/4sJSi/IU/dtnxZ73DJMjZoFZLCdyF8Ln+bwtb9fqhJ1wxw
	Olk0b3jkjgNR0vfPRBKcy3gCuOkFcJdPLVzvgSxMCfhmW4wtZKGvNHE4BNk/Rr5KZSmQecaHNPl
	VZzqWiQm4ceAhhGSYAfUWahg4WO7YB6/DFeKcCmnh36tla3EYEGfCNkgPnnOjUGEq6Zi2Z0UZkv
	xa5DlDZzxLhSMpGG+umvRXDtD+xEtUVJLxQY1qSzPTAt3iHtcmeIkSg4nlO3UEUCB0B8tSTwQnu
	tB8rgVAkhc9UQt/I7o/LinXu7vC4qSxueX3weX4S2yJ+WdQWRVp4fm8tyStyCulMt9lXQTQ7jaa
	cOutKbYRHs72xZOtOpPJtJ1nUL3vZYe1zxJ2X6biMXWO9rIie0OMZc6XG395ZVwV6r
X-Received: by 2002:a17:90a:2ce2:b0:365:46aa:e62e with SMTP id 98e67ed59e1d1-36546aaec0bmr1885640a91.24.1777882277739;
        Mon, 04 May 2026 01:11:17 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364dd3e9a3dsm11587831a91.16.2026.05.04.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:11:17 -0700 (PDT)
Date: Mon, 4 May 2026 17:11:13 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Eric Dumazet <edumazet@google.com>, HexRabbit <h3xrabbit@gmail.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] xfrm: esp: avoid in-place decrypt on shared skb frags
Message-ID: <afhUocdXhimtPK5W@v4bel>
References: <20260504073403.38854-1-h3xrabbit@gmail.com>
 <afhQjlpmt2agPcRE@secunet.com>
 <CANn89iLeX5eZuH6c=_HcADzgejYzE36HhFxmvg+2U3gqsOqHkg@mail.gmail.com>
 <afhTekPcnIak0IcI@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afhTekPcnIak0IcI@secunet.com>
X-Rspamd-Queue-Id: B043F4BA089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283745-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,redhat.com,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]

On Mon, May 04, 2026 at 10:06:18AM +0200, Steffen Klassert wrote:
> On Mon, May 04, 2026 at 12:56:50AM -0700, Eric Dumazet wrote:
> > On Mon, May 4, 2026 at 12:53 AM Steffen Klassert
> > <steffen.klassert@secunet.com> wrote:
> > >
> > > We have antoher patch that addresses this issue in a different way,
> > > so Cc the author of the other patch.
> > >
> > > On Mon, May 04, 2026 at 03:34:03PM +0800, HexRabbit wrote:
> > > > From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > > >
> > > > MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> > > > marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> > > > so later paths that may modify packet data can first make a private
> > > > copy. The IPv4/IPv6 datagram append paths did not set this flag when
> > > > splicing pages into UDP skbs.
> > > >
> > > > That leaves an ESP-in-UDP packet made from shared pipe pages looking
> > > > like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> > > > fast path for uncloned skbs without a frag_list and decrypts in place
> > > > over data that is not owned privately by the skb.
> > > >
> > > > Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> > > > TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> > > > present, so ESP does not decrypt externally backed frags in place.
> > > > Private nonlinear skb frags still use the existing fast path.
> > > >
> > > > This intentionally does not change ESP output. In esp_output_head(),
> > > > the path that appends the ESP trailer to existing skb tailroom without
> > > > calling skb_cow_data() is not reachable for nonlinear skbs:
> > > > skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> > > > tailen is positive. Thus ESP output will either use the separate
> > > > destination-frag path or fall back to skb_cow_data().
> > > >
> > > > Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > > > ---
> > > >  net/ipv4/esp4.c       | 3 ++-
> > > >  net/ipv4/ip_output.c  | 2 ++
> > > >  net/ipv6/esp6.c       | 3 ++-
> > > >  net/ipv6/ip6_output.c | 2 ++
> > > >  4 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > This looks ok to me. From the IPsec point of view, I'm
> > > fine with this patch, but it also touches generic
> > > networking code. So I'd like to hear an opinion of one
> > > of the networking maintainers before proceeding.
> > 
> > I have not seen a Fixes: tag.
> 
> Right, we need a v2 with a Fixes tag, and maybe also
> 'Cc: stable@vger.kernel.org'
> 
> > Do we need to split this patch into two parts?
> 
> I don't think we need to spilt it, we can merge it
> either to the net or the ipsec tree. Both should
> be OK.

Also, please add:
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>


Best regards,
Hyunwoo Kim

