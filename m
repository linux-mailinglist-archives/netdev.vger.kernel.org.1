Return-Path: <netdev+bounces-207063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CEEB057E8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C154D163DD9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0F2D46C9;
	Tue, 15 Jul 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYRX7OIz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75F2D0283
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575646; cv=none; b=LDetqtd97XLgD+QR4XuFjGWeTfxLqkzASqIBa5OZai4yJD2NTHWlaHMe8QX4hZn5DFu6bdVwpjs/bRKmD+xEgP9u8yXLCoh/0PLHOtlCfK2RAxsrI09VeDZjkNZObp51UAVU9aSOFUFIreudxgkKaKPz+9NFOorhMMdaVi+y8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575646; c=relaxed/simple;
	bh=+XosNr1noYyK5bt9K7G69Cb5UP29nUNpnRR95dziKDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR7DRVx4ZaWebhYEVwCCM1TVg/fbj7KmojIS5H0NsFSbzIJu89Ao1NwJ6TjFLdicy4ilRd8AWkytqP0wKD3OFar+hMObeOuZx6pIBJbfVquzZFucWHJ4k8byTDc3nxdIqq2en0ibeCKcL+TpxDTcAI3gxMX3hIjOV5B6h3pvBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYRX7OIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752575643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJZroVj36ZRC3vYmznkw5e0xFAh0ohF+p4dqRbNSEEs=;
	b=BYRX7OIzXJhaXv63hvSe+xNCXi2k91ipaEe4O6hDEnwyPXiAVWYqBE2+SwE2KOOOZ6g+p9
	IO+CrfqqOUlKklLtUy56rsikgU9nhCVieHJa0ev6JVxa1lmMsx95LhfvaKplasMqa1w6J+
	gmCW8AFFUDVbg5zqtRKWHoix1jBn5oQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-IPpDUGeYNzmxuJfk7frDkA-1; Tue, 15 Jul 2025 06:33:57 -0400
X-MC-Unique: IPpDUGeYNzmxuJfk7frDkA-1
X-Mimecast-MFC-AGG-ID: IPpDUGeYNzmxuJfk7frDkA_1752575636
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2590749f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 03:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575636; x=1753180436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJZroVj36ZRC3vYmznkw5e0xFAh0ohF+p4dqRbNSEEs=;
        b=SfIYyJTnq/mkSRUSv2dlGcVzbn5zLfVTStcDFlZyHQ8NHGrY1kYHcB+Tnrm04se6W/
         XHa2Fbp9LqIbQymo5CkUDKJhcmKRxGnZtTDjyhL3sMxiWZkhlbbw1pcJKu1tOoZBqWyy
         Df+m4aTmMFnscyVtGggEJJzsE5KK+6K5ZRFT7pAqNmkDIqVQ3dO5A9ZotTyPaH8xKwYy
         jtBvmJlK0n6Zsce5zSoRHX/XxOH/2N85oZC9DvPYpBtzyNYVS5Tzh5TGSSP8oU6bLgHl
         6hGb5q2hnyafUBeirXZTTQUqpRMksCXM8N8tPX81RoQ20NeBxtqN4hbXBQx7P344m3AU
         ICPg==
X-Gm-Message-State: AOJu0YwwADWCTg6RKyk3j82tdsmyW7cpXvaspdsJFljy89FAbzXOaOK4
	JAIb8YJYUP7h1UXe2Ov/GGnFrAzmjj+t2xyHyc5UhWzrJXwt3G1N3Lot6rn8EEsvG7Yn95tRvL9
	ljae+0fwKNqkAAjIbrorHX8Ip0FSF3bOK05ANEXLH/WEcp6bWJbNT3uYDFQ==
X-Gm-Gg: ASbGncvFuczQqjW16oZhpHY+K5J1amjgaEfW8WLWigjK4ZlKPqIv8mCbvw6U+FAUubP
	ytQq3dRyXd1z1W7g1nGrZR3YFO0lHh2uFwlvnxLktVcxPtDsP6VzWxt5jI9IbMftXf3+Tn3S2li
	eXzkEFM2AUpLzmqc0LGjBBz5SnKbFwKKJeNEcEvkWKWiNAbPwJTE5torxPn5UrNzWKdo8Pq2dqE
	UNHJ01TBze/08LrsDtNF/mG5Oj2s2sgc2z4kZ7xduKaVOJFDF+DYYXlnOiAV3Qw70XbXC2TEf8F
	dc3+Sw4WcGuks2a7SErAYVrxpHiHZK39hmZ+uYvxM7IrquAu3ty7bbBF8Ed+N9MdPJFl4t2gEii
	UIB8/k8OI2L4=
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr13886747f8f.51.1752575636030;
        Tue, 15 Jul 2025 03:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPG2tIYoFI1tuT6qjgNqxoevPWcjHN6ppGIaEdQxignfEXuFG+6+vW+GCRlJ+0Y/2Vp2b0LA==
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr13886714f8f.51.1752575635585;
        Tue, 15 Jul 2025 03:33:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5050d34sm199648385e9.9.2025.07.15.03.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:33:55 -0700 (PDT)
Message-ID: <3d2568b9-e275-490d-a412-2fe7a5b096a3@redhat.com>
Date: Tue, 15 Jul 2025 12:33:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bonding: add bond_is_icmpv6_nd() helper
To: Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250710091636.90641-1-tonghao@bamaicloud.com>
 <aHSt_BX4K4DK5CEz@fedora>
 <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/25 2:53 PM, Tonghao Zhang wrote:
>> 2025年7月14日 15:13，Hangbin Liu <liuhangbin@gmail.com> 写道：
>> Hmm, I don’t see much improvement with this patch compared to without it.
>> So I don’t think this update is necessary.
> 
> This patch use the skb_header_pointer instead of pskb_network_may_pull. The skb_header_pointer is more efficient than pskb_network_may_pull.
>  And use the comm helper can consolidate some duplicate code.

I think the eventual cleanup here is very subjective, especially
compared to the diffstat. Any eventual performance improvement should be
supported by some figures, in relevant tests.

In this specific case I don't think you will be able to measure any
relevant gain; pskb_network_may_pull() could be slower than
skb_header_pointer() only when the headers are not in the liner part,
and that in turns could happen only if we are already on some kind of
slow path.

/P


