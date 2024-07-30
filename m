Return-Path: <netdev+bounces-114042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16AC940C60
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51097B2878A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0C19307F;
	Tue, 30 Jul 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMR9MnSL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91612F5B3
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329609; cv=none; b=BhU7lFFysl37+jxgfvcjFznq4zNQDyve51NnMey1a7v/zVgRz46OCgplrFa50V879zDls2WRFnbrMneEO+YqaWUirOtT+nnfumf3irXGzYKmIAwcJpziTXscC8oy3ZdnAzbnvxmF2GSob6TykwXuSYijheVWp2TxEewhiTIJ7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329609; c=relaxed/simple;
	bh=+Qw8W9JXBVK2KYNrBUnkVpFmWeK8eGoS0fvOLwMjbCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmgMNAwd7T36melCBKLkr846+E8ApCvnMix/fBqu9ZlNL8+vlKiMiHSdH14EXlZD+IwcLhrwGHald245J6alDxo7CjZpzLIr4XdRHkvuueWSZcevfhA6Qqr2TG8SujXQVhoDwWwFsTw/GpW7bEi++KOCkUnZww5suIgj/+kCbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMR9MnSL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722329606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnacwdNXQeiYAN/vyHCjqJ3Z55j/qGrBpNl88GFWc6Q=;
	b=HMR9MnSL558lQthRx90HhO9FG1b42FIC1hmGhxXXWAPR5x6ybci2cqWTL19xge7g8cYxmw
	myscL71aKdEAY87yYTG5P8+8s9X+b+E3bUn4CFRxzVZ2UMU6m6n+EdXXfjqT1ubgnrL1Dl
	ouY83e5lcWdxbmYucxJnOW5Gf4YJ9ms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-qnVo_YjkMAOyvnkzytIuEw-1; Tue, 30 Jul 2024 04:53:23 -0400
X-MC-Unique: qnVo_YjkMAOyvnkzytIuEw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f31c668so6045865e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329602; x=1722934402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnacwdNXQeiYAN/vyHCjqJ3Z55j/qGrBpNl88GFWc6Q=;
        b=dLeBto9qqeqCIF5YzRSHg8UwCCRwTUOcj3PCADRClTmssdRg46fC7Uq6qC2NNw1p35
         RwjJVgwZVcmacQCRdIoDJSZumuACjCy7CgomZUngyCVGDnVz97omNrIvwGSvbI70l2aA
         zu/Q6WjgXh8eSvTppb5V0uF33vSBoq2F4hT0lS7QO7/y7ptG4zj4fe7TIbA3vx8hjHUZ
         i1zfJapFbJXvzIA384x+IIK0nd+SLwUuBNwphTrniyaottwIaZyou3Xj9MfiRRFsp3AF
         zjKf9y5xe2g+vKUXf5NHY86tqgn5Jm+kS25H25XEpTmUPUk+/onfCc+CoFAbsYYBpIOr
         48+A==
X-Forwarded-Encrypted: i=1; AJvYcCVRLuy26/V0/v/ZFzUO/7mM56+IYEAeWOBN8QYcpn/KjhnXsZ3T13ThMWwjGPCvSb+II3NSLF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOeTT+3Ui/fUIMoAJ2R5wawnu7FErPH0+roj/D7mD8a7ohwoq
	/RmgskaJQf11duCIS9xg0j5gzhRnugFGKF1kZfdIini9epRSmLueXov5wp031FBz5AqvrxaNgiK
	+0L3cc12tgoxq5lHeMW+G4qjGXQIOqNhAdJROGDPnn7WR302wMbwx2w==
X-Received: by 2002:a05:600c:4fc2:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-42805713af0mr69580145e9.6.1722329601925;
        Tue, 30 Jul 2024 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5skEumfC7OwYco+fwnLjIRX5mFiP+wG2g0HwUfV8HU5TLSTPaOIm8pjlpNbR0ZWFSuDj1w==
X-Received: by 2002:a05:600c:4fc2:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-42805713af0mr69579945e9.6.1722329601387;
        Tue, 30 Jul 2024 01:53:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428089c28f0sm191284215e9.28.2024.07.30.01.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:53:20 -0700 (PDT)
Message-ID: <738f69e6-1e8d-4acc-adfa-9592505723fe@redhat.com>
Date: Tue, 30 Jul 2024 10:53:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
To: Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
 <20240729190634.33c50e2a@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240729190634.33c50e2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:06, Jakub Kicinski wrote:
> On Mon, 29 Jul 2024 00:00:23 +0100 Daniel Golle wrote:
>> Clocks for SerDes and PHY are going to be handled by standalone drivers
>> for each of those hardware components. Drop them from the Ethernet driver.
>>
>> The clocks which are being removed for this patch are responsible for
>> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
>> anyway not yet supported. Hence backwards compatibility is not an issue.
> 
> What user visible issue is it fixing, then?

Indeed this looks like more a cleanup than a fix. @Daniel why net-next 
without fixes tag is not a suitable target here?

Thanks!

Paolo


