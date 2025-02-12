Return-Path: <netdev+bounces-165701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA66A33216
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6E61681DF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8872036E6;
	Wed, 12 Feb 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOdeaRY2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1C20011E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398117; cv=none; b=PbbuS6PPt8vCJmrtlHvjReztaWfd+ZL1KWwvPku2RArEcCvs7YMR405ZjK/d4wGci0Rx2f0iH0iMJjmOOta07h34uVTYnTvZ37s0cH9yqc2D8zC9ebprSeddzXLkvNPfmD9K5RnvkdQmuLV87R4Bx+1/OVHAMBpFnHFbE7SHsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398117; c=relaxed/simple;
	bh=Ro2MVt8tW1Gnnh74OercKd727stShUoKnHVmKhWiYg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvFl1rmncfUZE8lMVSDgX/OxVCKEhaelyArmELvvoXSn1eF753n9h5aKGXttnAlJJZ2WG2fm6HNjhM0z9ytq7iL8RVbIN2/9bfGBlVsY1lBugVhJVf9vypeEHdhfpGHHqU3gZ/O+3M2uHBqPjeSl8v2UC+wU/rjIoT8TbWeDdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOdeaRY2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739398113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOR1P5WoGAyvX9t1uWMUcn4uIp0BivM1RbHensx2710=;
	b=aOdeaRY2EakCHQ0Gxq8mCwBWl+R2oWQ4F6Sv5HM+Fmw7RlGOQwA/Kj88p1bI5b+GgcBJ2J
	DVOJphdFh//OS7GCG/2fg2OYdOUM0wW9jwEkT8BuVPq8TBb9Pi5UvG2nwNLUP/yLhS6cn9
	aASHfCP7Hjm7jiweO/nUlYHrMzF0sE4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-JIPmJOEJOq2ITePzKLHp6A-1; Wed, 12 Feb 2025 17:08:31 -0500
X-MC-Unique: JIPmJOEJOq2ITePzKLHp6A-1
X-Mimecast-MFC-AGG-ID: JIPmJOEJOq2ITePzKLHp6A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dc88ed7caso127144f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398110; x=1740002910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOR1P5WoGAyvX9t1uWMUcn4uIp0BivM1RbHensx2710=;
        b=OMF+K7NWEXr5s3l+fobRAX8+7IU418Us6qBuenr++Bf9eG43RDsqiDC16xttcoeLHu
         /h9ldPUP3crJfPgVoA2RUebGfKmWvyKOjns5jylVHWyyEfgSyqCr5my0ne3vraQ8rExf
         8qbDCIktu8mAlJ3Rsxzm4OnrIIYOEsCD827H6iiSPYuVsaKeAk21KM6Up02KlU2rNn0d
         ZYp1+yoHnTE9W+D0HmaJ5dVc9FswNKwaa8wLgM4b9t6kFMcIbaB64n281Iqs/4lCit6l
         uQmihM09ssmVsL0hOj2zmRUEz8gjhZG0bmBcgZkyhEx2vNjFQ6w6RhVdi1Gn3sJkk/Ga
         dorQ==
X-Gm-Message-State: AOJu0Ywwoe7Bo9DyNoS5+bjS/SbQwtiiirna0x2+S9HGIzyrdKo6Xs2I
	BYK1PWeXbh6Q/u0WJaz1/vodrTxGEAKLKKjo6omSgamYUjuvTs2x4rB65kFpaWd/6AfTA5lHBLR
	fU+1WABDCCsDGlZ6VYqJ130GJfoW+MpygWCPqxMS41dzQ1CCitRiE9g==
X-Gm-Gg: ASbGncv+A0rZIIylKiJyZsHc95CHOzZx8n1CY/g1tjkD7EaNP7GQ0JNkkeJAss2tqBd
	Y1VvKKPFSWSuf3GE6aDoMUdVzXkObVKXI/F+jdIT4+mF0uN6+o5jeYPqGPdO0oqplheKaRAkFwL
	B3iAy06g7VPtvtHqdDIOi9YDOfWz3pqwwYNWNGqWs0N5jieY4JGyP1MqvkFEHQmEVSEGziuha/D
	2UExgGV8f4NLP6ETdDwNuJc2AkpFow9GxduBee3RjBA4cAG/q8KUwYjP94R3gHeWL1qO7SyetMW
	FMFrljEtXYWbcPqwJ13Q0n8nToz/JHpcDrI=
X-Received: by 2002:a5d:5f51:0:b0:38d:d969:39c1 with SMTP id ffacd0b85a97d-38dea25279bmr4046721f8f.5.1739398110533;
        Wed, 12 Feb 2025 14:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNX5XhjWipbCPE9R0NHr0tKFkz/A4fBe7y3TjA/LUzhnrvL8f+ER/PvEGOupaTx2odBGgvTw==
X-Received: by 2002:a5d:5f51:0:b0:38d:d969:39c1 with SMTP id ffacd0b85a97d-38dea25279bmr4046709f8f.5.1739398110030;
        Wed, 12 Feb 2025 14:08:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd46sm99738f8f.21.2025.02.12.14.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 14:08:29 -0800 (PST)
Message-ID: <504a90ea-8234-4732-b4d0-ec498312dcd9@redhat.com>
Date: Wed, 12 Feb 2025 23:08:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 9:47 PM, Eric Dumazet wrote:
> This patch still gives a warning if  MAX_TCP_HEADER < GRO_MAX_HEAD +
> 64 (in my local build)

Oops, I did not consider MAX_TCP_HEADER and GRO_MAX_HEAD could diverge.

> Why not simply use SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) , and
> remove the 1024 value ?

With CONFIG_MAX_SKB_FRAGS=17, SKB_SMALL_HEAD_CACHE_SIZE is considerably
smaller than 1024, I feared decreasing such limit could re-introduce a
variation of the issue addressed by commit 3226b158e67c ("net: avoid 32
x truesize under-estimation for tiny skbs").

Do you feel it would be safe?

Thanks,

Paolo


