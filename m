Return-Path: <netdev+bounces-153277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F49F7881
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275D7163914
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF182206B1;
	Thu, 19 Dec 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMDqkKzg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778C149DF4
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600566; cv=none; b=hxDeVMjohoItLMhNyZuKpB6A+Z5MV8o+CqxLiwO8FJZdjiLj5GYrAB+Ehs3Ck2Sx9fjFRgecmD7oA7osEhedPFNoN5x9i7AkcG5L7MqbJkkWjIbfxKmk93rJcdxa/EFt3g6bH2Qb/95wp/Xq29AnZpTOKqj5ScIrvJH24ue1MHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600566; c=relaxed/simple;
	bh=eopNegyaC/qufpevVVd1YPVYD0n33SWau56z0iy2CAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDhG205HdZkuBXXdgLPzcoJDk87KTwPpe+FTOQXTqCyMVdWsItl+eh8zwgW/7jHZ5FKPeQyKUGr1UUA4/PURb8SeSPdITSvNzaCNKwUaxtgpBgIPfGvZ46fYhFkCGBVffCyp3NbWu6VdzPZNsbVYEKy841p+ZqpnFj64j1Tn7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMDqkKzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734600563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSx9e7rMMrvzpaM1ZT2/eBJ4H/q4UwR2i9GEPzEKZF0=;
	b=UMDqkKzgHt9fTQsnAzOdTRgn3TmVsv5ldcchQ2zfVMM8wUimSAH8blu4jol5pD4Rle97Sh
	UEHOF7jUSPBw5zWj6kZI5dgDUF+0ahrG6aV+J1yGUtea2A6TThvJyFzQDUJzofpQl8n1TL
	73jFV0sVJ/7KgkHz/lnX7DHU/DxjfmE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-MlL_AmEIOVGBpXzjJWRYqA-1; Thu, 19 Dec 2024 04:29:22 -0500
X-MC-Unique: MlL_AmEIOVGBpXzjJWRYqA-1
X-Mimecast-MFC-AGG-ID: MlL_AmEIOVGBpXzjJWRYqA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso3242295e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734600560; x=1735205360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSx9e7rMMrvzpaM1ZT2/eBJ4H/q4UwR2i9GEPzEKZF0=;
        b=UWIY1bEXj8YT88+3yu/J+oPy5rfp8tcUagBcaCr6ttwgFvdCahPFmguPpMyRZARayK
         BOsLvfmy9xqpVp2eLimR2SMwRoXyFsWcKJHDoiAMxtnUcRyehy56ZEQqlikyhlH1DyKR
         6FMqQV06DoLsVLL8WQYeD+1GPmXHicoc6R85+k1OJiCEcL81xSCI9802D8jmgf8SK1Pj
         kHvkcCMql/c1ZVXyGizwpckzXMuT6TCmk6GpAbpo6T7ccE3+tYIG9k8pzwXtxTxcQqBP
         Krl4gjDoHiAPupnI+7TifZoUBF5Q3hVot4LqnocTnsG07Ag1A32WyPprF3zW5ECK1oLl
         EpYA==
X-Gm-Message-State: AOJu0YzcHSVCbghHUE0P2Slyag0Kiseun4Ao+3gaLITXIluB1gsYStxX
	fKU2D8kQKpG/suaR4a3kp5uvnYQBHcyleidtKKjIBl2+pldXGDzE90ML7GSEAK8qeW2LxOqjwa1
	99IfTe+ek7bPL95UiPx9C+GBoWQj6LXotXzb4gRoin+Iey0Z9110JKJa8evV72UJ1
X-Gm-Gg: ASbGncsp1Q3e6YgwaBwSYZMe/lO41Ilq8BC1OHy0CYRzGWmD9gmdd9IuB2Qr8Zuw1xv
	jJK/wZehrBODC3bl/1TGUdg+lLkzYWUSTFTdSkE30l7zPquoa+IA2Xs+uwUywXOi2j+4wiHLnNO
	C1bcNptt0Zz6hQLd5Y02Gi8UNH4qCuanzeFyt2mWLwU/ogFtPLPyhkPqO2JCIQnPcLxiT2tCyon
	/Hxv1ndxZGc2lgjcuoLPrphEMvABsS03zRYOsW9vTzSNGkRpd5lB6aS2ao8NWeTXqOOWzwciSAM
	TpY3v9rlMhsB44KnjIRnZ/B0TDfMe3zX
X-Received: by 2002:a05:600c:470b:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-43655345304mr52697795e9.4.1734600560541;
        Thu, 19 Dec 2024 01:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5dIb0vTUNKu59GS4aN90C7izRGPkV/7YVa0eB8On3UUaJ6rsHrpOufiMNUiJBEeEVAT1GMA==
X-Received: by 2002:a05:600c:470b:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-43655345304mr52697385e9.4.1734600559883;
        Thu, 19 Dec 2024 01:29:19 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4471bsm46511405e9.44.2024.12.19.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 01:29:19 -0800 (PST)
Date: Thu, 19 Dec 2024 10:29:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/7] vsock/test: Adapt
 send_byte()/recv_byte() to handle MSG_ZEROCOPY
Message-ID: <hpe54soa2ltn7givmtvrkv2exommhn377bruyrfilts27qot2a@a6ksxyhm7zoj>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
 <8f1536c6-480d-4973-8fa8-ad94e6cb15dd@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f1536c6-480d-4973-8fa8-ad94e6cb15dd@rbox.co>

On Thu, Dec 19, 2024 at 10:19:56AM +0100, Michal Luczaj wrote:
>On 12/18/24 15:32, Michal Luczaj wrote:
>> For a zercopy send(), buffer (always byte 'A') needs to be preserved (thus
>        ^^^^^^^
>
>And this is how I've learnt how checkpatch's spellcheck works.
>Should I resend with this typo fixed?

I think it depends more on you than on me :-)

If you want to send a v4, I don't think there's any problem, just bring 
all my R-b's with them, so the net maintainers will merge it directly.

FYI I will be off from tomorrow afternoon until and including Jan. 6.

Thanks,
Stefano


