Return-Path: <netdev+bounces-230046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBCBE3329
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE04FD998
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D031AF00;
	Thu, 16 Oct 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5+IHYbB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEE31D750
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615737; cv=none; b=RhaM+jKDvGyZO9kebMCkwRHm+Zm94hleBAYQ9uNSvVVBUjYMlycEa8mT5wsVNyFvVW27lbDdaZh8yiZ+IifBiJxtrANn6yKX3NrCni8DALf7Yoz5Jil3v0FSoBZHIOKA73Pn40aao9MRr4lQmGQ+XNgIFCbPJKrhwQ5BqwGIAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615737; c=relaxed/simple;
	bh=hrzBevGI2V8cXk5mM1ZATfIXbjxQDSWKksrIj5K6CpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3qJHL8odPAG41aUHnbEhCkctDuzmqHRWeKDKdhQS6m+7DaJZLGvh1rClPBc4yiTvAy+KuX2Yg2nrpR38JnG3h9F9KK66U26P0iGMH5LKabHY0BMA/a7JB6/KPKNlSDY6xilm2CfOB1d09Q1oNvk6qv8wq+/7aZz24x9cYmD8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5+IHYbB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760615734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSDUFbM8yXxNZBt3wDoru1ZHsWQiovuW9TQzy7dwzjc=;
	b=W5+IHYbBz7qabjuJ9HWrrQyuedmW0cS6NGZS2im1DacAwM0hTYY6j0n8CRvVtk16Gkcdpf
	Hin6gs3tg1KZBdpyxgrZuEcddrg0ksaTLKX+eoZNuq7lawPRlE1JnJ5dh7p4dzJ5FbWpju
	qjdGDJAoOOZMCpK5w3pPYpfmXCFs8EM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-aH4QSmLmOpSjDjz_555w4A-1; Thu, 16 Oct 2025 07:55:33 -0400
X-MC-Unique: aH4QSmLmOpSjDjz_555w4A-1
X-Mimecast-MFC-AGG-ID: aH4QSmLmOpSjDjz_555w4A_1760615732
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so2045625e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615732; x=1761220532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSDUFbM8yXxNZBt3wDoru1ZHsWQiovuW9TQzy7dwzjc=;
        b=qC6e3r1Lx+jGaycU36TFPo9+aR1wl8f8Xmj69DYlIQ6SsYkpEsLqJPdeUzB/sqApl7
         ViaXY7AmzrSyz0ctiVfTp2kV62F2aOBhVeAsN8/I6Z7WtpGqdanhNPZif+HQvg2W+qHn
         r7xMRhwNckveAkxng16bUw9BWAN7U41x20cC85QVllM2k/ZgBvvcRQFwpyCPat60fI5N
         ZjJM5KllrvXmto+YrF2f9SKbWZUybPEYVnn6U7hiZV6w7DlsbqIoFUr/SzxFf+rTEltU
         o3Nj2Vei9Z0o9+gedY3KlKN73xg6Dv4DP5ojzP7WDLr6Nl36UpEFcYrAEkGKfQ1pnLGz
         xjbA==
X-Forwarded-Encrypted: i=1; AJvYcCW6daT8mb+DXCSIb7Wxj7TOnQLlJrUaFOG0AeZzj2yypmfMf7OumLoJNNf0m83xfZ/EzsviL0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbFIQLaTnfQMdDeUUyN6Ve0qw2OE4uHhJ/bALM+j6M5oWcGGA
	oFQCYurVDS8xwAuJ5lSB8APSErR3XFeQWUvvPZFra9/z5tMX+vBAHMWG060uvxa0cngECvNLIDi
	Cx8yq/9MUM1kLrwhsq4gJb5TXSNO08Wakx7YAZ2ifc2iruOOUYm1lnFBWJA==
X-Gm-Gg: ASbGncvq9ItGQrMIORvH4Um6XkmPdeEqrHUiENymohB9rWeXA1FujGde+rJA6BHUyPw
	779O8blj1GelMhMKC7J1Og8bWijR1uRBqDTpI4hileT6K9oNc26t8F3r9IcY8EgP1p3G/viaZB7
	c4tEb2mDXgeLtTQVsqP7I8uujqE6L7s+nxsAPCWD6hGKIUjqbVz2oovkKkCSzySrkAnXXsGXlhK
	lPme3yAw/PFjdidoN69km15HXqneUJxCrsmrZUvA8su2eCyV3yogdlIUNqHn8jFQsCZpACiWGp6
	j0xDHmct3XxnmqQpYCXx3ckcargqtAZ5oFXPS2LUCMNIljuASzV8gbSP66XpgUJn52k/oyVXw4Q
	+ABcvCem5BagZ6kcefPfLDSgxhcMpKY2C17oaMkLOoDEtVtw=
X-Received: by 2002:a05:600c:83c4:b0:471:115e:9605 with SMTP id 5b1f17b1804b1-471115e97femr15548825e9.35.1760615732124;
        Thu, 16 Oct 2025 04:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYQS+Wuzfm2CCDR+is3NYQRs4ImSIzDC37O6I1x1Ld7NV4rpbiuCks0ldhl7YWwsyGtFl19g==
X-Received: by 2002:a05:600c:83c4:b0:471:115e:9605 with SMTP id 5b1f17b1804b1-471115e97femr15548625e9.35.1760615731679;
        Thu, 16 Oct 2025 04:55:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cb36e7csm21235405e9.2.2025.10.16.04.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:55:31 -0700 (PDT)
Message-ID: <f439b8c4-8f2c-49eb-b670-2b2344d3d6ad@redhat.com>
Date: Thu, 16 Oct 2025 13:55:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
 <20251013235328.1289410-8-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013235328.1289410-8-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 1:52 AM, David Wilder wrote:
> +# Build stacked vlans on top of an interface.
> +stack_vlans()
> +{
> +    RET=0
> +    local interface="$1"
> +    local ns=$2
> +    local last="$interface"
> +    local tags="10 20"
> +
> +    if ! ip -n "${ns}" link show "${interface}" > /dev/null; then
> +        RET=1
> +        msg="Failed to create ${interface}"
> +        return 1
> +    fi
> +
> +    if [ "$ns" == "${s_ns}" ]; then host=1; else host=10;fi
> +
> +    for tag in $tags; do
> +        ip -n "${ns}" link add link "$last" name "$last"."$tag" type vlan id "$tag"
> +        ip -n "${ns}" address add 192."$tag".2."$host"/24 dev "$last"."$tag"
> +        ip -n "${ns}" link set up dev "$last"."$tag"
> +        last=$last.$tag
> +    done
> +}
> +
> +wait_for_arp_request()
> +{
> +	local target=$1

The indentation is inconsistent. Please always use a single tab.

> +	local ip
> +	local interface
> +
> +	ip=$(echo "${target}" | awk -F "[" '{print $1}')
> +	interface="$(ip -n "${c_ns}" -br addr show | grep "${ip}" | awk -F @ '{print $1}')"
> +
> +	tc -n "${c_ns}" qdisc add dev "${interface}" clsact
> +	tc -n "${c_ns}" filter add dev "${interface}" ingress protocol arp \
> +                handle 101 flower skip_hw arp_op request arp_tip "${ip}" action pass
> +
> +	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
> +                "dev ${interface} ingress" 101 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
> +
> +	tc -n "${c_ns}" filter del dev "${interface}" ingress
> +	tc -n "${c_ns}" qdisc del dev "${interface}" clsact
> +
> +	if [ "$RET" -ne 0 ]; then
> +		msg="Arp probe not received by ${interface}"
> +		return 1
> +	fi
> +}
> +
> +# Check for link flapping.
> +# First verify the arp requests are being received
> +# by the target.  Then verify that the Link Failure
> +# Counts are not increasing over time.
> +# Arp probes are sent every 100ms, two probes must
> +# be missed to trigger a slave failure. A one second
> +# wait should be sufficient.
> +check_failure_count()
> +{
> +    local bond=$1
> +    local target=$2
> +    local proc_file=/proc/net/bonding/${bond}
> +
> +    wait_for_arp_request "${target}" || return 1
> +
> +    LinkFailureCount1=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
> +            | awk -F: '{ sum += $2 } END { print sum }')
> +    sleep 1
> +    LinkFailureCount2=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
> +            | awk -F: '{ sum += $2 } END { print sum }')
> +
> +    [ "$LinkFailureCount1" != "$LinkFailureCount2" ] && RET=1
> +}
> +
> +setup_bond_topo()
> +{
> +    setup_prepare
> +    setup_wait
> +    stack_vlans bond0 "${s_ns}"
> +    stack_vlans eth0 "${c_ns}"
> +}
> +
> +skip_with_vlan_hints()
> +{
> +    # check if iproute supports arp_ip_target with vlans option.
> +    if ! ip -n "${s_ns}" link add bond2 type bond arp_ip_target 10.0.0.1[10]; then
> +        ip -n "${s_ns}" link del bond2 2> /dev/null
> +        return 0
> +    fi
> +    return 1
> +}
> +
> +no_vlan_hints()
> +{
> +        RET=0
> +        local targets="${c_ip4} ${c_ip4v10} ${c_ip4v20}"
> +        local target
> +        msg=""
> +
> +        for target in $targets; do
> +                bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
> +		stack_vlans bond0 "${s_ns}"
> +                if [ "$RET" -ne 0 ]; then
> +                    log_test "no_vlan_hints" "${msg}"
> +                    return
> +                fi
> +                check_failure_count bond0 "${target}"
> +		log_test "arp_ip_target=${target} ${msg}"

Please fix the alignment above.

/P


