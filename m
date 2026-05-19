Return-Path: <netdev+bounces-289464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A4+Fz9nDGo9hAUAu9opvQ
	(envelope-from <netdev+bounces-289464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:35:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56F57FCA0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3750E302EBB6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868AE340408;
	Tue, 19 May 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQRmhD+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C743409625
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197299; cv=none; b=PG7kPcwGPUPf2M91toHirjnQlmCas1Y72S7K/fxjZzYaFijDdUah2qfXpVav2tdBzNx4S2AdJ4dPTPSXnxO0+q82XLvCeovumVtnDdK0RyQtNmXwyhw30c/4EBIFKBK6lf8Y+bWpdCltexBi6z4k+o/pqY9lWB7z0cm7UJ1tJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197299; c=relaxed/simple;
	bh=1/xVXZdKhAdlqMiTsVet9wqnGJk84XqklvnZCAnXSxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe6MQeNGqOV1X8giawg8WkM835k32RJ/VufRK8nPQFRPPwE0vcjVXqxo85vB40WbPTpxoka1UpdBuKG7bZSfW5kKEbz9Y+godnvdOg9d+KU9o9NBtLh5u2P9cbs8ca6uInt6/0ba8qjbC8Be6UajVStolUI6IimL7PqtqYms1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQRmhD+G; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b98482b253so60990136d6.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197296; x=1779802096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKPSUbsZSmEbkWfEx2IzJ+tvdP/7UtkEfOkK4Ns846w=;
        b=WQRmhD+GsTxM99UctZQImKqgMss9hTw9l2MQazpvr3FZstGLz2SoF8aFCc7AEAmW2a
         K66b7mlGX5NmdLmSghSl3eHBuV/kyl6w09MMtWRB3y7B6yTSx4j+YA0R4JuXj1jZOpRa
         xt+qKay8QxXQtfMWkW5L6BZkb0v8H4PNimVFZtjFB1Md9YMgOwC0HXxVBS45BxGRUs4T
         DEmL/2SGsuyUZPOWkj+VQQ9+wKxdksWVVYDtt06lLOqEZHLpikMppckjokUWNRHvc++K
         JOlaZ+JqRouTaKqLGV671E9kCRL0eDIBYU5CPm9J3JFf7dEwtcQCWX8P8qXj+FcIO2oL
         8nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197296; x=1779802096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKPSUbsZSmEbkWfEx2IzJ+tvdP/7UtkEfOkK4Ns846w=;
        b=G42amG4fGpz5M6MWRYojdmX/vUVvUYL/rmhqlpaXlI8TryDDfrS/Ovq1mA5/xECP+Y
         yOet2ahtcASnKvKOgG7ScPL0i5sGdb+jIGOvG2tIt01pFbfct5TURbuZQfcSNgE47Vj/
         r6JtUv286Ke5CF4cwfPaT2ertB3QelTkrUXC5fWFCveCa6Oon6pRZX8FQERjQfJdu1aL
         bTskwmHP2E8I3tsNbZ/b9cltzP0wlbmOtoOw7mUDAHheFvuyDhco+SIME0dpUsjcss9+
         VR81W9NOmawly6ouam6mfuIvI0quJvTyvcuJXKd9Z9eN3I+EHsUQhjHg57+3W7MIOxHI
         nX3w==
X-Gm-Message-State: AOJu0YxlAvTgUknxWvCVJYz/WN/7RkLzdzezaGcXoH4yv0T4Zfqr0F5N
	AU+NiyYphWC5n724EcnhbrhP52rAN0oMgEPaeoZiLsi4buJ/hnRX0lWjzPzSLw==
X-Gm-Gg: Acq92OHcWygoXkiR3QrwR+X6aQjhgPDj3UPcRis18QcoriMUkOPFpA+AHh1AU4XYlCb
	pNTl8xSKZXrrgPkKsytiOPbehBmFXGHDtOrVrfAXIx/r30eTvTB0SuHEs08CCZUA0FXdu+NyMys
	BlhoVpPEg3oABvdCo4F2HcP33MNBhkVlkoRoQHGWyOKJ56sbzEU2/Dq6MGnfnABzcUt+olAGVIZ
	lO6cWnB2ul8uEOWgKTz3C1hP8lkyLqavSeIeHO34TDI2rKOsBR1WJF0tZiphZrGri/H8Ks58aBF
	9I74tcWMGUuTtUk/9yyHWirBcvAEo51WtYYj9oFgTi30embIKx+0dbaTgWuL8XXM9sOejOXZp3l
	hsezfTZy3gW5WWhTskon1kLDeA7FOkFTRJV32IkTzEDQaiqmSHMiz7beCr6uXq1fQVMQiis67Jw
	PFswiG5l9iLcSTIlolhDS5HyzI5rFG+UZG9Za08BimaF2KnYrOYF2qDQqII6sZ5dmZvRolTJHJV
	84UDEQJYKC7v3rqjVRSV9rumT7ylPs=
X-Received: by 2002:a05:6214:8085:b0:8b0:2017:958e with SMTP id 6a1803df08f44-8ca0f5eab0emr293198356d6.13.1779197295866;
        Tue, 19 May 2026 06:28:15 -0700 (PDT)
Received: from hunt.homenet.telecomitalia.it (host-79-3-197-232.business.telecomitalia.it. [79.3.197.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3609784bsm90218616d6.16.2026.05.19.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:28:15 -0700 (PDT)
From: Federico Brasili <federico.brasili@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: [net] AF_PACKET PACKET_VNET_HDR CHECKSUM_PARTIAL packets bypass ct invalid classification
Date: Tue, 19 May 2026 15:25:35 +0200
Message-ID: <20260519132535.3806659-1-federico.brasili@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289464-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[federicobrasili@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F56F57FCA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I would like to ask for feedback on a possible checksum/conntrack inconsistency in the AF_PACKET PACKET_VNET_HDR transmit path.

A locally injected IPv4/UDP packet with an invalid raw UDP checksum is classified as ct state invalid when sent as a normal AF_PACKET raw frame. However, an otherwise equivalent packet sent through AF_PACKET with PACKET_VNET_HDR and VIRTIO_NET_HDR_F_NEEDS_CSUM is not classified as invalid and is delivered to a UDP socket, even though packet sockets still observe the UDP checksum field unchanged and report CSUMNOTREADY.

Minimal behavior observed:

1. RAW_BAD

AF_PACKET raw frame
UDP checksum field: 0x1111

nft:
ct state invalid counter packets 1 drop
udp dport 12345 counter packets 0 accept

UDP socket:
no packet received

2. VNET_BAD

AF_PACKET + PACKET_VNET_HDR
VIRTIO_NET_HDR_F_NEEDS_CSUM
csum_start = 34
csum_offset = 6
UDP checksum field: 0x1111

packet socket:
PACKET_AUXDATA reports CSUMNOTREADY
UDP header still contains checksum 0x1111

nft:
ct state invalid counter packets 0 drop
udp dport 12345 counter packets 1 accept

UDP socket:
packet received

A trace of the VNET case shows the packet being converted to CHECKSUM_PARTIAL and reaching conntrack/UDP in that state:

skb_partial_csum_set(... arg_start=34 arg_off=6) = 1
XMIT      ip_summed=3 csum_start=36 csum_offset=6
NF_CT_UDP ip_summed=3 csum_start=36 csum_offset=6
UDP_RCV   ip_summed=3 csum_start=36 csum_offset=6
UDP_QUEUE ip_summed=3 csum_start=36 csum_offset=6

The relevant path appears to be:

net/packet/af_packet.c
  packet_snd()
  tpacket_snd()
  __packet_snd_vnet_parse()
  virtio_net_hdr_to_skb()

include/linux/virtio_net.h
  __virtio_net_hdr_to_skb()
  skb_partial_csum_set()

The same behavior was also reproduced through PACKET_TX_RING + PACKET_VNET_HDR.

An explicit nftables rule such as udp dport 12345 drop still works correctly, so this is not a general firewall bypass. The observed difference is specifically around checksum-invalid classification: raw invalid packets are treated as ct state invalid, while PACKET_VNET_HDR/NEEDS_CSUM packets with the same invalid raw checksum are not.

My question is whether this is considered intended behavior for locally injected CHECKSUM_PARTIAL skbs, or whether AF_PACKET should reject or normalize this case before the packet reaches conntrack/UDP.

I can provide the minimal reproducer and full logs privately if useful.

Tested on:

Linux 6.19.14+kali-amd64 x86_64

Thanks,
Federico

