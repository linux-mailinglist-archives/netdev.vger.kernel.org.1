Return-Path: <netdev+bounces-30940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC178A046
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1111C2090B
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387E1118F;
	Sun, 27 Aug 2023 16:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058961118E
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 16:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5152BC433C7;
	Sun, 27 Aug 2023 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693155120;
	bh=imSs2XferJA73h3vINrF+HzStQS61RyL8uEnCojilXI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nTaq0L7/iOs62foaNFUNzqfAHCYqGAslVHze+JdUD7Zs5RNX7lLKzSE3B7EuwsvQL
	 PXKOjPvM75tI7srA9pu+eK0vSEoXaiHVMrTu77Kc9+gZIXT9x2B1AtoHQvZKBGgTp2
	 1Qcu4YqpO5KX0J+WNZLWXeaRkLPiTrmIqyqjIH3ffR7IGNDVOUUENE4R6IhVEe1KXg
	 TuureuLD6hgCLSD/rsMkQDXt/nCj+qZXkuNoiUJH34YpkII3aXvvXttPDN6O+hK46A
	 FrVVEt7PBzZ2CTYTcwrrTQKaDbd3Uw9heVmVpN6RdVgBSikdRpR+XN/cPiK8KPhL+W
	 NGTnRSyusxrdA==
Message-ID: <b82afbaf-c548-5b7e-8853-12c3e6a8f757@kernel.org>
Date: Sun, 27 Aug 2023 10:51:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: High Cpu load when run smartdns : __ipv6_dev_get_saddr
Content-Language: en-US
To: Martin Zaharinov <micron10@gmail.com>, netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>
References: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/23 7:20 AM, Martin Zaharinov wrote:
> Hi Eric 
> 
> 
> i need you help to find is this bug or no.
> 
> I talk with smartdns team and try to research in his code but for the moment not found ..
> 
> test system have 5k ppp users on pppoe device
> 
> after run smartdns  
> 
> service got to 100% load 
> 
> in normal case when run other 2 type of dns server (isc bind or knot ) all is fine .
> 
> but when run smartdns  see perf : 
> 
> 
>  PerfTop:    4223 irqs/sec  kernel:96.9%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles],  (target_pid: 1208268)
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>     28.48%  [kernel]        [k] __ipv6_dev_get_saddr
>     12.31%  [kernel]        [k] l3mdev_master_ifindex_rcu
>      6.63%  [pppoe]         [k] pppoe_rcv
>      3.82%  [kernel]        [k] ipv6_dev_get_saddr
>      2.07%  [kernel]        [k] __dev_queue_xmit

Can you post stack traces for the top 5 symbols?

What is the packet rate when the above is taken?

4,223 irqs/sec is not much of a load; can you add some details on the
hardware and networking setup (e.g., l3mdev reference suggests you are
using VRF)?

