Return-Path: <netdev+bounces-224586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633AB86630
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CAC3AD9A2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B12C326F;
	Thu, 18 Sep 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnZQlnCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DC2D1905
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218915; cv=none; b=AEfUliiKTUv9KvIuWI+/TK6sysye1WwEPihr5pON5aYJ5AdLAdOHIljqorGLXejrOQLms65AggcD+TFojq2kBT+n4cOwy825lEeoJZzn/O7h1tty18/4zwC1zeynMmGS3GaGm9mQmpDhMPnN+Tt7lD37bnR6QjDh5RyFJBsdETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218915; c=relaxed/simple;
	bh=twkRZh0sP74K05Hs6WFO+KHIolkAIDDxrFvsn8amyTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XglZgYz+ffdmCoovp2L7UAvctZ7O6KNHZ87t+xhZTgnaSA8dKyYtV9AALIyPzhcZm3Fs0aLswt++nbPEX9f9bwuT7yxFZ4c7xFj4OYg0JhFFM1DEqefFFNF4Pp6nBSS15IdtELy8p0Moyhj/FEtqSSBT2s1i0c2vrXeAvh8Wp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnZQlnCx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-25caef29325so11823305ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218912; x=1758823712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0hV38YhCVzhQIg4KB2NIuKoe18ib0LXcZozxaagVwE=;
        b=bnZQlnCxQkMLETfp5gIGZqcyTXkMhjnTs0VGUIaPyX7Pf+B6TdwHi6K+feobzaQaE6
         VJBs8IAzZ5pUHworEB3pLjxsBZKRt9gsR/+BWV0Mma/i/PYbzLzofVK3I2gYTNdHxUhE
         MC/B1x4eu/WddPlaYW/36qAFhA6vQQa/kJAlDPra79D51GP6sCZs2w/FIeZXyeEIVJlV
         HrzaQpKFl2T9riws8tzRLhXU6bVWblAbpNokACSXOyMEJRhXS+wGFqFFRwbqS8srSQ6H
         wQzd2QWsrXBRewwYTN8dQRppau4Pbi4SMblSLjFw7vU8cV7cVRoyPX5vouWI6q0MRjWc
         hsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218912; x=1758823712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0hV38YhCVzhQIg4KB2NIuKoe18ib0LXcZozxaagVwE=;
        b=wlZOcr+ciq871676SF6QBA8MevoWl75B6XdZhTV2ap/YfwNQf6uw7Hl84W18DVFMle
         3EWZ7bF7mLJbxoyg6P72icCwcROy5j1FCezFui1WEYdMU+FZE41LvZCUQlxFV+vISp2p
         E3S5KuqKVnPdVfZNZ9iNXUZm+EVUdgWPmtgkpJj+YM1p52beTDgM2O+gYgdFfGtEm4yf
         Rd+TuilAhnHB214s7DM8ZSLhK22taoZiF4eqDLqs9emRVQ32MebQJFOhRP3DAECULnjD
         dSLXNCcJiJGas/GlwUBsfv+4agdG+dohodej7d8QX12wUGLJ+d/1AQqZYMgDTG4w1fyY
         XSKg==
X-Forwarded-Encrypted: i=1; AJvYcCVy54dsdnuemHU20b1d5ccKZOrXGyfdxDGP5uIsALyLJYhw2hNyOEOoWGgq1W3ZvQHPl8FpxgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTo3+6hfI152b+6yJu6RPajDUWJWkU2Mgw2zMBM8Rj8rwBrKHC
	in/nSdisLRM1r9nkJ8iAF7+44JA10l8DLL8qTN1jyGsFkeXE99vhztfKl2Eb2HDaDMEQeitCzgk
	H8LmrHAagvPv347KIUSlsH4NjsMG1m+w=
X-Gm-Gg: ASbGncvaT7MbWu77lVHbqjfGZw+Xvn8APDpqS6lPbKfuMfPbPrZGCT9XCvzi2MliWCj
	aguOYPlK4hP526ZgTB7LunPSABt7712fCNUvRtFjL54llVkiAwcA1+uuTbFSz/MwZIycqefQ1V1
	POZSaH9yQNGXjRWxTMZ4EsJEXF8Ncd3OJsXYL2twDEWRI9PYpYME7qB3JPD4Ydt+zY9pmWwM0cX
	AHW39YmRFiGGBj6DR4ZQiTI1S2QJ328IZDe12x7F2zRrCd/WEqh4mS4nB87xa0X4hbc/0CUGvL9
	ff2+P5E/ytr8ZGalERY0ScCxVuD9k95nZREVLH9anhI=
X-Google-Smtp-Source: AGHT+IGxMvnzHxuxPQJ9tRzM5/1tY07DVRqxQVzJUPW+8yC2DsbwuRojuHZoEBkVMhb/Nbnfw1WEM0N41YdCeizJeUc=
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id
 d9443c01a7336-269ba447e48mr8152795ad.17.1758218912364; Thu, 18 Sep 2025
 11:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132007.325299-1-edumazet@google.com> <CAJwJo6Z5+W2hDMOwPTnRWqLoGLqfwezZd_mOCmbMEnbvK-VBDg@mail.gmail.com>
 <CANn89i+nAPNQ9pWjk6K7z+kH4dnP3YcmjvW_StT=0CdHoPR-+g@mail.gmail.com>
In-Reply-To: <CANn89i+nAPNQ9pWjk6K7z+kH4dnP3YcmjvW_StT=0CdHoPR-+g@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 18 Sep 2025 19:08:21 +0100
X-Gm-Features: AS18NWDdRYXccn0hmfx7rgLKbslIxvWFQ92j2RUZVMIoamjr-CEQzNA9I3bJfnQ
Message-ID: <CAJwJo6abp+GfM4taWhfNfDT3_VCovfGG2v8p9P_sk3ATn2KcBQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Daniel Zahka <daniel.zahka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 19:02, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Sep 18, 2025 at 10:56=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail=
.com> wrote:
> >
> > On Thu, 18 Sept 2025 at 14:20, Eric Dumazet <edumazet@google.com> wrote=
:
> > >
> > > Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Daniel Zahka <daniel.zahka@gmail.com>
> > > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > LGTM, thanks!
> >
> > Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Side-note: I see that tcp_ao_transmit_skb() can currently fail only
> > due to ENOMEM, IIRC I haven't found more specific reason at that time
> > than just SKB_DROP_REASON_NOT_SPECIFIED, unsure if worth changing
> > that.
>
> We could then use SKB_DROP_REASON_NOMEM.

Yeah, I think I wasn't sure if it's worth just due to one place. But
if it's generally useful, I'd say we could :-)

Thanks,
             Dmitry

