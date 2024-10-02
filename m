Return-Path: <netdev+bounces-131386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27A98E61F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A01B21A62
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F7199385;
	Wed,  2 Oct 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6WeMISv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82569197552
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908559; cv=none; b=cPrV4qvbPha7Wfmu2poS5Bo3g2dk7iuPAQxE7TiTV3R7qtpXPgcSjUJ2Q25Hp6ZOMcL+hyly/zJS4uF/JY6kJHvpW+RPAWlCbGI9gtaHdHlRciddh4X9Y30TpVy/9Hpz8utL4OoWqp5tkxeambTuIEp9Y1M0O//GZcVTbr+Ejb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908559; c=relaxed/simple;
	bh=WxYH1xGNU7Nz+moHHTcWGecF/APXDwB67umj+BE9Cgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClfLnbAQ1tswAo35SDneeyh9PvlSS19racdjzISfJdY0YFyVStkir/PMWgamxneAwiJDFsKIF5wbjdeyTPjFGkZYjIJwNI3u/xI8KimH2E6azJrIYmaOfir8KwL0Ee/M+dkEhWu+5H9r3IztuDomssWDXEXlMJlbQt/fWcsFF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6WeMISv; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a367da1f8cso1342925ab.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727908556; x=1728513356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFIZxkdtL7k1sbISnLa6Kx4hkcApKc5Hy0Oh7GKHG40=;
        b=T6WeMISvTC4KZ3ymOPClnctq2Ol3IQdstOz5r6lJfj0icuiUu8XIBBZUmNBFi0xQMN
         h6ayzVg6ooI4da8vFEOsw7EHr3QFla5qzPD1C+/g3w5K0oU0ZreeVrzuVhQazxGx2zr9
         ayJHPnv36sAWV1q/D614xqAg4ftetaqRSA8mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908556; x=1728513356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFIZxkdtL7k1sbISnLa6Kx4hkcApKc5Hy0Oh7GKHG40=;
        b=RHEiZq9JMvDPavjwFrxdb4w66o3fv8Ka+bppFJe86Sy6EhSUQ/5u1uMtnH5BE6xvwn
         Y5OcT8EcT8PAF77eJKWD2nCXzebX+y6JIKZUyvxLU/s61BDpA6YZfW/wTruhSt4+qZ4X
         AFHYnttqWTdFvkVUBCxtbCwenHK+fCL7nvcf56ZUAjyKE4lty917JYcUSbI2FXcpUDIF
         BPg1832Bmg09gGPT127ofQ1OF+4SYhut/SlphnDVi5s5KnEJnwmiMsJyDJUSAeeFFlR6
         sl/lDZ5cw1hmuqYRrx6ITzNUAnpL6/ByLBrUZQ28yHkKE6d4kkRaLYVhSKQOdt918yJU
         Ng0Q==
X-Gm-Message-State: AOJu0YwKI2SGA0bDEKdmJRekGcOnUZu/vYVZ/dr0zdMCRuQMSKuCxQV2
	++m+srxDGvtI4HDSUX1xtOhUfl0QT0VAaiXj7fcJIiEJwY2qubcYlD5mw2Z0+0o=
X-Google-Smtp-Source: AGHT+IGkAFSGSEzn3GSVszgtbu2RR3UmfSKW5v7H0XSd0tddBSdZd3QXhwfgPGbSsTf7ey8uyW4NxQ==
X-Received: by 2002:a05:6e02:1707:b0:3a0:a3f0:ff57 with SMTP id e9e14a558f8ab-3a36592acc9mr51625005ab.15.1727908556541;
        Wed, 02 Oct 2024 15:35:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3709500dasm24745ab.83.2024.10.02.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 15:35:56 -0700 (PDT)
Message-ID: <1bd5d44c-4cbe-4514-99f3-31760e31a7f2@linuxfoundation.org>
Date: Wed, 2 Oct 2024 16:35:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 24/24] testing/selftest: add test tool and
 scripts for ovpn module
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-24-37ceffcffbde@openvpn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002-b4-ovpn-v8-24-37ceffcffbde@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 03:02, Antonio Quartulli wrote:
> The ovpn-cli tool can be compiled and used as selftest for the ovpn
> kernel module.
> 

Does this test load ovpn module before running tests? If so does
it unload the modules after tests are complete?

> It implementes the netlink API and can thus be integrated in any

Spelling - implements

> script for more automated testing.
> 
> Along with the tool, 2 scripts are added that perform basic
> functionality tests by means of network namespaces.
> 
> The scripts can be performed in sequence by running run.sh
> 
> Cc: shuah@kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   MAINTAINERS                                       |    1 +
>   tools/testing/selftests/Makefile                  |    1 +
>   tools/testing/selftests/net/ovpn/.gitignore       |    2 +
>   tools/testing/selftests/net/ovpn/Makefile         |   18 +
>   tools/testing/selftests/net/ovpn/config           |    8 +
>   tools/testing/selftests/net/ovpn/data-test-tcp.sh |    9 +
>   tools/testing/selftests/net/ovpn/data-test.sh     |  153 ++
>   tools/testing/selftests/net/ovpn/data64.key       |    5 +
>   tools/testing/selftests/net/ovpn/float-test.sh    |  118 ++
>   tools/testing/selftests/net/ovpn/ovpn-cli.c       | 1822 +++++++++++++++++++++
>   tools/testing/selftests/net/ovpn/tcp_peers.txt    |    5 +
>   tools/testing/selftests/net/ovpn/udp_peers.txt    |    5 +
>   12 files changed, 2147 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f753060d4e2467a786778ddd4f835861a603ce02..ffd997cc6a1f1fbc5bc954b585bc15ef7bf2486a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17457,6 +17457,7 @@ T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
>   F:	drivers/net/ovpn/
>   F:	include/uapi/linux/ovpn.h
>   F:	Documentation/netlink/spec/ovpn.yaml
> +F:	tools/testing/selftests/net/ovpn/
>   
>   P54 WIRELESS DRIVER
>   M:	Christian Lamparter <chunkeey@googlemail.com>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index b38199965f99014f3e2636fe8d705972f2c0d148..3ae2dd6492ca70d5e317c6e5b4e2560b060e3214 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -68,6 +68,7 @@ TARGETS += net/hsr
>   TARGETS += net/mptcp
>   TARGETS += net/netfilter
>   TARGETS += net/openvswitch
> +TARGETS += net/ovpn
>   TARGETS += net/packetdrill
>   TARGETS += net/rds
>   TARGETS += net/tcp_ao
> diff --git a/tools/testing/selftests/net/ovpn/.gitignore b/tools/testing/selftests/net/ovpn/.gitignore
> new file mode 100644
> index 0000000000000000000000000000000000000000..ee44c081ca7c089933659689303c303a9fa9713b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ovpn/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +ovpn-cli
> diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..65e23eb0ba86d31aa365b08a8c3468dc56a0d1a4
> --- /dev/null
> +++ b/tools/testing/selftests/net/ovpn/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020-2024 OpenVPN, Inc.
> +#
> +CFLAGS = -Wall -I../../../../../usr/include
> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
> +
> +LDFLAGS = -lmbedtls -lmbedcrypto
> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
> +
> +ovpn-cli: ovpn-cli.c
> +	$(CC) -o ovpn-cli ovpn-cli.c $(CFLAGS) $(LDFLAGS)
> +
> +TEST_PROGS = data-test.sh \
> +	data-test-tcp.sh \
> +	float-test.sh
> +TEST_GEN_FILES = ovpn-cli

Can you make sure "make kselftest-install" installs all
of the scripts and executables necessary to run this test?
  
thanks,
-- Shuah

