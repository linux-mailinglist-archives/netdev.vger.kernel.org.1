Return-Path: <netdev+bounces-206911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19987B04C87
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37BD7ADB85
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA8239567;
	Mon, 14 Jul 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+evtysO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E5367;
	Mon, 14 Jul 2025 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536786; cv=none; b=DtNssmqmADDIdE5IXIHJ2BN27tcZ7bAJ3MCYfFdEPFn2RF9p7h/R0+v3ktc3Egmb/I1kih1QHIhPBSUEvFdZzrOytUPoIjEjv1dqpKeXAvRHpwixpRTLIh2JfsCWJYKn5EFj/Al7M2qutRAD3NjeowcG8/SXDVztz5Rg8j29SNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536786; c=relaxed/simple;
	bh=gkzrKeuYhn6WyF4dG4lf+r1H4tUF4Ef69EciCVClaTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbdt7TUBRAZQAsTSZa27N6RqTgkpKgxNSUPeVlSWnLNdcmNFtOt8l23xY+dv+SIwc2Roxgpi0XpJH6WjzzWH3dyC41ERmZZjAzYPCXBtF6myq9nfddsASoEmt/WMRi6mZxt8EIFZA//KABz58+YCzPQpXyNYYB+/H9qF2gYIVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+evtysO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB22C4CEED;
	Mon, 14 Jul 2025 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752536786;
	bh=gkzrKeuYhn6WyF4dG4lf+r1H4tUF4Ef69EciCVClaTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+evtysOQGd69ioWv6yqlm0LYX5pe1DpGB+vCYv5+/fcGsenngcaHogLRUp3fX7//
	 xGwbwDqH79m5FyOwoAdInoAiieeULE7Pq8Pb3H5g2FVqtETIch1hi4Ke88Df4K9R4P
	 ZkTzrCNDLMmhcZcPAtICpRq9U30cbaZkWylQjLYvGoPrJwFDwaGBZhDWh+fnDlqy57
	 Fsu2S2JSAJZebbt2iD7Elp8ds8jTVBvbqHOmDcLsUjiraRhsrCyVgubv6c/G9IqehR
	 Jw2gMRvKw1NJQkPbnuUdxp1xNunFX84ZOUXoLNVFsNn/iTLFlso2Rk6OdYUCkv5KI1
	 +HAiVQLUIQxsg==
Date: Mon, 14 Jul 2025 16:46:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <fan.yu9@zte.com.cn>
Cc: <edumazet@google.com>, <kuniyu@amazon.com>, <ncardwell@google.com>,
 <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>,
 <jiang.kun2@zte.com.cn>
Subject: Re: [PATCH net-next v4] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
Message-ID: <20250714164625.788f7044@kernel.org>
In-Reply-To: <20250710100138588y-Q-MXtJiwV7aVn_cY0pb@zte.com.cn>
References: <20250710100138588y-Q-MXtJiwV7aVn_cY0pb@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 10:01:38 +0800 (CST) fan.yu9@zte.com.cn wrote:
> Background
> ==========
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, sequence errors, or routing issues).
> 
> The original tcp_retransmit_skb tracepoint:
> 'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
> lacks visibility into these failure causes, making production
> diagnostics difficult.
> 
> Solution
> ========
> Adds a "result" field to the tcp_retransmit_skb tracepoint,
> enumerating with explicit failure cases:
> TCP_RETRANS_ERR_DEFAULT (retransmit terminate unexpectedly)
> TCP_RETRANS_IN_HOST_QUEUE (packet still queued in driver)
> TCP_RETRANS_END_SEQ_ERROR (invalid end sequence)
> TCP_RETRANS_NOMEM (retransmit no memory)
> TCP_RETRANS_ROUTE_FAIL (routing failure)
> TCP_RETRANS_RCV_ZERO_WINDOW (closed receiver window)

Have you tried to use this or perform some analysis of which of these
reasons actually make sense to add? I'd venture a guess that
IN_HOST_QUEUE will dominate in datacenter. Maybe RCV_ZERO_WINDOW
can happen. Tracing ENOMEM is a waste of time, so is this:

 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
            >>>>>	WARN_ON_ONCE(1);  <<<<<<<<
-			return -EINVAL;
+			result = TCP_RETRANS_END_SEQ_ERROR;
-- 
pw-bot: cr

