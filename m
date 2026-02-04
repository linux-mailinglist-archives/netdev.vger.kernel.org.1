Return-Path: <netdev+bounces-256762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKAnOAp0g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:30:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E450EA3F1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 354C33024A2E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB91428469;
	Wed,  4 Feb 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wso5VrtO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B58427A0B;
	Wed,  4 Feb 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222560; cv=none; b=u1sSIu8a2HzOZHNdrmPUEHELU8NS3PxzLIemSAHZflBHPXZLNkDqSNoaxAzP1THzJh2sETzOmQjJdoQpLRWRQs880h0+Gc/pNWd19gIZsv3wDMXSwfcfvI6ek4zjfpeiUSaVMiG7NN2Mk1eUKFJlg8Qcew6BPrvj17d1w3KhyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222560; c=relaxed/simple;
	bh=PHdKe9D5um0ozJTCETL/kbKdKgp/SZ5nSJbuDhcuh44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2kthZ7AM+zxG7zXw11RiyLx+WruojTbLhsa6sF3rccGnf4urLVEnIIhEm19uhiKOk1kUW3y3+Fo6zCEf3MI2Aq5TkEfT1WIHyG3xvFpRkPm0z0oxTmYzsmTTt4i4/CciP9s3F2nAGPFQSi3VVEosxzJtMqTDK0f24YNBcXwONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wso5VrtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A2AC116C6;
	Wed,  4 Feb 2026 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770222560;
	bh=PHdKe9D5um0ozJTCETL/kbKdKgp/SZ5nSJbuDhcuh44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wso5VrtOhK/lDGxJGVBnZAB7HQbB+bx63bMSEFNdBE7sbvwd93JuA4bDnQF4RmJVf
	 Cfuhme+88RAtw5vrS7SgrIbI4E2e0gM+YA04XVD7UjnbE2V4S29mCetcNdLnfGzifc
	 GibEg20ZNkZsar2IC3+58UvAQa3ZAsBB/9PBEI8tvCv+UIPyHt7hjmnZ/WPcMpW6aX
	 xSYDWDT68TA9ith8jG3aIrzzkOcDA/7YNffXfApwUZsTNwc4pjZ5yb94ht7xMDOVEX
	 lbNlIdnEdedd5dyyeFGamKrb2Oq2cdruSBsFr1LxR0n+1aFvAysuMxm8Zlj0ZCTPbx
	 V7UtqxNm08yCw==
Message-ID: <3d7fd4c1-4519-49b1-88df-5770734e8a72@kernel.org>
Date: Wed, 4 Feb 2026 09:29:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] icmp: fix ip_rt_bug race in icmp_route_lookup
 reverse path
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20260128090523.356953-1-jiayuan.chen@linux.dev>
 <892557d1-9408-40e3-8e79-587713116b93@redhat.com>
 <1cbd0d2e-2002-4685-99eb-97dd8947cf16@kernel.org>
 <985568ea543b05f52c453427a6125200bcff0aaf@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <985568ea543b05f52c453427a6125200bcff0aaf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256762-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E450EA3F1
X-Rspamd-Action: no action

On 2/3/26 7:27 PM, Jiayuan Chen wrote:
> 
> Thanks for the review.
> 
> Paolo, I'll fix it in newer version.
> 
> Regarding David's question about whether the message provides value:
> I think it could still be useful for debugging. If a user's configuration
> change causes ICMP packets to be silently dropped, there's currently no counter
> or indication of what happened. Adding a dedicated counter for this rare race
> condition seems overkill, so a rate-limited warning at least gives some visibility
> into the failure.
> 
> That said, I'm open to dropping the message entirely if you both think silent handling
> is preferred. Let me know and I'll send a new version either way.
> 

no strong opinions.


