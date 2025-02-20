Return-Path: <netdev+bounces-168081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1632A3D498
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F147189C992
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501021EDA20;
	Thu, 20 Feb 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib8PSn2n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53DF1EA7ED
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043447; cv=none; b=bWU0RiPPJPCNDTmjiWaAdFO9bqp67wNJkca1T/MpwlWkr0crdStaVIkGOip8EkF8YLe1oCh8zWB20gvfWTlV2/Xin5vnlL1ICu91UeHVk85G2tTdvJfHRXrPsEOVJinET6aRDc4NZxCBDfxQfhi4+IuFBCul8KEIrYquf0pTB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043447; c=relaxed/simple;
	bh=a3+Uw5nVO+cw7ntRiZGpf+zboyTLjMdXzQPtLUgoPq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQhhHSqHqNcFYt/FIqMXKcLQT/m9x3rQrjALSlZC4a88F9Br02mdnj2k6fnfwwNYDVXit3SXQdlgZnm0qw2rqQslz93dN2XenicRC80aaSK9g1x2A+OPGIxpVbYGzw51l/cp9V2nthdoBJILSZuUBFjpKL5bCrAb9U0lxg2z4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ib8PSn2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740043444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzqj336A1rXg1HGlLKXDNm3cA/qnoePyfzqLG4eld78=;
	b=Ib8PSn2nhFbixcNjZhNjwbTaXWjrYzrPpBCJE03mZpYFmbV2P9y2RbUhQMCQNCIkrm3jOB
	xKLfR5g8adN1ElmcJWyNqeu5xupYyISs5m+8+s1Rqnwp0pjyMLpyGpXgfofmNug0liKorV
	n9wbVeJgnkpF9vLf16NbSqzkazCys/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-Ge1WDv_3MGeU_oB-JNA0Wg-1; Thu, 20 Feb 2025 04:24:02 -0500
X-MC-Unique: Ge1WDv_3MGeU_oB-JNA0Wg-1
X-Mimecast-MFC-AGG-ID: Ge1WDv_3MGeU_oB-JNA0Wg_1740043441
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so3290705e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 01:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043441; x=1740648241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzqj336A1rXg1HGlLKXDNm3cA/qnoePyfzqLG4eld78=;
        b=MgIUbXjzfcJXEDEdmp9zW0s25ACU+gAgKDSm6si4TZa5w+NaY5AnIsAZWlTtHdL/MZ
         dO90SjoOpjVk0Z8rgSUX2SxhWezwksxwfqPyDfo9wwgJtChk5bX6xTklaPuHigqWtp3t
         HnrCZz46LQYnuXH6epFwQZpDiu7awjTUvsCXcn54kgxhkfKBmQH31lud0ReIOH4I3lkC
         RwYBkpG87K0fkxfcHzm/xB2DWCp/9SZIkf4Iaj6IfZFFzY4Z+WuuJiWsK6F0yQMM2x/7
         bJ2SaAstz1sgAiSbQALZYwRQCDJwWf2gHlpCuJeuyygmvqBeIKgwII1o0IBCl52lPpyX
         BWTg==
X-Forwarded-Encrypted: i=1; AJvYcCWm7wUklMTu2UHlduEyMlJBoxFcqfKreQJ2R+pPwi7v8M/xaIU5sHi7T8JpdEAKo6E/nL2fl8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVMOyQiPPIvbx0QAaCVdiFb+dU/hNPoG+kc7kqlItUfxZKU/1
	rwkgJkGIM9g3hEWyMNnrF5W19YFdsbKF+ThDQQ3bvBeXAjXscWZB0guOS1T4Fy6M50ClAqWH8r/
	3cvcjWT12f5rp6f+EsE9Gh7x5c/FK10hloHsBbrmGxMPcrt+Ruih4Qg==
X-Gm-Gg: ASbGncu75oj8gSDt8kP7uVMIVAOfRR7ML7WHeqn4smV02OaX2FGYjYz8tZ4KqQFy94B
	K+2aeJ7H8ap0j6E9bda7tg/hbJqcwBtQy6BGfb/aF5xQWxuSq93EYOZPUOEGa2BbejpohRrNqZV
	jtkfLHqusxWR3Yh7NorFRmd6en+VyWSTMZh7wQmhcpzYV15lDwlPh/P7DpT1Y82rZE9IU1MGfI4
	kftFa3Kd6oT8ybWVNgoDZXaJXeGT26iZvvUbbIE8byh5tDGuwlnYHMD7b2F8wGt5Axn374sN40L
	zCDkJTpD5bKcaL0Er9MPbe8HFnPdGDY31BE=
X-Received: by 2002:a5d:59ac:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-38f3e3931demr16440047f8f.43.1740043441178;
        Thu, 20 Feb 2025 01:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXL3ai8YtSaeWY+YHH0xkK64FUIXlC+iWZe4227svZ8Bilgl6lzjsdOhfHv1/5wwtY5FCP0Q==
X-Received: by 2002:a5d:59ac:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-38f3e3931demr16439927f8f.43.1740043440607;
        Thu, 20 Feb 2025 01:24:00 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm5459947f8f.21.2025.02.20.01.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:24:00 -0800 (PST)
Message-ID: <fdf36ae8-10bc-44d8-94c0-b793b84b94f1@redhat.com>
Date: Thu, 20 Feb 2025 10:23:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/12] pull-request: can-next 2025-02-19
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20250219113354.529611-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/19/25 12:21 PM, Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 12 patches for net-next/master.

Just FYI, since a little time, the name of the net and net-next trees
main branch is indeed 'main' - to better fit the inclusive language
guidelines.

Cheers,

Paolo


