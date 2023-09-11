Return-Path: <netdev+bounces-32861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EA79A9F4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588DD28134F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2211CA4;
	Mon, 11 Sep 2023 15:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D111C84
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37403C43397;
	Mon, 11 Sep 2023 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694447236;
	bh=Kcnxt2oSKxE8PF0Bms/IhEcPrX11VHNwhQHhZM5nfJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qECviU647sbPuZWP6meJcZ5u6NXdOJ47vesLMwNh5dxECNBCFRzuMOG8d6E57hKUn
	 PqUDig2IzC5b9ve3tMmBJp5759A1mMZhusXlsyk0jnNy4YJUIPIo2Vqbxa50tMmlXP
	 1GpWJESTNJylBjjFCUNv2M/8unyT6mBkiicg8ir0Go/WbODtQRhNjM+Fyb7smS8BXK
	 UplYWJv1CZOG9PmhdyMxxTHLAPmhkYwBaPzFxFVY/CGYts9drPWBrmmR9hv4ifRIm2
	 kV+rI9VxXDdKJlqH6Z4cbvVOcX/xwkGX4z1PAroHi+7PJ5WdKTOod6I5HkvqSirGX8
	 p9LFojpv4LWlA==
Message-ID: <01d3caaa-42b7-58a1-e0e4-7578ecd10d0e@kernel.org>
Date: Mon, 11 Sep 2023 09:47:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: The call trace occurs during the VRF fault injection test
Content-Language: en-US
To: hanhuihui <hanhuihui5@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pablo@netfilter.org" <pablo@netfilter.org>
Cc: "Yanan (Euler)" <yanan@huawei.com>, Caowangbao <caowangbao@huawei.com>,
 "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
 liaichun <liaichun@huawei.com>
References: <1c353f53578e48faa9b254394b42b391@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <1c353f53578e48faa9b254394b42b391@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/23 4:05 AM, hanhuihui wrote:
> Hello, I found a problem in the VRF fault injection test scenario. When the size of the sent data packet exceeds the MTU, the call trace is triggered. The test script and detailed error information are as follows:
> "ip link add name vrf-blue type vrf table 10
> ip link set dev vrf-blue up
> ip route add table 10 unreachable default
> ip link set dev enp4s0 master vrf-blue
> ip address add 192.168.255.250/16 dev enp4s0
> tc qdisc add dev enp4s0 root netem delay 1000ms 500ms
> tc qdisc add dev vrf-blue root netem delay 1000ms 500ms
> ip vrf exec vrf-blue ping "192.168.162.184" -s 6000 -I "enp4s0" -c 3
> tc qdisc del dev "enp4s0" root
> tc qdisc del dev vrf-blue root
> ip address del 192.168.255.250/16 dev enp4s0
> ip link set dev enp4s0 nomaster"
> 

Thanks for the reproducer. I will take a look when I get some time.


