Return-Path: <netdev+bounces-258015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJb1E+CRimk1MAAAu9opvQ
	(envelope-from <netdev+bounces-258015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:03:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187111623D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD92B3006928
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4A429D277;
	Tue, 10 Feb 2026 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="eHssQR0U";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="nJGphPTx"
X-Original-To: netdev@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E722D7B6;
	Tue, 10 Feb 2026 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688987; cv=none; b=JAdoD1Q8Q59tt7wjOGg1vDN+bJd/NBxeo441tMG7oHhJzdj7P9PWT+ux+0BRYBxnNZiLtkKTp3XnMtihIaRmxnS07pb+dbqFwUzEV7OmJDHEUvcyF3sZpAVWrmh4652Xozozdx/4MTWp5etEpqvd5tcvjfTxW10GeeEqVYUvXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688987; c=relaxed/simple;
	bh=riLKeXcE3SDkoNfwPHn8lB3ud/YG40t/m3fvt2H9ICI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyBHwE5Ft115S84JUz5pb6Phnc3ITFdnDrGSKTvuX2H6ABKT6RhCO+drV49/4o0E9HAhqsicGxi0Rxu51nezpPhe3BPUgc1mvcOITztSgdtyU/kQ15EqvYGtmjbIMELL9jL0Qtqxp3ALmLg+LNdshGtaEBqapW2S7zy3eaVmQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=eHssQR0U; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=nJGphPTx; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1770688970; bh=EHMwWUzopysx2OW5PQDuyM5
	RK9zojql1474DYZ4AwGE=; b=eHssQR0U5qDayguOYMKloMMc8H3eXZW5+DTSgMYwaIqks/8fbO
	Y5VN5Y/zvQiKxYEwCZrYsfxGPYvTa+2Vm/bAkdHicPz/fUdFMUWtwcP9J5s8c5ouAK+BPsdbqCS
	duACy+SMTB1uQcVRjBXVtgGYf4q56TgAGymYxaIoJQEIVABJjj9LS0c3tEl0DOz92lL/LqiRoxv
	YNjZbpw93evvb4v9Wb59wwfGGN6n4vo8masoBumcy2zkNElq/HDJIu3DKp9KTo84333r6Ohpqsv
	SGvYRh3xSeEz+1rnCfo1Sv2cKmA06cfQqfHr3Epu7RvEwPVOMznMdEVvIJe7r0MwOag==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1770688970; bh=EHMwWUzopysx2OW5PQDuyM5
	RK9zojql1474DYZ4AwGE=; b=nJGphPTxbeXd+QUQ041ezLX4HsnyTIq0ERFudn/KysJ89q/GVC
	dCed+7wsnEU6PEm04AHwXVc3nTeYuve9p2BQ==;
Date: Mon, 9 Feb 2026 21:02:50 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: Daniel Hodges <git@danielhodges.dev>, sd@queasysnail.net, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
Subject: Re: [PATCH] macsec: skip PACKET_LOOPBACK frames in
 macsec_handle_frame()
Message-ID: <brhtacym66q4tn7ahzjkeeq53xfl3hez2jznyhkyvzsw33vqra@jo36wnmjnofh>
References: <20260209162851.11800-1-git@danielhodges.dev>
 <CANn89iJYk3T3sVf0osRy3_jvH6H_Xbgu6bdgqamJY-6pUoiHTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJYk3T3sVf0osRy3_jvH6H_Xbgu6bdgqamJY-6pUoiHTA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258015-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@danielhodges.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,0e665e4b99cb925286a0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,danielhodges.dev:email,danielhodges.dev:dkim]
X-Rspamd-Queue-Id: 7187111623D
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 06:35:46PM +0100, Eric Dumazet wrote:
> On Mon, Feb 9, 2026 at 5:29 PM Daniel Hodges <git@danielhodges.dev> wrote:
> >
> > macsec_handle_frame() assumes all incoming frames have a valid Ethernet
> > header at skb_mac_header(skb) and reads hdr->eth.h_proto to determine
> > whether to process the frame as MACsec.  However, loopback packets are
> > delivered with pkt_type PACKET_LOOPBACK and carry only a
> > protocol-specific header (e.g. 7-byte phonethdr), not a full Ethernet
> > header. Reading 14 bytes of ethhdr from such a short header results in a
> > slab-out-of-bounds / uninit-value access.
> >
> > Fix this by returning RX_HANDLER_PASS early for PACKET_LOOPBACK frames,
> > consistent with how macvlan_handle_frame() handles this case.
> 
> In the syzbot report, I do not see dev_loopback_xmit() being involved ?

I think it doesn't go through dev_loopback_xmit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/phonet/af_phonet.c#n182

> >
> > Reported-by: syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
> > Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >  drivers/net/macsec.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> > index 0206b84284ab..edcc51f82327 100644
> > --- a/drivers/net/macsec.c
> > +++ b/drivers/net/macsec.c
> > @@ -1103,6 +1103,13 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
> >         bool pulled_sci;
> >         int ret;
> >
> > +       /* Loopback packets (e.g. from phonet) don't have L2 headers, so
> > +        * attempting to interpret the mac header as Ethernet would read
> > +        * uninitialized memory.  Let them pass through unmodified.
> > +        */
> > +       if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
> > +               return RX_HANDLER_PASS;
> > +
> >         if (skb_headroom(skb) < ETH_HLEN)
> >                 goto drop_direct;
> >
> > --
> > 2.52.0
> 
> I think the issue is in this skb_headroom() check really, this is not
> really doing what we need.
> 
> Note that the existing check (if (hdr->eth.h_proto !=
> htons(ETH_P_MACSEC))) should kick properly
> if phonet was able to send a bigger packet.
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index c2cb2d20976b..ef4cdf25d425 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -1141,7 +1141,7 @@ static rx_handler_result_t
> macsec_handle_frame(struct sk_buff **pskb)
>         bool pulled_sci;
>         int ret;
> 
> -       if (skb_headroom(skb) < ETH_HLEN)
> +       if (!pskb_may_pull(skb, skb_mac_offset(skb) + ETH_HLEN))
>                 goto drop_direct;
> 
>         hdr = macsec_ethhdr(skb);

Yeah, that seems more likely or should the the loopback side use
dev_loopback_xmit?

