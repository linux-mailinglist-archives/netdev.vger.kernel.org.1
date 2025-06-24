Return-Path: <netdev+bounces-200584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9FAE62E4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A17A7AC6CE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9728466F;
	Tue, 24 Jun 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQXVA3sk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681B28030E
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762230; cv=none; b=RYJ8UgQFAfNuWkh3gGXHXMlLCYkxA7fPkT1HdlDpLqb15D4CqY6hhWssJo+U0450OLnN+vvtpuoQ8m7boBv2weeqLCdJfwyeek291Gd1vc0bbB+JKc5Pb8PRRK27E0DLeBAnvqPLzUBuSdtPiS0GSMUVXxjUzl5eIgwRV0KY28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762230; c=relaxed/simple;
	bh=qBq+f4c3Nls8l4McJnGhK8BgYcP656yzeWu177jOtf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFQ/S1Yz4/Lcv0+8tKCa4oWdkQyra9DK6WcXTI4htEZP6XPQvnpnXGOlcpoXTRiXYxLWV4QnD5lzAbWUVt0kElZrqkr7VRFqNCJSnm5Q0IuuWL7qbTYEV0G+vkPcGI8zJj0KrKBAyGGZ/ze9UbXsWXyJ2zEHmqHAP6xshc8hTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQXVA3sk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750762226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5WrQDajdq88YXiVGmKcCyKustSvwPWWJwlqVUa4+2I=;
	b=aQXVA3skeJx1oBK+9Azl4TOROyARwDDtzfUNpg1PTWc2DQo6c16YoIxNClwrK+aFCzKdwR
	+oNqvxXWhHzfskhwGgBjUeVS6f9FgTzkFQJ8DStdPujqYS8YA99zdtBhlV6kaqLF2P8Pvk
	NV3OHTEM8zV8czAyJacGEeBxdwbNBik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-GLLIvNOUMOWvkueI_yfCwg-1; Tue, 24 Jun 2025 06:50:24 -0400
X-MC-Unique: GLLIvNOUMOWvkueI_yfCwg-1
X-Mimecast-MFC-AGG-ID: GLLIvNOUMOWvkueI_yfCwg_1750762221
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so164266f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762221; x=1751367021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5WrQDajdq88YXiVGmKcCyKustSvwPWWJwlqVUa4+2I=;
        b=gDJOwyCsx7Xhqws5onsECEs1SjoG4UN61SxETACO7F+Imn2IkU7pvCbOGzdYw97i5Z
         yS7DkHQpGTwx3jV8K+DJ9NBdXslidTF0K/v9QzJFaRpnzHNGMAYGNgdA8KS5efbcsq2R
         Xp909A3+3rEDpHqt6fJrAFFIHmZAW9wHs+2Xq2n5NcO7m1k1whvD9BmHRxTsy1LSKcRz
         6hcXiTTAm4q00Po/71hFiq1NvXjP7/k2SIpcnFOAVrMNvSodv3osMg1BiYEscfqjRvZZ
         xgTXdnZbdvOBwSrc6xRe47FJ2W4jT2k0Qqn4iYGn1z4EPLnhLEovFj6tmbpnwCyerTHy
         ++2w==
X-Forwarded-Encrypted: i=1; AJvYcCWhi4vIFEl1jSNoexV0eOFJNB7VkUQbx1nNNfht43LomSdt+Z8XHlq8+7njgEEvHkzTgb3EVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbaG7uLQu+Av2tuQQKoERa2ko4DAHAEY5fL9TOw7NycqUKKiR
	/8nOdJodyn3/arOGi3Am7UmAb5P1O/RX1dlSStEwJDz9luFLRHUpryHKOuxZqFFF1Zux4BNiBhh
	tiWwJGkjudGwcmrJGklAMZDxa+VB4DBYZwULUGYMXLuToH8cMDJelFPbLwA==
X-Gm-Gg: ASbGncvWgBqirOdnljMYBw94EU9V2PfRk2a5XbG0zSZqXcjbUdRSHNAtSnNg/Lqhem9
	fYUdhlbSIMcGNnb+Y1jnPfvqtybdcjvHkjpcq7UWJeIQaXB/0W0q9lDPQivbe7eBqFKVbMWwviE
	nligiJd7Wel9YNNZ5Lmgmtx7gtjLL3YURIsl0S2ng9cfLfpvJjwQn5GuyXQhYOFYo5qz6b4xKEg
	lLlG3mlFtV5VzdhI7xoLMbOr28DRsoBP7+uZY++Dp+30fERoqf6t+IeEoGQhywXXTzoc4gcE1xo
	vJWJYg5qEOrMAH32okw7Xd0AEChrIQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr15603611f8f.14.1750762220915;
        Tue, 24 Jun 2025 03:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDS860fadNu+orhJGcSV1eJbxh/1Ft7AuU95vjWZvGq5lkPoCoIOGs7Wx4N7UeVznb/3cy/Q==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr15603585f8f.14.1750762220419;
        Tue, 24 Jun 2025 03:50:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805dc00sm1703276f8f.31.2025.06.24.03.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:50:19 -0700 (PDT)
Message-ID: <99bea528-ca04-4f90-a05c-16bb06a4f431@redhat.com>
Date: Tue, 24 Jun 2025 12:50:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2025-06-23
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250623165405.227619-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250623165405.227619-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/25 6:54 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b851a:
> 
>   net: mana: Record doorbell physical address in PF mode (2025-06-19 15:55:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-23
> 
> for you to fetch changes up to 1d6123102e9fbedc8d25bf4731da6d513173e49e:
> 
>   Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-23 10:59:29 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - L2CAP: Fix L2CAP MTU negotiation
>  - hci_core: Fix use-after-free in vhci_flush()

I think this could use a net-next follow-up adding sparse annotation for
the newly introduced helpers:

./net/bluetooth/hci_core.c:85:9: warning: context imbalance in
'__hci_dev_get' - different lock contexts for basic block
../net/bluetooth/hci_core.c: note: in included file (through
../include/linux/notifier.h, ../arch/x86/include/asm/uprobes.h,
../include/linux/uprobes.h, ../include/linux/mm_types.h,
../include/linux/mmzone.h, ../include/linux/gfp.h, ...):
../include/linux/srcu.h:400:9: warning: context imbalance in
'hci_dev_put_srcu' - unexpected unlock

(not intended to block this PR!)

Thanks,

Paolo


