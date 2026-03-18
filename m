Return-Path: <netdev+bounces-268847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKgoB/7/uWlBQQIAu9opvQ
	(envelope-from <netdev+bounces-268847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:29:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1802B4F70
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BABB305C8F0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0823EA85;
	Wed, 18 Mar 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+GYD79H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB122173D;
	Wed, 18 Mar 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797362; cv=none; b=l9I0K32tjhhBK0+jBeuqWtxZJrm66r/wBW/gjTAwG6wWT8lBWnfUTpVleQ/ncuo+1Cs9o2SerePG/8op/rQtG2EuGQ7RE63bN19sbuDxtKp0Kk10n9MGuu6I6WtjzOANZudBJDugM/k33T7OKa3m883bFHvFHA5EXEznE4MJIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797362; c=relaxed/simple;
	bh=Dv+JEpBFgrAy98wW9koJXIR6zjsFbdTYTx/tYC2Gty8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3Rlqh5E3ckxdXIiELCfrys5iC+44wx+EZONGx0Og4yqN1ViWOmmuidiTf16evgyBVqdx8FuQoizKsOFrzv+UnS3N34f449KPCSNl+2aDwnWOo6Bk47w6eeLviK8DFmHAdXYI8rsyJqCjPEk6zOrtdFeyCV+qOAshWu4VOcGoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+GYD79H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7EC4CEF7;
	Wed, 18 Mar 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773797361;
	bh=Dv+JEpBFgrAy98wW9koJXIR6zjsFbdTYTx/tYC2Gty8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+GYD79HnC/miwLDEG/EdHqCOG8EkZo4TE43F8DvWswodRwDJ17OxFkoe+qA0l9Bg
	 Z5Q605f4vtIL7R/VXiIpCgkyTH6LRG0BHFsJ1uwWPjqs7kXECHJXYQRiV+ctAtMSac
	 IWua7LDNZjH7bGQA7RfeVvcbSVntUrjnt3lrwo/vjovrIOXabamWRrU3/3zdFg9Pc+
	 Q5xD5j5YiXk9NG3Q/YSnBNXQzSKuCUh/+IkaK/8R0vwjiBht1IZUmb97KhT8SGWInv
	 ESiZkH62C8kvqUSRebfqcIDZE9IoK4mob22jbjGlpfI4GsGrPNA+D2i2NJ0XppJyNy
	 qLGAesRMmmbqA==
Date: Tue, 17 Mar 2026 18:29:20 -0700
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
Message-ID: <20260317182920.3f4fd8eb@kernel.org>
In-Reply-To: <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
	<20260316171200.4b8a96a0@kernel.org>
	<CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
	<20260317152045.58c719a7@kernel.org>
	<CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268847-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1802B4F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 17:57:32 -0700 Alexei Starovoitov wrote:
> > > Do you guys need it in net-next in this merge window ?
> > >
> > > We have nothing in bpf-next/net so far, so should be fine
> > > to take this patch into net-next directly?  
> >
> > Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec9
> > So I think we have limited number of possible moves now :)  
> 
> I wasn't paying attention. We can revert it in bpf-next and reapply
> in net-next and probably route all future xsk patches to net/net-next ?
> since it doesn't have much to do with bpf anymore.

Maybe we should defer until the merge window and let it sit in Maciej's
local tree for now. It's a tiny optimization, Maciej can resend in the
next cycle.

