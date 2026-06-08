Return-Path: <netdev+bounces-296433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ouUaJWiMJmpRYgIAu9opvQ
	(envelope-from <netdev+bounces-296433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB95654A11
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:33:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=b5uTgBJ5;
	dkim=pass header.d=redhat.com header.s=google header.b=Ub8Iy2wM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296433-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAE79301C958
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CB330B30;
	Mon,  8 Jun 2026 09:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FB3101D8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:32:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911134; cv=none; b=ONZAuo48lF3ubDuWCy6yJ9Ut30vzDp93q/Y39oar7G2HLjh0/eOD3lINnDnC3Q8eYB3lNLiiZybmenFWKU/5HrQI7ORvqyS717dcOzbR9YFa5qakRYDMaUY8nTb7xe5XdGPj0+bw6f8Lj0vVuLuST5TdbRxIXMj8W0D6dNOpeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911134; c=relaxed/simple;
	bh=m5XvVLdXPxodo6rvp/JQfddT78FNxqH1P6XgW7C2jjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1nbfnqPelVDCu+tENQWKnZh8YHYXdXmOXELvcA2t5zoLFzTddX1uOzBSI0jn80ZfDL2AZR54UkoHWOWslJo8A71gWzNkSXKLQRfT+0LEedQ2kqnlet6wnbp1fSoy8GIS4ehJls+ucq8OsEm0kW4nRZP5tWFgzexNgBhNBoYy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5uTgBJ5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ub8Iy2wM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780911132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKA73a2j5fYEJYroB0bsYaL4izOO4XLVGp6wZyBsZIg=;
	b=b5uTgBJ5OCN9p2qHoEDAgvY2em7OTiqbDLE2ZCJ1I/b70bXJaxb6VoVYecHwDdBH7gquX/
	rbn7kpMeAPcaxnoIVoGcKr3v57HK4W1y8hOf2YRr3b+JZ7zOYiZSFAUSKczSoZQv2kJwNG
	AdRm4z0VIGt7CW19i9Dq4xqk91sbIXE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-GXcCIyhAM6aViA2QDtkQyQ-1; Mon, 08 Jun 2026 05:32:08 -0400
X-MC-Unique: GXcCIyhAM6aViA2QDtkQyQ-1
X-Mimecast-MFC-AGG-ID: GXcCIyhAM6aViA2QDtkQyQ_1780911127
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3855694f8f.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780911127; x=1781515927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKA73a2j5fYEJYroB0bsYaL4izOO4XLVGp6wZyBsZIg=;
        b=Ub8Iy2wMXlF4QuYBczfnMUSVChIcJT5Mjj5519P/0GYR0zaVwx2kL7i1/ex65jvgb1
         QUevQbv7ryrc7qlxZQn23wqfECzQabSuE2/A5Ln9llTqt1NQST4R0BPMWVZ/m8cWF3sK
         10/Izpoy8//6SHr4FoGU4CxtXg4i0g4jR/7Fpfq6ISyVUnqRjvIPZd2fG33AZx6eqkie
         XdNXPIdfIlIbic2ynh/ZDgaKNney/aJMym/JzYq2agaP6UYR9xSOd4IyYJsFy/IyRjlR
         1CeZFdFZhCwz73urrMbO2ymBusibvuodAd7GwYBxVbb//Cy4FLBtlg+/QOSIZ/Q84bd9
         7q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911127; x=1781515927;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKA73a2j5fYEJYroB0bsYaL4izOO4XLVGp6wZyBsZIg=;
        b=fYUEWyxoDbwGZLyFGS2PQ54dB0xXDUcDh5QUDY7T8QTTaPsjCWJnUZXcNW/nVPbZwM
         xKw8+xnvJnVksI4iotVXZ36swaZUTxMd5C9iLQvOq6JAFz0EccVyHTabyJHkPAkI3DSA
         T2lwL3ejCxa3y+mNv5tUN7LNN08zHTcaHzmLx3XAT1ljtJqJ8OH5xfAOwwRh+8/fuT9t
         A2cL8ES9D6KWPBrNeT5QY23BMGx6CGf2euKKbNUkDgUrDsSDcnVye8I2dD3Y4Et+zOh2
         DsXg3Pzl34zUeupHkgW4EDBm4Moe58ikPaKw3j5GWqRKNDQIMKC5ub4QehV4Rj18WHLD
         jckA==
X-Forwarded-Encrypted: i=1; AFNElJ9VczWr45LAuTnV9IsYOID3Cp4hCsEIzuMrdteRpGrD+DtN5d2sN05vyN8WT7rhFHoySdTJZUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oGZM5mOrXZH47Myb6/lICNjHaFhGUsTUunlAHVLiBjCDagLH
	yrmFpqcpbRd1Z+Q4Xpa4ii9eoVWXqpkBXmz+2RrDmIxfWtJdY3BOPXw28WBAzgpxthKV/K8Q9xh
	m7rXiGWmUPoeic3pat+xE04ntZjIAEtCTDa7o/KnyJLrwkT7I5+fRrnUxtQ==
X-Gm-Gg: Acq92OEEfXyUDb5H+H95WUa2lo3pj3P14sAJ/0K/Klh+A4gGDEPlp6tRNo306ZSbaui
	eWGbm2j5U5bvMXBccIP7gWMJu5PJi6rYv5NkalZyeMyzixn4+YtSNPBs8uTQUb4pWBRUI2xAGHV
	xgvEyKMENz1jyzeirysn3oCspPVAOXtg4EaqHfIzIcljTsMqexgRy0tC7fmHO/QT6QxN0z8i8Xm
	R0IcLya8aVQlehVs8qcEwMNnr/qH+CSVBGLY+7NxZCjU7F1UZYyJFmBEYs+UVFbPl+C1vFqTtih
	f+43VtF3tDhit1ufEexx+NBqYbYh3giw17kKnxRtE7Ksxm1eqVOyEH+LlpPWGoSKSEysPVYk5NM
	6i9VcU/SelGSGX5mH7lQLqm43ylzjKvkVYc3kwg32YGBB6Huw4P0XWHUxjQH3yexXCQ==
X-Received: by 2002:a05:600c:4fc6:b0:490:b432:6f1e with SMTP id 5b1f17b1804b1-490c2614bf9mr240476005e9.33.1780911127125;
        Mon, 08 Jun 2026 02:32:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:490:b432:6f1e with SMTP id 5b1f17b1804b1-490c2614bf9mr240475575e9.33.1780911126727;
        Mon, 08 Jun 2026 02:32:06 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm285671275e9.2.2026.06.08.02.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:32:06 -0700 (PDT)
Message-ID: <a5b7a3ff-964e-4ea4-a61a-609d19acc58a@redhat.com>
Date: Mon, 8 Jun 2026 11:32:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] geneve: gate GRO hint in geneve_gro_complete() on
 gs->gro_hint
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Weiming Shi <bestswngs@gmail.com>
References: <20260607085611.3359742-1-xmei5@asu.edu>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260607085611.3359742-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-296433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB95654A11

On 6/7/26 10:56 AM, Xiang Mei wrote:
> GRO hint handling must be symmetric between the receive and the complete
> paths, but it is not. geneve_gro_receive() reads the hint through
> geneve_sk_gro_hint_off(), which honours it only when the socket was
> configured with IFLA_GENEVE_GRO_HINT (gs->gro_hint); geneve_gro_complete()
> calls the low-level geneve_opt_gro_hint_off() directly and acts on the
> hint regardless.
> 
> On a tunnel without the hint (gs->gro_hint == false, the default), receive
> therefore ignores any hint option a remote peer puts in the frames and
> aggregates them as plain ETH_P_TEB, while complete still honours it: it
> inflates gh_len by the attacker-controlled gro_hint->nested_hdr_len (u8)
> and redirects the dispatch type to ETH_P_IP / ETH_P_IPV6. The inner
> gro_complete handler then runs at nhoff + gh_len, an offset receive never
> validated nor pulled, and reads the inner L3 header out of bounds of the
> aggregated skb head:
> 
>   BUG: KASAN: slab-out-of-bounds in ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
>   Read of size 1 at addr ffff88800fe91980 by task exploit/153
>    ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
>    geneve_gro_complete (drivers/net/geneve.c:965)
>    udp_gro_complete (net/ipv4/udp_offload.c:940)
>    inet_gro_complete (net/ipv4/af_inet.c:1621)
>    __gro_flush (net/core/gro.c:306)
>    napi_complete_done (include/net/gro.h:530)
>    veth_poll (drivers/net/veth.c:987)
>    __napi_poll (net/core/dev.c:7733)
>    net_rx_action (net/core/dev.c:7953)
>    handle_softirqs (kernel/softirq.c:622)
>    ...
>   The buggy address belongs to the cache skbuff_small_head of size 704
>   The buggy address is located 0 bytes to the right of
>    allocated 704-byte region [ffff88800fe916c0, ffff88800fe91980)
> 
> Restore the symmetry by having geneve_gro_complete() go through
> geneve_sk_gro_hint_off() as well, so both paths gate on gs->gro_hint.
> Tunnels that enable the hint are unaffected.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Same patch from another source here:

https://lore.kernel.org/netdev/b2052195-0411-4fb0-a802-718e07804188@redhat.com/T/#t

same comments apply here, too.

/P


