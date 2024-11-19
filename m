Return-Path: <netdev+bounces-146200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA39D239E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C372833B4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B591C4A15;
	Tue, 19 Nov 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NimRcjPx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B71C3045
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012206; cv=none; b=lhvWC+jnEk3ycMKlm6SxqDSgO7RwU2/GzqD4L+R/c2D5VdaVKAe+ITrhS2Mqcl5b7O/pjwpphpOersITr2I9MZMyI1JsucFU0En6pTm425Hjc9SPm0gwUEWqf0JmNiiBqflhjc1gG44iczDdZu2R7huHt4RsfVXLs6lSGyvQXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012206; c=relaxed/simple;
	bh=ly3mNd5YsalM+CzqIwmHDN6pX4o4d/knQWkiqA/Uo3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQGa0iwtcB64VEY38ZGBE1Q66ijb25NUBAy05YDRQAGCIzgRlj0hDNMkHHqG9rJZ+38Wl5LU+1wkKD2JcFqpUbj7HilE+KcXWTx71RW/ArSBDMoUA5feoOc9ZDT0VxnkIuNNRi73FWjv9u2PMo+z3436ynXeqx/2H1g0zrwSZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NimRcjPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732012203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v03iSxWVANhOeJxy3bsm+mYyAEfzffMk3+YdoIoKdjY=;
	b=NimRcjPxuUz4f9SYPghgzs/c/yp+ywSiTO8NmMgELMaUgHLK5Onyn/Ju5p35hHwNR0fXL5
	1rNbO7WDQQ3oAIhPV5zm4GVga9/A/6/Dxa38sc0rJHkKzHRcrSrLaT6uqF5tRTwAmIVYam
	IwZ+KBYbJxo8X/B6f0drLA25ESzBmug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-xPkyBn9UPhSCz1eAAeXRHA-1; Tue, 19 Nov 2024 05:29:59 -0500
X-MC-Unique: xPkyBn9UPhSCz1eAAeXRHA-1
X-Mimecast-MFC-AGG-ID: xPkyBn9UPhSCz1eAAeXRHA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso22166215e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012198; x=1732616998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v03iSxWVANhOeJxy3bsm+mYyAEfzffMk3+YdoIoKdjY=;
        b=FMYyfRoKi+Kl7xyzTz7r8e0p66vE7wiZTq1YC2Ub/psXHpXJe849sx42HwbgjFWoCf
         E4pZ9UCxSH4Byk1qQVQGgkJwAaRGPU5WprHL93dAweXvugfSlL27gyFbdXGWTJ/SESQZ
         yKTdW0/i8ZrxXRgLsUqHa86Ayy8/Q2jbTNsyTXNllPAU2WDNj+MSXRiO5mylDUBEl4ca
         +OVV49Xnel3wir08fRkrUCdIaWsOpIzMs8gCklvTcak/qitPRrgphJwj7/l1CMrf5oU5
         twUdgODfw+uAtAejwkbALkLk6IK/JbC8rc414MwAxDjaC085IjH/Jws4NnHfHhhzuigF
         UdJA==
X-Forwarded-Encrypted: i=1; AJvYcCWbvU67kdPy3+E/z/5YvbM8H73DB8RMg8r2p/xUrp9ZJzcFoTj5AHWmTKmDJNt4DEeTXEzTv3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIwmr2CsSWTkdf1EXnkvAboQb2o4H9d6s702hJCbZR6wONtBB
	qZSgKbfEeAQfffxU3/qHI7EQDYPv1zR6b9SJ7aBk4oK4wcqnJijImolkZXWbRT9PWeurpa73aXv
	U903Ewj9usSgMcxqQHorAAwB0SYOCQ9IrW83H6Zjyj5C5+Kd4pXxo3w==
X-Received: by 2002:a05:600c:808e:b0:432:e5f9:2eee with SMTP id 5b1f17b1804b1-432e5f92f99mr105146605e9.5.1732012198154;
        Tue, 19 Nov 2024 02:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaGxrBXvlh0iZlre5SixcTdzb4uCu+PUvt5x46epMLIPAdXpFV9W8760iADbVJYk0QOUROtA==
X-Received: by 2002:a05:600c:808e:b0:432:e5f9:2eee with SMTP id 5b1f17b1804b1-432e5f92f99mr105146425e9.5.1732012197833;
        Tue, 19 Nov 2024 02:29:57 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm191873615e9.28.2024.11.19.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:29:57 -0800 (PST)
Message-ID: <bf7a70f2-ab0e-467d-a451-a57062982f18@redhat.com>
Date: Tue, 19 Nov 2024 11:29:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
To: Justin Lai <justinlai0215@realtek.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
 Larry Chiu <larry.chiu@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-4-justinlai0215@realtek.com>
 <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
 <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 03:30, Justin Lai wrote:
>>
>> On Fri, Nov 15, 2024 at 05:54:27PM +0800, Justin Lai wrote:
>>> 1. Add RTL907XD-VA hardware version id.
>>> 2. Add the reported speed for RTL907XD-VA.
>>
>> This is not a fix, it never worked on this device as far as i see. So
>> this should be for net-next.
>>
>> Please separate these patches out into real fixes, and new features.
>>
>>         Andrew
> 
> Thank you for your response. I will follow these guidelines for the
> categorization and upload the patch to net-next accordingly. I appreciate
> your assistance.

Please re-post the series including net patches only and wait for the
merge window completion (~2w from now) before posting the net-next patch.

Thanks!

Paolo


