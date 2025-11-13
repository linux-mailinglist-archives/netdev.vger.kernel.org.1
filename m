Return-Path: <netdev+bounces-238507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E1C5A21B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141BE4EC897
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405813246EC;
	Thu, 13 Nov 2025 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFuWuqUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75F3246F9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069220; cv=none; b=EnRPpd8JPfaamax+VqsQOxZDbzc6lj4p6z9HfY4Y/duqi18kQRhpA4Tgg2W5m0oA+bz1ofZdHL2QNVmZMmATRlLzql/35b2Nkd+2VTv0GYVJ2iye/iF4099aCJdQ7L2mf8rlxCfnlEzO2q0MX2FbWexijVb88qj3U0euA/i/NOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069220; c=relaxed/simple;
	bh=C563LsVa6/8e3VjqblDi8r6nB8mnn0chwKQh+7Cmjsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/mwUKy3azcAiLxP4RRB8tL26FmpB9zWvrn69shJAKvkjtCDo+8T0gtS5dzb46VutfJgeDtkPT0HU1IrX6SzXY/XWikHjJsLujGOStB+QSaVWcv+UuueHjSmCYEecVvCAIXWCc+PXFCRYPjlBiy6X1xjuFaK4kpquxPqFp1lmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFuWuqUX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29812589890so16199975ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069218; x=1763674018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvLS0Li6ncU43W6RO/80uOScztDNeTiGNxSyThA+RiM=;
        b=BFuWuqUXt3377e/PkAs84KRQt8wYLbBYhCBhJf2SaQPrBazoxI3tm19dvrV7u+KAGO
         a+wh+fwqmq8g8qV691u54La0nXEm5lOI6t2t2ptj3uOxqVVYw0IXfIaFXhHDI7TgRwN+
         ce184KVIc48vFoasurHvh67gf2jF/XdcqevhDGYnfDumOMMYM7QWfLPPE6U62pLFqoTf
         uXork8mLQ8U06Tskh1qtfetBXSoSyue0w44FNd8ocPXWPRUTLENvjyAJilOrnjU/++4l
         mQqbNtaRluNkcIERJ2xi7yG6LYRgkZAdtWSZUuOMQLpKCjId1bVwnHrXOWlqPREhEt46
         VEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069218; x=1763674018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvLS0Li6ncU43W6RO/80uOScztDNeTiGNxSyThA+RiM=;
        b=Pdq1K8xkWBtsiLWXDyuWvbx0ks5dMLRJ6KOibmZxcPzdNE5PWBKfMmzrWQMIFpb+8k
         HhiEZrtrf+LK+hwScuxIiC3tq6GBLIr8y4L/hyRvoNakrpDT00oWL8WwqirxpBhdimMt
         GUiJLzNSWXma7vPU9RbVWo+33sbPjdz+WtrLqDmjzizaLJN7nnR+csQAfzAgE3JD87mj
         +aAXGEkVSRsvZjGR9CKqfbRSLya4jjQ7R2mDZvJIatbe4JFTd6IELjJTwA7ITkJL6Goa
         dwW3BU/KJlTrUfHy/tKDzcpDwJskb39j/rWTP6CbrrpEFDwWqfI28qk/NSqanj3d6fu2
         t2OQ==
X-Gm-Message-State: AOJu0YxKUzLidAL7WK0FiK3hAWVRCkatpWi5QC8HRqTE/Rq10KrmU2A3
	tsKNrkEX2nDs8+bMxX6e9Pf6/u6VSA09Xn6YIzZX1jud3+tRTVV9mWcdcHUQZH/DketqtRozDS1
	7LCx/sZTPcwAfO+PpKv4ieGIYqsFehq8=
X-Gm-Gg: ASbGncvulrWiyMm6SbtrRXdgw2Vd0Usz2Oflufpo7/IoBcE2vk39nbDYh80quHNjBDK
	1AvUC5eke6P/vE93czFhsg4HW1lWv0McEhnKiWmgQxDMptm/0yosgLjTmFLiglN3xmtbENgNnoa
	DxuYChQCgndggF5M//NVRXG2PhsTCTI747N9hClil7emoKSbzEskZXK7h2rAXivi5iGl+oRheyI
	kPUFG/GlZWeCOE9R6hYNbDUNtmB4d1WMOg3OPY+AsHU1L5V3dAQWYngYwc0
X-Google-Smtp-Source: AGHT+IEKm9CXDc+kQUPCeykRAkQ1s2Mjxo36u4sHWF3ypb14wEXU8u3tNG0XYM1pygnHZYipY1MFv/VWv8KCRbHyAwY=
X-Received: by 2002:a17:902:f550:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2986a6bf949mr4415475ad.19.1763069218001; Thu, 13 Nov 2025
 13:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <56e8d1efe9c7d5db33b0c425bc4c1276a251923d.1761748557.git.lucien.xin@gmail.com>
 <989d3df8-52cf-41db-bb4c-44950a34ce89@redhat.com> <CADvbK_eGPuueR7XL80eagkrAeJraKBMiTVrhiFb_wnTD+N7qVw@mail.gmail.com>
In-Reply-To: <CADvbK_eGPuueR7XL80eagkrAeJraKBMiTVrhiFb_wnTD+N7qVw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 13 Nov 2025 16:26:46 -0500
X-Gm-Features: AWmQ_bkpD1XOS0u_fsUfGq1AJ3_cHnv3PQH7YYYwXkikJNe2ApTEEtQau8hdGQk
Message-ID: <CADvbK_eEHLbMQ3+OTWdg6_4a_bKFOkO-ZL0y661Vovo9uEFB1g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 14/15] quic: add frame encoder and decoder base
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:22=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Nov 4, 2025 at 7:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 10/29/25 3:35 PM, Xin Long wrote:
> > > +static void quic_frame_free(struct quic_frame *frame)
> > > +{
> > > +     struct quic_frame_frag *frag, *next;
> > > +
> > > +     if (!frame->type && frame->skb) { /* RX path frame with skb. */
> >
> > Are RX path frame with !skb expected/possible? such frames will be
> > 'misinterpreted' as TX ones, specifically will do `kfree(frame->data)`
> > which in turn could be a bad thing.
> >
> Yes, when generating and delivering an event to userspace, it
> keeps the frame content into frame->data, instead of frame->skb.
>
> There's no need check !frame->type for RX path,  and I will change it to:
>
>         if (frame->skb) { /* For stream/crypto/dgram frames on RX. */
>                 kfree_skb(frame->skb);
>                 goto out;
>         }
>
> if skb is set, it will go kfree_skb(frame->skb), instead of kfree(frame->=
data).
> Because if frame->skb is set, it only needs to do kfree_skb(frame->skb).
>
Just realized that frame->skb shares a union with frame->flist, which is
used only on TX. So instead of removing the check !frame->type, I will
put a comment here:

        /* Handle RX stream/crypto/dgram frames. Use !frame->type to detect=
 RX,
         * since frame->skb shares a union with frame->flist, used only on =
TX.
         */
        if (!frame->type && frame->skb) {

Thanks.

