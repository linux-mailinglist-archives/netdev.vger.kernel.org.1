Return-Path: <netdev+bounces-289180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOI3FUSFC2oZIwUAu9opvQ
	(envelope-from <netdev+bounces-289180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:31:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F00573E3D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C885300BD42
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4A391838;
	Mon, 18 May 2026 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz3YH+9W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041192989BC;
	Mon, 18 May 2026 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139901; cv=none; b=imRVHUcqosgL1TVEAMrrLLCD0wLyjYzJvCNeb9HBV6qjWhu6x258kNRF4mmjKr0AKsUYmG8wtF9QmcmkI2wTybbf23TJBgrnrvejmRhV7it+sKeAsQMQFl/Xqa+mfq8nO/DX5YgxWFMNr6XYT/zT+9XBXwjbarG6DYHRVUAXFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139901; c=relaxed/simple;
	bh=Al+xAkc3zJx2hYJ8EWq9TnfFPavpYY51lLG8aXdvAsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaUpt/+i7vhfxf9e8ed4+hGLr0+Rn0+7O7MsJjCcPHcrLYP7QrHU6v0RADBL8tYaR8DnLTBq2w6GnX5QBzAgxHI5CYoUuabROFH5wh/YaIWdwTOd5pzKWWDzsQkhfb4YS69weMWHAMD8GxWHlpJRrjUykrgtvO1+cwONN5dTGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz3YH+9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F4C2BCF5;
	Mon, 18 May 2026 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139900;
	bh=Al+xAkc3zJx2hYJ8EWq9TnfFPavpYY51lLG8aXdvAsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dz3YH+9WBld+b0pVXSiIrWxyZg4xFys8KdMEhpsPJAxuMb4LEMcl7ndNYNqbbiWOr
	 gYTWp5axql1oBIMdjvnyGbZw0N3XTHK8nTl5XqR5VzFa7UT7y0tG0UL9SdtQDp6AHQ
	 hBlnGFH/J7KcvekfRLMKmV+P0giRbbHAMIAqp+lac5UbfyEruJVTID6LNhfJgZuVpy
	 5CVEJ3RAONCPsvQ3O8C9LSUJyIynw7vbpy2rwo+z2c7miVhNfz8Of9EZXGUqXKu/A3
	 LTgcjoR83AU0ghQy49Uak5PPlAekJhZ1xHXm8BKhVvAaSUy8f5q94FF13ZUT776jz8
	 1Ly2LbVzqOdYw==
Date: Mon, 18 May 2026 14:31:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
Message-ID: <20260518143138.74839bf9@kernel.org>
In-Reply-To: <aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
	<20260514183832.5ef205c1@kernel.org>
	<aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 53F00573E3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 14:27:15 +0300 Nimrod Oren wrote:
> On 15/05/2026 4:38, Jakub Kicinski wrote:
> > On Wed, 13 May 2026 10:23:55 +0300 Nimrod Oren wrote:  
> >> Data adjustment cases failed with "Data exchange failed" when using IPv4
> >> because the program did not update the IP and UDP checksums in the IPv4
> >> branch. The issue was masked when both IPv4 and IPv6 were configured,
> >> since the test harness prefers IPv6.  
> > 
> > Oops, maybe we should run against both IP version after all?  
> 
> I can send a follow-up to run all xdp.py cases against both IP versions
> when both are configured.

Follow up sounds good. This patch needs a respin for the issues
Sashiko pointed out, to be clear.

> Or are you suggesting this as a broader change for all
> drivers/net/*.py selftests?

Just XDP

