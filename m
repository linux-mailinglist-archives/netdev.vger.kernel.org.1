Return-Path: <netdev+bounces-275106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKp/GZzcz2mn1QYAu9opvQ
	(envelope-from <netdev+bounces-275106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:28:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21BF395C55
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BCD13080F83
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D33C7E1F;
	Fri,  3 Apr 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnSFXxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D937B011
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229965; cv=none; b=utazRbP50JZnmuTcAfFXD3+cPSSd4rNet0icgmxHP7Cgr0N/neAkgFCHhutcCy+Djg+Eh9im2w/1MKRGV92gtVR/1rTzTAOtRhUeKKEtLys48j5fIHoXOKMwRlaXo/ttB0Gbd22zyGjH/oQ/0Uffr2qsnc/wyvB/pndMyzqCHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229965; c=relaxed/simple;
	bh=/iuUiBKd/QehSumXg68bTOYBxK/MWSEcoYlGJ5L4Wi4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lsQqIXEg6900Eh+p9Fqm1c5A34DXRWP2gZKj6Y/Er7/w2v96KTvV3gPeBeRE4HnPbfwjQNjSLADYC8pkUo86w5g7uYKUBDJVUvb+ac7m6s0gU1rIcYqjm5dAz94osQN43BxezM9ife+KnvT0dXNEGpxYemlVDGGWNI4vmDQmw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPnSFXxx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7a43424f861so16717987b3.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775229962; x=1775834762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phgEzarmetA3rPcVDi8C467Z7leoFPBcCeNvveOYnOE=;
        b=hPnSFXxx15dfsYGWgXmJoQPNdxqnS+jk29YdsNJwJJKvnpCuyaEZBSVqXi2yVOvr7l
         emsXExVs9Rysc4ukhZMufx5+2b5CGD5n5zJiwIyzNaDx3gCt4+TawoGbcKBeFpxlIpxP
         CcwFnyi+SPBH3DeVIsgBth9xu1U12YiZ/L+ZgXxYHAFHmv/SR/n4HtXnSUlYlT5wPh6E
         gppzDIigx1L4rRyjYfC2KsfTJlqUE2YfMcb9z7DBxB12EI1WnjnGZdspw1FeuA43a71G
         rNgcA7HQxKwgVCiDiNnmN1QvcljMY3bONR12k9aoh+/IVZVY+sGyy99tt4dh7Hm+bdFS
         +pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229962; x=1775834762;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phgEzarmetA3rPcVDi8C467Z7leoFPBcCeNvveOYnOE=;
        b=CF1lKDE66REvCRs6ym2BgT+nOBMGmfW5GIXbrv3uiyk5xNid2eniBn6nACeG2+9mui
         g7g/z73veGYkD+Z9MhvAhn40UuKLt1eq/Qhsh0Ye2w1DxlrrGMo105+4JfQRWH3iejvW
         iLQhJ/GgIk1Jwkk7zIPD+7KA/qsSejBB/0aw3iwj0RGb1B1McdgXNTMfj442wfjRkveR
         xc/iMuoY32pIj/txTDm50PpSyGyjCC1PQiQkzqCsk4mBPK6fP6LDJgTIpOk9YeWvwlWb
         IswG92RwKx2nE+fkLSteIs/Gm3Km2+c0zTfDeKFWrAEXXz88IlzdyFu9tZVoGeMRlddE
         szug==
X-Forwarded-Encrypted: i=1; AJvYcCXnnbMBUyooDT+KVNbpMCh9qERxiO2WoVYf3l+XMYUjYDhuu/6vAD6QvB52ouJrgDhnvwJNb5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkscAxpvBH1/vGO+aAgO5VWg77GYkD6DEffJdCkt4Rbk2ADgK
	kMxTQTj+Aae87i7RktlLdunGPpUxzBHVr0wLurZC+L0fGZQtAOMn9ue9
X-Gm-Gg: AeBDievCP9jLrfbTk/o+KcQDhywfvi7V++qVfJLd1f3q2RBmR+Ao3RKdHnxoTnbH8k0
	2OsHTsi5TD4/gKlwg9nmQ86SCd4+Xu+01RouXzhuSJHAhSGAMywh8ku6V3A4ob00P9zjLRUDYmc
	jBsr+7aqnO4NUhMxoQPSXwxP2QsUZYnejIkuQ015s4HBZG5jXI0JlP7UNn4OTVl6EOKdzAwlCvM
	Qn6IL1hudbx2RyrLpXKPk2cISpfnxFvi71g5ptFoYHsnb3Wln20yrTt3tXXE3k1CESJArsYwp+0
	lLHev4ejhLLRZl8mIzdQkt1yce5jLXzd+UmI29Jfuu4bulpivb2kfJ3q/tYRSe7RdXqCeYAqDej
	nv7INbNogng0m+zvgVW/5Vl/69mo8mIUPsLDa1syk2vkPaFUMjyLHL60zV/99XAdjq66hp7J+ST
	Uo8poHwYPUQmzR+EZlrtz3Y397eNQtELbpPmZiSJJrW/iNYdZVCzbIxNfyilq6Z166/7B1BCVUJ
	8xO
X-Received: by 2002:a05:690c:d96:b0:79e:8d95:7ebb with SMTP id 00721157ae682-7a4d3ac7a7fmr35626207b3.14.1775229962152;
        Fri, 03 Apr 2026 08:26:02 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e229135sm22909397b3.3.2026.04.03.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:26:01 -0700 (PDT)
Date: Fri, 03 Apr 2026 11:26:01 -0400
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
Message-ID: <willemdebruijn.kernel.886450145305@gmail.com>
In-Reply-To: <20260402232203.2004496-3-joe@dama.to>
References: <20260402232203.2004496-1-joe@dama.to>
 <20260402232203.2004496-3-joe@dama.to>
Subject: Re: [net-next 2/3] selftests/net: Test PACKET_STATISTICS drops
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
	TAGGED_FROM(0.00)[bounces-275106-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F21BF395C55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> Extend psock_snd to test drops by setting a tiny receive buffer and
> sending a large burst of packets.
> 
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  tools/testing/selftests/net/psock_snd.c  | 52 ++++++++++++++++++++----
>  tools/testing/selftests/net/psock_snd.sh |  5 +++
>  2 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> index 5be481a3d2bd..7bbce274b9f0 100644
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
> -static int do_tx(void)
> +static int do_tx(bool burst)
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
> +	if (burst)
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
> @@ -394,7 +422,12 @@ static void run_test(void)
>  	fdr = setup_rx();
>  	fds = setup_sniffer();
>  
> -	total_len = do_tx();
> +	total_len = do_tx(cfg_drop);

only if respinning: no need to pass global cfg_.. variables through
function arguments.

> +
> +	if (cfg_drop) {
> +		check_packet_stats(fds);
> +		goto out;
> +	}

can this not use the check_packet_stats added in the previous patch
right below?

>  
>  	/* BPF filter accepts only this length, vlan changes MAC */
>  	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
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



