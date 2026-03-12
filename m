Return-Path: <netdev+bounces-267118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIAGICfYsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:13:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D0274084
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 079F4303B925
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E93C871C;
	Thu, 12 Mar 2026 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV1ESFfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE93C870D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328352; cv=none; b=hp8E8QEIi9/UJ8Jw8PCV5l7COqPABoOcj6LCX11ysNYyOHPusTmMisPt+XGVhbCXweqWtISTQyEPBFOz0PcfCHHyEZ4clxmt7pBub3kytOEZQeS0AqpbN6CnxjHEmCVlMWeM9HPMqEK4U8u9XB6iWjsiT1HHFIh0VNZe5fxeY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328352; c=relaxed/simple;
	bh=JF3xHNGa8r6OMmdSsEx9P1AFHuB41PNGGUONR/PstEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPi3IK9PYXGHrUS/2hqNQ18a+StnM2K4zHa089HZ/fuHI+xjeyfZNt+rYXiD0gnF8DVKmZ1Y6nF07UIBdRx/TW/Ihs4HHMNmwDAR1cp7scUgY0VR1su7cSdA1YHcqxtBcGsXI2nzLaKhGTtPMdEFg/87LQw7BjrnrL904n8dsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV1ESFfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B30C19424;
	Thu, 12 Mar 2026 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328351;
	bh=JF3xHNGa8r6OMmdSsEx9P1AFHuB41PNGGUONR/PstEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bV1ESFfYvLaau6l8TShDGHClmcS5KVjKrZ8DxVT7rx0Ba4eFXIYzujp0cLKyS2m6Q
	 vbIaQjGkMeROoUp5Omwz0/zMwp6vxsGH7e+UdeT5sGFh9JDJnMVqcWvkgVD4xooEEi
	 WFgd6DXuFRe9NZsy0Gcp/Yv0lak1XcvNxnrv0+GlA29QJWwto93NnHV3SpSk1XKP6h
	 YeC/L+sl0dWbmLjlA6E4ulteXtUmz2y91DehOEdXc/0mo1qndBhrXhBfypPCwAnmtB
	 Y5uvM90gl/zMM8XfMc+hS4+naxYikaIXaQr4K1ELe2zSU2LrXNZAZubosfle1m0pnR
	 cfLldCd/FtHBw==
Date: Thu, 12 Mar 2026 08:12:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Guillaume Nault
 <gnault@redhat.com>
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to
 NETDEV_PCPU_STAT_DSTATS
Message-ID: <20260312081230.1540a7d9@kernel.org>
In-Reply-To: <CANn89iJbfsT5-j0iPWpCSsoDuOF-PmfbE9hL4YpEU7ucT8ipxQ@mail.gmail.com>
References: <20260311123110.1471930-1-edumazet@google.com>
	<20260312074630.52e7a311@kernel.org>
	<CANn89iJbfsT5-j0iPWpCSsoDuOF-PmfbE9hL4YpEU7ucT8ipxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A0D0274084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 15:53:02 +0100 Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 3:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 11 Mar 2026 12:31:10 +0000 Eric Dumazet wrote: =20
> > > @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> > >
> > > 32bit kernels would either have corruptions or freezes if the syncp
> > > sequence was overwritten. =20
> >
> > And moving syncp would be too much of a hack? =20
>=20
> I thought about this, I prefer doing such work in net-next.

SG

Acked-by: Jakub Kicinski <kuba@kernel.org>

