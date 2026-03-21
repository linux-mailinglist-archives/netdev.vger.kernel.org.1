Return-Path: <netdev+bounces-270139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JrTJT/2vWmqEQMAu9opvQ
	(envelope-from <netdev+bounces-270139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:37:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A142E2CBA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55DB7300E287
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9430ACEE;
	Sat, 21 Mar 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6zuac8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327A2749EA
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057017; cv=none; b=gQsVJUUxewCBcMlGGEdT+RD2hpBx4mIJtDTABCTrGwxcu7zZelfB/+75wrtKEojXdhd2l2W0fXaOrXiZHESz6PYl628MES/6/KCgy1RnenGBz0c8mrQihzNQ5FMXQ7nltlo52bC8H9B4r04lW49v5krM+kzdusxhDF1GDROKDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057017; c=relaxed/simple;
	bh=qQHhn8vSDvbc147bPdifFiyrpdsSgOZYnDhlgqgpQZs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FtxEVg2Z/Sxqn4IM2HJiiHAU8AInRVRLO48Tap1/wK1q8Et3yMnEO29+68B0RdrBG9/dt3HFEcB41WpwKHrA2+J9OsTJhkrS9kF7fYOP2fYM5rz65lpyyv5n4ev7nAepYLTn2Q6jof7lqEsz2TLljm786114Xcfp+gggcTBSu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6zuac8i; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64e8cdafeffso3743519d50.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774057015; x=1774661815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6SSl1HUhY/DWF+uq33YuHpzbLaRaT77I1mlkc9EVY0=;
        b=i6zuac8ii2ynN/ohsndRAe+UpHkTYAZuq33JBcPA6bcKR3f/j/ZVAYtmZ4MdfAG0Pa
         O+6D+xwRBkHDCNVDFlF+5BXZ7/qNpAjtfpE9MC3+/Vys2Pp3q9fgOnpdn9yoVEiKLtjC
         0ofZ5/ggtIgclTF3i/juN5WYPvW0g6meFd6KtWHFncbPRoc/Xt987Am2OZRyKvco3pWO
         hpBuZgveffMcMF3kL/Ib7UOFBvNlONB2wBvIiKpkHKimBv/ZxxpQPTu7uG7CnEwrP9+p
         XuIE1BuAJdCl8yoUX0AV1kzEqaB1H6R9GYCyFpnBkFNlDf8iZ3h4hl+MBXP6QXSM5knR
         bb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774057015; x=1774661815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6SSl1HUhY/DWF+uq33YuHpzbLaRaT77I1mlkc9EVY0=;
        b=VIBWq5pdOlItdYHydRPOcTk8EFThdmwiwJVjwvxR6Ys5fJtpekAKviBP761YLkigBJ
         7d56nXLkcF3Enun0SzNwmbcUU6kTx9P7Mnt5/4XWVchk7ezLfrJdZGbYvZGAeup+KqmE
         71G/xe4DzqGTHQJ8++ftZqnU7Lc2iD3uIZJkifZgkTXGz/fKMapiImDA5Z3sA1YvMVIF
         68taMSETg4LAd6uJGRpf5ZBEk7KM+JIXG7pIIDebwklWh7l2KSSQrEvEFLZ2rrErp3Eb
         qknXmZ8WMRfXC/D6lcwnKP3yPOwpVwxthSXoryyn6b9FQsOmbfUwzS/fFWtCyic54Cw6
         fKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5jE5mkqzmCczFdCAh59vSefdzQyu+JGPnr8kiBuXiR3rSGY1mDBP5eki9IlES1bylzWWbMAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ktfZDCYaZHaWiTHWwN9VqjYWm96r9SdoI+laY4W2ah6J4Z8x
	6IoEkbPR5XpdleH3SpIiL39VgHUzyZ8eXEVyz+vUx7mKSBleJsgGXdQ/oEzGZw==
X-Gm-Gg: ATEYQzyQzO84DRg93odUUUyxpvFOiuzy3A2g7U0yCHM64foeISlX/HyraC3+BDQt5cO
	a7HIT290cSAZAGyDwpuBU20r/6kmIOLPMTc1d8KyZnMLjLiX/M06iHw8sm5xfOjeL16cYwfBKlT
	2XxkAc4AGfXn9IIB2fzCB7j0ms5XQfaem2vS2Viiob8qea4+Vc06Alo9TERBNk8gSJzpI020Jao
	i774sJZXm/npEWYe79AFzATsWqbWNU/kPdTKCp9HdqmNCBmCCN+yaCh0Ef3FfE5GUINDvbBYMwt
	aUoRjcZFfGVMot9bexk9fiitW5Zcr7NCx/l4Yx91UHEEU9raJCiiEXCN2YHlBA6X1AwrR7gW9MA
	SzKRAUhYtoZVO80eYalICnCXC9Vb40Yos8ILv0IG2QnccGdp5IIdLB8C9DadsI6FEXx/m4eOsoI
	cdW7UzdS1gMM55H35CqpCkV1GPMiUcLyp4koJDl+pCssDqpA3izm5SoXiRVVInCZ2anDwPy0frg
	lx3
X-Received: by 2002:a05:690e:6c4:b0:64a:d3b2:d394 with SMTP id 956f58d0204a3-64eaaca56c3mr3628999d50.26.1774057015607;
        Fri, 20 Mar 2026 18:36:55 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabe7e343sm2510457d50.11.2026.03.20.18.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 18:36:55 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:36:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Guoyu Su <yss2813483011xxl@gmail.com>, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com, 
 Guoyu Su <yss2813483011xxl@gmail.com>
Message-ID: <willemdebruijn.kernel.2497131610e6a@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2018fae77325e@gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
 <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270139-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21A142E2CBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Guoyu Su wrote:
> > Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> > called from netif_skb_features() [1].
> > 
> > The current direct skb->len check is not sufficient for SKB_GSO_DODGY
> > packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can build
> > a DODGY GSO skb whose total length is large enough, while the IPv4
> > header is not fully available as initialized linear data for a direct
> > iph->frag_off access.
> 
> The fix looks fine, but the AI review of an earlier revision brings up
> a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in all paths
> to ensure the network header is fully in skb linear. What kind of packet
> is this that managed to escape those checks?

The packets I got out of the C repro just after virtio_net_hdr_to_skb
look as below.

[   76.539562] vnet_hdr: flags=0x75 gso_type=0x1 hlen=0x6a gso_sz=0x416d cstart=0x58
[   76.539755] skb len=56584 data_len=56476 headroom=4 headlen=108 tailroom=0
[   76.539755] end-tail=208 mac=(4,76) mac_len=0 net=(80,12) trans=92
[   76.539755] shinfo(txflags=0 nr_frags=3 gso(size=16749 type=3 segs=0))
[   76.539755] csum(0x10005c start=92 offset=16 ip_summed=3 complete_sw=0 valid=0 level=0)
[   76.539755] hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=0 iif=0
[   76.539755] priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
[   76.539755] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[   76.540713] dev name=ip6gretap0 feat=0x0000000e401d4869
[   76.540843] sk family=17 type=3 proto=0

Clearly fishy. They do have VIRTIO_NET_HDR_F_NEEDS_CSUM set, so we
know which branch they take.

        skb_reset_mac_header(skb);
        
        if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
                u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
                u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
                u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));

// start == 88
// needed == 88 + 18 == 106

                if (!pskb_may_pull(skb, needed))
                        return -EINVAL;

                if (!skb_partial_csum_set(skb, start, off))
                        return -EINVAL;
                if (skb_transport_offset(skb) < nh_min_len)
                        return -EINVAL;

                nh_min_len = skb_transport_offset(skb);

// nh_min_len == 88

                p_off = nh_min_len + thlen;

// p_off == 108

                if (!pskb_may_pull(skb, p_off))
                        return -EINVAL;

// headlen == 108

At the end of this headlen == 108, so all of iphdr should be in
linear.

Since the syz repro requires repeat it is possible that I simply did
not capture the right packet, but I don't see the C program vary the
packet contents.

