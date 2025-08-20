Return-Path: <netdev+bounces-215214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F0B2DAD0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9863A770D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49C2E2EFD;
	Wed, 20 Aug 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2+srXer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71A2356B9;
	Wed, 20 Aug 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688870; cv=none; b=YykrmCept5brn/brKFqcBWWGosvboCUpJnFxOPWPsqeVBWSZ3IPgrDqOcJnhz9Tsz7SERHZrlfrCiRsuHAO51o6v/cePgVR1dPO4feqXA0oVkDhDGyHcrkU5CRtmHUkVAuOucRtm36d+YGTY63PElJGbPi1DYjsAhyuytkcWxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688870; c=relaxed/simple;
	bh=/hKBwJtBwYM4vmTeSL0zLMJvuQYltIBcdYkVEbkjDLg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OTKC/MiTOWpoc16PEn7+ksoj9rkwzl9uPYiafvOc4A9TlUQ3AmNw5fW4msZ9xWCybcYBpkILj0nZBD29yLLWSnSmhg6AFbda5aI0kyt66Eouh1foQxX4kKkfivVbnvujyatd1WAuQ5io3adJ+Ew2UnfhDl1oeSPxebIiSbG9kuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2+srXer; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87035a7c3so875845385a.0;
        Wed, 20 Aug 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755688867; x=1756293667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6srAcasDYwpbqhFux+sMQhCaOe0BSLIJCpAILFY05M=;
        b=M2+srXergmJU2kuxf0fS4cbgUw8XQawMrbRoGVfIts8rS8a4MmUAZdrBzGEBzQGNpE
         H/XKv56q93UuNLMV7qiYXIXgl8+ZcCTB95SfVdxNrdM5g/Dd6Wk7pWrFH+bUox9IWxes
         QcdIF87nURHGuBgvyNyjYWiH3iNXLVwB0nfDPMwjhilL3nWn6rnysWk3EQGFdyzaOZYA
         nGgg+t9LOIth3OiCUgN6kkQF6gxFlwIBhMvN7beO1m7Lz6k/6yjpx9UylHR/myXdUWto
         /VyBG1Z44BtvCxwrMxWH/Rv02fDmQSy4jzX0M3KFYMEnhf8lleCP8cdF1fV04vr3NsBT
         SIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688867; x=1756293667;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e6srAcasDYwpbqhFux+sMQhCaOe0BSLIJCpAILFY05M=;
        b=WOPO4UaCFnmz8hKy3o5rDUJGwSjOrbHHjvpi50V6Gy15LNvcl9YRcMhbPdjPPRFgiZ
         HkQlWlCyg3nluA+3Yr7ZbfvjwVB1NyuPo4hQRWoL8sH91oMhp7EeEQKg1moaR/C/DHec
         JRYWTFixlmPzT4lMcoQv3TaRhiZj0bZhfiFNUFAOSHhATj2NgQWUzhZTUVFjfBIBE0B6
         KgZhGrHGemGzjXLGqOkiArSwdbIc47L8vZXe2ubf+A4YyFSb3h5dfqAUH4PnVP4NoJ6Y
         fn4l5lleiyOyrLhk4VwJDNyYnJXIh+9YQrgkYpUIvUBubfEVhBrdhlCPTTnvZHa0eo4+
         s7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM/WCYwHX4LFfVHADlqm+I48dbdrN6UHKljkTMFyXIdNdf79su5KmgKuTxmG8IZvkHLDuL+aautG3kOcI=@vger.kernel.org, AJvYcCXsbiSqFRNdzr8nLTPnCYyAGdWbGuDkggv7Gc7NL3CIezUBMrtgirxeHh0PVxHbNTq4cfZP5Cu+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyp6ojlgX28zcTZGAMrDhJ1/glIeu/MehaULgIihQYpigBEgnf
	9jLmpn8dyPFGo51lkaMTUzBHdMEH6W+CzLIiFUBD5UHx8KeQ95ddAOoP
X-Gm-Gg: ASbGncuTRUQXBZN3ho7kT9v5aWUcmlMVRZuSiJLfgt0KO76xq5pV5WuhXzqUazzjvvq
	mXH/hb8FCjbXX5KYuu2CnwUQGv9Dg4fGsu3q0nIHBaJioMJAp1HuH3KD0XtoqcOy93EWWupe4zk
	RnhGJIMtqCXoFTVDIT8qpWpsP6/I00q12VMCen6m48VUCJF5AiL64YHQzQiAk52ip52z54cD01Q
	6lKtPrW/DBU7UcXtLbqENVx0l54ucEejrM5kKak6OnLtouH9N5AOPy610MTK47DqfwRcxt1WWac
	V2oCfM0UjfudpsfnWfm0qHmGJKxQ3WS0RXaQirh76YHcmL/T/lLTnNBwTb5xWSwW4CqODD6WYde
	TQeSLfKh1wT/HHppguLv7S5Siea5bYjZ4J70ro/nayPGyfh32XCUs8NuKwa2kwg50St8FtQ==
X-Google-Smtp-Source: AGHT+IEXWVnwHMBPEpM8dgl8zVi2CLrKELYgLa7PfXgp1uxdhe0v2T1K/twOUoGrJrz3i2jw8gtlTA==
X-Received: by 2002:a05:620a:f06:b0:7e6:83fe:f95b with SMTP id af79cd13be357-7e9fca967d5mr271069085a.14.1755688866902;
        Wed, 20 Aug 2025 04:21:06 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e191a42sm919218685a.54.2025.08.20.04.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:21:06 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:21:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 shenjian15@huawei.com, 
 salil.mehta@huawei.com, 
 shaojijie@huawei.com, 
 andrew+netdev@lunn.ch, 
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
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.33c6a8233829@gmail.com>
In-Reply-To: <20250819063223.5239-6-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-6-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v2 5/5] selftests/net: test ipip packets in
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
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
>  tools/testing/selftests/net/gro.sh |  5 +--
>  2 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 3d4a82a2607c..aeb4973418a4 100644
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
> +	} else {
> +		fill_networklayer(buf + ETH_HLEN, payload_len, IPPROTO_TCP);
> +	}
> +
>  	fill_datalinklayer(buf);
>  }
>  
> @@ -416,6 +429,13 @@ static void recompute_packet(char *buf, char *no_ext, int extlen)
>  		iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
>  		iph->check = 0;
>  		iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
> +
> +		if (ipip) {
> +			iph += 1;
> +			iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
> +			iph->check = 0;
> +			iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
> +		}
>  	} else {
>  		ip6h->payload_len = htons(ntohs(ip6h->payload_len) + extlen);
>  	}
> @@ -777,7 +797,7 @@ static void send_fragment4(int fd, struct sockaddr_ll *daddr)
>  	 */
>  	memset(buf + total_hdr_len, 'a', PAYLOAD_LEN * 2);
>  	fill_transportlayer(buf + tcp_offset, PAYLOAD_LEN, 0, PAYLOAD_LEN * 2, 0);
> -	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN);
> +	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN, IPPROTO_TCP);
>  	fill_datalinklayer(buf);
>  
>  	iph->frag_off = htons(0x6000); // DF = 1, MF = 1
> @@ -1071,7 +1091,7 @@ static void gro_sender(void)
>  		 * and min ipv6hdr size. Like MAX_HDR_SIZE,
>  		 * MAX_PAYLOAD is defined with the larger header of the two.
>  		 */
> -		int offset = proto == PF_INET ? 20 : 0;
> +		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
>  		int remainder = (MAX_PAYLOAD + offset) % MSS;
>  
>  		send_large(txfd, &daddr, remainder);
> @@ -1221,7 +1241,7 @@ static void gro_receiver(void)
>  			check_recv_pkts(rxfd, correct_payload, 2);
>  		}
>  	} else if (strcmp(testname, "large") == 0) {
> -		int offset = proto == PF_INET ? 20 : 0;
> +		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
>  		int remainder = (MAX_PAYLOAD + offset) % MSS;
>  
>  		correct_payload[0] = (MAX_PAYLOAD + offset);
> @@ -1250,6 +1270,7 @@ static void parse_args(int argc, char **argv)
>  		{ "iface", required_argument, NULL, 'i' },
>  		{ "ipv4", no_argument, NULL, '4' },
>  		{ "ipv6", no_argument, NULL, '6' },
> +		{ "ipip", no_argument, NULL, 'e' },
>  		{ "rx", no_argument, NULL, 'r' },
>  		{ "saddr", required_argument, NULL, 's' },
>  		{ "smac", required_argument, NULL, 'S' },
> @@ -1259,7 +1280,7 @@ static void parse_args(int argc, char **argv)
>  	};
>  	int c;
>  
> -	while ((c = getopt_long(argc, argv, "46d:D:i:rs:S:t:v", opts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "46ed:D:i:rs:S:t:v", opts, NULL)) != -1) {

Please keep alphabetical order.

>  		switch (c) {
>  		case '4':
>  			proto = PF_INET;
> @@ -1269,6 +1290,11 @@ static void parse_args(int argc, char **argv)
>  			proto = PF_INET6;
>  			ethhdr_proto = htons(ETH_P_IPV6);
>  			break;
> +		case 'e':
> +			ipip = true;
> +			proto = PF_INET;
> +			ethhdr_proto = htons(ETH_P_IP);
> +			break;
>  		case 'd':
>  			addr4_dst = addr6_dst = optarg;
>  			break;
> @@ -1304,7 +1330,10 @@ int main(int argc, char **argv)
>  {
>  	parse_args(argc, argv);
>  
> -	if (proto == PF_INET) {
> +	if (ipip) {
> +		tcp_offset = ETH_HLEN + sizeof(struct iphdr) * 2;
> +		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
> +	} else if (proto == PF_INET) {
>  		tcp_offset = ETH_HLEN + sizeof(struct iphdr);
>  		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
>  	} else if (proto == PF_INET6) {
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

Why does the ipip test need this debug xfail path?

>            ${exit_code} -ne 0 ]]; then
>          echo "Ignoring errors due to slow environment" 1>&2
>          exit_code=0
> -- 
> 2.36.1
> 



