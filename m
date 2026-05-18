Return-Path: <netdev+bounces-289099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M7yIuMqC2oNEQUAu9opvQ
	(envelope-from <netdev+bounces-289099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:06:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51BA56F8F7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EFB307608A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176A29C33F;
	Mon, 18 May 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLCFccEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4592BEFE8
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116073; cv=none; b=RS3tdCbFjwXUnd8mlpJmDky2iQrscOPR41r8p1U5yylLFknj3krh3HoYyorDz3ELWnTlgf+C+k6xSGr0Bkuc2/ap8o8IH1J71Jy+KANtPNlxE8EcMLlrGYkHsftca9ppyLcey6RQyun6FbPkINotjJukFroDAlFHdk/ViNubJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116073; c=relaxed/simple;
	bh=0hNpcKFFPUeeY8mvNc8d+Furck1M+6yn4y5f78ZljG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9BSIa36hfa+dwrxATCjFzxMsGe+RK69RY3V1Ud1msphZqMrnjvjBOsdpOf4/sHIT22YYOk4D3f/V3z57ihh0WH41CbDWvsw1JEQcPadEvGFMBtpx4yqxQ1sdNfwuE2o5PGbaCbVKEr7pj6O8AJvrzPn+/UJqb2L7u2L1vanqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLCFccEt; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so2321521d50.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779116071; x=1779720871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c0dfQ7Wr8JZMajT0PBZM7edBivQd6TDRFDvTIsxG1qg=;
        b=mLCFccEtbfVYAyhGY6YYh7xqeUg1akP7dse6zMWJCu2L7YFFjJAqXYbmv7yDVbjdZ6
         1ARZDVF9kLxQoVcJD9BzNvv38S7ZDRg4J03b439PGLoN77J56D2DG9GDjpQXPw9m7xb8
         baKkW4Bzkrq4qniWEBH/IuA+INSXvCP8XzXWJOR8F8jkEdlCiEYzAI6DWxBrbRoqCDLC
         +cZS+VDQ05dqREcWckwmrnvuWZ0NcUSoSgVnOAbGmZyLodIAebNS6N6DgU4LnFkD9ppI
         uKYPi8ooDCmmtkHe/A9w+AIw1Y+9QPY0fOnKP7WW4xc7QfgaOSBkr2Dymd/cZZBDw8Yh
         DxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116071; x=1779720871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0dfQ7Wr8JZMajT0PBZM7edBivQd6TDRFDvTIsxG1qg=;
        b=F3ZCaYRV0YypfCQ9TQjyLCaJ7uThraykzgs61dDkwOx0JK6C2rzYqt+DgHgUC9Ja4A
         9N7Pgr7qUIug0xuFmHguWTzvxVnbW/AljbUwIQQqTNhNSGzm7QQ+9WBDc+ta0Hq6f4Js
         0rOeLHpl3zMwM4NfAUOf5eoMc9dOL8RIfY+nWa/LA5ADTCID7NZA5OLkKwFKq5mvsuUB
         By2VgKarbseE2BkNnQIJPVjO+5Fg8sEouoXntOLCxrF527AxZVJB6BWmWxTLCNk/4beQ
         96sGrDc+9wk/BJNCBcck53PjRT80zvRZWWnoEZQuTGmxDnVbmcAXPhSAHGn8jZ7J6mpd
         +Izw==
X-Forwarded-Encrypted: i=1; AFNElJ8U4MqhKQl35ompWPaYJhi+EnvtfoFRx9JFJ1gp/V8ywwsyfpW2ouGym/sgn0ERr9mXKjsqSuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS6i5X6lI0yGz7J/Iz0uIyFgGt2KjH9YaiM8+RAghP8bZz/qY
	6zPUAhvpf8U9qeuhK/fFeP/Z3ngJKodI+h60joLextB3sNPXZ+4dFpjUPD3e0beq
X-Gm-Gg: Acq92OEHdlWzZVr6w9N8cOxZw7MBKNxYAwKI6NIuPVvG2WbIFCwu0c6URtSmWNo1LG8
	bGf+DetrMdPrkuTpOjzWDE6F6AdZ8kWNIFt3IYtwnkBddvNjL0LA9nLkvW/O/sIADS8JYQ0pAO8
	0F5dfyGTZbL2sLJ9u8B9krb/GlIuaqi4Ty8XV5phoE/NSDjJYqHcASUIM6TEXEVJ6VQHsfdiss+
	c+H1Q3pevfI7HPsKD0tokv7Zloa86rut1PgD14Hu3Y8kAPQtkx/GyN1CI6z9XwcpeNscwjRlMF3
	rBeGorsvfefqMmdJvglzLicCottdOusoVC003bHhLPgWj3KqyCjgSj5nwVZ8pSigjX3XyvekNF9
	HdyahoiJa20wCmXq9u1JKPNrB20yE9ENjpskIFHVTN+OfWmjkZBqeh4PmGu6Llt5Yqvsvl3yZsx
	DrSidVQvxD+XY6gzD9
X-Received: by 2002:a05:690e:c4c:b0:65e:3df3:1c30 with SMTP id 956f58d0204a3-65e3df3218fmr8960255d50.7.1779116070571;
        Mon, 18 May 2026 07:54:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm6466044d50.12.2026.05.18.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:54:30 -0700 (PDT)
Date: Mon, 18 May 2026 07:54:29 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agsnigh3BgocPhlV@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
 <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
 <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
 <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAPDdbubsEg8kx+1bsEymqVokdk7LUB+kOacXaGVZK4Hw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289099-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: E51BA56F8F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/16, Jason Xing wrote:
> On Fri, May 15, 2026 at 11:41 PM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/15, Jason Xing wrote:
> > > On Fri, May 15, 2026 at 8:29 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/14, Jason Xing wrote:
> > > > > On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> > > > > <sdf.kernel@gmail.com> wrote:
> > > > > >
> > > > > > On 05/10, Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > > > > > only the current descriptor is released from the TX ring. The remaining
> > > > > > > continuation descriptors of the same packet stay in the ring. Since
> > > > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > > > leftover frags and misinterprets each one as the beginning of a new
> > > > > > > packet, corrupting the packet stream.
> > > > > > >
> > > > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > > > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > > > > backpressure), its address is submitted to the completion queue, and
> > > > > > > the descriptor is released from the TX ring. When the last fragment
> > > > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > > > > budget for normal packets.
> > > > > > >
> > > > > > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > > > > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > > > > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > > > > > >
> > > > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  include/net/xdp_sock.h |  1 +
> > > > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > > > >  2 files changed, 23 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > > index 23e8861e8b25..1958d19d9925 100644
> > > > > > > --- a/include/net/xdp_sock.h
> > > > > > > +++ b/include/net/xdp_sock.h
> > > > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > > > >        * call of __xsk_generic_xmit().
> > > > > > >        */
> > > > > > >       struct sk_buff *skb;
> > > > > > > +     bool drain_cont;
> > > > > > >
> > > > > > >       struct list_head map_list;
> > > > > > >       /* Protects map_list */
> > > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > > > --- a/net/xdp/xsk.c
> > > > > > > +++ b/net/xdp/xsk.c
> > > > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > > > >                       xs->tx->invalid_descs++;
> > > > > > >               }
> > > > > > >               xskq_cons_release(xs->tx);
> > > > > > > +             if (xp_mb_desc(desc))
> > > > > > > +                     xs->drain_cont = true;
> > > > > > >       } else {
> > > > > > >               /* Let application retry */
> > > > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > > > > >                       goto out;
> > > > > > >               }
> > > > > > >
> > > > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > > > +                     unsigned long flags;
> > > > > > > +                     u32 idx;
> > > > > > > +
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > > > > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> > > > > >
> > > > > > Not sure I understand why you want this if you're still marking the desc
> > > > > > invalid.
> > > > >
> > > > > The key point is that as long as we read the desc from txq, the desc
> > > > > should be either put back to txq again or publish it in the cq (for
> > > > > application to keep track of this) at this point. Or else, the
> > > > > application will lose track of this desc, which breaks the whole
> > > > > logic.
> > > >
> > > > Yes, makes sense!
> > > >
> > > > > > > +
> > > > > > > +                     xs->tx->invalid_descs++;
> > > > > > > +                     xskq_cons_release(xs->tx);
> > > > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > > > +                             xs->drain_cont = false;
> > > > > > > +                             err = -EOVERFLOW;
> > > > > > > +                             goto out;
> > > > > > > +                     }
> > > > > >
> > > > > > I also don't understand why you want to return -EOVERFLOW again? Why not
> > > > > > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > > > > > on?
> > > > >
> > > > > This particular desc is really one of overflow cases, right? We should
> > > > > warn users to handle this with this error code.
> > > >
> > > > Right, but didn't we already return -EOVERFLOW to the user once?
> > > > The part where you set drain_count=true will -EOVERFLOW. Then this
> > > > remainder will also return -EOVERFLOW?
> > >
> > > Right, my intention is to alert users twice under this kind of
> > > circumstance. We silently drain the remaining portion of the skb the
> > > second time, which looks a bit strange, doesn't it?
> > >
> > > >
> > > > But let's maybe step back, what's the expectation on the user
> > > > when we return -EOVERFLOW? In theory, the user can re-submit new
> > > > shorter packet (at the current prod index), right? And then your
> > > > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> > >
> > > People would be aware of the skb that is too big to handle when
> > > receiving two times of overflow warning. To put it in a simpler way,
> > > the second time in xmit path only handling the remaining is enough, no
> > > more descs that belong to another skb should be taken care of.
> > >
> > > If the user is able to quickly react to this case, I think the whole
> > > skb should be re-put into the txq again instead of adding the
> > > remaining part. I'm not so sure if I interpret the "break" correctly
> > > here.
> >
> > Let's say the user puts a packet with too many descriptors. We find that
> > mid-way and return -EOVERFLOW. What is user supposed to do with that error?
> > In my mind, the user should drain TX ring completely and start posting
> > shorter packets. You seem to be trying to handle the case where the user
> > leaves the remainder of the previously EOVERFLOW'd packet in place, why?
> 
> Good point. I think now I understand what your opinion is here:
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3b604776f09f..72d05a1fb0b5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -996,11 +996,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> 
>                         xs->tx->invalid_descs++;
>                         xskq_cons_release(xs->tx);
> -                       if (!xp_mb_desc(&desc)) {
> +                       if (!xp_mb_desc(&desc))
>                                 xs->drain_cont = false;
> -                               err = -EOVERFLOW;
> -                               goto out;
> -                       }
>                         continue;
>                 }
> 
> Then as long as we have enough budget, we silently handle the whole
> big skb and then continue with the rest of the skbs in txq. Users will
> be alerted by the counter of invalid_descs. I think that is what
> you're asking, right?

Yes, this resolves one part. But the larger question still stands:
why do this tracking at all? Why can't we clarify in the documentation
that the user is responsible for flushing tx queue completely after
EOVERFLOW? What am I missing?

