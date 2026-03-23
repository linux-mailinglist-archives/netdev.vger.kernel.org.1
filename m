Return-Path: <netdev+bounces-270752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BU1F4y0wWnlUgQAu9opvQ
	(envelope-from <netdev+bounces-270752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D22FDE96
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF811302C6DB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9036309E;
	Mon, 23 Mar 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSjjjMlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B202BE644;
	Mon, 23 Mar 2026 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302345; cv=none; b=nI1HC51My+LL8oCHobabqpQQrMoakxEhbk+4uqtHpc4c87D6V4CKhPMwWWMJ3smazy/tlUSBYLWsTTMxBPADMVVRGAa5Li/g9Wk8QdRKyT/852NIw0b8O8rFEqF7+9mklnAIjtwh0vBoNOKl7w9Zj4BPlvRH8WxKm2kXjBvtAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302345; c=relaxed/simple;
	bh=VITFuGFpBD7idTQ9bwVIiO0Kbe8zJIHPqCz5ac4iSos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doQZPiZ2Ogp9iTIRDISkJv+vOtTlajuFV57I5lzFw15ByZlYwbOP1CM8JfmS7IM3R3VaHXspDHe4xC1PcmeGVbacxA/ZT4FYGCznBG1ryFK42Bv5aeofURK18ZMoNppIIqKfCBcCX+STFhfFGEk+tOmUOMLngHIaXWEbwgKF6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSjjjMlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAFBC2BCB0;
	Mon, 23 Mar 2026 21:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774302344;
	bh=VITFuGFpBD7idTQ9bwVIiO0Kbe8zJIHPqCz5ac4iSos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSjjjMlB9hVE7KL2JxQ3Me4D7+o2MTI5tyWkYMUFI0YByVA9qerXqXhE3DFB9IOax
	 XGS8figT5TEnNPtarT1YGXUX6kyWtaKj9z/vYmdMuUfK0z2/wKaXp/9yUwjfg1xB26
	 kcvqg9m33WZclAjxAu6eL84YfbIbCMg6cNBEU5vyF4GZfjroVniVeX6iitgfzV1TaA
	 7OJdRc3j2FB2je5OJ6NySvhWzpHC1cEgonMd+VHN2MU6aJFPaRQ4PmLCskSUsJNzlP
	 RID4lFVabzh+dFXtandeFZwGvAneieSLY4qmONvjIOgZDbAPhupOjNDRtDVpYlwqrU
	 4LqbdwPtxAJdg==
Date: Mon, 23 Mar 2026 14:45:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, horms@kernel.org,
 alok.a.tiwari@oracle.com, davem@davemloft.net, marc.dionne@auristor.com,
 linux-kernel@vger.kernel.org, security@1seal.org, stable@kernel.org,
 pabeni@redhat.com, anderson@allelesecurity.com, jaltman@auristor.com,
 edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing
 queued RESP challenge serial
Message-ID: <20260323144541.3ef887b7@kernel.org>
In-Reply-To: <1433905.1774080919@warthog.procyon.org.uk>
References: <20260321014543.3892478-2-kuba@kernel.org>
	<20260319150150.4189381-3-dhowells@redhat.com>
	<1433905.1774080919@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270752-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED3D22FDE96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 21 Mar 2026 08:15:19 +0000 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > The review under --- is AI generated. It looks legit to me.  
> 
> I saw that there was one on patchwork, but I couldn't access it.

There's a 24h delay before results are public otherwise noobs spam
the list with 100 versions until the AI is happy.

