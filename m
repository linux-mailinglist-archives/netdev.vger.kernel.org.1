Return-Path: <netdev+bounces-287335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OvqJkCsA2oO8wEAu9opvQ
	(envelope-from <netdev+bounces-287335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:40:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B952AF6B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FE523115EEA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6273A380E;
	Tue, 12 May 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dstRc5MI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410F39F172
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625288; cv=none; b=qTYaHnKxhKwYqcZNJUXEUU6EbBlOIceECdNhjCeixHaLci+TkFooGQuuwrnSVnNshxlScE0E+Zfayx96pmxR6yvRtTammL17b+2qysCF4KGda2E+Ezpqvh2i06MBWBEDHkCTbtyCbt06lTi5YM98XTurtnggpVcDGnVd99ZTn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625288; c=relaxed/simple;
	bh=WyGA54gcSfEwPmBZ1yT22s2i71gVY9h4KQNOJn9VllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOtR3QH7m0TyYfZRoY1HxvOhbdtmBl6yt1XJbCdJgmAGN5aTXBtiKBqtV3fyKCp1PyfQQ4rkJer0vmblH6OYaHUPiV/0BTE9M9XXr/yAmRZitXq9lkr81IfPDMzM6YmqQZg5rOxMn/fhGy4AP+uBmNtiMF8Fwbt3nftW/Qc7p4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dstRc5MI; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c801912c903so2811375a12.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625286; x=1779230086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BO3odHd40A1icJZvGy9LfmlOcg6Cjiu8d7ytO7Oe88c=;
        b=dstRc5MIHPeqEOxtmlAy5cv8RGA6tElsCDjM7mo+o9GHtBgHbGlFwWzu24V52HwjEC
         SQnuqnptEG8XGLwEp40vE4N4L2n7zza2xRNBAPXv48LlwfSLUuQ4f6dkbDs2BJIspfCp
         Xc5OfUI7RxQlzCvcDGsglvQX3nfYtI3d1tKe+Um8S+o0Nrjlkijwn4qh8vJAyWa83SuE
         UtSsTFAeE5F9vjkD2SdAxLT5CdraU0LWzifTXQc+2t+G+kZrd2tYL7v3h9/JFLDHZX0l
         mbfVAq6JSrjw2NSuW1kBelbCGf0NxeAlisIy2fHOIardpVLxi9GKAo4mXzQvyS99Iog8
         1AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625286; x=1779230086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO3odHd40A1icJZvGy9LfmlOcg6Cjiu8d7ytO7Oe88c=;
        b=fWN6O/SorprnKLIg58LctRi/V/0CvrEIOPwDTF6oTs5SJPnUWULXU+Qd9BkcMz0MwX
         6Vn1BnY7HpDorYbANLzRdTFwdJ8DWqz/heqYPeJH6ChyAgXBC1iEEP+n4YrJj/tmjlnm
         xhQS3oTNg2zE99FyCzdNX7/PX6qidB6y2n9TXbDVAnlEx+0/zH3woj7l6SGTelE+6ngG
         6bRiECScZminOWyA2J+AKyBtU24bhZXyyytILjkwd7hVPN9B2rRSeoVBDyo5lJN8HIW7
         7b9y49f4H23iTba2dTylGN8oYP5dLWdqvYqcizl4/3vttKqekWO1tR9hY1CHdifqMoLZ
         c+8g==
X-Forwarded-Encrypted: i=1; AFNElJ/1OzY3s6KjZ+g5CAxq5n8ZdO8zMm05iR5wyzdHCMzVfKplg0GYWP2k4WIxIZZRjPRSvRAJwrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPrdJpk8Xv9TMP1yAL0e8Iefbum8zxutAxXA0/6i6O7hKI3PV
	BW2RyMUbNZ0XjoswKLXCNeYEydZkARfdyne06HdgXDFGTY7E2iXsoo08
X-Gm-Gg: Acq92OHH/rJPDrjk+ByI0d0AtYl5WfYLiWCJVFyobFZSxLmubEYDjRrtEXt6plkdWXl
	4xATFknh1NDhKjq+mfUN0F/pc3N3MB5cbFKFaPSX1O3ofpoCLrb9yrUgyPJkErS+lxp3STkTled
	ZxXpZO0vcGyLnE3B2op1rZwMqSdqeLdwD/VI5JqtLUumgsOdVcIWY6DDIaJoXugO/KdZ/TDfDuh
	ZRO1nPuv7jDrgUQQLM+SXQ9orUgc1evx9hqlEW3UXgs1iXtzD23agyrUs9UraByBBi8Ajg1shwu
	OcPaf1o3yKAjXvEWds5uze8kaZhBgugTM4/7YKjpgaMsU0HAVkR5vufib49T1tX4QAwHJRSiAJW
	G9PFMf54Bp5vvdUnQ86QVPu5M8n1VZOnrFfLK+CJc3RHdlwaRt3D0JB+I++LISq4eagaqAFU3mb
	k2i8jcFFK1R+txC49T
X-Received: by 2002:a05:6a20:9184:b0:398:aea8:a9c0 with SMTP id adf61e73a8af0-3af7f875fa2mr578019637.19.1778625285821;
        Tue, 12 May 2026 15:34:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f049sm28583190b3a.7.2026.05.12.15.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:34:45 -0700 (PDT)
Date: Tue, 12 May 2026 15:34:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
 <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
X-Rspamd-Queue-Id: 203B952AF6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/12, Jason Xing wrote:
> On Mon, May 11, 2026 at 11:03 PM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/10, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > csum_start and csum_offset are read from shared memory for bounds
> > > validation, then read again for skb assignment. A malicious userspace
> > > application can race to overwrite these values between the two reads,
> > > bypassing the bounds check and causing out-of-bounds memory access
> > > during checksum computation in the transmit path.
> > >
> > > Fix this by reading csum_start and csum_offset into local variables
> > > once, then using the local copies for both validation and assignment.
> > >
> > > Note that other metadata fields (flags, launch_time) and the cached
> > > csum fields may be mutually inconsistent due to concurrent userspace
> > > writes, but this is benign: the only security-critical invariant is
> > > that each field's validated value is the same one used, which local
> > > caching guarantees.
> > >
> > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 6bcd77068e52..cd039e397018 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > >                           u32 hr)
> > >  {
> > >       struct xsk_tx_metadata *meta = NULL;
> > > +     u16 csum_start, csum_offset;
> > >
> > >       if (unlikely(pool->tx_metadata_len == 0))
> > >               return -EINVAL;
> > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > >               return -EINVAL;
> > >
> > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > -             if (unlikely(meta->request.csum_start +
> > > -                          meta->request.csum_offset +
> > > +             csum_start = meta->request.csum_start;
> > > +             csum_offset = meta->request.csum_offset;
> >
> > Wondering if it's better to READ_ONCE(x) these?
> 
> I still chose not to use it after reading the suggestion from local
> AI. The reason is there is no WRITE_ONCE pair to make sure everything
> is no data-race. I also checked some existing implementations around
> the shared buffer (between userspace and kernel) and didn't manage to
> see the usage of XXXX_ONCE(). Does it make any sense to you :) ?

Without READ_ONCE your patch relies on the compiler honoring exactly the
loads and stores as written. Which I don't think it does (hence that
whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
the same code (and read csum_start twice) even with your patch applied. Happy
to argue with your local AI if you give me the output :-D

I grepped io_uring/ and I see similar pattern for reading user supplied
entries (via READ_ONCE).

