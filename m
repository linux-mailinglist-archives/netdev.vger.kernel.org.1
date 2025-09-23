Return-Path: <netdev+bounces-225666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC60B96AF8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BB34A0573
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5A270EBB;
	Tue, 23 Sep 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gIbNOtGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CD25CC74
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643135; cv=none; b=oQdpjCJl3mXpH+BSChF/vhZYwxpQ/jGsePZtMWdKIZuXg/XeaRecPPn/GwB7sJqhi5T/Zr+IXBa+9XvjRyabgRh1ThOQluSPibHhKifkoS5usxEJpIf4OMnQNToEW9j72NNAnnXJ3fratduSKBRokeFGyr7vkpSe1EMuTYJitbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643135; c=relaxed/simple;
	bh=gcdrUkEE7k8h3bL5EJjiXIehhukiVZtEsgd/zcv4Nxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu4vgUIfYq9kc7ugID97n2LSXlTYJ9BcneY1c4MtEinrzqLf0QHooyMyAvSLZT7TFQH3oxdba28ZNxCAXT+IlhUFoiMQFKd6cjvBeZrMsiP8gZrAJWTA37FAp14xH9ew3darrmZCeOtQcLZxLTb1dK0wpRhSJ6LIzPZzq/l8WTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gIbNOtGm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f41086c11so2072362b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643133; x=1759247933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNQhOf7kY2F8TCqI/O1nW/ycDnR2r4OrVFQr57e8EJs=;
        b=gIbNOtGmomRbmruZM7FVk9qYoSl0f0mfBchtP00Tp9jy9Mi9YU31pbUtQrzOcMstcI
         J0wTBdNOKzYe318cAUgEsbx2sgIh6pDfpNmh7INPq42fK0gS9WT+zLBlJMkbTA9qamg1
         O9bBvAHqgLC4r8GBT9wJRS2G+ol/1SqhyxQU8p/lhucNcqXxg+1occo+YX4l+3ZSRN1K
         kf1FoCmsoFGwpUHNHWI3n5UhAESIrobgj4D0CuMZz75uIeUmi8og+Wo5aPctmZjTY3i9
         zv/k3SyOFgG9LugN2opdCWJDsFypOfzM7mCUZbe2Iv1DjkluJF057v4D9vpFAmeKJ07a
         2tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643133; x=1759247933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNQhOf7kY2F8TCqI/O1nW/ycDnR2r4OrVFQr57e8EJs=;
        b=PXV97PuN3kFSgBZ7vhjLqOG/j1A/glpFgQOTRdtwVybwqiokxWHpmfopxw0lYf2X3T
         iWkJBVYus+iinDBgSTO4pIwiqqHOcaSSP+QXRDEr7gwRkhURnA/hSgq4sbsgKguNLnzU
         v1j4ooGKOyBBEH3q1tAaVcbbMIuEL/cVYB1qPwijag/KQ2QSIPK4Dlc9DLR3kM8pae9D
         FASm8nBLtFOy2wf9ffK08Eb1LQNP4qOEKbjQywsttqX/4Nvd4W0vW/tHHn+jWKJnhFsv
         /1k+abQ4rPwr5ArwuGYnRDbvTR5Gs2UDRMHSRjCbrEsCRu1iOkewsfTVxvizsg1jG3Vp
         /uOw==
X-Gm-Message-State: AOJu0YzsgMM3/R/5oxFWAkT+1OSBMamcdJQHsYhsLr7XFbAqOPUUZf7E
	r2eSVzBFA8cMDv0CmY3z85ji/1Sa5XIVKdFjYNN+6MIEfQeNKqSEAd9fuWYTDv6nSeLTITYyewE
	OLaghtKA=
X-Gm-Gg: ASbGncuFVAy/maLa9m1AeiB+5QSWgcKrEK+E40NSRzZnONKC+3gFBF2YZERq1qsvL6N
	mw4AG9jOCPwICB4REnumonHsjhG/MQKHal44t5OwoWNV0XpfE0P/XEAQ2Wk+p4U2QpUe4MNILfM
	AU8TdZzPVqr2awUWZGlOJu4qtK9eXR1Edf9KTEbTr9rie6RCJedis5N81fuBTGiYHdCSAhGk7Xl
	1NmyVJY3DnK0cfudZgOh+MDVoC85xIoUa7KmVe9qAWzc3KvguxvmltUNvLyTc+AfN9SJZwBT6YS
	IwfL/UPaeyItGFcmOanObpXANl5wKdugW2XWp9t9fuuBA0LdxRGE4oT3OgUNbw90H6bM8AOljRu
	UnUBpI81qPGDGCyP42ABtSaWJBM4zYpPt67z+QZAVevdcUOdOba166SCDbZI=
X-Google-Smtp-Source: AGHT+IHaWWQsxNkqF1/Ox1XypUQNX2Lmei4T4nsZ50MiDDU2VB8sz/+STs+7VGJfCSePr8jpdwU4wQ==
X-Received: by 2002:a05:6a00:8c2:b0:77f:33c5:e271 with SMTP id d2e1a72fcca58-77f53ba52bdmr4279406b3a.32.1758643133009;
        Tue, 23 Sep 2025 08:58:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f188dd4a8sm10312819b3a.39.2025.09.23.08.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:58:52 -0700 (PDT)
Message-ID: <a3c19679-a229-49ab-97b0-8a702b714bbc@davidwei.uk>
Date: Tue, 23 Sep 2025 08:58:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net>
 <20250922182231.197635c1@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182231.197635c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:22, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:36 +0200 Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
>> rxq specifically for mapping to a real rxq. The intent is for only
>> virtual netdevs i.e. netkit and veth to implement this ndo. This will
>> be called from ynl netdev fam bind-queue op to atomically create a
>> mapped rxq and bind it to a real rxq.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/netdev_queues.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index cd00e0406cf4..6b0d2416728d 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h
>> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>>   						  int idx);
>>   	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>>   							 int idx);
>> +	int			(*ndo_queue_create)(struct net_device *dev);
>>   };
>>   
>>   bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> 
> This patch is meaningless, please squash it into something that matters.

(Y)

