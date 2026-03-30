Return-Path: <netdev+bounces-273049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHWTE6HgyWn83AUAu9opvQ
	(envelope-from <netdev+bounces-273049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D626D354D0B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB2C300B06F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7F34405B;
	Mon, 30 Mar 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6BSmCaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394DB37F75A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837776; cv=none; b=mYZsZ3kwz2eOwtE1tYbpADLPTxhZI1IsmGAYcwqy2iQlaUkIQZaC948u8+HcHbNJyCE93aeY5F1xKRVaAIbGh7qmvIOvdAbM991DXTjEcykkoHJHvtciD0i0tImbYnyTwP3OE1BinLUBtaDGY4WS5eLWIBt9S8uexPKPHu0dAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837776; c=relaxed/simple;
	bh=q+XVYlFLxCAzomJfQtNjsLarOjG6MU1Go2EMdXhpJq0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IgLdVeA3z/dKRn/ArNZ2AMJ9hSiSx9ETx/fFIM3nIH5XVX2c7NvD7oO3t2nYbQO83IErbpzmuZKJ0sk7QqDsD4R3b2izSCHEYLx5CCjNCWmPrLfbq739eciwI1vSYFvPAkZqs1v80L8fM8R+cTcYREuOqtwdrGcozqhmdTZ6anY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6BSmCaE; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64eaf8aa893so4566494d50.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837774; x=1775442574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+XVYlFLxCAzomJfQtNjsLarOjG6MU1Go2EMdXhpJq0=;
        b=E6BSmCaE6Ly6XM2TQ7PfZ2KjhVdIFYFQmCIOR2GwyQDV0xiUo1gljhEEeTnYNHgt1I
         nA4Xg+OvwtFDVv7JROq4vKYzjDwI66gBOrMTtE7f24m/2ZARDZDiSxVHC0kfrO8s0zFF
         OewjpJFtprGIShnB5thiASBs1T0XmzJ2hiJtxqtfsW79pqvBJ2FcHXuVKH8EaUT3POL1
         NkmCefCp1qkN9qdhH9mpygkPp1e/ZDoTgFghSOHOqbXTeJYkmZo/xeXKzuLNq+4iySnx
         XsUrdegthsPzb6nfcoMhvbCy9NyCrovLHRuVexhlQzqd+GnTAk9T8eNNqNIM+4R5FyBs
         KigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837774; x=1775442574;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+XVYlFLxCAzomJfQtNjsLarOjG6MU1Go2EMdXhpJq0=;
        b=bPOynoe4B3PELnDfuOACpJ2vts0uRVlPkYIFi/arsCa1zNFV8cmxHCPUa94xqBzlNI
         qzRKsnCUhA+HMLZd9cOUBULJdIZcxJfzoqsH2CbsaHlsgtTh8SVv6iZxqATiU8MQIQ7o
         QkFO4/xZW507b9J8RXVEr4qGpCp0sHSxNoLLJaQJatdxkfgLvJLw23A9bLMDGiQC2Y0u
         RHdqajTPGuegxcR3zKNQUGmz36GL/C+gbuF+JQswfvWz1xUL2foCJZNfezL3rDp3eMGp
         RCVi075IT9+exB+vIlzb8gnHZvZRv8Tf+B0IFdIg21k2T0FYChxMzJcR+r5/Owfkri0Z
         cu6w==
X-Forwarded-Encrypted: i=1; AJvYcCU4xoWzBfrelGYuo4PMDp4WoFlzJlYFylxYSnj32NQkJXZVqlSPoeVHyv+TvU6ifoaGE9R0mMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CITwWBRWENiHIh++fFwNLu6tsm00n5EPDEjU7qoCFEy89zbi
	xX0fxbMu2lobjBLHXs+MVbW9QI9FdOEp4eFNo5/qOSVMcCZeCg7U9kOl
X-Gm-Gg: ATEYQzw/XBty+QJoYBNv/721hNhkPlfEjA8a+P4HEVu9huBjRV1VY/WA5WHX+EQX50v
	/iM9iLfvl5lXMCgnGzR4oe8j7BgwSrr6zKuKd+FxX86XXMCAS/p/SIyW6auC7nc5aYEIMI4I4DW
	YUVAoSCZ8EUZlE9DtakYB6P75qSnTko9v9dFILyVFim45L3PP0TflKaX032PtD3HLsuRBhTG99N
	IAnL0sADNWTaPn1WlpyMfkBINHBeeQMPd1QMUKK08UGSodokY1OSzEVlT2K98JUD3yr/si6h99R
	7g2XHxIPTt/HBNFMbn0JUHzKKWkfetVEkTuKlup7armP39U8XHA2qhJkrpyMgv0yPmW9Wx5ugJU
	epMW5AEvG6lFNz8SpOUWdME4O1mSTjJ+6dOv7c21nRdKrYm5XL0DKjTEZU+xcZqO91Hp/kNwT6X
	WYOyx+sBZlrsId+wyg/TZZtKxWJKOKezUseFGAwOgkAajAAaJz2PzU2eT/xZvjT5Ir7VoqdCjPJ
	54F
X-Received: by 2002:a53:d005:0:b0:650:1bc2:7e18 with SMTP id 956f58d0204a3-6501bc286femr1961791d50.1.1774837774124;
        Sun, 29 Mar 2026 19:29:34 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500934c235sm3278408d50.17.2026.03.29.19.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:29:32 -0700 (PDT)
Date: Sun, 29 Mar 2026 22:29:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1968171df848f@gmail.com>
In-Reply-To: <CANn89iL_znbKR2oqOs9kQTgAnNKv487ymr8Xx8ouHFsyAK=o6Q@mail.gmail.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
 <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
 <CAAVpQUB=LtWXq_bzET2DOkyw_y5qRsuUf_fNCRE+TtiVHFktZw@mail.gmail.com>
 <willemdebruijn.kernel.64bceda776b2@gmail.com>
 <CANn89iL_znbKR2oqOs9kQTgAnNKv487ymr8Xx8ouHFsyAK=o6Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273049-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D626D354D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet wrote:
> On Fri, Mar 27, 2026 at 4:16=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Kuniyuki Iwashima wrote:
> > > On Fri, Mar 27, 2026 at 2:48=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > >
> > > > On Fri, Mar 27, 2026 at 2:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu=
@google.com> wrote:
> > > > >
> > > > > dev->type could be any value on tun due to TUNSETLINK.
> > > > >
> > > > > Let's not warn about it in netdev_lock_pos().
> > > > >
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > >
> > > > Hmmm... should we instead have a list of supported types ?
> > > >
> > > > And reject user space requests for unsupported ones ?
> > >
> > > I chose a safer way but maybe we could reuse tun_get_addr_len()
> > > and define the default case there as unsupported ?
> > >
> > > I guess it's okay even if it breaks userspace because we can
> > > just add a single line to restore the support.
> >
> > We shouldn't risk breaking userspace, over such a sanity check.
> =

> The thing is : this check makes sure that each type has a different
> lockdep class.
> =

> >
> > Presumably any truly newly added type will have a non-zero addr_len.
> > While tun sets this to zero for weird inputs. Maybe just filter on
> > that in the WARN_ONCE?
> =

> Then we might hit some lockdep issues...

Warnings due to stacked devices wouldn't apply to tun.

Can this be used to set up (false positive) lock inversion deadline
reports?
 =

> Perhaps use lockdep_register_key() on each tun device...

In tun_set_iff replace the xmit_lockdep_class previously set by
netdev_init_one_queue?


If keeping the approach from v1, perhaps a tun device can already be
identified in core code without having to export tun_link_ops.
From the init in tun_set_iff, dev->sysfs_groups[0] will have an attr
"tun_flags". There might be something more elegant. Just the first I
spotted.

