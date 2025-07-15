Return-Path: <netdev+bounces-207038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B34B056C9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C164716CDCF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8363275118;
	Tue, 15 Jul 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agvkIo5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3671DC07D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572281; cv=none; b=bd/QxE+rhbwLDRo/yvfebcznOwDtF/IJxGbfhLUPsWokZ5NpJK/OmPvGmZkot0c41d9ksqfTXnJEA0JFe5ieKKr65aI7KPW2qsFcGKc+NJBIjp6AQqTTYw+JCD3uUEouQ35Ij04se5PQIenYd1XJAOkT/oi0DiSVgZw1krhCAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572281; c=relaxed/simple;
	bh=QNCBtPaTSE5T621Q1/slm5WE9aV/EJ6j6EVIvjDmpKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVaNk5ZU5TthGJdzNW4xz9uvny0FZjhS4nXMSZdnNbv+5NFiC3cDquAZjIPqTcLYGWXUCAITcffaFdlhbbJJ09f+8w6J8/6ulDmupcIimHoy/EpAtJKJJykgEbHKFfWAH9aUFPAVt++tIo8+FT6+rySnQDncfsjVJDPc8BnAIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agvkIo5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
	b=agvkIo5HOu3MdyeH/sTa8928tokufQ25u1Bu/e+hJyeCBnqj2Pdyydgm7pTrCfZNPCMfnR
	EFhK9kElWHxRHosuJot9pzY8f1yiMhtw/VvSvyjXNzjMzfCxoWQ4+x2pigoOCuuWH+STqa
	vx8y5pgN5DyBdyUcefPuT8HH9F5DuvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Nt3p3b4bOHWY1K1x6h4THA-1; Tue, 15 Jul 2025 05:37:57 -0400
X-MC-Unique: Nt3p3b4bOHWY1K1x6h4THA-1
X-Mimecast-MFC-AGG-ID: Nt3p3b4bOHWY1K1x6h4THA_1752572276
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a58939191eso1962067f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572276; x=1753177076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
        b=ZNyUFHXJLIpRMTpyTGH5M3/pw1lcE+t4LV1xhTsosWyeiSu1cE2+SvB/i+tfwjq4R5
         bJjSO39MLktFEmqQudY83syLLdNvg3y0A5xb+4VXqUb0MzAaVh4WuqpwXBqNyl3t0I56
         8YbcNcDf2xoAsMo9ofKJJIHn9iKEWTO9MHzbz205i76hKSrhsZf/mar1XeAzYo2Kerfk
         2DDXqax3C7Qha6db3DwhnAsEB3qmJZ8Nir2FrM6ze5qOaWv2/U2YkFSJMzOaJ1eoUY/C
         hC9QXBZ/8ZhpDaXtsEixEeRpxD7stv2t0Hk69Q/hJ87PaUCSaz8PbvxrImLT1dBJhlX4
         On/A==
X-Forwarded-Encrypted: i=1; AJvYcCVC/JgkKeYwbfqow5m1T7AbSTdco+fmw1h6zeyzu9E+ynnJW1v/M0OYTLHWSjWvZvFoxYzt1JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOLGgwIfX6vdzcN3KD2M/0SvZ5HUd6d00h4n9AR3lYThDCTdG
	TzyeKQR/oRpJfeP2DSXIMkk5m125/8F9iSvPdfZksllrX7C6vjGGX39O36CLTMR8QTZQvU36Typ
	rHYXRnwgfVn5pj+sodreHb3T9cJ3gTPjCz32wItZcAwKOmKykLqunPATrOg==
X-Gm-Gg: ASbGncsLNnV7HDO+QsAG/XLrgl2C13yRzn/C9tytGq4Y3XH4VFaNI6dpAArWlaZeYS2
	v1skb4nw0aJ/cHkBvIumwHHlaKJz1DS8txSw+Dd4XqUrHo5aU/DEeELMfjQ+o8nWw1EG6zc0Rge
	J3f7+JLDvY4qYXgX3AlQzLXAj3+rw0LyRhgmJWgpdW76y5aTCmxiwFNSoKX4aAXA0Neh8kQwxyf
	5zukS0LTJatFO7UFqnl0RHXJ7NpntoZr0vPIPAE5QCapcA5hgOQCQb5ul/UsRUyASb+9EF2bawL
	8icytoD8qJV9xZ+UgCR0FqplGMsr0GC33QJ8hx3PWmx0oGJMLkFWXD0dCHHuvAeV2OIhu9W8NML
	H9Y0pHCIiBR0=
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123160f8f.10.1752572276252;
        Tue, 15 Jul 2025 02:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7rnEyaVNTCq9R6RoKiLyFF22JsBtzv/zE5FdLGKRbnJHy7hamvgRydWCDaxAzMf/pvDQpA==
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123135f8f.10.1752572275741;
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm14923256f8f.14.2025.07.15.02.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Message-ID: <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
Date: Tue, 15 Jul 2025 11:37:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 11:03 AM, Hangbin Liu wrote:
> Add a selftest to verify bonding behavior when lacp_active is set to off.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
>  .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>  create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh

New test should be listed in the relevant makefile
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> new file mode 100755
> index 000000000000..4cf8a5999aaa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing if bond works with lacp_active = off
> +
> +lib_dir=$(dirname "$0")
> +source ${lib_dir}/bond_topo_lacp.sh

shellcheck is not super happy about 'source' usage:

In bond_passive_lacp.sh line 7:
source ${lib_dir}/bond_topo_lacp.sh
^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.

either switch to '. ' or use bash instead of 'sh'.

> +lacp_bond_reset "${c_ns}" "lacp_active off"
> +# make sure the switch state is not expired [A,T,G,S,Ex]
> +if slowwait 15 ip netns exec ${s_ns} grep -q 'port state: 143' /proc/net/bonding/bond0; then

Shellcheck wants double quote everywhere. Since in many cases (all the
blamed ones in this patch) we know the variable is really a single word,
I think you could simply disable the warning with:

#shellcheck disable=SC2086

(same in the other test file)

> +	RET=1
> +else
> +	RET=0
> +fi

/P


