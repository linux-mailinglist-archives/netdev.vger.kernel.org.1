Return-Path: <netdev+bounces-253545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+9Maicd2n0iwEAu9opvQ
	(envelope-from <netdev+bounces-253545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:56:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 305578B102
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C61993051865
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E33491C9;
	Mon, 26 Jan 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3VpYOpB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391034888A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446172; cv=none; b=Y66416kKY+VxQwIxXgoH12xo15s1rG4uT0TQYF9K4ESk39tGMVoPq850u2EdIKalniw4t8B7i/NU5ED5i+kHt5XRQGDBc0SlpexHAUo/fDDlSQyLGKTvW9uFY0ebwM3KNOp9nsSfjyCtlMxI6CGdaxZaSNIo1yxslJGKqEzMEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446172; c=relaxed/simple;
	bh=uHcXECLSgsppVhP+AhoOZulbAbBN77UIUBU86+28NXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PfEUsLy315PYZyzQ4qX94M4ylJEjxFex2hTVUD2SZLF8hlsYje9LxbHhxk3POBiRrSG8FcJVGM+oykRw4Fnpa88Pi7H25pABACDgu5T0k7QQVBJlG2sSH2z7ut1GosQo9besrIdP2kdrnJ6z+xenQE2ZQrHmkz2YqISsmAqYt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3VpYOpB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7927b1620ddso69028237b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446167; x=1770050967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzIM5S1aosasnRgv4fpJy7hXx99GJuvBk4X/AumVJ6E=;
        b=C3VpYOpBYH6j/6Ogy6nYwz33PkgKdn7zoo8DV+MsAPUKDOmRisXtm82KK7zpBFotFd
         KG3HZbVdskGhXmgESjGv3ZEUogwzPyjOLe09etNtZJ5I8ENxG4Ec0XpevpkO8s6eIY23
         Fq6bTrTjdxopBy4riRctLA/JUZn/LDLgm6ZFBGlSFzBLyjwAMr1fropAWpbywCnFobiX
         iYZDQxhrGKe8lXj9io+A/YUJTF2bXqxIlBtuPKe5oOzv7txsBTp4sXpGtj/phpq2Rc2H
         evXJsR49xTGdyULmbJqghynRdYxVPEfMLhE0EwS8/l05HSzQ5WHjvdXNqUsz25vXCCmL
         bhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446167; x=1770050967;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzIM5S1aosasnRgv4fpJy7hXx99GJuvBk4X/AumVJ6E=;
        b=GZvJXx7Y9ChP6vduX8vpVS/J+U1oHC9NpTQKoUE+DMYEniu9W7Ddja+nXdYg+5lSYy
         So6uZZp7xu4EZ2qVLO+wO07D/Sbc3x3tXkhPsQbdedHa1UdcvNOpB3NRyhEe/7s+7bsp
         69OJcviQhUm9PCUESz1x2bWqdk8aIxIVsd88Y8rYCV7VSp7a4JIsb5RsamhZZpEp7IXD
         VqTuTU3F+Y/ko5o1XPqMEJaVxOq/v5WpqRZ9Emqop8XEWPE3UpPodpl9c4dRRX3EL/S4
         6XrwXdwR2pHPFmosrCK1/knC21B5Gx7YyPuQr4w6OSCA2fOcaUgGyDifH8KfA221R+V6
         Y1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUm1vU0BubZMVUoROu0pZJXaFkp98ymE6SAoSgYa0SfOCyIweiKcWTrKkkE+g11DwHsQKcJCNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4ZXQ0i5w3wN4NAA9rP+lYBH+lutWOcsCtP2rOU9a34GadJcP
	gmejbwMBtAeSZEWbpVp4Ad/eR+3JDSehViLpUdy5g9wzEeeLBjnYbBOn
X-Gm-Gg: AZuq6aKzWvYNchRi0SCjwAONjl2z5Y843xFJbQaIcIFTIR/8w/j4wLYlcH7MVa6KO0C
	LN8deOsAc5iGcsyZ0yHGfYzjAvwd7MXBcuE+TNCYFgQGUbqOd9qfjhaeosoaP8jZKGzd7Pg5Df+
	3C0yLOSH0dRXIHwhyjlVnuR942wWBijiVapK+2aYIMWjDEWnVJOPF0g1e/8Dkdpv+clvCm0Rpvm
	V2OhUfHMWPnFAxxVKYyAlRDK06pCCT0CPZ/xn+iuLAz2wqUTuLcl1CG5qEBWIkA3FVIsHkoO1uf
	b3Qc9+nLi2CYjo+eE3A6u+kAbDryFxCEUQjhBG9lNzH+j8+0VKa3oLT7G0Dml73arYCB3TB9quG
	oIEgwIbo0IzAigLoGMEHYWGZVpY2/fQgvpaZBw5DQ0pPd6VwLBypWZVENZqM1Vyf/4hmTeere7E
	AEGk1nTNzJyXfsNTD5/Uym1n3h+WB7FXvXdsFptNv3xniYUExcps9NbOVfQB8=
X-Received: by 2002:a05:690c:6809:b0:794:107f:12b8 with SMTP id 00721157ae682-7945abe5d41mr35771317b3.10.1769446167253;
        Mon, 26 Jan 2026 08:49:27 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b2b9bfcsm49990507b3.38.2026.01.26.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:49:26 -0800 (PST)
Date: Mon, 26 Jan 2026 11:49:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jibin Zhang <jibin.zhang@mediatek.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 steffen.klassert@secunet.com
Cc: wsd_upstream@mediatek.com, 
 Jibin Zhang <jibin.zhang@mediatek.com>
Message-ID: <willemdebruijn.kernel.11a4b80935127@gmail.com>
In-Reply-To: <20260126152114.1211-1-jibin.zhang@mediatek.com>
References: <20260126152114.1211-1-jibin.zhang@mediatek.com>
Subject: Re: [PATCH v4] net: fix segmentation of forwarding fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253545-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,collabora.com,vger.kernel.org,lists.infradead.org,secunet.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 305578B102
X-Rspamd-Action: no action

[PATCH net v4]

Jibin Zhang wrote:
> This patch enhances GSO segment handling by properly checking
> the SKB_GSO_DODGY flag for frag_list GSO packets, addressing
> low throughput issues observed when a station accesses IPv4
> servers via hotspots with an IPv6-only upstream interface.
> 
> Specifically, it fixes a bug in GSO segmentation when forwarding
> GRO packets containing a frag_list. The function skb_segment_list
> cannot correctly process GRO skbs that have been converted by XLAT,
> since XLAT only translates the header of the head skb. Consequently,
> skbs in the frag_list may remain untranslated, resulting in protocol
> inconsistencies and reduced throughput.
> 
> To address this, the patch explicitly sets the SKB_GSO_DODGY flag
> for GSO packets in XLAT's IPv4/IPv6 protocol translation helpers
> (bpf_skb_proto_4_to_6 and bpf_skb_proto_6_to_4). This marks GSO
> packets as potentially modified after protocol translation. As a
> result, GSO segmentation will avoid using skb_segment_list and
> instead falls back to skb_segment for packets with the SKB_GSO_DODGY
> flag. This ensures that only safe and fully translated frag_list
> packets are processed by skb_segment_list, resolving protocol
> inconsistencies and improving throughput when forwarding GRO packets
> converted by XLAT.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org




