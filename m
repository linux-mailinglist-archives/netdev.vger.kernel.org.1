Return-Path: <netdev+bounces-161772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E7A23E36
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F46F7A1EF5
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722C1C4A0A;
	Fri, 31 Jan 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XWS5uL4R"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F11DFF0
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329201; cv=none; b=kA786QoCBnsbqHP4CJbEUthSXTbh8t8XdI8N1Pk3MeV/OpAdrsBJ6u8CDFSOSQ1fsidyYDn8o0AhSnWBNfKVMgNpgjka2TIC1zi2UvnxWpS4XJ68XYgiWT//DMlBG8w/g7gAAZFrxDDqEgGMT/3hWbOs9sYR3F4lik2DWjnbyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329201; c=relaxed/simple;
	bh=k5RkkXzF13rZXSL9io3ekPgEPUw+PXfJpxELXTQUpY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOT20+X2MHgwQ4wcWE4Xsytbe29GfCAeE94GXS2F85DW4pUn3K+P9s6lcRDrXRXWOBzoZzTc2RkD75a5nV+qPrfbQI/6FoRuBQGzN79UoFPR6GLk+8EuwnO2KalY5kTab2q+qdLlxK+rNPQ+GMo4p7B+srwnUivYyGe8FsrLsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XWS5uL4R; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250131131309faf71448f22149c4f9
        for <netdev@vger.kernel.org>;
        Fri, 31 Jan 2025 14:13:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7ddmw+MSH+bE+lpmVD4Wnv3gYJ4CsT3P6TUawXH7hJk=;
 b=XWS5uL4RZBFQEOgbrkoinobFHaphy8O+5E+P3yGXLd7XDgQnHjyupzHw/nFjHHjoFdTGf8
 mvcNlRBNYG8wW8IswCiNjHTMgAeNTd32AjpAXjStl8fyMt6y0rmFi/Yztz3oayTTUZiOqW3a
 sQaxSTerPXPAzJLqFHYAVUGkM8zHd3MPwWKw6SUnzJqfKdUeo9bHmdirmf4oOL/0OiGPXbER
 LJi8XzNCm80kQsfkobrEsJKbXnCXlQOD0N9Au9jkV92M0qC6kNZQPoxrc11wtPjGcoN+mHl5
 8Erb2wyxszaDR5KHq87NIv6bd1IyNXl4K6+BYuiaKdarLvOVMgfCkBEw==;
Message-ID: <f86bc94c97d6e91b3564d3df6f91722318c8d24f.camel@siemens.com>
Subject: Re: [PATCH] igc: Fix HW RX timestamp when passed by ZC XDP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Song Yoong Siang <yoong.siang.song@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jan Kiszka
	 <jan.kiszka@siemens.com>
Date: Fri, 31 Jan 2025 14:13:08 +0100
In-Reply-To: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
References: 
	<20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2025-01-28 at 13:26 +0100, Zdenek Bouska wrote:
> Fixes HW RX timestamp in the following scenario:
> - AF_PACKET socket with enabled HW RX timestamps is created
> - AF_XDP socket with enabled zero copy is created
> - frame is forwarded to the BPF program, where the timestamp should
>   still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
>   behind bpf_xdp_metadata_rx_timestamp())
> - the frame got XDP_PASS from BPF program, redirecting to the stack
> - AF_PACKET socket receives the frame with HW RX timestamp
>=20
> Moves the skb timestamp setting from igc_dispatch_skb_zc() to
> igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
> igc_construct_skb().
>=20
> This issue can also be reproduced by running:
>  # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
> When a frame with the wrong port 9092 (instead of 9091) is used:
>  # echo -n xdp | nc -u -q1 192.168.10.9 9092
> then the RX timestamp is missing and xdp_hw_metadata prints:
>  skb hwtstamp is not found!
>=20
> With this fix or when copy mode is used:
>  # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
> then RX timestamp is found and xdp_hw_metadata prints:
>  found skb hwtstamp =3D 1736509937.852786132
>=20
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> ---

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

