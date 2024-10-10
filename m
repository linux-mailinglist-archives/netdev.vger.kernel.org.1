Return-Path: <netdev+bounces-134143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64E998288
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5533B287E78
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010591BC09A;
	Thu, 10 Oct 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzlb/aAw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7321BD017
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553173; cv=none; b=DQplFiTXwg3RGTpOLzmlk9ugl+6vDyX11wqZXVV/S9mzsrO6rc01vZis4YlZFeVhCrC4Bb5ZnH0N9M57zExhkStcr4R6fLZQ8MP7ow9GXRPM87afZ55c/cr+TQgtO/keluxS484NEkGE8wePKxXmW+8kfJkJHqv07NkTkcE/29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553173; c=relaxed/simple;
	bh=UH1KcN6aJU23wWi1cO1qdQicdr1PoB59i5Ni4SZhtsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzIJawG8qBUNXg4ogYG4fFhFL/6SyaUjg6RPGCF3pohySLrpeu37UhiU6LUXwFJqEEK1Nv8diNzOma1Oj9kCPBEI2fjwiywffXrd/ngaHETamFpuruXpihmXTFB1I+1ZbvRLtHuBQM94xbUljg4bs5aevD35tZSHfCfASF2hM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzlb/aAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728553171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFpkVzZdNC6CnlTTVl2TGiDBeW16kMCAfBnHOOM8DCw=;
	b=fzlb/aAwoqOj2HD6iLInGPujvNqTC+UQIoMNml4dAfHgbYsk7Y3RTj6yhO2VxXFVO6ZHJ0
	dzsWzMts651diNI3O2xqyoAswnkYPqeX7TpFvSudk1bXai0QtozP4co1T5Pj7nXwB/5zud
	9tbY3moCUC/ZwMFiWznbDyvcfyhIhk0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-hTOR2rhHPgCdOkc682_2Ow-1; Thu, 10 Oct 2024 05:39:29 -0400
X-MC-Unique: hTOR2rhHPgCdOkc682_2Ow-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb1c04af0bso5628571fa.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553168; x=1729157968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFpkVzZdNC6CnlTTVl2TGiDBeW16kMCAfBnHOOM8DCw=;
        b=iJ9cWvlAkDrrlcbD/fBZ80TozrMdzRg14MdUqVHe5fSVaCB28RFYkNKLEdxpQNeFik
         WsquyaghuIS8NVwo52vch6nk5Zm0xtnFrN5mV1/6XqrgGWSpbNO85lVMhlHLobGTeNtu
         geIJTDVflO39rn7Lr1rvun8IA/a4pnisSqbVHOb9WMHR/PIH8aqyuetx0Qp01xq7irSN
         5MYZJZ3d7iuwGosK+9rTPNXXhkQuSmbo+St3oqoZ0UX5mSaoI9Eahrhgjmn3nCs3dfFy
         99cHriLUiI/dZFkDN48A615VbqOI8lxtx+G2APRXhYGdK8MdkioYw5Ndl2Y5ZQjmZ0s/
         GpPw==
X-Forwarded-Encrypted: i=1; AJvYcCX0nhX6gaXX9wvSSWQixUJ/lXh6pM1a0lqkXyBJgIBll1UIDD4owd2I3b3D7MHXRLEPibuu6XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi6uEHquyGxx0WkCtwoKPfQGVedmwMfoWhPrJ/IPYL1oYLRve
	WOmvDq94e3TQ+9EPy3QuHfum61eboxT7/8Iqsld7eMuFaMq5nZYMeqse8m95GtO+V3/vev1vhaw
	yofFAKRaNwiLWroK6/gRdM+e7uv04kMh1HEsvdpfIlSHTzGDxgl+e7A==
X-Received: by 2002:a05:6512:1250:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539c496ac2amr3163261e87.53.1728553168237;
        Thu, 10 Oct 2024 02:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzYePXXkYHbL1Su4nyf+oLAE79vXYQkaaX3O0Z7jUlyV7RSc07CjqwATXl8but6Sk2WX7kuA==
X-Received: by 2002:a05:6512:1250:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539c496ac2amr3163239e87.53.1728553167860;
        Thu, 10 Oct 2024 02:39:27 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183065e2sm10822215e9.28.2024.10.10.02.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:39:27 -0700 (PDT)
Message-ID: <25f50405-e36c-44a3-8045-3cc569b37a1e@redhat.com>
Date: Thu, 10 Oct 2024 11:39:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tipc: Return -EINVAL on error from addr2str()
 methods
To: Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com,
 ying.xue@windriver.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tung.q.nguyen@endava.com
References: <20241008142442.652219-1-syoshida@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241008142442.652219-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 16:24, Shigeru Yoshida wrote:
> The return value 1 on error of the addr2str() methods are not
> descriptive. Return -EINVAL instead.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

I'm sorry if I gave conflicting advice in the past, but I now think this 
patch falls under the 'small cleanup patches' category we are actively 
discouraging outside the scope of a wider (functional) change:

https://lore.kernel.org/netdev/20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org/

Thanks,

Paolo


