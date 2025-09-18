Return-Path: <netdev+bounces-224283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC4B837C0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D401D16A1FB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0F92F0688;
	Thu, 18 Sep 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWLBBIdj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B02EFDBA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183026; cv=none; b=kG0REUTnroj5H8hOwf2aPvu1g/DoxOeiMID6VkWxyFuP4ceUqJnRmGbc/KpsjCNRo9ywqZnjwB4xU6CtS5MfwMAGGHV4RN/858kUNOrfr3ocCu3qIF25iT778UMLMuvTXNdo48gXpIsE6hJO6FO/cY/m/v4gVxzAVEtIatFdvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183026; c=relaxed/simple;
	bh=ivIZEsXoqTF/6RC+0opLvNAFtOiJGTDP4BJSazhqGSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvMoetJ4TqKrWSztHVc8o2H2LszyFSvgtXVLrtCKVFvyTzjbp9D/dIZhVQQII41NNQ5FYDENsA//uSytYywRrCCoMRWWe2cC8pMHPsGzDgluN3PNY5J6oRXHQ8/CBH783yasoDFTQOowCFAZw1L/DDJhwYzzQqtISDWHNhrPOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWLBBIdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758183024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIK6PrdsNp4wCeKnNrX+jPRHc/pTUR7rE/WtO0oG9eQ=;
	b=aWLBBIdjRVBoUXHr13EcgyUSLLdMerMjbRG4Dv2SoXKj8y78QkSEPIXSlysPcHZJygNycW
	KX1aEKGX4OCFYK6Mwy0M6bstOxPv6BsH0qee0TS2WBi4cY86hMrLAIhd+59VAJHvXJWwIZ
	dZnjnCX6m91cjm3U5c/n9P0QqEqY+3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-s1nxeMHeNjeHZjZtGLC2KA-1; Thu, 18 Sep 2025 04:10:22 -0400
X-MC-Unique: s1nxeMHeNjeHZjZtGLC2KA-1
X-Mimecast-MFC-AGG-ID: s1nxeMHeNjeHZjZtGLC2KA_1758183022
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e40057d90aso319201f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183021; x=1758787821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIK6PrdsNp4wCeKnNrX+jPRHc/pTUR7rE/WtO0oG9eQ=;
        b=iDvJz0zQy3aoQMEHzuo2k5wliw21MqQ99OgrU5w7OhQofBXN7vwLJPMfK4PwGkzWrt
         DYw4HM1lQurJ5YucqtCAwLeUsJbnquF4LRe2DaUn3zh7+zSjOs3FKw+LgUAG4HMr5SJO
         tQC2ffJUSh0pbjF7uJ8Z2I468Uqju/8pyyxix+n/HbTqU5+ffEAMBWTImn2Gjg4D61KZ
         6pQrV3YzZKjgIUZjy8Ao2+PF8wkEOuZmHoCtd0vN/tD5/9dSYmXx3hj9qsr1GDJPTwi1
         CWMGfnzuhS+3Tw0wr/u74Cee1HXxT6Sqx+7bEZ4ojQCou75Dkdm9EsVeiUvQHplatUKY
         b7yw==
X-Forwarded-Encrypted: i=1; AJvYcCUU62CzQHI08KlOwnmJpbDlA7zdpxz++fxAGrbpOXZtEnHC9YxA7g+sXOGG/Ca99/2gQjmtg00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rHaW/B4zgiM7O2lwPbP1OabLZCrvOeUDYuRGz+nRNxk/veHj
	UBgE08g+iqNkPjYWekUuMMyNF7cYoQaBE6hV7tfulvy5Puw1NVKyTZCSIFq4vCvom8GdOyEIMgR
	+98wAXXIiz9yLp5UJzrY+2hM+9KHqlX5zfCjtHRf86FiGGHOGlNsSnHG84g==
X-Gm-Gg: ASbGncvGZfTliiPfHOrp4S8PwKqfhjIswgWAVmOQgF4ZRHdnE2cvJDXgX4OJNw2M2D9
	yYgC6chL78rylS/P5X/CGdjIGwkV8LuP13bYZgY54MqfTXoLDNvYClR8dgT8nAijlNahNaCTO2K
	2/wp9h0SfqFwRSO4C96lOwW0iqIhGxnQfnMovSXPAeR85oZPdW5+ce5kDTWE0QyBISl//HKtmmi
	DB/3KQFVNEwylDYSKLKqZmILcbwP/YlKnp+p9x3DnwBGK6OfUoU1RIicNFbXOoihWRonB0ENa1X
	OmIH8G7Wlko+AGUuh788iXo7aNuQf3A69wOYVwujSLMHx1Oemv19eFk4bsFwK1jgt7lZrSqiJEF
	lyw5FmJdWcioL
X-Received: by 2002:a05:6000:40c9:b0:3e7:451f:3a6e with SMTP id ffacd0b85a97d-3ecdfa44ce8mr4457758f8f.51.1758183021502;
        Thu, 18 Sep 2025 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQmokUFxowAtKuYqHFe28f5t7HKRGU+H7wCLUK/xtNvxaEAZb80ygLNuVNrDWbmZGJZghMQ==
X-Received: by 2002:a05:6000:40c9:b0:3e7:451f:3a6e with SMTP id ffacd0b85a97d-3ecdfa44ce8mr4457718f8f.51.1758183021037;
        Thu, 18 Sep 2025 01:10:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm69364125e9.9.2025.09.18.01.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 01:10:20 -0700 (PDT)
Message-ID: <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
Date: Thu, 18 Sep 2025 10:10:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org,
 ecree.xilinx@gmail.com, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250916144841.4884-5-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 4:48 PM, Richard Gobert wrote:
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. This restriction is unnecessary since
> packets without the don't-fragment bit will be forwarded as-is even
> if they were merged together. The merged packets will be segmented
> into their original forms before being forwarded, either by GSO or
> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
> is set, in which case the IDs can become incrementing, which is also fine.
> 
> Note that IP fragmentation is not an issue here, since packets are
> segmented before being further fragmented. Fragmentation happens the
> same way regardless of whether the packets were first merged together.

I agree with Willem, that an explicit assertion somewhere (in
ip_do_fragmentation?!?) could be useful.

Also I'm not sure that "packets are segmented before being further
fragmented" is always true for the OVS forwarding scenario.

/P


