Return-Path: <netdev+bounces-180627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1AA81E63
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0071710D7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C7425A2CA;
	Wed,  9 Apr 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="WLeJBQWm"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155C1586C8
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184193; cv=none; b=QkFBK6so8/NqH4o3rERH8Q2yCBriuypGbpako9loVbad+bvdkBxUpjjRt2+F6rlEHLuZQ729HvFPQs8ywwgbrrcJLNvmPvXFXuAkn6OJVW2PTSLLZOAH8CcBwTlMLxnA5QR6nWLXsJ5hc4AJ7sqRTKZmXgrCQcY7D1dRnQsDyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184193; c=relaxed/simple;
	bh=mTcntJCXNQyKC43n6lTEnr+mojMoJoo/tSAnFYaJRMw=;
	h=Content-Type:References:Cc:Mime-Version:In-Reply-To:From:
	 Message-Id:Date:To:Subject; b=L94eH6zwiY27BNdJiXVsabbCYDP8tP8W0onCg6ij19lOG2ljT07qqg6j5ZTNiDZeMGe7WG2kZaRHhPtzvwrSTSgC54eU+z21y3L+9NYG+BwOsS8bNE7aj2J7JA2pkynUN8ueV8zL4ATnn2fVBsjSOqGRXfqQSXr/oCOhZnBN8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=WLeJBQWm; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744184171; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3iVMT74G1AQ55Rx0Yx0C4mM4H1FAM4+gVCqKvkq30Ds=;
 b=WLeJBQWmXH4WBxRrj4DXPFFRVjiF/6zfSexs8IwgaGTkl4RVlkAKp3eg9RG+HJJRoOCKrR
 Et2bRdcrQOAt1dv8D6VfO4T0h7hV7txaF3RGmIQ4bOJ6J8S29IRAMBlyVqzx31bYGd4BoU
 bFwoyIt1BFP6XR5PhyHHaoc3NoTyO6JOQ9lhzMvyZcL/03nUFjadKnIySf0GVPjOGl7XTu
 3FyZUvwT4BEvtZIwYAkcqr0qIqO7+TjCOHbX0Ki6muMVLPr/gdGUjf5cnUqyjN8hR6Rvry
 rVUxMPKSE2Rm4lA/E9C4ytnDMoBh/kq3PHl4WI93OH1eEMb2KKD5oxMk8UaIbQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Wed, 09 Apr 2025 15:36:08 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151517.1376756-13-tianx@yunsilicon.com> <20250326101727.GA892515@horms.kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>, 
	<geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250326101727.GA892515@horms.kernel.org>
X-Lms-Return-Path: <lba+267f62369+a12eda+vger.kernel.org+tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <ad1566da-1e2e-4bf4-b741-f2e484f4b490@yunsilicon.com>
Date: Wed, 9 Apr 2025 15:36:05 +0800
To: "Simon Horman" <horms@kernel.org>
Subject: Re: [PATCH net-next v9 12/14] xsc: Add ndo_start_xmit

On 2025/3/26 18:17, Simon Horman wrote:
> On Tue, Mar 18, 2025 at 11:15:19PM +0800, Xin Tian wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
> ...
>
>> +netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev)
>> +{
>> +	struct xsc_adapter *adapter = netdev_priv(netdev);
>> +	int ds_num = adapter->xdev->caps.send_ds_num;
> Hi Xin Tian,
>
> adapter and adapter->xdev are dereferenced here...
>
>> +	struct xsc_tx_wqe *wqe;
>> +	struct xsc_sq *sq;
>> +	u16 pi;
>> +
>> +	if (!adapter ||
>> +	    !adapter->xdev ||
> ... but it is assumed here that both adapter and adapter->xdev may be NULL.
>
> This seems inconsistent.
>
> I haven't looked but I do wonder if adapter or adapter-xdev can be NULL in
> practice?. If not, the checks above can be dropped. If so, then ds_num
> should be assigned after these checks.
>
> Flagged by Smatch.

It can't be NULL, I'll drop the checks

Thanks

>> +	    adapter->status != XSCALE_ETH_DRIVER_OK)
>> +		return NETDEV_TX_BUSY;
>> +
>> +	sq = adapter->txq2sq[skb_get_queue_mapping(skb)];
>> +	if (unlikely(!sq))
>> +		return NETDEV_TX_BUSY;
>> +
>> +	wqe = xsc_sq_fetch_wqe(sq, ds_num * XSC_SEND_WQE_DS, &pi);
>> +
>> +	return xsc_eth_xmit_frame(skb, sq, wqe, pi);
>> +}
> ...

