Return-Path: <netdev+bounces-188343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBFAAC684
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEFD4A2C6E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46999280CCD;
	Tue,  6 May 2025 13:34:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993123D28F
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538490; cv=none; b=mhdgXo1kyPOwD3Ua7Xj/v2pG/x06McaNb5sH5aPdaZaGVMRnMidWQ+j47Tk10dNPpSWQv88M3Hntun/eRTo49Xoibl+04mrpb3HBtx8UlwH/B1/XZBMyb5d94WOzUFdyspn7hoEQQCTC13nyVnmpZNcQZx1I5a35AlQlo+8xKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538490; c=relaxed/simple;
	bh=OokJgCchqneXjWnsDj1Sjjodavmnvcl8YGWBPeqdGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHOrpp2iY4uVicdxtFgXXu4YWDhvODm+w9JU87JK5uJpbIHq+5sYGu5FAU3OsPgAPpy82nJAWMxCMEmP3BacecMQQT7gyhkdJe/CZn3Sy1HAbL1pChsnkt4Qe3KCZu3WPyBItkpsXh7QYCtFhjehx1uqXVBdJWlK834b3VLnDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso3382254f8f.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 06:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746538487; x=1747143287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OokJgCchqneXjWnsDj1Sjjodavmnvcl8YGWBPeqdGAU=;
        b=nsxvL8ZlpCvmxIw0WDaWoIeiJYGX4gs9oAVXbx4SQr17+hgIXR2uCMwPUZOz6czusI
         F9iunB2Z5KVMW6cUlAxmCiwcPzGJBJxiFHQ2u1DEuwSRJy5rt4H0jH+bUgKSbmCmFyjn
         duKP8YGp136CSoXR7MLlK+AIHVfzgV0Ia3YO2x/E2ndmbH84rWcA400W9INMRNlidCHP
         imrbOAp777lh4sBXWeLydqd/LqkWXWPAqF9hJJKTQRItDF1yV4TLbj9Cp5wakE6/IvKI
         YlnbSiHTEfmYKo/qt9WjctVXn1TfkvzUD8Fi1dhUtTl4txm4d+kV4kBHBrADlahhn2mY
         zw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMzN+4kaUKJZPiGBFF9xZGUqCO0APqAOVO56WeBVSPD6qfA1Atj00J/+LoObbi5CvsnwLjl2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsBYnVdzgslEGJbZPSH5Qh3vfz+mCJaWiNjnGLWBlup5PwZZf
	qhu/9BU12pxIjQ9d44d6/4Ahp07BXxoSzKONq/EYWawWmQCNS0VS
X-Gm-Gg: ASbGncswgOLu5LSR7CLAqyKy8YXxDu3v+zAA2JWFSMvuxyVBW71lpjJu8L+gH1aclja
	UT2wvxI9GM/sKNc14YGa+wvoplDzsRWAvk8Q87HPYoFSjUajLSQd6aQzZ5AJONk7cpA9WJTP72E
	MZj7jgm4zh7jpvOC5XNRGihZQzAyMvWnkbCVcbivYtn7JKEPDj8is4Ymr+VkzrR1KuVAZ38B0yv
	/6/b5L7FU/eqD8AplSlF1KfXY/3dGYB1eGsNtauYx4ij3pZD3HP37uY5ZlXfBJ3zRcpyHunMyvw
	qCziuP9qGXRBYHoGNhGpf5M4UF6M5gqdqYkvTR4IuXPzYVny9yvwhOq86ZcLoYCNrgFp3YDtCuH
	UoctgcQ==
X-Google-Smtp-Source: AGHT+IEJ+6S2l4dL1RILDCg3dr6TjbuXO50PqYFF3qxvwSVe0eMOFGzjp+ywvS/51U169tlJf2lZOQ==
X-Received: by 2002:a05:6000:2484:b0:3a0:8282:88e3 with SMTP id ffacd0b85a97d-3a0ab5a8bc0mr3252698f8f.27.1746538486332;
        Tue, 06 May 2025 06:34:46 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3cfbsm13502158f8f.40.2025.05.06.06.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:34:46 -0700 (PDT)
Message-ID: <4f1e9f1b-ace9-46d1-96bb-3a117d676c90@grimberg.me>
Date: Tue, 6 May 2025 16:34:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
To: Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, hch <hch@lst.de>, axboe <axboe@fb.com>,
 chaitanyak <chaitanyak@nvidia.com>, davem <davem@davemloft.net>,
 "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin <smalin@nvidia.com>,
 malin1024 <malin1024@gmail.com>, ogerlitz <ogerlitz@nvidia.com>,
 yorayz <yorayz@nvidia.com>, borisp <borisp@nvidia.com>,
 galshalom <galshalom@nvidia.com>, mgurtovoy <mgurtovoy@nvidia.com>,
 tariqt <tariqt@nvidia.com>, edumazet <edumazet@google.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
 <20250505134334.28389275@kernel.org>
 <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2025 0:51, Keith Busch wrote:
> On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
>> Looks like the tests passed? But we'll drop this from our PW, again.
>> Christoph Hellwig was pushing back on the v27. We can't do anything
>> with these until NVMe people are all happy.
> FWIW, I believe Sagi is okay with this as he has reviewed or acked all
> the patches. I am also okay with this, though I'm more or less neutral
> on the whole since it's outside my scope, but the nvme parts look fine.
> The new additions are isolated to hardware that provides these offloads,
> so I'm not really concerned this is going to be a problem maintaining
> with the existing nvme-tcp driver. I trust in Sagi on this one.

Yes, as I commented before, I'm perfectly fine with adding this.

