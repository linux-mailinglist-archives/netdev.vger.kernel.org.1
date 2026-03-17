Return-Path: <netdev+bounces-268757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C5ZOdTTuWkqOQIAu9opvQ
	(envelope-from <netdev+bounces-268757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:21:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4DB2B3107
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D0D3073A4A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E739C629;
	Tue, 17 Mar 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAFNvBuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C239B4A0;
	Tue, 17 Mar 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786047; cv=none; b=OPZCstjHowJ0u2TR2eOp5jKbl+rn1gHqxJDPqOm++6ZAJRS/+/gDD0XS6hIyZOM/9Cjo47pZGWnJvmVQAfsOYmnGLE45IuDXhKaEOAwPn5S8VYV5EuPhce2lbc2du6Didai8/5BO4I9kwgkPeRimb18rZb8bKfubqbQkv9bQy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786047; c=relaxed/simple;
	bh=nzKsTNfCaWoKpLestak1KDClGw/UYRbka/YqvLVh9rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs4SDEaC4aAtCkU9Vol8Bh/NOw/IFWmrPYcYnl9cp90sYIfUcgHj5uWWvS2LChacu0eWgnFXrDXvETqwXC7UO0lJtlkaXBwoA49bbl0FD6K6WgYKzw3PlpkFY5TpomqkKSkcDYrrOBMu4Burv/q7t7GBtNxjjs3GZmvJ1rx9C6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAFNvBuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC8C2BC9E;
	Tue, 17 Mar 2026 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773786046;
	bh=nzKsTNfCaWoKpLestak1KDClGw/UYRbka/YqvLVh9rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pAFNvBuSHUZzsl/I9NLulqf6RdIC/v9VKemm6HlXkg9p1ZxHVjgHweNNAnYPq1nJ8
	 bPR1AIZaki4A61+hMziTq8xuvcs7yGc2orGcg1ri4OYsAXOgWOGbHUJFSvJzLe8VjU
	 Qumf69SE3iREr7UhHdD0Y0Rj8fzn5gHudz/x2gZzZzT4otQ8miYOMhMIEfew8MJh7d
	 ahHbK+h1p/jcpFKGicWQ/EfyvKZ3ipRtdNxSQUDDyrdbD0hW+u+uTPiyBj/qaWowwk
	 5T//8+b/frZkYgx0PfgF/ADicJDc8VrQmWCBxxkgXzCOWJFXnpEIWajdFry1zrmzvG
	 oh9sKBCGIzrlw==
Date: Tue, 17 Mar 2026 15:20:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <20260317152045.58c719a7@kernel.org>
In-Reply-To: <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
	<20260316171200.4b8a96a0@kernel.org>
	<CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268757-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,vger.kernel.org,gmail.com,redhat.com,kernel.org,iogearbox.net];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F4DB2B3107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 08:09:08 -0700 Alexei Starovoitov wrote:
> On Mon, Mar 16, 2026 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote: =20
> > > Commit f620af11c27b ("xsk: avoid double checking against rx queue bei=
ng
> > > full") addressed a case in copy mode, when working with multi-buffer
> > > xdp_buff, where we were peeking onto XSK Rx queue twice, to find out =
if
> > > there is a space to produce descriptors.
> > >
> > > Adjust ZC path to follow the same principle. =20
> >
> > Acked-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> Do you guys need it in net-next in this merge window ?
>=20
> We have nothing in bpf-next/net so far, so should be fine
> to take this patch into net-next directly?

Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec9
So I think we have limited number of possible moves now :)

