Return-Path: <netdev+bounces-214932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493EB2BF81
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD583626B28
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394D322556;
	Tue, 19 Aug 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtB1YpS+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41B2FF16D
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601026; cv=none; b=SIRCe/18zNdSpMw49BC7gOFlTkcb1dAdj+hObfV/z9OHkCUy4g1lDFSr7jVMHmDdQ5qgN50PvlrYslwlMshvgLlAeNt/63oD2mm9ka3jN3OORVpez4MVbzMuddF+yeMvDoVFNp02P4BOF64NgljLaQ9zm8ktekOe+WL6ze4dxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601026; c=relaxed/simple;
	bh=rZL+wNNkkSaYWCQ+s/sEu/+VRbLDXmLW0HZ3ko4ckms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH+KZD/8BQgPZ0tiqN+Pm26zvNpx4d8+nG1KAruaPqpasI1iRvgU2VCr6fJZhDBMCjlE4CR5kW/gyi1OnFOZgkWt2mZ9bqNzoDg717eUsvR3N2jrc5MYqOZyzQTIPFbBOPTTqAKJgcm+YvWB75RXizrKVUCef0zho7YQemqreWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtB1YpS+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755601023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZqMtC8zn+vOgLMpZN5F6L+enwy/jFamAIbV1Hg+0OE=;
	b=OtB1YpS+ikfv89FNVW7yk8gpckWPBYihyiJP6l95hshPKbFzc3Ije88llrOkGThLWwWOn2
	g/MGDjidMDvE16mFa1hXVdi1eKWaKHrMT3X7En02LIaO7DLcy8yiO4rJ1Az+QtVz2/W0Z1
	jOdOBVhM8IB19P8QhLpjQQREnj5obe8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Q31_Sg3CNgyETmvufumpiw-1; Tue, 19 Aug 2025 06:57:02 -0400
X-MC-Unique: Q31_Sg3CNgyETmvufumpiw-1
X-Mimecast-MFC-AGG-ID: Q31_Sg3CNgyETmvufumpiw_1755601022
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e86fa865d1so1560102185a.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601022; x=1756205822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZqMtC8zn+vOgLMpZN5F6L+enwy/jFamAIbV1Hg+0OE=;
        b=XQe9yxRXDZUAMrsx9/BZ+/AD6YB4oS4QKmfk28RQfigL66EwsjxajrTyB9wD0Z1YTk
         RCA7xqRjdg0yP9AuEXAROtCBFELr67MtKW/j8sYQ2CgrwXi5iBgYvxWgo6wcug3WQhOO
         UNXxJl0/sWk4ar2jPQoxDYhouCAciofMCd0Xzg0DlVMRB1UMlRV8YeiLukHwEJrmRJhl
         h9r3cFOI+5ra+WDENzqili0ogpja7iA1ch2ikWQ3rRsF8D1DRwbgfU8NlhQ4accaGVD2
         MelxxcHiK0MZ9eXF0Xj79Z1mQC/TKrOopJ+pY4/Z4mRNdJsOBmsatfIatp3FgXF918rH
         5g+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF4868LzqG9T0GaQO3TguBsr97QNDhPO5Iu8iYzbaRAE45OuaemgUJYoDICJ0Mf+G/qF3BL4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfBZKHbVDLR5c2Qun3H+exV4TTmDYT/FiQKjdTac0eQ7Q2Ors
	MKbApTucwpYGWpOJR3N/gUphgGwED7mNDRRvkQfKfSxSZ+c3XRK3/lnH9d3373gf05zBjKILUvt
	wvuK9NUhiJHHka+Ki3ZvRPZODBi7CMuAKSdFQBfJ3//8if2IIyqM1diO9Pw==
X-Gm-Gg: ASbGnctb0GPLDynyqG0PK+gynuhjZCbocJMHBLD+XPLVmf0nufx5GLKW1/ARlEQs73/
	MR2DC8wKKU1O/RkDPHN5puYZqNLxbxd3eqtrsx2rHhxgfVWHEChBZciC0cYInj3HEjFUfhtKYmB
	H8lTc3BIRSGT7sCAnFwkj/KjVIwf8xkvIBikz2jsmQdd1+0jY9Glv/xG8fBQwoLVBJMauKhR5+l
	uYVm4AG04csE27BEQk2D0GodYairpYUtlsVV/d2fwn//FZ7mu8dlTVUMRtmtXzeBXgU3NNc6B09
	lEAcRqy3pBSBlg1VGzgsOf3W5FsE2kMAM+wvum9JoZbBVyIeKlypOW64Hz78CnZxvSLLVib0aZS
	+U7E7+vF4S7E=
X-Received: by 2002:a05:620a:4156:b0:7e6:2191:583b with SMTP id af79cd13be357-7e9f4b33d75mr176156285a.20.1755601021962;
        Tue, 19 Aug 2025 03:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1FF9E2cq5W/gic4mgv+BEBYHZo17fYvd2cx2owI/XCkestf7MYq5z33hQe3gd/Ce09YdDg==
X-Received: by 2002:a05:620a:4156:b0:7e6:2191:583b with SMTP id af79cd13be357-7e9f4b33d75mr176154985a.20.1755601021556;
        Tue, 19 Aug 2025 03:57:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92fa157sm69122986d6.47.2025.08.19.03.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:57:01 -0700 (PDT)
Message-ID: <98b7d1b2-843c-40c6-8918-1af431aedc5f@redhat.com>
Date: Tue, 19 Aug 2025 12:56:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: net: add test for dst hint
 mechanism with directed broadcast addresses
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814140309.3742-1-oscmaes92@gmail.com>
 <20250814140309.3742-3-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250814140309.3742-3-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:03 PM, Oscar Maes wrote:
>  tools/testing/selftests/net/route_hint.sh | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100755 tools/testing/selftests/net/route_hint.sh

You must additionally update the net selftest Makefile to include the
new test.

> 
> diff --git a/tools/testing/selftests/net/route_hint.sh b/tools/testing/selftests/net/route_hint.sh
> new file mode 100755
> index 000000000000..fab08d8b742d
> --- /dev/null
> +++ b/tools/testing/selftests/net/route_hint.sh
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test ensures directed broadcast routes use dst hint mechanism
> +
> +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> +CLIENT_IP4="192.168.0.1"
> +
> +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> +SERVER_IP4="192.168.0.2"

> +
> +BROADCAST_ADDRESS="192.168.0.255"
> +
> +setup() {
> +	ip netns add "${CLIENT_NS}"
> +	ip netns add "${SERVER_NS}"

You can/should use setup_ns() from lib.sh to avoid some duplicate code

> +
> +	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
> +
> +	ip -net "${CLIENT_NS}" link set link0 up
> +	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}/24" dev link0
> +
> +	ip -net "${SERVER_NS}" link set link1 up
> +	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}/24" dev link1
> +
> +	ip netns exec "${CLIENT_NS}" ethtool -K link0 tcp-segmentation-offload off
> +	ip netns exec "${SERVER_NS}" sh -c "echo 500000000 > /sys/class/net/link1/gro_flush_timeout"
> +	ip netns exec "${SERVER_NS}" sh -c "echo 1 > /sys/class/net/link1/napi_defer_hard_irqs"
> +	ip netns exec "${SERVER_NS}" ethtool -K link1 generic-receive-offload on
> +}
> +
> +cleanup() {
> +	ip -net "${SERVER_NS}" link del link1
> +	ip netns del "${CLIENT_NS}"
> +	ip netns del "${SERVER_NS}"
> +}
> +
> +directed_bcast_hint_test()
> +{
> +	echo "Testing for directed broadcast route hint"
> +
> +	orig_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')

Likely using the '--json' argument and 'jq' will make the parsing more
clear.

> +	ip netns exec "${CLIENT_NS}" mausezahn link0 -a own -b bcast -A "${CLIENT_IP4}" \
> +		-B "${BROADCAST_ADDRESS}" -c1 -t tcp "sp=1-100,dp=1234,s=1,a=0" -p 5 -q

You should check for mausezahn presence and ev. error out with error
code 4 (ksft_skip)

> +	sleep 1
> +	new_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
> +
> +	res=$(echo "${new_in_brd} - ${orig_in_brd}" | bc)
> +
> +	[ "${res}" -lt 100 ]

It would be helpful additionally printing the test result:  '[ ok ]' /
'[fail] expected ... found ...'

/P


