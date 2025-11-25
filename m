Return-Path: <netdev+bounces-241534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F67C85596
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF73B2B22
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739523D29F;
	Tue, 25 Nov 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmWwtbRN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCGSpeLu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC693246FE
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080180; cv=none; b=f/7363wmDv2hDJ7WDNSJmUoZ1Gn1or3IgjmbWcs/41CMP5YwcsYI1jHymwc4JJmkW73G0xKT7aWa8jrf7hWTOXGg3NTlfAzsOtTcYUxYbKpW8ZkpaNz1usDjtuF5tiFZ+EvjWGF97Gb8f1iXsyztJOvJNrAAP30v7lelag0rdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080180; c=relaxed/simple;
	bh=fz8dUOLkrmuqWoT6oi5DtVb+2CmS9v+v6gFIhBnZfgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6VQV5p4qtyjflAPHoUwxqRbIonI31AgvUiptKr2inXfWtHxBI8N8m3mGZNkYLkT0d5j6u3NR7d6Yxtxfctpk+ZBrom26GGcXoTNSon+VzrO8ST2UYzxcMIVB70v1ig2Y3ziMbL1ZE0Bd/ViUN9KYzAYIP9PbXcg2bV4yrExx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmWwtbRN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCGSpeLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOVfHp9blK7VBhAWHvqJJVbO8Gp5yJ1ZNq+u6p5xQdY=;
	b=XmWwtbRNJ/vvEM+j5RKc+zNO8bDf7s50QyR9mfeA1mz8TH36D8nZyIRvuOhsPu1qwcOK1S
	lTEU8w+vLPBnDVNaJu/4scFnwMj6NBRZnz+IZno8mp28fJ2gLrdaEVJIfD/XzxeKyFsSqT
	LS8s/tsXpGdiz+tzwprN+C/yPQmYocM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-QiJ4QWbrPta3qHRnL8GlkQ-1; Tue, 25 Nov 2025 09:16:14 -0500
X-MC-Unique: QiJ4QWbrPta3qHRnL8GlkQ-1
X-Mimecast-MFC-AGG-ID: QiJ4QWbrPta3qHRnL8GlkQ_1764080173
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47777158a85so73375875e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764080173; x=1764684973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOVfHp9blK7VBhAWHvqJJVbO8Gp5yJ1ZNq+u6p5xQdY=;
        b=CCGSpeLuZmHVdzmXrvN34Xh1zz2wNuFC5EnK1THbWJv+HZQGbykucwT3bRcDc1Hosw
         4bMYYWjn8+vSd0GwDLoYuFi2m4sWMepp7J2U1jQxOvXyY3SbbivFmo+D9Bxp8sQyYG/w
         hf9xlJi5eLXfX8diJJewMImGNccxnpfZGZJ4idlbBbcJ1OxToTMqGS4+WrbMmoCizMpp
         ZNDgs1tpwIwNzMuFpixyvM4Emgpn5Ak8zompAmLeM0nVF1kNAHaNDtOqK1mW2GPhhphA
         dL413/icfm9EeKueWqu26ZVwqSdsvQNjuxd5TNwi3DRcwGF4+gwBFncRRdWTg119dd6C
         b5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080173; x=1764684973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOVfHp9blK7VBhAWHvqJJVbO8Gp5yJ1ZNq+u6p5xQdY=;
        b=Vtj99Th3HBiumgohh8vae2yVDuZg/N0bSjhc4ejpYeEixm5HwXZsqciwCn9uhoZfas
         w/6X31S7rmaHAsG5+f2LXJ4HIlzq5JFpW57GhCwTXCOA3C9EL8P8wb9MUxXlt5aDVrU9
         0enms/kP7DkcOiozzPdQRRJI/MWcB5oPuD4nrrLEgGwIiVmPN4mOdXsnFIg6YmgMC60/
         FI6roVcHPNURDevycu3i1S/ZhzViqpFdgBd2m2DJk6I/d1552DdLZgf+oVb0B0HEWN0y
         /s0rXMKl2HfBUsBp1nGtjDBgafiz22poRVqqbMXTgngWvwheWaQDMy1NFnJDutyRYIEN
         O+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6T5PGaHOiIS8x6fw2PIGJbGCuwRbWJsV7KFfOaKuKnQXJPh/aAMhxZ/Q3dxmnFjzuxr9FlgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8OW5dFm81x9+MIF60ZYse6U4a+UCFjVxbgHD0CdNDi0u8+AQ
	9TKBg/k2f0H87t9032FUjm2zNUsLkh37VJKcoWtzoem6pOVHCXP2WZ4CBl20PtTSaG8yt9YYccq
	uuBYdXXPvvQ6o4CVgvfvK2qOLl5Vcmn/0V8G96J3fyLI0VtiXh2/M4QSQ8Q==
X-Gm-Gg: ASbGncupMpk5uuZYngBnOAzG3OLGcxYAleRaUAV46wztdDOj8m30FxTMV8jhB5CJ+cx
	Cl2v1F0qyj8j9lk3UG6ZFquhVmgLLnAzGlQPvqBb130hvLnCeCLuPNCB4R393Iv/OAztiYCruzR
	+Xy7wyg7fFXI0SDCeaIUcnCcE4puyAws1TEVjbwggyBzdwc32DQTTiOvd9A/nwYU6G+Vj8Nj1J+
	6B0nxuM+u1U1vZcw5Kr3lvWdZEnCxJmb0FOoOoLK3KJpyIpcCY07qeRoAEHBwNVnJfBw4bP44uX
	a/IVlN0iZdTAh88MqDsgPmE6Z3cdd7B9kY6X29XPGMTyyHY+nr/Vj1RD+ym9Zk2wmsG264LdR+k
	=
X-Received: by 2002:a05:600c:35d1:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477c10d6e76mr166439275e9.8.1764080172769;
        Tue, 25 Nov 2025 06:16:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9xDEm63fmzn5I9bRc4mGBEdTRc4fc7SlxHbBVsUfrg8G31SlrJq8hRiHKGxsIJ2OdDp0G/g==
X-Received: by 2002:a05:600c:35d1:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477c10d6e76mr166438925e9.8.1764080172349;
        Tue, 25 Nov 2025 06:16:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226c2asm252052355e9.10.2025.11.25.06.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:16:11 -0800 (PST)
Message-ID: <106cc1c2-3e7a-438f-a7c3-7d8804665cb5@redhat.com>
Date: Tue, 25 Nov 2025 15:16:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] ipvlan: Make the addrs_lock be per port
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Xiao Liang <shaw.leon@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Guillaume Nault <gnault@redhat.com>, Julian Vetter
 <julian@outer-limits.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Ido Schimmel <idosch@nvidia.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-6-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-6-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> Make the addrs_lock be per port, not per ipvlan dev.
> 
> This appears to be a very minor problem though.
> Since it's highly unlikely that ipvlan_add_addr() will
> be called on 2 CPU simultaneously. But nevertheless,
> this may cause:
> 
> 1. False-negative of ipvlan_addr_busy(): one interface
> iterated through all port->ipvlans + ipvlan->addrs
> under some ipvlan spinlock, and another added IP
> under its own lock. Though this is only possible
> for IPv6, since looks like only ipvlan_addr6_event() can be
> called without rtnl_lock.
> 
> 2. Race since ipvlan_ht_addr_add(port) is called under
> different ipvlan->addrs_lock locks
> 
> This should not affect performance, since add/remove IP
> is a rare situation and spinlock is not locked on fast
> paths.
> 
> Also, it's quite convenient to have addrs_lock on
> ipvl_port, to dynamically prevent conflict of IPs
> with addresses on main port.
> 
> CC: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

This really looks like a fix, that should go via the 'net' tree with a
suitable fixes tag.

/P


