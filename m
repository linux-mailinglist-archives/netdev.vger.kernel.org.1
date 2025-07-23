Return-Path: <netdev+bounces-209340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894BB0F48F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCC544D56
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186092E92BB;
	Wed, 23 Jul 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luketYE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638A2E92AB
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278710; cv=none; b=rKQsexhocUb6KyNBWoyA9m5P8lR66CKvQY/m+jmiqMI1zOFMNc1VxgYj0vgLVpMUAOKpT8lwO6lrwAtaHKkL/7t4dYBnAvyCDvuxVwM+GYEvBaukqEBUA0/8ZtarnrrhNieQAYYitMLVdq76n8V8Lfz1nmx7PrtgpbSiDsa8rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278710; c=relaxed/simple;
	bh=vWOPeX/41Zq97Zr19D0PoLCtQ23VDnSEerrywNp+kfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sH9KFu4mb0k0jW6IjscnB9PvcMDnHxcjBElqv+D2rr7TqL8rOOzuSr5CDzMcu2nOYTa+JtjFuSfHFTwBbg+CPQx9Crcin6RRCGa03DfYvqQOb8bS5HDV3F/oiKz1psLY1NCtE0+vLD4/gSJ64raa1oNhu62I06T1zpxtSC73FhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luketYE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63EC4CEE7;
	Wed, 23 Jul 2025 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278709;
	bh=vWOPeX/41Zq97Zr19D0PoLCtQ23VDnSEerrywNp+kfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=luketYE3dwEzwCMAKI68cmwgOgqOo3GnlP5Vh76W+qtwD16o6Ltcn900/5Vptq5R2
	 oZhcS/Iq0qdiRZWhIHQHxxkvHh7lbirB2sMrjjdgN/YpxydMjRvobYR700wS9hnxO1
	 YqNghjmYUljGS8p8MbqNK5H0HZRe0lIga6w9SpCTI+51RusDX9C9GE3uj5DUhpjXlf
	 eIIySFSLp3HDE4fTB4XKit6Hzwj26hVp7PEqW8rRhPavcvsrUjSlm9782QqUT2fSo4
	 sKCr0HbOzsXJ3DEoCNy/h5sDMmIOZ6GMTxzMu+/v4mLEq4rYzObyAuTTdukJxY8aIL
	 N9DYka6/Gb8VQ==
Date: Wed, 23 Jul 2025 06:51:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Zigit Zo <zuozhijie@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: virtio_close() stuck on napi_disable_locked()
Message-ID: <20250723065148.1b40c3b8@kernel.org>
In-Reply-To: <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
	<20250722145524.7ae61342@kernel.org>
	<CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 13:14:38 +0800 Jason Wang wrote:
> > It only hits in around 1 in 5 runs.  
> 
> I tried to reproduce this locally but failed. Where can I see the qemu
> command line for the VM?

Please see:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests-on-virtio

