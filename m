Return-Path: <netdev+bounces-289460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KpGCHpiDGpXggUAu9opvQ
	(envelope-from <netdev+bounces-289460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:15:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1A57F66F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC555302630B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AB3EF675;
	Tue, 19 May 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sImQ2+3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E526299
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196414; cv=pass; b=QmT1/c4MEB8kmZYgOhr/M76emP+ZRyEM5EYMrdbq7U9Oed17R/+o0qeIY2nhonxgMHYVCPx35y/7EP0Ho2Ro41TEu7fVqqPSwmh+aN+brOg/Q6VG4A2G4SmkRk49oVj6KLvjT2/WOMLw8L9gCPHlBG34AbPcrVBu5dQwFPd8osA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196414; c=relaxed/simple;
	bh=Uq8Uv76VoSqgu2Xxy7jY5UaQBqn/xykEQFsH3kw+DnM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pl2ZDi2Vp9u6WAOnArXxDykZrH+3X5XJCz1ev0TpFfiRQJr62dm7ip1XzxN3B4cqBIb6mxkptpRYpIUnmzfJsC3kTeDwpvK9sytBEEIf24yvQ2Nf1IAq8jpDT6gTn6la851on0O+mkcrL0HVghFzNi95mRTx4nYsfWC9/xUN9EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sImQ2+3L; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4824176bbbeso1093791b6e.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779196412; cv=none;
        d=google.com; s=arc-20240605;
        b=O+8kf3UDzf5wn1FfphHk6TfK6rLXVWy3+QjOi4h7wN6PjVAc+VUJln9pjtjq30yHcG
         TI6ekUrXkFesPkXEgls/o5k3ZPhUSqMyecaqGwthwRepxxhkiBBNqHJM6dkdMfZqwquY
         NgoLGLdyckX3t9aYoGY4NP7pBkD1gqj5nr2PgGJBjwnAD2sUOdFKLkAAbqqQa1Xggr+W
         XddWo/Bqx2KfhV8t+B2VMQf62dgl+VJLbm46j3pYagjXdXR7QTYyzHmjtqWQ/56pC9on
         WalKxCrK1AeRmiBSQfmJ0vW5F9IhI94kObGq+d1ugC5iqwffMHkpYVCoAcaxFd5w3rrs
         FAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Uq8Uv76VoSqgu2Xxy7jY5UaQBqn/xykEQFsH3kw+DnM=;
        fh=+xku+NwDVD9G+O5tNrwkR++oEpvVqdeDnU9pkd2HbEs=;
        b=TXpczRHSPmBDWSLPAd+OtOFc0gJ33RyT0SZg5j05d5aGkOsmVlIJy+avwkk6yK8oKW
         MmHVn4schnVrQqZsz5Zoqq4Pa0fjI1vHHL5Ab8TLMgz9yFO5ZNsQfNyfoTbm9VBKbrXB
         7gBO72XSRaQturcVxy/PC5+hbWm0Z901sNr3j6F36Pw/baSgxqQUSXhZpb8ifL45mPkE
         yGdflYuiCgtcQof5DWn/zYDWiqHMJyTIKIVMFoANr3MtRoDf6sQOKIsUYGUarpHUzjTO
         vmM2EeBw+nA1mSLxUylgRTmq1WYHLhzjlZ+nxyq2LDshvU5XW+qLaMBFcXHB6X7BWNpg
         7rNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779196412; x=1779801212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uq8Uv76VoSqgu2Xxy7jY5UaQBqn/xykEQFsH3kw+DnM=;
        b=sImQ2+3LBj4tN1tLtKeZtlLXXtH+gIo1drsLy3GRBRyqeKCK4VYKElxx/7fqMdTJ51
         zxIUzHjWqDb7Ot3X07lNj2Ve3Afz5WzJLn+Cyh8Fw0N7UFJZHEI78xx+rCwydrpDNck2
         UOFTkeTqyn4z/UPJd5m0Ho+WZlfEHQhpl+qKW4j6XjY3y31heZmg9C4op2Oe73rxeKkS
         3WsPOOiCY28KVTDOU+tHQ8W/DU3bJlQPIE6D7CuCX9ijIjB8Ra4t1hodY4y8oaRbTybn
         q9y5yAaW5s3XySmwNDBd1hWzMzrKsVEeSnhenI8QNuDSFS2rLHV74hU86kWN0+roZpth
         9kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196412; x=1779801212;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq8Uv76VoSqgu2Xxy7jY5UaQBqn/xykEQFsH3kw+DnM=;
        b=YxGyaFBqRNGtWCQ8gFJIgLldFtULKR9cFdt6EHWi4kXdZ1oDUGMSS1/qO03yP35Wwy
         /1VLLY+weXrGztRuTBrHcJwlSur5LZFxns0tGObZ/qjWS1/sz56wn4EbsuyIR6OCjHh5
         hQovDSxZsG67PNUhwWmvaNS5djZVkP9YG6hhLfV8ADLXwYlu3cASlTPPbEc0g1nx5CfI
         Te8aG4jB8xwN95yxOu94708n3HwUF3YgxnKzsdAffYwyurwOHo3OrY0TFEwXweiL9zgX
         FD8BjWnvvXahT/IgA4rCPxv3dyFuS4xwSl7FzvNhtcIZJ2uKjA3Q9PYXUM6Xp+xUMlZO
         CKWg==
X-Gm-Message-State: AOJu0Yxezds3oXMZd0r2G/FdbEcqc1oqqGdWlRpSTloJcKKMu+cZY4/d
	x2o1B69vokwjgkE13IC3fXlLJ9O8HQctTFRhJEFd8flSfODi6ljh1zqMrDZm0iv3nVopszUlb+y
	epBgSWM1TOw2T9aBZOjugERTvCvGeO8+YJvwle9g=
X-Gm-Gg: Acq92OG9bO2KWwB+3m1LqUL7VNFIiJoPjIQkGnkhTMTY7QF+3F28qVl4v54cSlozNTg
	3CUlCnm8bzUMAia2j0gclOcOVv9oVa1FueZU7HGa3f+zzy9H4lfLRXmHEW6jrJXO4d40QwmSikH
	l0kGTxsxZ+YnekwCH2m2E6LwHMFerYBcPouHU6xPDWb9c2S+I17+YULe6tImv8pDJOcYAz2vjYH
	ptdKy+O/fTDTvoru17IIGPoMwIUL4/SjxUY3I5vAHfNE5tnq9Sax9Ir+P5KAg1xtPMRsINBn/aA
	DDbX4g==
X-Received: by 2002:a05:6808:124e:b0:479:ac7d:6da8 with SMTP id
 5614622812f47-482e56310e9mr11580479b6e.18.1779196412539; Tue, 19 May 2026
 06:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Federico Brasili <federico.brasili@gmail.com>
Date: Tue, 19 May 2026 15:13:22 +0200
X-Gm-Features: AVHnY4K2s5mNKsvcTMCldiaF7FozFvwcgzBTCP_F_3U_m1StpUhvC6KUAc_DFjo
Message-ID: <CAAEr8jbV+e5SM_GZqqbiV0zwoA5EH=eH_L+8Lg0w5RPmBPeekA@mail.gmail.com>
Subject: [net] AF_PACKET PACKET_VNET_HDR CHECKSUM_PARTIAL packets bypass ct
 invalid classification
To: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	"edumazet@google.com" <edumazet@google.com>, kuba@kernel.org, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "fw@strlen.de" <fw@strlen.de>, 
	"pablo@netfilter.org" <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,netfilter.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[federicobrasili@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B4E1A57F66F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I would like to ask for feedback on a possible checksum/conntrack
inconsistency in the AF_PACKET PACKET_VNET_HDR transmit path.

A locally injected IPv4/UDP packet with an invalid raw UDP checksum is
classified as ct state invalid when sent as a normal AF_PACKET raw
frame. However, an otherwise equivalent packet sent through AF_PACKET
with PACKET_VNET_HDR and VIRTIO_NET_HDR_F_NEEDS_CSUM is not classified
as invalid and is delivered to a UDP socket, even though packet
sockets still observe the UDP checksum field unchanged and report
CSUMNOTREADY.

Minimal behavior observed:

RAW_BAD

AF_PACKET raw frame
UDP checksum field: 0x1111

nft:
ct state invalid counter packets 1 drop
udp dport 12345 counter packets 0 accept

UDP socket:
no packet received

VNET_BAD

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

A trace of the VNET case shows the packet being converted to
CHECKSUM_PARTIAL and reaching conntrack/UDP in that state:

skb_partial_csum_set(... arg_start=34 arg_off=6) = 1
XMIT ip_summed=3 csum_start=36 csum_offset=6
NF_CT_UDP ip_summed=3 csum_start=36 csum_offset=6
UDP_RCV ip_summed=3 csum_start=36 csum_offset=6
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

An explicit nftables rule such as udp dport 12345 drop still works
correctly, so this is not a general firewall bypass. The observed
difference is specifically around checksum-invalid classification: raw
invalid packets are treated as ct state invalid, while
PACKET_VNET_HDR/NEEDS_CSUM packets with the same invalid raw checksum
are not.

My question is whether this is considered intended behavior for
locally injected CHECKSUM_PARTIAL skbs, or whether AF_PACKET should
reject or normalize this case before the packet reaches conntrack/UDP.

I can provide the minimal reproducer and full logs privately if useful.

Tested on:

Linux 6.19.14+kali-amd64 x86_64

Thanks,
Federico

