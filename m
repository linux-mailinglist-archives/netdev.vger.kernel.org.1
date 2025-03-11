Return-Path: <netdev+bounces-173884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24FA5C19D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D5167B6E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A90220696;
	Tue, 11 Mar 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBNJavfw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95961D514E
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697259; cv=none; b=aS8/IWHnwjcDMhLQ1aYl+dLdqgEJLX+GQTI5v1FI+uweIVV8fBcxmdEWIZVW3qr0ovDNc0rGTryXRkWho6o4oqSVJ/7b/xtg2PBGiIAtEZdC6Zu31MCAa15ufkGvc9kRFi6lUZkKeygNXf3MjVR2R+UMAnk5HBvsyttYpga34pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697259; c=relaxed/simple;
	bh=W52BAZ67rt5tCR+ptxJg0EnP1F1YOu8kYIPl/ayZA7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+tORmf6/EEhMYngUzv6ifzsxIguocPNYrzE1psGTCeWBBlC7a08D0vCfyEF0e8COSISDSLc2MxKZuGPyO1nLgRY0BRL2XBK4dpyZpXi0UCfg6cgBjyXihPOTR1PeCLvvLfuJC2/RIEnQulksWwK6/oPNYGTdCT4hfgh/vaVRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBNJavfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741697256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWt93kEX2XgtTJqbA1fUNvNcsGBAeNh7jPNzgFkGhWU=;
	b=eBNJavfwz3nj5ElUfJ1UxusDqpiTA0YgfY/Z5W0EgKuGIFHToMiySF4BYHBvyoVpSyZuy8
	huCC3adnopLCPE8Awk2z79BYsKnUiSb4bxV/rtG1H81hWNeTFkGisls85PPMBO57OHk3XY
	YYPlfo2pr/J1O4iR65ftdB9fdbkFm8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JGJewReNMoWXjBP70f__PA-1; Tue, 11 Mar 2025 08:47:35 -0400
X-MC-Unique: JGJewReNMoWXjBP70f__PA-1
X-Mimecast-MFC-AGG-ID: JGJewReNMoWXjBP70f__PA_1741697254
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3933ab5b1d5so375308f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741697254; x=1742302054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWt93kEX2XgtTJqbA1fUNvNcsGBAeNh7jPNzgFkGhWU=;
        b=STA82slxQR0ewp3mPHy8/C1ipWVjG/skzCWH0MqCWBnMYg22wvtIkrsDBX4jnI3mbp
         dc2Jm7N5A810dEFfwOoZdkqCtPi7V4m0TKK+lXEHpd1JbCQQQx8FVb/4piboO+jjlil5
         RHH3FwDFIcOYeFN7LW6slUof9+k3dpR4QqAvTmBmBbZyddHk1zTFM3sIBEcqrbRftlMA
         L4h9/YxrAMe8PnbCkUknULcuouvbN1+sZVACxnROXUoRDEv4HofYFq4sQnuCOqJCs0nm
         OeKupDXhH8p0aZjxKek4gmzja5e+jdvDkgnmJi5ciP3w8ecoCLc5G9vxGMGkXaVUDuvV
         k2yg==
X-Gm-Message-State: AOJu0YwlEXztplC3aptXAF/yK1tRJoqbxCL2xcA7+Wng/4JJQyfm77gW
	XqrVMGB8Ck4A+T1eQ2H4rvxkzzz2SR2sPSn3LWV+8dT8iH+XMz83zh6jZMRmBwR5Xw7fvl7Y0zw
	+52j3lIQRW5btYB7KW9fYKQ19vWAFPatgd5WFcTv3huNsk/vYwQh+mrm7Z9gewA==
X-Gm-Gg: ASbGncs4dgl7sEhPjV8Xxi+Uj+kryjv/qT1zq5b/tq9NbMqt1sMPjPH0zvkxLZZgPx9
	7XdxPG+ZW8HD0ozyuiQgbi4xt5JPp6CMxi6+baL7giWn4QXU+PmnjmHK5nh9yUE3NjVK1sWvWBT
	BWFzF+iRh7ND4N5FqhrSEk98nvSFa1qec8EoO+aaWHpxZLF0Vqgl4MiiLtArik4Tzm6+VDrZjCr
	WNYrxQNK998sUh6QraZn8/G7/meK7PVLViskvNk85M8S0Nd/YIE3XMebgAA0Wm4ER+hgVmtQQTu
	Ks3t+Try7mUEZ/SXiwXqDIt8ebl2VlZ6uOZ90//7IQ9pZA==
X-Received: by 2002:a05:6000:1867:b0:390:f9f9:3e9c with SMTP id ffacd0b85a97d-39132d7a804mr13929383f8f.25.1741697253915;
        Tue, 11 Mar 2025 05:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHakZdu2nSYhBEYNqrpDmBkDduynwCPB+/0EF5Mz//hrthKdpdMvd6Dy1qv/FcN3sNK1fpIcw==
X-Received: by 2002:a05:6000:1867:b0:390:f9f9:3e9c with SMTP id ffacd0b85a97d-39132d7a804mr13929361f8f.25.1741697253577;
        Tue, 11 Mar 2025 05:47:33 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb799fsm17981000f8f.2.2025.03.11.05.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 05:47:33 -0700 (PDT)
Message-ID: <17414eab-445d-4669-89a9-855a872f7c16@redhat.com>
Date: Tue, 11 Mar 2025 13:47:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 1/2] net_sched: Prevent creation of classes with
 TC_H_ROOT
To: Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 mincho@theori.io
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
 <20250306232355.93864-2-xiyou.wangcong@gmail.com>
 <20250311104835.GJ4159220@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311104835.GJ4159220@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/25 11:48 AM, Simon Horman wrote:
> On Thu, Mar 06, 2025 at 03:23:54PM -0800, Cong Wang wrote:
>> The function qdisc_tree_reduce_backlog() uses TC_H_ROOT as a termination
>> condition when traversing up the qdisc tree to update parent backlog
>> counters. However, if a class is created with classid TC_H_ROOT, the
>> traversal terminates prematurely at this class instead of reaching the
>> actual root qdisc, causing parent statistics to be incorrectly maintained.
>> In case of DRR, this could lead to a crash as reported by Mingi Cho.
>>
>> Prevent the creation of any Qdisc class with classid TC_H_ROOT
>> (0xFFFFFFFF) across all qdisc types, as suggested by Jamal.
>>
>> Reported-by: Mingi Cho <mincho@theori.io>
>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> Hi Cong,
> 
> This change looks good to me.
> But could we get a fixes tag?`
> 
> ...

Should be:

Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix
qdisc_tree_decrease_qlen() loop")

right?

/P


