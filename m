Return-Path: <netdev+bounces-234236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB2C1E06E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBA14E1415
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2C1F5847;
	Thu, 30 Oct 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsxxGF3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B91A5B92
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787905; cv=none; b=GLCEIR5At/doROp2iZhpIZGG3QrHq6BJTag0h1PcpMjTez+HNiZ7JAsGDgB/IwC3Ei2YBmdDrlVV3woIo8dqImD/gLrSRjwLl1sk9gv0t1VPuyHXZydlSOjOmHtG8KxZUO8J+gOvVySuTqVqF9U3LIUu5gTJqZ2Wj2vTevHEacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787905; c=relaxed/simple;
	bh=05p+UU6f865M9AorNZxNqh9P/Bx8uoBhGYh4apd4QFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9YAB85oub7Y/mpl/OhgSEDzKjZYWEEndPJtsyXRv74sIc+rRTOZywjbrsTkmK0QjHvr2CdCLABlNvOOPquQoUzRAaIus/SuPYztqPme9cUoYeIOJXmfszNDoKtDpofXwgacXeSGZOwaUBWuv3ITf+iZfBlzSJpToUOqEalH9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsxxGF3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9106C4CEF7;
	Thu, 30 Oct 2025 01:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761787905;
	bh=05p+UU6f865M9AorNZxNqh9P/Bx8uoBhGYh4apd4QFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsxxGF3Qr2vLxmjtAQhM6KNH+Nux1X5rC0tUdFNPjbPRcz3BhmH1YyCs1QFjbjKHv
	 K5HmJieT2RyOUr0iOusJaVFIDfiO3Hr5PWxdIOLGcTK6PIZ0neKDWpGnaZhcJQ/j6d
	 uv4ENVOvRv4ryytC8H37/yQKejiaO4H+NMRa44Lv3MNnllcuXY27wNcgTEa52/+mo4
	 mJIi5azfui3Eiy/zltvQPfJ3tJpKuzRaqcvZOcNJspLVMExqMwYk+sA4ebSHKSux92
	 FOm27g4Leh7wD3TKu+k+2HZ1W/CsfAuidVVaprZvOB6tDxiOD9nuX7q2dqssawbUkk
	 Ile0CO5/J3apg==
Date: Wed, 29 Oct 2025 18:31:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com, Justin
 Iurman <justin.iurman@uliege.be>
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Message-ID: <20251029183143.09afd245@kernel.org>
In-Reply-To: <aQHkY6TsBcNL79rO@shredder>
References: <20251027082232.232571-1-idosch@nvidia.com>
	<20251028180432.7f73ef56@kernel.org>
	<aQHkY6TsBcNL79rO@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 11:54:43 +0200 Ido Schimmel wrote:
> > Is there supposed to be any relation between the ICMP message attrs 
> > and what's provided via IOAM? For interface ID in IOAM we have
> > the ioam6_id attr instead of ifindex.  
> 
> RFC 5837 precedes IOAM and I don't see any references from IOAM to RFC
> 5837. RFC 5837 is pretty clear about the interface index that should be
> provided:
> 
> "The ifIndex of the interface of interest MAY be included. This is the
> 32-bit ifIndex assigned to the interface by the device as specified by
> the Interfaces Group MIB [RFC2863]".

Makes sense, thanks. And we have another 4 weeks to change our mind, 
in case someone from IETF pipes up..

