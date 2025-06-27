Return-Path: <netdev+bounces-201968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01EAEBA49
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479AE1895236
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCEF156F3C;
	Fri, 27 Jun 2025 14:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63B27FB31;
	Fri, 27 Jun 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035657; cv=none; b=YcWAIwP6O+fIF6FJzOCZ6FhvtNwxE2BA1Cj5C/tYyr68jizijE9L5Nd1pZk6rhLpIF55FXSBd8uTUDXZSftbC+0eIMiH4xV0EU9TbAJM3120Upky4YH+ukeB7/GvovK+GKPTWA9q222EEBwb9fDLPvig9Lq2LMByOuGrwuVf6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035657; c=relaxed/simple;
	bh=F1W/DiN3Su/MEYlLYa53aHYIKiU6GRCUMsTepHB/HAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXPwppg3JZ5v8zr+Pjhd6u/XV7eF0XK5TuIxM339fp7/0of+TwjLSsG+t9IWp15MqTloDxWunxwGMBvTBJxW/0Yg86D2pgqUbhj1YtdwkHDZ3VSC87GVBIBarOUOOKlcPgC1M4/qtatfH5xZmdagQyehTBFQr5KRMyiT4jATcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 15011468A6;
	Fri, 27 Jun 2025 16:47:27 +0200 (CEST)
Date: Fri, 27 Jun 2025 16:47:26 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: add `do_forwarding` sysctl to enable per-interface
 forwarding
Message-ID: <hx3lbafvwebj7u7eqh4zz72gu6r7y6dn2il7vepylecvvrkeeh@hybyi2oizwuj>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625142607.828873-1-g.goller@proxmox.com>
 <f674f8ac-8c4a-4c1c-9704-31a3116b56d6@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f674f8ac-8c4a-4c1c-9704-31a3116b56d6@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 26.06.2025 16:51, Nicolas Dichtel wrote:
>Le 25/06/2025 à 16:26, Gabriel Goller a écrit :
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `do_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the do_forwarding flag is active and forward the
>> packet. To preserver backwards-compatibility also reset the flag on all
>> interfaces when setting the global forwarding flag to 0.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>Please, export this sysctl via a NETCONFA_DO_FORWARDING attribute also.

Yep, will do.

>> ---
>>
>> * I don't have any hard feelings about the naming, Nicolas Dichtel
>>   proposed `fwd_per_iface` but I think `do_forwarding` is a better fit.
>What about force_forwarding?

I Agree!

>> * I'm also not sure about the reset when setting the global forwarding
>>   flag; don't know if I did that right. Feedback is welcome!
>It seems correct to me.
>
>> * Thanks for the help!
>Maybe you could align ipv6.all.do_forwarding on ipv4.all.forwarding, ie setting
>all existing ipv6.*.do_forwarding.
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/devinet.c#n2423

Also done!

>Regards,
>Nicolas

Sent a new patch just now, thanks for reviewing!


