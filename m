Return-Path: <netdev+bounces-236475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8478C3CD11
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BA2661D66
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813934EEE5;
	Thu,  6 Nov 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qj9FSAf3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyk5qLZf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919034DCD7;
	Thu,  6 Nov 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449451; cv=none; b=o2CaWk832ideUgCysX8FEpDtfbDM4afccNuQina7k4ESKGEei9OhDzFacS3i2ltiy0drire//78C+N0KYIQfMYBDFYwGmDoAwFlPHKtamCkNDklYWxulZrwiGVj3zaTYQwtv6OsywN2DLEwN2pWuh9f5QTrGZXZnR4WeuMXh/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449451; c=relaxed/simple;
	bh=WYEDEGjne8eaWsfWa3xh/Jt/BKN+KQCVMJvsmRYg1Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLUdzlYo8w32ZhcGSdrQ7xKBN/trEzoMWWJ2Aak+uxU+Z8Wn8pAl1FN1Fr+B4rQoOokfdka/sSiDT30aB6vCyFm3tqeiLDRXBgq29jlLAefYuLNye2Cfh/wwdcXZxXgSvphf2/y1o2OaM4olo5xnrhWLiGl+sI7fAoZNJuZKlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qj9FSAf3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyk5qLZf; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EEA7EC021B;
	Thu,  6 Nov 2025 12:17:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 06 Nov 2025 12:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762449448; x=
	1762535848; bh=hcyh73KxGvxdueRyyktekXhmIJOjbNzwiZamSSUNi1E=; b=q
	j9FSAf33HxhkBka3yKeVuKidAQB4y/KjYctbCQkQoR2/xVH30e4+ul6QuYU/7a4x
	AfEnsSo8CeIzqC6+sIQdqWEK0dVnYLnelbnoJWQX1+w4prYyd5WoXEP6QEP0lsqp
	johTlmaZjLcmgYY+rw3n3cMth+ER84voHQCvT4GxIjM0Fi7jmr4DhMLVWfjbMNn9
	NMGrrzf5DTISBNlkT1pylM/NjbmnxP5Q/vRMiNxfDzMdyH98sjveKMsCx/QuIvWJ
	AjFlQ59KJGtIVdkA6KLDIkbKMgG8QdG4bSzxUQ+uMzvjK/Ww1Gm6bcUrRH33qd3/
	LvVaYBI16PdVwGvxE5aLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762449448; x=1762535848; bh=hcyh73KxGvxdueRyyktekXhmIJOjbNzwiZa
	mSSUNi1E=; b=iyk5qLZf5y6GLtqFkUUrV8dARKTOO4qaVbNbYo2J03rZuA04ADm
	ewNf7SxgQCnAzA3d/q5XpTdG+WRLisSRozX/fBCXk7Gb/5dm5Vswovxm4ubWz6Rj
	O8sQO1nk6Hhl5D0kDPltJ3ePmZMePQUyvS9iUks+uEzwG5ZIkk/yAjSF+gBgHe6r
	p3KaligVz0PVn430vlt3aPB205+ovNGHireuofbuDI7h4jH9n0SOYGIgDwWXrUWI
	PbCoDW8q01PUtsb4CQ3geJgEAkXUvQjmdTCYHW+o/suqEfKEA1fSdABqxbCnL2Vm
	vmgfk1dxzqGZu1QSiZqBVBFC3TyUwEeg9zQ==
X-ME-Sender: <xms:J9gMabVb5KcuH3a5WjYHRk19_x-RgOW59rLhpaaWEKn9rLzU0O6XMA>
    <xme:J9gMaUAdJlu0uSeFZWU7m5n6GqkmZm5FLj6chDAb1-Cplk0Ks2fOTtkUgEsEB8X3n
    zSNrZ8E8kRnZMw4_PWCuw5IoqzsyGtpetb4DznFb1B2npWVBeEdslk>
X-ME-Received: <xmr:J9gMaXJkZeW57X0IfKqGdJpYuT-kvBfsa0M6r-kYNtTo8TeX4fXmhOeEcItb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeefledtueeivdelvefhvddtle
    euveeugedtteekvedtteeljeeugedvffeklefgvdenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgpdhshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptghlfhejtddtfeekfeesghhmrghilhdrtghomhdprhgtphhtthhopehhohhr
    mhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhm
X-ME-Proxy: <xmx:J9gMaSsAFJDXerDKT4Zmgyq0Xt05D13g00BgXb1jgt35r8-eny6glw>
    <xmx:J9gMafW--dxRd_jnXjpimYNitMrLr5Yf5GPqHnFt5KbXRnxDQ-8v3g>
    <xmx:J9gMadLLdasKnR3S4F0tbuB7y-2cuS6F9VHZirrqSr-2Xl_EWqTbpQ>
    <xmx:J9gMaU_8L-xmwDz1Wq90QJfHyT3a3a87SRKQY0CnbNacVFEnX_Leog>
    <xmx:KNgMaS3irnaQyzs176GJdiQHShJD1Asxh8mS6_OTgyEagU9Ggc-2kVsh>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 12:17:26 -0500 (EST)
Date: Thu, 6 Nov 2025 18:17:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: clingfei <clf700383@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 3/3] net: key: Validate address family in
 set_ipsecrequest()
Message-ID: <aQzYJX1pDMksNLO9@krikkit>
References: <20251106135658.866481-1-1599101385@qq.com>
 <20251106135658.866481-4-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106135658.866481-4-1599101385@qq.com>

note: There are a few issues with the format of this patch, and the
subject prefix should be "[PATCH ipsec n/3]" for all the patches in
the series. But I'm also not sure if this is the right way to fix this
syzbot report.


2025-11-06, 21:56:58 +0800, clingfei wrote:
> From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>


From here:

> Hi syzbot,
> 
> Please test the following patch.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> 
> Thanks,
> Shaurya Rane
> 
> From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Date: Sun, 19 Oct 2025 23:18:30 +0530
> Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

to here should be removed.


> syzbot reported a kernel BUG in set_ipsecrequest() due to an
> skb_over_panic when processing XFRM_MSG_MIGRATE messages.
> 
> The root cause is that set_ipsecrequest() does not validate the
> address family parameter before using it to calculate buffer sizes.
> When an unsupported family value (such as 0) is passed,
> pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.
> 
> In pfkey_send_migrate(), the buffer size is calculated based on
> pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
> family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
> (16 bytes) is allocated per entry. However, set_ipsecrequest() is
> called multiple times in a loop (once for old_family, once for
> new_family, for each migration bundle), repeatedly calling skb_put_zero()
> with 16 bytes each time.

So the root of the problem is a mismatch between allocation size and
the actual size needed. Unexpected families are not good, sure, but
would not cause a panic if the sizes were handled correctly.

OTOH, for this old code which is being deprecated, maybe it doesn't
matter to fix it "properly". (but see below)


> This causes the tail pointer to exceed the end pointer of the skb,
> triggering skb_over_panic:
>   tail: 0x188 (392 bytes)
>   end:  0x180 (384 bytes)
> 
> Fix this by validating that pfkey_sockaddr_len() returns a non-zero
> value before proceeding with buffer operations. This ensures proper
> size calculations and prevents buffer overflow. Checking socklen
> instead of just family==0 provides comprehensive validation for all
> unsupported address families.
> 
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
> endpoint address(es)")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  net/key/af_key.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index cfda15a5aa4d..93c20a31e03d 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3529,7 +3529,11 @@ static int set_ipsecrequest(struct sk_buff *skb,
>  	if (!family)
>  		return -EINVAL;
>  
> -	size_req = sizeof(struct sadb_x_ipsecrequest) +
> +    /* Reject invalid/unsupported address families */

Steffen, AFAICT the whole migrate code has no family
validation. Shouldn't we check {old,new}_family to be one of
{AF_INET,AF_INET6} in xfrm_migrate_check? This should take care of the
problems that this series tries to address, and avoid having objects
installed in the kernel with unexpected families (which would match
what validate_tmpl does).


Looking quickly at xfrm_migrate_state_find, it also seems to compare
addresses without checking that both addresses are of the same
family. That seems a bit wrong, but changing the behavior of that old
code is maybe too risky.



> +    if (!socklen)
> +        return -EINVAL;
> +
> +    size_req = sizeof(struct sadb_x_ipsecrequest) +

nit: tabs should be used, not spaces

>  		   pfkey_sockaddr_pair_size(family);
>  
>  	rq = skb_put_zero(skb, size_req);

-- 
Sabrina

