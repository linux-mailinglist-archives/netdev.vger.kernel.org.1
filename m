Return-Path: <netdev+bounces-86605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BC89F93D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE92B31665
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAAE178CD7;
	Wed, 10 Apr 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8WatoTn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E516F0C8
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756700; cv=none; b=AbLSa+RE9TfjotSvA9YMfy9p+kortJjBg6Y+QkxZfobBHjlMDbQeAYXFjsReDgD3N+ZTF/HE1aehxHzMjipf+B7zf2qmq1DzlOEpYbw2WiKMDItqeMYRRWvjVY/0WlUIfW3MD7rDQRX5IyhWPyTWIUXrMuzrH8FzhBu5FO/St0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756700; c=relaxed/simple;
	bh=EAsyLgaappxVCZGobyQ5YHcbJ/wGsUmTMmjzR+qJakA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb5nXhGB9nhmGD3bWAzIe1Qsl20QTsLotSAOM/11QdWJ/P59TW5O/pFQGilbxnB0JIOUutLKOS1sMxXFhj2eRZcaoY6iugkFm8J+Fg6K6+2USvnRNn2k5n8CuyVUMm5iwoFuXqhy3MfkdYzGneqYB5y8SZSa3li/jxJ8noCE6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8WatoTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMVEOECJX8R6kuajY0/sKhEV8hB0coW09DS561E0Mxw=;
	b=a8WatoTnvi1JkTr/wjsd5GuGPtoza8upRZxjHTb9HlkR4IK2K9QiT9Vj5j4Krjjj+HzQjb
	BZjGyXBoMxRCzZpaYwiA/nkqoyzzzp4vYiwl1aTM8yAPUL0suqT0VpbN//GJqKaLn6+f5B
	PSQmmSPoIA8gLQc3qabqmmFPMPseGz0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-sWf-jxPTPNOW9jMMfpGMwA-1; Wed, 10 Apr 2024 09:44:55 -0400
X-MC-Unique: sWf-jxPTPNOW9jMMfpGMwA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7e7af908001so253023241.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756694; x=1713361494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMVEOECJX8R6kuajY0/sKhEV8hB0coW09DS561E0Mxw=;
        b=Qd68viAvGhxBnxDjOqqR5Na3lkm+ICCG5Lua6qXlwcVJb7KPZIZP9tSDouxYXEajtD
         SeX410dZR5pgfjqdzRUJmem+O9eBTJfGTXKKeVjpd0hX8cJgx30C6v89Ov1ryopwz/Vk
         HnfGxkLOnGleXswnoZ4zgVQQmnHDNOBhVhgCNf+2StGpnYW/nQDWTfprNDltUEisfZ4V
         uPZqlZSg/FT4kmbRkfd2HVuC+ICaUAPOe8gU+A5pBX9Wwakp802BXMG99tIq4gnY6CP0
         YLlzbwnRV4EiORxwCLjWZUKe6r8CHNCc5m24RZqCd+xqeIJokKjgqWKV4kefBISavVZ7
         8YBw==
X-Gm-Message-State: AOJu0YyYMDN+7zJO8xHet5dxRLuF9FeAVh8l53F8jZ3J7wWaXvfMNFqd
	OZ9ciMhxLmsH2rcjMMELe5bE+VYuJ1L6Tv46sIDy/m6wWtOtF1nj/00bx5pZuLrxx54Qa8dh8J6
	75G5dnPwJtbluaMHwlyvGelSjX93qhrN1hEqbE5mqqYJ4x9e9AlkuXw==
X-Received: by 2002:a05:6102:2923:b0:47a:2576:8fc0 with SMTP id cz35-20020a056102292300b0047a25768fc0mr1459015vsb.6.1712756693036;
        Wed, 10 Apr 2024 06:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQBE6gb61qopW7Aj7PAZOr2h1zGYUclZeUUHATWQLOSfmg+IlnKI24E1FEZ6tSTxARz96Jog==
X-Received: by 2002:a05:6102:2923:b0:47a:2576:8fc0 with SMTP id cz35-20020a056102292300b0047a25768fc0mr1458999vsb.6.1712756692669;
        Wed, 10 Apr 2024 06:44:52 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id p20-20020a05621415d400b00698d06df322sm5116986qvz.122.2024.04.10.06.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:44:52 -0700 (PDT)
Message-ID: <1e009e95-e6b2-4db6-9d92-dd830640289d@redhat.com>
Date: Wed, 10 Apr 2024 15:44:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 5/5] net:openvswitch: add psample support
To: Jakub Kicinski <kuba@kernel.org>, Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 cmi@nvidia.com, yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-6-amorenoz@redhat.com>
 <eb44af1d-7514-4084-b022-56f1845b109e@ovn.org>
 <ad55dd2d-c07e-4396-a32c-92d7aefe2ef0@redhat.com>
 <4a86e5bb-f176-42fc-a2b1-f21dea943626@ovn.org>
 <01898b85-d950-4e56-99b3-5a366dddb383@redhat.com>
 <f2bbefed-f17c-4127-a87b-13a5933e98cd@ovn.org>
 <20240409144947.1379e33b@kernel.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20240409144947.1379e33b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 23:49, Jakub Kicinski wrote:
> On Tue, 9 Apr 2024 11:35:04 +0200 Ilya Maximets wrote:
>>> If we try to implement all our actions following this way, and we keep just
>>> copying the incoming actions into the internal representation, we incur in
>>> unnecessary memory overhead (e.g: storing 2x struct nlaattr + padding of extra
>>> memory to store 2 integers).
>>>
>>> I don't want to derail the discussion into historical or futuristic changes,
>>> just saying that the approach taken in the SAMPLE action (not including this
>>> patch) of exposing arguments as attributes but having a kernel-only struct to
>>> store them seems to me a good compromise.
>>
>> Sure.  As I said, it's fine to have internal structures.  My comment
>> was mainly about uAPI part.  We should avoid structures in uAPI if
>> possible, as they are very hard to maintain and keep compatible with
>> older userspace in case some changes will be needed in the future.
> 
> FWIW there are some YAML specs for ovs under
> Documentation/netlink/specs/ovs_*
> perhaps they should also be updated?
> 

Sure, I will update them in the next version.
Thanks.


