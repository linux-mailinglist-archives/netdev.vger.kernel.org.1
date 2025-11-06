Return-Path: <netdev+bounces-236467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A0C3C925
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CC1188CA87
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DF319608;
	Thu,  6 Nov 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxdy5pNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C22D46A9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447762; cv=none; b=pFpiqY+FHS8KwqATBkPVNfkmTXM6pUmWc0whC3croayzIhlLO3I9Zfm/pDmDdFPUj7StCaX9gFIj6tO7mAwSquKLQ3O9i1ws9jU/EXPXOUOerygsJCFITy9cE/Uq0Xk7atNZXW/VIAHczMJTOwb3vDi3HidM0XGNQa4+iDXKJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447762; c=relaxed/simple;
	bh=gPC9VPLFYbjfVxBSFkmUOkcw3DGZnlisHf1J732GkLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwvPTa/PxSz0q9FippqPQOvLL2onFd/pDBWy1YKPo+UDOOqBHdikz3nDD8+gXoIdQXqJZaHdEpjxXKCnE40RkmhA8uY8o5x/kLtAe2VYelQI2XAB/tsLKrtlAA+YDjrPc0QrsMBzeyR2+WWHC4qBfJ68Srnfm7vvedyx7GC+CnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxdy5pNV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso990488b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447760; x=1763052560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qzn6+Sh35pzxbK3z/xOK777J6LI54V1OZ2Oy1H+1YU=;
        b=Pxdy5pNVYWILmUSusu47+TjwZlsqGFBaR0IidrJzRoMtGDpXyUs+YIxMsMoiseL/bJ
         hiL6CS6636iL8aIq4ZILae2grig0IdTbCkNWBmQ/bqlfbNjaicKYBmiedN+i+rc4hPcb
         w6Sy5+OviusZWIDVGhnskDCyioxinh7itjziVJYHNLFEXqc3NUzcuOhYj++5QlMuPEJN
         FOr43I1zwz8Ps6cEEh8H78mZy4JIcIpOwl/2mTrj3Rca/x8a274j9RWd8MZWkuBIOlY+
         vGmqRf59G0gwFIpTSAeoWoiar/UXs5PZOvf3rz+duCw75SKGFoIn+wZuxA5CveXSnjl+
         Y8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447760; x=1763052560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qzn6+Sh35pzxbK3z/xOK777J6LI54V1OZ2Oy1H+1YU=;
        b=C0no/+EjauC7JZx240yhAc2xe/Pah1mwn79TaJVWVq17xoF4VmxC6skIXRSfsKhuKB
         /KoRhBCSrTfS0dqZbtyZQft0aIEqbECZowRK7JiWdJcZ860nFEPS1HQH7fOhtQYUeDP5
         Pr3SgJvTSsqSTNW+wD/zrzURxDV9262HEGLm4j29JiX9eiaMmJOpdabiMHb8VgX6DrPu
         J/0KUnv0OHeHOZW398eX+yzMhanCQ/2A4KdCxPkU5nA6mf7QqwOBXo0ZRn75rhWjmg6I
         Z0oOJvyMdD1aKJKT33dstMAWdQAQ5K0X2WCnYxW0Nazx3YIvnpvRY7d0t/Cc7+NG6Rwi
         WP5g==
X-Gm-Message-State: AOJu0YwWTv/SV8BcX2GfnJs/nwLvdQ+nmwW+jEhOZXkJqY5pQD4NJtyb
	m1Xr8vMLO17Eyd23AYV1sfh65bSHP8wA+6TKOTxzACDkhrdGk+VKpLLkDKA4fA9I3v+B09swCGr
	5JXw43BVMiFdQugJpzCF7S9mveKIgFBw=
X-Gm-Gg: ASbGncslpxHZ+8RThOoq9VKhd9BDHPPp1e2Pwwl3iQHXk5h34yudWJFyI908EqS6sce
	KaFPLOpFIh2ZWGooXBaHr4RBrxSesASWUT6uZxv4aaYJNY9v+PiqtoxXsNUTsXO0d3Azo3tTtQm
	AvHAkcIOmAp5PTfWOHtOXDvGzJG/TlJwvCshwdsTHLPFON8XqE3Eyk34w5Jgwb9D2AulPPi7ZqQ
	II+C9f3gDxP5I/+sPPlAN1ZpkhnZSDoc9dr/7DpFcZb76Wr3FIwD+QPTm4m6fq+CUpsIfqm9cBM
	uxfqqcfEKdVP3BNzJqXpbT/tFNoUYA==
X-Google-Smtp-Source: AGHT+IF5xt57zcNq+U+HwDSwBlT/1oLe/u7UB3heYQ1Kbhs29xTrM/I6aw5xgiWPTyWZevpEl+UkTdOu25fxJ6wmzM0=
X-Received: by 2002:a17:902:ef4f:b0:290:dd1f:3d60 with SMTP id
 d9443c01a7336-297c04931c8mr1358545ad.51.1762447759701; Thu, 06 Nov 2025
 08:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <cc874b85134ba00f8d1d334e93633fbfa04b5a9a.1761748557.git.lucien.xin@gmail.com>
 <3618948d-8372-4f8d-9a0e-97a059bbf6eb@redhat.com>
In-Reply-To: <3618948d-8372-4f8d-9a0e-97a059bbf6eb@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 6 Nov 2025 11:49:08 -0500
X-Gm-Features: AWmQ_bkulaWnvSaWsxVAziWY-nd-sBA09kWceVf7bj-CFTKpUJNHZl6a4fE2Pjg
Message-ID: <CADvbK_f9o=_L=K+Vo_MbJk3mXFgriUUtGCSVm6GNo6hFHk5Kzw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 13/15] quic: add timer management
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

On Tue, Nov 4, 2025 at 7:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> > +void quic_timer_stop(struct sock *sk, u8 type)
> > +{
> > +     if (type =3D=3D QUIC_TIMER_PACE) {
> > +             if (hrtimer_try_to_cancel(quic_timer(sk, type)) =3D=3D 1)
> > +                     sock_put(sk);
> > +             return;
> > +     }
> > +     if (timer_delete(quic_timer(sk, type)))
>
> timer_shutdown()
Will update. Thanks.

>
> Other than that:
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

