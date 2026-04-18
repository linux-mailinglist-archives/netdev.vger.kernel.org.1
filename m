Return-Path: <netdev+bounces-279555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CZ2aGvPm42mpMQEAu9opvQ
	(envelope-from <netdev+bounces-279555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 22:17:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D44222FF
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 22:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C874E300CC31
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51A26461F;
	Sat, 18 Apr 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2MWdikN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFE1339B1
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776543472; cv=none; b=BMeKb7foEmhCes7oq+zmrInlq4feXsDKUJO+nkjVxjUXabn9jmkoQtJfEmwlfQvSaVPM0GIvfBP6NXf+oiE52vDmkUNFqbF2FlZTRLcp/SabEgYX/DfUYGgUS7epOSspxEjbBzxd5Z3gRPYtuG0zlxmpWXfMYBZc6AfRQHZbpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776543472; c=relaxed/simple;
	bh=LtYk9tTgl00Rd8QbHpcbJ+0ocoxhZbfBqA4DQgsFgv4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lwxzbEXbvGoLc+s/64pBvSrfhrDkggrEAF8ePoSNkYrhK5g7iabU7hJ2iuJnzPJSIY1TRpn37OzXSCrl9y30nko0P8REVDYQi7eG0SUFdKTqCjn67BWtaAlIJBzmkQ+lJ/vaQtoOWd//HYwHbA1b9rW0Eakz2uJOotfnmigoKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2MWdikN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so16448987b3.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776543470; x=1777148270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8P8PHyoAbkisVknMKNTMPJovECCgFND5DlHYPy5dqU=;
        b=S2MWdikNVSSmUX4Y1tcDijzF0bM9Sj2S3pPUfqScmjG4WaI1XS/uANRGApWPId9qG6
         +PXEUNwszD7WU+Z7I2Vh6w2mHHsQdSwxjMlUKrc9MpjQXtAWhW4fP8n5yo5iKl7B2GN+
         FuWcegcP/UfgcpEHqB/xKBo0fKvtFQX2asGjO3B5IpO9ZjpSAYs4Zqbn2UIfYAJLui+T
         ljw652max22CD2mbbg+GJnow9/wce44oaHv2AGWwe+lbWTtGqWA2yUjm/RPASSJL1Hff
         oSmE/IyZQIg9I89DAnuprWcgqhvvjBQl5XJIv0XHu25vPevaLyjDbO8zq4zS9VNsvROR
         oELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776543470; x=1777148270;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8P8PHyoAbkisVknMKNTMPJovECCgFND5DlHYPy5dqU=;
        b=WkiAgL1qBt4dtGN9pge3kEUmb7qRr6d5TLSeM3WZ5RWgY6+iCLd/jG/UBlGGY221G2
         SQk7vgSsdo3FXoqB8pz35ZWONGxw5K0g40nPYaK+a6Kw74pRRtiQ+7/ClmqY1TuzvzFj
         KOIDtsfybnrE2NefJxQUrFo/IR8M4b0dtu5HxMzKgEBcGfJNaCfUFVQhNqBmx6LB85/i
         k4jgO3jBBPic5Ye5JiLDuizEE891t/7GuX+gtLiGEOQv0j1f3WWpbdAt20Tb/XcGQ708
         Yc7UILavvNNO3s6R7pp2aEPQ0BJvET4VIfLC5Z7IEXgpWlnWoo8ieDo8c8m9NWoL0d0K
         aPUw==
X-Forwarded-Encrypted: i=1; AFNElJ/dZ6GIT2mf5kzd40Dy47slZtBQ0XfBRSgySUhhgmpCCFkXic/VPy+Xux9TT7SphY+eFmAULgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ic/g9Fgkzfw24pby2k4IWeWWLfSt/yyFOwX+sToFbZHkrVN2
	1z2ejg2m/R+nAe++xhBF79fW1Ysc16XERui9pi72ElMkCoCC1xQxpK4cczmVzUrY
X-Gm-Gg: AeBDieudxY6J/tKxC+OmOhEKOFRccZDg8+ctR8tJHBWQZTRP1OBKMpFDTdIEiRsYsQY
	rvPhFGTvU1VXl4+BCBkaYIBOv2HTMGiq04N/87tkdd9YDe1d4+DGdH/pufv7JOmPhwbngpETKtU
	iDh9D+xzJkFKS4UuKl5s9jqn1RJeapigfKRNuzuxQm9qFMe6k6gB/+8mlXJZdkFa8oFucsy31/1
	vfPScyxj9g1/3vu3x3L4ld2njogUqs0XqHMSJJ6RhogubV6glvCW/NiGhEwo20f39hWWkaMWVdt
	Zi1MpMRfxJMdmg79jysK/8jOIIm73BocB+vh83yZtvxlb9BdSSX3M22dAgKr7cfdlMVBYa8lMt1
	A/naUYmnJzN68Ett31wIYQb48iTsMcN6qQOVUX0LkqbSV6G1OtHDLsTlhCUIK7aiXqoTtJ1xXhZ
	W7OVbHlR122wtWQ97JPeEe/6M50zcNE2rYHUoTED4javitIqrTjIJCwjOPO7HtWemWpCabYmZpt
	/JC8MnV9WlUGczmgJNQ53x6ag==
X-Received: by 2002:a05:690c:c509:b0:79e:142b:cbc9 with SMTP id 00721157ae682-7b9ece8f491mr81027517b3.6.1776543469963;
        Sat, 18 Apr 2026 13:17:49 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89b88bsm23957297b3.9.2026.04.18.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 13:17:49 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Bingquan Chen <patzilla007@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Greg KH <gregkh@linuxfoundation.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 security@kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, 
 Bingquan Chen <patzilla007@gmail.com>
Message-ID: <willemdebruijn.kernel.21b11715853b3@gmail.com>
In-Reply-To: <20260418112006.78823-1-patzilla007@gmail.com>
References: <2026041858-estimator-shower-0f16@gregkh>
 <20260418112006.78823-1-patzilla007@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279555-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[networkplumber.org,kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B24D44222FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bingquan Chen wrote:
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
> Signed-off-by: Bingquan Chen <patzilla007@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

