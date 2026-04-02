Return-Path: <netdev+bounces-274294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFa4AUa4zWkLgAYAu9opvQ
	(envelope-from <netdev+bounces-274294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:28:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0A382000
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E5530388D2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45F1DF27D;
	Thu,  2 Apr 2026 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZyxaZhF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5B1DED42
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089729; cv=none; b=a1633yN/9FUdCRco2TZAQg3E7yKGmpnelWkjGZ4POYzp0Cn6cDtj2386WJLpTeNwAjimLH/lJe/lL304pBCYdSSqWZwOFRrygIs+8Rj2SvMIG8vdaPZWQb9WZEeQ5KlV2FAEsqfkxhlM8xd8rvKZBNTomnfOqAfQAd77uYX1q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089729; c=relaxed/simple;
	bh=NsFHEc9cLIhxwHd8GCARIIYerKt25yqMowBZFNTuQ6s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B/r4sRBypoSnJwq67jiAVpAzKHFjQIBM0pSWArnP8lWUBoeXVfRBeca0eL5AT8N6AyB9Grf9H3q7BoMgQ1JebuWlRbFMAUSoTOcHbPfbrUF4c2noRwYnyHYhPneyzZKDr7fjXk1ymkRkNyURku8h9rtKD9oVKiNYWGOsod1Ybmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZyxaZhF; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501d32b04bso362022d50.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089727; x=1775694527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG+TGuMH7iRqP+SEgh1/fCjYkx8AoXZpEYux/97XIDg=;
        b=qZyxaZhFXBrp9Fddl2ELPB719MzoC7PMpKO3lEqRjpVNhgB03tJSQ15MbjrZCTrYpd
         7bVwTOwVBsgqAjsc+mR/XfDAPAAoCvKz/Vawi4KSiPScE5cf7ujXW56dCmgPV85pDlQX
         siCSwO3UKCVyVwyO2bk3pB/I7eRYOlZSy/j8sRnp/dN0i55IxH9QdVzDLRS4rVF3QVNU
         BPIFeexvp0tCeGEPthVnfZfekgiFYP+B04NLnNGmjBBU7vPbyrrtuH5//zjBHcLBrrMe
         QTui1ZeZi6rPhL1JmbSk+fz59GdU0WM1aqVPqmHgbQU+oUxGmENtMdkHVNOyOrN4aI9l
         On9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089727; x=1775694527;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EG+TGuMH7iRqP+SEgh1/fCjYkx8AoXZpEYux/97XIDg=;
        b=rZ8qTRdLl9tbcnXPAXyBbHXAMs5e9C51cfp3n+vf3X7jWvBtxUS7R9ZgPokKR7Inb/
         WydNUbKpOCE5MAt9rhDx/bryAWkfHoB3b+BqHQk0Zbu8p29L/a639dOMVL51FhQeg4vf
         vVxOqIDam5c4djO3nTt0/P03a374dkojvy1AKJJNKE6S6uYDgMww24GybkiWiSnowx2s
         E2ZCRYhW/6yHY/5eKdTs2TDGUsqLJjXO4b30vRrJzR23xldEY8Z7G0RrSNW0Vj5OgpLE
         eo9vIdug8RzrxUKhrgJW9CgfrzyEMk/xLSkEKOzqSxfSr6EHZv4dFu7LRStPFEA83UG4
         BLYg==
X-Gm-Message-State: AOJu0YxPg18W1GNcKHmho9pFNIsPoFxhHYYI7i4ZQHR25tpNxk9rxtZN
	ZhVIzroUL22INtbZ8HH6vqOsQ1zIqUhushGXGNfzsW7ZZVLtcGrCdo0h
X-Gm-Gg: AeBDievkQEVPOQGArfcCnQXrDyXeVLcGUrq+ambcswPhhpF5UwrN0SDU4wFYF5HjwKN
	8ijDgWJ8BOmb8sBjMR8hNiRKSwuP49wJXJC4IajgUXxUAnN2PcgclW+iryOZM5bILqiDfmjPxgv
	O1J4fWhg+ltGuwEWOiTvzyXgWOq0EIarnqfSDYSi8oeRx1l/rPhsz1ZbQfF77D2cx/70XTKiJHv
	puJEWTy5pyeTR3oNmCzPUXtZLqCXJerou3BDgjiGzpvR3NLvZarA5j+tg5ddyQ8N6o5hqNjSiNK
	gQK8DMWy/64rHuUgGlXUVChSWo3i1x70ODKBXmwIs/+fpPMD3QaPsHA8d2ocT72ZzE72cNgxN5A
	+069JMO5GgRdGs+DYZd8koLgP+/qLzseGdXxRHgrL6g8ONVRmXK5jzAOnN3B+ZvwPvl9JE0F41z
	J5NkpdsK1j03TXnKuW60LgHcF6H1y4ANysFbfG0+cnZNLiOZO8mBUohKsaW5SU+cYKDafj0YfeN
	pfP
X-Received: by 2002:a53:420d:0:b0:650:2257:e085 with SMTP id 956f58d0204a3-6502fde2b85mr3979331d50.30.1775089727443;
        Wed, 01 Apr 2026 17:28:47 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9cabaesm573157d50.18.2026.04.01.17.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:28:46 -0700 (PDT)
Date: Wed, 01 Apr 2026 20:28:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 anubhavsinggh@google.com, 
 richardbgobert@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.14f444719030c@gmail.com>
In-Reply-To: <20260401182625.372605-7-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
 <20260401182625.372605-7-kuba@kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: drv-net: gro: add a test for bad
 IPv4 csum
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274294-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC0A382000
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> We have a test for coalescing with bad TCP checksum, let's also
> test bad IPv4 header checksum.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/gro.c      | 25 ++++++++++++++++++++++
>  tools/testing/selftests/drivers/net/gro.py |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
> index 762e88932ed2..a458cfbd11eb 100644
> --- a/tools/testing/selftests/net/lib/gro.c
> +++ b/tools/testing/selftests/net/lib/gro.c
> @@ -36,6 +36,7 @@
>   *  Packets with different (ECN, TTL, TOS) header, IP options or
>   *  IP fragments shouldn't coalesce.
>   *   - ip_ecn, ip_tos:            shared between IPv4/IPv6
> + *   - ip_csum:                   IPv4 only, bad IP header checksum
>   *   - ip_ttl, ip_opt, ip_frag4:  IPv4 only
>   *   - ip_id_df*:                 IPv4 IP ID field coalescing tests
>   *   - ip_frag6, ip_v6ext_*:      IPv6 only
> @@ -675,6 +676,21 @@ static void send_changed_checksum(int fd, struct sockaddr_ll *daddr)
>  	write_packet(fd, buf, pkt_size, daddr);
>  }
>  
> +/* Packets with incorrect IPv4 header checksum don't coalesce. */
> +static void send_changed_ip_checksum(int fd, struct sockaddr_ll *daddr)
> +{
> +	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
> +	struct iphdr *iph = (struct iphdr *)(buf + ETH_HLEN);
> +	int pkt_size = total_hdr_len + PAYLOAD_LEN;
> +
> +	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
> +	write_packet(fd, buf, pkt_size, daddr);
> +
> +	create_packet(buf, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
> +	iph->check = iph->check - 1;
> +	write_packet(fd, buf, pkt_size, daddr);
> +}
> +
>   /* Packets with non-consecutive sequence number don't coalesce.*/
>  static void send_changed_seq(int fd, struct sockaddr_ll *daddr)
>  {
> @@ -1392,6 +1408,10 @@ static void gro_sender(void)
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  
>  	/* ip sub-tests - IPv4 only */
> +	} else if (strcmp(testname, "ip_csum") == 0) {
> +		send_changed_ip_checksum(txfd, &daddr);
> +		usleep(fin_delay_us);
> +		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  	} else if (strcmp(testname, "ip_ttl") == 0) {
>  		send_changed_ttl(txfd, &daddr);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
> @@ -1588,6 +1608,11 @@ static void gro_receiver(void)
>  		check_recv_pkts(rxfd, correct_payload, 2);
>  
>  	/* ip sub-tests - IPv4 only */
> +	} else if (strcmp(testname, "ip_csum") == 0) {
> +		correct_payload[0] = PAYLOAD_LEN;
> +		correct_payload[1] = PAYLOAD_LEN;
> +		printf("bad ip checksum doesn't coalesce: ");
> +		check_recv_pkts(rxfd, correct_payload, 2);

This verifies that a packet with bad csum does not coalesce to a valid
packet. Perhaps too paranoid but, do you also want to test the reverse
case?

Can be a single test by adding another write_packet and observing all
three separate packets.

