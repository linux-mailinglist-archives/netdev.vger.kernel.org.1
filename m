Return-Path: <netdev+bounces-146617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EF9D4966
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BDB222E5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE141CB9F0;
	Thu, 21 Nov 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6iC9y8D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC071CB33D
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179647; cv=none; b=A0brR4yKht3bIdh7o5CYbCrlhuaizrZ2SMfJS7oIZ9C1s7aCSYtggIPYjEibrQqyICP+AChasGfrkKBqy/DD1xKCSZ78qH3TBcgBxc/D/a2KPNQVOkLv6bjAudmmWkGWp4KGf6NaZh2v1X93+oLPlxyXWyR+uHgSPoXmrJYoi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179647; c=relaxed/simple;
	bh=ZnCk/5g2TfMnFVnDiNYU9hF72gFeq8DTzd2S/HP3jYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyll1MzRVOCzPch08yQyUul2G7vySw5Qx0iZgYKVZ11NeP0hCKe1/cgqFlLu9r7EIj2G4tGZS5ZlHaQ1cGbq/IVXyff1t1GCT9U/WqLs2toqh2N4UQmCXDLJrKBP564430+e6ijStloLY+70Je1lB5yfOdDGUfDSap5P0pTjGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6iC9y8D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGDVNO6KuLT2CaTKYJTuRwWCpafnUpHauXNIMBPMRRY=;
	b=N6iC9y8DL9vLmI41pVLq3IPRQfEok+2PPNQgjKqhcVu+kvNcbs7o0VJqDeR+7joDH25TH0
	Ou4imSCohI1uHm+urTUHGcdkUMGKn5FIUTK+j4PKQqf5cUyiRH8H83kAsCQfy1KDvflky7
	NNGbE38rnc7Y37x/X1DJZnP8VmRpRTc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-NI4OjzOUMy6haUHCKzNOaw-1; Thu, 21 Nov 2024 04:00:42 -0500
X-MC-Unique: NI4OjzOUMy6haUHCKzNOaw-1
X-Mimecast-MFC-AGG-ID: NI4OjzOUMy6haUHCKzNOaw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d41cbccd23so11075426d6.3
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179641; x=1732784441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGDVNO6KuLT2CaTKYJTuRwWCpafnUpHauXNIMBPMRRY=;
        b=fioOC7KSQU8EY4Fae/LZ7vivzMkjESE+gOYlUZoQIjoNzFAplV8JwT8sbBzS0Yc/rz
         rYA4Cs/CVBurfcAKva8ZIjaxJIXGWG1Uu2pve1FGhz5tVHcRT6fAR+xYimq+J9gUXq8l
         W5m1nbf1D4ea3KlVooEapmxX1fUvK+2dGFPV02RPdOHYYJdo//pqioOlAUsnsHBvP41e
         pusO0o4i8aY3jqDLeWa2BLrZX4XYZsRGB9yK/ivp5vLTkCfMaBjryGK1slx0fYR6we+C
         DJZ7Nbx766HQMMwijexxcRIQOjjz7QKTMhC02T3ctOpelRz3axSdOVXFe4Oo9aNrm2eh
         RFhw==
X-Gm-Message-State: AOJu0YwJlYqoeYTd/x5kjVQ87dhUTjWWXFdawxBTYey/mXCIt7mh17Ts
	fasW1pwW8ssAtX2wTJCrSbAW2mVjY16DqLaiHu3NZaP4tWB+TQhzP8sA6LujZj2jIJgMdikiPfV
	NyFJiRIcBieM9j9EJpgZKFdhgQS1UY45FurQGrXQ0xAS9guQ2aHbWZ1gY6tQCRw==
X-Gm-Gg: ASbGncsXa6FanRzDmG+FA5Txzdj0JnAksD68UvTkTa2jv/laAJq6V4/HxcS1Xz3BipD
	H7R8+sKi/Vjo3U8BWEDYqxR6siFf3sMRi7Wi4y2PtvVUNfynbjyLRSlXLL1Uhz0Fxm7TasaDZQJ
	fvjk6A8Z2cK42R5+YRuFIRTiz9Iv9G6eORhl4v4db6jLGcGMy3t/jKdUeK6fj4JSiajWmMGl1pT
	JOzuo/jYmONPZ4WahW252Qfm2y4ZqPcqkFXQf3ILwJSBE6UdU37twd6xKZuzzoiR0sKATHiww==
X-Received: by 2002:a05:6214:b65:b0:6d1:74d4:4ba2 with SMTP id 6a1803df08f44-6d43778e4a0mr103045326d6.9.1732179641627;
        Thu, 21 Nov 2024 01:00:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdmy2H9pW5POPHqGGAxMcBpXXjXeyFHS9b0AAyNbf4MGFLMnDsHCORTEYORJXQ6zeWUALLNg==
X-Received: by 2002:a05:6214:b65:b0:6d1:74d4:4ba2 with SMTP id 6a1803df08f44-6d43778e4a0mr103044906d6.9.1732179641249;
        Thu, 21 Nov 2024 01:00:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812c8ffsm20484906d6.91.2024.11.21.01.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:00:40 -0800 (PST)
Message-ID: <22595a95-e4e9-4aeb-905c-ad928c5fad58@redhat.com>
Date: Thu, 21 Nov 2024 10:00:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/21] net:yt6801: Add Motorcomm yt6801 PCIe
 driver
To: Frank Sae <Frank.Sae@motor-comm.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 11:56, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> and adding yt6801 ethernet driver entry in MAINTAINERS file.
> 
> YT6801 integrates a YT8531S phy.

Please have a better read to the process documentation and specifically at:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L14

before your next submission.

Additionally:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle





