Return-Path: <netdev+bounces-112559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FDA939F56
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845E5B22286
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137A14F130;
	Tue, 23 Jul 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjvanq9E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CB14D6E7
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732740; cv=none; b=jciZzB21Tx/Vv2OZZHXkQFA/YMZowUDHs61byTK9r6SfIhTYGvoG0mjAt2ywhpWFJeYcaPY0L9ZzsD5NdtoJf9/d5geUXxpb6LEu2bnOiWlpJnAlbZ3jf5ILeU2hEp7b3qc6U/rrHkhUs8rCrp1Zj9x67Ve/wjZW84xOvdeWUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732740; c=relaxed/simple;
	bh=7XXeSul7UB9LBGW7UFEWmEvnnhBGYXJidgRwX+irI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZdmTGSQx3Dlt3t5liNdJyP0NcUFYk2/MJ+lyYtVZuSCAMWxjp3VWXWtkVY17rI4qwrCyB9es7YmnYeJNFbfeTTtQ6/YV0omv9wOaSPZGhtvsdOjzS1ezb4qERmcK5GnfvziDShQzpviDbfDj/n9JlyH6rv2n+sU2LeOj0e6D2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjvanq9E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721732737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3j4jPgv6Hs0fzu6rXE2M7orTiihZ3jZ0T7426KJgLA=;
	b=Rjvanq9EvszONB8ofF9OXh4j9hyob7/i6tfVK4Dixd6rKiNbvvkra2fgOBLvF/HG4gv02w
	gy9UXQxArMcIs6wamwx3iyO5VupjMeRinqo5d0l7SdhklvVXUkC9QN/czxYN+nBVJHuA8L
	C9GZFNX3tG0rs46qOCZL54+6opVnamM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-4boR_E14MsO2v5VFe7KrGg-1; Tue, 23 Jul 2024 07:05:36 -0400
X-MC-Unique: 4boR_E14MsO2v5VFe7KrGg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42669213f26so3382215e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 04:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732734; x=1722337534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3j4jPgv6Hs0fzu6rXE2M7orTiihZ3jZ0T7426KJgLA=;
        b=ZRtopK/ysMRaGGT4db7evi0ZsNP4MdI1YR3uwBbl4du1jaD8MR7FyylZOq4obm9xzv
         vBbvCsm71TCydSMHd7A57ItjH81930xBiPqlcV8dWuga/BN3eVZInWHADKBLAV7NwZ9i
         zKNF3SL9rFjJAqi2VfCVDm4xj2qFYycTT3+ftUdWwuG1DxuRvhV7ecqfE+qVHLFRqfHD
         2jKdLnGLTGDS7tsRL20IOaYll3K88WmzJHHj1MIsAhmI7obvx0p+LlOmzt61BZCyAEh/
         iXLARbO2VPQlr85/bdzVIE7i/2U/mjZ9KN7OYjm5vBxm98d0g7cwl1fZCji6sdGHb9+V
         mqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX2M7juEih/Lw1/Ot4aj44Qr1V/wfFQ+SNi9Ka1GeGAR+pAdaIg3nmKLALAlkLBOUb/Ym9MBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzikwhMcaTFkJ/E3ZoawVP2pWfpK9W3Mk3bIrDYeWjnNwckzPWw
	iCy/n2cfMmIVCGu1CW0zpGawZu1SvgfC+1s0MaYki0yrEeN9XG7qyhnaWL0bQ7cjvad5DjWFzCS
	YRC9WtwDajVudnv5h7uhcvs8Ws8mxAvTOHLrE+DQX/6qMbw9DrmTLTzu1M6+J3w==
X-Received: by 2002:a05:600c:3c97:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-427da9ad357mr45399625e9.0.1721732734661;
        Tue, 23 Jul 2024 04:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWCl8LDKZyp3574p+r9uVIoAK1epDaa1iQUNezXTrhZGqQRyRF8Ml82x3u3sW7wHj6udkMg==
X-Received: by 2002:a05:600c:3c97:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-427da9ad357mr45399415e9.0.1721732734229;
        Tue, 23 Jul 2024 04:05:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6fd5fsm194076715e9.22.2024.07.23.04.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:05:33 -0700 (PDT)
Message-ID: <0f2ef152-0fbf-492f-a334-89bb700721a2@redhat.com>
Date: Tue, 23 Jul 2024 13:05:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wangxun: use net_prefetch to simplify logic
To: Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Duanqiang Wen <duanqiangwen@net-swift.com>
References: <20240722190815.402355-1-jdamato@fastly.com>
 <20240723072618.GA6652@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240723072618.GA6652@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 09:26, Simon Horman wrote:
> On Mon, Jul 22, 2024 at 07:08:13PM +0000, Joe Damato wrote:
>> Use net_prefetch to remove #ifdef and simplify prefetch logic. This
>> follows the pattern introduced in a previous commit f468f21b7af0 ("net:
>> Take common prefetch code structure into a function"), which replaced
>> the same logic in all existing drivers at that time.
>>
>> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Hi Joe,
> 
> I would lean more towards this being a clean-up than a fix
> (for net-next when it reopens, without a Fixes tag).

Same feeling here, please repost for net-next after the merge window.

Thanks!

Paolo


