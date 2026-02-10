Return-Path: <netdev+bounces-258061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHqzLaUUi2n5PQAAu9opvQ
	(envelope-from <netdev+bounces-258061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F170E11A109
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DC23035D7D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F304C314B6D;
	Tue, 10 Feb 2026 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZljnbkXi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1nbFNb+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A52E093A
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722466; cv=none; b=KoA/+XYocCjTKxoeYCH4s8QLSyg/9CCvjpH/m+JLTd/cj8JKq/ec4j+YT1x14FGc9EBXEmchMCz9dPUH5UmMS4zj5qdkU7mGcF9607E5ENW8vina96PvSx0T/EiGB5HWATwWEkTfSzMjfG2JKhWNJQPhuXRiN+N0hFPgJYygQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722466; c=relaxed/simple;
	bh=eKcEZlo17RdBD4UYDZAyhczV/J20m1EXzW92cGhob6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CdJLr+GjysBXC6KHI2vrWZGmmttLau+k/AUt8gl9M+DnsjujEAaGV3IVyHL+Lpqv3JDOpjuvaN7qs6v2LCZUInclE0ao3fPAShZKXSYoqdUtd0CdAjt4qSUoHnBiIg32RAU+thS5qUZvRGplFYrwyOcYcMl8bIUrHCX5EFedC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZljnbkXi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1nbFNb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770722464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
	b=ZljnbkXin2vylX7YDV1UkyeVQtOnG4zHbDT9uw8vDJUjzFvLbf2dAt1h4WntSDv00apIiv
	G/v0tXUV8ybyro8BGTXogAw0Ra/ukBpUouldM6j7vlGsicSHhnWuA90mwr8eYh5pk2fCF8
	8qHkxd2nI1JW5Hlq0Y+FH34aImVi1EA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-NDBzZSTTMaSVCsgk2Ff8_g-1; Tue, 10 Feb 2026 06:21:03 -0500
X-MC-Unique: NDBzZSTTMaSVCsgk2Ff8_g-1
X-Mimecast-MFC-AGG-ID: NDBzZSTTMaSVCsgk2Ff8_g_1770722462
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso34111265e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770722462; x=1771327262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
        b=I1nbFNb+30U4KPiY2Jbu47b8yADGiug34Y3y9R/FYEK0ouhuhpvRf8Ie6DYdwQWdrE
         IlUnUuqjU62SfYNSYg3W/7zpPVDZn8IcQEOIho5fdAiIfxpyACN4Wd3fZk/McoPEfSyJ
         GzY2OWIlRvNa+4iYKyV9i6CcZf2iyvItdt3lUhXpECdkHkEJ4S154tNL+Y3pjcL867wH
         s1zcNM1ISx3aK7740iIzUz1hLslKKlAtlqEW2Mt0dcI0E5uuCWVx0SiRN5Y7NT8Zgtpg
         KaO4dCLJih3PIjCG9KEbsZih8ns3Hj+T1L73guXabrgdLJAwRkSYcp/KBSmucnggtJLR
         3CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722462; x=1771327262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
        b=qs/ZP31Lsc2hHucy3c5oODvC7wNUjB6sJ8WN4X/d5xkf15wIa/O1K14b2IUTK/3k+r
         a7qaHYi8bN+LNhH7sWrNJY5UZbu4aKi2Yww/1WW1iS76iy1iX98XyRXlSU6iVyOQTlSW
         mWIpCuYXm92twz+EFPWYflA8GBB+ATN05nbZ4pyFpfjMaB/2tsa9MIcOP7vJK6OHRPvI
         J9cDf1g2r1WKsTVwI68GlKE6FOdpdE7pZNMjBDLsLTgx4a3SuY5dW7CkaZbxRkha03FG
         if6MvwK4xbcsdZ1Hz4ojXREs+xFjm69397lyQ6q82FvdeHcBBoY38mCG9NsQsq68tV+o
         lEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfrovs7eY0v0qVYkk0YmSlG8YdzT2Qn32qNZWRlbxi0GU3STwSPloLfWNb0S4hHoPtBgAtIAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqPdlomirFV7Iu8jXxhJVYFl1kQD7Pus0hcSjhjCq7V44miEu
	Nx6xIZtlzWo+wKoLFV5NenSQ0UKO+O/HDSYJkJvO0479krOajotrStvaA2PZsvlpy7+b6vvxPet
	+D2zR41KuNY0xX5TWgeuD9Hvfp73L1lq7Ne/M5iD0jFKC/PPOE+YsJg0Sjw==
X-Gm-Gg: AZuq6aIzCxdiSEAuEFJKbj1Bmbf8P71g192k6ZymkJD5jQJVWwmF2J13se2vLLs4qVk
	wyVauOUa3iFToX/YqFATAGiGcij0vjt6XTurFxlMQfdwgriNGOURJpvcM2dBcH3i1ECkzhCFquK
	tjygjGmHHvniZu9qPCGaZWsnOgXjLTESbebQLI6AIQ6w2Lg0872FjyTjHC7cJCzHmlUsxqYZzWr
	DgofVQNxTfFUiZZb2wZwK/oSjqFKUFU4LcNraUnEwMRW3P2n5jVO1aCrJ2TwEUm8O4TMYL8aMwo
	U8s557o4cgjGQfewmKHVLbQqogyThkTGxfZunJaRQcPjSfpfoRvWRRcU3wN2m/IQxlS224ZAvQ6
	UI3HCgG5YwMJRXoo9Drcre3A=
X-Received: by 2002:a05:600c:6612:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-483201ecbc3mr232437065e9.16.1770722462066;
        Tue, 10 Feb 2026 03:21:02 -0800 (PST)
X-Received: by 2002:a05:600c:6612:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-483201ecbc3mr232436535e9.16.1770722461601;
        Tue, 10 Feb 2026 03:21:01 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm80277245e9.1.2026.02.10.03.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 03:21:01 -0800 (PST)
Message-ID: <ad37a4f4-7a03-4293-a8c3-1f0bad2f2489@redhat.com>
Date: Tue, 10 Feb 2026 12:20:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] net: hns3/mlx5e: fix CWR handling in drivers
 to preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com,
 andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com,
 mst@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
 <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258061-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: F170E11A109
X-Rspamd-Action: no action

On 2/5/26 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Currently, hns3 and mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP
> segment with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN
> is only valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168
> ECN offload to clear the CWR flag. As a result, incoming TCP segments
> lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
> 
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
> 
> Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
> Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

IMHO this should be split into 2 separate patches, one for each affected
NIC.

/P


