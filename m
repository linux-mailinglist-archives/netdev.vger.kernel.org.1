Return-Path: <netdev+bounces-263941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF+jHTdoqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:13:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA3204F5E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7DC83006804
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20314378D9E;
	Wed,  4 Mar 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT5wrsQC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE936BCD6;
	Wed,  4 Mar 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644164; cv=none; b=FiqTbGLjP1kykleWrFO4WXn/+ASIgbuo9815Y55qhtMdlMtlZOE/YhZ1DZQnfrW49a/WPG6h009FqzjMHMH+EJNRRozBmO0N5A+4DxypD7d8d+7N+J1IbgCtVSCDN/VLTMfs1iZz1exgFBakmySRTzV3aw0C/TRD57Qui2IKNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644164; c=relaxed/simple;
	bh=w6ICnhS5+EQ1XucJOjZLgAkSndLeRnt6hbPmuBxmpZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSiOziWgKgmiw3NdiaKMFvnpNhn5QCObNJSUoiUVB8b7kqre/LaEencSP2Zq0gn3suHab9Ol+6lsyUj0g/LX84+k4V4W1QZr8bzpgqpGD9DJblHBt8/Xp41X2SFn423oKkMbElvsUaBcwUniqwITjox+uynoGbzgGBsf84rlJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT5wrsQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFD6C4CEF7;
	Wed,  4 Mar 2026 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772644163;
	bh=w6ICnhS5+EQ1XucJOjZLgAkSndLeRnt6hbPmuBxmpZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WT5wrsQCEdkgfiaq1d3go6er2XFAUI/bVm8RgMMNvUJcANJwFcQrOL1wEK1QdDi0z
	 JP+XGD9rMZZFgCGiyIti5T/AjGeuJk2Z8e5+VuRhGMRXZf/MqIC97Xe+cvCQG6WhME
	 3tY25dgSx214KtFXK0kNBAFM+eeAlXhCdu1XXM1fM3is/C4tM4TVYBDVw4s0r9Ju7p
	 59soPz5/GB+1P+/DqlZGZNOi9+jTOxIPIC+Z8NzNmY62HELr2+sXIdVIiUZNIp/4kT
	 VRP8gx1hZID8c3VDVtr+2e5l0zX/lQxt8oPW/WPL3ZqxKcTXWlpWNDAjz3Aslu0cRC
	 1XAXt6adV/mQQ==
Date: Wed, 4 Mar 2026 09:09:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 1/5] ethtool: Add RSS indirection table resize
 helpers
Message-ID: <20260304090921.408a8c4f@kernel.org>
In-Reply-To: <CAJ+HfNj9Z61aE1ydoKZBUqeWJsPOBC4J4ZgMd6JjSfC6J89-9w@mail.gmail.com>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-2-bjorn@kernel.org>
	<20260303160334.39276d7f@kernel.org>
	<CAJ+HfNj9Z61aE1ydoKZBUqeWJsPOBC4J4ZgMd6JjSfC6J89-9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82DA3204F5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 12:37:09 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > > +             return -EINVAL;
> > > +
> > > +     scoped_guard(mutex, &dev->ethtool->rss_lock) {
> > > +             xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> > > +                     ret =3D ethtool_rxfh_indir_can_resize(ethtool_r=
xfh_context_indir(ctx), =20
> >
> > 80 char limit width limit is still king in netdev
> > please shrink the length of the helpers you're adding?
> > And/or take the locks in a normal way.. =20
>=20
> Hmm, is guard() and friends discouraged in netdev, or ethtool
> specific? I'll fix the 100 chars lines (sad face)!

Yes, non-scoped guards are discouraged.

> > > +                                                         ctx->indir_=
size, new_indir_size);
> > > +                     if (ret)
> > > +                             return ret;
> > > +             }
> > > +
> > > +             xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> > > +                     __ethtool_rxfh_indir_resize(ethtool_rxfh_contex=
t_indir(ctx),
> > > +                                                 ctx->indir_size, ne=
w_indir_size);
> > > +                     ctx->indir_size =3D new_indir_size;
> > > +             }
> > > +     }
> > > +
> > > +     xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
> > > +             ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context); =
=20
> >
> > Why a separate loop ? =20
>=20
> We can't hold the rss_lock for the notify;
> ethnl_default_notify->rss_prepare->... deadlock.

LOL I guess scoped guard also has negative impact on readability

