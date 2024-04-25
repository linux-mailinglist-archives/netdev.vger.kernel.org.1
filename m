Return-Path: <netdev+bounces-91254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9C8B1E89
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149901C228A0
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE685281;
	Thu, 25 Apr 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ9+4Wyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B984FD4
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038895; cv=none; b=Nu0VXPkGzS4eWP3CKwP0aJhluwAmf7dy66Ckf0bQ7QL6axCo50gpvrj/ChEXmkulZdWDenVRghcDFu+YwCLHKqSp+gQcrLhAqOIvlMGpysmyp2ekW03ypGi95hcxNU2tOTg964Mo1LCCbvbG5ZlIEh+Q41b279jajl0pPt6xprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038895; c=relaxed/simple;
	bh=hfbV/RZTarJj3gnQEpHtU3hSgVkyrIqXsZDPMv6z8CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dllxU1rS7xjcHb8r9fX0ndYNzwhjdCxClJF7TKZckITcWDqYtbBKfJejZ8cATPAX8cKBjDsjmT7spWn/JhaGD2EGX5HKPDEqBmgXvKw7JFFsiQdrFNu293WblvAAFKuFTzXbbSOm04cEEx6mV6t8rF3z6KMkeBY+nhZhgVckHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ9+4Wyl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so12915a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714038892; x=1714643692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zqv/konk0WiXBafX4h8lK5bdqLuFg953XCNlD3iE7U=;
        b=HZ9+4WylZcjlkxM5GD6OkLnN1wctJzCj+0l2NhJW+1w4CbZ3fALWqnfgMY/MTdhdrw
         0txX2mq1x5WYAhkYScIbUKDIjAXoxkRhmCojcIx+UsZIeX759jA82VJRVtk4YD4Jmgbn
         LCAZ68ysx6WMROTeQkuZpkCRZ7NjMIMwvDLz4iXYE2pYBQe5oX+V2Cr9GJ8T0SCYCBBT
         p2OBoNEC4xNBys/X76hWyckjRAv2rEfk+N9yZrBi+mOVcIPuLWWgI5Aww/g1+nlEqTL7
         ywv9eMbeEYmL5cykWcSOZYGaPYCy3fBlUKqCQ+ef4uADYelbpqrxVdGzirkwo7Vvm4N5
         iKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038892; x=1714643692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zqv/konk0WiXBafX4h8lK5bdqLuFg953XCNlD3iE7U=;
        b=RfSxoYvBYpot3XIzdNgUE07+90jgAM9R5iG/PRsjmkx4rviuq83dPdGB3fm3n/fi8A
         8JB9soqZ2TVUkhPV0BoV68PWLzeUUVisCmF2c7d88U+NvuvtqjbTXCgOtPuXbcZ3L1gM
         gMds4sHiWevfpigOhCXbp5RiVnBH1CytT0zEvUCUZCqtb0I4ul//QW4qSPljEv4zf2bG
         IFD08AisP5BEo62drCOGhk/OAnbg9We9Sx1snzNo0UKbgC6ZAoDwuzcNBIPl5xIRav3T
         Ec14VDz7kc/zcZWP8X3disOV83Y1IAQnntrTIwbKNdvJlDQItLriTdgI+qgM4PoW/YSa
         zOUw==
X-Forwarded-Encrypted: i=1; AJvYcCX17rjPz+t4vMM85wuUsroXpQtW+XHNDGIEA00PtF2PKx/6kzxfmnld3SuVcMtVS8n4duzxNToNUcMy5nVImg6BivFU/zdI
X-Gm-Message-State: AOJu0YyF1PQQSHYrLV1AlZYW6NHPjsz2oqesTBbNAv1nz/y3c+dB+cYv
	8XhJknP+/RjKi/NbVMDWmya/YtR/2+CLsR4k4yMZ+NkG7dZDzOeGohbUBI98PsHXHkY8jTq0tWZ
	IYpiRBdre0HVVkq9tQlkqMGHF5tt7SDlWtZva
X-Google-Smtp-Source: AGHT+IF1jUh8OEQl+WwRNPGSb8cJoC3wfyc9+wHbtxUxM55wwk2Dql1iVFlshN9cf2h9YRjlrgbHHSrRqqKgwo3pJrY=
X-Received: by 2002:a05:6402:40cb:b0:572:3b8c:b936 with SMTP id
 z11-20020a05640240cb00b005723b8cb936mr172669edb.2.1714038892171; Thu, 25 Apr
 2024 02:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com> <ZiokCzm41m21CxLR@calendula>
In-Reply-To: <ZiokCzm41m21CxLR@calendula>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 11:54:37 +0200
Message-ID: <CANn89iLxRgYSsFokDo327B4CwwwN9B1Q8e+OHvQenn0a5SfxDQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: mark racy access on ext->gen_id
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: linke li <lilinke99@qq.com>, xujianhao01@gmail.com, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:36=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter=
.org> wrote:
>
> On Tue, Apr 23, 2024 at 07:50:22PM +0800, linke li wrote:
> > In __nf_ct_ext_find(), ext->gen_id can be changed by
> > nf_ct_ext_valid_post(), using WRITE_ONCE. Mark data races on ext->gen_i=
d
> > as benign using READ_ONCE.
> >
> > This patch is aimed at reducing the number of benign races reported by
> > KCSAN in order to focus future debugging effort on harmful races.
>
> There are a more uses ext->gen_id in the code, my understanding this
> patch is just a stub.

Anyway, ext->gen_id was already read and stored in @this_id

I would probably avoid reading it a second time.

diff --git a/net/netfilter/nf_conntrack_extend.c
b/net/netfilter/nf_conntrack_extend.c
index dd62cc12e7750734fec9be8a90fd0defcbc815e0..747797b20bc7417a2b7270d84f6=
2d24991a4b982
100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -141,7 +141,7 @@ void *__nf_ct_ext_find(const struct nf_ct_ext *ext, u8 =
id)
        if (!__nf_ct_ext_exist(ext, id))
                return NULL;

-       if (this_id =3D=3D 0 || ext->gen_id =3D=3D gen_id)
+       if (this_id =3D=3D 0 || this_id =3D=3D gen_id)
                return (void *)ext + ext->offset[id];

        return NULL;

