Return-Path: <netdev+bounces-139882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF19B4844
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947911F22622
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99A192598;
	Tue, 29 Oct 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opo5ntqs"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EB1EF0B7
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201431; cv=none; b=HQvu0FPjTEkKxBMUxwhjcSwtp+A3wTNQH6AveCB2quH0Yggt7+S5scrxU9KHvZDm5V4WSu8WpIHR4LD9Fc+XNlna0aZ2ro55WvG7ispWfLOalUCLAUEabQCWAwNwijU9qOsFccJIvTDiKWFbBMBHvG9S9gyuEtj/G5KRdb90aSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201431; c=relaxed/simple;
	bh=ZJWIOaODwIfc/DttkrsPEXQKTwuWHVM2VjAiuA13IIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSgmM4ODmNUu63bYWxLKL3AHLrAxXbrq9EpFtc3YA6hQMV32SO8imdLOrt56a2vJ/FwQrX1DjETlntQ6+BYahjuAav4P8GrvBi6kujlbJrCy2EK0HCI06n/DPXN4TqtLwSNdWwifgFf2xIJlLwv+UIvB2trL1KXe5KCJBIFyH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opo5ntqs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8899c12f-bc2f-49d3-bded-e838ac18fef8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730201427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnPiSIzYx1HHGDGVnrngZ9mBvsB94BIHWT4QM52rRrM=;
	b=opo5ntqsA8rr6ubL3xvniGK9UObixzdsM+/2sqePNDeiRZPc/roalwOphgW0PwWipbSQfi
	Oh72XIPwiRbf31ILLkk16qo64TyZicotgGiN7R/D/xeaCxCLyTHZ1FpGMFgt8utXVkO6X4
	P1AgBMDxwvbDC7It1PGCtzQQYSzFAng=
Date: Tue, 29 Oct 2024 11:30:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/2] ptp: add control over HW timestamp latch
 point
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com
References: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/10/2024 20:47, Arkadiusz Kubalewski wrote:
> HW support of PTP/timesync solutions in network PHY chips can be
> achieved with two different approaches, the timestamp maybe latched
> either in the beginning or after the Start of Frame Delimiter (SFD) [1].
> 
> Allow ptp device drivers to provide user with control over the timestamp
> latch point.
> 
> [1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf

I just wonder should we add ethtool interface to control this feature.
As we are adding it for phy devices, it's good idea to have a way to
control it through eth device too. WDYT?

