Return-Path: <netdev+bounces-258672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAOMAAOFj2mRRQEAu9opvQ
	(envelope-from <netdev+bounces-258672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4A139536
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03AC3030EA0
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA2261586;
	Fri, 13 Feb 2026 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkRH2R4k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE622B8B6;
	Fri, 13 Feb 2026 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013357; cv=none; b=Z9o2HTqSMFI+K1oPt3zq4huoCVNAeTX9VgQyodCrM3YdrJxDr2gRV5fUqvlbQxYEpWQ3noWrR/2lkmWFGAVp3tFn+0IM3CaEvO/KAm4K5hFVgY9URMnNK2sN9L0K2Fa+HFDQ6liaXz463xM2PqIcxlk+Q0zjtAoxHYNF1fUB/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013357; c=relaxed/simple;
	bh=hwil1v8cOOxYX9g8fOoQ0xXGgetidedDLd7mpjii16Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3INJ1nOap1DARIMmQRt25pLcFw1kCkG60GFw5jyWSDXTNe26pkqa21GPXc9Ks1TLZKoeb4HnK8TaKNIdkpWcvC/qkTD5/DECCxJNay+HbsAZQqj0WnGweKars6eDExvyBdI8UuoaSYufGpZoyHdWIyF4IA3gS0vOyhIC0ScdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkRH2R4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A322C116C6;
	Fri, 13 Feb 2026 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771013356;
	bh=hwil1v8cOOxYX9g8fOoQ0xXGgetidedDLd7mpjii16Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkRH2R4k3catVXNwWYKbPVqIqlX7exf7NYAhqZIDjQVPI4oj5CEsuvp3dWcH4JYfc
	 Kl2ktTWtzm5oVSHAWdNUE4cdD4MdHFmlrbkeWKX/j4g45LQqVREU0g2rFOs9J9+pC1
	 v5z5nUWSvBfzSSl5U2XVxCzoBvXM8Y34au+gFu2MIsKMoKQDuuYipk95dgblJzwj03
	 4L3+gqiaprh4kJZEOVAwGQNGfLhyQwuA3ZOtxBjMXGB9fbh+UG0RRYTZXVR7yz8ItB
	 gr6jUwwE0133fL2RvBQIa4+Ja0Tfiuvv71YPP+YEhNtlb0mOCGymEmJ9WsBP7Cy2TA
	 WOCuCLFWd5v3w==
Date: Fri, 13 Feb 2026 12:09:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 kernel-team@cloudflare.com, jbrandeburg@cloudflare.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Message-ID: <20260213120915.6af2bc65@kernel.org>
In-Reply-To: <aY99llj2HmFNrR_5@20HS2G4>
References: <20260213192449.1294830-1-carges@cloudflare.com>
	<aY99llj2HmFNrR_5@20HS2G4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258672-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,cloudflare.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 4EA4A139536
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 13:37:58 -0600 Chris Arges wrote:
> On 2026-02-13 13:24:26, Chris J Arges wrote:
> > This patchset adds the ability to use an XDP program to extract the RSS
> > hash of a given an xdp_md context.
> 
> I see net-next is closed: https://netdev.bots.linux.dev/net-next.html
> I'll re-send with proper target after Feb 23rd.

Would you be willing to add a test as well?

https://github.com/linux-netdev/nipa/wiki/Running-driver-tests
existing tests in tools/testing/selftests/drivers/net/

