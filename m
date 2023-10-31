Return-Path: <netdev+bounces-45454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC9B7DD167
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C145EB20E1C
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB653200D8;
	Tue, 31 Oct 2023 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DzhsUYEg";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="81sgtNlB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F920300
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 16:20:15 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 09:20:13 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD875E8
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698768848; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mvw1KADqqyDW2oR6nnLoId/S6IoovfewRC9fw+4r+dv6DLivQ1TA0RUm9DwVoeDAac
    yWIvsPD9UOWiU+JalO9wh744K5th4h+sJwMBcgyVq6hNaqfFGXEklmj29dBxZDbpCmSB
    nTY9Y/ERBGX1Zh19vFmnGkO5zjuLqqXZsHyhmqxodbI+/Rxumwt/JZaAPPQAheErUasn
    mW+OCqv2tiD2fLO8canzfbnFeOkGo21QLCx78TK2iH3CsKdqcDWbnIDAOibMKHPixMbT
    DM9E00wb1u2uONZgzU3MFI2fFWaC3WW3zi3T/3gqaNfriYwzTxGMHbP4JkqHjJuwXnan
    w6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698768848;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m3wr98qtOShw+UHdDmrt1fsiZ8CPD3VyYm78seIY5Z8=;
    b=BIi/OdugA/FhjliuJcjQHAjET/3HfIxyyPWY0Q1DCo+OTBdm1prP0rwv+psbizZiNw
    uxGtPNVnJgE0EVLZbw2W9DYcEZTNEupBY/YQavFRAPi1QdJeldd0ZcJjNTDQHu8JUa0Z
    48Hb7lg7K3eBGbA2XB8QCiP71P+42JOiR4AaPw/y/rXtCLIuYWEx7/vgNpH7cPzSY5T+
    koDMAraKO9pKbA0mnKVh1UMwzkugSMzfAZqU/oYHwDEkXQpVWL9fvgV6P1CM5zyg/9dT
    2lJBrRZfEVHH+IJHF96Zz9quB9vXgwPBU5jeGQxdWrBmWvz0ewRbW3hijaRDaMngsClK
    Ks7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698768848;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m3wr98qtOShw+UHdDmrt1fsiZ8CPD3VyYm78seIY5Z8=;
    b=DzhsUYEglGIhp34x1IBP9JVooiicclk61yQgdMa2272SHE+tXpcXM8gUPxLh8Nxt4/
    a+kZGE3/Whoh9/pR5o/YHtXp0PxjYm857rK3DsBwKKndNEepTnmr8YB5Ru4RhlWx6QZE
    0kmOAKQTQsrIK9tRDY4KsC6dCLP9vN1di7cJLoiALAjyCzN5yFYtO379jYs7iF6pjUmz
    I/w2MfOFaN8MtdGweCuFbX9vs070igGgjah7MCRD28STF8FHEXpj7ReR8AUDubXirv1W
    uy8BeZ20IaFRDnih8kiups7dg8JRyzSvno7SDfiRWeGvqO9J+/EqcAPv1K3En3caPbnN
    bVdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698768848;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m3wr98qtOShw+UHdDmrt1fsiZ8CPD3VyYm78seIY5Z8=;
    b=81sgtNlBoUu1CH1pT11dC2fGIImRAgRIov2v7koI0P6R7Nxzs24InVxS9HE4tdQWwK
    c3kxVvIWOEK5ldngiPCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOM9vpw=="
Received: from [192.168.60.115]
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9VGE8H21
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 31 Oct 2023 17:14:08 +0100 (CET)
Message-ID: <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
Date: Tue, 31 Oct 2023 17:14:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20231031112349.y0aLoBrz@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,

thanks for the review!

On 31.10.23 12:23, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I stumbled over this piece in cgw_create_job():
> |      /* update modifications with disabled softirq & quit */
> |      local_bh_disable();
> |      memcpy(&gwj->mod, &mod, sizeof(mod));
> |      local_bh_enable();
> |      return 0;
> 
> unfortunately the comment did not provide much enlightenment for me.
> Let's look. That memcpy() overwrites struct cf_mod within struct cgw_job
> which is under RCU protection. memcpy() and RCU hardly works as a combo.
> But why the local_bh_disable()?

The content of gwj->mod can be overwritten with new modification rules 
at runtime. But this update (with memcpy) has to take place when there 
is no incoming network traffic.

> Let's look further. The user of this data structure is can_can_gw_rcv().
> There is something like:
> |                 /* check for checksum updates */
> |                 if (gwj->mod.csumfunc.crc8)
> |                         (*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
> 
> With optimisation enabled (as in -O2 or so) the compiler will fetch
> mod.csumfunc.crc8, do the comparison and if non-NULL use the previously
> fetched value and jump there. So one could argue that it is not really
> affected by the memcpy() suddenly setting it to NULL. However, adding
> any kind of a function in between, say
> |                 /* check for checksum updates */
> |                 if (gwj->mod.csumfunc.crc8) {
> |+                        trace_event_crc8_sth(cf)
> |                         (*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
> |                 }
> 
> will force the compiler to reload mod.csumfunc.crc8. And here is the
> possible NULL pointer if overwritten by update in cgw_create_job().
> 
> One reload that already happens is the one of mod.modfunc. First at the
> top we have:
> |         if (gwj->mod.modfunc[0])
> |                 nskb = skb_copy(skb, GFP_ATOMIC);
> |         else
> |                 nskb = skb_clone(skb, GFP_ATOMIC);
> 
> Here mod.modfunc[0] is NULL and skb_clone() is invoked. Later if
> mod.modfunc has been set to non-NULL value this piece
> |         while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
> |                 (*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
> 
> reloads mod.modfunc and may modify the skb assuming that skb_copy() has
> been used earlier.
> 
> Looking at this makes me think that the local_bh_disable() has been
> added to the memcpy() just to ensure that can_can_gw_rcv() won't run
> because it is invoked in a BH disabled context. Clever little trick that
> is. But this trick is limited to UP environments…
> 
> Am I missing something?
> 
> If not, my suggestion would be replacing the bh-off, memcpy part with:
> |		old_mod = rcu_replace_pointer(gwj->mod, new_mod, true);
> |		kfree_rcu_mightsleep(old_mod);
> 
> and doing the needed pointer replacement with for struct cgw_job::mod
> and RCU annotation.

Replacing a pointer does not copy any data to the cf_mod structure, right?

Best regards,
Oliver

