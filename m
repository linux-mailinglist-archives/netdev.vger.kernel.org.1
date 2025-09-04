Return-Path: <netdev+bounces-219947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03EB43D4F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8245A0778
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA5302779;
	Thu,  4 Sep 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjUR3bN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E914AA9;
	Thu,  4 Sep 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992826; cv=none; b=Dn1xMqbfHyaq9XGYal8WfKkYJOe+ktmGsn+zlfTGS9GZ9V7tqusUl68qCqDgMFgpgsVyz2+1TkZqiSK13POP20roizjpFf3Tl5ZWL8mgHidhSKIPc3EqEKIVHd4gWcl3Tz5yTX6ofOeVQnkoWIRqhUCk/CTwnfQQJcGhYqpxG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992826; c=relaxed/simple;
	bh=IMrYv7oCWbvt2UCstOYiVv3rbLBEMMRYsIR7L60yWAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn2dRtzQAeltE6QjEF3AKOJwF+4V+tMHoV4SPzcDjfzKB42f3SvI2xmjwqC2dNnNM14lMrlo7LyvcfpqmjBqFh2BG+P39t3phMtlIUU3SnOsMUHHorx1ZxIKiz/G3UumXatLTCC6F70oQn+IOziBeedkjtTsDr8DAaziQkHU2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjUR3bN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859BFC4CEF1;
	Thu,  4 Sep 2025 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756992826;
	bh=IMrYv7oCWbvt2UCstOYiVv3rbLBEMMRYsIR7L60yWAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CjUR3bN5FT9/qEnxJEpHPRU8z+99Z3ngzVNrm9qravPaE9OikalYlpwDz7Y6jBkk+
	 en0nRX3QyMcCTred+t+EXJqefDfh6+pOme99YUpexNbJgrg962DMkt0NPs7XEgLOmi
	 B8TP8DF4zdtQZEF2Kgv61T+JheiiQO+OJyy3Szg+3pdjYgN4g+8nkdkHYEUdjXO9Tn
	 9vcZywAOJAo/vIGEAxx8VqYQD7PDViij2OyqbQogmYHglmoGQOxW95l61zsaKepQX9
	 KsYARWRlmVbxZ/BnZ4KcergjKEqmN7FfQa6R+10HcaG8sPW57AFZ6a/ZCzz1MjNfZN
	 ZTrgTX3vEgrEA==
Date: Thu, 4 Sep 2025 06:33:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 alistair.francis@wdc.com, dlemoal@kernel.org, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Message-ID: <20250904063344.6507fcc6@kernel.org>
In-Reply-To: <aLllqGpa2gLVNRbw@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
	<aLllqGpa2gLVNRbw@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 12:10:48 +0200 Sabrina Dubroca wrote:
> If we set tx_record_size_limit to TLS_MAX_PAYLOAD_SIZE+1, we'll end up
> sending a record with a plaintext of TLS_MAX_PAYLOAD_SIZE+2 bytes
> (TLS_MAX_PAYLOAD_SIZE+1 of payload, then 1B of content_type), and a
> "normal" implementation will reject the record since it's too big
> (ktls does that in net/tls/tls_sw.c:tls_rx_msg_size).
> 
> So we should subtract 1 from the userspace-provided value for 1.3, and
> then add it back in getsockopt/tls_get_info.
> 
> Or maybe userspace should provide the desired payload limit, instead
> of the raw record_size_limit it got from the extension (ie, do -1 when
> needed before calling the setsockopt). Then we should rename this
> "tx_payload_size_limit" (and adjust the docs) to make it clear it's
> not the raw record_size_limit.
> 
> The "tx_payload_size_limit" approach is maybe a little bit simpler
> (not having to add/subtract 1 in a few places - I think userspace
> would only have to do it in one place).
> 
> 
> Wilfred, Jakub, what do you think?

I reckon either way is fine, assuming we clearly document the behavior.
I'd lean slightly to using the same definition of the setsockopt as the
RFC, it may be confusing but if it ever interacts with other settings
it may make it easier to refer to other RFCs.

