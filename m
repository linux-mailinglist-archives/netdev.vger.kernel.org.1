Return-Path: <netdev+bounces-111221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF63930423
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 08:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC72838A0
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6C1CA94;
	Sat, 13 Jul 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wh+FpMIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1021BF54;
	Sat, 13 Jul 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720853565; cv=none; b=VcacDSuMDbDvm1X8AmAFSDbGR+vl6kpVOpOfo6+xrMxhedCRL6Yc9xvcEKnHl7K8cvhuBMKdBIQ7Vc+QpCt4x9zQZbZcUgp43oaGBLVPKhMdHueeshvn76RUZeGtvs9CCOpxfDmMZkfhqlwxARyl32fnYGijkAB0WFaMbzog0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720853565; c=relaxed/simple;
	bh=k9Fz/brBJXRmkY77OHcvYUwK69ppymwPr/gyiKMhobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc+D+VpKBe5wRdp7Cn5O4nLauQI7qhLh+nyK/geKnQFX2MHbFHUu+BPcKXMsfA1uUcvofS+liPcWdd3BmW4TyPTWqSgk5JeRhwSxmPS0Sksv3xiCEIZe2YbbziPMEXRwK1o6QLBkhkzD4V/fYKNvlAhaln8n6d52dtkWy3tjLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wh+FpMIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DE3C32781;
	Sat, 13 Jul 2024 06:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720853565;
	bh=k9Fz/brBJXRmkY77OHcvYUwK69ppymwPr/gyiKMhobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh+FpMInW8KB+YeUy7oXXOXD6ApMCU4ZAQ+aus/GOWfvFERLzQf/0oKLbG4a4uzOK
	 qS6QLBiSeB/Zb0zSC9EpQzAGDs23fe09dP6mWj/bBi8bP/yUbLM2qa4HTbH+VEsOSR
	 2ig0ggvFLVu7p5zlS6ZFt5N9n/5briROnhWnTaBo=
Date: Sat, 13 Jul 2024 08:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ashwin Kamat <ashwin.kamat@broadcom.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
	yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com, vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH v5.10 0/2] Fix for CVE-2024-36901
Message-ID: <2024071313-even-unpack-9173@gregkh>
References: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>

On Tue, Jul 09, 2024 at 03:52:48PM +0530, Ashwin Kamat wrote:
> From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
> 
> net/ipv6: annotate data-races around cnf.disable_ipv6
>        disable_ipv6 is read locklessly, add appropriate READ_ONCE() and WRITE_ONCE() annotations.
> 
> net/ipv6: prevent NULL dereference in ip6_output()
>        Fix for CVE-2024-36901
> 
> Ashwin Dayanand Kamat (2):
>        net/ipv6: annotate data-races around cnf.disable_ipv6
>        net/ipv6: prevent NULL dereference in ip6_output()
> 
>  net/ipv6/addrconf.c   | 9 +++++----
>  net/ipv6/ip6_input.c  | 2 +-
>  net/ipv6/ip6_output.c | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> --
> 2.7.4
> 

Any reason you didn't actually cc: the stable@vger.kernel.org address
for these so we know to pick them up?

thanks,

greg k-h

