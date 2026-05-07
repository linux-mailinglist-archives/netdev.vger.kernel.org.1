Return-Path: <netdev+bounces-285229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEBkKcxp/Gn0PgAAu9opvQ
	(envelope-from <netdev+bounces-285229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A74E6CD1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18DA300EA8F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFE3E8C71;
	Thu,  7 May 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i48YEuXJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="caiEYbQh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAB3E9280
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149830; cv=none; b=gfRgHtdiy30zUJS5KC3HVuPfTfDaX6sN+zJGyxc3X+WXGm/rFPqrURd9Op0wvsuPyhljFYQKmIKg777wbiUHdgh9V7dM8fRZXZDSBDJ5D2KTZhUB/J9CUzaYItibJLDyVygWhaQS3hn4DWW97molavAwx+Z2QRtBs2myJtsJfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149830; c=relaxed/simple;
	bh=8KJvoWVaTAXL1jHbNmZcZDdZ1wGhBJeDmvT28bWqJOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY8QsiIlK1WtLcdzoHiwVueM+fY+raWd9UdA4+q/l7PdpjBcvxjWBzT0+0yFTWo469IhFQV2Wx4FFf+qRPhaaqrW6MMkmfg3tHIhhfy/fIlphKkYnrq+sETVHytTov+LFggaJb4PjSOcuy6CCVoUDiLvKNugwGSYeVRVYg7nOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i48YEuXJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=caiEYbQh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778149825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f31ImB+LjEleID9ftmO48DVwJX81TOASIqUpMHAe4zk=;
	b=i48YEuXJN3j2pv/jycOJgSIcU4jr7hBPGvDfMlAFUEPCeSXrqKqhI4LJiEfmqWIvGabyut
	Xrtq/ENiAW2i+zrvlRUIJoMBogklwYJxYiLddYqUfLZ69K5QPao0Rfo3Jt7LCC2q7eO2Rp
	0PwoV3krnVZ3tLQktSe2zQwu+Ydbfxg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73--bNSFuBTP5WCntvFlYukJA-1; Thu, 07 May 2026 06:30:24 -0400
X-MC-Unique: -bNSFuBTP5WCntvFlYukJA-1
X-Mimecast-MFC-AGG-ID: -bNSFuBTP5WCntvFlYukJA_1778149823
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5eecd0aaso3348875e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778149823; x=1778754623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f31ImB+LjEleID9ftmO48DVwJX81TOASIqUpMHAe4zk=;
        b=caiEYbQhLqUxzxWUuONmeyudo1NI8D7F/6nMDAaWeVm4A9TDtbY9vocuPBV5iWsutP
         98fQz1Jwq/JruoL2eiPyZHJ+zrRLXXYdByUkYPA4J3ubl1pIBTn3JDyA5u+79q+Qxb9y
         ENp4hjQ6c5Y9qFd8v3ActpytDs8iF1aRgpOWo94sUrQLSULWsReYtFRb5enJJIaZVwnS
         4dbcZpVRPtRCzdDbXqKMhO+7xNs7KRLHMglQ6ipNcOxaGaEXuLJ4MuQqVY+0Nk9G0a8q
         63REZQaIlEH0wz7IfY3HRHJpmW3deYZPzpxbuA04U9ix9cnZ4tSilxf37a5MytyCwHIz
         c+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778149823; x=1778754623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f31ImB+LjEleID9ftmO48DVwJX81TOASIqUpMHAe4zk=;
        b=EsO5wnUTSMKBGJMXULrWoh149cMdfgPAvk7Cz6MVbE9NGyL+Fb3d3h0RAYAurgnH+1
         gFbKCn1N8ydbQOEnOz8OnYZKk3hwMRjzop84w9AQUIvZr+Oi4W42UHpOn9cwoVs2rois
         JZlGKKg1xZtBJZVxGIB88KI3CoZtNCVGHqT9n5e78DrDs3M2Hn/GIhT8u8BTpFgOnwra
         tfCKQuUVQBhPqViL32mUTnA+LbeN2fStsh2G1hOJM0+ISXJ67UWPajU0FlIy9MTtijBQ
         4rjBQhA3fvrjYy9R+64MKeBnecuSspu37fnvYVFWNUycS7+n6RuxuofiJ/ZJxB2AgLZL
         mGyA==
X-Forwarded-Encrypted: i=1; AFNElJ8dFFfjtg+5P8sZzllIrBPBqyBIFxEuu+Ob6ktebUo3zrW7JeqwDaqsvjkySeezXimalVF2gfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsefVUdzqH5F/bzj7u2AM1HyV4P2cZDI0OcQqIi/63+oHf/5R
	t/KYmUiG/y1PY5AFfS3y5J7zBKmvvbfVK3+99wl9mpYr/Uwgx5x9zW0Ojy6lndYcJMTqWlDdUPw
	Ew18tnkVtng2ureWlklMP31jdP30rTDQ5gQePPLJvtZ+dqMWAtzf/qloeaA==
X-Gm-Gg: AeBDievrQw+k5PR7+inEU6EqLOvznRtZGGHTi6q9l4X0cj1ay/T1jbfOPpe07CVGmyr
	s7JBAIx8YjdfkVyTLsC0+M7q9J6pC+wijssHaWBvO6ZZYpw6hD596TqY99VXLUnvhLvOj8b5bya
	VlvAJH3NrxXG8nLihfURLT/vc3TK8z8IBWgKLo/56KMBvlxsezN8oq1fg4jpRAV7Zl72eFSeUWK
	HljxI0UpvF+fGHm8+TlaBybnrX7PNO9paAcVSWMBJ/75T4EKqyov+GGHI5ti8TC3Kte7AekJ9J8
	GwZ4WC2tl68U4orvPIQG88e7/3OFTiK/XJia7fqPprZYf/Q9QU1OqBadf0V1cN6A2ZBoSArvSls
	8jzW70MEi7oRYob2WDgtqABR6ZK1P/4IahJfgGwhc5KBEe135jya4/FoVg6b/NkLztyxZ1byUoR
	Gi
X-Received: by 2002:a05:600c:c094:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e51f40a29mr90236995e9.23.1778149822944;
        Thu, 07 May 2026 03:30:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c094:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e51f40a29mr90236345e9.23.1778149822188;
        Thu, 07 May 2026 03:30:22 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm123375505e9.4.2026.05.07.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 03:30:21 -0700 (PDT)
Message-ID: <1c5a2912-6d24-4709-b3da-9a58f0731e9f@redhat.com>
Date: Thu, 7 May 2026 12:30:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v42 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260504144439.29570-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260504144439.29570-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2D7A74E6CD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	TAGGED_FROM(0.00)[bounces-285229-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/4/26 4:44 PM, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.

I forwarded you the comments from nipa-sashiko. There are more on
gemini, even a good deal of them looks invalid. For future revisions, it
would help moving this series forward to triage such comments,
explicitly marking the invalid ones.

Thanks,

Paolo


