Return-Path: <netdev+bounces-137786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A89A9D3F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0831C21F21
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D10192B70;
	Tue, 22 Oct 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/+HMHSw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D20176AA9
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586560; cv=none; b=Mf2z7HU9tiotAQwQREMg20WFEMe9zZK7rDof1XQIsoAALRrzxxDi2OwhOMoC/zX+FuPrktTre5gtNo6c07LcaPz7ndKSCyxQXjXF3DNQ38hF+pbVzI4xO4EFoLSDVqhps/4ThpMnt6gNPD3NZ5MbwzCbh59xT/4cCuOuONA/A7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586560; c=relaxed/simple;
	bh=wKJHY2I32oDJr7b5rvQgvZn8AxHw4x6HflpI9vYTGeg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fXzBfzIXtQX4uJt/gbAk6T79zCOwDevwfSwuJj53rDt+i6rb+M8FzCJuyENDTcYNZ5nIcsx6RwXp1DVNa8uihiU5C99wbuoDepXRJISSPnk0IJCwPqrntkRqv4EG72AYm2v9oqQUl2HXzMiAGBgx40krfDJXq3SRT+oxTq45MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/+HMHSw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729586558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzExqh9OIGJ3QsOAEb6URhcRMNJNxeFogN6Awio9h7E=;
	b=e/+HMHSwO4kdqAMarvtJcu1Gdwo8r2dmuv2W+SIbQCdo9chAFHydfASbpCSiYNKy5gt1qo
	lUVrA2cL0XKPxXqVpIxrVhq4uzf1+gXmJvcXQ4UwwSwDgEX88cjFyRKjPd45/SUm63dV/L
	rpuuTlFTGDvjdENn80FWkocUPNWMLd4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-bPC3AaexMp2RYAzRkwxtLA-1; Tue, 22 Oct 2024 04:42:36 -0400
X-MC-Unique: bPC3AaexMp2RYAzRkwxtLA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so39191165e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586556; x=1730191356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzExqh9OIGJ3QsOAEb6URhcRMNJNxeFogN6Awio9h7E=;
        b=nl1V0GaSkBg/e3BF/cVNBEPQe783zAZn51zpiQocqOGQwrSrN3nnX6PvOfyqAOX7kG
         t1VjHkkoY4RXK1XpoVsrvPhiiPT4e4V1UU0Pep1R/Fwvv6PxgB5yxsYdJkLmKICAXBkS
         OefSzOWNTNArd8aUOcWjkmwyD2XJaCBSwWUBeEOsLA0c4vqu9D17egwnRNTVy35tI6om
         egHB+lqymtOyll7f+1/WS3v7gHBoDyUy3eEpMg94Tt8pdxunv38o7xPc/BDifZK/Racp
         50ysUjxerW7WSiro6o9aw+7rfYej3dHcaKF72N1nz0hTqpXjYHM+wBHaCyMi9tILnMn8
         lq8g==
X-Forwarded-Encrypted: i=1; AJvYcCVn17tPWdGmf1FRiN7y2/VWRgNw7X2R0Of+mpFHuQOpGVpJyQNxxDWT2cEv8auwtFiyisbywzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShLUY+c2yI79mfHtTJeZ9Fv3Yngc2Bz8AGqEcUkgQHWnBIlWD
	mbVFXca8Thxt3Jiu+AZ4kKwFpsCUsQlfkLgltLhnJcHX0jvDWQvkziD1TkPhASJ7l8vC36IrhAL
	X6EkdE6YwYKk7hYEY0Qp35/RqzW/a7vV8pusmH1B/ZkQ+V2H8WKp4cQ==
X-Received: by 2002:a05:600c:1d1a:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-431616418c0mr120614225e9.14.1729586555791;
        Tue, 22 Oct 2024 01:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/jzp8JPOC1+qpj/V8JOMEcQi8I+rLG/eZ7uJLVFmbphYmqhk1KsgD/yiAij/J1+GppZzKBA==
X-Received: by 2002:a05:600c:1d1a:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-431616418c0mr120613965e9.14.1729586555424;
        Tue, 22 Oct 2024 01:42:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37d25sm6123446f8f.23.2024.10.22.01.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 01:42:35 -0700 (PDT)
Message-ID: <67a84928-a451-4b10-a5c0-d1e30b9421a9@redhat.com>
Date: Tue, 22 Oct 2024 10:42:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 07/14] rtnetlink: Protect struct rtnl_link_ops
 with SRCU.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241016185357.83849-1-kuniyu@amazon.com>
 <20241016185357.83849-8-kuniyu@amazon.com>
 <5b7dcc2b-b3e5-4889-b0ff-6c341e4d9154@redhat.com>
Content-Language: en-US
In-Reply-To: <5b7dcc2b-b3e5-4889-b0ff-6c341e4d9154@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 10:35, Paolo Abeni wrote:
> On 10/16/24 20:53, Kuniyuki Iwashima wrote:
>> @@ -457,15 +457,29 @@ EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
>>  
>>  static LIST_HEAD(link_ops);
>>  
>> -static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
>> +static struct rtnl_link_ops *rtnl_link_ops_get(const char *kind, int *srcu_index)
>>  {
> 
> This lacks an 'acquire' annotation to make sparse happy. Similar thing
> for the _put() helper. Also if let such helper to cope with NULL ops,
> some dups checks could be avoided in later code.
> 
> Since the netdev backlog is huge, I don't consider this blocking, but
> please follow-up ASAP,

Just ignore the above comment. Unfortunately we can't attach the
relevant annotation to rtnl_link_ops_get().

/P


