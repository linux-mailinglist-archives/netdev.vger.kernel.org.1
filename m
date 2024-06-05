Return-Path: <netdev+bounces-101037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4468FD022
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6E029B22A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE0433C1;
	Wed,  5 Jun 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVa/2RmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EA17BBF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595404; cv=none; b=KYFnsJkwpNtzmYkS9+bQpCDQv4NYI3KkpPZfAbiZgMVuOOpoENRc+KrwnLWcvXeCqvadCuIj6C4tuKsh1IrWIP9Mlne9/ClqxtlmpjpW8O8402IkS8mYTRulnBA5JRbaDEthk6X66Fo5GB+gOgDm/mQUelb2nm8JXTjIno2Cayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595404; c=relaxed/simple;
	bh=i4ONNnMfhang+tbIMX15oCd0PwIGJ32RjTTYY6YCciw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKZ/3dZRt4D8pmSaR/lV9cj2aa+SaDlnxn3RGDEID75Tu0l+wsvEelpwJg7ZWVFl25aYjKP2DNJXHqZ/I2cfeSLjtVjarOzqUC+KigJNeRsxHSpkXLF3ZXYsKxkxxDc/DBfuKtAAxQp/7CEHnkD3ENDFHq2M7jrfvKVvYlva6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVa/2RmQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so14235a12.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717595401; x=1718200201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4ONNnMfhang+tbIMX15oCd0PwIGJ32RjTTYY6YCciw=;
        b=KVa/2RmQcxO/BPxwaOLFWxn84ryEpm5dF8CwMdHZicjAwH05e9FA3d4AfSovy52yre
         vD2mCWnrQiLT/TJZiiNjfD6vTqPGVzxHDx5rkFsfRe9DjdqW+Hse1hwWBMmFDSs1TOS7
         5SQFqscVe7TiO3iiwSQm8U3BWspPaYzaQQ61gBgR8LkouIslU3Bcu/fWuesCNGUkWQSm
         Qs4FcKgwsS6YBgt9BSwkD2gopXvLWyOCNkWDxkZqup/HIrfJE+a1RTzEDt6iOTzk9n32
         cpyZqu7XmmapqEVK9BpJeFpmpvs2wXGaFPYD05jlmqyOuvIEKNJ5xbZaiGoeNLn7qidu
         8s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717595401; x=1718200201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4ONNnMfhang+tbIMX15oCd0PwIGJ32RjTTYY6YCciw=;
        b=aq3u1hJMlRkJaMs4s1v+bNLqHkee5AMsLaa1B7+E9BA+VDiJzUKAR0h1N9qJeEdgyT
         8zG1CxKVgsgbk4gBS4W3e9vRlEXPgJowS+75js276CDDB6Tis2UrSlel9ECX/bZNBGLV
         UhYHbDgQ4j0lBKAOC29ly+iZVtn+7gOLy6aFWhBaDaV/S5KV2jFTiPmNAfv4Tr2ZJdcd
         zTQpjhk//Y98Nph9b9Isws/2GnGX/qHsn7ObPVZD3GMlnLH5CvQ11662Sqt72Z9Ui/7n
         pDvTUZsRp6Kc0MQs0E0cW7I5ppj3oUrhtSdLei+FQubd6QwCphAWzfQsZhmv80FK0sGw
         gv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuq1dleCCC8dV/iEqfB4wPkU2OqeQOf6PBJDdVGHWFrVM86I36HRzVhMnVltVknK9e8HggVnM4X9Lgxi49bFK+cXKG2Oe7
X-Gm-Message-State: AOJu0YyXBI4U8KxkjiO4FzqKtg6Onpa+tS+HAh7T9SBqQbHcbWLhy20p
	IborY+i+xIFq+ZeCHjCSuYmUYMwI/iPlN7jRCY5ihCS0HEqAFgoR1IR3JwD0WtqDimWcZUKYxTD
	UbL8JN57MWrJ7X5Grk86D/Pc7rw0HG/BiEVwg
X-Google-Smtp-Source: AGHT+IGFzI5vbUc2aUwVIByF3mO71xo+hsJAjyZAJgAAejyKO6eP2V1v13sYNzTxIrgiVM1ZLDO6j1c0m5pEXW1BDYo=
X-Received: by 2002:aa7:de10:0:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57a95009854mr140609a12.7.1717595401143; Wed, 05 Jun 2024
 06:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>
 <942dec85581305f7046de9021b69a8dffa29eaf0.camel@redhat.com> <ZmBqNPGtUA22yFQE@debian>
In-Reply-To: <ZmBqNPGtUA22yFQE@debian>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 15:49:47 +0200
Message-ID: <CANn89iKrqnzP9Zkq0r5S_+7i33edhs-B4WT7YLtv5f3brm_XYg@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_xmit_one().
To: Guillaume Nault <gnault@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:38=E2=80=AFPM Guillaume Nault <gnault@redhat.com> =
wrote:
>
> On Tue, Jun 04, 2024 at 12:55:53PM +0200, Paolo Abeni wrote:
> > On Wed, 2024-05-29 at 21:01 +0200, Guillaume Nault wrote:
> > > Ensure the inner IP header is part of the skb's linear data before
> > > setting old_iph. Otherwise, on a fragmented skb, old_iph could point
> > > outside of the packet data.

What is a "fragmented skb" ?

> > >
> > > Use skb_vlan_inet_prepare() on classical VXLAN devices to accommodate
> > > for potential VLANs. Use pskb_inet_may_pull() for VXLAN-GPE as there'=
s
> > > no Ethernet header in that case.
> >
> > AFAICS even vxlan-GPE allows an ethernet header, see tun_p_to_eth_p()
> > and:
> >
> > https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.html#name-=
multi-protocol-support
> >
> > What I'm missing?
>
> Didn't see that. I'll post a v2.
> Thanks.

Also please add a Fixes: tag

