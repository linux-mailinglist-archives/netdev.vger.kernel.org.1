Return-Path: <netdev+bounces-169551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1186A448B1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8256886E36
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8B19E998;
	Tue, 25 Feb 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmWP05Xu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117118C91F
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504725; cv=none; b=HGzBvJUK8OL4uXDjXUS5bjDioHqOhgcOnjlCpQknAaK3AlJ8aUlkCi7h/9X+xFSr0ad18lMglF69a0TKuQVOdERTlPQSWgNIY8k/eQy9+bmc7oGl5FnLh8WJzZ6htU8qSRBBIThJF3e5d43Q06o7xBzIAPCwC90jpofGQ6oaqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504725; c=relaxed/simple;
	bh=LlsxapL7zz/UY2W32nnrlFbGV8Jz0hmZdlyZFk67JUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihDm8XDiwxlxX1UiuYN6v+BzTpWd/qZfDdSv3/emy32NydIjAOI5oSjPU8P0zm1H+Rduuf4T+jiKGMljqJKyQhC94Bg2AXHsNaypyu8qdDddtJ6pDkYihrphAfdq2NIyIwI0V6ohyLUjmbkgijX0zk45PcvmQlEg9C+kryqPJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmWP05Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78047C4CEDD;
	Tue, 25 Feb 2025 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740504724;
	bh=LlsxapL7zz/UY2W32nnrlFbGV8Jz0hmZdlyZFk67JUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hmWP05XuQR9dODIzhR4acarx1/+zBAanwF8tvkrq9Rs1IZ/6t4ul4L4X7Ty+9dWkD
	 sFa9Znuw3pgkU+3zDKrheKD7AwRqBMi59X2+Rzfc29QnImL3VXXfkwoEHVVWjQcuf7
	 RFmC1hnck2Fv0fzxSxfnTPZ98DKzqUE6BqTXg2lHpYfpp6gZjaWHhadJPA7jMnNXLn
	 KHxbNzga5vWpfIJqAWX6Bc0XNaAsll5K/YlfkCKW7CfH1lFeVSno/hzVf8dV6VwEvb
	 3wCNbZI+JJqDPNe3zCQlTBefb86sPC3AnKA5Gr+4H8+luO91pVDA8HBSExop4xcMK8
	 GOijhlAjvurfw==
Message-ID: <8e05636a-0214-4009-a751-3ed355b5e7f7@kernel.org>
Date: Tue, 25 Feb 2025 18:31:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net-next] tcp: be less liberal in TSEcr received while
 in SYN_RECV state
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Yong-Hao Zou <yonghaoz1994@gmail.com>
References: <20250225171048.3105061-1-edumazet@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250225171048.3105061-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 25/02/2025 18:10, Eric Dumazet wrote:
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
> 
> As hinted by an old comment in tcp_check_req(),
> we can check the TSEcr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
> 
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
> 
> Send a challenge ACK if we receive a TSEcr outside
> of this range, and increase a new SNMP counter.
> 
> nstat -az | grep TSEcrRejected
> TcpExtTSEcrRejected            0                  0.0
> 
> Due to TCP fastopen implementation, do not apply yet these checks
> for fastopen flows.
> 
> v2: No longer use req->num_timeout, but treq->snt_tsval_first
>     to detect when first SYNACK is prepared. This means
>     we make sure to not send an initial zero TSval.
>     Make sure MPTCP and TCP selftests are passing.
>     Change MIB name to TcpExtTSEcrRejected

Thank you for the v2, and for having ran the MPTCP selftests!

And sorry if my previous replies on the v1 felt like I was rushing you
to send a v2, that was absolutely not my intension!

The v2 looks good to me, just a small detail in the doc. Apart from that:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

(...)

> diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
> index 90ca2d92547d44fa5b4d28cb9d00820662c3f0fd..bc96efc92cf5b888c1e441412c78f3974be1f587 100644
> --- a/Documentation/networking/net_cachelines/snmp.rst
> +++ b/Documentation/networking/net_cachelines/snmp.rst
> @@ -36,6 +36,7 @@ unsigned_long  LINUX_MIB_TIMEWAITRECYCLED
>  unsigned_long  LINUX_MIB_TIMEWAITKILLED
>  unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
>  unsigned_long  LINUX_MIB_PAWSESTABREJECTED
> +unsigned_long  LINUX_MIB_TSECR_REJECTED

Small detail, I guess it should be without the extra underscore:
LINUX_MIB_TSECRREJECTED.

>  unsigned_long  LINUX_MIB_DELAYEDACKLOST
>  unsigned_long  LINUX_MIB_LISTENOVERFLOWS
>  unsigned_long  LINUX_MIB_LISTENDROPS
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


