Return-Path: <netdev+bounces-120112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51F958560
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097D5B22CA4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B918D625;
	Tue, 20 Aug 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Ln0aCX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481B18C020
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151878; cv=none; b=M90n7TbeGlrOTL77jgk+b7dL3hstEXYIf35nhGObrjTOf4ZV4oW1veJ8dadPhGL07SXBMEKVRdktHCTiHurtstb1Oy/cfitbwXe7VovTxyNcU3x95QhKptLrmVe2LP4S9NSF63M+98TaCFZkJat73xkrmg/Hgzev9QRRzLLI1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151878; c=relaxed/simple;
	bh=14bfwB8I4A9Gc7sKfVRW208/c8s+Ns66Xn+NWCQUnZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puTshJNtSJ+Udu9UV+gEK6/IQTgXHi1NkMakF0i2sfTQE/os2OOF3qbpODNzMQV0gT4P9Lok6KpQQBejHkzVASkzLmg+3xcn7eIiiO9vmWKI4uVVs4WSOH23Gq+VhHGythVAriImre8k48Ly8T8xyEgr64UjFBvnftneYxMpGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9Ln0aCX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724151875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6PGBPw0FL13SJbdnlSXI2jV9MiQK34AZDi4iKAI8MA=;
	b=Y9Ln0aCXT9Gr8kH4J5C48NntByWGzseQezY8adMfWJBOil43MqXsmJN2ZlU9pEGNd8PVGs
	+O8cP71j3yeNYloGP2U66bHcjVRRdSHPWqMVmgbzOfRklKn2/0GxhcqpxZ5FD/466qyEVi
	+9SgdP5DB0Lh6lnrcUBLMev2KN9Cb34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Mi3GuXJXNZa7lg2qvE-Qkw-1; Tue, 20 Aug 2024 07:04:34 -0400
X-MC-Unique: Mi3GuXJXNZa7lg2qvE-Qkw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429e937ed37so9283605e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151873; x=1724756673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6PGBPw0FL13SJbdnlSXI2jV9MiQK34AZDi4iKAI8MA=;
        b=hfJ+8mswGzermDlV+Be37ZLdcI1yEczFZ/LrkANJIZI6Yu7bP2mg0Fd9fTiALFiGI1
         /wRlWUXpmcsWWaIFOgvyg2u+FxpHtb390oWb0DzsGWJIIGdxyNKVsD96SLnAbpEGuDO9
         kHpZv91dt8buet4hF8YSbOA/EY3Nj/JUJAzzIVSoEA+tRVTQj2RaN2b74sfx1ZoXD8r8
         54iCB0ge4mMTQ/jn9u2pBhYqYMhukaAgzpRfoe7QQrs7e/XMOD6go7mf0jb0kLmc07M6
         NozO8yE9KPyNkl92q2xZzPhMGBcyjG2h8GRv7KojFaz1FPT4CcBmM8nJhtrocUsb9w12
         gq5g==
X-Gm-Message-State: AOJu0YzP7CshcuZvVvPCFsumoo6wWcBHaQmGoibX0vOZQXx9TtZA0BJf
	aMdhDfK1lnE6DQ2fXDexVDVTPBd5PiB6JwjficIm1WH09EbdFCxHY2PgHGroxHSx9cpdF0lIAnz
	yf1rnFrwMWz6ZoLMANOZIBHg7fkY2qNBYDOwOINKVwje6TsBCY/4B/A==
X-Received: by 2002:a05:6000:184c:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-3719443d93amr5179850f8f.4.1724151873466;
        Tue, 20 Aug 2024 04:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBfSN7rcRCN6YaZHBe4c8eqWnpHNwpwMslPKUWNq/YZGBhF7jG7Dqv8btB84+yTdVIrFmoQw==
X-Received: by 2002:a05:6000:184c:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-3719443d93amr5179827f8f.4.1724151873004;
        Tue, 20 Aug 2024 04:04:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded720eesm192828645e9.33.2024.08.20.04.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 04:04:32 -0700 (PDT)
Message-ID: <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com>
Date: Tue, 20 Aug 2024 13:04:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Jade Dong <jadedong@tencent.com>
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815113745.6668-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 13:37, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> We found that one close-wait socket was reset by the other side
> which is beyond our expectation, 

I'm unsure if you should instead reconsider your expectation: what if 
the client application does:

shutdown(fd, SHUT_WR)
close(fd); // with unread data

?

Thanks,

Paolo


