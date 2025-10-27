Return-Path: <netdev+bounces-233244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E300BC0F228
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9E0189D09D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF973115AF;
	Mon, 27 Oct 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="eKeihIJc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986B3112B6
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580384; cv=none; b=uu2uzc+opiP259yrxfEZWcc0A5m+taTNeMrFJYzXS3X42svgEK6ZJ+m+r4YhadxQNSE+4OIQyUiUAfdSODAFzcw0AUMARpRg2jniVsv+sF17evkpD9kVjkR3Jd+wRTwr0kjiZKjmcVR4CdfsZn9KeWuY7/uS2lejcmXixAxL45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580384; c=relaxed/simple;
	bh=qAwFGdXkn+fNYTCd3S513c7S/IJtQtkvnrltpd0ddeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB0B60JjP60t0kpAUGzF4o3xEOpuHEp3LzA76fTXfcY0JG0E9CmcPIieLHkQkL1P5C1hAnmVBSiIM+GqMfxISqva50vK22siVKA4hKTjEe5AEvFqt6BczzBl2YadNmDnq6TXQGfVf1bN8bbiIsgqigssbZBunySoYL5WBnkcJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=eKeihIJc; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=159dh4QNniwM1GLNE1gY2qN1aiApwiY4K5u74KdGC7U=; t=1761580383; x=1762444383; 
	b=eKeihIJcONBvaXMxfMFObLwJj5dUu8DlWOJz+pCNk+6OqAF1t5pfBcHknF5uKvu+iamEfLzV8Gc
	LYLO6toQ4C0PesljHTue6ZmyxugoJL59JU7RMnd6SRKFqE/ogy+zqGBW+UORYk9xvPk3XTQ/eP4OP
	0rT81K1YQA8wb6CUS6WUKX8fR89teG5lDHbw1d883+dzwdU9A3owTO7x6RP7n9nJaDjGjEDECZcO2
	kmxOvYPT2n48uBBgwrCU+PXycix3P+0qnnv6rnSSfytP58eHb1KxSAAv5pYjjo2jh6d9Cbe+uIvbt
	XfAf6AJ9vcngkKV7/xxt7AE2SZUF0Q8XSU4Q==;
Received: from mail-ot1-f52.google.com ([209.85.210.52]:56765)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1vDP6i-0006rV-2i
	for netdev@vger.kernel.org; Mon, 27 Oct 2025 08:26:05 -0700
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c532d70cfaso1622198a34.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:26:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzz9bW0CxD07I1oKx7ZfZAHR7zVR4Wxk7/efW7Cmp/gOFZ/bRe/
	vxDtX34WHJkmqCvj8cfbtnxhlrATNac5yo2KV93Rn0HcVRohxqTsbnLRzRyK1v/HsZKobF4ePLb
	B7FgVhzeEnuLqsdom3zj3g6Gs83sbQXA=
X-Google-Smtp-Source: AGHT+IE8OWg/j8c5gWX60vjj6RWOzRqsaA6KoRINIOWMfZ3lSK6gaNv8zglmf7P33KUlzpj3LEo95IE7GWmXcLfwLlg=
X-Received: by 2002:a05:6808:6d8b:b0:44d:c03e:657a with SMTP id
 5614622812f47-44f6b980f3fmr89421b6e.7.1761578763498; Mon, 27 Oct 2025
 08:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015185102.2444-1-ouster@cs.stanford.edu> <20251015185102.2444-2-ouster@cs.stanford.edu>
 <aP89WhbDEzt24sFG@horms.kernel.org>
In-Reply-To: <aP89WhbDEzt24sFG@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Oct 2025 08:25:27 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyd6MuPG6mRA+h0RCnCpPyaSRwnwRRt2aA5+nsumek2-g@mail.gmail.com>
X-Gm-Features: AWmQ_bnEkRcK3b-j0TnGMfmMyXSCYX0qMsZh5BaE8iFhqnSEeh7cg2YfPtdj4eI
Message-ID: <CAGXJAmyd6MuPG6mRA+h0RCnCpPyaSRwnwRRt2aA5+nsumek2-g@mail.gmail.com>
Subject: Re: [PATCH net-next v16 01/14] net: homa: define user-visible API for Homa
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 3134a374f3853b94094f80bd9e2b84a0

On Mon, Oct 27, 2025 at 2:37=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 11:50:48AM -0700, John Ousterhout wrote:
> > Note: for man pages, see the Homa Wiki at:
> > https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> >
> > Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
>
> ...
>
> > diff --git a/net/Kconfig b/net/Kconfig
> > index d5865cf19799..92972ff2a78d 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -250,6 +250,7 @@ source "net/bridge/netfilter/Kconfig"
> >  endif # if NETFILTER
> >
> >  source "net/sctp/Kconfig"
> > +source "net/homa/Kconfig"
> >  source "net/rds/Kconfig"
> >  source "net/tipc/Kconfig"
> >  source "net/atm/Kconfig"
>
> Hi John,
>
> I think that the hunk above needs to wait until a patch
> that adds net/homa/Kconfig. As is, this breaks builds.
>
> Possibly the same is also true of the hunk below,
> but the build didn't get that far.


Yep, there was a bug in the script that I used to generate the patch
series; the changes to net/Kconfig and net/Makefile weren't supposed
to appear until the last patch of the series. I have fixed this now.

> > diff --git a/net/Makefile b/net/Makefile
> > index aac960c41db6..71f740e0dc34 100644
> > --- a/net/Makefile
> > +++ b/net/Makefile
> > @@ -43,6 +43,7 @@ ifneq ($(CONFIG_VLAN_8021Q),)
> >  obj-y                                +=3D 8021q/
> >  endif
> >  obj-$(CONFIG_IP_SCTP)                +=3D sctp/
> > +obj-$(CONFIG_HOMA)           +=3D homa/
> >  obj-$(CONFIG_RDS)            +=3D rds/
> >  obj-$(CONFIG_WIRELESS)               +=3D wireless/
> >  obj-$(CONFIG_MAC80211)               +=3D mac80211/
> > --
> > 2.43.0
> >

