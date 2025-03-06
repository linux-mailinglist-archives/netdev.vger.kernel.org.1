Return-Path: <netdev+bounces-172530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83528A55319
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB1C188C59A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3419D89B;
	Thu,  6 Mar 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrCE2UKC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087FEC2
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282271; cv=none; b=Jv2LQew8axPgVAJ3lGbBhHL4VOY9umJguidx29HRnhKSrAf6JZzKB0lNSuNeC9mJj6kzsK63T8FcnqpCvPhzEau2OVnPbYZzgCnzewziij/fTsJT/P9Y8MLb0F5zfDxL20jpmC/dO/SxEZ63wmFm/WYRFJD5THPGtuxW3WT4i8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282271; c=relaxed/simple;
	bh=shPMqCaj8RK2eFwUrN72YhJP/BlDe7cPtUkolBvktjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2nIwMzCbBB3AqwwF+2MA1UgwSWAFVfIv0dwn7X8dyBT/2NiFLSSajCqsxMucZXi7C3xRessZ4680l3MHdhfpe1EYTxr30//A9foA2Ud9ks7DYev3g/iMI/Vh9MlXlw6zNDWTFjyh7YtX+RpUIIfvEt9P3jt6goP4nwig+iKYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrCE2UKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741282268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUzND9tY7sAVUN2c6bTcnBh2yWQBn0Es52sgRmYvdnY=;
	b=FrCE2UKCcpeO3HFgBIzqbNNyyerlxjcrNtR+OGamnsWNI1ZhjzwaAKbDpjldb8vMTmKn3Y
	EDj+t3aPHyE5q7inas8JAxTn/hLJXcmAMppOMfXald/uswUxrT5waemnJCg2zz2ZmqRz+k
	/PY1mw2mtunZyx8d6TqtD2mHkJcfHLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-LWjyWgqiP8m_JkbKJ9QclA-1; Thu, 06 Mar 2025 12:31:07 -0500
X-MC-Unique: LWjyWgqiP8m_JkbKJ9QclA-1
X-Mimecast-MFC-AGG-ID: LWjyWgqiP8m_JkbKJ9QclA_1741282266
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bbfc1681eso4008895e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 09:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282266; x=1741887066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUzND9tY7sAVUN2c6bTcnBh2yWQBn0Es52sgRmYvdnY=;
        b=jNSULeIVzyWReoE1M4vrxQvgNGk2qpngM7Y4Kq5FAbj4eHs97evBUxHuyB0ms9un2V
         5IQUYcD9YSBL1rWuwISyRMjkO62VJ0hTt3CCwCsmX6t840hGQwrg5W/Qt2w8/flK0fCE
         a0LZ8tiBQE5z6+sVRAtvFYUvAlG8a1s5h5I3aJvQkVsqkfh0dKFtzhO5zj8hgHYPcDjv
         6+mpjjZGlLvivNCG/U+zSOjacJInkjxFV5Zbb/nLn9UmKg4zoaynAkfvC0+rBb/F4O6a
         MhSjLTJWeXHAhN3QZ0IOBtkwj60DJNI+IQuVM6JEOoKG1hj0YSJZMeuw+60tH7dZD01O
         m6hw==
X-Gm-Message-State: AOJu0YxAiJRTJEmP+it7qiQFZnub9xQWRz5qFRdKTZ+U2g3pXnXHopkb
	e3E8eeSAjP84kZRzRZds4XUNtdoW0HC97xnFP0H//1Ft6Y+kojA6uY2Lu5yC3KSuG2RFAJPK2pW
	viloDg4Qz7JyDm3VUwprtHp0Xzh17SL7RG0b5MIF5oEAly6RCaV66oQ==
X-Gm-Gg: ASbGncsQ4qDeJMFQfMJwL+Do2YGubN/Vvc/fEnmKCTX/tm+bk/ri2gk1zGWRDeVJu2X
	o80e5/wBGLPJNF8sqycIiODZwbshSlUd69yCtQhc14d3X/CCo7v9A7NFHkCcbi5BXNgbeuzJsAf
	ergXW66YH2A795tnCMsfuAY2TlMsyukR7CXut4HW5+HuAWjbJyb0n7ht0lnRFW5L1KY2zYn+kmo
	LWII9pqjc/EMoVLU2KIqR0o9SmyKPqPPMsCa9dFjNhzWaZCAI0379mQy0mrk+OhtkT/h/tgwVfs
	NmLgVH1HJCh2YfRmBl/PZeCjGYUskrodXqnOZGzt0shtJw==
X-Received: by 2002:a05:600c:1c9d:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43c601cfd25mr2713375e9.3.1741282266346;
        Thu, 06 Mar 2025 09:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENot+TgntcvvvXCIOZ192FV4EPTu1f2JLPTD42r7NQnVQOFqGTsFe5C9JQou4U5/L4clMtkg==
X-Received: by 2002:a05:600c:1c9d:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43c601cfd25mr2713105e9.3.1741282266002;
        Thu, 06 Mar 2025 09:31:06 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015d2bsm2621284f8f.43.2025.03.06.09.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:31:04 -0800 (PST)
Message-ID: <025c356f-a77f-4251-a7ae-4f242c70463e@redhat.com>
Date: Thu, 6 Mar 2025 18:31:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>
References: <cover.1741275846.git.pabeni@redhat.com>
 <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
 <CANn89iL3YFsZoOJpe=wp2uNiSvKFNbj8Kbxj11_iwk=8Sh0uuw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iL3YFsZoOJpe=wp2uNiSvKFNbj8Kbxj11_iwk=8Sh0uuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/6/25 5:35 PM, Eric Dumazet wrote:
>>  static int __net_init udp_pernet_init(struct net *net)
>>  {
>> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>> +       int i;
>> +
>> +       /* No tunnel is configured */
>> +       for (i = 0; i < ARRAY_SIZE(net->ipv4.udp_tunnel_gro); ++i) {
>> +               INIT_HLIST_HEAD(&net->ipv4.udp_tunnel_gro[i].list);
>> +               rcu_assign_pointer(net->ipv4.udp_tunnel_gro[1].sk, NULL);
> 
> typo : [i] is what you meant (instead of [1])

Whoops... I guess testing did not discovered that because the pointer is
only touched after a tunnel is initialized. I'll fix in v2.

>> @@ -1824,6 +1825,7 @@ void udpv6_destroy_sock(struct sock *sk)
>>                 }
>>                 if (udp_test_bit(ENCAP_ENABLED, sk)) {
>>                         static_branch_dec(&udpv6_encap_needed_key);
> 
> In ipv4, you removed the static_branch_dec(&udp_encap_needed_key);

I replaced such statement with udp_encap_disable(), which in turn does
the same. Still is a left-over from a previous revision of the patch,
when I intended to do all the cleanup in udp_encap_disable().

In v2 I'll avoid the unneeded ipv4 change.

Thanks for the review,

Paolo


