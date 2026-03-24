Return-Path: <netdev+bounces-271251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBPuAuTgwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:07:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4D31B332
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAA983006B08
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547B371D09;
	Tue, 24 Mar 2026 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ0osLDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33932C0F84
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379233; cv=none; b=axBjBJjtgpCkc6YdQnK+cAlEcNTGy9ScMcg8b+/J8TElcBtGZLv/hE9o9c1WnMmIwWk/tu6zbgEPFdkFE1vULw5gr7Z7kgiDKXw4gcZ3E8+BPhxdmlwvMLRhlyIXA2jVhMruDqsvbaFsJpCqhDcbRM4txkf8NuwiWtVkb21aqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379233; c=relaxed/simple;
	bh=AW1OlEhSS59XAz0xTMa+6MUUg+iZ6+WPjBax3z5pQ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jn7EcWKTFiFlqgwOqYzb7oEvp6szPOS/Q4JRiPkifekYzvENKpzjwWDL+h1Zit5s9Sh10OnomDPEPTBT2MOP+K3t+/XQU4zn229/2DZPcwjZhpyikmlSEASEV13ZhVd/BYozOqIxo4N7yItsxaNEoxt4KOrHZ0YVRUew+l5H+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ0osLDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A0C19424;
	Tue, 24 Mar 2026 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379233;
	bh=AW1OlEhSS59XAz0xTMa+6MUUg+iZ6+WPjBax3z5pQ2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jQ0osLDS58/jZGZXdKes/JUpPFmIHJUrTMH365fnO4UsZ9RTw9HVslrWx0LAwE6Q7
	 xAdkGe77ixS6ZD5xRrVCTPgWOXwDGpIrn0rR/eFAMkHegWiejekEMW3qJFpP4V8yvT
	 qsVHbUy7HVXjHfWKtHIRnY7GxHbjjRLmrk1aa90XLpC0Ln1noO5OdSlg3+vljs4HbF
	 zIT68zS2STz2xPJUxCVLVAQq/Qu4jXmhqZ3ycLh1bTY6e7rRO6QdV8JNrDF1heezph
	 opI7YWtqPjo0kOZerfOX89Fnq9Y3Cw4IlaStTQtapB16ESStD9qBEao0SrwfrEGt6v
	 GtFrkfthgOfnQ==
Message-ID: <317fc769-8492-4358-81bb-e21a001a6beb@kernel.org>
Date: Tue, 24 Mar 2026 13:07:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] vrf: Use dst_dev_put() instead of using
 loopback device
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260324155521.525292-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271251-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACC4D31B332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 9:55 AM, Ido Schimmel wrote:
> Use dst_dev_put() to clean up the device referenced by the dst entry
> instead of partially open coding it. Internally, the helper uses the
> blackhole device instead of the loopback device.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



