Return-Path: <netdev+bounces-176178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD3A69426
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC9188EFEE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D51D5CD7;
	Wed, 19 Mar 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8faRu1B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32C1B4F15
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399370; cv=none; b=XE6uJ7IzaqB/D0csOxMTeJ/hBqLuzycWoLw6N2WCxgyeDHNOggmOhdCJ+Yf/xaInXZoZ2FBF4NmPznPFD3Uv6YawgIzXpgFjHeO0oPMvGS9gZfW/VwP4cbtJeUvNo49vKM1lOp+xHniuLN1oXYPIXR6z+had670aFqLJjZFopkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399370; c=relaxed/simple;
	bh=ahCsjLvqJBUOse3N2+9FKftUgcznb03HxnIhorRaMuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+vBPRIGY8l+3Sc6+qsKBsNUxqLaIOoSQgykOmDFJQh9ygxrDytx4EAG1CIeNpmv16ojp2+KC4qRY4wBIfda3xpy/u0Ubeyv21PJRKOF2XNkdPes47s37yeFFv4P8xtmT8FD7S/041aLXK5xSUVjYRbgXlh3ihgbWSnhVXjLRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8faRu1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742399368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLbogJvkEaDqkv3bI1FrnUkI4u3gZXZJWkvSDWmAwFU=;
	b=Z8faRu1BYQ3tVF8j6OYYIU6fnGRhRpOEbVgHkvpuyS50dFw7Yr9s5axKT0+f7G5pFVvofj
	CXIOkzOnJ++hdSa8dI1SPnMCZekdEOuY3SwLPo/cdbk7KYh7OdmD6121wQ1V/fAASDzotv
	eLq/+ntGeMwgutV0zI5n65py005y80M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-lsQR4cwzNW2raCRKovCuRg-1; Wed, 19 Mar 2025 11:49:24 -0400
X-MC-Unique: lsQR4cwzNW2raCRKovCuRg-1
X-Mimecast-MFC-AGG-ID: lsQR4cwzNW2raCRKovCuRg_1742399364
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912aab7a36so3012136f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399363; x=1743004163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLbogJvkEaDqkv3bI1FrnUkI4u3gZXZJWkvSDWmAwFU=;
        b=Z7RXb7G6uW8cSNYXJpmLb0QCK1UTQmSvtH6aXA9bTQYY9ftBQuZtSlDVhUR+7bH4XL
         zYRYz7W+xe5pz0h5rvrsY26prsUw/o6zG/fr71NdLDNEyrk/hDnz/cbJrTATMfJe2ply
         kcpJeONiski6xUQQWJQvrTTK2BCMmCo22kol4NLi4fwJOoD4ZoZT00/QfD12u6pRh2UP
         NdPnhuZdUymvw4jE8wsDrRGvu2yk2Q7YeQrEM9yybYU49L2mUIpyvldluUMQFCZWfyit
         jHU0nIcuV9jWydWFgbv/vUBWtxeRw+ftA6/4vu/wdJiQMqfoBDfEjORV3aRl/WeepjY7
         B1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVjO8dLL5rEG9odGnWobG4SoJKcuvD+Ek3r4vByBWCJqYfyq/CkCZb+ff1nR0IL0RETbdB0+8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8P5xLcn7tC97hTWjVR1he2zYlm0qQDBjvcsHTdqT/XjerhFWh
	kerLMQkv2jgifD5vqVJDy/pfQ14l5zcAvXKAB8G8Le5sGWp9sSMTEVChl1biKJ+Iijefqvsy4+h
	hh/e5Ako9W0g7GQ4Fnf5UviIJ+lkiOKnTu9Sck3Ggr1jusNcVATRDmA==
X-Gm-Gg: ASbGncssfLzdiDtj2yqFb8yXcVwFxUMY0TcqkB9vqluTNUX/1LSuRUZSjrOdaiExkqy
	L4sLNQHFGlV940ugKtNVA0l5iUV/FaDCHdtl77bqe7cgbizR0mIuHaEZenXl1RPmOh9sViUf2iF
	pNEkObbV+olcoY2PeKkdg28yUpFnRCPk1xJfFmV8R/6ECbkldWWScQSPz8qYUAMhmCNRUH4IyFI
	avGA1bCDNhf2YYwgMF/dCWZSqTbiTIlhvbi37x5qAK1qw/SGb2lJeIfQ2UU/ctv84N0b345aPP0
	uegPHWGlAei3DBGR55WUnOC8wyzuCODwwQPdvFy2JMNTJA==
X-Received: by 2002:a5d:5982:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-399739c1524mr3745131f8f.14.1742399363528;
        Wed, 19 Mar 2025 08:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsMp/eW2F9bGGuaianJulHBg1c3Yv2EHA8H/CuPvCIgqbf8LFjRLj6w34OiAUcSOQMBvr5Uw==
X-Received: by 2002:a5d:5982:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-399739c1524mr3745099f8f.14.1742399363032;
        Wed, 19 Mar 2025 08:49:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm22093775e9.39.2025.03.19.08.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:49:22 -0700 (PDT)
Message-ID: <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
Date: Wed, 19 Mar 2025 16:49:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, steffen.klassert@secunet.com
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
 <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 3:35 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> The blamed commit below does not take in account that xfrm
>> can enable GRO over UDP encapsulation without going through
>> setup_udp_tunnel_sock().
>>
>> At deletion time such socket will still go through
>> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
>> trigger the reported warning.
>>
>> We can safely remove such warning, simply performing no action
>> on failed GRO type lookup at deletion time.
>>
>> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
>> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Because XFRM does not call udp_tunnel_update_gro_rcv when enabling its
> UDP GRO offload, from set_xfrm_gro_udp_encap_rcv. But it does call it
> when disabling the offload, as called for all udp sockest from
> udp(v6)_destroy_sock. (Just to verify my understanding.)

Exactly.

> Not calling udp_tunnel_update_gro_rcv on add will have the unintended
> side effect of enabling the static call if one other tunnel is also
> active, breaking UDP GRO for XFRM socket, right?

Ouch, right again. I think we can/should do better.

Given syzkaller has found another splat with no reproducer on the other
UDP GRO change of mine [1] and we are almost at merge window time, I'm
considering reverting entirely such changes and re-submit later
(hopefully fixed). WDYT?

Thanks,

Paolo

[1] https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
I *think* moving:

	if (!up->tunnel_list.pprev)

from udp_tunnel_cleanup_gro() into udp_tunnel_update_gro_lookup(), under
the udp_tunnel_gro_lock spinlock should fix it, but without a repro it's
a bit risky,


