Return-Path: <netdev+bounces-266816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FzPHakOsmkNIQAAu9opvQ
	(envelope-from <netdev+bounces-266816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:54:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D405826BC48
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDA730DD36E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DA337BA3;
	Thu, 12 Mar 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVifggrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5F28643C;
	Thu, 12 Mar 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276832; cv=none; b=ZBwu1RMGPZuj4otyRPUgIrNDGpBz8mNIIPPTEu/ZdGRGh3LQJb6kF074lMWrxR+CHwW1mbNaA5BzJxlox2M0UGBt0aY78bhB5vFzmCK8PyDVPUnGkerWoqjY2XUWgT1eEDVqALq5+5yCeeeyHaNjCDsJn93dJ3kt7SH36QKTKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276832; c=relaxed/simple;
	bh=Q3+4Ab/bSeTUBy88ojfJKjl/bLS0Ga6QdrWQdkBqNbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYPeRgJ2kpj5W/eSJOEW7HwL12chURHgNgCXCJ7cthE9vQ6HsahU+GzUUCUn8hcbiRmyx8xcJy0ICEy8oGi2CvQvDHC4nSIXashSOqj7NHn1ARrmsDGYF5+BpskJwgNR113bJJvGkxDC2rlpZtByqp0mRDMIP0sAvnop1Y11GmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVifggrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69169C4CEF7;
	Thu, 12 Mar 2026 00:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276832;
	bh=Q3+4Ab/bSeTUBy88ojfJKjl/bLS0Ga6QdrWQdkBqNbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVifggrtTEp+4NAYtK6ELbT1Xnkshsm4UeF3liKNNBqbm5701b5JN3hwfdKdzxomZ
	 Ca4phC6HYlsjLcc7+2GGt0ZT9idjniOK1x42yHhv4JBnrl7Kbp9fLHXXxjCoelT2Bc
	 NjRTGHVMGKyEkDx94WBLUg1rO1THwv8qFHu3S0WiU220rz4WYNgTOraBWXUuP//Yto
	 aSVTLrkH62iLNFZZvlDnH4GDYKpjVnltWFHbHjl1zeB8B3UY32/V62+PRreNRNunI2
	 v4mWt7m/I+G7VbE98PPZ5vJGvI2tLOagfEsv9ZnMA2cQtuY+ul9fuFuC3GGFdidwdF
	 CNvV3GRvyKX4g==
Date: Wed, 11 Mar 2026 17:53:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
Message-ID: <20260311175346.3ce9df1f@kernel.org>
In-Reply-To: <92cea50b-8187-459f-bd0f-be0d253f49ff@iogearbox.net>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
	<20260310175858.70ed0391@kernel.org>
	<92cea50b-8187-459f-bd0f-be0d253f49ff@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D405826BC48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 06:50:18 +0100 Daniel Borkmann wrote:
> On 3/11/26 1:58 AM, Jakub Kicinski wrote:
> > On Sat, 07 Mar 2026 17:50:52 -0300 Ricardo B. Marli=C3=A8re wrote: =20
> >>        bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is=
 disabled
> >>        bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is=
 disabled =20
> >=20
> > Hi Daniel, are you okay with these for net? =20
> Yes, these look good to me. Go for it via net!

Thanks!

