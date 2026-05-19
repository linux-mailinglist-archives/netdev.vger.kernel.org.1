Return-Path: <netdev+bounces-289459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCidNRpiDGpXggUAu9opvQ
	(envelope-from <netdev+bounces-289459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27F57F616
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9860303C42D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39E3EF675;
	Tue, 19 May 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="INxQ4EN7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eASMPlwt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AC34041A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196332; cv=none; b=R/lFGzNtWicThLPowzdpcKmMHNfhNpVKvYZmc1nsQcIzkPI8L+tnSxhgChsx739c9W7pJVKmkAS68KRAfhhQVzf1juytnqGnFR0S/OdbXvsBV3wORMXRPuGoV+zL3sclJH41XozXg8eaohtDcComn0YVpldu9vB3PtsdtLnFBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196332; c=relaxed/simple;
	bh=wIALats8330P4GY254CIgPMnQvywdc1NoEvfnpJIuBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djzbD9EauyMRSAHRFVmH/0SsbrMIX7RT9nLKd0VQiZg+yWEKA+nLemewto9GvhiwN9FmvPVzLrlAa0iD6KtXJFCo8taVHIdxK58zDlhnlh3XJCGWwHDNPMO5P4JoAwqex3F1SN99O1xzyJ5CdqQmlHoHiMWFDW9cWT3rjjbZGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=INxQ4EN7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eASMPlwt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EE7AEC0092;
	Tue, 19 May 2026 09:12:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 May 2026 09:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1779196329; x=1779282729; bh=C8UJjN9YIM4dF2un1h9N5JgiFsD8ZA8f
	TKRS/ARFXxg=; b=INxQ4EN7m81c6gPrhcpB6idlpBG7cHagf+wSRqU3bDWkbURY
	IjVPQCOYExulZV/hu2iAp7jzN+rKNMI6JXJcb7aWOHLFvWqVaawW34TowJytz3dU
	un6wA4ZaeaSI0Qlt9SMBvKCdrgFBnDuwzmrCJIKBoxEYd6Yted9iP+iU6Ie71JVg
	WkCQ7EoyzioC6JmC4tBvXtdXQrAX3AErowWI6dxHFgbloNUQasGmxe8rP24PyO9Y
	xDmbQGa3UZk75L2eO+XIMK6wO05gRrehNJ5myl1tu2/FRslzUVMMAuIU0dUfGpVE
	k03mDxISj5a3UcVD4s09PFbeJHC7tuwYGdDf9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779196329; x=
	1779282729; bh=C8UJjN9YIM4dF2un1h9N5JgiFsD8ZA8fTKRS/ARFXxg=; b=e
	ASMPlwtVYqD1Bo4cAxpkgWqkRWx1h+KetkpLKiv63C+37SS9v3pyK/Sa6N1H/uls
	SbwlZ4+OldI62w9pJo9a34cdrkFRZlz+3/U00ijdqRkaYFLEvbTn7TwxCq5FWzdL
	bgRqk2RfBYpHiaVN2bO6umfx4h8PdgE2O8vzWJ9SKRLaY/4aZKYsOcWevrUz+3Ip
	4dddwHILBq/dMkGTW/mBboToMO1kKE5dzM+79gVNa4O9XFS6RcFe6LD4vC4fz03l
	0oaYA8DtcjCzAfXszCzo/Gnw/AkpewgvmauyEXIwGlcp9+JYab/dnZqqrFSfw+zo
	QlcXeICZUnEtJxvGWqpxg==
X-ME-Sender: <xms:qGEMasiXOypnAIoZQR8E-A8T2MLFtixq4MTayVJ_Xz_POyffNcCP5A>
    <xme:qGEMankw0RSfz5V5crIXinF6kdYv1tm0GoF_BKFdld8vcthX-1zBcweoomg9Vlcp2
    VKrNCWBLx5RSEMyAStVXZUZb7EUqT5hRweYbsf3-kxMeBfU8crKW1g>
X-ME-Received: <xmr:qGEMansuSPNE8i45uNvnED8x8_tIfo8uBM2EuNH0Qe_0xkaCctjD3kfWVd_aEiNtM2gwUvH6LQrLUWkdDeLA_4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuhiirg
    hifhgrshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrshhmlhdrshhilhgvnhgtvgesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:qGEMatYBbwAytSisAgp2abJWc8eFI7Ujx6v7Fw_4Lcq8IPWxdifvDw>
    <xmx:qGEMavA7srHCutKKKRTzOi55mof4aPj5y63k0vq45xgKRPAuiGyTtg>
    <xmx:qGEMal_bnj3ByBWaHNoIO_uSz7alj0aCYZUWbrahO_R-9zvqITOkow>
    <xmx:qGEMarS9VVxvzsN4Omqu3I7NtpelKy6AkvBPutPTZBO0Wb8J-js9DQ>
    <xmx:qWEMamLk582IMjCjruyAuKGQrNuCwxc6ALJFxQ29_DaXvVkkiFms7LBd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 09:12:08 -0400 (EDT)
Date: Tue, 19 May 2026 15:12:06 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
Message-ID: <agxhpnI84II_Utjk@krikkit>
References: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
 <CANn89i+w93DBm_yo5DZ6K_dgV4Gst=vb5OnTcXi2rKqeNHZSbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+w93DBm_yo5DZ6K_dgV4Gst=vb5OnTcXi2rKqeNHZSbQ@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,redhat.com,davemloft.net,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 3E27F57F616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-19, 05:57:22 -0700, Eric Dumazet wrote:
> On Tue, May 19, 2026 at 5:40 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > skb_gro_receive() can currently copy frags between the source and GRO
> > skb, without checking the zerocopy status, and in particular the
> > SKBFL_MANAGED_FRAG_REFS flag.
> >
> > When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> > on the pages in shinfo->frags. Appending those frags to another skb's
> > frags without fixing up the page refcount can lead to UAF.
> >
> > When either the last skb in the GRO chain (the one we would append
> > frags to) or the source skb is zerocopy, skip the frags copy, and just
> > append the new skb to the frag_list.
> >
> > This is probably a bit less efficient than calling
> > skb_zcopy_downgrade_managed(), but then we'd also have to handle the
> > rest of the zerocopy flags/machinery. This can be improved in
> > net-next.
> >
> > Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> > Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> > Assisted-by: Claude:claude-mythos-preview
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  net/core/gro.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > Huzaifa has found this to be exploitable to overwrite the page cache
> >
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 31d21de5b15a..cae0a0dbfa69 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -123,6 +123,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
> >         lp = NAPI_GRO_CB(p)->last;
> >         pinfo = skb_shinfo(lp);
> >
> > +       if (skb_zcopy(skb) || skb_zcopy(lp))
> > +               goto merge;
> > +
> >         if (headlen <= offset) {
> >                 skb_frag_t *frag;
> >                 skb_frag_t *frag2;
> 
> Do we really want to merge these skbs in the first place?
> 
> What about play safe?

Seems reasonable to me. I'll wait another 23.5 hours to submit v2.
(and I'll let you pick some commit tags if you want)

-- 
Sabrina

