Return-Path: <netdev+bounces-248213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6ED059BF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF033044BA5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D773033E1;
	Thu,  8 Jan 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grvXtx+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D482EFD91
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894297; cv=none; b=DfACh9TXtgVfS/4yv3HXCfmfbjGBfczcQqT30IU+233BTO/SnePPWf00zXUWGBkacbskOdUPUY799cuUwRR+n2Y+IDj5Op8KgvxPjU6l4wO0KZB9aiiEHFMWUg+MmSTpMPOVTGtpvbMHM3PV8aXm2zF78EkKQT6ZAoDprvQ/vSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894297; c=relaxed/simple;
	bh=ss/QmZtegoT8QUE92ql/8y/No8UIkLe6lLm4BxyGzgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmyxxGgw40Yw/iuph60Wn3MA9i84SUdlYVmgARWSU7sVGIK8lFRr6OR5J2xqjx6fBwQQ/mjClVb1lIeiC+X0EOeRof8n4tDI3ij+3723ZX/8HLa0gzomskujwUzUtHmpblGlp2EhXlIOk/rBrfae2DzsLMOYPmuPTpUIlz7gaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grvXtx+Y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a102494058so9597085ad.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767894291; x=1768499091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss/QmZtegoT8QUE92ql/8y/No8UIkLe6lLm4BxyGzgg=;
        b=grvXtx+YX8ETlnBUL7z97klEGcrQd5hbLXDFB6kjGgEdItZ619Go+VlsWbhhoAzeI5
         W1e/egTR6d67EoApj4JvkyxtIfI/CLaI9EDUXKvAJVENV3d45e/INBnWMGrLjlyfrwVJ
         uHwkKuMFS2Ubvxs+1MRSxu90lugbcMCsHc+MuruVLLGnMxCSR2ELGnGsPTqXpPdbhIxn
         nqrUqlXh4qXT27DCjttxbqg99aNK81pEJQr4KG20LCtk89AvjnxqKT4a3bEYDnyP45cw
         Aq/d6YM2Z9IwvvZtYAVQsy4V5+P9qr5rLx9aCcqsFj/F08MWGIHbyNbgucep6oiwWamY
         7kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894291; x=1768499091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ss/QmZtegoT8QUE92ql/8y/No8UIkLe6lLm4BxyGzgg=;
        b=GDqROdBKPhhykOhg+VTjoFNCi9XHk++jgTVNXhE3/Dpo0qNt/pUyLy+DZWqpVfsGau
         ZTxu2Pizjva3wITzGqIBiPBs6WicNOs/LJVhTStN23dBwr6cGsoq8PpLgCl1GaP+VBBl
         W1xHXu7ZllZVIElhmuz2jdxOBCit5Pk3Zle+DMexjO6WHCqZHQv16CLI5MEtISggF17i
         BaTj35ktd0Ep4cpsiyqUehlYHJvgP5ZBTuiSVIokWuKpGUEB0ncyEajHpcvv1g09Qmqu
         GDnPuTZi3Rpm99UIkuzTU4fK2qqB2nDy/mCfmPW/DwBX+AqbTaP069VJobg4S8gdek4W
         /Eqw==
X-Gm-Message-State: AOJu0YzyFIUFvmWtPgG76m9lYoH4dAnhwcfMKOW8imWUQ2+ubR6JEqfq
	IcWjHfXGgB6LvEV64k2XOm0d9gScClWYCE0QAzX0uociy3VDFfS287MOs76TuyGctNDWBlghIY4
	udLuj4rxOlAYQNze6Bn6UzJE/hAOzz48=
X-Gm-Gg: AY/fxX52p9eW1jLJFftlb5xdb/37wDDtD/UUChJ9exdr5McLp6TJsm9vCEwSa5qduKW
	22vG8VrIrd5WArKsCJduj2Qaq+MOjj2/AQo+a6AJu0F2d5ioHRrdKJakl3P/fc19H6KBrajgpfR
	4xCGwmHXRsqkJx8UWsHxUGR3y8/0NLnXQ9T+VPwho2DniVxYXUpTKb4/gngqDqsfhYndZMHCdjY
	TGr/xYgfyR49ZkJlL/rZSUiYnZoMReRQEK498Zrp51FpjWS0xUjbLVQzD4YLoKww7Ag1O9Sr0dJ
	tD4XIJQoMDM0yYKsbkPbDXdPG3Mpt+oUgJXqgDE=
X-Google-Smtp-Source: AGHT+IGo23JTAhDe6YZ04HEPRhsvfMI0iFv39hHhbnRbHjZlEOShm5/5yd/f68zNrStyS0OL76jXKcU4YQTPqscbaUY=
X-Received: by 2002:a17:902:d4d1:b0:2a0:b432:4a6 with SMTP id
 d9443c01a7336-2a3edb775abmr78034655ad.15.1767894290166; Thu, 08 Jan 2026
 09:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767621882.git.lucien.xin@gmail.com> <127ed26fc7689a580c52316a2a82d8f418228b23.1767621882.git.lucien.xin@gmail.com>
 <1f31a9ac-01dd-4bb1-9a5a-ec67b381c5c0@redhat.com>
In-Reply-To: <1f31a9ac-01dd-4bb1-9a5a-ec67b381c5c0@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Jan 2026 12:44:37 -0500
X-Gm-Features: AQt7F2o6dW95jyJ167axiY2PfCkYBHxaTuo-Pd8v15qVpoBoDqajatltW2Rygls
Message-ID: <CADvbK_c2YE8KfXE2KP0=a_zaUm-AWNOwpmyeDCQURA3AtbDpOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/16] quic: provide quic.h header files for
 kernel and userspace
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

On Thu, Jan 8, 2026 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/5/26 3:04 PM, Xin Long wrote:
> > This commit adds quic.h to include/uapi/linux, providing the necessary
> > definitions for the QUIC socket API. Exporting this header allows both
> > user space applications and kernel subsystems to access QUIC-related
> > control messages, socket options, and event/notification interfaces.
> >
> > Since kernel_get/setsockopt() is no longer available to kernel consumer=
s,
> > a corresponding internal header, include/linux/quic.h, is added.
>
> Re-adding kernel_get/setsockopt() variants after removal, but just for a
> single protocol is a bit ackward. The current series does not have any
> user.
>
> Do such helpers save a lot of duplicate code? Otherwise I would instead
> expose quic_do_{get,set}sockopt().
>
Not much, just when using quic_do_{get,set}sockopt(), KERNEL_SOCKPTR()
will be used around the optval and optlen.

It should be fine to change to expose quic_do_{get,set}sockopt().

Thanks.

