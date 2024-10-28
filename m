Return-Path: <netdev+bounces-139483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90799B2C7D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839528194C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3381D363D;
	Mon, 28 Oct 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b5QHTaPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7411CF2AB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110390; cv=none; b=SV4jcqYHcqewBkyFB+MW8SL3TcJ6hC3+CPXBvL0wluUOScIxeRqv5l0elQnnIdwUDVXwRjLUgvrduSs5lZY8DL7YJQ1xTZ5SUxknN9Ai10jOp2tEtrHEOlujDgy+hfJoc2DAXUf/5lIZkOWpPuPZB9jS/sYlmY7Yi60jf2FeYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110390; c=relaxed/simple;
	bh=AV3H95WuR7HgF4Hklt8Oa1y3SpNFAqrinNBZJEI3sJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu96tCkYp21sUVIxaSjGsDWJAHVkCF9UH9T9ncIH5xZDV8iLHBOyfRytJ7rEJz1hWB6qkcHQgRogjLfdsXtQ4LYTH2TJ+L4oXAKscBoRXqgaOQva+3uQ3gn4SSX62WxYUdGRHkzYk7E0VSwA3JvXSijmKsxFZGWNeYp+z1pUtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b5QHTaPd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e13375d3so4571895e87.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730110385; x=1730715185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kTse+UIA/55vueNOi33xp+1Nvpf6FMXtF/RFvE7Aux4=;
        b=b5QHTaPdKSKA/dDsnth1Xr5n7leH6WQBCer3hmfL5/kSJUp/3LFHpPne0203mKYfPy
         dsks+82zeK89FdjdKjvD4hfL7lj+WHxFU1YYQIU7viVBuWJ1mVnrokFhPgQTM5rqX2Z0
         rO+10z2K+4t6DDcTKjBVBPvPG2Fm6EXn7iWDkiA51b/KfkdGWFIVO8FflGgWe0TkjcWy
         6i3rQd8pfjAtDqUeXnNb9E3JcdXX210Vv4dl5HNx///6FM72g+2uk94loBKG8svNPHaJ
         F+sLAUUYYMDN+8u1YleiLVn3G5MU4MewJzesCJnPLpzdnachuy/ka3D6K2rRU6Z+lAhG
         n42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110385; x=1730715185;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTse+UIA/55vueNOi33xp+1Nvpf6FMXtF/RFvE7Aux4=;
        b=xDCZOieUeQfI0JyvmYfFli1miTsO7FQcQ2X9scUbO1wjOdSLlhQbQJdBwNdLNqAZuz
         h9797v+BuxjExOWPclr3i1AM8RQcNnU7uOAPTL5Q+uCUB8JE1mzAaM2Fwu9RhrYkgbRm
         BQM/7b/Ctn+5CJ1KpZgNftleBJ7khiRGr/cHi1tl3yT04t7ZHf5rdSW/EQwEIS3N6whf
         Soj3ul++4Xf/Ky7WNBrhZ+dbPqWXp1w073T+/hHz2T1Cf4Hyjdcgpt9A/OaPz+U5ZKx7
         sgvfJjfvHFQa6lSm4p5XvoE1vq6riGDOON28F9dfjp5xnM/C4MkVF4e4VKvu5vzH/pDY
         Qzmg==
X-Gm-Message-State: AOJu0YyrI2jljTrKxuTXHJun/JJo1jv0xVm60qP30QcBGx5iY5RimF+R
	KidqUu1SLeHTKtNQ0E6QnmvqBpww94CYYazmCKwf+2+jycJ5QjruAaJi9/n/g9rSew927YP6eMo
	c
X-Google-Smtp-Source: AGHT+IF1okyvZaKXse++KL2wEvd3Z6/OhR++/wqVVcCM7ZvtJyoTyPLnGArGk0C4r0iTm+16yUgihQ==
X-Received: by 2002:a05:6512:12d1:b0:539:fcba:cc6d with SMTP id 2adb3069b0e04-53b34a19019mr2673820e87.42.1730110384195;
        Mon, 28 Oct 2024 03:13:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e302:b53c:29e9:63b6? ([2001:67c:2fbc:1:e302:b53c:29e9:63b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573d47sm106146525e9.3.2024.10.28.03.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:13:03 -0700 (PDT)
Message-ID: <feef6601-0e68-4913-b305-3be3face4a9e@openvpn.net>
Date: Mon, 28 Oct 2024 11:13:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 23/23] testing/selftests: add test tool and
 scripts for ovpn module
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 sd@queasysnail.net, Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
 <20241025-b4-ovpn-v10-23-b87530777be7@openvpn.net>
 <fe2b641f-a8aa-428c-9f04-f099015e0eb9@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <fe2b641f-a8aa-428c-9f04-f099015e0eb9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2024 01:40, Shuah Khan wrote:
> On 10/25/24 03:14, Antonio Quartulli wrote:
>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>> kernel module.
>>
>> It implements the netlink API and can thus be integrated in any
>> script for more automated testing.
>>
>> Along with the tool, 4 scripts are added that perform basic
>> functionality tests by means of network namespaces.
>>
>> Cc: shuah@kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   MAINTAINERS                                        |    1 +
>>   tools/testing/selftests/Makefile                   |    1 +
>>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>>   tools/testing/selftests/net/ovpn/Makefile          |   17 +
>>   tools/testing/selftests/net/ovpn/config            |   10 +
>>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++ 
>> ++++++++++
>>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>>   tools/testing/selftests/net/ovpn/test.sh           |  183 ++
>>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>>   13 files changed, 2626 insertions(+)
>>
> 
> What does the test output look like? Add that to the change log.

Hi Shuan,

is there any expected output for kselftest scripts?
Right now it just prints a bunch of messages about what is being tested, 
plus the output from `ping` and `iperf`.

My assumption is that the output would be useful in case of failures, to 
understand where and what went wrong.

I can document that, but I am not sure it is truly helpful (?).
What do you think?

Is there any specific output format I should obey to?


[...]


>> +
>> +static void usage(const char *cmd)
>> +{
>> +    fprintf(stderr,
>> +        "Usage %s <command> <iface> [arguments..]\n",
>> +        cmd);
>> +    fprintf(stderr, "where <command> can be one of the following\n\n");
>> +
>> +    fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn 
>> interface\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tmode:\n");
>> +    fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
>> +    fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
>> +
>> +    fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +
>> +    fprintf(stderr,
>> +        "* listen <iface> <lport> <peers_file> [ipv6]: listen for 
>> incoming peer TCP connections\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: TCP port to listen to\n");
>> +    fprintf(stderr,
>> +        "\tpeers_file: file containing one peer per line: Line 
>> format:\n");
>> +    fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
>> +    fprintf(stderr,
>> +        "\tipv6: whether the socket should listen to the IPv6 
>> wildcard address\n");
>> +
>> +    fprintf(stderr,
>> +        "* connect <iface> <peer_id> <raddr> <rport> [key_file]: 
>> start connecting peer of TCP-based VPN session\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
>> +    fprintf(stderr, "\traddr: peer IP address to connect to\n");
>> +    fprintf(stderr, "\trport: peer TCP port to connect to\n");
>> +    fprintf(stderr,
>> +        "\tkey_file: file containing the symmetric key for 
>> encryption\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_peer <iface> <peer_id> <lport> <raddr> <rport> 
>> [vpnaddr]: add new peer\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID to be used in data packets to/from this 
>> peer\n");
>> +    fprintf(stderr, "\traddr: peer IP address\n");
>> +    fprintf(stderr, "\trport: peer UDP port\n");
>> +    fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_multi_peer <iface> <lport> <peers_file>: add multiple 
>> peers as listed in the file\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>> +    fprintf(stderr,
>> +        "\tpeers_file: text file containing one peer per line. Line 
>> format:\n");
>> +    fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
>> +
>> +    fprintf(stderr,
>> +        "* set_peer <iface> <peer_id> <keepalive_interval> 
>> <keepalive_timeout>: set peer attributes\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +    fprintf(stderr,
>> +        "\tkeepalive_interval: interval for sending ping messages\n");
>> +    fprintf(stderr,
>> +        "\tkeepalive_timeout: time after which a peer is timed out\n");
>> +
>> +    fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to delete\n");
>> +
>> +    fprintf(stderr, "* get_peer <iface> [peer_id]: retrieve peer(s) 
>> status\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID of the peer to query. All peers are 
>> returned if omitted\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_key <iface> <peer_id> <slot> <key_id> <cipher> 
>> <key_dir> <key_file>: set data channel key\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID of the peer to configure the key for\n");
>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>> +    fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
>> +    fprintf(stderr,
>> +        "\tcipher: cipher to use, supported: aes (AES-GCM), 
>> chachapoly (CHACHA20POLY1305)\n");
>> +    fprintf(stderr,
>> +        "\tkey_dir: key direction, must 0 on one host and 1 on the 
>> other\n");
>> +    fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
>> +
>> +    fprintf(stderr,
>> +        "* del_key <iface> <peer_id> [slot]: erase existing data 
>> channel key\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +    fprintf(stderr, "\tslot: slot to erase. PRIMARY if omitted\n");
>> +
>> +    fprintf(stderr,
>> +        "* get_key <iface> <peer_id> <slot>: retrieve non sensible 
>> key data\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to query\n");
>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>> +
>> +    fprintf(stderr,
>> +        "* swap_keys <iface> <peer_id>: swap content of primary and 
>> secondary key slots\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +
>> +    fprintf(stderr,
>> +        "* listen_mcast: listen to ovpn netlink multicast messages\n");
>> +}
> 
> If this test is run from "make kselftest" as default run does this usage
> output show up in the report?

No.
This usage is only printed when invoking ovpn-cli with wrong arguments 
and this can't be the case in the kselftest.


Other than documenting the output, do you think there is any other 
critical part to be adjusted in this patch?

Thanks a lot for your time and patience.

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.


