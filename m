Return-Path: <netdev+bounces-246023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAFFCDCE0E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D533303F295
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515C335BB4;
	Wed, 24 Dec 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Uiov8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E043358A2
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766594612; cv=none; b=Wyqul6QzONY7oTQNGTFtX3hkJGFSGOe97sVre1BRlWLlt0cZ7DyYV2MKnE0pXs+n/GuHJQv2GDNiRqxiZ7aqpRxWkKdWLgtzxIWD19PjikVbbomLs3mOJXrRvWOoe8nGRAi8GYQarXiPRF7/AR372nkTwT6z+OsUycvVvS8sGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766594612; c=relaxed/simple;
	bh=2khFtyxoG8D3pvttVzE9sVaw7e+CdusfWtieJ8Un1NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwnPyWEUS+L8AmDNa3DPoPOkVdvQ9XK3gsfHfnZ/c7HpOQ24AyxiwdTqLTWOEPXjevyglZZxx6mXnz9/kv8VJlMuv0ey29gOZwzL2B4BC6NHQ5sJQHCizjjgv1yMOK4OAGyZNlvQM1Y8VNeUkiG5WlzPLN3UzXnGQScm2zevy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6Uiov8K; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4967792b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766594610; x=1767199410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=F6Uiov8KrV1uXVywgYxGVViWHDKYBlDNCPFGcAghUuc/px803Mg7wNhjFsKRmB8/20
         EiNKkGTMOQ1mVtnXRQREredIrr0309uYby6mwzTkpwzXydrh2+xo0XhwbgbWg5W2c+qQ
         bCJcwsVPh3uLFdHdvb92z6NvT3Hmb8v5htS8yIp6zw9+9GkpEQRBseNGX6tOunQhN54j
         QdXssaPvr21K8fp/YnqpRUxr98qGo8pgqM/QLIEWQ4bDtK9cJx2o1IwHPHhprC/G48in
         cr0MUtFRlFwucKPHW95VEEjVzsDhwfh82i+QCR2fWxK04NalXABOl0KnhpJ2EpbUQpwa
         TTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766594610; x=1767199410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwIk1nvhH1d/vdoQL7AOIOe4muNkhVEYe/P22V7V6vE=;
        b=LUIqN+hcovPTNT0256OQmDJCQ62XhUlvQXKq39Wam7j/+FSuMZBgvclKtXQ6H3vQEQ
         9Ec1xJgh/m+cxg5vPdHMZE5ZJtaLCZuwIJ9J1nRgeknOdJCKKj4L0e0T153jT20o2QIM
         9PFH3k0+nzIdU5WH9B6WUcDmZ5WF7PocpHO79pOx6h1HjgA+QL4v4IfKwXufxsG8GCrE
         HGOzyXbElWQD6KlVIdA7gxhXqLEPBMNYl3NwoIHeA/oypA9cD5CNGxufLDeO7Nd5mo6i
         l/aRuzFNSoJmJKiciX4XOzh6bQuENkKg5TxmKwHeyiHFAS/q9YwE8xjlO8w+Wrqvh2ZF
         yJAA==
X-Gm-Message-State: AOJu0YzcVcbEwW4HHfSp39GfIy3wB3lN6z40av041hN5nrnwkGAoNMQZ
	ZNyVXLi5Z/SUgI2IpoCTGlIhu91CjiE+cRxoHwUD4AEV/VU/18uj5dsC
X-Gm-Gg: AY/fxX7W7dLdN6r44dNSiv1BrW3+AN5Yg4hy3LDlq5i/yEQJZQ61k304JRUigJkQtK0
	k3UU71wHr1Jn49LKhGLiMOxb6BXhqaG8KxzEDDvEDRHa7fPgj0jw+6eTlFzd/gtnYPvgxr6PQJ4
	cSv7jZ5MEQdGb4KC8I6qTn/iYfd3STZFl2yQiEzW4ew/lAsRuZMH7aGocFYZvgOousAswJM5ElJ
	FHu2DpN0YybXGkBXccMWw257gWmXoSQ9X25oFUuulg4armNn4HU7eBVqAiAixE8QjOlo4fj/L4e
	9nOTxZXM7tl1Usu1fOKvZjYCSLomhnlaTizO88eVKFwazqtjdzNvhfYPgUs8QN1c0MSmiK3f2w9
	7F85Xg1f35eOAoZxEtTOKkngAft3M6q7YGjzJrrWqtJxx9MwVgeRsh6Ui33R1SYShfm8T4jEXep
	AuIDAM0HV3mrUXCmvjC+MMRcaaLxD/OsjcpVTZdaZeAO28+UEp0aVt0cz0/Q==
X-Google-Smtp-Source: AGHT+IESvaaiYDz0FQXnk+cOSP0Y3BphqGxvFTMbynES490LRlFZ6uF+ljLMEtDR9jmc0Xu4izDLEA==
X-Received: by 2002:a05:6a20:a107:b0:364:31e:2cb1 with SMTP id adf61e73a8af0-376a7af61c3mr17802942637.17.1766594609908;
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7d3sm19211220a91.4.2025.12.24.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:43:29 -0800 (PST)
Message-ID: <0c94aed3-bef9-4ae8-b9fa-bf2db113eee8@gmail.com>
Date: Wed, 24 Dec 2025 23:43:21 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 07:52, Jason Wang wrote:
> On Tue, Dec 23, 2025 at 11:27 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, the refill work is a global delayed work for all the receive
>> queues. This commit makes the refill work a per receive queue so that we
>> can manage them separately and avoid further mistakes. It also helps the
>> successfully refilled queue avoid the napi_disable in the global delayed
>> refill work like before.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
> I may miss something but I think this patch is sufficient to fix the problem?
>
> Thanks
>

Yes, this fixes the reproducer in virtnet_rx_resume[_all] but the second 
patch also fixes a bug variant in virtnet_open. After the first patch, 
the enable_delayed_refill is still called before napi_enable. However, 
the only possible delayed refill schedule is in virtnet_set_queues and 
it can't happen between that window because during 
virtnet_rx_resume[_all], we still holds the rtnl_lock. So leaving the 
enable_delayed_refill before napi_enable does not cause an issue but it 
feels not correct to me. But moving enable_delayed_refill after 
napi_enable requires the new pending bool in the third patch.

Thanks,
Quang Minh.

