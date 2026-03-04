Return-Path: <netdev+bounces-263770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK+SCXoZqGmgnwAAu9opvQ
	(envelope-from <netdev+bounces-263770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:37:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 964111FF188
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C00B3047BFD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8DF377EB9;
	Wed,  4 Mar 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X29muQLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAE372B5F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624241; cv=none; b=uS9Dt2Z9agZnRByU1RiuzfDeOUgDAJLujWL/11TvYS5AFHYkC3y5xZBwlqHHpEvOHhJ1hvtbKd1ylB9MyytSwT66fwUAIfgB7eSy/SIQoxQb/nQdCuh8T/BxAJHtnQzgsu13GfKuEfI/sBMWF1zxxx8Pm3SrnrMN0aubsvHO/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624241; c=relaxed/simple;
	bh=M3NVCfYA5yhhYewPJ2qtXjjufLcb/RCqjtOxWVebdNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqXiXnbvwLG7HkhjePZ/tm4CtRDJVb/qRmTwdE1obju65eWJmqTrV5GJe67GvGt8qHSWZC2P60WYIQzMdBKYjxfjnF00DC86y8tS5MsA3Wy5iTcrrZbfIKICoRjQ5T1L6iwMLIzU8Tr12h9N91SLO5HCxa0BlKfBKt4FNvetHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X29muQLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551A5C2BC87
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772624241;
	bh=M3NVCfYA5yhhYewPJ2qtXjjufLcb/RCqjtOxWVebdNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X29muQLLYAcKPag+S9O/ERhDSBhLieOqDd0RBXr2CTRAPC6YPZSp0WO1yZg1OCm5V
	 jFASpHmllAzL1qxKrFREPpvoRaTADA8q5vkmKl/eS76WEyvWgTG3Ntuyh18qWYHjjW
	 ptmxatKAjSLs/UrmCE5DT6f00i703+wboozrTf2xYkZk8AsErK0LCbxVPcsgSzmfKe
	 WrQyc+ZJXolBqjmQSQRhAWrgEbufK0IUUacnXB8jdGJt8gSbzzNHQ77Vzcr7TQBBx5
	 ugvirD+m2zihIZM5Rvz7Mg8nFJkiTI4L+LQq8VShXYF/CPqrCxwelCxyf8hTIlNevY
	 AsLB8qGc8wEsQ==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a15b9a556so12919196d6.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 03:37:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDOMcA3aFOM6TA/DjDo2tZRRLsnAgCGBqDPhnpnqqDI3inDb11QM90h9QyJP88ljRY/St++HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkVgUIcGDjEWbgteUzhUkGcbGXmF0dsjN2apokBNvsG+lguzh
	47mU/Ykv+GyXxeXTnaGhEdlAHfyCAjbP2OJHp+sylWlHoJhaOm31s6ejEly8VaRSTR2Kl8dlUPv
	ust8eusiD7dIz+/CReONbOL0yiZs2HvI=
X-Received: by 2002:a05:6214:400c:b0:89a:c0d:46ef with SMTP id
 6a1803df08f44-89a1999d519mr18681266d6.20.1772624240392; Wed, 04 Mar 2026
 03:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303181535.2671734-1-bjorn@kernel.org> <20260303181535.2671734-2-bjorn@kernel.org>
 <20260303160334.39276d7f@kernel.org>
In-Reply-To: <20260303160334.39276d7f@kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 4 Mar 2026 12:37:09 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNj9Z61aE1ydoKZBUqeWJsPOBC4J4ZgMd6JjSfC6J89-9w@mail.gmail.com>
X-Gm-Features: AaiRm50PaU6vmpgo6TMDnc4Y5lcmZiUObj2ifMPxsUxsp8sN5mOwInVklJroYwg
Message-ID: <CAJ+HfNj9Z61aE1ydoKZBUqeWJsPOBC4J4ZgMd6JjSfC6J89-9w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] ethtool: Add RSS indirection table resize helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 964111FF188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263770-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 01:03, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  3 Mar 2026 19:15:29 +0100 Bj=C3=B6rn T=C3=B6pel wrote:

...

Thanks for hacking a look! I'll address all of the above in the
follow-up.

> > +             return -EINVAL;
> > +
> > +     scoped_guard(mutex, &dev->ethtool->rss_lock) {
> > +             xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> > +                     ret =3D ethtool_rxfh_indir_can_resize(ethtool_rxf=
h_context_indir(ctx),
>
> 80 char limit width limit is still king in netdev
> please shrink the length of the helpers you're adding?
> And/or take the locks in a normal way..

Hmm, is guard() and friends discouraged in netdev, or ethtool
specific? I'll fix the 100 chars lines (sad face)!

>
> > +                                                         ctx->indir_si=
ze, new_indir_size);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +
> > +             xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> > +                     __ethtool_rxfh_indir_resize(ethtool_rxfh_context_=
indir(ctx),
> > +                                                 ctx->indir_size, new_=
indir_size);
> > +                     ctx->indir_size =3D new_indir_size;
> > +             }
> > +     }
> > +
> > +     xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
> > +             ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);
>
> Why a separate loop ?

We can't hold the rss_lock for the notify;
ethnl_default_notify->rss_prepare->... deadlock.


Bj=C3=B6rn

