Return-Path: <netdev+bounces-224415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B02B84629
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1773C543709
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93083303A32;
	Thu, 18 Sep 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf2HFvtl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759D299A81
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195627; cv=none; b=EUcRVZm0evflp3YFVrty5r4I1OHAY0g0F0zXTbRWQw0jd+nkFfFmNQfLFSBSbOb698Mw3MIGvJEh6IowRQBZ4GZ8Z5vYNJcKyUfXTFBpHVKsdSKfjaNnk0WWeHFKw4owQcuKwkfXyk6w5CD7EqczGvCgKGXZou6QaAVIw4T/wHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195627; c=relaxed/simple;
	bh=94EML2YX7AYmMlLS4ljOwRT3kFId4sNZy7RWcOBmjy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Daj+fcCTUzQ+7AHkVfdjdzOinioFGmHSsbrQQeH1GUEx57BmVukNKrXDf80hbca7WxqOS3RiRZnaxGCiyJUIgqysPC7OuzAR1Nzda1aO2aj4snFGKTEHf0w+qPVIxQluMjL0BEnM8mQWP1g/HXpUUTz0hliU4/dQIa+WpAi/hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uf2HFvtl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758195625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgPJVM2wYZcAOQHjxIVTAbyinSxKVYEfxq5qAotJRBs=;
	b=Uf2HFvtlyMh8F0QVjwPAsLALXrOwGEV85ARGb4jV0ni3RbUkeZHN6feh7fn2vjvoP/9pHN
	de/1l4BI1D69D0oAl9CisrDH/BLtWFHfX2Bju4oJuTRKJjGSgsis9UFxmGbDOAhy1KOSNM
	Os/Q8CaMTHcHBfu3zmdMk2v8cktcRO8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-KIU5fsmdNY20DBIoePvXUw-1; Thu, 18 Sep 2025 07:40:23 -0400
X-MC-Unique: KIU5fsmdNY20DBIoePvXUw-1
X-Mimecast-MFC-AGG-ID: KIU5fsmdNY20DBIoePvXUw_1758195622
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df07c967e9so402726f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195622; x=1758800422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgPJVM2wYZcAOQHjxIVTAbyinSxKVYEfxq5qAotJRBs=;
        b=teqSi9ii75meZDSq9UC3TYvxNJLhFG4RjKmgmaIaNNYtDAZgkRg6eFKppnp9JmJIWb
         jbSlknY10+0hEQ5I9sDU1zWbog7BPGDycFToFhMY2/bpf2OLkyU64bIV3+zX8dbUmWGN
         bPGng/6RqjmUaWj9cxSlsm0tbqIY7Xy+HUfTDLPVGJWIw+ifGFIfSIeuvZiqaq20+aOI
         P3DnxHI8mZ6sHhS20x54FHZm+61mJani1vuJJyzgMMwnbl+sedZLb+OUC3Dww0Kdj3XX
         kHqRorXTNaKzjLMGOQyCExcRQWT8UyCz6E3+qd6r26UP7MeFPrm73mburIjC4gi4sEYv
         /ZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsQSwkeTUES+wVh++TKgHdY322Eg5l3Z0YJvg0QQdTD1hjxjwM7uuvL8AUIUn03J5L93sphS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuLbV9xWrj6c0Fg4k418xTvrzISHBqgU/XWV3osX5nBL7DBgn
	XgbY65c+6bS6uwUS+cqQvye/oqk/8tzdLBUqiO0pb2FtN03K96KgkmIVJsiql+t6scgeXNDbLSY
	qt4SoOm/f4eODYUPs7I130h7ZliKBQaLti06XS4BW+rM2TzymT9O/vZAxYg==
X-Gm-Gg: ASbGncvJL2dbVJAr1FZtdRlM6oUWRLu5a8C5ocq/5QX+mY/DC9XSHWCF2CtBawB5yoH
	rQoJ5Gn4pQwJ+fvkXdTCkSo2qiHKoryH1Fw2WyqGiAP66QwXt/GjO0PGT9Ke37UgRycBR3Rj8vq
	hqYYnr27iuR6oee5VwYjLPlbTaQzW53AP3Ip4XZ1jQAH4yhbi0xmSLbd4By/zQ6+wi5tHhaEtU4
	Z3Rc3sN7pc7naHNCUk+rPfe/F1vR7wzRpbbz6h2J8gUULUGAnXOxn4gXICDpL1QUPmuK09et9m6
	Kr2Q9a0lZ0x8Vg/a8rHGr40DiCfx8ewpLBjKcl/KCo5LKYeGDonjy5sntINPzlRWhbmoqNUjCZY
	OScl74RLvZTFP
X-Received: by 2002:a05:6000:2881:b0:3ec:2529:b4e5 with SMTP id ffacd0b85a97d-3ecdfa0d552mr5324877f8f.38.1758195622487;
        Thu, 18 Sep 2025 04:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiiMzhoC17rGGpLet+riqQz4wspo7U3zll9Iwt+xXUHl5ktjRATKDu+gU75xPefV+06WISSg==
X-Received: by 2002:a05:6000:2881:b0:3ec:2529:b4e5 with SMTP id ffacd0b85a97d-3ecdfa0d552mr5324852f8f.38.1758195622053;
        Thu, 18 Sep 2025 04:40:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm37805585e9.17.2025.09.18.04.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:40:21 -0700 (PDT)
Message-ID: <717ced87-a6f0-4c0b-afdb-72041e297fe2@redhat.com>
Date: Thu, 18 Sep 2025 13:40:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] psp: rename our psp_dev_destroy()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemb@google.com>
References: <20250918113546.177946-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918113546.177946-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 1:35 PM, Eric Dumazet wrote:
> psp_dev_destroy() was already used in drivers/crypto/ccp/psp-dev.c
> 
> Use psp_dev_free() instead, to avoid a link error when
> CRYPTO_DEV_SP_CCP=y
> 
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Closes: https://lore.kernel.org/netdev/CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

I'm fine with applying this one (well) before the 24h grace period, to
keep the tree saner.

/P


