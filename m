Return-Path: <netdev+bounces-116162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC6949543
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2731F267BD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB263A267;
	Tue,  6 Aug 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzELewlD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368527466
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960460; cv=none; b=D57cHI9dcFVlDLSPJzOjqp8SEccCuJjoz3+1VdzDsrDnHNVkYKSMwC7oW94VLYoIXdf2mR4zOx+KAEvpVwE4izNfbMd5sDsBh67RCBzS6kGEdxLqvj+znw8QOSF3CiAjGR1keSD4sLqPAqkt+jzVzEgnGSw1CtxJWC3GiLwSx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960460; c=relaxed/simple;
	bh=UDWWmRE+xMMUUJ/1cLaONknX2wree4fqwDyz4S4KReY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hHyKFJaNY7xmV0FgLvhO5mmi+rJFMBdjpLghZ8wIzbE66oJXY5iTBzQiCOu7Ozl49EJxY6ZaxdyQD9BlpCmrGEBThm7WyGQUbO7KpWqJ7ZXuGs+nAidhGbsw/W0aSzWtafthKzPTpQiksqz5ynZKtdLeD9DUiPvEb+pKkJ0Gznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzELewlD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f149845fbaso9179991fa.3
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722960456; x=1723565256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA7vzvBPHn9h+tl0kUbpv8e+uf0r/+Ug8uEBTZW7ZeY=;
        b=ZzELewlD9OeCm1GWthFLAbnGqmOE1bZ2dbSitP5JqE8WC1M+Wu07YpAP85xz2odYJf
         MAM7cbEyQw+5nUGzZo+iBdUGYADMGQHSMsdyfslvX1Nz2lSDb2mXxutpLUHgQ6k+zvD7
         HiQbep5lxtDjYPVvOq1Ey3xmD0mGkpayi9We78KbEGbhiBqFKtO99nNJW5NGYmycsj3D
         sH/qD/MbuFnNFFi9vuaLJpRLETvp2rktCmZ0Wh0VGy/5gsjcoy2fptrDWETV3syQh//P
         epKo/Ct9BHdYTexzddEn62KMJPBZt6WKFaBmztSk8Xt2g1PZY+soSnJgGI6ONeVm39p3
         PwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960456; x=1723565256;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA7vzvBPHn9h+tl0kUbpv8e+uf0r/+Ug8uEBTZW7ZeY=;
        b=Yk7/BiQYKNzVJJqnFPusC3x+XXp0CV6L68N11iyLZBvLVPoXas9RTM5tyHXgxoGsf/
         QrfaNU7H24HPHRd0EBs4ZMzDX6qOhIpOuOJ25uS1pI3cOJzhjjig+pnDr8hxY6TmLtA9
         jiWgeShv+cv4Ud/hC+Iu1fpaz1X3wOlOIkJKNr3ojc+BZ/gXUl1kXcLRiXi5P7F3/GSs
         AbPN/RjFA/1HT+Ww+3Dv0iVB0eFv74XQgrOuHbRx5JUUIObX2szXOFU93xXBHNBPWvWD
         pgYDhVdMZbiJJovssEMsezfCIOXDtjak/tg7VVu0oHnab/gE1AdSWBPJb8AvMq7VfOl0
         PgDQ==
X-Gm-Message-State: AOJu0YzBr+O6wYwH0otElcQ/lwHMb5ADds2gdRDxVEvZ2lBJkxodKjvo
	NdIYKojY2D88EKgAI9wFpV2Qv7g4aS2NMP3E7j7Nsp/H/QRC3PaaJn6MPQ==
X-Google-Smtp-Source: AGHT+IGpvrcWEi5tc5C8Kux/42Lsg98Mxxcoj75P9Ba7dKXlS76mWYG36+9llMU04uP2EUO4xrGn3A==
X-Received: by 2002:a2e:6a12:0:b0:2ef:290e:4a2b with SMTP id 38308e7fff4ca-2f15aaf64a8mr106745881fa.38.1722960456109;
        Tue, 06 Aug 2024 09:07:36 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a878sm250139385e9.8.2024.08.06.09.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:07:35 -0700 (PDT)
Subject: Re: [PATCH net] net: ethtool: fix off-by-one error in max RSS context
 IDs
To: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20240806160126.551306-1-edward.cree@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <242fd732-0962-ef5e-a3fc-fe8007a521f9@gmail.com>
Date: Tue, 6 Aug 2024 17:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806160126.551306-1-edward.cree@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/08/2024 17:01, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Both ethtool_ops.rxfh_max_context_id and the default value used when
>  it's not specified are supposed to be exclusive maxima (the former
>  is documented as such; the latter, U32_MAX, cannot be used as an ID
>  since it equals ETH_RXFH_CONTEXT_ALLOC), but xa_alloc() expects an
>  inclusive maximum.
> Subtract one from 'limit' to produce an inclusive maximum, and pass
>  that to xa_alloc().  Special-case limit==0 to avoid overflow.
> 
> Fixes: 6603754cd914 ("net: ethtool: let the core choose RSS context IDs")

Whoops, that should have been
Fixes: 847a8ab18676 ("net: ethtool: let the core choose RSS context IDs")

