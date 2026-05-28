Return-Path: <netdev+bounces-292768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB2OBhV3GGo8kQgAu9opvQ
	(envelope-from <netdev+bounces-292768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794E5F570A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D0F5311C6FF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E773F39CE;
	Thu, 28 May 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmgI1+RQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C3305695
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985962; cv=none; b=GJy9PWWQ66cH0HBsCYOwHFc4/SO6EMDrLVYaKGRS5PAGrJ/F0zaWYxwcinws7ahBGMy9VrG7yhyKDyEn8AHW9Gwjlzfeh2CZYy1LMb70mZtD1KA7BJsoup3N+ZO7NPDVWkry8Ch9q7jpgC6tTEKhsJyw1Z7uhNlfZ2XFJeUvXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985962; c=relaxed/simple;
	bh=ufv1PObtyFAiJQzsskvo1bUR+MHLbc50/gzK5sojAAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7gD3UkV8cw+EymVulgkBW2F8170sW8ENoGecQoJPS989YgCKCUScDgY9BS2cnrCLLbrgZVWJvDARndlVSEhZbdeR1CpnGhhW4WMEhkXN9pOqYIFzQQjIwhK/jynEbEVWyKLJ7wQ4LqfVWxmsdAYsmKwsGvaUswsPK3b7m+SYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmgI1+RQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf02708e8fso7620525ad.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779985960; x=1780590760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh+PZK3q6XrLM8CGunVOtEsZQHIDpJMRVztO6r+erJQ=;
        b=fmgI1+RQEhi9wUMi6GpqlHiOrLgj5NJq2zLr5kKFSRwjK56k4WmPpFnbAEt09VhD6a
         zgNiG2SVl961/9Oduyxa5VPQV9RQYjfr5rSfIsmfgEXKbti7YNUwZKI0RP5cykhaGfYC
         /7WLn8f7dy3a0y+pBBVSjspvQmt8sIBYAFW/9EaoT1yOdyhRvoQ2HxRWZiOmzEz+Fo8T
         mxagicuYJyQ4847ahJfsq6LnzjxFFEcjo2PB/+qi9RISZy1hK1YofHO4DzyT9Z9kfYDp
         aKaFmcMQzX+DUzWktFdhivDNP6eAs0OfR/nq9Ea7X+Hw6NhY7uOG8eXa4DOr5V//wvTg
         8+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985960; x=1780590760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mh+PZK3q6XrLM8CGunVOtEsZQHIDpJMRVztO6r+erJQ=;
        b=H/z5Z6SVvB3V/ZEIQf0Vs4HARdVzb9UtfstdmSgH9Vnh9qXdqhN8iVNbrNGdKeIpPs
         EkK2hkfrb3kmBX/HV8JEUOg8FXupeZrr3l+D0QDkBHi+1tzBVS96W4O29cKpg1sEelO+
         bcXZ4LAtl2RAAJ8wStVNd7yVVNBcU51VQGCnH8mLjFOdJJ0iF2oARLE/XEVRDrygxG8q
         f3uQVKYEGkTuL34gApvFk1OP8nR/ZIlZP83a6CnsDfbL4GWjTFGxjEn5LydIKGstD35I
         kVu45I4QihdJhB6oqmlywRmuvmCBNm5CqABlVNb3mdB76AGSLoF+NjtZfhmfthD1/Vh/
         /ugw==
X-Forwarded-Encrypted: i=1; AFNElJ8c5mvPW2oQ5CsNCbUDFDWN/2cdY3u/Pfo0CawrAjijckEH1CYoHoLdzuwMsFYxat5wTtIOiGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMUaNPKM5CwI9x7qtsEUZuA199JL59RPIlSrJshtVu+4MiVi8
	kBZ/TNVI1pVTgfgDbqS6C1ry8ZKWXbNH6JtCagiddq70BOfYoIXLYJRryBUhsBlQ
X-Gm-Gg: Acq92OFs6QhGWPQHvUnkHiQI0j+Q0J/QgMBxke2jUED74Jh4y0Ml5pGgCSSOjFdLazt
	UgAbp8Tg/JAZvH38E2spCw+71dwWpMWHrDqGffFqUEHtgMUzeBhbkXpzhHS34L1kpAmTgC4RmHm
	8SOgn5nsUzb6+Gze3HD/62pSsIbTw2pFcNwxVa21ylvSKQH+NysG3u/iHIvwgViYa0ptvH4hU64
	UQzs7hoQ1dccXInqyWCkeN4VZr8bpjR+O3ho7QVhHF+utEPi8I+90QcHrui2gvrm6sMt/RDDOmd
	BDb60LTa4XRLi99WuvHYll9MhdvssqX2zWvZMmmUdwGbw3ux/U6UGFzDVx1jqPeMmKPcKjaJ2Ij
	d3EQfHWtdC6OGP+XLZL1EA+AAczXuIys7Lub9bnKobmvD/DqhSEC6RVeie+JRCuLeDYqodNu1+D
	45kXrqcRAGxO00/bNkNojhks8K5Twy8AgZXGK8u1qz1BykYybjxEqEaH0=
X-Received: by 2002:a17:902:f78f:b0:2be:e3bc:e8e4 with SMTP id d9443c01a7336-2bee3bcea3cmr158404015ad.18.1779985960405;
        Thu, 28 May 2026 09:32:40 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b387dsm191320345ad.50.2026.05.28.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:32:39 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: jiayuan.chen@linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net] ipv4: validate ip_forward_options() option fields against skb tail
Date: Fri, 29 May 2026 00:32:26 +0800
Message-ID: <20260528163226.573363-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b1447f76-0ca4-49b1-a1ba-2670dbbe5eea@linux.dev>
References: <b1447f76-0ca4-49b1-a1ba-2670dbbe5eea@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292768-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9794E5F570A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 9:48 PM, Jiayuan Chen wrote:
> The bug is real, but I'm curious what kernel version and driver you're on.
> On my side the skb falls into SKB_SMALL_HEAD_CACHE_SIZE (704), so the
> linear area is pretty long, and optptr[2] maxes out at 255, which doesn't
> look like it can reach frag_list.
>
> May the driver use alloc_skb to allocate small liner buffer?

net.git at e1914add2799 (7.1-rc3), x86_64 + KASAN, plain QEMU, no special
driver. You're right that with a normal small nh_off the +250 write stays in
the linear area. We get the reach from a large nh_off instead.

The packet is forwarded over a VXLAN-over-IPv6 tunnel, so after decap the
inner IP packet still has the outer eth/IPv6/UDP/VXLAN/inner-eth in front of
it in the same head (nh_off ~112 here). Inner options are 12 NOPs + RR, so
opt->rr = 32, and nft rewrites the RR pointer byte to 0xff on the forward
hook:

  nft add rule ip filter forward @nh,272,8 set 0xff

so ip_forward_options() does

  write = head + nh_off + opt->rr + (0xff - 5)
        = head + 112 + 32 + 250 = head + 394

with end = 384 that lands at shinfo+10, inside frag_list. ip_rt_get_source()
writes the route source there, and kfree_skb_list_reason() walks the corrupted
frag_list when the skb is dropped.

VXLAN was just convenient. Other paths likely work too: any encap that pushes
the options deeper, or a smaller head like you suggested. Pre-6.3 without
skb_small_head_cache a plain forwarded packet already has end=192. I can send
the PoC off-list if you want to repro.

Thanks,
Qi

