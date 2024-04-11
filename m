Return-Path: <netdev+bounces-87077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C18A1B24
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50F81C20FAB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6719729421;
	Thu, 11 Apr 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ62lVBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436562941B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850728; cv=none; b=XHViBWlyuRGS2vTqxij1LjVjnHlrwmzg9eOCeFH3IMFlsYEeZrEHT7feEdIb/CmyreTVOnF9eZVk+GPMy1xPqxCqIxfIw5dsPzxrzlY0EmfPU2OOgl1lddkCGRnCmT7tORqzq2ieYaaCo8m/5skdkIQ7Oiz2uNjMwbk4gHObLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850728; c=relaxed/simple;
	bh=WXVEMBGsq4Evp3kJVq7V3SFlz2NoKb+9imPHtxiMwIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYtqd7QbpR87nfKX++MyPXORKiiXl7g8lOMSp3YGwZiM7b/X+CCymWfA65v97YK0zETrYgX4wF7uAqmuXox1m11koww9Lirei60xCIAJrjqyFmslr5A735bWhTxl0wPauTzb8p5jqobAWRWe4V7lywRdKmapN9Qp59PtsjdiUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ62lVBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4B4C072AA;
	Thu, 11 Apr 2024 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850727;
	bh=WXVEMBGsq4Evp3kJVq7V3SFlz2NoKb+9imPHtxiMwIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJ62lVByk1wBUz/tl+vEb2YTIy55nBFv5UP+DeyqB5vr5j1M1E9krC0mWjpWnwYSa
	 PiExqjEW4kxdOLgGkiuVXCIbOZIXoF0OQlZQT7iOv8cmE+Bgo/A4hR0lGeXVUSakey
	 KU6mfoCK/bDnh9NlabDJz0IjAt1eytgAkSwjt6HR7W95CuZN0l6/T/++f1oUqEbh4x
	 i8KR3/2G9mddMyj/217XAXZaiqAeWB/ZeNSHLnom1KVgxNkXyL1ALaGfmSHuorS5yf
	 r57ZMWYYbg/+PoMC+WZlBsFFL3WH9ErNnkGM5wZWDbA5uolj9sRfqqK9g6pDVjwOyU
	 gwoN/ulWGJ7JQ==
Date: Thu, 11 Apr 2024 08:52:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>,
 davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, idosch@idosch.org, johannes@sipsolutions.net,
 fw@strlen.de, pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240411085206.1d127414@kernel.org>
In-Reply-To: <b2e7f22c-6da3-4f48-9940-f3cc1aea2af2@ovn.org>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
	<20240319085545.76445a1e@kernel.org>
	<CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
	<20240319104046.203df045@kernel.org>
	<02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
	<20240411081610.71818cfc@kernel.org>
	<b2e7f22c-6da3-4f48-9940-f3cc1aea2af2@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 17:39:20 +0200 Ilya Maximets wrote:
> nlmsg_type=0x1a /* NLMSG_??? */  --> RTM_GETROUTE
> nlmsg_flags=NLM_F_REQUEST|0x300  --> NLM_F_REQUEST|NLM_F_DUMP

Thanks!

Also:

"\x02\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x01\x00\x0a\x01\x01\x02"
 ^^^^

So it's dumping AF_INET. I'm guessing its also going to dump v6,
separately? To fix v4 I think something like this would do (untested):

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 48741352a88a..749baa74eee7 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1050,6 +1050,11 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			e++;
 		}
 	}
+
+	/* Don't let NLM_DONE coalesce into a message, even if it could.
+	 * Some user space expects NLM_DONE in a separate recv().
+	 */
+	err = skb->len;
 out:
 
 	cb->args[1] = e;

