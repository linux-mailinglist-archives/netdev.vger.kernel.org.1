Return-Path: <netdev+bounces-125036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9D96BAE9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6071C20D07
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE21D0149;
	Wed,  4 Sep 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OxJ+mTob"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666561CF5E0
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449815; cv=none; b=cGpYLY2jIlV2yytR1xpuwafJsjlzhdrdsmiQiSDohce8S9vcSikF7F8iTVMIISUmCeXK6rI+YKfHvPkUCW1qPAqIhkQv04T6ZnlUcqM5M3kSCXkW0WUpgwfM0vOi9Cmw3GK2MXOgASPzKACV3sdXNImGJGLUEF1gN2qDyZclGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449815; c=relaxed/simple;
	bh=F8uV22TQSGpCc+W1GVrPnUmh4KZebMl7bCz67+vAeVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2AK9RzHvuBHVVbBs/R9OgaB9Q1OTM4+81JX/9sPFdvG36eA4xAwKx1aM4uX0z3b5X0ETo9o65If2GGIOK95CxjlJeG4MbZq2e0Vr6ToLjCVnGnwZaLOfGScEFRb73w8ZuxeeWx7RR3jkVcxYhY1mQ7S3hgtzCdNiIBcy08zRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OxJ+mTob; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a50a1f2-3b99-4030-9a96-6aecdd2841b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725449811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWcmzEngmLiVH3Ykyh3RHxn5Zb8TLlLZBEcSvnipohI=;
	b=OxJ+mTobiY9r2vcWxmLDDcTyOsYiJi4bYhFw9YVSZo8DMhd9cNPVtttH4Xp0R4XqaoP2Of
	JZsnqmzJRCeg9muLb4fcYBLZnnCVGw8oZgjvZeGMa7umBr1005TRBAraClzzU7tklMtIn7
	cqwiRpVl+pLQ1E9HGxU74rrzF1PGKzY=
Date: Wed, 4 Sep 2024 12:36:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 0/4] Add option to provide OPT_ID value via
 cmsg
To: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240904113153.2196238-1-vadfed@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904113153.2196238-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 12:31, Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg.
> 
> The first patch in the series adds all needed definitions and implements
> the function for UDP sockets. The explicit check of socket's type is not
> added because subsequent patches in the series will add support for other
> types of sockets. The documentation is also included into the first
> patch.
> 
> Patch 2/4 adds support for TCP sockets. This part is simple and straight
> forward.
> 
> Patch 3/4 adds support for RAW sockets. It's a bit tricky because
> sock_tx_timestamp functions has to be refactored to receive full socket
> cookie information to fill in ID. The commit b534dc46c8ae ("net_tstamp:
> add SOF_TIMESTAMPING_OPT_ID_TCP") did the conversion of sk_tsflags to
> u32 but sock_tx_timestamp functions were not converted and still receive
> 16b flags. It wasn't a problem because SOF_TIMESTAMPING_OPT_ID_TCP was
> not checked in these functions, that's why no backporting is needed.
> 
> Patch 4/4 adds selftests for new feature.
> 
> Changelog:
> v2 -> v3:
> - remove SOF_TIMESTAMPING_OPT_ID_CMSG UAPI value and use kernel-internal
>    SOCKCM_FLAG_TS_OPT_ID which uses the highest bit of tsflags.
> - add support for TCP and RAW sockets
> v1 -> v2:
> - add more selftests
> - add documentation for the feature
> - refactor UDP send function
> RFC -> v1:
> - add selftests
> - add SOF_TIMESTAMPING_OPT_ID_CMSG to signal of custom ID provided by
> 	user-space instead of reserving value of 0 for this.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Vadim Fedorenko (4):
>    net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
>    net_tstamp: add SCM_TS_OPT_ID for TCP sockets
>    net_tstamp: add SCM_TS_OPT_ID for RAW sockets
>    selftests: txtimestamp: add SCM_TS_OPT_ID test
> 
>   Documentation/networking/timestamping.rst  | 13 ++++++
>   arch/alpha/include/uapi/asm/socket.h       |  2 +
>   arch/mips/include/uapi/asm/socket.h        |  2 +
>   arch/parisc/include/uapi/asm/socket.h      |  2 +
>   arch/sparc/include/uapi/asm/socket.h       |  2 +
>   include/net/inet_sock.h                    |  4 +-
>   include/net/sock.h                         | 29 +++++++++----
>   include/uapi/asm-generic/socket.h          |  2 +
>   include/uapi/linux/net_tstamp.h            |  7 ++++
>   net/can/raw.c                              |  2 +-
>   net/core/sock.c                            |  9 ++++
>   net/ipv4/ip_output.c                       | 20 ++++++---
>   net/ipv4/raw.c                             |  2 +-
>   net/ipv4/tcp.c                             | 15 ++++---
>   net/ipv6/ip6_output.c                      | 20 ++++++---
>   net/ipv6/raw.c                             |  2 +-
>   net/packet/af_packet.c                     |  6 +--
>   net/socket.c                               |  2 +-
>   tools/include/uapi/asm-generic/socket.h    |  2 +
>   tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>   tools/testing/selftests/net/txtimestamp.sh | 12 +++---
>   21 files changed, 154 insertions(+), 49 deletions(-)
> 
Oh, sorry for the mess, patches:

[PATCH v3 2/3] selftests: txtimestamp: add SCM_TS_OPT_ID test
[PATCH v3 3/3] net_tstamp: add SCM_TS_OPT_ID for TCP sockets

should be ignored.

If it too messy I can resend the series.

Sorry again,
Vadim

