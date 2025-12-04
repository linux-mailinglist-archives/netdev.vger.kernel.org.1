Return-Path: <netdev+bounces-243560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F049FCA3AC6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43C78303A68E
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F4E341042;
	Thu,  4 Dec 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiB6AHAa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZeyQC51"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C933E35A
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852730; cv=none; b=FP1CsgTwsA2T2tiB7sPglgv6OFBPSGa+9qyN9crDHH8esdvv3ZBzFCRcCn83d7oYcfLgkPkaqPQ3872AHKK856fZJiAxxoejE3L9CSgihsK9bEWHyv8BooRApheg/GrHGGeRXvZoimug25NUPP9oQ8vHqn+aVAYrpB4wfcy0NxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852730; c=relaxed/simple;
	bh=OGnRAPHhgasM0mRjlVYUPiBaKyj9vXfcbziV9w7M1Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXmSbj4EFlig9N/WEvJUVV2tAthSBrxnsaPGAQKS4mTt201xRckMIt6Kn8i07s67Yg1KcDTRR+Rl/9hLAwI/tGm5grAaft2yvG3M/sHtRXuNbcRXcR7HyGArPYRWJQDMtVKutrEKLSMr+vLOJla0xi6YvfA06BeZkFULUM0NQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiB6AHAa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZeyQC51; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764852727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWKFtRptmn2CPvnrXCNnyvZybDhYlyGG2xEo5BhJnDk=;
	b=QiB6AHAafeBheB4P6mOo+xXIsq65zE+az4hNzBkstG5FDcRPuP3Hr473aA0Nb+rMl5Hzf/
	1YfEep7dlDZ8l21E+jAecImzkC0sD/BVnRc7CB4UT4CIiXiF3q7IyKWWyg/jVnV1p3BT6q
	FSZxKsUOsIo5TY4XuxHh69LeOdKUw+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68--zRSkFw2MtqcsTLH3JYjYw-1; Thu, 04 Dec 2025 07:52:06 -0500
X-MC-Unique: -zRSkFw2MtqcsTLH3JYjYw-1
X-Mimecast-MFC-AGG-ID: -zRSkFw2MtqcsTLH3JYjYw_1764852725
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad29140so464497f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764852725; x=1765457525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWKFtRptmn2CPvnrXCNnyvZybDhYlyGG2xEo5BhJnDk=;
        b=WZeyQC51xFlJupxMlXxTWvOG0uul79eVAvSLXzUyuf42oRBCohPf/lEyyIdD46kE/v
         iorX8DROi6NgLnoa3R3aDDh5P1p38Y50eUvuHSZn3/9BNmd80bMhT12XBMh/7vl2CYBH
         g/B7aJZmoletqGifNi80GF2n2XEexkX2POf7cp4g7iUg0evmshrTJvtu8WP5oJlqy2fv
         I7a8YQtfCMB3b+Jejs4z6v+Onpx/LJQB5DurZtGlUtkZalQ8cxI2g9OLBaENGXz9dWPF
         IiK1REM4UT/u1bd6PkxpVb3hz+MJZTrKCkwWLwdwbt9ed6NiDHMXCkhRZbBzKrchwk1Q
         0nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764852725; x=1765457525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWKFtRptmn2CPvnrXCNnyvZybDhYlyGG2xEo5BhJnDk=;
        b=vAQt+Spajgr6b6s3ptPFAeiH6DNyamSSavxxPtfm8AIfXuhSAOYF73WzXAWkCxi5fz
         e1vaLg+VIXaqTDh2hWjoe+MXT5KjOlRNtQc9k2ytzgdjKAM0n3t1oenjAHo1d6+H7Z4d
         SaoQRb354hTsm+n6YS4WuCFpaSh/87/9alDBigLgL/+v4fhOn7EOJqNwiVY0SzRkNZIr
         8U8Cz2OIn95l/4UJdlEPK0/ZYrzbNgkrbmNeue2fuXqL6Ws2Lv/9D8AzV30BJjrwfslL
         vWWqWs2dsSjJ4ZXDS2g0/D6D4DtRHc9MyLgicDSKgbO9sAtcWshBIx915hlrZ8a6jDe6
         1A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWOX60qG5er/PFvKN7/w2MbqnLFqaRV5sqtiNNkU6I4NZGKCg2ffOMw9TXwk4r5r8m9y51RRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8pn7fIRTY5CsDWCXPrdLi6h2pPAaBsVrWvB9QJ0ych/Ei4X8
	QcHrqVxnuUR3mX8vRMLdxQTAvTJPbj4tWmuddd6pVCwhrgOkmQPEIk0USSco7Ftu44CNkEnwXbF
	djfz7FvObR/gMblnnCrB+eWA36FwdEQl+0JKvVujG4xeajMloSQL44lQTBA==
X-Gm-Gg: ASbGncudP3NhBUB93fJzVbsVC0UXX8SKZqG5Aj1wyfNopBQ6I7L/1MAiRs5KYgoz5KV
	lTVpCHofu6Hk96s3wsG5HzKnTLyKFHvkgh1Oc9lA89SsKj6X7dfkqijF38sAX1Tn6LW/tAls9LX
	1qdzczNiQgM31MVLBRhho5DGsivnW85hBdUC35iNWQzK/VWWTJQKV2TuGMCfJoSUyTEtCqNtvjw
	pqNv5D36CvUqy1VdefvDhx/Q4hi+LeIVFrVTCKBZjAH3umyBJ762jTaIfmvpMMCoNu5SiTlPEpr
	H8IcyX+cstQYvz4+KDrqkwFvVBwIQngMKyPQbQFq21MDXCy2OHbeRtHaFQ4kCGaZPJ+XcB/AcUt
	rlR8oQ/OKTgG8
X-Received: by 2002:a05:6000:2387:b0:42b:3023:66be with SMTP id ffacd0b85a97d-42f731e9ba5mr6129784f8f.32.1764852724729;
        Thu, 04 Dec 2025 04:52:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkMufu4r67XizVQgnp7KjtpXy4lQIc+l2HNrQKXtYq9cAARc+rF033dRP6a6N5PuJ2vMHucw==
X-Received: by 2002:a05:6000:2387:b0:42b:3023:66be with SMTP id ffacd0b85a97d-42f731e9ba5mr6129753f8f.32.1764852724308;
        Thu, 04 Dec 2025 04:52:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2231dfsm3075796f8f.26.2025.12.04.04.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 04:52:03 -0800 (PST)
Message-ID: <eb26c4db-5219-4ee6-b49d-fb324742266d@redhat.com>
Date: Thu, 4 Dec 2025 13:52:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Julian Vetter <julian@outer-limits.org>,
 Guillaume Nault <gnault@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Mahesh Bandewar <maheshb@google.com>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251202103906.4087675-1-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251202103906.4087675-1-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 11:39 AM, Dmitry Skorodumov wrote:
> Packets with pkt_type == PACKET_LOOPBACK are captured by
> handle_frame() function, but they don't have L2 header.
> We should not process them in handle_mode_l2().
> 
> This doesn't affect old L2 functionality, since handling
> was anyway incorrect.
> 
> Handle them the same way as in br_handle_frame():
> just pass the skb.
> 
> To observe invalid behaviour, just start "ping -b" on bcast address
> of port-interface.
> 
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

Since you appear the have momentum on ipvlan devel, please consider
adding self-tests for the issue you are addressing.

You can later leverage the same infra for functional coverage and that
will help your intended development.

Thanks,

Paolo


