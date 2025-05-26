Return-Path: <netdev+bounces-193475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F24AC42BC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D7178CE4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C163214A7D;
	Mon, 26 May 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCxvVceT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD021018A
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275304; cv=none; b=qfUwxpZm4Em1kIcH+luU2AM3nxxovY2jbsbh3gRi78/iCfbN5RmxqRabnQCI2d3bEnfOMJqzre08EiA3rKDxmaWTCSDVT4U9WBguiRRcFetNHZ+bGz2zBf+W8KQp3xST56+OGpvJsxILG5NFzH+wAZD7ryBydK9/Bl+S1mOdkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275304; c=relaxed/simple;
	bh=FTqaI7t8RxcXrVZU9VUNxiCBtuV0no5S+yCRZG/CB3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdMRoWU2o7drXMzz0GQJmjLQen0q8hvfjPKts0OzMGUzsuW1SqVfbFskTjid8SKeRgd7L3GZRy44kmqpHPgO0eIeP5B0aw0qvyTY5IGpsaC57ZiPnFUS1mv1qVJqKbWRUIxd3carzQbopL03EIYlMImGhxQEc57FoBgu/5vjTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCxvVceT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748275301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT8Ho/edJj/b07n6d4X1kH3ehVgioTniu78IFWGtIt8=;
	b=MCxvVceTxItb/1iyvqqP3kdHVuDx+q5JHEOUTRSU9Zp+3+R6Szta573mG3Mypvlj+/9e1w
	nYyGDo0eLHZuazTv5be7IUy62M3pPm5dFUQ+8zYWvrvkWNgcM/BeuwTSvJNNOLLUNxif2o
	9MnR2Ix3gXw0gKRQuqMxKYmuJRcVYW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-gu9O9X93NjG1pCOoegkm2A-1; Mon, 26 May 2025 12:01:40 -0400
X-MC-Unique: gu9O9X93NjG1pCOoegkm2A-1
X-Mimecast-MFC-AGG-ID: gu9O9X93NjG1pCOoegkm2A_1748275299
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso17840135e9.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275299; x=1748880099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT8Ho/edJj/b07n6d4X1kH3ehVgioTniu78IFWGtIt8=;
        b=OGSkUI28LwKmhOk9p+Gl8E7WsdxhjMs0WZF9KwWU16xALETrGSMv1NNsXS1TW0yOxj
         J2CKXZuUBZCzfuTSypgV+VmFbkCEoXgOFpde0r8v8YEUG/Iwmqr13hRzC4fybywR0LRz
         Vzqr2WIcq0TBNEviX/BQs/czJBZQ2nPIaQkWH2epkb7ZUEpUqKtrQj77BR6egvnOnRT8
         u0eaeFUPp1nHZJSMAqVowedn8tetwPtZd4s41ySWqN7+0GH8wwHM16WY50OZmgn7w6Bp
         seOlNUEc4wQNsMbygRmRI6vkw0eF5ksVP6tlXyVhP8bdP51qRPkTOIqmfn3DL5C+IRTY
         if2A==
X-Forwarded-Encrypted: i=1; AJvYcCWgHxEUrA6XEw/7sHt/SATir/bGHCStk3VTPcAhTFb5HDFcpLPKd2nBQoF9KCqJmWL1RwqqKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoSUi5DMdp5S2/v5sLJgQnIQgKyUzB9lPswNcGo3WX5f+t7/u
	0KE5EtFRl4DMqkWz/iYuT/VmeHMbOwCuv4dbJxftKuhQriIeHYRBL4CB0F/gaKmaKWTZhecLuJG
	9QF+QKlPItp7NEnHQLeRxqPaYXpLJAyFRqa7kz9wjnCt88/ONZmkxjqB5AA==
X-Gm-Gg: ASbGncvJZgfl+V47HJzP6KwUF9ZjOIChB0/t95v5LRPfpwdnJV2Rgo8Iq6yW9Yrspaf
	QgT8lR0z8FITV7eg6URL+WgLYeGcSgeYg0nWO8s2ixcvnHg0UO/alQdb0507YzUfBplu2CiaP5i
	M2lYBpJn6hZ5COCbXjPPWqT/eYRH03wiTAvdr+Xh2OYUPFezgOopYjP5rDqyAsPoyiRd9LcgBI6
	8Fn19qThOSwSV0XlrZLTodL3L5Y/bd6hZAu+i5d229BS6sHqrvWs5YuSAkmzzTGFEIXqEqCjmO4
	CCVBqKJIZ8iaWoiR10g=
X-Received: by 2002:a05:600c:1c27:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-44c92f21e2amr65777645e9.20.1748275298238;
        Mon, 26 May 2025 09:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+50k3T5CMDiIgdqAVfAROx0cJKvW/edB5JJA880McrxNIY+zCPmgbCIcKfpwxoGKBgbrzcg==
X-Received: by 2002:a05:600c:1c27:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-44c92f21e2amr65777155e9.20.1748275297711;
        Mon, 26 May 2025 09:01:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm236658915e9.27.2025.05.26.09.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 09:01:37 -0700 (PDT)
Message-ID: <18051f57-37c7-4994-8859-d0c41ef6fb7d@redhat.com>
Date: Mon, 26 May 2025 18:01:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: nettest: Fix typo in log and error
 messages for clarity
To: Alok Tiwari <alok.a.tiwari@oracle.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250526151636.1485230-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250526151636.1485230-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 5:16 PM, Alok Tiwari wrote:
> This patch corrects several logging and error message typos in nettest.c:
> - Corrects function name in log messages "setsockopt" -> "getsockopt".
> - Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
> - Replaces misleading error text ("Invalid port") with the correct
>   description ("Invalid prefix length").
> - remove Redundant wording like "status from status" and clarifies
>   context in IPC error messages.
> 
> These changes improve readability and aid in debugging test output.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> Resending: Previous email used incorrect address for David S. Miller

You should have waited the 24h grace period before resending:

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/maintainer-netdev.rst#L15

---
## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.



