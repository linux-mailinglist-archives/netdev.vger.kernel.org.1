Return-Path: <netdev+bounces-61276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926858230B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308251F247A7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F31A73F;
	Wed,  3 Jan 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZJwMGwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3C1B26F
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D584C433C7;
	Wed,  3 Jan 2024 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704296543;
	bh=pwnjjV5sqsOfYlxHSfP4v1iAvN3jPc5U7JfLXiD4ms4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZJwMGwuiKnJivCr6R9T4kUMkWHQnS5BX4W+XRtF1LTFzs3dspVcags5l3Jlhv3ON
	 g82t0TQItH6RxwE9mZVdIUSeheQxqts2GTeF+Zp5QvVuYoPaKrci9B2laqbZj8w5X3
	 KHS5mmmeayXaUkv/SaRKo+g6/G81lllGGQHTWMOHl0T1lp3vG1b8sePhQPeKUxfS48
	 hKXWRini3bZJPflVlvRrs9l4jKI02iexMpRC5HZUGvdpywdowOSrwNJAn+Gw3fk015
	 0s4veunbCvQ5ICH3HBAs9fBNf0avSysRWrURcRtQ/6If4qrsAdeW6zIHavmVJ3udWp
	 8pDiQcOJ/nWWA==
Message-ID: <2b3084da-ab85-412d-a0e8-3e50903937df@kernel.org>
Date: Wed, 3 Jan 2024 08:42:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/24 2:48 AM, Nicolas Dichtel wrote:
> @@ -1239,6 +1240,44 @@ kci_test_address_proto()
>  	return $ret
>  }
>  
> +kci_test_enslave_bonding()
> +{
> +	local testns="testns"
> +	local bond="bond123"
> +	local dummy="dummy123"
> +	local ret=0
> +
> +	run_cmd ip netns add "$testns"
> +	if [ $? -ne 0 ]; then
> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
> +		return $ksft_skip
> +	fi
> +
> +	# test native tunnel
> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
> +	run_cmd ip -netns $testns link add dev $dummy type dummy
> +	run_cmd ip -netns $testns link set dev $dummy up
> +	run_cmd ip -netns $testns link set dev $dummy master $bond down
> +	if [ $ret -ne 0 ]; then
> +		end_test "FAIL: enslave an up interface in a bonding"

interface is up, being put as a port on a bond and taken down at the
same time. That does not match this error message.


Thanks for adding test cases. Besides the error message:

Reviewed-by: David Ahern <dsahern@kernel.org>


