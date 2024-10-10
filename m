Return-Path: <netdev+bounces-134167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF59983EC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114F81F270F0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCB1BF7E5;
	Thu, 10 Oct 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QK1TyffG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AC1BE85C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556728; cv=none; b=LJ1cGOnuRGABUIxQ24P50ZQ5aHkAbd1zIMCkWGwU/rkKPkRja8kx0QNIi1mxMRsSWESNGcLICtpB1TnENAlUF/j9gX7RKo2ZVBSS6udCQCFrIellauSE9+VnFUst1fwQZm/MLuImHV6xdNFrdAVuk8cfruTrlZxwAoBHj+r4dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556728; c=relaxed/simple;
	bh=Tfw0UWN0VPUGCU6S1y5uTrPgAbyejSXETEcG0FRoBJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E4/jnUEFpG8k0zGCR2ETeXYbhRaStP51uLwvSxWeqD8VC0lLfKqbMs/XHLZDFOaoKjaBQ4qS0NnlkmwSg7dBw6v5HFH1y6xTCUxuH13elhkuu0UxXOHL3RRX2/XyqHqWLTGWL+hELorS1zfUSTRff4hdZUk/u+/P83shZpFMi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QK1TyffG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728556726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9NGAw0g5hDQ4VJq4rie65Ou2GvfsBst48dZfVNLApU=;
	b=QK1TyffGD1sy0SUJZfayjrDeG/sMGWMNvTn3+pZHnYpPz+Nb64gRrfVxSu6gX0S1KQdhoG
	TUwk/UeaLI7/Rk+YoI7AgZrV++xfXwxL4toro826HecA0QQMTR70jMkkqLtcEuIvowiO72
	4DxkHudF6dCdu4xD2WeoOKbUWkcXkU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-9DmyyVn4Ne2i3KIUf73qag-1; Thu, 10 Oct 2024 06:38:40 -0400
X-MC-Unique: 9DmyyVn4Ne2i3KIUf73qag-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so9739955e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556719; x=1729161519;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9NGAw0g5hDQ4VJq4rie65Ou2GvfsBst48dZfVNLApU=;
        b=PKpa5RS1kS3Vc2KDqpWXfhHgfXew6j+avLHBEISORAPJlwD0vDSf5HNPRjUbAY/3y+
         0OCQdo4ct+oUQ7ZM2w+hJHkV92JQyrRA2rEPs2Z+PVGJWJ0MBWXBc2uRdGAjyMX/7RyI
         wAdsRfBNntVSbroIpfh31RIdSZKNs+zjYuq4rudSs+BoemqOFVMHY7zwquOfhn7VPAF5
         nIlcIfSkWtWN449QOZs7DU2OdVfNr++Cb3d9D7ZBsnKJGR06sbfJyGdPrjKa6xhcLSoM
         Zyzh3hfNOvHMhZo67HsH5ujZn499et/SjtHuUsPDWL7AizzSCx0ImKZ/KcxNgvm4ZzrA
         kTWA==
X-Gm-Message-State: AOJu0Yx7AhR1O3kieyG67p8F4EQaIP8Blw0ZHUX7/xIWR+CniilhYWpx
	4PNqD7LfiUf3+diihbkwiRg2+1rX0dsGHEuy2jXYO6Tb++psetibWQJWEvnaO9aEjDj1XLF2eX+
	hvi/+ordO+k+8CQzXZQKe54R1hQ4p6gZya2d2Hx4Gt2W70qX8wr+rVj6sJxF9LwQE
X-Received: by 2002:a05:600c:a00a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-43115a9da67mr24580775e9.3.1728556718704;
        Thu, 10 Oct 2024 03:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3LS2Un3k5X+VmUBcOyzI3Ar5lk5KImO1MXVprALFe54dgZnEtaS9v9B+pa8DgAGBSjJmWQ==
X-Received: by 2002:a05:600c:a00a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-43115a9da67mr24580465e9.3.1728556718288;
        Thu, 10 Oct 2024 03:38:38 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf46e96sm45148115e9.18.2024.10.10.03.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:38:37 -0700 (PDT)
Message-ID: <3f190185-4143-4a0f-af36-eab2ecbfe670@redhat.com>
Date: Thu, 10 Oct 2024 12:38:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] eth: fbnic: add software TX timestamping
 support
From: Paolo Abeni <pabeni@redhat.com>
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
 <20241008181436.4120604-2-vadfed@meta.com>
 <d4413c7d-7c7a-413c-a75d-de876ccf6e09@redhat.com>
Content-Language: en-US
In-Reply-To: <d4413c7d-7c7a-413c-a75d-de876ccf6e09@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 12:18, Paolo Abeni wrote:
> On 10/8/24 20:14, Vadim Fedorenko wrote:
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> index 5d980e178941..ffc773014e0f 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -6,6 +6,16 @@
>>    #include "fbnic_netdev.h"
>>    #include "fbnic_tlv.h"
>>    
>> +static int
>> +fbnic_get_ts_info(struct net_device *netdev,
>> +		  struct kernel_ethtool_ts_info *tsinfo)
>> +{
>> +	tsinfo->so_timestamping =
>> +		SOF_TIMESTAMPING_TX_SOFTWARE;
> 
> Only if you need to repost for some other reasons: the above could use a
> single line.

Never mind, I see the changes in patch 3 now...

/P


