Return-Path: <netdev+bounces-289655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFuOHsjxDGoGqQUAu9opvQ
	(envelope-from <netdev+bounces-289655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:27:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EA586022
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28C66300B846
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11766369D4D;
	Tue, 19 May 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AczC3q4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EE2F2607;
	Tue, 19 May 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233214; cv=none; b=HfsJ7/eAf47PyFzqhyJu/tQaCPnsl6PXK6EJc2JRTAirK5tmHOoxg6fRGdjeyryI52x155mrsQvplm/9d3feKbMjFoLZRc8bsHZJNt6GknndO3+xthZFW8aU1MhnEX+dCzId9YP/oS2xVQ4TAP70ktiTn2zxWXs1k2miwodO1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233214; c=relaxed/simple;
	bh=I0hsHaMtnPi/bAvwUJpJzf8T7fh6Jopm/e+Iidj6xAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uESbWuy1IB1uz0fmx5L4tlvgoL62FMTZz31FJ7pb1mTyk2icl//3QrFirto2AozLabVec67b7BRHeJigjqo3OoM3EFE23O0HQlcmNyUu+uGU4MXdvj//r03/rG/p/k+vYrFs/SQeORLExaaeK3VEVUV/eOFIYFRdcwG2ec7GeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AczC3q4j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8941F000E9;
	Tue, 19 May 2026 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779233212;
	bh=HYjnBPBPS67l+j1tn04D+J2nO0RoeF3lUjicMmnNUls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AczC3q4jZdt2BLmc4SNIdD+4Zpdtb1nIO5fXG+JHOhccAzw4DacDluBOUT0X2wFRv
	 QpSA9qH3KSdJf/wG/xc7oasCymqdfFY7w0Ymfs7K9NHeu0AnExwHr93KNB9aoDF85g
	 8Q6Ec1Dhbl0rQzr0yUjUd0Ai/AdkFS0b8vtKNbcOHUaqNO7c32Sw684h2RrZJFoAG8
	 WSS0alaZNxQ3anxJdbbEm7lx+rQnlBh961bajcQcaaIEmmIRepXJthzntqwvpbq9cq
	 EyVEYGDd1y8fqZi/ria9kKFs2eJfjDwmGrN+z2Ruje0uU0dmlKV4RKjQG0T1gIWC/T
	 KDU8Yn+OvS1xg==
Date: Tue, 19 May 2026 16:26:51 -0700
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
Message-ID: <20260519162651.765cd587@kernel.org>
In-Reply-To: <364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
	<20260514183832.5ef205c1@kernel.org>
	<aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
	<20260518143138.74839bf9@kernel.org>
	<364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-289655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF1EA586022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 10:04:03 +0300 Nimrod Oren wrote:
> On 19/05/2026 0:31, Jakub Kicinski wrote:
> > This patch needs a respin for the issues Sashiko pointed out, to be 
> > clear.  
> Replied to Sashiko earlier (my reply went to sashiko-reviews and bpf
> but not netdev - oops).

Yeah, it's a bit buggy in how it collects the CCs.

> All issues are pre-existing and harmless, so I don't think they should
> be addressed in a net fix.

Please fix the csum thing.

