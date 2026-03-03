Return-Path: <netdev+bounces-262974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAHIOvg1pmlJMQAAu9opvQ
	(envelope-from <netdev+bounces-262974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:14:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1E1E7914
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B20FA306BC25
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B9280024;
	Tue,  3 Mar 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOngzt/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26D26A0A7;
	Tue,  3 Mar 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500294; cv=none; b=EzK7/W8KwmDW3oaLRWAX8cvoreY8ZIOl9cwlYP0eARZLQkvTz6lWwMmWiamkgBczbWRY1XsZcZVZxKtaFY9s8UVqOKgmLL2sReq6lQea9A1HOGhXdQ6fqANPvqoStwR2wEGVJf2PbryJvoQBilh2an3rwe9DoJH6gBwTKhSl0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500294; c=relaxed/simple;
	bh=8hjgCw9tBxfdHn7nYg46ux20VTettEl4HQsWGCPdvaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4q/ce8BJurRBvjR8wmAp7Y7XwepRhJZEMv52B3gT88wwW+deOfmbQOdWDnmHkBzRfXqGbSXxpzYUgiFM+wMjytVrcwEciIUyzPUmzDOfJcUSsXB6VxpDY/tu8zfLPbVb6fgwb1a7TooO8a+y+Pbqc/XPX4CcjpB8Z1lzsZ1v/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOngzt/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9F9C19423;
	Tue,  3 Mar 2026 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772500293;
	bh=8hjgCw9tBxfdHn7nYg46ux20VTettEl4HQsWGCPdvaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UOngzt/p8pSLllijatbO4/Gy7fc+I2xwykXJabnI1UymCCMkyw9mEKC5jF/Rt9TCM
	 4NxdoabAtppSRChGJUvzEnKuecUDe/x2zA1JrihX5rgsNWVmVcKfWi1RqyfPCImw08
	 i8DkNSm8X9nBKDcK+VkG63rz/Dov1wPeo2ZyooQrYnK9J4znXuUDKHVaTf/f0nFiW9
	 hO9jpM3IGGcQOwFgVi8kDQIpyv5MWs3pON3WqMONfmg29q7r739wfhMDnFqEe0h1aK
	 c7RUdhMLMMIx31lEzYutAjCv1jGhEzG0icaTJbWNGvrgaifVBsllPFABKO+v8u61YI
	 ye9EYbPYagUwg==
Date: Mon, 2 Mar 2026 17:11:31 -0800
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
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260302171131.28373ccb@kernel.org>
In-Reply-To: <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
	<20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
	<0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 72F1E1E7914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 06:58:46 +0100 Daniel Borkmann wrote:
> >   	} else if (nh->nh_family == AF_INET6) {
> > +		if (!ipv6_stub->nd_tbl) {
> > +			rcu_read_unlock();
> > +			goto out_drop;
> > +		}  
> 
> Can we just completely get rid of allowing IPv6 as a module?
> So either its built-in or not available at all, and then we
> can get rid of the stub completely rather than adding checks
> in various places which also brings a small performance benefit
> of not having indirect calls in some places.

+1 fwiw, if someone complains we can revert it back in
feels like a complete waste of everyone's time to maintain it
https://lore.kernel.org/all/20260224180544.3c865751@kernel.org/

