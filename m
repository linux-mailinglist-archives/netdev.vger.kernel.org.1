Return-Path: <netdev+bounces-129875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D7986AED
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 04:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170D51C213F4
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 02:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5FE173320;
	Thu, 26 Sep 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSA+0x9r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B3170A3F
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317617; cv=none; b=oteoTd1xBRPgrlwHA+Gvm4/89hwGW/+BTS+mQ4hN9Nej8dDpdU4YbB9Dw+PiueekLO3E202j4Q+61FPCavVoMb7lzGi6SeBKnKVjiSYZAeV1ECpvfDLGR5D4Xf7DIIWDXJXpSJLootvdZomi00nMXYZBiNKla5mRAJh20A08No4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317617; c=relaxed/simple;
	bh=kvW+FGqxzPIQK8RkZMIDGxlGVr2LgGUxvCIErGdrHa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFQdYJQW4juOj+AHddz8Yt3kS0j7yIxYncYX4sVHTF3PdjntONxXE8bkuGwhpI1735mQHoVZIsqWTf8SNBY5QH0rMXB6QB8hfyZUhryNaNGJ41uWI3b5OB9Y1hiCIivkzktIYmlNnkOQfXLn6PQzJD+IOfgX5g9eacqQEjVf5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSA+0x9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6A6C4CEC3;
	Thu, 26 Sep 2024 02:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727317617;
	bh=kvW+FGqxzPIQK8RkZMIDGxlGVr2LgGUxvCIErGdrHa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BSA+0x9raKQZIh8H+qGYK5eyHhs/9sDbAOrCfQ889fMFDkIPhPn2IXBzaqa1OB9Hf
	 nFja+MJQlaM++r9rPgQ14kwf6sq+4pWCPtUDICT+0y28p0LV9RqTfJ9vLJwMnpl+zR
	 27OTH6/aDik3lK8J1mkHX/g8yy5iDVcbOFjzGmGtDYxLJ5ladB9QVk8uU3vZZEYhWX
	 f+eKh5/SR5kY9F3qfvYahY2nH5ua6VIIvpXG3gsxbZGRx1+353ETm0Q2Zmj3ndqQl/
	 kVk1cw5mcDrRKPCVgsiVIiXLPMlvYUmQ3/sZiYQiQ1KzasGGINOeOSVNg+0yhe+7Aj
	 JFVEwXf0pjuHg==
Message-ID: <814042a4-15e5-4288-a526-37213ddda710@kernel.org>
Date: Wed, 25 Sep 2024 20:26:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: two fixes for qdisc_pkt_len_init()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240924150257.1059524-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 9:02 AM, Eric Dumazet wrote:
> Inspired by one syzbot report.
> 
> At least one qdisc (fq_codel) depends on qdisc_skb_cb(skb)->pkt_len
> having a sane value (not zero)
> 
> With the help of af_packet, syzbot was able to fool qdisc_pkt_len_init()
> to precisely set qdisc_skb_cb(skb)->pkt_len to zero.
> 
> First patch fixes this issue.
> 
> Second one (a separate one to help future bisections) adds
> more sanity check to SKB_GSO_DODGY users.
> 
> Eric Dumazet (2):
>   net: avoid potential underflow in qdisc_pkt_len_init() with UFO
>   net: add more sanity checks to qdisc_pkt_len_init()
> 
>  net/core/dev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

LGTM. For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


