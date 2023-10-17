Return-Path: <netdev+bounces-41954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9E7CC6DC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F021C20BA5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1C44460;
	Tue, 17 Oct 2023 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ULBpVbHl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85D405C8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:57:58 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1A2366E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:57:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8C01F37C;
	Tue, 17 Oct 2023 14:57:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8C01F37C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1697554676; bh=9dz7qLoNvtDhASUW/qPVLsB36MpW7OBQ4hurrrMfmpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ULBpVbHltJ2z/DRuVx3OEKLhsKMJbZ08q7mLyI8f2SR5fnUdDHr4Zi39nO+LHYAov
	 93LC4j91sRkzMxBQj1H1u6M6s+KYXR5CVFiejuH/JUo52vENW7AD6UmKeegdTD7ykc
	 nQF2w04TODOerHLw8+IkPYwrjUl190m/g3bLM4kTEJ2qiI/SbM8UoZGe2IBvKfoWjO
	 /jHJAqGCxP6IaXDBX4gd03z1pg9Jf6rwKsDl1SKJXuJ/DhWSuhw/IoEjbh7dzoIseY
	 wJUSvgexZ6kxRoE1k1XgjH20qAbt4e9H0n6SKcDYo2dLZBxw1704RDk3kKui4yZcy7
	 MSl1ypx2Txj6w==
From: Jonathan Corbet <corbet@lwn.net>
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang
 <weiwan@google.com>, Coco Li <lixiaoyan@google.com>
Subject: Re: [PATCH v2 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
In-Reply-To: <20231017014716.3944813-2-lixiaoyan@google.com>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-2-lixiaoyan@google.com>
Date: Tue, 17 Oct 2023 08:57:55 -0600
Message-ID: <87y1g1b8jw.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Coco Li <lixiaoyan@google.com> writes:

> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
>
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionaly. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
>
> We hope to re-organizing variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
>
> Optimized_cacheline field is computed as
> (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> results (see patches to come for these).
>
> Note that the optimization is not cache line size dependent, we use
> x86 as an example of improvements.
>
> Investigation is done on 6.5
>
> Name	                Struct_Cachelines  Cur_fastpath_cache Fastpath_Bytes Optimized_cacheline
> tcp_sock	        42 (2664 Bytes)	   12   		396		8
> net_device	        39 (2240 bytes)	   12			234		4
> inet_sock	        15 (960 bytes)	   14			922		14
> Inet_connection_sock	22 (1368 bytes)	   18			1166		18
> Netns_ipv4 (sysctls)	12 (768 bytes)     4			77		2
> linux_mib	        16 (1060)	   6			104		2
>
> Note how there isn't much improvement space for inet_sock and
> Inet_connection_sock because sk and icsk_inet respective take up so
> much of the struct that rest of the variables become a small portion of
> the struct size.
>
> So, we decided to reorganize tcp_sock, net_device, Netns_ipv4, linux_mib
>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../net_cachelines/inet_connection_sock.rst   |  42 +++++
>  .../networking/net_cachelines/inet_sock.rst   |  37 ++++
>  .../networking/net_cachelines/net_device.rst  | 167 ++++++++++++++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst      | 151 ++++++++++++++++
>  .../networking/net_cachelines/snmp.rst        | 128 ++++++++++++++
>  .../networking/net_cachelines/tcp_sock.rst    | 148 ++++++++++++++++

So none of this changelog tells us anything about this documentation you
are adding or what readers are supposed to gain from it.  What are these
files?

What they are *not* is RST; you clearly have not tried a documentation
build with these files in place.  I would say that needs to be fixed,
but I do wonder if this kind of information (to the extent that I
understand what it is) isn't better placed in the source itself?  If
nothing else, I would expect it to have a somewhat higher chance of
staying current that way.

Thanks,

jon

