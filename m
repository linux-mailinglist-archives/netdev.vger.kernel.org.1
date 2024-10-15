Return-Path: <netdev+bounces-135609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8E99E5B5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509E01F213E6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735561D9674;
	Tue, 15 Oct 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCXFZCqg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39F13F435
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991983; cv=none; b=MzMAG+VWpCy9HURoY+AwyaXK25G2Gij9bO8/u0Fxs1Weh+pZnTN6717Et0jay+K8QhMsL2ZxJPiUfKQS/UIUIxx5pb+ArAqqsKyXaB/e9B5L3iYLmU6A1O0WDnGjZgZyoUEerCQlsWa4RjW4JW6VdCustJXRDsKAEaUZBQV0K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991983; c=relaxed/simple;
	bh=4LJhOFliEGCYJeXPJjq9rcUD45sfo6k8OvuueXwJPNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIAJwulPX+KC3+xzVlQ8ErFj9upjdtOSIiICMmn0vbO961u7NU8Di3+wtEaYs8owX9EooJrHl4OTvYbexcpBddJGNLHC75XP/XbPdwrrHqkxflQWH+n6N4oAfDjcNcU+ukGR5FpXbNwIOZRBPuAwyK50gpa9D95Bw6ELX0OrY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCXFZCqg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728991980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HGIkCUj4P3GarxgLwJxQhDbXDAu8fFAFismcPS1kbs=;
	b=aCXFZCqgc/97wXkszn6KCFesGptpNwFlxI3HLlv/BQGoLanD0HJTGYF5G0aYksGMSXvRu5
	4XZLh9p2NwOFmanED4KPd1mTldzXSDBSVasjyDZEQHH9OZEclhZosUl9W4S2aj5U7TFr3x
	CbC1wd6BywYMR5hXTNoFXh7Ybebi4WI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-FLyDS_UOMP-wNve45TtBvg-1; Tue, 15 Oct 2024 07:32:59 -0400
X-MC-Unique: FLyDS_UOMP-wNve45TtBvg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so2456739f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 04:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991978; x=1729596778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HGIkCUj4P3GarxgLwJxQhDbXDAu8fFAFismcPS1kbs=;
        b=sJq6XV25IRY/rD0HkSSPKXbMASlQlQlWbHIKnKIEov6Pzin8h1b2+dkvUQILAstDOZ
         eZl4+u1RQJqGCKl8B1nXYSuApmGmA23tA3mZwKfSi4ANYGVs3oT+uHtRMn8o8f0mELtU
         mI/yh3g8wl+at+nwOFsdcDEty4MIAzRK/6Xf1AvwD0bktxAT2z0CFuvlzRXxxIlu5/E6
         WsLDVtbbFTCGio8AkqNi+3h6Xb+MqIij2fRfi9jsCgymPP1jlt2uoh0mQhDzmelxqxvy
         QpUAE74XZI+j5s3hcPOWxZfIbIe109MJpQFMfrUuku50jhZeASTk9oaxRsLZodapmswC
         5t3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzPe5ZiN0ImfXMAFT+jKwg02oBLey2OM2js32KF7cSp3ESUCgFMwLdhZwuVfAgT9xixhXJ5Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96vXEWBHCphnxa+eMkSHsbEV4tBFWI+gmzNPSdRvZeyo5Znw1
	NiPWktF83Q4DioL+zXLzMHgzGfg46Ek4Xm11D71MFwW0OulBSxY3z27K8AV0k528nohpLe9YIPM
	I1iNh1O89zOosL8GPBAvUzRhmBjUJrzwAK/hsBDKiANQEDfFi64wwgA==
X-Received: by 2002:adf:e88b:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-37d551d2566mr8948113f8f.14.1728991978137;
        Tue, 15 Oct 2024 04:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OIgcZteYdJmzz82U4QRQMqjjMjSGyiYZpdCbwV+aF+nP0JM4GQJ9u+1zyEL5Auz8eFwycg==
X-Received: by 2002:adf:e88b:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-37d551d2566mr8948093f8f.14.1728991977737;
        Tue, 15 Oct 2024 04:32:57 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc411fbsm1332551f8f.107.2024.10.15.04.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:32:57 -0700 (PDT)
Message-ID: <d2cef2e4-d697-456f-8893-57f29ad17f3b@redhat.com>
Date: Tue, 15 Oct 2024 13:32:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next][V2] octeontx2-af: Fix potential integer overflows
 on integer shifts
To: Colin Ian King <colin.i.king@gmail.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Naveen Mamindlapalli <naveenm@marvell.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010154519.768785-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010154519.768785-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 17:45, Colin Ian King wrote:
> The left shift int 32 bit integer constants 1 is evaluated using 32 bit
> arithmetic and then assigned to a 64 bit unsigned integer. In the case
> where the shift is 32 or more this can lead to an overflow. Avoid this
> by shifting using the BIT_ULL macro instead.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> V2: Fix both (1 << i) shifts, thanks to Dan Carpenter for spotting the
>      second shift that I overlooked in the first patch.

The blamed commit is in the 'net' tree already, I'm applying the patch 
there.

Cheers,

Paolo


