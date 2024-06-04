Return-Path: <netdev+bounces-100557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E08FB268
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57882B25876
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1377146A7D;
	Tue,  4 Jun 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAB5H0O9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E4145B0A
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504716; cv=none; b=BUrqwimSZak2c/It3OXEYSNh5CR2XP8A47A+qVZFugae/PGdAGo4XEoLrY02DhJJaByIuXEtbV1N3c7kOZosCbPFhxPm3EADMKqGR1y3cSr9TLpMrx035Ml6DmGH0GRIAS5ffCgGRby5+LJRwWN2rFs6Y3yTRwN05v1FSnBwi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504716; c=relaxed/simple;
	bh=b+uqx5fe5tv+FvK9FfrzZmS9q9MHmd/7to5UF9T5c2g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TrLUFuMta55YKZenjWbIN5Py7tpSeVVm+8j6ZEnNR8PvFsNwe3To1jsDfeMotMDhxqe/c18YiUstVL0/uwax4vH3JMyeeKh1usYvH7a99JHWVJp/vJqXdrgae8X4Luwivxk/wDUe9gfKdS+xp9Smge3YWt6YQYaxijX9lCqvjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAB5H0O9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaadde4dafso3386431fa.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504712; x=1718109512; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC0k6a72JP8QJgAe5ng/eqEM1GkRhUuxgwcgR8pA3WI=;
        b=DAB5H0O9uQkINpc0hWyET2oCfl9vNnOKwaXxZ3cFvIQId+wkcg1nkxn+4MCoF1EgW8
         ukVKc5NucQjjlx7+jJxfl15oU8avBdKwxucs+4VJxfv9IhRxA52ZiSNp/bYN+xA539MG
         WowcS1D4vqBDbEvIWauUWaQSECfUJyf7Ii8z5JVGPM0kjBVhI1m+dVpnvTwQ+XURNsB3
         RTFuYCfBUmWOcOJtK1VJexElh82uVK3fvjlJtCRpiqCl1yCFU9R+eyAPYYYyD7AD+YST
         NJMn6RgFB0i6RzhdKN7UDuYN2yf4kr7PCFt6YdRMb3VcyiOua6CmB9BllZG5mXq2EMzU
         ixTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504712; x=1718109512;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wC0k6a72JP8QJgAe5ng/eqEM1GkRhUuxgwcgR8pA3WI=;
        b=sQen2YJq+ZMaw8jnaZEZ8Qk1gKPDu2n+pAi9mUAbRJR8j7YqJzdbautiITiJQJZcMh
         xxZ5uKH11Y+fW7GHE73QJhF4uSzx1oVf7EFZAf34dOmHfIppz3aCHyCZNtoWoiRKP59c
         lfPO336Xlo0lQ9OWd1Sr4cHf3fgnAC1lARCWbb2OBE8zTIMyIjqNB5qWUm6qHqNnsQg4
         cM5GumNWX7ZcpWe49UH2ujihxFzppdiUnnBKmivYGcA3iBEYvunfUcwvCd75hVaMuU9j
         2sskX0zoPRtXWhbpZgNStKhGrsrOoe0l99tNEs9+Q9oUyUH3oHhBI/3E6J0sHVFhYUCI
         c2TA==
X-Gm-Message-State: AOJu0YyxKuT4whbjOY3w8iVuRwAOEuVXeuV82gMbXEFXDeE5tmo52v9a
	mz/MVm5tc6vH5l5gCqX1zf9J8izltUjM2FdO3qVBRfI1dm8tHt6U4KdmTA==
X-Google-Smtp-Source: AGHT+IFw9Y+O1lp8WnoGGaxq+34ZsvatwdSP4Aj1yzgiK23Cu4nmXPjH/v4xIwvi+AwdUi+XIEZRzw==
X-Received: by 2002:a05:6512:2085:b0:51e:e6f4:2ef1 with SMTP id 2adb3069b0e04-52b89819b04mr6078018e87.4.1717504712250;
        Tue, 04 Jun 2024 05:38:32 -0700 (PDT)
Received: from [192.168.1.74] ([136.169.224.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9eecd99esm354840e87.302.2024.06.04.05.38.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:38:31 -0700 (PDT)
Message-ID: <b448d9ac-53ab-4a87-99ea-2f0d081c896c@gmail.com>
Date: Tue, 4 Jun 2024 17:38:30 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Andrey Tumashinov <atumashinov@gmail.com>
Subject: RTL8125B on r8169 no traffic
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm having some strange connect-reconnect problems with my built-in NIC 
on RTL8125, Gigabyte Z690 Gaming X DDR4 running Manjaro, 6.9.2 kernel.

1. I have to plug the cable in several random times in order to NIC get 
it's IP address via DHCP. Manual IP doesn't help either. The cable is 
Cat 5e, verified with several other laptops.

2. When the NIC is linked and then link is downed and then upped on the 
other side, it won't get IP address, too. I have to use the following 
commands in order to get IP address and start traffic:

ip link set enp3s0 down
ip link set enp3s0 up


3. Other than that, there are no problems at all - connection speed is 
stable 1 Gbit, after PC reboot connection is always on, IP address ok, 
traffic flows as it should.

4. Recently, I've stumbled upon this thread which I think is similar to 
my problem but It should have been resolved in my kernel version:

https://lore.kernel.org/netdev/97ec2232-3257-316c-c3e7-a08192ce16a6@gmail.com/T/

Do you have any ideas what's wrong?

