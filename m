Return-Path: <netdev+bounces-87157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438218A1E4C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D88288052
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0D127E17;
	Thu, 11 Apr 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLOQ7JV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6983BBC2
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858595; cv=none; b=kHcg6nS26msDegdZ58FAnC0uOxqhONSyzJoypoMgjLIYqJcxnB76ZZii7XvXNBl69exnBh6Q+SQ6Lu8TlwN3c5A3pab5xKb40GroYDQHf+8ypoaIu6CVFkIVToy3deN2HfhUDaxf1lkW7DdqR8yCTUutdqBSo3woaNiNyucClM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858595; c=relaxed/simple;
	bh=ESyS+zpIk0ubNX7rAGt8jXV6WTbsdJ2HW3iDvtjetjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6ia7i5Mq0if2bB8piGXSff6iWY+WZlcGICxAC2JB4V5L5hubQwVepZvMl7UutKNLuG2FNoajjt0pkCH4VJz1V5HAng7zu3gbuzPHbCRYu0UEkZci/ftwGn1oml6TDM54x77gRDLvnm+wSd//7gm8rq/s0pYFB9ly3Nda+AdyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLOQ7JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D91C072AA;
	Thu, 11 Apr 2024 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858595;
	bh=ESyS+zpIk0ubNX7rAGt8jXV6WTbsdJ2HW3iDvtjetjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DyLOQ7JVCn3m8e5ZRc89MCpqQSVxUDS4Wr5ELxS0RjJvFNUmvcmoMtUW8iTgKiyNf
	 Peh49mY8WoiLI6FQY/+g5wZcBO9QiAjiDEQGOkFvDIgaQbGjH5n0FtLoTPDAMjXzyO
	 n0K0hBgSW6xD/PoAWV58VNFB5ReamF1+E+kIFyehQp9DT+GcfxrTWFGEXL4kaEUINv
	 W3dwXhUjoZ+ssrg5rYga96ySlp3eSttuf2gc+GnGnd0XjRBrLM+enTxGs5ikAfORt4
	 RkBuN2BSO6RJsCX6Bq5HTqi0Gk9BDBfWWx2j12zc4U26FM9i/bemNgXZKgIB8QMRd+
	 fWZ6S84q1LGbA==
Date: Thu, 11 Apr 2024 11:03:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>,
 davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, idosch@idosch.org, johannes@sipsolutions.net,
 fw@strlen.de, pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240411110313.245b321c@kernel.org>
In-Reply-To: <6a561c3b-02dd-485a-aff0-04f1e347adf0@ovn.org>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
	<20240319085545.76445a1e@kernel.org>
	<CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
	<20240319104046.203df045@kernel.org>
	<02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
	<20240411081610.71818cfc@kernel.org>
	<b2e7f22c-6da3-4f48-9940-f3cc1aea2af2@ovn.org>
	<20240411085206.1d127414@kernel.org>
	<6a561c3b-02dd-485a-aff0-04f1e347adf0@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 18:38:19 +0200 Ilya Maximets wrote:
> I tried that and IPv4 tests with Libreswan are passing with this change
> on latest net-next/main.
> 
> IPv6 tests are stuck in the same way as IPv4 did before.  The sendto
> as captured by strace is following:
> 
> sendto(7, [
>   {
>     nlmsg_len=48, nlmsg_type=0x1a /* NLMSG_??? */,
>     nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=0, nlmsg_pid=17084
>   },
>   "\x0a\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x00\x01\x00\xfd\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x02"], 48, 0, NULL, 0) = 48
> 
> NLMSG_DONE is part of the first recvfrom and the process is stuck
> waiting for something from the second one.

Perfect, thank you! I just sent the v4 fix,
just to be clear you were testing on -next right?
Because AFAICT the v6 change hasn't made it to Linus.

