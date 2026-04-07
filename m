Return-Path: <netdev+bounces-275818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPQINK5h1GnltQcAu9opvQ
	(envelope-from <netdev+bounces-275818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 735283A8C97
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F04CD3004F32
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51623C516;
	Tue,  7 Apr 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjs7fCXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD44238C1A;
	Tue,  7 Apr 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526313; cv=none; b=KF4HAqmXXHL/zL3tM4FgOEqeaP+juohKAbkLhD/JU4uzBeWv1BZEHnzheOVa2oMOJ5m7sfrB1SjXKxj4Jg9l5lJpdbM5hLXwOJWFs3crSNUJkN0+sh0gg3Sn1VVZwHz2hXUMWkOooBXqVGF77BvFxL7q3gS3AJxS0M7Q3o8kY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526313; c=relaxed/simple;
	bh=KcvkA/E00Wx4hWtOlaUTISCZhZKC8imyu8C7PpT9wWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Jb90lyufpfRWaMgklJw3KSRcqT6gk90G5vY24qBZBtdtqJdBMuK7bNIKngamYz6WKRw+LHVlrCNViFhNI8vnw2W9zzsQFDM82IYnjnQlVw4QYm76M9bHvxtZqcR93pNDHHq2a/4Ttm2DFZTlvu/G7AGZ/fC3zSF+JkoSxaAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjs7fCXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0232C4CEF7;
	Tue,  7 Apr 2026 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526313;
	bh=KcvkA/E00Wx4hWtOlaUTISCZhZKC8imyu8C7PpT9wWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mjs7fCXYlHewMportKa2HSLRVh7Y27pMubXiTN69l5Qxniz08aYnrybMkIqStrueQ
	 uvD5VPJnVlbGpkLMvHjAdQlzpQBjW56pBgqWAC+gq7IIJVv9060NODRFK8g7p9fjhP
	 hcIq0FXPF4SUOS+1qyNU0kAJPvHiorWJghhRugd2mK+M3ZVmdjEViciNtUSpgBv1AJ
	 Ka55jOfDjMZEl5H2X6J8EY5/S/J+Ludg/ddQh2ukycblp5bszEu7nxvtERK5aK1s+W
	 7gS4Y+ycbE3jZ/rj4oNWXYjSJPnHBkwzIZ7Luyw5a4vKwZugc6rSaCpN8Cn7GBsWYx
	 z7hYFuse4JpCg==
Date: Mon, 6 Apr 2026 18:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <larysa.zaremba@intel.com>,
 <aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v6 net 3/8] xsk: fix XDP_UMEM_SG_FLAG issues
Message-ID: <20260406184511.748707f0@kernel.org>
In-Reply-To: <adDjtUbNPSjffLSm@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-4-maciej.fijalkowski@intel.com>
	<20260403165636.1f4ee958@kernel.org>
	<adDjtUbNPSjffLSm@boxer>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-275818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 735283A8C97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 4 Apr 2026 12:11:01 +0200 Maciej Fijalkowski wrote:
> > BUILD_BUG_ON(XDP_UMEM_SG_FLAG & XDP_UMEM_FLAGS_VALID)
> > 
> > somewhere or use a hack like this ?
> > 
> > #define XDP_UMEM_SG_FLAG	(XDP_UMEM_FLAGS_VALID + 1)  
> 
> Good idea i'd lean towards the latter version. I can send v7 after easter
> or if there wouldn't be other issues related to set maybe maintainer could
> adjust it? ;)

Quick edit breaks the build, probably missing an include.
Let's leave it for a follow up 'cause I'm gonna break something :S

