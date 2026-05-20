Return-Path: <netdev+bounces-289686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MHPGZwODWpyswUAu9opvQ
	(envelope-from <netdev+bounces-289686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD45868AE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C663014131
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1E2DF137;
	Wed, 20 May 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX6wOPGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C912DE6E6
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240567; cv=none; b=I8VZhlkjvRuFytXm60pgTdT066DVcCAAL1fvQhWCi7L8iFZNm724fQ8oX7fIJWZJNDuFHWyK5iB6v/HIbUcbUfFa941fvkUjAMl07j/nR9IXxVm22r936ErMHSQ10n0duSfvZPRYg3jfChtMtPem0KPekq0lOSwK2yIsyu2osB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240567; c=relaxed/simple;
	bh=Hu8zDtNMBrc+5wbcvkAIfyDm9uV2mGXXKMSxc6qL+20=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hKqIbRO8OpF66M98+UMvrYeMbgtAWCMnHXs2cxxyFYyqn0lVOIu9FMNrOV5sMYiXrqqieQmoVPkClZL73EIplPBuyiwzA1EF5sSp5ZC+qT7anpjwAFfoQ5EQiDEvU2DUoPOdw3uePQozDQdRpQPSeJTcubFLMpakKD+UkRJkA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX6wOPGa; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651d6347a69so5645394d50.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779240565; x=1779845365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sfqAEdhlbXdhpv1B5LAHbRnjd4l+/snCkCwOb+8Uak=;
        b=EX6wOPGavDrsdCuR63gKKcnoevZM++5ttJL3BPMRqMuXwBh5VnYTeTpSTETXaYSjya
         Mg8fP2F1ZfaCvLXO3T+atC/yVZ8EdZBkYKR+RmfiES2DkwGk8W3nd0w6aRvq05qYqc99
         1HdhZqD/KGoU+8w+Sfez3blZNgNgzwPRBco1RPzOTB1Z2zZbw0ckCnc6QvBgRxHKEyyz
         X66pDDbYynNMTTvLfS7MVryxKXxTkVn5tmVWd1N21sonFoIBTdNwKeZKS0nwQlI4lQ5/
         Np6V77T87qrcKNPSP1FSEyJo76JYLu+Dnm3zd4ORznPf/v77UZ2nemn/lrg7nEbsSONP
         WKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779240565; x=1779845365;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sfqAEdhlbXdhpv1B5LAHbRnjd4l+/snCkCwOb+8Uak=;
        b=bCJc3Uc1+098/jBEIfW2Ch41egYegbEXlWVpDwS0GyyoRy3VYUaj/U+k/xKJ3FEEKl
         6rkdy/H4dY1t3XixFa4WZpDzbuRbsIxQOtdZF9gm6kQbLRYdJAjMFnurOeYOihZeAkS1
         642ALz7gM5yutQ5k+xYxZxKuoCZ0P3YIfO4P+zjrHXzp0RLtWPHMdhhmukzoBqIYz3Qj
         Ve1E5RBvJYK3gK3wjoWYXDJG99fR1u5xjtlb3Oy/7oxVoDI76S5Bui/MfPSu8JlKoyZ2
         jYBE1HXxy8Zs2+Q1md7ORaKi9/9VgmWo4mZZaPPO4N6KO08OXjSA5OIGp0ZPj4eob3hv
         bhzA==
X-Forwarded-Encrypted: i=1; AFNElJ9E4JLpCTpvdz+VBrN3T30o+h7jMrjWx9yzsz3fbOAQ77Dzp/I6tZSAo9ctZjDg6iWxmPZjpWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqypLHQKCvegswZ04nwJknvoeDdW9H+/QnV7dYWHtvk+CCB7I
	CvA3WM8PjPwjLoS7q2Fkx0wTa2AIPma9dG2Cth9WHglucNB43BHrpB2i
X-Gm-Gg: Acq92OFpky9+5NowRKd+58dHaFECZd887NGA2oR62yKRcvl04tuqjoGuaD+YXs6WYbc
	mA+dfkhm4EbP5MXJbvX/892LYKs5T0fDx40oXqCmjWfaysVRlmE171S+Vv/DH7VuHAiPjg+uwjl
	plR23S+/wdjY/RghmBlQEqGkZV8QINe/d8IjGBLqR4ELeNo9IPkEzGpXUxw5tCAFrbpXV6sYM5z
	SRbNA2PGN9/NpbzFqpjVkaIrq3cyovCSE2ckwNUfNGnk7O1RmLZ++g/mQa+HS+zMW8g0ACszQ5E
	F7IuCLJPEGzQFm60QORqsPwEZPdzbLaZKNY0K8jP7lG6F+YvWxG6Vu0Tmo5ijlVBt3v+56Rt/bp
	PIsWrTSmFoMirwtbjIFmKavnRrxO42glCmOHfQrdqnY1CKs0nYHSayn7nG0XkjlKPGx4p9vqg2I
	ekexVywZQZzsQpgo/DAMwdqALQaDa0NHd2fkGO4Vr83yoDecEczwqIPw+9kELi8EJGCReeY/rQl
	hVawkrtVF2L45A=
X-Received: by 2002:a05:690e:134c:b0:65d:5702:3383 with SMTP id 956f58d0204a3-65e0b2f68f1mr20974182d50.43.1779240564832;
        Tue, 19 May 2026 18:29:24 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b124sm8657617d50.6.2026.05.19.18.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 18:29:23 -0700 (PDT)
Date: Tue, 19 May 2026 21:29:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Federico Brasili <federico.brasili@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, 
 netfilter-devel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.fc94e94f7ffd@gmail.com>
In-Reply-To: <20260519132535.3806659-1-federico.brasili@gmail.com>
References: <20260519132535.3806659-1-federico.brasili@gmail.com>
Subject: Re: [net] AF_PACKET PACKET_VNET_HDR CHECKSUM_PARTIAL packets bypass
 ct invalid classification
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
	TAGGED_FROM(0.00)[bounces-289686-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4BD45868AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Federico Brasili wrote:
> Hello,
> 
> I would like to ask for feedback on a possible checksum/conntrack inconsistency in the AF_PACKET PACKET_VNET_HDR transmit path.
> 
> A locally injected IPv4/UDP packet with an invalid raw UDP checksum is classified as ct state invalid when sent as a normal AF_PACKET raw frame. However, an otherwise equivalent packet sent through AF_PACKET with PACKET_VNET_HDR and VIRTIO_NET_HDR_F_NEEDS_CSUM is not classified as invalid and is delivered to a UDP socket, even though packet sockets still observe the UDP checksum field unchanged and report CSUMNOTREADY.
> 
> Minimal behavior observed:
> 
> 1. RAW_BAD
> 
> AF_PACKET raw frame
> UDP checksum field: 0x1111
> 
> nft:
> ct state invalid counter packets 1 drop
> udp dport 12345 counter packets 0 accept
> 
> UDP socket:
> no packet received
> 
> 2. VNET_BAD
> 
> AF_PACKET + PACKET_VNET_HDR
> VIRTIO_NET_HDR_F_NEEDS_CSUM
> csum_start = 34
> csum_offset = 6
> UDP checksum field: 0x1111
> 
> packet socket:
> PACKET_AUXDATA reports CSUMNOTREADY
> UDP header still contains checksum 0x1111
> 
> nft:
> ct state invalid counter packets 0 drop
> udp dport 12345 counter packets 1 accept
> 
> UDP socket:
> packet received
> 
> A trace of the VNET case shows the packet being converted to CHECKSUM_PARTIAL and reaching conntrack/UDP in that state:
> 
> skb_partial_csum_set(... arg_start=34 arg_off=6) = 1
> XMIT      ip_summed=3 csum_start=36 csum_offset=6
> NF_CT_UDP ip_summed=3 csum_start=36 csum_offset=6
> UDP_RCV   ip_summed=3 csum_start=36 csum_offset=6
> UDP_QUEUE ip_summed=3 csum_start=36 csum_offset=6
> 
> The relevant path appears to be:
> 
> net/packet/af_packet.c
>   packet_snd()
>   tpacket_snd()
>   __packet_snd_vnet_parse()
>   virtio_net_hdr_to_skb()
> 
> include/linux/virtio_net.h
>   __virtio_net_hdr_to_skb()
>   skb_partial_csum_set()
> 
> The same behavior was also reproduced through PACKET_TX_RING + PACKET_VNET_HDR.
> 
> An explicit nftables rule such as udp dport 12345 drop still works correctly, so this is not a general firewall bypass. The observed difference is specifically around checksum-invalid classification: raw invalid packets are treated as ct state invalid, while PACKET_VNET_HDR/NEEDS_CSUM packets with the same invalid raw checksum are not.
> 
> My question is whether this is considered intended behavior for locally injected CHECKSUM_PARTIAL skbs, or whether AF_PACKET should reject or normalize this case before the packet reaches conntrack/UDP.

This is expected.

The VIRTIO_NET_HDR_F_NEEDS_CSUM flag on transmit indicates that a
checksum hardware offload (CHECKSUM_PARTIAL) is to be programmed.
The sender will include checksum start and offset instructions.

Handling of CHECKSUM_PARTIAL skbuffs inside the kernel is described at
the top of skbuff.h. Note the section on receive processing, the point
about "are considered verified":

 * - %CHECKSUM_PARTIAL
 *
 *   A checksum is set up to be offloaded to a device as described in the
 *   output description for CHECKSUM_PARTIAL. This may occur on a packet
 *   received directly from another Linux OS, e.g., a virtualized Linux kernel
 *   on the same host, or it may be set in the input path in GRO or remote
 *   checksum offload. For the purposes of checksum verification, the checksum
 *   referred to by skb->csum_start + skb->csum_offset and any preceding
 *   checksums in the packet are considered verified. Any checksums in the
 *   packet that are after the checksum being offloaded are not considered to
 *   be verified.

