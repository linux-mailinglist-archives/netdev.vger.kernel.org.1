Return-Path: <netdev+bounces-215249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C9B2DC4B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66405871AB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97C2F1FC3;
	Wed, 20 Aug 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zke99Dc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D92512E6;
	Wed, 20 Aug 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692510; cv=none; b=VX05J6NOCDzi4GGtM/J2N71rBYYG3ReiicACmsFx/J5Ga15O49sESIxzAvT3/Xg+Ccd5jkrn+2cpG4y8VVGgSqxSC2vVC1HCJxkjg2C4015eiEU4se6BB2FOLTSweV38WvO+0t1QjSltUivMi2Qmw9WBPARiEzQW+0cCLgkLQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692510; c=relaxed/simple;
	bh=Dlw+xPHbNvw5HSlxlMWNFhE5O3SGJH1Tu04A2+ovXqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCtafsRV4FGH80LU/5r6e4LAdTM+aRid0GnES22N608ahp6lQatkvhR20G5NREAqHjvHnKPPwaIlyyUnIzkrWRvrk/bFPndUNGjnVGyjFl93XIAR9E5f54GKAOX6iEDpMipIMxo6ns+mDnbIxooo+srvOUnYYocj2nmN3Cn0iqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zke99Dc6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e4147690so3964248f8f.2;
        Wed, 20 Aug 2025 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692506; x=1756297306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn2uMhPhuiAUQnSJWLqsyZPdwG0fR3Hyg0ZEIEBTeNs=;
        b=Zke99Dc6u0ir0dZIQ8VV2OAY3tf4ZhwlS+1MIU6YrMTUej1qqaQcOvsT/Q0uItkQfU
         WHdoZ+JLiD2FMtR0TKhKZjucbkJ16azrgZ4Du/l9NRv2Ea7sea/DGcyVlvgD5KCOJjRf
         MSr6eqGoUlEhGi6uprBXDrSk00ltRQsQXPtHCs4uABgSbRfzIepz62aj18P7LTVJ9Kum
         3vF4XpspywhH3Xtp6IzorCiPTwYPAYXowR+HXXCK0Z2THWZK5IVPSd5UctQyAOspl0w5
         7HH3tRSOnuN3Inyf3ipmRqsv+Ve5WB2d4YH2ufsLDf8JZHsdZ6zsvhnaw8c2Ui5NAZKB
         WSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692506; x=1756297306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xn2uMhPhuiAUQnSJWLqsyZPdwG0fR3Hyg0ZEIEBTeNs=;
        b=DVLkktBCxEHKakTuhR06gmRsSaq8jtO2PEfjxlFtiz6AqzferJXx7ttLWvll9b9Od6
         vFaPJDNSYsgS6nlY/1eLxAG9KN9jgTCXfFmZ31qaX8HlCA9b3uplKcs8k2S8k9kJzgYk
         s9+GAvJJIaKs5aEX/UKlzCUvNQbBtMbG/jrIqiGDZaENsSQzDaGVnQw5K2p6h1tOD4Ov
         FsnqUBzuqpJgJ6BTciLrKgpTyiObs/OaZ2A8zYQozXH5XTS88X7esBYvLCjUMELArkHH
         GJ1ywyGfskPaVeE4gAr+fB2ly4cnkYzTTLEF5WVV0MItraA8fFUlicXZ22Qjpj9gnAgE
         eilg==
X-Forwarded-Encrypted: i=1; AJvYcCUjaPAMiI6/K3aoqzRbDTV4tIw7YKvN20oqoUo7w78aPWZQ7qzYFXcwWnQb5ytMwADUSGSErju7vKLYhuY=@vger.kernel.org, AJvYcCXq7Do14S6mxwtYI0/zayME438vYyjOJNxraiNDuAGfyRs/iXkzITFwAb5c/9zP+caWVUAZYsD6@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIUBiJkBVl3Mc0SsIlBHWr6kNE4G2banrHdDp0CxuUAxZDDlz
	/eNJSNZ57GVtmcy0dU92mIj9raURRjZrjbCeLQde0fnb+rcUJtC/oC4T5cSTurVVSxQ=
X-Gm-Gg: ASbGncuiQbXs3ybucSpSYi0vxJ3wJEQoVH96SwsgOQ3lvt0rMimWiJbd1vqjelEv9I2
	4eh59OQRO5+0z6EXpMBOmEtpwTiHNu8Khd1DggoprtuJRJrtyaRf1cp26JyxZAqnrSywbN62qSC
	oBrIkC1M5/PfIQzUDzfKwni82lNOk+uvjZXDZa9Bi0QvkhVRBbyi38Csnz3yTVtLr9v5qtV27mj
	ziFm99iCUi1nSToMYxorm8IwPreWP3rT5jsPnViuoQ+nG/hntH//u3JwfP0DmG8gj70Jp8v00TN
	nIH0UKLoplTiQdxbvcsgQzWDBDHi2yy3X9kCEsnbWexjczCdp6lmknTgd7rck4k47NVbfN7cya7
	c4W2sykQbI348DuPkrLUj8v3x6X3x9L/tNkZvFQm8/FJ6
X-Google-Smtp-Source: AGHT+IGG5woTaUhlPOonjwrWf6Pwnx4hseDDNN8dVhPqy3xsR2mbo+fHzXi6ESC3N82Nn7nUB5W/pQ==
X-Received: by 2002:a05:6000:2485:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3c32e22ac33mr1945014f8f.42.1755692505935;
        Wed, 20 Aug 2025 05:21:45 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879859sm7493855f8f.3.2025.08.20.05.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 05:21:45 -0700 (PDT)
Message-ID: <72843355-2afc-413f-b42e-b5e804511874@gmail.com>
Date: Wed, 20 Aug 2025 14:21:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 5/5] selftests/net: test ipip packets in
 gro.sh
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-6-richardbgobert@gmail.com>
 <willemdebruijn.kernel.33c6a8233829@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.33c6a8233829@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Add IPIP test-cases to the GRO selftest.
>>
>> This selftest already contains IP ID test-cases. They are now
>> also tested for encapsulated packets.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  tools/testing/selftests/net/gro.c  | 49 ++++++++++++++++++++++++------
>>  tools/testing/selftests/net/gro.sh |  5 +--
>>  2 files changed, 42 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index 3d4a82a2607c..aeb4973418a4 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -93,6 +93,7 @@ static bool tx_socket = true;
>>  static int tcp_offset = -1;
>>  static int total_hdr_len = -1;
>>  static int ethhdr_proto = -1;
>> +static bool ipip;
>>  static const int num_flush_id_cases = 6;
>>  
>>  static void vlog(const char *fmt, ...)
>> @@ -114,7 +115,9 @@ static void setup_sock_filter(int fd)
>>  	int ipproto_off, opt_ipproto_off;
>>  	int next_off;
>>  
>> -	if (proto == PF_INET)
>> +	if (ipip)
>> +		next_off = sizeof(struct iphdr) + offsetof(struct iphdr, protocol);
>> +	else if (proto == PF_INET)
>>  		next_off = offsetof(struct iphdr, protocol);
>>  	else
>>  		next_off = offsetof(struct ipv6hdr, nexthdr);
>> @@ -244,7 +247,7 @@ static void fill_datalinklayer(void *buf)
>>  	eth->h_proto = ethhdr_proto;
>>  }
>>  
>> -static void fill_networklayer(void *buf, int payload_len)
>> +static void fill_networklayer(void *buf, int payload_len, int protocol)
>>  {
>>  	struct ipv6hdr *ip6h = buf;
>>  	struct iphdr *iph = buf;
>> @@ -254,7 +257,7 @@ static void fill_networklayer(void *buf, int payload_len)
>>  
>>  		ip6h->version = 6;
>>  		ip6h->payload_len = htons(sizeof(struct tcphdr) + payload_len);
>> -		ip6h->nexthdr = IPPROTO_TCP;
>> +		ip6h->nexthdr = protocol;
>>  		ip6h->hop_limit = 8;
>>  		if (inet_pton(AF_INET6, addr6_src, &ip6h->saddr) != 1)
>>  			error(1, errno, "inet_pton source ip6");
>> @@ -266,7 +269,7 @@ static void fill_networklayer(void *buf, int payload_len)
>>  		iph->version = 4;
>>  		iph->ihl = 5;
>>  		iph->ttl = 8;
>> -		iph->protocol	= IPPROTO_TCP;
>> +		iph->protocol	= protocol;
>>  		iph->tot_len = htons(sizeof(struct tcphdr) +
>>  				payload_len + sizeof(struct iphdr));
>>  		iph->frag_off = htons(0x4000); /* DF = 1, MF = 0 */
>> @@ -313,9 +316,19 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
>>  {
>>  	memset(buf, 0, total_hdr_len);
>>  	memset(buf + total_hdr_len, 'a', payload_len);
>> +
>>  	fill_transportlayer(buf + tcp_offset, seq_offset, ack_offset,
>>  			    payload_len, fin);
>> -	fill_networklayer(buf + ETH_HLEN, payload_len);
>> +
>> +	if (ipip) {
>> +		fill_networklayer(buf + ETH_HLEN + sizeof(struct iphdr),
>> +				  payload_len, IPPROTO_TCP);
>> +		fill_networklayer(buf + ETH_HLEN, payload_len + sizeof(struct iphdr),
>> +				  IPPROTO_IPIP);
>> +	} else {
>> +		fill_networklayer(buf + ETH_HLEN, payload_len, IPPROTO_TCP);
>> +	}
>> +
>>  	fill_datalinklayer(buf);
>>  }
>>  
>> @@ -416,6 +429,13 @@ static void recompute_packet(char *buf, char *no_ext, int extlen)
>>  		iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
>>  		iph->check = 0;
>>  		iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
>> +
>> +		if (ipip) {
>> +			iph += 1;
>> +			iph->tot_len = htons(ntohs(iph->tot_len) + extlen);
>> +			iph->check = 0;
>> +			iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
>> +		}
>>  	} else {
>>  		ip6h->payload_len = htons(ntohs(ip6h->payload_len) + extlen);
>>  	}
>> @@ -777,7 +797,7 @@ static void send_fragment4(int fd, struct sockaddr_ll *daddr)
>>  	 */
>>  	memset(buf + total_hdr_len, 'a', PAYLOAD_LEN * 2);
>>  	fill_transportlayer(buf + tcp_offset, PAYLOAD_LEN, 0, PAYLOAD_LEN * 2, 0);
>> -	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN);
>> +	fill_networklayer(buf + ETH_HLEN, PAYLOAD_LEN, IPPROTO_TCP);
>>  	fill_datalinklayer(buf);
>>  
>>  	iph->frag_off = htons(0x6000); // DF = 1, MF = 1
>> @@ -1071,7 +1091,7 @@ static void gro_sender(void)
>>  		 * and min ipv6hdr size. Like MAX_HDR_SIZE,
>>  		 * MAX_PAYLOAD is defined with the larger header of the two.
>>  		 */
>> -		int offset = proto == PF_INET ? 20 : 0;
>> +		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
>>  		int remainder = (MAX_PAYLOAD + offset) % MSS;
>>  
>>  		send_large(txfd, &daddr, remainder);
>> @@ -1221,7 +1241,7 @@ static void gro_receiver(void)
>>  			check_recv_pkts(rxfd, correct_payload, 2);
>>  		}
>>  	} else if (strcmp(testname, "large") == 0) {
>> -		int offset = proto == PF_INET ? 20 : 0;
>> +		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
>>  		int remainder = (MAX_PAYLOAD + offset) % MSS;
>>  
>>  		correct_payload[0] = (MAX_PAYLOAD + offset);
>> @@ -1250,6 +1270,7 @@ static void parse_args(int argc, char **argv)
>>  		{ "iface", required_argument, NULL, 'i' },
>>  		{ "ipv4", no_argument, NULL, '4' },
>>  		{ "ipv6", no_argument, NULL, '6' },
>> +		{ "ipip", no_argument, NULL, 'e' },
>>  		{ "rx", no_argument, NULL, 'r' },
>>  		{ "saddr", required_argument, NULL, 's' },
>>  		{ "smac", required_argument, NULL, 'S' },
>> @@ -1259,7 +1280,7 @@ static void parse_args(int argc, char **argv)
>>  	};
>>  	int c;
>>  
>> -	while ((c = getopt_long(argc, argv, "46d:D:i:rs:S:t:v", opts, NULL)) != -1) {
>> +	while ((c = getopt_long(argc, argv, "46ed:D:i:rs:S:t:v", opts, NULL)) != -1) {
> 
> Please keep alphabetical order.
> 
>>  		switch (c) {
>>  		case '4':
>>  			proto = PF_INET;
>> @@ -1269,6 +1290,11 @@ static void parse_args(int argc, char **argv)
>>  			proto = PF_INET6;
>>  			ethhdr_proto = htons(ETH_P_IPV6);
>>  			break;
>> +		case 'e':
>> +			ipip = true;
>> +			proto = PF_INET;
>> +			ethhdr_proto = htons(ETH_P_IP);
>> +			break;
>>  		case 'd':
>>  			addr4_dst = addr6_dst = optarg;
>>  			break;
>> @@ -1304,7 +1330,10 @@ int main(int argc, char **argv)
>>  {
>>  	parse_args(argc, argv);
>>  
>> -	if (proto == PF_INET) {
>> +	if (ipip) {
>> +		tcp_offset = ETH_HLEN + sizeof(struct iphdr) * 2;
>> +		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
>> +	} else if (proto == PF_INET) {
>>  		tcp_offset = ETH_HLEN + sizeof(struct iphdr);
>>  		total_hdr_len = tcp_offset + sizeof(struct tcphdr);
>>  	} else if (proto == PF_INET6) {
>> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
>> index 9e3f186bc2a1..d16ec365b3cf 100755
>> --- a/tools/testing/selftests/net/gro.sh
>> +++ b/tools/testing/selftests/net/gro.sh
>> @@ -4,7 +4,7 @@
>>  readonly SERVER_MAC="aa:00:00:00:00:02"
>>  readonly CLIENT_MAC="aa:00:00:00:00:01"
>>  readonly TESTS=("data" "ack" "flags" "tcp" "ip" "large")
>> -readonly PROTOS=("ipv4" "ipv6")
>> +readonly PROTOS=("ipv4" "ipv6" "ipip")
>>  dev=""
>>  test="all"
>>  proto="ipv4"
>> @@ -31,7 +31,8 @@ run_test() {
>>        1>>log.txt
>>      wait "${server_pid}"
>>      exit_code=$?
>> -    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" && \
>> +    if [[ ( ${test} == "large" || ${protocol} == "ipip" ) && \
>> +          -n "${KSFT_MACHINE_SLOW}" && \
> 
> Why does the ipip test need this debug xfail path?

When I tested on a VM, ipip packets sometimes didn't get merged because they
weren't received quickly enough (optimizing the selftest helped somewhat but
not entirely), but I can't seem to reproduce this anymore.

> 
>>            ${exit_code} -ne 0 ]]; then
>>          echo "Ignoring errors due to slow environment" 1>&2
>>          exit_code=0
>> -- 
>> 2.36.1
>>
> 
> 


