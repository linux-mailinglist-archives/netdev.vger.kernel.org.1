Return-Path: <netdev+bounces-258939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB35IMRdk2kr4AEAu9opvQ
	(envelope-from <netdev+bounces-258939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:11:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C091146E18
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367C63003724
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD72857C7;
	Mon, 16 Feb 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlMi4+W0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED122D4D3
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265470; cv=none; b=XBWaPUCONI6JkotsyM45sXuBfamffg0/ay63hsw6LAiV8LenmSvf7d5cUiOG/jia9m49I0TWc1eS2um/zaJ8AqfYxHbluEb7YlxsvLC9CCf3LIW4Mq+4apWwdcxBSvFk4A5ppD3ZTG/I+2CYksZBHlXavTQevx+tgUYGK2kOYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265470; c=relaxed/simple;
	bh=YvpKE+f9MXWcsTM3Nco/1s7RFnOf+UexpP3V25U1vpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtEscrFtGi3p9Zs+H+HbbolWHkvttJenb48zrpOtwtWBi0Zg427sCjTr2Od7VCTMou33S4MsaYDrTvsuQm739qst2jCzsnW89h03EnxgVudsiNHiv24jeItAMCAQpzqbobbcL4cJit0WAGwmqOYDlNK9rrnTCD/MOKCWp1KV2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlMi4+W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F46C116C6;
	Mon, 16 Feb 2026 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771265470;
	bh=YvpKE+f9MXWcsTM3Nco/1s7RFnOf+UexpP3V25U1vpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZlMi4+W0JZUhthXpIVjYFHVEwZrmlqq9AfbPsMrXYP7d9ZYIOUAEo/xd1k19l93eZ
	 yPKhW0WFyiT5gOHdiqxy60cr4tXcBmeoClcm+4SpTXcZR+ll+4e5d99Q63+cLTZuqu
	 PvKa/yNwhLR//LWV0JnzO609JonJUIs8hdJyJayD7wiWk1YfvQjd5f5KuwelgNQuVJ
	 Vt6RK12ogc8SmW1kzuloMC8Xto/8qEByQc2HXi4mv6ZEG53FJ30uuPUDFwpNu53G59
	 7ejS9YoyQMS7W8lw+aMqJhrUA9CIeQ6S+qvoZ8g70DOLWiQS1W02iRVxXPqMDvkWUM
	 ckkspk1ImpajA==
Date: Mon, 16 Feb 2026 10:11:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260216101108.6b2319b2@kernel.org>
In-Reply-To: <CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
	<20260129150459.29419003@kernel.org>
	<CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
	<20260216094936.5bf9d789@kernel.org>
	<CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C091146E18
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 18:58:08 +0100 Eric Dumazet wrote:
> > > I think I totally missed your email :/
> > >
> > > What about not attempting defer for zero copy skbs ?
> > >
> > > It turns out existing patch e20dfbad8aab ("net: fix napi_consume_skb()
> > > with alien skbs") is already a problem for zcopy.  
> >
> > We definitely need either this or the timer patch I attached, for UDP.
> >
> > I put the TCP write side on a back burner because slab sheaves got
> > merged, I think skb defer free will still make a difference but IDK
> > how much. Maybe juice will no longer be worth the squeeze?  
> 
> It depends how many frags are attached to each skb.
> 
> page frags are not yet handled by SLUB sheaves :)

Ack, my recollection is that more of the cycles are spent in slab than
pcp handling, tho. I could be misremembering. But my thinking was that
if we both:
 - lose zc sends due to the unbounded completion time
 - lose the slab benefit due to sheaves
we are only left with fairly narrow case of page handling of small skbs.
My gut feeling was that however unclean the timer fix would be best
since it gives us zc back. But I don't have a way to experiment with
sheaves yet to get data. All of this is pure speculation.

Regardless the patch you shared earlier is probably best as a fix for
zero-copy UDP for now.

