Return-Path: <netdev+bounces-194353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B1AC8D3C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154DB4E6169
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160B22A811;
	Fri, 30 May 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JPTQ4/y2"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52948224AFE
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606199; cv=none; b=ZImMgeC2KHZ2xuszS+r5pSjqQwMTRJCo6+znXs8KDB7XGojJrE6SYp8cNSOeeOq/hJnzbXmf8VFoTcAtq3S+dJUmmcuC3cJX6VrI13npb9m/Sp+0lnOy9U+qgRFDZU9i+0zVvmo9It0CPxZDvA2S4tlpJpnUR6GpKZKipz2D0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606199; c=relaxed/simple;
	bh=TgIyGIIOuLpJxK/0mNRaPvdDf1D8N2z4h+Hm2SzufqU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=Hstq4e4rhHuPvy9RNdlhNdPdn4ro3APsloOO9bREVYhg4Wi8PeTQ6mD/7SaMWbGRaXcc13PVbKwpSbofDqqDu0alZEdf5IMsYPyGAK0K9rA0CpXzZj4eXU5GTiHW234Yf+JTn0TdCpzUAdkBF8tE2UWcE1PV4zFzeOJIbU8KS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JPTQ4/y2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250530115635euoutp01b103f877b3ef7e3e06fbc6da1430617c~ETBIDnNJw1023410234euoutp01R
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 11:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250530115635euoutp01b103f877b3ef7e3e06fbc6da1430617c~ETBIDnNJw1023410234euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748606195;
	bh=TgIyGIIOuLpJxK/0mNRaPvdDf1D8N2z4h+Hm2SzufqU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=JPTQ4/y2PuLMNh6igXoJ0WI8Ybyy6IirYc2wCbexf3QyQmgdCbUly1NT77wTNWn+N
	 xWcELr4XlzPccrDdJ70b1SOxSu4AKyUay7V2HZhx7czk6T2QtHcI2p0ZO4sTgFHcj2
	 W45v5zp71Sqy9TJWoqOQV/zAMhNG+lTZBvqclbNw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Reply-To: e.kubanski@partner.samsung.com
Sender: Eryk Kubanski <e.kubanski@partner.samsung.com>
From: Eryk Kubanski <e.kubanski@partner.samsung.com>
To: Eryk Kubanski <e.kubanski@partner.samsung.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com"
	<magnus.karlsson@intel.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250530115635eucms1p43454c8aa2f2215d2b86bc41ee9d1085e@eucms1p4>
Date: Fri, 30 May 2025 13:56:35 +0200
X-CMS-MailID: 20250530115635eucms1p43454c8aa2f2215d2b86bc41ee9d1085e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
	<CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p4>

It seems that CI tests have failed:

First test_progs failure (test_progs-aarch64-gcc-14):
#610/3 xdp_adjust_tail/xdp_adjust_tail_grow2
...
test_xdp_adjust_tail_grow2:FAIL:case-128 retval unexpected case-128 retval: actual 1 != expected 3
test_xdp_adjust_tail_grow2:FAIL:case-128 data_size_out unexpected case-128 data_size_out: actual 128 != expected 3520
test_xdp_adjust_tail_grow2:FAIL:case-128-data cnt unexpected case-128-data cnt: actual 0 != expected 3392
test_xdp_adjust_tail_grow2:FAIL:case-128-data data_size_out unexpected case-128-data data_size_out: actual 128 != expected 3520
...
#620 xdp_do_redirect
...
test_max_pkt_size:FAIL:prog_run_max_size unexpected error: -22 (errno 22)

But Im not sure why?

My changes impact only AF_XDP generic_xmit functions, these bpf tests don't touch
AF_XDP sockets xmit path. Changes should impact only sendmsg socket syscall.
Most of changes are Translation Unit local to xsk module.
The only thing i think could impact that is skb_shared_info, but why?

xsk tests didn't fail. Could you help me figure it out?
Should I be worried? Maybe tests are broken?

