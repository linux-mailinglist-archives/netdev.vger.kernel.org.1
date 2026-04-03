Return-Path: <netdev+bounces-275112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBrLNV/gz2kS1gYAu9opvQ
	(envelope-from <netdev+bounces-275112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39790395E84
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33772304289D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E93C3BF1;
	Fri,  3 Apr 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X65IIqZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28134F48C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230633; cv=none; b=JQDYdHPqKZiwmzxRQBiJDV0Oe4chzH5TyYIgm1S2cDm9xzO+8vf5ugzwNrEgla9IoAPs7fSCOHwXu6KyRvbW+QiW8rIuCv1b7gwaAOu8gfm0mpIiaa8yfAFsY2eQ76/BL+2phT9k3hkL1whLiI3hrep+iMVIJcTzg9dbRQvyLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230633; c=relaxed/simple;
	bh=YZ9x9LlQUdaWzhrdGk3G6BEBa/K0v+Vx0017f8NKskQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ro8k3ybvNKnc7XOw4diWQvltSEbCNYS+/iVcN/LeLtRgQCbVUpJEEETWlfoEHRo1TDhtlkaPWyzJNBrIpkvVt7uSTNLyrifh9jtoSIPrvlUTC2NiZbfewafqHodz57/ID8lfAhSAHpjTwEcTPSsM5tCTh/nHHTMtkyvpP0h2cvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X65IIqZe; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6500040f128so1846342d50.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230631; x=1775835431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpuvJuy/tFtXZE3ikq8tJ0F1YYf2MuYLH559k2dBC5U=;
        b=X65IIqZeuVffj6BLMsybZKW9d7TTWuCd9/LMImdp7VgmNlg3MlwLn6+In6wGr3V2lK
         jiFdCpcDAcyFszfFS45ZN5nC1p6kRYNNlo2uTKDV3c4IQIO9Nr31gFDvgAJ1WortHWaG
         0Gzo9EqJRijdNOjpmRVpHiQqWQi3trkclj9lvI6eSLf+7AdIGqmifqULjOWAKIf435iI
         LEQ8Ns/Cp7jDXaMRNtVt6obbsZhX4wU7mp13Vj6fC/fihrv+b/AGYZrwASnaWt/ZHbGd
         0wTpb9oeFg5fBZ2ZzD7f/03qyxklPCHg8swgOC+t26uiDUaKTzDsBvRoO0aQ8gdvYqK2
         Eo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230631; x=1775835431;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpuvJuy/tFtXZE3ikq8tJ0F1YYf2MuYLH559k2dBC5U=;
        b=dmx7kc2q6Xl3+HgwexoZiNkD5Jwl3OlkzXGlc2Lq9DURvzYUsL0UKa/S6dOB8qgkGm
         IHXomVWc7rmnPjaH49J8UkIOMFw2d+ejIYKc3czPCcYl81RFJIxQ9ff/lIt6hjUll5WD
         EWeYRulAGK0NIsQ0UDCBmrIMzMSnjeICYh00LbQOeiSkqh+1/vdbA4P5F2nb2/QGca1b
         3TYytBkLPRKavHenynZpFLDp2URFuKQ8DpkSebpP2bLSNm6H0PV7tEnWjfGLvH3SqytM
         sf3w8PknKV0R+YzpbzxRP5amF49txL0Jx6EOXTj7Ve1FboRhyQQ4bkLAN0tYdUyBgXLL
         Kpiw==
X-Forwarded-Encrypted: i=1; AJvYcCXkkz8eNl9H9FizYIVCpl+JAhimobRbjvnIWmHHVH+lvmRTNw4LNcRUP+VM6at0E982vUJXX2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nMNsaCCy2iL8fPY8OkN/W811ezSmS5sFn5lk+ESkPTLKhpuE
	tXuRV9KP4GItt+OqA0DfApoOqosWc8JBegDum7bDj0rLuRY1JJxDPZVh
X-Gm-Gg: AeBDieskBuIZKgRo1LMxez/hOPAzPH56nfy6G2yEBUPsyJnwMC3uIy7u3Bqbz68lzjK
	5ob87oOJZQvmTp8yrXq674f4IZv3Vj4MVuk5PdXEnNSMxK4COdN9M0IsMMiHI3hbps8S+Lim5ms
	HOWJ553htuJYRW+pDrQ3WnH7kioBJ/KxqC3rIUK+YWwV9nfW16ZCC9eydOdUxGp+5YLcP4vIkB/
	Rq+dEutcQl7UAZb8KaSBOsfwiN1Qilj15Hl8vPA8R1BGJpKJiRlIXwDMWHnAcU5Al93VAqRgey6
	b4SlauBzFtvPPQSbBi1x2i8bwQseKixk2xP9Lz6RlCZv7Hum8ahtQqjg270roQxPpWTo83EX5mE
	GTaHdeHzOwJGaLgDoQni5cBpKWBElJeRHMufl5ufKkFiUxhHiQJcfDq1V3fyay4n518DFUdyCBe
	IYKhe5ugN+mZAfvBWk2lJJ5hYa5P1AwiaMgNnGtsB9eEMfYw4zQUOs9jS+7Pqu2Or+EZrQo5Mzq
	Mqg
X-Received: by 2002:a05:690c:dd4:b0:79a:b75e:1509 with SMTP id 00721157ae682-7a4d6158cbamr36144717b3.43.1775230631157;
        Fri, 03 Apr 2026 08:37:11 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3709075besm22668317b3.25.2026.04.03.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:37:10 -0700 (PDT)
Date: Fri, 03 Apr 2026 11:37:10 -0400
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
Message-ID: <willemdebruijn.kernel.fd5e56c96ff3@gmail.com>
In-Reply-To: <20260402232203.2004496-4-joe@dama.to>
References: <20260402232203.2004496-1-joe@dama.to>
 <20260402232203.2004496-4-joe@dama.to>
Subject: Re: [net-next 3/3] selftests/net: Test PACKET_AUXDATA
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
	TAGGED_FROM(0.00)[bounces-275112-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39790395E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> Extend the packet socket selftest, adding a recvmsg path, to test
> PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.
> 
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  tools/testing/selftests/net/psock_snd.c  | 57 ++++++++++++++++++++++--
>  tools/testing/selftests/net/psock_snd.sh |  5 +++
>  2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> index 7bbce274b9f0..682e0afe364d 100644
> --- a/tools/testing/selftests/net/psock_snd.c
> +++ b/tools/testing/selftests/net/psock_snd.c
> @@ -40,6 +40,7 @@ static bool	cfg_use_qdisc_bypass;
>  static bool	cfg_use_vlan;
>  static bool	cfg_use_vnet;
>  static bool	cfg_drop;
> +static bool	cfg_aux_data;
>  
>  static char	*cfg_ifname = "lo";
>  static int	cfg_mtu	= 1500;
> @@ -281,9 +282,26 @@ static int setup_rx(void)
>  
>  static void do_rx(int fd, int expected_len, char *expected)
>  {
> +	char cmsg_buf[1024] = {};
> +	struct msghdr msg = {};
> +	struct iovec iov[1];
>  	int ret;
>  
> -	ret = recv(fd, rbuf, sizeof(rbuf), 0);
> +	if (cfg_aux_data) {
> +		iov[0].iov_base = rbuf;
> +		iov[0].iov_len = sizeof(rbuf);
> +
> +		msg.msg_iov = iov;
> +		msg.msg_iovlen = 1;
> +
> +		msg.msg_control = cmsg_buf;
> +		msg.msg_controllen = sizeof(cmsg_buf);
> +
> +		ret = recvmsg(fd, &msg, 0);
> +	} else {
> +		ret = recv(fd, rbuf, sizeof(rbuf), 0);
> +	}
> +
>  	if (ret == -1)
>  		error(1, errno, "recv");
>  	if (ret != expected_len)
> @@ -292,6 +310,31 @@ static void do_rx(int fd, int expected_len, char *expected)
>  	if (memcmp(rbuf, expected, ret))
>  		error(1, 0, "recv: data mismatch");
>  
> +	if (cfg_aux_data) {
> +		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> +		struct tpacket_auxdata *adata;
> +
> +		if (!cmsg)
> +			error(1, 0, "auxdata null");
> +
> +		if (cmsg->cmsg_level != SOL_PACKET)
> +			error(1, 0, "cmsg_level != SOL_PACKET");
> +
> +		if (cmsg->cmsg_type != PACKET_AUXDATA)
> +			error(1, 0, "cmsg_type != PACKET_AUXDATA");
> +
> +		adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
> +
> +		if (adata->tp_net != ETH_HLEN)
> +			error(1, 0, "cmsg tp_net != ETH_HLEN");
> +
> +		if (adata->tp_len != expected_len)
> +			error(1, 0, "cmsg tp_len != %u", expected_len);
> +
> +		if (adata->tp_snaplen != expected_len)
> +			error(1, 0, "cmsg tp_snaplen != %u", expected_len);
> +	}
> +
>  	fprintf(stderr, "rx: %u\n", ret);
>  }
>  
> @@ -312,6 +355,10 @@ static int setup_sniffer(void)
>  		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &one, sizeof(one)))
>  			error(1, errno, "setsockopt SO_RCVBUF");
>  
> +	if (cfg_aux_data)
> +		if (setsockopt(fd, SOL_PACKET, PACKET_AUXDATA, &one, sizeof(one)))
> +			error(1, errno, "setsockopt PACKET_AUXDATA");
> +
>  	pair_udp_setfilter(fd);
>  	do_bind(fd);
>  
> @@ -322,8 +369,11 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
> +	while ((c = getopt(argc, argv, "abcCdDgl:qt:vV")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			cfg_aux_data = true;
> +			break;
>  		case 'b':
>  			cfg_use_bind = true;
>  			break;
> @@ -436,7 +486,8 @@ static void run_test(void)
>  		check_packet_stats(fds);
>  	}
>  
> -	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
> +	if (!cfg_aux_data)
> +		do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);

Slight preference to instead detect that this is a read not from a packet
socket and skip the cmsg processing inside do_rx as a result.

A roundabout way would be using getsockname. Simpler may be just to pass a new
boolean to do_rx is_psock or os.

