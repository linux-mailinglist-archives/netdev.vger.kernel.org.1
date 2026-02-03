Return-Path: <netdev+bounces-256233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA7NGQfJgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:08:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2586D7508
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848883058A9A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA339C658;
	Tue,  3 Feb 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvydTPGI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDRIwq+O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAF39A7EF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113279; cv=none; b=cE7n9+6eAT3W34GNX9UjeAlaw7li7Nr7i9lzDEWVRTmCfo5BQByOk9+2VWZYV9jkjbbvBkvjKW2/xNAJ1pR18dga6Umsn35QDSu4cMq1EW1BUO7BOlXADxgDaIjS56N4sMp9T+qT/rysaDgbqRWEh0co5DP/D3jroC/pxpJuUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113279; c=relaxed/simple;
	bh=GJgu6W5rJwbIyNtNorr8rYsILnJchB4cpfPCSfzgtVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VSTsDAStxH0KsIzzV4D10/8zBJjAnvdTXAasAVQuTI7lHZqiC+WT0qfabeK6WiHs+Leeufd8uJjfIDXYjh4WyEYU68JS1MUwDWjnRqZCXyX5QsxGFHn48jinP3Yx8PiLUSCY4B3c4t4FrJ6Dig4EHYNN73CAyQvZzHcYK1trD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvydTPGI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDRIwq+O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770113276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGs2YkYoWlfGHazFM7O3osfPUjK8eaN/zd8OtSRCmyA=;
	b=SvydTPGIxpvwbowm2bInXGSEREEOkkgTRKV48G/UK0p6+hquFCroVEMihAYO0cxq/Q1vc8
	6/L0yCmL5/9np6TAzR8SRglZQTZfZTL719jwWveENjML0WHPk5JJPasMgUYVGJ7lFfBcGW
	Xl+Cnx2eFHZ8h1ls3nPUt6zssf465ic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-5ZAyjsHGNfOdP4tjqvHDOg-1; Tue, 03 Feb 2026 05:07:55 -0500
X-MC-Unique: 5ZAyjsHGNfOdP4tjqvHDOg-1
X-Mimecast-MFC-AGG-ID: 5ZAyjsHGNfOdP4tjqvHDOg_1770113274
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4359d70faa2so3325475f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770113274; x=1770718074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGs2YkYoWlfGHazFM7O3osfPUjK8eaN/zd8OtSRCmyA=;
        b=KDRIwq+ON8DU8K6jPDKLvdHekKcSdH1ftr4U6UQIv+QGK5l6ZNfw9rtxG6Ceaoy+cJ
         AWPbrwuoB2kLxwopj/T3POHdi1FOA4nQJOR0rRlMAF3kuBbNyZtMezMBSJUVqkln/fQK
         R/6qJDG+PQkhj18ogN9wjaRZFCuZN4/ObAbN6cDK7cmzFypwQa+CseNPY6ShxrDzofHI
         7YDC12V7RmxNhUWwn6WeiomC1oqZc34e66YCB9Z1r7RHq+63N7IQq3EvCrDV3jCDofMh
         emPJy8YyJgTP5w5tG5ZIYh59H30g/3ObCKW5sFlgezNn/Idq1AmDvkf6dn6JXuq9G5+I
         2ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113274; x=1770718074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGs2YkYoWlfGHazFM7O3osfPUjK8eaN/zd8OtSRCmyA=;
        b=tB4+sX5eu3B20MKr5/qq+k2cl79XSeT/3vmzLKXE9G5qqKlYrdxQCCyWCkdOaHD1Np
         2J8OR0Fx2vT6hbcUcXQ3gCZaNs1TaYD3j4DPllpuGgV41KLBeq6qfv06uvVEgvHYA9kx
         J9zrorXyhLehHt+kiMcznoKPZIV5TNthLpCZGFf6n2IHDp8jsvHlrxnuDZOxv57Q6/gg
         1wF5UKXlJJ2O85SsF2qbFb2cR4FRidbMRCtcL0XHhLRU2II9EwcaozzrxqCo/Nga5hd1
         A3ibmd1N8SwdVml4YCO+JpMsVt8AwMKM802VGXxgUHW+g3GH4k+7C+snYFoTzC921wIz
         SilA==
X-Forwarded-Encrypted: i=1; AJvYcCWTscsOUKPHZRyMXgrJkkBtUICHhXTr8GUCI/56WVvJAyKQWx93Q9Ck9MK+GEoGrCEew9wQBCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNvxr9rIh/4ee1x9beN5MNZNJDKNqNxc9tWqkLXQK/w6DF5T2
	GBO3RW4nFlE0DT0uIumEXHtptRZ23sBXoFedEbjrv5ZFBy342d6kSFPxkdlWNAadSHTSC2jjKwF
	PIfh4wMvRIzy8w8HWbjUzlTPKp/idXDlw/64kjyS2+vLVxdaHIJzae23DOQ==
X-Gm-Gg: AZuq6aLwNJYvA3Kbhs3eyTqYs6BBn+FyZF4bZIvBFBEOfi5ku89kTsmK/iA6PcRap2V
	x7/mZg1kcbwzDjg+IqwAzzmmn/XQZ8C/WsXnA+DRJfQcPbVQ+ofbqSLlXjmHx23nhz9Hw9+eRoO
	GvtZ7KNxJ4twoe6dF8HMj0dE2b4hPb6kcRr7EfXpffUohEeb23+XmKcPdSOmOyGVNsyvyQrEFV3
	CEKDQ1HPVHKPTRCr2qU5z1P/2BrWc+Ptr/yTA7RdUxjkKEhGqCc0TjST2kPapGP2ZFvoYDP6Drc
	liZ7n4AMSTsS8N0RiZUVcvvRIswCW9JDPX7irx0ahMW3gHxoYqCFGYtQZ/sf9Cok/2xzC6/3hhF
	fbrV2cdtX3/I=
X-Received: by 2002:a05:600c:1f14:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-482db4a6193mr194760605e9.33.1770113273864;
        Tue, 03 Feb 2026 02:07:53 -0800 (PST)
X-Received: by 2002:a05:600c:1f14:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-482db4a6193mr194760295e9.33.1770113273418;
        Tue, 03 Feb 2026 02:07:53 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04d168bsm114722155e9.6.2026.02.03.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:07:53 -0800 (PST)
Message-ID: <e68843a2-632c-4703-8a75-551c56232224@redhat.com>
Date: Tue, 3 Feb 2026 11:07:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/10] test: Add networking sefltest for eh
 limits
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, justin.iurman@uliege.be,
 willemdebruijn.kernel@gmail.com
References: <20260203004853.94438-1-tom@herbertland.com>
 <20260203004853.94438-11-tom@herbertland.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203004853.94438-11-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[herbertland.com,davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eh_limits.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,drop_monitor_tests.sh:url]
X-Rspamd-Queue-Id: D2586D7508
X-Rspamd-Action: no action

On 2/3/26 1:48 AM, Tom Herbert wrote:
> Add a networking selftest for Extension Header limits. The
> limits to test are in systcls:
> 
> 	net.ipv6.enforce_ext_hdr_order
> 	net.ipv6.max_dst_opts_number
> 	net.ipv6.max_hbh_opts_number
> 	net.ipv6.max_hbh_length
> 	net.ipv6.max_dst_opts_length
> 
> The basic idea of the test is to fabricate ICMPv6 Echo Request
> packets with various combinations of Extension Headers. The packets
> are sent to a host in another namespace. If a an ICMPv6 Echo Reply
> is received then the packet wasn't dropped due to a limit being
> exceeded, and if it was dropped then we assume that a limit was
> exceeded. For each test packet we derive an expectation as to
> whether the packet will be dropped or not. Test success depends
> on whether our expectation is matched. i.e. if we expect a reply
> then the test succeeds if we see a reply, and if we don't expect a
> reply then the test succeeds if we don't see a reply.
> 
> The test is divided into a frontend bash script (eh_limits.sh) and a
> backend Python script (eh_limits.py).
> 
> The frontend sets up two network namespaces with IPv6 addresses
> configured on veth's. We then invoke the backend to send the
> test packets. This first pass is done with default sysctl settings.
> On a second pass we change the various sysctl settings and run
> again.
> 
> The backend runs through the various test cases described in the
> Make_Test_Packets function. This function calls Make_Packet for
> a test case where arguments provide the Extension Header chain to
> be tested. The Run_Test function loops through the various packets
> and tests if a reply is received versus the expectation. If a test
> case fails then an error status is returned by the backend.
> 
> The backend script can also be run with the "-w <pcap_file>" to
> write the created packets to a pcap file instead of running the
> test.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  tools/testing/selftests/net/Makefile     |   1 +
>  tools/testing/selftests/net/eh_limits.py | 352 +++++++++++++++++++++++
>  tools/testing/selftests/net/eh_limits.sh | 205 +++++++++++++
>  3 files changed, 558 insertions(+)
>  create mode 100755 tools/testing/selftests/net/eh_limits.py
>  create mode 100755 tools/testing/selftests/net/eh_limits.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index afdea6d95bde..73195a2e8f1e 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -24,6 +24,7 @@ TEST_PROGS := \
>  	cmsg_time.sh \
>  	double_udp_encap.sh \
>  	drop_monitor_tests.sh \
> +	eh_limits.sh \
>  	fcnal-ipv4.sh \
>  	fcnal-ipv6.sh \
>  	fcnal-other.sh \
> diff --git a/tools/testing/selftests/net/eh_limits.py b/tools/testing/selftests/net/eh_limits.py
> new file mode 100755
> index 000000000000..01fcf15c6b94
> --- /dev/null
> +++ b/tools/testing/selftests/net/eh_limits.py
> @@ -0,0 +1,352 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test of extension header limits
> +
> +import ext_hdr
> +import getopt
> +import proto_nums
> +import shlex
> +
> +from scapy.all import *

Not a real review yet, but this is causing self-test failure, because
scapy is not available/installed in our runners.

To prevent such failures you should add:

require_command scapy

in the test shell script.

Also please be aware that CI runs linters vs python and shell code, and
there are quite a few complains with them. You can use the
`ingest_mdir.py` tool from:

 https://github.com/linux-netdev/nipa/blob/main/ingest_mdir.py

to automate the pre-submit checks.

Thanks,

Paolo



