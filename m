Return-Path: <netdev+bounces-112085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788A934E23
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F20B213D2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F913F426;
	Thu, 18 Jul 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0jO7sxI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455613D52E
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309127; cv=none; b=hG5QNDYWjvYbkk+7GH/n4mNmMw7YU0k4zNnNbkU5LNpMeekTh7LDGH3XWcl3WpZHIGli7Eupqv68utyUdE/6RzqUZK3IyreQK4kY0aNmYWmTTNxlAw/elgsn162p85egF6o0hQdI72HiVJ5CLR4OfaocJliYcy5cjiNTmO+xuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309127; c=relaxed/simple;
	bh=5KTinmv7XSXWPbZ0s4JePYuIZBnr7QLwI3QLrD3l6IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AylDHpE2g29JaBDXXibuFYrmEc6HxOA/D99DYnjwPjHKw8oWRxZmrWm9wMvjp9YU8jbQrzh7rKorVlt4KhzLVv+3HVwtZHLfHSLdTT0fRixxcckZ4tC8jtgXOAPFL2hWgspDo25UXQuvY9JYf0fAdMyN6QPfraRSpJHOwPFSYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0jO7sxI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721309124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXsMcahM/dkX5NU3LDR+2q3rhH+C04CObb186SJjvaQ=;
	b=g0jO7sxIN2HFwDfiG4FpCC0JPZMPUHbFvbydtIhzMqp68QFdApCcQ4ko5g0r8I7P/1hwcu
	zc3m/5fS+ctdiaVOjzSLODLluZKrnhIK/CjSpnSfuMY5IeLYlhDhrjLu9WgeeDlLCj1jCG
	NTEFuIBRcaAg8BfXKBD4ZT3XOpdb4V8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-W95rlxe0P-CN-gV0wkqBTQ-1; Thu, 18 Jul 2024 09:25:23 -0400
X-MC-Unique: W95rlxe0P-CN-gV0wkqBTQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so837241fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309121; x=1721913921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXsMcahM/dkX5NU3LDR+2q3rhH+C04CObb186SJjvaQ=;
        b=auX1h4kwhcunnc+yNT8q7COTTFNYXie6RlfMBCTZBFJjT2gXoezZ2Y+o6K2GWkNv44
         I98NJU8nrxrmxpDsJm2jg8T1iyIi3fmlXl+Fvgy6e8YB5h6HDYiDtipVfXQr0r7hKiem
         tSUsvHi/pKmjfT+78TF/9xCNpKxNp//IK/uijbAW5E8b75mHbXPthMlS5iO/DtRmCKfL
         2ggbLIiFX3uYXm9sCLxe6IQvRcW7sCUesjCKqfh+eK8F07BfHhkw8t4tq77ucpAqP1GW
         VyhbILREfvWfvnrrSAlhS3hEc6JsOp000GT5E/ZNyOjziRpLP56MS0eJYFGLS5pRxwv4
         cHpQ==
X-Gm-Message-State: AOJu0Yy1p4OK44GDZ29bMEK6owh6GgI/WnoG56QwVtDSaH+SuO4B8iyN
	SzTODJpGCCy9kvNQ9TUzHbRJ1bUhp3Xnn0zCj1kA5bZljSHLSXU9jDc1Z0cqMqgCoB7DQiBpPC6
	Bfj7Pmuggld8e0LWLzshHQppM7Q+X265v/XfkR+oOlSYJfnWVSb34ivLV4/7KRg==
X-Received: by 2002:a2e:9954:0:b0:2ec:4ed6:f4a with SMTP id 38308e7fff4ca-2ef05d2c1a3mr11749781fa.5.1721309121669;
        Thu, 18 Jul 2024 06:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvBgPk/sBcoqR3p2CVxdhR0A+KeAH5D3l27sk4H3U+c/E1eHcfuAWSwfQlZbHF2DmgKZhZdQ==
X-Received: by 2002:a2e:9954:0:b0:2ec:4ed6:f4a with SMTP id 38308e7fff4ca-2ef05d2c1a3mr11749541fa.5.1721309120286;
        Thu, 18 Jul 2024 06:25:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710::f71? ([2a0d:3341:b08b:7710::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b317f1sm12708145e9.45.2024.07.18.06.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 06:25:19 -0700 (PDT)
Message-ID: <5021a2aa-1398-4b3d-b1fc-6bbb2d85dfbb@redhat.com>
Date: Thu, 18 Jul 2024 15:25:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] eth: fbnic: don't build the driver when skb has
 more than 21 frags
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, alexanderduyck@fb.com,
 kernel-team@meta.com
References: <20240717161600.1291544-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240717161600.1291544-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/24 18:15, Jakub Kicinski wrote:
> Similarly to commit 0e03c643dc93 ("eth: fbnic: fix s390 build."),
> the driver won't build if skb_shared_info has more than 25 frags
> assuming a 64B cache line and 21 frags assuming a 128B cache line.
> 
>    (512 - 48 -  64) / 16 = 25
>    (512 - 48 - 128) / 16 = 21
> 
> Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Paolo Abeni <pabeni@redhat.com>


