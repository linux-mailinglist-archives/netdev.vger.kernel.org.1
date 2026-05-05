Return-Path: <netdev+bounces-284524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ILaNt4k+mkzKQMAu9opvQ
	(envelope-from <netdev+bounces-284524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB14D1DF3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48AE9303675D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419249550A;
	Tue,  5 May 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYb9v66c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4F43CEE4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001091; cv=none; b=SPVAwdIKcM5uIWzlO3PFltOLyfty9NEe1S3QjWtUHMYxEslATKxWKBJKuowTGZb3ttnxjqg+Ym4FM+ZWPohYIHQJKX9/nTBfRlTAExi/h1nvqlcpDZfYSE1bNSgWzG+K3qTfajaLdazZldWI7RBq26n0duHIMpv2tbnQqqX7CTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001091; c=relaxed/simple;
	bh=grWeBb5Acpoj/AANpNcSWJEWoN06WMNxgQBBa2TtiI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIxzMrUGEsOnXRwVvqC0Nb0eucU07H8UYFc7fXTVwQ5gLi0SiGqGUZlKLUv1nXgZQhwev/mS01Fz6RmCFE5rr1USYJcQVNqaeL8NT0F10B9Vyg5dnDguGIcpxH94mB5tekMJCzNIW07+cJnEO57QP/lv0LpP+WQBIpA5L+h0lfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYb9v66c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so1259625f8f.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001088; x=1778605888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90Ls8GApRUBmoDVuDYw/y92UxlHRPn/jnTHMFBfdrfA=;
        b=fYb9v66cPVDW1BNpmOrPETAezGO32yiL/SQV7fq6+gMWdRI5ZEsGequeLmDSxFeVM1
         LutN5IZNX/D5nK1mW8EiiJTwikfSsWTymKsUYuU8SKcatVzSA9JX+vLTUR1mhSD1smh/
         PjiR+8bd7wxUVU9CMrqZY288ekYde21Y9btI5m32cwSYnYil81B36FcXI5lQ6hz//qKn
         MOooZv2dz3EJC4XRux42+F3yEn2jIhFZYnk1rhZF6/Aje4H8iLJCNrGK2btlVAfFt7Rr
         Y+XLwsY1rlUUVNuXtmYDzEGSzfbtWU06dhtLkApf6JGpCURVc2AC8EiFkzMv3y+fJwO6
         TEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001088; x=1778605888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90Ls8GApRUBmoDVuDYw/y92UxlHRPn/jnTHMFBfdrfA=;
        b=oNVl2BsC8/BEUDRV+UTvb1XLxALjaEpF41yfuKAencf3azs/4jP9aS5rieODYs7IOE
         gZB0bq9+aVyVxqI+2xxjgxFy2fhe+gUJn2lifi+y06zJPdSLhOwj291b++5/3V3nvgEq
         VRzJ6kaRwIeXBgmbPyjFGdwxE8Ovj2gmB9CJRoClcaqvHac8M+XmWEFW31C01Sy3a1z+
         IkSO8NTH/SOdDETH3iTbtsDmXX/+YhiV2i2hE+EBh+WdAeHYIJw4MMFZOxMHqi2oLH85
         8X8N8Gr/Fsqc9nF8X76TTxhsiOvnXbi8VavJ0d3PKfDbU85E28Pt4t+a8a1/HW6gQPrI
         4+GQ==
X-Forwarded-Encrypted: i=1; AFNElJ88AION4ylsMX2l8kaGmtptcv4YfGuRjh3U+Si/hubE3sz1FisECWsgqlVnOnuZwmWNyqCgBOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TQt0WAIZDp/fDVNvGDyZOZT5kTawzxK3xgzigGwrjAeFfcEP
	RYvirPyYJa4jGyXg4srfKQ4xZapteOH6b0iJN9f7H2KwbCpaZr5V0njL
X-Gm-Gg: AeBDieuTBRZ1AA9UvhDsunjlIAvUk+vSqCwuHN22GRArPqerDVz7z4d2Q15WUW3OCOB
	P8sdVx4h09fX4h1o4XaoxQqzA4WXVatPAuAWgLQnkUPPYopOxR0hqMMW5wrSQx5f8E8RxLyj2+4
	4BG5+CAqZSUKMfgrZp/1FE2HzinWvg2qLBOgyyoOR1LuweVMAW/g+FaIhj+nYv7yLlBL/kYh+M1
	5t/hig8Lasx7y/csxN+r/WwnAIbXL5dd4wzikG5SGAZwjzSdEwrjUKWCdZBj0qfCWycimRPqlyl
	tddvoqTlwI8IYAL6UK6UgW/F3j3MlTWEZ3IUuDTAQXBRavLkGyjFqzV0y5EhuyJZKu/w2sEzlyZ
	SfOqIkCyoe7ruwCfmD1KKG2UCSYr16r6JrSVILu9426CCS/VS3nIuFghWCUnKxZXTbr8H+mMGSJ
	KtjUeu+3GJBqtALyZGN1p9LdnhKD20jd4eW1LNV5lP05rcZ0+N95qHSkmbqFfBLJ57jnL0BmSTh
	qQCh9HXaSLMnyfJwZxsRgk7tD0=
X-Received: by 2002:a05:6000:2586:b0:43d:762e:76c6 with SMTP id ffacd0b85a97d-45003914f85mr7030717f8f.7.1778001087889;
        Tue, 05 May 2026 10:11:27 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:dda1:a178:34b7:3d68? ([2a02:a03f:a75e:9a00:dda1:a178:34b7:3d68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524834eesm5606320f8f.4.2026.05.05.10.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:11:27 -0700 (PDT)
Message-ID: <e8e6c910-c9a4-4633-82d2-973e79137d9a@gmail.com>
Date: Tue, 5 May 2026 19:11:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/10] ipv6: Address ext hdr DoS
 vulnerabilities
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 horms@kernel.org
Cc: Tom Herbert <tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E8DB14D1DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[herbertland.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eh_limits.sh:url]

On 5/4/26 20:51, Tom Herbert wrote:
> IPv6 extension headers are defined to be quite open ended with few
> limits. For instance, RFC8200 requires a receiver to process any
> number of extension headers in a packet in any order. This flexibility
> comes at the cost of a potential Denial of Service attack. The only
> thing that might mitigate the DoS attacks is the fact that packets
> with extension headers experience high drop rates on the Internet so
> that a DoS attack based on extension wouldn't be very effective at
> Internet scale.
> 
> This patch set addresses some of the more egregious vulnerabilities
> of extension headers to DoS attack.
> 
> - If sysctl.max_dst_opts_cnt or hbh_opts_cnt are set to 0 then that
>    disallows packets with Destination Options or Hop-by-Hop Options even
>    if the packet contain zero non-padding options
> 
> - Add a case for IPV6_TLV_TNL_ENCAP_LIMIT in the switch on TLV type
>    in ip6_parse_tlv function. This TLV is handled in tunnel processing,
>    however it needs to be detected in ip6_parse_tlv to properly account
>    for it as recognized non-padding option
> 
> - Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h so that all the
>    TLV definitions are in one place
> 
> - Set the default limits of non-padding Hop-by-Hop and Destination
>    options to 2. This means that if a packet contains more then two
>    non-padding options then it will be dropped. The previous limit
>    was 8, but that was too liberal considering that the stack only
>    support two Destination Options and the most Hop-by-Hop options
>    likely to ever be in the same packet are IOAM and JUMBO. The limit
>    can be increased via sysctl for private use and experimentation
> 
> - Enforce RFC8200 recommended ordering of Extension Headers. This
>    also enforces that any Extension Header occurs at most once
>    in a packet except for Destination Options that may appear
>    twice. The enforce_ext_hdr_order sysctl controls enforcement. If
>    it's set to true then order is enforced, if it's set to false then
>    neither order nor number of occurrences are enforced.
> 
>    The enforced ordering is:
> 
>      IPv6 header
>      Hop-by-Hop Options header
>      Destination Options before the Routing header
>      Routing header
>      Fragment header
>      Authentication header
>      Encapsulating Security Payload header
>      Destination Options header
>      Upper-Layer header
> 
> --- Background
> 
> We selected the default value of eight in RFC8504 based on an
> expectation that there might be new options defined and that the
> Internet would be fixed to reliably support extension headers
> including those with options. I do not believe either of those are
> going to happen.
> 
> Hop-by-Hop Options are ostensibly the right way to do network to host
> and host to network signaling.The only HBH options that might get any
> substantial deployment are Router Alert option and IOAM. The Router
> Alert option is being deprecated and IOAM is at best a "nice to
> have". The best use case of Hop-by-Hop options is congestion
> signaling, unfortunately the die was cast when CSIG authors decided to
> place the information in VLANs at L2 and cajole the information to be
> routable through a switch. IMO, the miss on CSIG pretty much is the
> nail in the coffin for Hop-by-Hop options to ever be widely deployed
> (https://www.ietf.org/archive/id/draft-ravi-ippm-csig-01.txt).
> 
> Destination Options have proven even less useful than Hop-by-Hop
> Options. The only Destination Options supported by the stack is the
> Tunnel Encap Limit option and Home Address Options. The Tunnel Encap
> Option was buried in the v6 tunnel code which is why it wasn't obvious
> it was supported in the first version of the patch set.  I'll assume
> that might be useful, so this patch set cleans up the code for it. I
> don't believe there's any use of Home Address Option.
> 
> A major problem with DestOpts, HBH, Routing Header, and Fragment
> header is that they have no inherent security. Their use presents a
> security risk especially when sent over untrusted networks including
> the Internet. Given that and that the high drop rates of extension
> headers on the Internet, I am proposing that Extension header except
> for ESP being deprecated on the Internet
> (https://www.ietf.org/archive/id/draft-herbert-deprecate-eh-01.txt).
> 
> An update to RFC8200 is being proposed in IETF to allow enforcement of
> extension header ordering and number of occurences. An I-D is in
> https://www.ietf.org/archive/id/draft-iurman-6man-eh-occurrences-00.txt
> 
> --- Testing
> 
> Add selftest eh_limits.sh. Tested by running:
> 
> $ sudo ./eh_limits.sh
>      TEST: EH-limits - default sysctls                            [ OK ]
>      TEST: EH-limits - modified sysctls                           [ OK ]
> 
> Tests passed:   2
> Tests failed:   0
> 
> $ sudo ./eh_limits.sh -v
>>>>>> Default
> TEST: Two non-padding options in HBH and DestOpts: Received as expected
> TEST: Big destination option: Received as expected
> TEST: Almost Big HBH option: Received as expected
> TEST: Big HBH option: Received as expected
> TEST: Too much HBH padding: Didn't receive as expected
> TEST: Too much DestOpt padding: Didn't receive as expected
> TEST: Too much DestOpt padding #2: Didn't receive as expected
> TEST: Too much DestOpt padding #3: Didn't receive as expected
> TEST: Almost too much DestOpt padding #2: Received as expected
> TEST: Two Dest Ops: Didn't receive as expected
> TEST: OOO Routing header: Didn't receive as expected
> TEST: Two Routing headers: Didn't receive as expected
> TEST: Two Destination options okay: Received as expected
> TEST: Two Destination options: Didn't receive as expected
> TEST: Two Destination options after RH: Didn't receive as expected
> TEST: Many EH OOO: Didn't receive as expected
> TEST: Two fragment Headers: Didn't receive as expected
> 
>      TEST: EH-limits - default sysctls                            [ OK ]
>>>>>> No order enforce, 8 options, 66 length limit
> TEST: Two non-padding options in HBH and DestOpts: Received as expected
> TEST: Big destination option: Didn't receive as expected
> TEST: Almost Big HBH option: Received as expected
> TEST: Big HBH option: Didn't receive as expected
> TEST: Too much HBH padding: Didn't receive as expected
> TEST: Too much DestOpt padding: Didn't receive as expected
> TEST: Too much DestOpt padding #2: Didn't receive as expected
> TEST: Too much DestOpt padding #3: Didn't receive as expected
> TEST: Almost too much DestOpt padding #2: Received as expected
> TEST: Two Dest Ops: Received as expected
> TEST: OOO Routing header: Received as expected
> TEST: Two Routing headers: Received as expected
> TEST: Two Destination options okay: Received as expected
> TEST: Two Destination options: Received as expected
> TEST: Two Destination options after RH: Received as expected
> TEST: Many EH OOO: Received as expected
> TEST: Two fragment Headers: Didn't receive as expected
> 
>      TEST: EH-limits - modified sysctls                           [ OK ]
> 
> Tests passed:   2
> Tests failed:   0
> 
> V4: Switch order of patches to avoid transient build failure
> V5: Allow Destination Options before the Routing header, fixes
>      suggested by Justin Iurman
> v6: Fix a bug and create a test for extension header limits
> v7: Run pylint on new Python file, run shellcheck on new bash file,
>      Make fixes as needed
> v8: Repost
> v9: Fix subject prefix
> v10: Lint fixes in selftest scripts suggested by Simon Horman
> 
> Tom Herbert (10):
>    ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
>    ipv6: Cleanup IPv6 TLV definitions
>    ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
>    ipv6: Set HBH and DestOpt limits to 2
>    ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
>    ipv6: Enforce Extension Header ordering
>    ipv6: Document enforce_ext_hdr_order sysctl
>    test: Add proto_nums.py in networking selftests
>    test: Add ext_hdr.py in networking selftests
>    test: Add networking selftest for eh limits
> 
>   Documentation/networking/ip-sysctl.rst    |  52 ++-
>   include/net/ipv6.h                        |   9 +-
>   include/net/netns/ipv6.h                  |   1 +
>   include/net/protocol.h                    |  14 +
>   include/uapi/linux/in6.h                  |  21 +-
>   include/uapi/linux/ip6_tunnel.h           |   1 -
>   net/ipv6/af_inet6.c                       |   1 +
>   net/ipv6/exthdrs.c                        |  32 +-
>   net/ipv6/ip6_input.c                      |  42 +++
>   net/ipv6/reassembly.c                     |   1 +
>   net/ipv6/sysctl_net_ipv6.c                |   7 +
>   net/ipv6/xfrm6_protocol.c                 |   2 +
>   tools/testing/selftests/net/Makefile      |   4 +
>   tools/testing/selftests/net/eh_limits.py  | 349 ++++++++++++++++++++
>   tools/testing/selftests/net/eh_limits.sh  | 210 ++++++++++++
>   tools/testing/selftests/net/ext_hdr.py    | 385 ++++++++++++++++++++++
>   tools/testing/selftests/net/proto_nums.py | 231 +++++++++++++
>   17 files changed, 1334 insertions(+), 28 deletions(-)
>   create mode 100755 tools/testing/selftests/net/eh_limits.py
>   create mode 100755 tools/testing/selftests/net/eh_limits.sh
>   create mode 100755 tools/testing/selftests/net/ext_hdr.py
>   create mode 100644 tools/testing/selftests/net/proto_nums.py
> 

Hi Tom,

While at it, should we also take care of ip6_tnl_parse_tlv_enc_lim(), 
ipv6_skip_exthdr(), and ipv6_find_hdr(), so that we remain consistent 
with recent merged fixes 3744b0964d52 and 076b8cad77aa ?

Cheers,
Justin

