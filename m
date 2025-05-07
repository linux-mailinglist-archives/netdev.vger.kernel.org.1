Return-Path: <netdev+bounces-188515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73476AAD27C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE351BC84C4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B872625;
	Wed,  7 May 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afOrFpBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A133EAF1
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579513; cv=none; b=jJ7T+8PBjFRXy22E3+3GB0mJJCBC2R3ee6R9CUpwpAoofdEsI8YHV2+MpRZuAm3HhBRRQ2+6oYCunC6zA8+dv3PtnGrYIAzQ1cy2Ei8fBqWw+lUHpPdtl6cWZtB1kMd/D5plhTSdoIhjn1Umrg+R7ggkVAfQgalfc02qYqLOhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579513; c=relaxed/simple;
	bh=VdRsu8aJ5jn44QDTp5Gc3GtceF8xnedwP97dkHTL/Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsBpfsRHwkkLjGiSdVpyxBJcJQELj7OI4aXvQvdPz50NnozX+V78dnrRfq38g885F+UcuTnb1u7PT9BQ3O81uwePn/0hkVN3XMp4OPwGZ31XrC9l9Uo1FNS6od/bzW3VCFbBvbJkxpmJsZ59mQbiQFon9gQV53lZVJn47/rH0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afOrFpBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E704C4CEE4;
	Wed,  7 May 2025 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746579511;
	bh=VdRsu8aJ5jn44QDTp5Gc3GtceF8xnedwP97dkHTL/Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=afOrFpBQofFLxgx4DdVsn+fIXkp2mUvU1xqzBI8pn75k/XZs7f+IC5EqiYfUppfji
	 FFqkG0imUtP4yaE68ALTcSNk7LS1yAiXdM4gp/o/fSx04K1XNPlqN5XMcmYRMDY2Mc
	 wjvi6nFqCshcKL3DO0XIkaEjUrzXAd4kWnZ5Ggdjas9TW5Kv4PRWrHx5gkW/bouakH
	 0GcOySJ5ZixeCgnY76pgj7QYEKDxye5JqIW/CYep+OxgJseZk2/OG08kBLRv0nzYPW
	 z9Dj+zsged8kjobffqpJxdnirB9QbDMNZLuu9PXMEUSmByMtDQh/w1MU+zTse/HeI9
	 wSMuO9RgiORWA==
Date: Tue, 6 May 2025 17:58:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Jeremy Kerr
 <jk@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250506175830.15aefdbb@kernel.org>
In-Reply-To: <20250506160753.GU3339421@horms.kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	<20250506160753.GU3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 17:07:53 +0100 Simon Horman wrote:
> > +	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
> > +		hdr = nlmsg_data(cb->nlh);  
> 
> FWIIW, I think the scope of the declaration of hdr can be reduced to this block.
> (Less positive ease, so to speak.)

We wouldn't be able to sizeof(*hdr) if we move it?

I have a different request :) Matt, once this ends up in net-next
(end of this week) could you refactor it to use nlmsg_payload() ?
It doesn't exist in net but this is exactly why it was added.

