Return-Path: <netdev+bounces-229543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51425BDDE01
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06F804E9D80
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F731985C;
	Wed, 15 Oct 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="R1r9qTW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OakFG2EL"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4152308F2E;
	Wed, 15 Oct 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521992; cv=none; b=qTLv8XWBQTN2SMiARpKeSuIrmgYjzJq3QCCoSzf0lvi9HPQ8xVRbaP72m0Mx8KsWS98ZgVbZwDpAiMF8ynKFp1BmbVJdLBaTXjYtt1H42jzgZzd7r6vFt0QicGY2bwfsdgdTqcdIXyxzeJBYLKuUV0pIPNJihRv8OPXzadJIp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521992; c=relaxed/simple;
	bh=iziB5jyiF6mHDkiY6ZCk+Wow33XGRZNsyWDK/NaIZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUJylbaEVQeHZxtPLKJvaLb6VApUUayJ/gUDw+rOKEbdFQ5hI1ljdtSyF9tdszqX283hCTqYGjBV57qCf90DLItmL/pE7OTVS5YU2U7zhDiBOvzTTTUwa9mrfFV6EHbQuycrQqdItfGQz5ODfmNjr6lQmJYmzOnCcO9uque3eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=R1r9qTW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OakFG2EL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C8894EC0110;
	Wed, 15 Oct 2025 05:53:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 05:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760521987; x=
	1760608387; bh=ZRcJTFRWGK7NOr5KnRDlG6z7tyzDX/Z+zt3DwkntsFA=; b=R
	1r9qTW4ibBV4NbFPgVBitEjstKh6c7MHolCH0qVsCyEqZmp+3ae/R0glqvb4gQSz
	G5VM5Y1Vw4Bsp4dJhRs6lzBkKIGuKj1QGzyCEt99q3Q/8WV6U0NG4nngyEsRx2I0
	+TAQCJS8TcRXTNtWj4Z2vAaO83ZO6b0p2EUc6L+SUMqDRCOYVsgGPCcjJnFCh4bT
	LhUldd58ZeOKVFBqr6MgzOCbDUse0V02o9eTgmkfB++2fCzHQD7X/wk7Jm1BtDU5
	0b9D2GfzXM6b8EIifPZywoHrhq6DQSNxvJsG2tlqErzAtdtVFNsRaY2foJXN+xX1
	cmxLhpV80vYGRS2XDQ1aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760521987; x=1760608387; bh=ZRcJTFRWGK7NOr5KnRDlG6z7tyzDX/Z+zt3
	DwkntsFA=; b=OakFG2EL23EDKU0Aiuh6rFoSz3h7uE+h2JUUo92X/j4lsaGOQrw
	t1OM7Vj1zEFaFnlaRLE0qxNknyzURm8HF/InI/dnuDG4FX40gVK3Yx7qJF0PPwZW
	nn09l/7Alqtb3j9Mubi17QEzDmhGMon/+3i2z3CpP6d7ujZD6U1Bl7RbaXD9ROEv
	frOhZGxOmEgByROBxJ45Wut9DmeExgHQczH1vqNcHRSjegiZrc3EQ7Kqjz8ZEZJk
	VZ/2m1Gs66qebDRYznALwsykaLFxxqzQjDI6SwYR6XDP6BJbbyFVQib/Du16lLCp
	tW3M/KzRp8f4kbdbedE6rLExKtQ5m7GE8Jw==
X-ME-Sender: <xms:Am_vaCTqocvZRgtz9fiW0XvRu5Ol0lveXTGovW8sH0d0bgxF_kIQeg>
    <xme:Am_vaJVGK3BDWr0CRcvFCJv_DnLsy62l3WwmbcpLasms6YTOYhnAGTzDtAjcKUtpL
    0sMr4jGl3zjo9DcvLEjHljP8XfA2ukxcgxP6BEveSqS06qGGA6vTtw>
X-ME-Received: <xmr:Am_vaPGBvTG2QKbZkR1V9-YRyAdM0eeGkPXI0LBfc0CFo0k0lj4Swe0FiYvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujges
    thdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqh
    huvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveekhffgtddvveej
    vedvgffffeeftedtfefhtdfgueetgeevuefftdffhfduhedvnecuffhomhgrihhnpehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqh
    huvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunh
    gvthdrtghomhdprhgtphhtthhopehshiiisghothdohegtugeivdellegvuggvgegugehf
    jedtleekjegssehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughu
    mhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonh
    guohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehhohhrmhhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Am_vaEermWOTEaHSXCemuj5res_AHg5uzYJwEjrE7n9uUwZQpDDTng>
    <xmx:Am_vaArFXLnncdG7io31n2ZDW_U0SrSFOozS-EfP3hamUc56Z3mVog>
    <xmx:Am_vaNBfKenHPKIPyoe_zUqnwPg8xC3Vz2j5xzuBh-ZmkjT9FBAGvQ>
    <xmx:Am_vaBfNYqPwIW0_K9Oswa4FjG6n_QFXfbreCspptYWNbGCUqGTXCg>
    <xmx:A2_vaJ9L5nzLrXNwURqQBoq1i6TdFkK4dBA6HYXSxjtbDkaX4O_hJnlr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 05:53:05 -0400 (EDT)
Date: Wed, 15 Oct 2025 11:53:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_migrate (2)
Message-ID: <aO9vAIsmgNx4j1Sf@krikkit>
References: <68e2ad62.a00a0220.2ba410.0018.GAE@google.com>
 <aO5PnU4dhUuzM34e@krikkit>
 <aO9QkNNkZ1JLnnIl@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aO9QkNNkZ1JLnnIl@secunet.com>

2025-10-15, 09:43:12 +0200, Steffen Klassert wrote:
> On Tue, Oct 14, 2025 at 03:26:53PM +0200, Sabrina Dubroca wrote:
> > 2025-10-05, 10:39:46 -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    4b946f6bb7d6 selftests/bpf: Fix realloc size in bpf_get_ad..
> > > git tree:       bpf
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13be46e2580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
> > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f0ef71bdead6/disk-4b946f6b.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/0c8251d5df12/vmlinux-4b946f6b.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/29bad3cdad16/bzImage-4b946f6b.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 __xfrm_state_destroy net/xfrm/xfrm_state.c:800 [inline]
> > > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_put include/net/xfrm.h:928 [inline]
> > > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_migrate+0x13bc/0x1b10 net/xfrm/xfrm_state.c:2165
> > 
> > Steffen, this looks like we simply forgot to set XFRM_STATE_DEAD
> > before the final put() in the error path of xfrm_state_migrate (and
> > xfrm_state_clone_and_setup):
> > 
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 9ea1d45b79e3..7ae10fac7b31 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -2074,6 +2074,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
> >  	return x;
> >  
> >   error:
> > +	x->km.state = XFRM_STATE_DEAD;
> >  	xfrm_state_put(x);
> >  out:
> >  	return NULL;
> > @@ -2163,6 +2164,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
> >  
> >  	return xc;
> >  error:
> > +	xc->km.state = XFRM_STATE_DEAD;
> >  	xfrm_state_put(xc);
> >  	return NULL;
> >  }
> > 
> > 
> > Does that look reasonable? The state was never add()/insert()'ed, so
> > it goes through put()/destroy() without delete() first that would set
> > XFRM_STATE_DEAD.
> 
> Right. Looks like this is broken since the migrate API exists.
> 
> > It also looks like we're missing a xfrm_dev_state_delete if
> > xfrm_state_migrate -> xfrm_state_add fails, since
> > xfrm_dev_state_delete gets called during __xfrm_state_delete, and this
> > new state will only see xfrm_state_put/__xfrm_state_destroy:
> > 
> > @@ -2159,10 +2159,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
> >  		xfrm_state_insert(xc);
> >  	} else {
> >  		if (xfrm_state_add(xc) < 0)
> > -			goto error;
> > +			goto error_add;
> >  	}
> >  
> >  	return xc;
> > +error_add:
> > +	if (xuo)
> > +		xfrm_dev_state_delete(xc);
> 
> This is correct as well. Thanks for catching these!

Thanks for confirming. I'll post the patches (with a few other fixes I
have) today or tomorrow.

-- 
Sabrina

