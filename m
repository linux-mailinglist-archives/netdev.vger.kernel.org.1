Return-Path: <netdev+bounces-109079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA02926D38
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B7A1F223DD
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB0C2ED;
	Thu,  4 Jul 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm5Zuh5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB7746E
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057805; cv=none; b=NUGtkwgNUQnRdLt1ajiSw9VxnlV73UVZLfLhmlFBGqF/dKkxVCL9ZGLFw2qv6wWi4U0EgAnRTTjkxE/z12TxK9uwMZAdpaPnN3zZkxFLN6FTCY7uMdsNvdlsq28WCB69sXtzpBTVYlHiXHGrUjoRWPGbSEW5w1aZzO+1/bcIVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057805; c=relaxed/simple;
	bh=nvqeSAYCCkBaHb0hj7LhtO6pgKRB/ANEcnd/GmhdxFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNbSl463N46HH9MedLDv/RzA5rNi9Sa2rjD1AjSvl8JUuo3utk3Z01x/r33iLKRlz8sBzjY6hKdzHm8BueSzJBpbBwoA7BlIXjMlDDXX3SLm+GDMhJlqWD5lShY96A3YnFDNcZml7D7Niu85yTADvgRkcNiMoblPkVQgiXV7hfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm5Zuh5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F9BC2BD10;
	Thu,  4 Jul 2024 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720057804;
	bh=nvqeSAYCCkBaHb0hj7LhtO6pgKRB/ANEcnd/GmhdxFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zm5Zuh5ubveRHyVc2G4Gxy34xCvPpCNAKd3ajf99oAX58nP+98PlZ4HvVgm6xt2Xq
	 NMchGxvQT1b1gT+5DS5oPRb3AQu9150N/bmufpKtpafVUC/93OLnhgtwIwpvqsM2Ty
	 gmP+RJQSD+C93U20bHw7L+BJ/8t/ABWybYjNesbrelUj0ArKYSc/1ccWqxyeO/exSS
	 EM7EUv9QF5O/Hs3vplD2uVsse6R0b+w54jLqeJTC125mc+O7hySohGq3PAn0NfQfWb
	 aUXhbCjga0XczO6aWsvWRNIiq6AIzqaAz9oM8DZm0kXt5qMEhLzgJak2wugCiJuFYv
	 ZooFPCJQPz/6Q==
Date: Wed, 3 Jul 2024 18:50:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
Subject: Re: [PATCH net 1/2] selftests: fix OOM in msg_zerocopy selftest
Message-ID: <20240703185003.6f11ff73@kernel.org>
In-Reply-To: <20240701225349.3395580-2-zijianzhang@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
	<20240701225349.3395580-2-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 22:53:48 +0000 zijianzhang@bytedance.com wrote:
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, as the introduction of commit
> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
> always writable and does not get any chance to run recv notifications.
> The selftest always exits with OUT_OF_MEMORY because the memory used by
> opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
> different value to trigger OOM on older kernels too.

This test doesn't fail in netdev CI. Is the problem fix in net-next
somehow? Or the "always exits with OUT_OF_MEMORY" is an exaggerations?
(TBH I'm not even sure what it means to "exit with OUT_OF_MEMORY" in
this context.)

TAP version 13
1..1
# timeout set to 3600
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=164425 (10260 MB) txc=0 zc=n
# rx=59526 (10260 MB)
# ipv4 tcp -z -t 1
# tx=111332 (6947 MB) txc=111332 zc=n
# rx=55245 (6947 MB)
# ok
# ipv6 tcp -t 1
# tx=168140 (10492 MB) txc=0 zc=n
# rx=64633 (10492 MB)
# ipv6 tcp -z -t 1
# tx=108388 (6763 MB) txc=108388 zc=n
# rx=54146 (6763 MB)
# ok
# ipv4 udp -t 1
# tx=173970 (10856 MB) txc=0 zc=n
# rx=173936 (10854 MB)
# ipv4 udp -z -t 1
# tx=117728 (7346 MB) txc=117728 zc=n
# rx=117703 (7345 MB)
# ok
# ipv6 udp -t 1
# tx=225502 (14072 MB) txc=0 zc=n
# rx=225502 (14072 MB)
# ipv6 udp -z -t 1
# tx=111215 (6940 MB) txc=111215 zc=n
# rx=111212 (6940 MB)
# ok
# OK. All tests passed
ok 1 selftests: net: msg_zerocopy.sh

