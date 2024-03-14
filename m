Return-Path: <netdev+bounces-79905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C861887BFB2
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578FE282471
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8D71756;
	Thu, 14 Mar 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kf+VIT+H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224158104
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429397; cv=none; b=End+gmJ4RDvq3ZhA0A7nCESYKx0FcRCtGsQzLmg2kSA26FL/irMhZPWYTxZuYUan5aRDw3620oFNJftW0oNLSbRXhVH0ZdwwP++rals971nvulmoJnPALXEs+BtjNrmWUMtzZ/OFrKis6VSF149A0XqUkm9uJkQPSCSwconAGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429397; c=relaxed/simple;
	bh=jz61kBlhSie4U5QPCzxlomY23Lf41qL87N90PmvRC9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+AlJiv9+sShznD2y2kL1Fy6t6CT7SSiFsuvt1AktBb2k5za3+iAkj9DV1tgMqM7byLn+Bg77yr5nkr4ZSJLnyMFiaZ68pQ01+g2ZJd49I09+oKZ6jBMcwoScmYdC05sULcbOQNmlimG1WEwkmVWGa99KNjS7/bPgLkeFGbTBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kf+VIT+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710429394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jz61kBlhSie4U5QPCzxlomY23Lf41qL87N90PmvRC9k=;
	b=Kf+VIT+HImwnvo50IKZW+Cl0NsNixrmkVT7pMrwv46MT/NNsr4NlAvAO5o/EwSREOfQN0k
	VKkIRqOwVnZ2jdJmVuquDkCtvNAuh4I9RDNSnAo1DRpe9BbmISh+2xlSWbTPiRXDciSZQu
	XZOqEISCxdLmaZI9yk2JeqA5U3S9rfM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-sldqp6orMHOlp3W9D2NQBA-1; Thu, 14 Mar 2024 11:16:32 -0400
X-MC-Unique: sldqp6orMHOlp3W9D2NQBA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513a7f378afso85339e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429389; x=1711034189;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz61kBlhSie4U5QPCzxlomY23Lf41qL87N90PmvRC9k=;
        b=CFp9XZHHiN6g3gwMO9xAoBkOaMye8IwRGXU8MM3Fk84at8hESdDsFX5isTafyNTDGS
         3K10FOwhE2m6LeEnPVm+Z63SOEM4ZOP8nTLbNcrVsXaPNX1gmgRppjrbhszekXUgmY1Q
         B8FmV5+F/PNqqVrzXkN2viYXLoIJq9IPq7XGYSx6xibtw1n6ZcoABf+X7o2+rfIRnU3V
         0gL9wdCQsb38Gu4R6NCj+gSEZkX3o9x7aYgzKhn67zBo09G1/7ojPNOFvcAV/De7wFOR
         yKYztmwIOnZz1V4mI2BXnRT8EJ/QVyfzx6ln4T+ysw/9yOoTigOpd9PguLOWTOAxo4w8
         NJsw==
X-Forwarded-Encrypted: i=1; AJvYcCVFx8UinTgWqeopLcTdJnHU/6wLwrcgIBHYcdDv2PlWoA0XylpItW+eefV5KdQDq1dk8yfOdMsRa5VSsTzSg1VWBjSS0LEN
X-Gm-Message-State: AOJu0YzmdDkaynqomuEr+Ms2lFJFqisQa5xPgAKKGCmCLfkWBTqCbIka
	wLAxgrLt0MBV4rh7eA64tiUWRdoYvfceG3aGC3iZnHRd51pF7LMacTx1USWJYHePa4VvEiq/FnQ
	jQA6aXAnISRxngRlO0LT1lF8qU9eBXM8ghoxXg8L4aW0h7efEvMkVbqNavTxY1Q==
X-Received: by 2002:a19:6914:0:b0:513:c9ea:5e with SMTP id e20-20020a196914000000b00513c9ea005emr1265604lfc.3.1710429389092;
        Thu, 14 Mar 2024 08:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC7lr3DrZX2Ge/MxnGyrJ0jiGBkm3nPLm4vHtoOZxfOuruda3AjlnGJW9JxEoghEjFLpqYCA==
X-Received: by 2002:a19:6914:0:b0:513:c9ea:5e with SMTP id e20-20020a196914000000b00513c9ea005emr1265592lfc.3.1710429388678;
        Thu, 14 Mar 2024 08:16:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-217.dyn.eolo.it. [146.241.230.217])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b00412b0e51ef9sm2697114wmo.31.2024.03.14.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:16:28 -0700 (PDT)
Message-ID: <cb9b4e2c09131901a97c233ab2e18cb8970e09a3.camel@redhat.com>
Subject: Re: [PATCH] net: remove {revc,send}msg_copy_msghdr() from exports
From: Paolo Abeni <pabeni@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, netdev <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 16:16:26 +0100
In-Reply-To: <b44a7fe3ec2c595786d520382045cf7b5ffce3da.camel@redhat.com>
References: <1b6089d3-c1cf-464a-abd3-b0f0b6bb2523@kernel.dk>
	 <b44a7fe3ec2c595786d520382045cf7b5ffce3da.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-14 at 11:46 +0100, Paolo Abeni wrote:
> On Tue, 2024-03-12 at 09:55 -0600, Jens Axboe wrote:
> > The only user of these was io_uring, and it's not using them anymore.
> > Make them static and remove them from the socket header file.
> >=20
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ## Form letter - net-next-closed
>=20
> The merge window for v6.9 has begun and we have already posted our pull
> request. Therefore net-next is closed for new drivers, features, code
> refactoring and optimizations. We are currently accepting bug fixes
> only.
>=20
> Please repost when net-next reopens after March 25th.
>=20
> RFC patches sent for review only are obviously welcome at any time.
>=20
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Jakub noted that waiting another cycle just to do a very safe cleanup
would be a pity. I guess we can do a one-off exception here for good
reason.

Cheers,

Paolo


