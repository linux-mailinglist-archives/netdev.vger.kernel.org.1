Return-Path: <netdev+bounces-193898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42144AC6350
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEF11BA11D1
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C11F419B;
	Wed, 28 May 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3vArk2+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC382899
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418625; cv=none; b=HdEmU88gq2Nlnfeng2BVritA5HCjNZIz7GN/Wkv991s/kQ7OkOW/6Q4r3hQLVbTzHqVj+t3I+DO11Fq8ba1NcBdTLyh8H8uauT3sZ+Kd/s6TmWJj1p7bQKygR8DbZlzVc0Gqt4pdEWzdpLUsUzD2YQe0OJbRgp8iMy1rVaUq/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418625; c=relaxed/simple;
	bh=NqihgWTEBh1jUCG7kUpeQ20C703nVkPYq6iLxWxEZ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqAVQdgE+J64sIT6ITZhjT9O9TAolVousE2m4Ad1ZetShnpKF9MG9Fh7eJSzfvEDmro2sUg9AtiGfqx0LTCSPI/0BSubQTqFHA1jMz1WlWWGI9IhGoB8R3YyVKlJkyd9TMjaBKOf/6dO8ZtkLwUmvHmYKJbUwtQQLqhHt4VCzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3vArk2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748418622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tpi47h6CncFHkErQUdzowao9tBVRUGMqpMcapTTkpA=;
	b=i3vArk2+naJZx+0Df/8XJncFyXEKsewHMzC7MrfhEzGa/NJrhDX0OWnR0+3KaB/iO31ELs
	SMwpRcNa6pbWIlkfzCoa2gDblwuYw6BKz3jUSOB23kcOL4YO5ECXZ2TKDtaKuyDUWInzwY
	PxpPrw+k//BY9tJFQVblxhz+w9+EC1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-vcnVp3UiO6KY_I_xGLwGZg-1; Wed, 28 May 2025 03:50:20 -0400
X-MC-Unique: vcnVp3UiO6KY_I_xGLwGZg-1
X-Mimecast-MFC-AGG-ID: vcnVp3UiO6KY_I_xGLwGZg_1748418619
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450cb8ff0c6so476325e9.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748418619; x=1749023419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tpi47h6CncFHkErQUdzowao9tBVRUGMqpMcapTTkpA=;
        b=XZmm0Ed3FADzrZm+sr6Q+Vi5bxxf0GWrsc1UTpOx26zDKje1EJrB7zLksLpmy72WQO
         VvcLxTLQUqQZTwPQfpVFXg5UrloBfk97AZP9z7in7COE7hEaUhymn6mXjpJQhboFaufX
         SgX3KaG+Fv5lAsNIvUaj1PpyQS+F9rx1pRuva8f0xtqtbnzGWuIIpPIGH3hdfGyypFT+
         r31VVaNhYxsVdLpEz8wlgc5ioOH1Foi2txEipIqsAQ61nMDXxFBI4YDq5rEKQZ8nShKI
         sHlQpMl2qFtqi4kc99SEXjYKnyTXofu6kD8F44lO+j+OR0hnwZIN1KT1zekQNMMu3f/X
         zTQA==
X-Forwarded-Encrypted: i=1; AJvYcCVlhLhvCInz8mGtRFcZ9uBpPgn4lv5tkhg/YUjzrJMqShZXmVt4kJdRZuRKCId6f1HtrMZxdZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGcUDxcriQzf32J9DW3DLiZud0TcFf5w7x7qgGzLiCI3/0Usr
	u67o7LdsuJFBv8nCrk9kbgg4tJEUTqq3T5jqTjL+soDQRg56sMD1IqQdwaLHiBh/x5lUy3WNgCF
	YXBd5taR5gsKU8le0lt4oIMphYV/dQ8a8yX14UfI3O0UGH49RSCarEdqpBw==
X-Gm-Gg: ASbGncupGWILArGqkURwUYhFaBzhjK/b7SRcpYd1N8jjHt0ZgTdmH9Q8B11hz5LvURu
	1Ho//iplcr1iQfNbMNHIojS17hN/2y3kecIe13w4hwVIM0ve1ZhmdOJXaqEsx3AvZxtQfZyAtS7
	+pKk0HAUh6pcLqaNOlna4VfrOiQIqhMZnDQDkOW425rB5YI+4gFZXfNHuwLZUrv9ipQiyu+5F5Z
	gtkJ02NRF3xHhs58K8hHdySCiLKtqlwfqXDTdhKkKYqdiONSrcbohsQmavGw/lTkAwFfkLdo+N5
	EtbtjwDCWaO17oeW2GQDHCViBk0e4BsipPtMo1WYWxvTnn9xL2FwSgSYhMk=
X-Received: by 2002:a05:600c:648a:b0:442:ffaa:6681 with SMTP id 5b1f17b1804b1-44c959b8d8amr110637325e9.28.1748418618965;
        Wed, 28 May 2025 00:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBWJyZILJbrgkPiDDB8tVOLhwXdtQjh+xX3gUrTyMstA+8ge6QPCVLy/QC/PtLY7yRC/4N5Q==
X-Received: by 2002:a05:600c:648a:b0:442:ffaa:6681 with SMTP id 5b1f17b1804b1-44c959b8d8amr110637095e9.28.1748418618539;
        Wed, 28 May 2025 00:50:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4507253bebdsm9195275e9.4.2025.05.28.00.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:50:18 -0700 (PDT)
Message-ID: <f2ce8d64-2e0b-4fa0-b266-4b4c547771bc@redhat.com>
Date: Wed, 28 May 2025 09:50:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] selftests: netfilter: Fix skip of wildcard
 interface test
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
References: <20250527094117.18589-1-phil@nwl.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250527094117.18589-1-phil@nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:41 AM, Phil Sutter wrote:
> The script is supposed to skip wildcard interface testing if unsupported
> by the host's nft tool. The failing check caused script abort due to
> 'set -e' though. Fix this by running the potentially failing nft command
> inside the if-conditional pipe.
> 
> Fixes: 73db1b5dab6f ("selftests: netfilter: Torture nftables netdev hooks")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

FTR I'm applying this patch below the 24h grace period to avoid sending
a net-next PR with known issue and known unapplied fix.

/P


