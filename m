Return-Path: <netdev+bounces-162073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B7A25B16
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE563A2A5F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B97205514;
	Mon,  3 Feb 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="B/QOxKdR"
X-Original-To: netdev@vger.kernel.org
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1A1FC118;
	Mon,  3 Feb 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589867; cv=none; b=XC//actGse8UFmVQU+ef6/0qGnkRZBEOeBQ7BAgtM1fuVXaaEcWqWh5WUVxW5acnW8DaRSmpAm87J31q4B8sM0OER5VNBV7abXqCEk0hJ8Yf+6JqeIlXZ2UtP0cLhDFZv6ig3lmmQWTi95pZbJi/HO0HY5KP7jIk+Yjm96jKbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589867; c=relaxed/simple;
	bh=3LIrkUdgYIoDB6lJmGD+AQagBFms03gV3QNsqrM1pCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swxvSWguY+AwZZhnVRYIBzKUSOMznjx8LnXjr3O9D7teEKbxgkNGgoVaANqXNpTfazs7ZIq37gvGDUbSYtcBe1E8gcS+CpGWekat5XdxzVpjRiLpZIr6TmwJ+PsMnPX83TyAK+l7MyMh/6VClmc25kywfA5dLbaeRrUsKUbpGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=B/QOxKdR; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1738589350; bh=3LIrkUdgYIoDB6lJmGD+AQagBFms03gV3QNsqrM1pCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/QOxKdR8TDxjFpYyrzIjE5MMzNoOQ8mZwxfABIUonwmh27B7AagH/V8BMr0sNv2A
	 1uvkDGos//bP/NP6NIrt8YD3I5J7KSJwK9SqzePgiKrfixHwvQUp/Jsm6E4TzOEbyI
	 rcVY6NocM6EgzUdpC7QFnGYhy+qhkcP9XkDMyVFVL+6h72TJazKTSdIxYiMA4hCQfx
	 r4apiISapEtBWIZudgt10dGZhdUTdtGAUa3SyJE4kBMaVo9Lw6jRpfZtYY8E2Uipfo
	 VIc+7wAQFqNMuKkrvrM7TavzeL/ayduqxkSlhcFuZGubmQPhj6fI59NsKrHRipN4HN
	 AjBwA+vdOksOg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4YmnQY6XSLz1L;
	Mon,  3 Feb 2025 14:29:09 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.7 at mail
Date: Mon, 3 Feb 2025 14:29:08 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Andreas Karis <ak.karis@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org, corbet@lwn.net,
	pshelar@ovn.org, dev@openvswitch.org, i.maximets@ovn.org,
	edumazet@google.com, ovs-dev@openvswitch.org, pabeni@redhat.com,
	kuba@kernel.org
Subject: Re: [PATCH REPOST] docs: networking: Remove VLAN_TAG_PRESENT from
 openvswitch doc
Message-ID: <Z6DEpDT2cFn3pMKR@qmqm.qmqm.pl>
References: <20250203113012.14943-1-ak.karis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203113012.14943-1-ak.karis@gmail.com>

On Mon, Feb 03, 2025 at 12:30:12PM +0100, Andreas Karis wrote:
> Since commit 0c4b2d370514 ("net: remove VLAN_TAG_PRESENT"), the kernel
> no longer uses VLAN_TAG_PRESENT.
> Update the openvswitch documentation which still contained an outdated
> reference to VLAN_TAG_PRESENT.

Hi, it would be best to extend this doc saying that the CFI bit is not
usable in openvswitch (unlike in other parts of kernel).

Nevertheless,
Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

> 
> Signed-off-by: Andreas Karis <ak.karis@gmail.com>
> ---
>  Documentation/networking/openvswitch.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/openvswitch.rst b/Documentation/networking/openvswitch.rst
> index 1a8353dbf1b6..8d2bbcb92286 100644
> --- a/Documentation/networking/openvswitch.rst
> +++ b/Documentation/networking/openvswitch.rst
> @@ -230,9 +230,8 @@ an all-zero-bits vlan and an empty encap attribute, like this::
>      eth(...), eth_type(0x8100), vlan(0), encap()
>  
>  Unlike a TCP packet with source and destination ports 0, an
> -all-zero-bits VLAN TCI is not that rare, so the CFI bit (aka
> -VLAN_TAG_PRESENT inside the kernel) is ordinarily set in a vlan
> -attribute expressly to allow this situation to be distinguished.
> +all-zero-bits VLAN TCI is not that rare, so the CFI bit is ordinarily set
> +in a vlan attribute expressly to allow this situation to be distinguished.
>  Thus, the flow key in this second example unambiguously indicates a
>  missing or malformed VLAN TCI.
>  
> -- 
> 2.48.1
> 

-- 
Micha³ Miros³aw

