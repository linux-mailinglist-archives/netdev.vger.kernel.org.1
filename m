Return-Path: <netdev+bounces-73002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC985A9C7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D8C1F2198A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1441C9D;
	Mon, 19 Feb 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bpl+SWr5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A6446A9
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363160; cv=none; b=pGypNk30y1bh/VGbm5wSxS/H8UGRLaq6u2vez3DebbR+hXkuMx+d/H3u70bjU5SAd2dlEaeu+fb+Zrza4zl8JdoF6uaLdISW9dAZsyFV6hZUaGKg+5eEiKzg8omSHpdT6GdhvplSPGqEj+vikjbxV5jzs53vvtwIVaDlDUhblSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363160; c=relaxed/simple;
	bh=VzfMPkf9ob96OklMZ48DldYQOLj4cY1U2wP/ZiWUKhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9gTdbh084slzxLASMKAZvJRudA5ojsh5zdKo9HwYe9tkETSp7Ln1jy41+cuh8rTgCTINgG72l6FjjeatgGFLOYN9wbKKjxlxhnJMg7BqgOeBWFBTmPdz1TwnWiqz5lMScHrkrCBYoi4sBvggVO6M0jIkLmfSRG1YI1ZkpUtrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bpl+SWr5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso24520155e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708363157; x=1708967957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=55PXyggjDkk5+PTXj9b+sqJNLMYJC/zyHBnEuQI/qWk=;
        b=bpl+SWr5+WUcMWXcBs0MXeYanS0zLVQxfOlayYw3FJuiUhP9pnNpTrnuOKvQDXGlPF
         jIMlGNqUMzmAR2QTJSy56rQpVu2TK0KDs7RvOd6hCIQ2YF5eJtyml9DW4XaREn6VW9cf
         NiwklcKsBt8b9QCb9ZJbiPGmnZb2lltgiLrP0yfXiRBTSMnEl9xHwU1Enir8Byd2LWaY
         q/ubVxVV2N7zaioMj5ozyZzLnyYwDWtgMWuC/f8v0BuJP8f6jbrMDWLi2b2knbrGavvf
         X2B7gHVffO0bJGf2jUIF5pX5Lv2j1nX34dgQ0sAwUlzTIjf6X06ZaK6VU4yn0XDf4eBb
         nVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363157; x=1708967957;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55PXyggjDkk5+PTXj9b+sqJNLMYJC/zyHBnEuQI/qWk=;
        b=X10lrmDjiy5ula1Ch21EnKw37ChLbukOxpcA9o0WC2MlobEETIRHy4T3Y0FDuQgQ1+
         g5vbbdO1PDtfxhrnRSM28Al7j+vvXVvT1eSi4q761PjollbHTyca1SFNmBSSyOvAoiXM
         q4PrCPTFuMWOEH3ueyJbQF27S0cao6gzhFF3Xg5VOyiOQxuGHgmgARwOLqD22IYgA6WD
         EoFuvu0g+AAWqr12nk8IVJhGyFrxKWa8BaM9XBpvDdxuuWpFwsooNellV5AJUbRwgpqf
         +tEdZLKR/iLpsP3hhAfLVT42nxdTECp7E7gIJiKXf+lnlFXVXJq1NekhOiM1QlM29Iwr
         lieg==
X-Gm-Message-State: AOJu0YyMXqoL/Z1rL8yq9QaYCPdtoNBcJKHt2AA3bmrcrKYNn88/InBf
	LMhpbTXgYULwpVI1Q2OAU4uqbLWA5DvU3y02RuavFo61vlpr7A5zloI7TXook9I=
X-Google-Smtp-Source: AGHT+IE0FDoZGQjvqLminoH+s9f2esvfXelJI1ORcRZugMD+UJm6mjZPlEX0lBtgMtXNoJiWfbr0QQ==
X-Received: by 2002:a05:6000:1563:b0:33d:608b:c470 with SMTP id 3-20020a056000156300b0033d608bc470mr1340451wrz.21.1708363157073;
        Mon, 19 Feb 2024 09:19:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:31d5:8fa3:ed75:9794? ([2a01:e0a:b41:c160:31d5:8fa3:ed75:9794])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b0033d449f5f65sm5213087wrb.4.2024.02.19.09.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 09:19:16 -0800 (PST)
Message-ID: <e0ee6c07-aaf1-4ed6-8c7f-3db772652f16@6wind.com>
Date: Mon, 19 Feb 2024 18:19:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 3/3] tools: ynl: don't leak mcast_groups on init error
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 chuck.lever@oracle.com, jiri@resnulli.us, willemb@google.com
References: <20240217001742.2466993-1-kuba@kernel.org>
 <20240217001742.2466993-4-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240217001742.2466993-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/02/2024 à 01:17, Jakub Kicinski a écrit :
> Make sure to free the already-parsed mcast_groups if
> we don't get an ack from the kernel when reading family info.
> This is part of the ynl_sock_create() error path, so we won't
> get a call to ynl_sock_destroy() to free them later.
> 
> Fixes: 86878f14d71a ("tools: ynl: user space helpers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

