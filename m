Return-Path: <netdev+bounces-280268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NCjCqj452kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E9440222
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FB6430223BE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D337106E;
	Tue, 21 Apr 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUJVyOE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D432D0C64
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810017; cv=none; b=hHrwcyjg5RXDdiqF75L2Tek1eGH75VYzlh38zkanFaVnZZ7CHGAy5W8CP78HSEv9wxT7SfD+Kkq2Xdx3+YFGDtrwch9UON9MrmcmUlD1b0j7qb+w6dUKi6tf/sR7aBXBJwg40PXTpJI2nYrwyyT0vN/9b+eBZaxrKrN3WCNaqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810017; c=relaxed/simple;
	bh=a4w8+2wcKmtmeXRFt+uVdMabsR9DGM0MEHNTh4eYR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4+Kd8SjL3m8iDM4yHOHuFxm0VAAWnMHY314+2r9T7LLZhYt2QPVlofed4E2E3Yc1YQXnWLRPIo6bamIHnGqkC2Xn6GYpqqAmpUKpFm5voVXIsvUg9XKygQCsuqXPNGaFI+KvyOa5HAEWI/5uIsA5Y8qKgb2pj17Rvh2o/NuUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUJVyOE5; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40ea36b56b7so3661478fac.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810014; x=1777414814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5k2a1ZwjWaXhRtVuXvTgvfheVXV0JH9Yw/NlxIWNNYI=;
        b=jUJVyOE5/NDo4UEHOphFCPt64D0hCUuS2V3jRA63xOqKhN2skt6NniISREZXhDbRSH
         W7AkyIFJdJz0d9uL3lxb1SFUpv+WSXhGwPraxHMzuPyD/q7Fc0Gxi/R6z7au7cCk9cvv
         0imS1A007VOMNO/op4SarSvxUKtA4t46AYofw1FmCkjC2ObpoxC1r04LMOEREfSQKmMi
         Ap4HYkpmcDnU11hlGxeLqAL1zClLwlUWN+yLo8sKROyQI/BIsaTPXW6ajwtsRUUb4nRE
         6wY0eVznPvAuw7tnlKjo+vdCNJ7pjCbJrpz5BZuuWE7PrKpGplheezNMXuGubgDnuuRz
         Uglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810014; x=1777414814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k2a1ZwjWaXhRtVuXvTgvfheVXV0JH9Yw/NlxIWNNYI=;
        b=SYjd/mf1jM5WtdHgAOLXK1vzg74oEU3u4zn5ot3TGPXO2qjJ4nz/baUBVaKDLwY/RH
         puQU4vF+A/WAIlZFNTGCIA9pKN7LTUMD7hesviSagjRRDFlPyGETm1IjZJvb/akTEmeo
         60f0wxIRrZ9Em/c8NX3Yvm6I6djHTyf/nADo0UTtANJYO2JWQmHnx+AU8GBEaGASwvbr
         4DhQ9bpLWX6i8qGeDMvNvMNYJ4ZIKrjS75LO8tvQgtsNOQm9ck82jPaYUPCgMXcYlrgq
         WvVd8t1vA1eOz53x2512X4fxV/Wcu20oVSQ1r9XyyPsV+MJ+onK5pAhAgLOXcrTPApsi
         GOOA==
X-Forwarded-Encrypted: i=1; AFNElJ/QMk5GQQnuXARXOAQ3pVoVbm8i0JM5bGB55qAuXX7/0Tu9p2EgnP2jlgS9OSgC+pbYGOJKIWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9zpBMYiGzExi0p/AO3tEo1lp0Ni5+q1rVvqIUTw4iTd+LLV3
	rBxaubvtnJ71+sleIpk8cQKzGWNH1mj6iknZyNvtGkeAQb05P+J+6TUKfUgZAPMu
X-Gm-Gg: AeBDiesjzNN5rAQUQkrkW4IzKiZJKzPsdZJw2lEVvp8M1rd2nyIkbw2/cUPACuG51j0
	DSOgXA+orinXd7fjSHRamS/hras254SHviQoQZ4iYhFlhYTrWQdo5Z3zPeg+Zh13fUcAABj9/jj
	dKPnXv1WgFlK01K2dGofu3GmhmwJk6vBNFQbknNHVuqsqCdxqY9XenOTmNg89jkQI+EMsh2j5BL
	SVbySB9iP/WGOyh2SUxjowajM+ZFdXCR5rVWa1KXGaKfl60d7lXkVLAeaIRJ9VklK6UWlMj+b+q
	BTVjhZ7FEo8iNag1hZ02j7YYg3KNzj6tf29rqLFyeig2sEQsAsWIrbK+HRkcyw0Yv98yhK7BEt1
	43gUuW8evoY2FgZRKbKnaVd/P3Hbh1QZdBAzPDUuk9gv7kU6nRSX6EQkwo5A1xnD6P49ybWDkma
	knHhdzpZyEMtyN14pf1x2gtJqXuokk
X-Received: by 2002:a05:6870:c6a0:b0:423:1c3a:33d2 with SMTP id 586e51a60fabf-42aded6ed1cmr12505398fac.26.1776810013852;
        Tue, 21 Apr 2026 15:20:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9acc056esm13255853fac.17.2026.04.21.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:20:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:20:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Message-ID: <aef4DpNOD3otivdp@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-2-kerneljasonxing@gmail.com>
 <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
 <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280268-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,tencent.com:email]
X-Rspamd-Queue-Id: 240E9440222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21, Jason Xing wrote:
> On Tue, Apr 21, 2026 at 3:34 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > skb_checksum_help() is a common helper that writes the folded
> > > 16-bit checksum back via skb->data + csum_start + csum_offset,
> > > i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> > > and -EINVAL) when skb_headlen() is 0.
> > >
> > > AF_XDP generic xmit takes two very different paths depending on the
> > > netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> > > skip the "copy payload into a linear head" step on purpose as a
> > > performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> > > pages as frags and never calls skb_put(), so skb_headlen() stays 0
> > > for the whole skb. For these skbs there is simply no linear area for
> > > skb_checksum_help() to write the csum into - the sw-csum fallback is
> > > structurally inapplicable.
> > >
> > > The patch tries to catch this and reject the combination with error at
> > > setup time. Rejecting at bind() converts this silent per-packet failure
> > > into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> > > launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> > > because they do not call skb_checksum_help().
> > >
> > > Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> > > XDP_TXMD_FLAGS_CHECKSUM' produces:
> > > 1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
> > > 2) sendmsg() returning -EINVAL without consuming the descriptor
> > >    (invalid_descs is not incremented),
> > > 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
> > >     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
> > >     the same descriptor and re-hits the same WARN until the socket
> > >     is closed.
> > >
> > > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk_buff_pool.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 37b7a68b89b3..c2521b6547e3 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >       if (force_zc && force_copy)
> > >               return -EINVAL;
> > >
> > > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> > > +             return -EOPNOTSUPP;
> > > +
> > >       if (xsk_get_pool_from_qid(netdev, queue_id))
> > >               return -EBUSY;
> > >
> > > --
> > > 2.41.3
> > >
> >
> > Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add option
> > to calculate TX checksum in SW")?
> >
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for the check. But not really. It is the commit 30c3055f9c0d
> that brings the csum support of IFF_TX_SKB_NO_LINEAR case where this
> issue can be triggered (because this mode no longer puts data into skb
> linear area).

Ah, right, good point, it's the IFF_TX_SKB_NO_LINEAR path.

