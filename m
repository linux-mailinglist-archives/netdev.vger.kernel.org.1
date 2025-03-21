Return-Path: <netdev+bounces-176788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB3A6C238
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B1F3B3052
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10522D4C0;
	Fri, 21 Mar 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwDjxEiW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B161E7C25
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581102; cv=none; b=dzmHlllN1W0VuqrtifpPldiocZfZeItgVFSCpFVM++tHZ5cib7XHuzdMrAgQwR9xz5/iTXiOun4FYe4f0hCeDa/9MKv1PwwgbCw/1kzXIPhUdZLZ/cUb002hQxE8x6kKLjAunsGuatFr+huByLR0wpMeyIdEdn+I43cWOfaNcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581102; c=relaxed/simple;
	bh=vOHWoxiw2xdMs3GmEHCxHidgceg+4sXbAb8ZxPba/Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thNkKMp55qclNEaFyXqyUt9Tc733xTndf/l452NP7pj4i2C1uxVDDQGgNkx7PDuUb2pWDq1n98FlKfPkXPPqgc62H6mtkE35oFgDL9z3taG/IlvIOf4uB7uBtjMhkmIOlzUqI2gRual6UxAUritIhW0y7RiQgY753SJu7z8KQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwDjxEiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRqBZ0OkMQP4BzSiooVfIumzyiQnM11f1AZ/zH2IWSk=;
	b=MwDjxEiWgSNCqW7Ka+LWh3iVQrcNjYxlz3zROsyv6YAJKFX/0L53Zk1Nv6obO61cZ7czXo
	UK/aJ7TBfm/mD9QFiq0k40+n/uQcAujYj8105FQ/R/VAcVavFPtq86cWsGn/64NbI1pKk9
	7AqdHvxsNT0Opldt2S/8cullj6qvf+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-gQ8wvRy5PguSC3B9lHnYDg-1; Fri, 21 Mar 2025 14:18:18 -0400
X-MC-Unique: gQ8wvRy5PguSC3B9lHnYDg-1
X-Mimecast-MFC-AGG-ID: gQ8wvRy5PguSC3B9lHnYDg_1742581097
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so11046485e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581097; x=1743185897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRqBZ0OkMQP4BzSiooVfIumzyiQnM11f1AZ/zH2IWSk=;
        b=ZabhcIaXI70OpmptFW4P5sDAVKy38X/6j4GwCqyx4gqaAIKMpZ/PNUV3dMMP/oOas1
         tBZpMF/p9QSEzrwlfx1u3ja3CMA6Xr5/zGQ4ALls62O31m1u77fJBHK3y9dAAczLGuAK
         yQVrphBLx4dzes2K3UnhKm7UtanPzFCqG3uK8UJfULJG+s9+0uAaLZ5WNNLADT9l1dg9
         y+m2qI/FV8TVRii/9IuOJcL8LYBF+mrlt/lQ/0BZ21RMpl3zZEm51YNWa/cgMFoPBCCj
         Z+4jN9IS0eDgVzJ+KFQfcy9oGt6yQwzX0OOIGB6al+OIX3/BdLQGQmjC9wzoRJ7NQZoy
         r/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW+gjrhWOxfIaw1+6c057/DMzEGSXmh60IFZ0cAJzdrQsmMByEtuctvBqI30lu//01JIQ1rtYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszJLFNpb8ElOO1W2sOlFunPvcR5cMTvlAWAKUgUhrOt0qiIfG
	g64dAxK4sM/p/nno4kBC3XaIiyip7TT8suCWqulCzHNm/3ZH/OPYId9L0hVWtAeVGnMVFLW9/tn
	1H/xzCE2txPU/zhGgKGXU9w7rIKlsRnLLgdugs5YVPiLInEalRJKi+A==
X-Gm-Gg: ASbGncuk3lbELkHpFF5HITRvCpi2mlfeQ8mWIARV6XBCd9utXiDNHut2Q47tNAXinUD
	Q37WXxPDoEz9vbnJvSfMSSsX3rFJLHP+he3tNZj1JjpD6FW4qcDze7Fwa6pWsz2GfSN8+DbrUW2
	ZRqD5qSk4HQgtU3lK8rxTf7j1WE9vznzjserO9So/dcpKP7Q9g3/lud2ckfeh71Cqr1id4KwIZ+
	2mIidknL711JCLj7cFc11ZaDn1g5LDLV0ZEEI7Z3Z90E+E9gHo5T79PjU0w2vKaCl+35VZKBpps
	5k8VhH0NIbYiLh3W+HDsswUpajFtLsWngJ/mv3KqiggpTw==
X-Received: by 2002:a05:600c:5488:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-43d50a31981mr32999205e9.21.1742581096863;
        Fri, 21 Mar 2025 11:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4hjspn7nFbirV1vOF+PWolmKka8uULS32ZeHXEmfN9pXrlTOZAy5VVuhKwl33XEm7itFSrQ==
X-Received: by 2002:a05:600c:5488:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-43d50a31981mr32999005e9.21.1742581096493;
        Fri, 21 Mar 2025 11:18:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f3328bsm84371215e9.1.2025.03.21.11.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 11:18:16 -0700 (PDT)
Message-ID: <2d39033d-0303-48d0-98d3-49d63fba5563@redhat.com>
Date: Fri, 21 Mar 2025 19:18:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>
 <b647d3c2-171e-43ea-9329-ea37093f5dec@lunn.ch> <Z9WV4mNwG04JRbZg@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9WV4mNwG04JRbZg@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/25 3:59 PM, Lorenzo Bianconi wrote:
>>> Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
>>> routine.
>>
>> A more interesting question is, why do you see an invalid port? Is the
>> hardware broken? Something not correctly configured? Are you just
>> papering over the crack?
>>
>>> -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
>>> +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
>>> +					struct airoha_foe_entry *hwe,
>>>  					struct net_device *dev, int type,
>>>  					struct airoha_flow_data *data,
>>>  					int l4proto)
>>> @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
>>>  	if (dev) {
>>>  		struct airoha_gdm_port *port = netdev_priv(dev);
>>
>> If port is invalid, is dev also invalid? And if dev is invalid, could
>> dereferencing it to get priv cause an opps?
> 
> I do not think this is a hw problem. Running bidirectional high load traffic,
> I got the sporadic crash reported above. In particular, netfilter runs
> airoha_ppe_flow_offload_replace() providing the egress net_device pointer used
> in airoha_ppe_foe_entry_prepare(). Debugging with gdb, I discovered the system
> crashes dereferencing port pointer in airoha_ppe_foe_entry_prepare() (even if
> dev pointer is not NULL). Adding this sanity check makes the system stable.
> Please note a similar check is available even in mtk driver [0].

I agree with Andrew, you need a better understanding of the root cause.
This really looks like papering over some deeper issue.

AFAICS 'dev' is fetched from the airoha driver itself a few lines
before. Possibly you should double check that code.

Thanks,

Paolo


