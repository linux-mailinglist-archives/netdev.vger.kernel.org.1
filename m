Return-Path: <netdev+bounces-153301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7439F78FA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BA7168257
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC1221D87;
	Thu, 19 Dec 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHGZhG7M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E6221473
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601876; cv=none; b=fsZyGDcKImbPRW2Av7/7H5aiElV98LyDJXjYSwNQQVhbZoKnVaMpF/1N7ovoKFIlyuRqeoQ3C9cwqFZv9byJxHE/4JjR4x6kwu76aTrI3V7nqXTaY24ERivQadVuvFSyePNX44n4vqNd/47gNd1/l9CYLBA5Qqzm0A5G3ZpYFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601876; c=relaxed/simple;
	bh=MOgjv8NLvbCJVNusxjVzb0ZjyoqeQDJ7L4XoYYYJcQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3xei5zARwSoV7R4Pzk9dkJH0SvvgwOLQqnFfJ7fBTLGDXGdExsjk5eOcKZFDMfMfaRKI+H+Xa60/ZPXpyGGd0Zm3oisTwonqvQxdELYK7knOuTrpfwzLjPajqCPmloIhPS1igTgX+Z0yhYnG9/D6i4q9H1nHfxBNVyuLMe83TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHGZhG7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734601873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wU49+e7tvLItM+Xg1PJft++Z0Ygv+fKtA0Gny+3OZY=;
	b=LHGZhG7MgYE3PEjKi1Onxnkrz7xZ1NgPwbvrZUc3GBNrbrLA34FpYZGl+G6RLC0nMd5RNV
	64JrJQhiuuGenctoh0sZXs1NfrwrSGoXYGK1KIMgk1YXGQY/Vl/hhHZgwDeh2j8CTg/qKQ
	X0GjgST5nalSRr9l3PPeG8JwJNjh9dM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-1H3ziBa2O4C0iuImueO__Q-1; Thu, 19 Dec 2024 04:51:12 -0500
X-MC-Unique: 1H3ziBa2O4C0iuImueO__Q-1
X-Mimecast-MFC-AGG-ID: 1H3ziBa2O4C0iuImueO__Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so3187325e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734601871; x=1735206671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wU49+e7tvLItM+Xg1PJft++Z0Ygv+fKtA0Gny+3OZY=;
        b=DCZLthdvy0z47KyLVW7VvPQlZpcOoheZUXsHaXJQ3Qzs4UoPkL65OARlOYdCS4SPTm
         3eLefzYD357NFAQUfoFNCiuVlxb8I+a5FFpYIW8WN4YLJQpfNhU+P5wUuxoPq7ozqJpn
         lg/qK5DBP53xYc2dATJ547E9uLrVWhPiaOzSNZiPP3luynbqVFHTTTbcgw6qckJT1S3f
         0EW/rkzk/wV6xEPiwYQJZQ77xRrAClIngVvBGZt8UmNvzuF2FLfBcTwsDHC8ozOjpoqm
         IldEiv7hLbY5IpMtLWedqCQ/d1xmIDYXyDkVa88kXksEG86wcmUNZw9ug3DNskEHsT4J
         03yw==
X-Forwarded-Encrypted: i=1; AJvYcCUkxCh26V+mDZUg6IRgcRQIpo767xkuYPLRlbRH4QPmRCuERlYBRU0U5eMyHG76FhfmJ7CHjW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQ7PF6fwC0US7M43/vc+zeMY9kBIQ1NO45LOJcAkFl9A4zJ8G
	keRJ26CqMPIHARz9OWGDiNTjLY13pJ/9uob/6cg+LS1j4KsZ87L7XDvpkLb75Hd9bSE6kyQVZZU
	7MbTmNa+OCSmNeubLAp8IBq5hdy1c3ggG45q7ulx/T/PT7mdlm7YMbq+a7Hj+1A==
X-Gm-Gg: ASbGncv1l2xMpgdLrrCCK2n1B/BvstR9Loqyf2E9PqOysxHIM3LjWpzbUTVf/7aL4a3
	o0vN3UEGSYl98tO7oRTEuPaaVrmhs/AUP7loX6yTv9l525rchQAIKGQgyAxOdiBw2SwikdYlHKw
	La7dd4PHNjRbnDrxWu7Rt3PVTbL9GdWsLfzEYeZd/XkDoKPoTxol9Op49xUX6XaZ//CpkP5+DMQ
	BE5hfiwUaZLZOd/5MRC7JGbIeGiTfzHwlp1MtwUp3Rz5fhduDFf5ugK0ezNa04DqBLoLO+t3WXk
	xdCsGkWICA==
X-Received: by 2002:a05:600c:4508:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-4365535fe12mr47541165e9.11.1734601871252;
        Thu, 19 Dec 2024 01:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiVx3RGR9O17A1hpKQriifFDUtCiFAmeV0v2obPBdwiQMiNihtkWiVxavI2S/flue9uwOtgw==
X-Received: by 2002:a05:600c:4508:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-4365535fe12mr47540895e9.11.1734601870840;
        Thu, 19 Dec 2024 01:51:10 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c66sm48559835e9.5.2024.12.19.01.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 01:51:10 -0800 (PST)
Message-ID: <f661b60c-c271-4778-b6c2-c4c9a6e68fc5@redhat.com>
Date: Thu, 19 Dec 2024 10:51:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2 net 6/7] net: hns3: fixed hclge_fetch_pf_reg
 accesses bar space out of bounds issue
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, shenjian15@huawei.com,
 wangpeiyang1@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-7-shaojijie@huawei.com>
 <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 10:29, Michal Swiatkowski wrote:
>> @@ -533,10 +533,11 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
>>  	reg_num = ARRAY_SIZE(ring_reg_addr_list);
>>  	for (j = 0; j < kinfo->num_tqps; j++) {
> You can define struct hnae3_queue *tqp here to limit the scope
> (same in VF case).

@Michal, please let me refer to prior feedback from Jakub:

https://lore.kernel.org/netdev/20241028163554.7dddff8b@kernel.org/

I also agree subjective stylistic feedback should be avoided unless the
style issue is really gross - in such a case the feedback should not be
subjective, so the original guidance still applies ;)

Thanks,

Paolo


