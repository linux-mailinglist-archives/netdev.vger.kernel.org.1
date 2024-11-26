Return-Path: <netdev+bounces-147448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3319D998F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283C8B2625D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016B2EAE6;
	Tue, 26 Nov 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcZZ0mKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A21D5CC2
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630841; cv=none; b=Urj/Is9UQvVNKS3d7Rf6Z46wQZmZspijQ2Ylnk3pAhZZxPt/2BJkbcKmDiehcX64+hxY1ss8qZYxzupBFKWtTiy3ujQIfkRck2DB9YUaDmAeActSB3IA7j5YCa9m85oCK91BPYMqQiBkR/qA+P2hqb8KovyAW+pKSY5iS0qXghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630841; c=relaxed/simple;
	bh=Nt2N9AicdWJ/nKrqZ7uRqb8xhfY5yw882EqZyhO3gWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLWbi+2PuImAN5+ZNP1mD/DYqB03K/YOgAMkmaPqfrlVkcmbooLBOf9KY2X7OHx8aWOIoqorW1+vmR0OVIesUh0JpUHy84tfVmqaRUoxC0Wk9/HiocgOtH/6HHvgkRoYFsczbRnnGdiJpLdrvELyaRmouaOVx3WyZhVl5rb709c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcZZ0mKG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1833367so10752325e9.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732630838; x=1733235638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt2N9AicdWJ/nKrqZ7uRqb8xhfY5yw882EqZyhO3gWA=;
        b=RcZZ0mKGdAgUUWK/ZB+Rm/U74zxoAd8+IPED8WtVAqEUCUFEoaDPRgHT0gz1Dz8XLa
         s+TdnqF6+xdhX+BZXphvltmN7s2HmXUMo/Nua/Tz4b9P3ahxSurhjQv5J3XYFyvJa6mw
         DJo35WYE5TfLHqDSi0nhhyD21yHREjLU0kz+2LsJqIEyhS2GkN4oE9lRg7yzxNPgGzOC
         xLjgIfOETibrHwI/l8T67lXDko/VU+CjLzkIKd6NIwbuyp6OITnC4zZostm0r27FK5uE
         OIRwys5I6suEgsbMKYWT8mouJzLYoj/9gJRM6MdSAH/KExkqsPk860FLyQQxW3GHzit4
         tYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630838; x=1733235638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt2N9AicdWJ/nKrqZ7uRqb8xhfY5yw882EqZyhO3gWA=;
        b=H4529eIyyDUzuaw6wgW+Py4w2J/uIs2F4j6+sZ5J2O9v/3Gd8Y2rI1pR1/iCCL+opy
         tqcZ7/GgDL0yAqy2NzyC85416qMBbyIYZOnCx0SFsYaRKnn2Y7BeoddgN9yKssbOHWSv
         G//zkGHt4YmhwydMI1ADnpGQc+el6qWBCPPlB5E/wCK2rR84omhRSlOFhZqOml1IIZcr
         AdX0u60jLBtmUneStDaVzOb5wf7LGeM0roW6V0GSrskGVyw2fLKz4HqYmzu3klK9mXpt
         2ccLpGwGOZkoZU/ym4GpmzgCj/nteWNQFgYweHhyycv/Ga2dC1+ODSS/jG8bv6djebnT
         R4Og==
X-Gm-Message-State: AOJu0Yy61qCn8YQTZu3oxNWabpl7nlWKyKgDvuSHx1SDpOndBkH4QYSX
	+wglZkeS1gi54oeQOa5pW39AsbLtCbDXYE/6Miases78kviKd/dOMc9mUQ==
X-Gm-Gg: ASbGnct2fHNrqz0ny77/POhGTO8aonuaQduIm7nJr9+c6C+iQItTYPQQciso3DWkOLk
	lxN9Qv2vf2qFERE9VabKlm+AjvxLi6V1VeZXpYwkKrtnILL1+r1WlWz3LXyeafK8R8lJczncTZX
	5yW0AwOi6/FOv8JgGCpYee8/lYYZHebALvKUA62uWEf/k9cB6c3Jsk7UO1Xm5F4MJ3tlWevrTWI
	dBHOSdf1USQ/ZdqW7U6dAbGfGULRpJNK41uNoVGqJM1ZSJQI6bU
X-Google-Smtp-Source: AGHT+IEc4q9l5Ov+Mzz/8Uhjn/bsTfxXaE8rdH9ye3ZnjWPhVCXVuVIqOXZHkGIdHMHZv1byJER5HQ==
X-Received: by 2002:a05:600c:4985:b0:434:9e73:51a1 with SMTP id 5b1f17b1804b1-434a4ea3f2fmr31210855e9.14.1732630837962;
        Tue, 26 Nov 2024 06:20:37 -0800 (PST)
Received: from [10.0.0.4] ([78.244.195.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4642b8dsm231487205e9.41.2024.11.26.06.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 06:20:37 -0800 (PST)
Message-ID: <1e418442-722d-488c-858d-8789736b1b5b@gmail.com>
Date: Tue, 26 Nov 2024 15:20:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ipv4: remove useless arg
To: tianyu2 <tianyu2@kernelsoft.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org
References: <20241126131912.601391-1-tianyu2@kernelsoft.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20241126131912.601391-1-tianyu2@kernelsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/26/24 2:19 PM, tianyu2 wrote:
> When I wanted to kprobe the ip_rcv_finish_core, I found that using x1 to
> pass "struct sk_buff *skb"."struct sock *sk" was not used in the
> function, causing the compiler to optimize away. This resulted in a
> hard to use kprobe. Why not delete him?
>
> Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
> ---

This is great seeing compilers being smart.

SGTM, please send this next week when net-next is open again.

Also do the same for ip_list_rcv_finish()



