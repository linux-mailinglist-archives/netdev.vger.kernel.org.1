Return-Path: <netdev+bounces-279414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEV/KrCR4mnf7QAAu9opvQ
	(envelope-from <netdev+bounces-279414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED741E6AC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3430C3055E1F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3A2264C7;
	Fri, 17 Apr 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LObDetON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959C1A6817
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456078; cv=none; b=b95Ybg80N2l9gWzy2TlyljqVcJnR9fi5dlgVFL0fzLxcE0IURddp6CKm8bQFHBha7JDlxugeHdM0LDFiNE3/uveDeOxsxqKx8Oeh1YjRI9wlcm3w5rPTGmaAoTvh4TIY8k/L4GTpjDEyjZ8IEWOcxDHd6xRrlNUPnh5huZzIt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456078; c=relaxed/simple;
	bh=ZXBv+p3Nk6vB1R22OjPwrXH48JjQ/4baNDrQdAuiJVI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FSaFaBcSbA2RxuXs9QcySi86lQf2cqobSUCEbTqa88HuB2RKtTcPJbulKqsb2h+LWv6fCDVi+oIpfurhx8BCTw1WqD1va8iZ1zCn8oUT7JQr+OtV6CSJJZYJpd4jhRMxgRh2VnYseyttrmHdh7kDLaGTQQz0kSr9uYntaduAVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LObDetON; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501d242e3fso1250512d50.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776456076; x=1777060876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iczVd63vbqFWvqoqzA31fRG6WoDSsjwf0MmS0a+EFGM=;
        b=LObDetONbCBk5Kwe0bieiSeIX41UVvHPO/mQCmdzZ8Jd8Ep2Hn6wcmxxLgJfBA5DNi
         Vkk+9LG6lz7Y+4LPbb9LVxdKVoMfLjEc9ZCrkwUn6QhC8FabZXG7ngUuwCWzXyatqenu
         XMXUL3PKQNcePzkSJArnZBW2xSlwtTf8rsLuZrwHhVJuBo+QFkX64m9LtNcTRq6K0Gx3
         X7aziAi9esG8+nQRMGBKlgITz90Yj7DKnzNDDSd8witQyTsCZ17VsUV/9HUAFQle+l9L
         nai/xiU+wbQo/APkh34fzs3T856Ja6LJ9KsY170ybBI04n17dHMRfQZqGEeCSAkEPm+1
         ck6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776456076; x=1777060876;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iczVd63vbqFWvqoqzA31fRG6WoDSsjwf0MmS0a+EFGM=;
        b=BlpnmzF8l80T0TSyoO54EV9LN+EQhjqzrIZO+Ur9GMu8APSyPgGz5Y6fAdiaEvwPOZ
         13H9xIziK/6Sr3htdmz8WfmZ/cz2p1aoZee3xMS7APSP7PNZn12ODokuMb94kKhJJjZR
         DsfgphWvdWUivaSsnOsFp7M64JZUpw0nd+Z73px0UJlRzx2v58dY5Q+XQlfOOLinKwI1
         2D4iwm9qLtkqSlARYrMCP+uiDYvU/hieGhm1Sz/nljxHpLA6CVbF15Z52P+mpoWEfABp
         RT0JRKLXGjOTSO0CIARCmXD6ryTaEwCuNH11I6KtP/ntBnFaCad3QBOyG1JvZw5ZyXpU
         4ptg==
X-Forwarded-Encrypted: i=1; AFNElJ/RrEhzryU6e2FH+vWZsa/8Jl/DhDm5+Rm7xWnKkh8HNQe+DCtWCFswDVxtmZ09vQAs1+bkDNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXbK/pb5EYvZJY2fOG3pIz8qvc58ENxEJ1xIBjO5aob0pT5Vb
	6uwYX2hTcSbXezanWv56r44gdqaipJPFaLc4j/5yleXZjKD59Nh72yJ0
X-Gm-Gg: AeBDiesCWNpI8SkLYFH8B9C0dDVpuSo5vdvw/NM+OFdKfuGOslLSWmK7wT7fNPvKWw8
	f8VTscKn2Uq+Vyko5dmZzcL2Vz+BTOY++hrZoqUZHq+xeZ+K3EOlwQJkzfz7M5rZQCy0vpwIIic
	Y3evmTGWHbtMMsBPHDorLBuYNp7fo1WlNaCtr3TEiJ8WFL7VsSYn527GYKUYNRHub9m6sAC2odF
	AJp2p0Kl9OCUBmh6p9eFtVIQsJB1PJ3PHdGa/NdaMyZwHkyYMngc0V1ry12YvDrckQEmlSa/DCv
	18gxjIXvdH+TRCSJD17ysLQbko2Xz0xfYP+aCPqk3NBKCia3mbcZcXsA+6jvmz2+5r8kf6AgOLw
	0ZcvWxSx5OLaMjmrkn99s9B0/sJMYEQfsalSaGTozSqm+bZGtKYLo1V2m39HLdfxexfzy3/Dskj
	y/QoV6CHAkBYO8OAiaY/efxaO4F8oy/PG/avsAW2swAASXsbNIZpsxwBtPj6n07IA1eSRSbFqoZ
	asV2aI7bctX6+cZa8VKqI68nw==
X-Received: by 2002:a05:690e:4812:b0:650:1bf0:ca64 with SMTP id 956f58d0204a3-653107bd0camr2931418d50.8.1776456074067;
        Fri, 17 Apr 2026 13:01:14 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b63174sm1219116d50.6.2026.04.17.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:01:12 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:01:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zero Mark <patzilla007@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: security@kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, 
 Zero Mark <patzilla007@gmail.com>
Message-ID: <willemdebruijn.kernel.1e149a5a1914c@gmail.com>
In-Reply-To: <20260417133610.88158-1-patzilla007@gmail.com>
References: <willemdebruijn.kernel.1683671b10e8@gmail.com>
 <20260417133610.88158-1-patzilla007@gmail.com>
Subject: Re: [PATCH net] net/packet: fix TOCTOU race on mmap'd vnet_hdr in
 tpacket_snd()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279414-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21ED741E6AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zero Mark wrote:
> In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
> directly into the mmap'd TX ring buffer shared with userspace. The
> kernel validates the header via __packet_snd_vnet_parse() but then
> re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
> userspace thread can modify the vnet_hdr fields between validation
> and use, bypassing all safety checks.
> 
> The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
> to a stack-local variable. All other vnet_hdr consumers in the kernel
> (tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
> path is the only caller of virtio_net_hdr_to_skb() that reads directly
> from user-controlled shared memory.
> 
> Fix this by copying vnet_hdr from the mmap'd ring buffer to a
> stack-local variable before validation and use, consistent with the
> approach used in packet_snd() and all other callers.
> 
> Fixes: 1d036d25e560 ("packet: tpacket_snd gso and checksum offload")
> Signed-off-by: Zero Mark <patzilla007@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

