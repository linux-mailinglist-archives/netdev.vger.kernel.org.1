Return-Path: <netdev+bounces-152243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016319F3349
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B8A1886C66
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C120627E;
	Mon, 16 Dec 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVzPfCbK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303720626F
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359595; cv=none; b=hgX+rIJFMu18nnThwoMVH/tqje2qnBKCCEcyZYeezk/bSFY99+cHUZAgQc3BAyI7icaJJ3VRlWctzGdLFd84kbJpppQcZzgExcfO3l/R59TgFIBPFwTYod+e2PUMgjlXCPjxGWjnBnb4i3QsnKo8A/J17K1aEVPwxt4yGv37r/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359595; c=relaxed/simple;
	bh=a8mbAfnSdWDP77b9eSs1tH2Gz4Nl5Fhhs/+pAyvhC7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuseuqZXLPUeVReD6vskgo+pLKul3302PcSyQ1AqCMEZR10Kya8J7lwjcW6QAxUg34IYMu6q/mWYgsT7QJvDM1K6PJKCRn+fI75cans7L1N/OxV6vid0qmK7hcNRdV8h7hnesGfdFdKbluy0581qo5qQqWQzfdHcxy4D3oCNUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVzPfCbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FKB+bLI/kkfm732jneV5KKgRtRgN6ZhGArdnX61CYE=;
	b=OVzPfCbKw23zHy7VG3Wgl6oSbBWPdr9UNuoxAQnMAIml30s2xHpBkKxDOqMheYdOmpr0Fp
	eqjUvIhrVxzuwDhEt5+WPzKtFKKI3fQX8xIKcHkBDbSFRyX0IepADCWiduqBQX0n7jM98L
	l1RJgP+A06EHiVQ63K8lZY2njNGkQ4E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-p2Hv0_SUNdOquObEkd2A-g-1; Mon, 16 Dec 2024 09:33:10 -0500
X-MC-Unique: p2Hv0_SUNdOquObEkd2A-g-1
X-Mimecast-MFC-AGG-ID: p2Hv0_SUNdOquObEkd2A-g
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e9fb0436so673745085a.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359590; x=1734964390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FKB+bLI/kkfm732jneV5KKgRtRgN6ZhGArdnX61CYE=;
        b=BlVJm3+ixsOT2mObTyDENkhCsGKdKS0VloeewLcqQuVTYBJtggsuKsPp2dAnVAX0X6
         AtOgRknCEPT52V6OenAjTV88tHOH4Y1qh3UKcaq+iD48CuP5+qfSUGhO53HgG7bN4wTv
         npqPecFf+nZgxFAnLC0AkTnvMZmFhsRXKzc0b5hrD2Ruzf28vi5K3xcsddXzWFyfroou
         1xGOJr6WyseriTzNdE8CbKxOwVnF34j6uj2c026LEcg7nOYXNGVqX6bg35Gb5/bnvdtl
         shaF3Ff5NhQf4MsMrezY4m/5GIESRwk0lER8HGKw7L3rP7jhRgvyrokeJPeswxu/o8kV
         jEhA==
X-Gm-Message-State: AOJu0Yw56tTlDFDksONdSBccHpnnc6oCW0mifzmnUxun186ikmyrCSGQ
	MX552nF19tOKVH7VHywmIiIwMC0dH/gC4DDEfLpff4X0hk/RBNcwN2F4/r4Z0c5BG2FeAL0e4ss
	5gWDT85HwdX3OZbLxb4d56knajfVwIyRHPel6XYx9GcQk7cD7//XuaA==
X-Gm-Gg: ASbGncvha8Uu11la+3JfUuARBge4MImp4hSOUYFI26otVdTuwgxkW4gF6nrmYNm+6Zm
	rrUBImgfiRphKwvW+qcv855jB44lnXmGWJPrmYDbUNcq5Ce6D1h91Fh11VRLAitywTvrBlZMnE/
	mp5DwFKE3Je6rtJy5JycPslN7SXwEc32bjuJEf1BdNUyxom8snW+0K8KXUXOetujoCPDXvpNxBr
	cWP74UDrbc+Cgyx3LaASFIbGISM+3rYnvsmLWVrTtpn/0/uH2amqWVTBUImJo/cQwObF0RAh9XE
	ndZkQHj4zGxrYJ2QKq5pZF/i/aE98PWv
X-Received: by 2002:a05:620a:a518:b0:7b7:142d:53c9 with SMTP id af79cd13be357-7b7142d56c0mr523083385a.53.1734359589964;
        Mon, 16 Dec 2024 06:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlR/cnO8WA57JYBMk3wH9+iCw30M2oNWmtb0izbh23NC2zr8stSQmy7a//R/vJDt1hKodhJg==
X-Received: by 2002:a05:620a:a518:b0:7b7:142d:53c9 with SMTP id af79cd13be357-7b7142d56c0mr523080985a.53.1734359589658;
        Mon, 16 Dec 2024 06:33:09 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048d0ea9sm228040085a.127.2024.12.16.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:33:09 -0800 (PST)
Date: Mon, 16 Dec 2024 15:33:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] vsock/test: Add README blurb about
 kmemleak usage
Message-ID: <sugkft67ys3oaqp2i3fuz5gwuwdd7a2wo6w7xpgkn274rxvdmy@pgpuek7gmbz6>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-3-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216-test-vsock-leaks-v2-3-55e1405742fc@rbox.co>

On Mon, Dec 16, 2024 at 01:00:59PM +0100, Michal Luczaj wrote:
>Document the suggested use of kmemleak for memory leak detection.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/README | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
>index 84ee217ba8eed8d18eebecc4dc81088934f76d8f..680ce666ceb56db986c8ad078573d774e6fecf18 100644
>--- a/tools/testing/vsock/README
>+++ b/tools/testing/vsock/README
>@@ -36,6 +36,21 @@ Invoke test binaries in both directions as follows:
>                        --control-port=1234 \
>                        --peer-cid=3
>
>+Some tests are designed to produce kernel memory leaks. Leaks detection,
>+however, is deferred to Kernel Memory Leak Detector. It is recommended to enable
>+kmemleak (CONFIG_DEBUG_KMEMLEAK=y) and explicitly trigger a scan after each test
>+suite run, e.g.
>+
>+  # echo clear > /sys/kernel/debug/kmemleak
>+  # $TEST_BINARY ...
>+  # echo "wait for any grace periods" && sleep 2
>+  # echo scan > /sys/kernel/debug/kmemleak
>+  # echo "wait for kmemleak" && sleep 5
>+  # echo scan > /sys/kernel/debug/kmemleak
>+  # cat /sys/kernel/debug/kmemleak
>+
>+For more information see Documentation/dev-tools/kmemleak.rst.
>+
> vsock_perf utility
> -------------------
> 'vsock_perf' is a simple tool to measure vsock performance. It works in
>
>-- 
>2.47.1
>


