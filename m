Return-Path: <netdev+bounces-43314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1492D7D250A
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 19:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF0C1C208A7
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0610952;
	Sun, 22 Oct 2023 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVZvQdXv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBFCA71
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 17:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC802C433C7;
	Sun, 22 Oct 2023 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697997054;
	bh=a7bhSUEACARdlq+uMxJTYxwH4vFhfS8krMiwwfiEKSE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uVZvQdXvjKYi6AzOm1BWXPZChWwTpjAO2Q98PUveYzLzJTehfW/4eSjrAY97EcIH8
	 /rC4gT6u2sUK62SKS8PTy7TvYrQ+NReci0UwTlHQzNe5gir3J5WphZDYl5ICNvsYfg
	 CvcxNV1xfZA1RG5OlbEGf9QxtaGB0s9jxqnYQgv/iiWge8em318oaRNncDK93jiORP
	 kb7bYrbGJFbOljYZI2qm2ZaEY9S3a4pJ5PMD6MO99d7j0aWPghpOcsa1XyQ7H5jUql
	 jyAby27BeHzkn9XRhfDNUvvwz/dQZYHJoUgOLmEhWZihxk8q5bcYcVY2Quc37ZpwNS
	 ImoDGXT6vpHyw==
Message-ID: <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
Date: Sun, 22 Oct 2023 11:50:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:net change ifconfig with ip command
Content-Language: en-US
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/23 5:31 AM, Swarup Laxman Kotiaklapudi wrote:
> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
> index 116bfeab72fa..3ab9beb4462c 100755
> --- a/tools/testing/selftests/net/route_localnet.sh
> +++ b/tools/testing/selftests/net/route_localnet.sh
> @@ -18,8 +18,10 @@ setup() {
>      ip route del 127.0.0.0/8 dev lo table local
>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>  
> -    ifconfig veth0 127.25.3.4/24 up
> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
> +    ip a add 127.25.3.4/24 dev veth0

ip addr add ...

> +    ip link set dev veth0 up
> +    ip netns exec "${PEER_NS}" ip a add 127.25.3.14/24 dev veth1

ip addr add ...

> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>  
>      ip route flush cache
>      ip netns exec "${PEER_NS}" ip route flush cache


