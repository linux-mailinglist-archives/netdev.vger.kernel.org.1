Return-Path: <netdev+bounces-146612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81F9D48E4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D232821A5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840C18660C;
	Thu, 21 Nov 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJTfxSDu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA8146A6B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177960; cv=none; b=Oor50+oJ3+PFaMF4cFWJyzgIj23hB/aD/OEafomLlH+I9oBYfgYh+3lXroVxUWKuCsz5Jwqf+N745gtcHzlpRnuHsr30vaiSpUfVaRWKVSW7VhAYqGcC4JRELq6d4yH/7c0v5peVhswOC6AyzrZZYyGJ3o5GhiKelOQCLyAEtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177960; c=relaxed/simple;
	bh=4iiaUOGz93H1S4cgbsdyBLjhynmeCThSmYSKF4EHkCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+kNn61zodlkCHN9uF446NG7fQM842nj0WBwkBRMJ8/jZ8NT6Cpb/TxbUpalw6PntXgzhF8jqdX/0mk1AT9Y1OxKYHs3vUPSEeCAf7FEjs8aGsObyxdQxhQ8L9C0alJ8gyTOe9spnF0Gfxag/KGnQifGaD7ngjOl1elvp5r8cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJTfxSDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732177957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HS64kzGMgc1claFltF2m+ECVBO0rJ10VKJs9lIo19g=;
	b=GJTfxSDufpV3RUIpATrb4qmJ6iM4cj9WCt7I7PETGSFOFxsmnI2xrsFRKN9cR24Cfs3WoG
	4PfbFLG1g4/5J7HOheK+ZS8QlSOcaWbaWo+1oXRn9x9w6sHSU73Qohm9HRBbubjBery4TU
	0obG/VECTQ5ZFgdGOnSy1zQpuSFqBys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-c5XHgYsgMly4YOEEwOIPnQ-1; Thu, 21 Nov 2024 03:32:36 -0500
X-MC-Unique: c5XHgYsgMly4YOEEwOIPnQ-1
X-Mimecast-MFC-AGG-ID: c5XHgYsgMly4YOEEwOIPnQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3825a721afaso337606f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177955; x=1732782755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HS64kzGMgc1claFltF2m+ECVBO0rJ10VKJs9lIo19g=;
        b=EfV1I/LMah07kWFT2WUlsjmJTHtTQXZtnVFKYVXTSxNxW/ArBDC54UnDuKePyN/Cn0
         E9FRFIbksaE5M/PUVhCO/hlNhyExV1sIONbeLdRkIdXiKRysJvs5KEKo1QjdASrcFvv8
         MA50QUng/kKcU+DTBB9XVVSaNJiauy+qlzXFjMkKIigzqRxfDizjSdNijiuLZo6LzAxj
         JJJ7pUXsl3Rn+82c1S2MpZLNqs9RHCI/Yc+45qsRyngv7tO7nET2Kk2PWWsLu7pa5/ZS
         VY3/NHNwqkUYRxMxEN5DupPt0OwIaKKmK5Hj5mYaHG03AV3JsQlPYJiMkASH6yF0D4F2
         LYXQ==
X-Gm-Message-State: AOJu0YxXOrjXuLYEBhIEgJYYiheB2GesK3Zz7o9OOkQ3ydC5JvTe8FyX
	0YrRqL+tYMCz2jKEKOqs5b8IVhpE8dNQq5D8mXxl8NEqUEWo0pXObG2SPUue8qW2WrIcijaBIyu
	xu4E8JUSHN8rmIW5jPO20GDzIeBgOKN8KheUayAOWYO03zOaAO0NTWA==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4473332f8f.37.1732177954721;
        Thu, 21 Nov 2024 00:32:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyAxoVi5AJMaLr3M68ylpafmrXYb/zD7xYmNLoDBfil0ANpkK0cFGXI6Zn2wRYRaXjZESpdw==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4473317f8f.37.1732177954372;
        Thu, 21 Nov 2024 00:32:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107b1sm4256414f8f.49.2024.11.21.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:32:33 -0800 (PST)
Message-ID: <82730046-d2cd-4766-b53b-ba40cb6f1bb2@redhat.com>
Date: Thu, 21 Nov 2024 09:32:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
To: Cong Yi <yicong.srfy@foxmail.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cong Yi <yicong@kylinos.cn>
References: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 07:27, Cong Yi wrote:
> From: Cong Yi <yicong@kylinos.cn>
> 
> After the support of PCS state machine, phylink and pcs two
> unrelated state enum definitions are put together, which brings
> some confusion to code reading.
> 
> This patch defines the two separately.
> 
> Signed-off-by: Cong Yi <yicong@kylinos.cn>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle






