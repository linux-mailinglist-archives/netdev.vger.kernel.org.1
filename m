Return-Path: <netdev+bounces-142779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611929C055B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9165D1C226BA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707B20F5B2;
	Thu,  7 Nov 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbw2wbCF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94471FF059
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981328; cv=none; b=JZ4L0E7zNf/hpvIljy18GKnNARD4dnRZKTnQvAcALYvJSgIYQh7IEEGecOb9jbcXNTGGVOnay01nVLRAvfmZtY2izMDgWpKI0fqdx33bBhpPUkq55ZKKeUhhvGD97SJeVLrLwNXaGsyz55qak5t8MC0FLRH3E+WTaPkS2hbg4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981328; c=relaxed/simple;
	bh=P+ZmCLNqT/7hSPWujVP3owEJpB951n6H3S7VxdBjr2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TCg1gqNB4Ya32ePuEjfFK8dqDTl54QJLBlwzQjUPzEBPSGhCYq6GcMlfHJsaiCYrJq+6Aw8wmfSi/DS1EQZ6izPiSqIYu4aWJozwtSl0hBEEYWDC0MIr6gJkrNWnCHkT720BzJf8Cp3+LP/IhF7RijUDOG/pZiwgz3E21GLbIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zbw2wbCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730981325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+ZmCLNqT/7hSPWujVP3owEJpB951n6H3S7VxdBjr2s=;
	b=Zbw2wbCFfcmyriiBER4v0yI/iksoGo+KQAEbhjQBJzWATdBPEM7hsEVjSFU8VnWvt18iDR
	XhwbuEYuw9d8xNy/95swXo/LmRE26wAe7MUWOKtzH30oJ9szG/0KZkpmF5LOQK1qysSpm2
	BISmGc6jBXh1VDIqSBn1FkB9Cfr4fYU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gUZHCm_gPjuWz1vIf2vHqQ-1; Thu, 07 Nov 2024 07:08:44 -0500
X-MC-Unique: gUZHCm_gPjuWz1vIf2vHqQ-1
X-Mimecast-MFC-AGG-ID: gUZHCm_gPjuWz1vIf2vHqQ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e6594fde12so842444b6e.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981324; x=1731586124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+ZmCLNqT/7hSPWujVP3owEJpB951n6H3S7VxdBjr2s=;
        b=tuOe4jplPt7Rd/LRAkHApMsLNw2mBGn4i3b7C7OW5f95aWv8LZnCsF4yATWAXxzAXH
         Wj1V95d4aM/QvwAy93L8CW4Z9ObaCSipQiyD09hhlYNPIeO/TBCAZ1+uH8898Hi93woS
         8tmDQSghVymHQyz1rakZHowhB/2EwjHx9To15bECqINMbfgaaOWvpjUtdhcCKZlCwKkg
         3tOYoJ2EyP26fzz/yFuByYUZO8VSSdCMsXdH3ZWlh2BCIMoy0zN8Wf1nSOEoiHnra/rC
         j2tv5n/RIc7KaPTIzW9ZEXX1aUacEBUMa3BlPNB8tkRu0WHB086bxK/3w5DbMg6pGUc2
         qGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf0CDO6oF90uJ2bL4EbnnSU8xVQ7rV4sZDO3IMcXf8fAZiFBeyJBS+Hs1e0j96mZ+4OumyhSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiT2ZJFMzapWsybRpeEuQWfAJXtP4m5/pD5cPBC2/r9MnV5gO
	7b7ytFrlEmGYIoPiWeFKBxon3SMwQP5EyCFEQr/L0NlaVaAbh4J6w8Jq1U09bxFKSg7nKh0NS4b
	5qGXXa/OSOdcqDvsee2aO3KzEvhDQfyPlaYNQ9+LNyXQ4gZCiTvbNDA==
X-Received: by 2002:a05:6870:178e:b0:261:164e:d12a with SMTP id 586e51a60fabf-2949ee0b87emr21308215fac.22.1730981323735;
        Thu, 07 Nov 2024 04:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeJrwUsl9lztRDYZl1aEOL++WosS7qon8mJ6s7nwFpWJQj81Qdxv4suuQ4ykwvnLVP/ZrxCg==
X-Received: by 2002:a05:6870:178e:b0:261:164e:d12a with SMTP id 586e51a60fabf-2949ee0b87emr21308196fac.22.1730981323479;
        Thu, 07 Nov 2024 04:08:43 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107eb5c8sm227391a34.13.2024.11.07.04.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:08:43 -0800 (PST)
Message-ID: <7e0df321-e297-4d32-aac5-a885de906ad5@redhat.com>
Date: Thu, 7 Nov 2024 13:08:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ppp: remove ppp->closing check
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104092434.2677-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241104092434.2677-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/24 10:24, Qingfang Deng wrote:
> ppp->closing was used to test if an interface is closing down. But upon
> .ndo_uninit() where ppp->closing is set to 1, dev_close() is already
> called to bring down an interface and a synchronize_net() guarantees
> that no pending TX/RX can take place, so the check is unnecessary.
> Remove the check.

I'm unsure we can remote such check. The TX callback can be triggered
even from a write on the controlling file, and it looks like such file
will be untouched by uninit.

Cheers,

Paolo


