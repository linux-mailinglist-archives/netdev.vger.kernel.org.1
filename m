Return-Path: <netdev+bounces-219263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D2B40D3D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7505C7B0F7A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627834DCF8;
	Tue,  2 Sep 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY7Op3vq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94734DCE2;
	Tue,  2 Sep 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838080; cv=none; b=BsuEL9RicHjeJaRYXHijspd9xdDpUsIBGlcTd84Se1gYNv87S4fhtHowOLHVZuI6sB7HvdpAP2Thb9/uvudJiIERpadfqHzgp3Gwez0O8v+A7OLBZIQ4TPvg5r8Pe+hfLGP24c+t5rCvDIq2HmP2HAM0ZNe32rCp8HpNw+VtsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838080; c=relaxed/simple;
	bh=9JzRUZl22vn+LFcHlLO4ve2rAfiXHxmhG6RUTTHx5VE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b9UnDabDoVChAXgxj1o0MiVpsI/ub/V8MKQvuaMFzpGeGJBNCBDRGQLR+uaHbD7uM3vq+x4EydRVs8TRZD514EtaL6cQoVXdVdMuRLon3JzJW5Wj1/Eg9j+30BHgGQ/H1eBNsJM6etr3HxLTbsiqIwP3yRPvbtZ/ZAdJDpTvpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY7Op3vq; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-544ad727d19so144158e0c.0;
        Tue, 02 Sep 2025 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756838078; x=1757442878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbtzSrb2IcrKkwEGNPn/q1GAJEnc3LDOQZtiITLxNXk=;
        b=LY7Op3vqvdgl2/RH4plF9iHKbs+FVt4XhF2CYLTuMxExMgEgpJZt1FLs8ZfZ2ft+or
         19nDsNDtBHwgFQhv+VR+cBJ6zrPnqX+XOh1gF9LmEW29yPBCQFZdAnf+Y2m6maQ1EoFj
         PUL/jzbki3ugDEiuY7cXuCQMHLTcno/Sjg2hYVZ0kQxqTK3YVeUhAm7BXotLvu4ZJ0iV
         RKfrYHTXjpWwE7jKcHkNN6dWpwU6yL378H1rjHXeM/KrPs2wCuyxx90MbYUq3aUTy/35
         JiTxPnpzQBtuvIUkmYBm3qsj8TyxUKlwMWJH7IHhPn/aWP/UU3IZWve6YV0TrXPuiI4K
         pPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838078; x=1757442878;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VbtzSrb2IcrKkwEGNPn/q1GAJEnc3LDOQZtiITLxNXk=;
        b=CGpMckgnUVLH+kHUcBx0J08rQ3C+LWJnVDYCTMMh5xc9Kao+wRVZlZT4pcKjPNCdjl
         1MLhBXVwq+jbGDtBlCQAW9esFmP+pkXeb1BNtwokqyxFCQvgOhjgBEUEVeAoL72a6RQM
         FlBktNSmPw20G9NbSD/TQ0Xvku51ctW+zGnyULicB7TtjyPQK4uZKCy51ZzacOjl+DxT
         SAJmyk1st7TCuyfo/BBvSpjbua2GwFUwA64Aqu6Q0FDxxk+2zmy4lXy5pR9sFB6LS/Vg
         vWUwbmM7E6eaRW9fpnmADFZGcDfzzjuQeljUDT9s7wCleCe5O1pQU4R36YDYSdHhxbB6
         ICUg==
X-Forwarded-Encrypted: i=1; AJvYcCUbRS4pCfwtZqnfzP6zzn2r3SLie8MZHak+NrGGIs9NfwoowJm2iNld2GTQ7Rin0oOYwwWiklw1HjQFu2Q=@vger.kernel.org, AJvYcCXKmR+T+zNU1fjrrWNuWsP++AaAalELJkdANITshe7ue9RqEKANCaqfqBc++akpRl/TRQ9yS7SI@vger.kernel.org
X-Gm-Message-State: AOJu0YydWI21lEVmzPzj3NsfcDb7XAs8o++SComz9l5Hr2GazjiGKCVg
	9ozeS4QbK0uUfjhsfT2pIDtTQH5OEkLGiPoF6K4pH6xJwKLllpyOA/Rd1nWiEg==
X-Gm-Gg: ASbGncuqYdmWSen/Sjhk7qViq+YA8ftlEx2+0e38RJCvON6NW/fNikbVNIMChFU5hnU
	rccCCQegbWlgT2KPIwfdl9Ls8TM6Wv9owBTwUs1cpywO2cY7nhvzOl8f65Ni3TVqJ5+vmKwnngr
	+5pQAgxvlmRPNIr/jF2/UBXuVGWU5kC3RmgeQyIMtr3zq/NQFJVW2nkbezIVYuxXod8CSwSQpn9
	dM0HVnazoCQ/6V/W4ms3QL/kaMEo2oh4dMJxsTbOhCphAwWQubK6XL0gRDhm0f5SIP6v/8Zi2zj
	1Spr9xnqCzt2KFQq7JxrKmtUFCDf7lMrdA9mjMHs2OI/fwMne8pOjqZWFJ21AtsBWJHHGpPpDJ7
	mHFUIU2u010IM4AcjaT2qcRbDFWw3lhvRsObLt77o8+EGL3/UvJn80ZpPEVTospGsyJGuzekYje
	jkub4yXflDpt4o
X-Google-Smtp-Source: AGHT+IETfZjHtGAfi8ECh1uuzCfxcgFSe2Z65Cm/9zkkA9f12Dt9QxUQYVsA3ykCkgM9C5xSD0lOsQ==
X-Received: by 2002:a05:6122:3c4a:b0:544:87e2:12d1 with SMTP id 71dfb90a1353d-544a031f627mr4741726e0c.7.1756838077727;
        Tue, 02 Sep 2025 11:34:37 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-544912c7cbcsm6010677e0c.2.2025.09.02.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:37 -0700 (PDT)
Date: Tue, 02 Sep 2025 14:34:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2bc58f76bed9b@gmail.com>
In-Reply-To: <20250901113826.6508-6-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-6-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 5/5] selftests/net: test ipip packets in
 gro.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Add IPIP test-cases to the GRO selftest.
> 
> This selftest already contains IP ID test-cases. They are now
> also tested for encapsulated packets.
> 
> This commit also fixes ipip packet generation in the test.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
>  tools/testing/selftests/net/gro.sh |  5 +--
>  2 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 3d4a82a2607c..451dc1c1eac5 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -93,6 +93,7 @@ static bool tx_socket = true;
>  static int tcp_offset = -1;
>  static int total_hdr_len = -1;
>  static int ethhdr_proto = -1;
> +static bool ipip;
>  static const int num_flush_id_cases = 6;
>  
>  static void vlog(const char *fmt, ...)
> @@ -114,7 +115,9 @@ static void setup_sock_filter(int fd)
>  	int ipproto_off, opt_ipproto_off;
>  	int next_off;
>  
> -	if (proto == PF_INET)
> +	if (ipip)
> +		next_off = sizeof(struct iphdr) + offsetof(struct iphdr, protocol);
> +	else if (proto == PF_INET)
>  		next_off = offsetof(struct iphdr, protocol);
>  	else
>  		next_off = offsetof(struct ipv6hdr, nexthdr);
> @@ -244,7 +247,7 @@ static void fill_datalinklayer(void *buf)
>  	eth->h_proto = ethhdr_proto;
>  }
>  
> -static void fill_networklayer(void *buf, int payload_len)
> +static void fill_networklayer(void *buf, int payload_len, int protocol)
>  {
>  	struct ipv6hdr *ip6h = buf;
>  	struct iphdr *iph = buf;
> @@ -254,7 +257,7 @@ static void fill_networklayer(void *buf, int payload_len)
>  
>  		ip6h->version = 6;
>  		ip6h->payload_len = htons(sizeof(struct tcphdr) + payload_len);
> -		ip6h->nexthdr = IPPROTO_TCP;
> +		ip6h->nexthdr = protocol;
>  		ip6h->hop_limit = 8;
>  		if (inet_pton(AF_INET6, addr6_src, &ip6h->saddr) != 1)
>  			error(1, errno, "inet_pton source ip6");
> @@ -266,7 +269,7 @@ static void fill_networklayer(void *buf, int payload_len)
>  		iph->version = 4;
>  		iph->ihl = 5;
>  		iph->ttl = 8;
> -		iph->protocol	= IPPROTO_TCP;
> +		iph->protocol	= protocol;
>  		iph->tot_len = htons(sizeof(struct tcphdr) +
>  				payload_len + sizeof(struct iphdr));
>  		iph->frag_off = htons(0x4000); /* DF = 1, MF = 0 */
> @@ -313,9 +316,19 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
>  {
>  	memset(buf, 0, total_hdr_len);
>  	memset(buf + total_hdr_len, 'a', payload_len);
> +
>  	fill_transportlayer(buf + tcp_offset, seq_offset, ack_offset,
>  			    payload_len, fin);
> -	fill_networklayer(buf + ETH_HLEN, payload_len);
> +
> +	if (ipip) {
> +		fill_networklayer(buf + ETH_HLEN + sizeof(struct iphdr),
> +				  payload_len, IPPROTO_TCP);
> +		fill_networklayer(buf + ETH_HLEN, payload_len + sizeof(struct iphdr),
> +				  IPPROTO_IPIP);

if respinning, minor request to insert in the order of the headers,
so IPIP first.

> +	} else {
> +		fill_networklayer(buf + ETH_HLEN, payload_len, IPPROTO_TCP);
> +	}
> +
>  	fill_datalinklayer(buf);
>  }
>  

> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index 9e3f186bc2a1..d16ec365b3cf 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -4,7 +4,7 @@
>  readonly SERVER_MAC="aa:00:00:00:00:02"
>  readonly CLIENT_MAC="aa:00:00:00:00:01"
>  readonly TESTS=("data" "ack" "flags" "tcp" "ip" "large")
> -readonly PROTOS=("ipv4" "ipv6")
> +readonly PROTOS=("ipv4" "ipv6" "ipip")
>  dev=""
>  test="all"
>  proto="ipv4"
> @@ -31,7 +31,8 @@ run_test() {
>        1>>log.txt
>      wait "${server_pid}"
>      exit_code=$?
> -    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" && \
> +    if [[ ( ${test} == "large" || ${protocol} == "ipip" ) && \
> +          -n "${KSFT_MACHINE_SLOW}" && \
>            ${exit_code} -ne 0 ]]; then
>          echo "Ignoring errors due to slow environment" 1>&2
>          exit_code=0

If you can no longer reproduce the need for this, and we see no
reason analytically why ipip would be more flaky than ipv4, then
please drop this. Else some future time we'll be scratching our heads
why this is here but will be afraid to touch it.

