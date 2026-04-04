Return-Path: <netdev+bounces-275390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK21H58p0WlsGAcAu9opvQ
	(envelope-from <netdev+bounces-275390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CA39B82D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21E03005D1B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B42D94AF;
	Sat,  4 Apr 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9GTJQex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CE2DA75C
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315299; cv=none; b=Hw4EP35XZRigdtC42tAHNq3Zd3pAyy1pgK1ygfpMG0mx8C87e9Xh1Q2tdMar95izuZWt5eOCYrPNWOkJHeQUfyLyn1oHtEXAWAg47qGuvpbjQtmv66Lu9kX8rDmIfonCGM+JON8+ZIVSEWDVi5If/LZR4e9GhmJ9c/Iko5eY3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315299; c=relaxed/simple;
	bh=GKnP9FkbLRMPwQb91TBQRJYV4zaTPwKQgjogh0/oxyE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YqjbNfMEowLW59JdxOllg1cpK23u0IHeaFd3kY49PvrmTm117c1/yE2UO9+uP/HQQzApGjw6yUUVOxQ5AhCWFKPLtQZiefOX8ktDNgB9b5ihnuru1s3vIREOihDV+Ve2NevMdRAEwfq8XkMKs5ev0Lnz61uCtVVaCc/x5rvEpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9GTJQex; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79495b1aaa7so24577937b3.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315296; x=1775920096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpIgdEywYJarOeXBnQPDMHU5G9TMjrWQTBzqgz6cG/I=;
        b=n9GTJQexpgcf6U20q93ODJoV/U8OntFHnfTdXhd1xVFUQcJ3T0oFQEKjqmcMbdMf54
         sC/mXu6YDXGnABcsUK0Qt4Kv+6OuntKSBb2dqalQ/HwNET7Dh5rI2HVYQFccVskAGlPp
         LQm4d13JZElqZX4kfeqU2Fi1l1007PYgYjyenFRtrn0zWasuhUjoy3LfJW096dY7pf+5
         0YHMiPdjuvwInu4BrdUru5hFFHV3VOmciaYGfqTFBFgQ9EtqpdikjBha7wuVcQXKz4cM
         UDe4Cjh8q3XqCbIMQRXohXFUmP74Wr7vhn4GGPvsz934XbTwh2m/gTkuXt6YKLuZ5nbY
         CaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315296; x=1775920096;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpIgdEywYJarOeXBnQPDMHU5G9TMjrWQTBzqgz6cG/I=;
        b=p97BZw+8dEf0/4EliXeEwt02QkeBeKMtXxb14/RgkhGCepE5iWbtJrznlc4Euhwzod
         yoKy047Giqk3rS7KaiiHHgN+JIG1a/eR/cxI49LqppHmyKKBhoWNCJ3HGvprx5aWn8I0
         J2NsGcukm25h59WT+cUvH/38gx+o5MrbPiiE5bQoJ0AACZ88EA3aBC8WdWN1MTSRAOfT
         V7gQ3So4vuQ5DogYKd2GXGEypce1BXdKt3D8DfORUAJ/NGun0/VdVMFNPRyVR7cyRG+e
         0Fcwl4CrXnsjh4YfdKhtSLB39ZgoCSKBoWO3yc+ea0XHWAWvpxy1hsUQU2AWhyyWfdo3
         Rk2g==
X-Forwarded-Encrypted: i=1; AJvYcCUd1tUHojNMicOa0C04TtYBEdmhazuapHH0mzjlRaqm9s3HkBGl01vDLsp9JGrEGbDY62k/jTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMdOHUqC5O8y7++iasB855CfPJSPlUdAa6qdzKlnDuUuPxMmj
	iNVfY5el7dcMG1V6Vqz419gJ1m9RQzNuQYORxaX6VOArhcxxib1wR7RQ
X-Gm-Gg: AeBDieueHMYhyEeD0VfSHLXN50jqbrIwPW/XOK2hXNk9t+xWhJCbufsLdwb85R5zMXF
	tUiejmJp16hJwC7FTe7zw/wxcwww2lVLTwFgRSkUowi4YKl6UauXGWgiOHK5eY1v3wJS8VadvLa
	yj0T7pFj4wv5K8qga7OQvIJuvCKAhDyu+ZyNm0MnTbYSZKrGfbPNFNyTgiGqzvd3FXv07jqlHoL
	zoUQNbGN55wwzqCNcKOHJ5v+612CS0bu6AYrKhyw8B97H+LDMPXg9g0qMWLqMhLT3SN+gPTjF2h
	XUpjgy4lW9iNNPRhhLyEKhp6i4P2B5fmVP2zaGcrqESxwicAJoWdvzUnCDI2d+YSzPAVY8UW2uu
	X/dt2hzwdlaE/Se+1wnid9wpCij1JWewAxf694OnJPGEghzbonM/n9sgx9kfnbuaFt1TlTubM29
	kCw37bRt87/AVCwNFo+KgTQmfE3+afauaUz0eI7MNkT3w+yfC5N3Nv0i9GIZLM67vpaQm3ODIhN
	J1L
X-Received: by 2002:a05:690c:110:b0:7a4:80ce:825e with SMTP id 00721157ae682-7a4d41b66d1mr68237397b3.25.1775315296259;
        Sat, 04 Apr 2026 08:08:16 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e228f75sm32114967b3.10.2026.04.04.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:08:15 -0700 (PDT)
Date: Sat, 04 Apr 2026 11:08:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.aa6e2a3e845d@gmail.com>
In-Reply-To: <20260403233240.178948-3-joe@dama.to>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-3-joe@dama.to>
Subject: Re: [net-next v2 2/3] selftests/net: Test PACKET_STATISTICS drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275390-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D60CA39B82D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> Extend psock_snd to test drops by setting a tiny receive buffer and
> sending a large burst of packets.
> 
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  tools/testing/selftests/net/psock_snd.c  | 48 ++++++++++++++++++++----
>  tools/testing/selftests/net/psock_snd.sh |  5 +++
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> v2:
>   - Remove do_tx argument and use global cfg_drop instead
> 
> diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> index 5be481a3d2bd..81096df5cffc 100644
> --- a/tools/testing/selftests/net/psock_snd.c
> +++ b/tools/testing/selftests/net/psock_snd.c
> @@ -39,6 +39,7 @@ static bool	cfg_use_gso;
>  static bool	cfg_use_qdisc_bypass;
>  static bool	cfg_use_vlan;
>  static bool	cfg_use_vnet;
> +static bool	cfg_drop;
>  
>  static char	*cfg_ifname = "lo";
>  static int	cfg_mtu	= 1500;
> @@ -49,6 +50,8 @@ static uint16_t	cfg_port = 8000;
>  /* test sending up to max mtu + 1 */
>  #define TEST_SZ	(sizeof(struct virtio_net_hdr) + ETH_HLEN + ETH_MAX_MTU + 1)
>  
> +#define BURST_CNT (1000)
> +
>  static char tbuf[TEST_SZ], rbuf[TEST_SZ];
>  
>  static unsigned long add_csum_hword(const uint16_t *start, int num_u16)
> @@ -212,13 +215,14 @@ static void do_send(int fd, char *buf, int len)
>  	if (ret != len)
>  		error(1, 0, "write: %u %u", ret, len);
>  
> -	fprintf(stderr, "tx: %u\n", ret);
> +	if (!cfg_drop)
> +		fprintf(stderr, "tx: %u\n", ret);
>  }
>  
>  static int do_tx(void)
>  {
>  	const int one = 1;
> -	int fd, len;
> +	int i, fd, len;
>  
>  	fd = socket(PF_PACKET, cfg_use_dgram ? SOCK_DGRAM : SOCK_RAW, 0);
>  	if (fd == -1)
> @@ -242,6 +246,10 @@ static int do_tx(void)
>  
>  	do_send(fd, tbuf, len);
>  
> +	if (cfg_drop)
> +		for (i = 0; i < BURST_CNT; i++)
> +			do_send(fd, tbuf, len);
> +
>  	if (close(fd))
>  		error(1, errno, "close t");
>  
> @@ -290,6 +298,7 @@ static void do_rx(int fd, int expected_len, char *expected)
>  static int setup_sniffer(void)
>  {
>  	struct timeval tv = { .tv_usec = 100 * 1000 };
> +	const int one = 1;
>  	int fd;
>  
>  	fd = socket(PF_PACKET, SOCK_RAW, 0);
> @@ -299,6 +308,10 @@ static int setup_sniffer(void)
>  	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
>  		error(1, errno, "setsockopt rcv timeout");
>  
> +	if (cfg_drop)
> +		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &one, sizeof(one)))
> +			error(1, errno, "setsockopt SO_RCVBUF");
> +
>  	pair_udp_setfilter(fd);
>  	do_bind(fd);
>  
> @@ -309,7 +322,7 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "bcCdgl:qt:vV")) != -1) {
> +	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
>  		switch (c) {
>  		case 'b':
>  			cfg_use_bind = true;
> @@ -323,6 +336,9 @@ static void parse_opts(int argc, char **argv)
>  		case 'd':
>  			cfg_use_dgram = true;
>  			break;
> +		case 'D':
> +			cfg_drop = true;
> +			break;
>  		case 'g':
>  			cfg_use_gso = true;
>  			break;
> @@ -367,11 +383,23 @@ static void check_packet_stats(int fd)
>  	if (getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &st, &len))
>  		error(1, errno, "getsockopt packet statistics");
>  
> -	if (st.tp_packets != 1)
> -		error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
> +	if (cfg_drop) {
> +		/* PACKET_STATISTICS reports all packets seen (including
> +		 * drops) in tp_packets
> +		 */
> +		if (st.tp_packets < st.tp_drops)
> +			error(1, 0, "stats: tp_packets %u < tp_drops %u",
> +			      st.tp_packets, st.tp_drops);
>  
> -	if (st.tp_drops != 0)
> -		error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
> +		if (st.tp_drops == 0)
> +			error(1, 0, "stats: expected drops but tp_drops == 0");
> +	} else {
> +		if (st.tp_packets != 1)
> +			error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
> +
> +		if (st.tp_drops != 0)
> +			error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
> +	}
>  
>  	/* verify clear on read */
>  	memset(&st, 0xff, sizeof(st));
> @@ -396,6 +424,11 @@ static void run_test(void)
>  
>  	total_len = do_tx();
>  
> +	if (cfg_drop) {
> +		check_packet_stats(fds);
> +		goto out;
> +	}

Sashiko pointed out that there may be a race here between rx
processing in the softirq and check_packet_stats. Seems plausible.

>  	/* BPF filter accepts only this length, vlan changes MAC */
>  	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
>  		do_rx(fds, total_len - sizeof(struct virtio_net_hdr),
> @@ -405,6 +438,7 @@ static void run_test(void)
>  
>  	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
>  
> +out:
>  	if (close(fds))
>  		error(1, errno, "close s");
>  	if (close(fdr))
> diff --git a/tools/testing/selftests/net/psock_snd.sh b/tools/testing/selftests/net/psock_snd.sh
> index 1cbfeb5052ec..b6ef12fad5d5 100755
> --- a/tools/testing/selftests/net/psock_snd.sh
> +++ b/tools/testing/selftests/net/psock_snd.sh
> @@ -92,4 +92,9 @@ echo "raw gso max size"
>  echo "raw gso max size + 1 (expected to fail)"
>  (! ./in_netns.sh ./psock_snd -v -c -g -l "${max_mss_exceeds}")
>  
> +# test drops statistics
> +
> +echo "test drops statistics"
> +./in_netns.sh ./psock_snd -D
> +
>  echo "OK. All tests passed"
> -- 
> 2.52.0
> 



