Return-Path: <netdev+bounces-170222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19914A47DCE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0723E3B469E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43619D8A0;
	Thu, 27 Feb 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgLGNO33"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF22556E
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659613; cv=none; b=GOEeodNRxdBibuibsTzV9EztCNIbxpFL3kOvAKJzfpM1Af6PJDEtlKZ3yM0JAyGN9vxd1HRAXBM3FuWZkoFlhZOdOvjgDM1I/YpJXncaar+wbD7SI82tBxrCvXwaZ4zeNfFTuB4NCdLUEyUF2+bV9bx0EQt48yXt+coczvW4k+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659613; c=relaxed/simple;
	bh=UUF3X91+llyZURTHOSpXPepCKrlN8rL/U4WR82VKFD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cjr0lZIbG3CRlfu5sQRg/BsG/+7ICcMX5b470d29X149hj35OMjOhmC0kmAp7gbtnZuwQ40AeE4xPxWByX+ue8HgGBDEjkWLd8SVr2934bG000GqEnerTTp8czdwUTKK5AJNxOd9O1qSMz9l+hJ7xSAzFtj77Z4CTwz2JVU8FKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgLGNO33; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740659611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVZyoIiO2tKVS/DGhefvVf60W+221dDlikQw+QH0D28=;
	b=HgLGNO33cqE069dD0VHzH0SSU5odJLLPWXtKGgq2/Z5o5b4tXl+F9KLiI2Mz8MfWUE9ORT
	gJcaU4K/K6ma5/cmK9EApMyuUkUeopIBvq2wy+iBpQCp88AqFqlmd+Q2lCQH7/okIOiTLW
	UrraCtPk4WkBPagLyk0/kxleM9XVwXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-xTc_OjKfM_q0GvwFnE_mwA-1; Thu, 27 Feb 2025 07:33:29 -0500
X-MC-Unique: xTc_OjKfM_q0GvwFnE_mwA-1
X-Mimecast-MFC-AGG-ID: xTc_OjKfM_q0GvwFnE_mwA_1740659608
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so8560975e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659608; x=1741264408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZyoIiO2tKVS/DGhefvVf60W+221dDlikQw+QH0D28=;
        b=FEz7vNouVF8TFMZYcBzMd/lJ+M/0WoWCGnndmKxQurkikg3agbjGxmdPk5NYTvgbd5
         EUZD9nvYRwrDkWlaBl21uMzAogzAy5JpIElPCfWME09OcFdesWjvObKoS13hWBOW+qb4
         OudKVBaqkW12s89Uw1UdNFYE0ON525xWsuAH8P/UBFxAACUKdfBuOvGUZoAB8n+Dbhh1
         DsLS/iMo5jaqiNCyuZaf/0HsBsJzibelHJlBbWaHYki4Oatfu+ZNHBpSfTodnmh2n43h
         jTh4TZUJ3CoVM0YhKjUJuSNgFeoEGocrbwlmuFAMsBsLOXZKik5MSmZNU9RGFFGofwQW
         508A==
X-Gm-Message-State: AOJu0Yw2xK6ItUeLB+Y0cwR/8NYepi1ow3JMvJKDQqy5p2WC9p/23H/8
	nAqk7b2JUV0B2CS/LE7yQz5AM3oINHys9A26j/yNAZXmp3swV2uRAO6eygtRN+PxIczjIOD5WiM
	29s3L2M8Y82IWazQxi5epHv/dLeiLDh/rliE1YUUq1tafT4+ij+hf+g==
X-Gm-Gg: ASbGncsSkIPIjO3le2h3yp0YAq7KbYFQiTeISzrd5QPlrMky/2WcfWgUuDjViPZdLQd
	MKjke/PJCS39LGNNfWpM1lZJRJOUnIpsE5k97Dt6wwdkF5TWpBXF2wtYK+kb6HqDwumar681mqc
	wD40O2HAPKT+f5qDMCBXsW3JZefgGPnHh3oz3WKaEnEpRI2b8wGbOb8tgnxVTR4ENHATZn6Bx5a
	PU2IGLBjEwUcgpvJQVaNntc5ycJx5uqtjU/6vlbAp2YGAKkB3i9bpXASDjQdsiv4vvsplTUkR8i
	DkD0ZM+mdtVE1awbo+bEODax1k2DC5xGFI3Aec2Q+mV4XA==
X-Received: by 2002:a05:600c:5252:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43b31f2020bmr20299015e9.6.1740659608395;
        Thu, 27 Feb 2025 04:33:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJRVuDkKv1lD+05VcNthhgmdrXrOUOHQ1OuZCCPnpYc58GHcizWC6uipdF3o0/PTnA5BwnYg==
X-Received: by 2002:a05:600c:5252:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43b31f2020bmr20298595e9.6.1740659607556;
        Thu, 27 Feb 2025 04:33:27 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm21170475e9.19.2025.02.27.04.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:33:27 -0800 (PST)
Message-ID: <d1e3d6a6-90b8-45bd-a57f-c8175d0bd906@redhat.com>
Date: Thu, 27 Feb 2025 13:33:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Antonio Quartulli <antonio@mandelbit.com>,
 Ido Schimmel <idosch@idosch.org>
References: <cover.1740493813.git.gnault@redhat.com>
 <a05174174b9fa6a79a9c3ee32e7a5c506d8553aa.1740493813.git.gnault@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a05174174b9fa6a79a9c3ee32e7a5c506d8553aa.1740493813.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 3:43 PM, Guillaume Nault wrote:
> diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
> new file mode 100755
> index 000000000000..85e40b6df55e
> --- /dev/null
> +++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
> @@ -0,0 +1,227 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ERR=4 # Return 4 by default, which is the SKIP code for kselftest
> +PAUSE_ON_FAIL="no"
> +
> +readonly NS0=$(mktemp -u ns0-XXXXXXXX)
> +
> +# Exit the script after having removed the network namespaces it created
> +#
> +# Parameters:
> +#
> +#   * The list of network namespaces to delete before exiting.
> +#
> +exit_cleanup()
> +{
> +	for ns in "$@"; do
> +		ip netns delete "${ns}" 2>/dev/null || true
> +	done
> +
> +	if [ "${ERR}" -eq 4 ]; then
> +		echo "Error: Setting up the testing environment failed." >&2
> +	fi
> +
> +	exit "${ERR}"

I'm sorry for the late feedback, but if you use the helper from lib.sh
you could avoid some code duplication for ns setup and cleanup.

> +}
> +
> +# Create the network namespaces used by the script (NS0)
> +#
> +create_namespaces()
> +{
> +	ip netns add "${NS0}" || exit_cleanup

Also no need to check for failures at this point. If there is no
namespace support most/all selftests will fail badly

> +}
> +
> +# The trap function handler
> +#
> +exit_cleanup_all()
> +{
> +	exit_cleanup "${NS0}"
> +}
> +
> +# Add fake IPv4 and IPv6 networks on the loopback device, to be used as
> +# underlay by future GRE devices.
> +#
> +setup_basenet()
> +{
> +	ip -netns "${NS0}" link set dev lo up
> +	ip -netns "${NS0}" address add dev lo 192.0.2.10/24
> +	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
> +}
> +
> +# Check if network device has an IPv6 link-local address assigned.
> +#
> +# Parameters:
> +#
> +#   * $1: The network device to test
> +#   * $2: An extra regular expression that should be matched (to verify the
> +#         presence of extra attributes)
> +#   * $3: The expected return code from grep (to allow checking the abscence of
> +#         a link-local address)
> +#   * $4: The user visible name for the scenario being tested
> +#
> +check_ipv6_ll_addr()
> +{
> +	local DEV="$1"
> +	local EXTRA_MATCH="$2"
> +	local XRET="$3"
> +	local MSG="$4"
> +	local RET
> +
> +	printf "%-75s  " "${MSG}"
> +
> +	set +e
> +	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
> +	RET=$?
> +	set -e
> +
> +	if [ "${RET}" -eq "${XRET}" ]; then
> +		printf "[ OK ]\n"

You can use check_err / log_test from lib.sh to reduce code duplication
with other tests and more consistent output.

> +	else
> +		ERR=1
> +		printf "[FAIL]\n"
> +		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
> +			printf "\nHit enter to continue, 'q' to quit\n"
> +			read -r a
> +			if [ "$a" = "q" ]; then
> +				exit 1
> +			fi
> +		fi

I guess something like this could be placed into lib.sh, but that would
be net-next material

Thanks,

Paolo


