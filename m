Return-Path: <netdev+bounces-125773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970C96E88D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2891C228A2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9A1282FE;
	Fri,  6 Sep 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuUSqdNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD13CF73
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596113; cv=none; b=WUGL+ktuGHP/G9q3Q161ilBgJjcuwXSdZM23CeS4TkGQX432fMYMLCGh7uY02cWnZ3pHyEMshcG/pu+efRyQRI3djjL8GTsDa5xqMkZcJSbvtNXdkljHcxqYPggF728g0OUP1K41IMYJoFhIjrkkpNZngvDZPCsebA7t8ue65/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596113; c=relaxed/simple;
	bh=01Tk7ZBGJfPLVRWgGcq+8uS8reVOfMG6hmmJl95+gWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFPmmxY2B65Y6ohEZ3r1TmrRdHkTVQ9WBlE4Fh0IOtGjhccWeR/FF/RY0Lu6mJjAEsof8rbpSRscvl/1ugLkTIZa0GjcXjpfjgckgfHhGGApEePWkc6jC5KrDEEI9zOLW2zrc8YmXvWyolxoTOgxdMJF6Z7kQgFwenFJkcW6quk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuUSqdNP; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df0c1271c1so1015501b6e.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725596111; x=1726200911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01Tk7ZBGJfPLVRWgGcq+8uS8reVOfMG6hmmJl95+gWE=;
        b=AuUSqdNPMrHLPrqFRZbsFejZc+ygjQnTjuIbg1mFOALF2hLZRVcXNrzvTAY3LcUXQ8
         tpbOXizNTHGLSzw7bT3eX3x5vdzKmpkIeY8cj69xiArpTXe1MQJmG6qy2Vb/C1UTLl5/
         huA+p6LTXB7AJ0QQiQkuCxJdULSU2Ym2unFmBz9liziqDesWaKPeqyI9resP+uxDblJ4
         wcEh4lcdFQnFTaNAKP1wBcckwwYoCWUbKqVOPmIy0TGJGiv+IzZrag0SU7TrrmJDsnzB
         q8Wwz4I6NK356VNXNp1IDgSd0QLXXJTP+tnenT1K+V78aLZGECkAMksng8UyLpitQxGl
         gRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725596111; x=1726200911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01Tk7ZBGJfPLVRWgGcq+8uS8reVOfMG6hmmJl95+gWE=;
        b=jnuj2/RruL2H6WuVS3TkTKDW0/mXWM5U0QnkQzTridqXAaT8pRlSjL54L7iPMg6w9U
         WFMjhER2YJRqrejOGX3HvS/Jec9QJa+Ks+SWENAQP+FR1fya84acjXUtR6YivBGLkXiG
         jgwTcxR6XmFOm7x2rqytVxtTEPPLBJCGXJ89fjn6eqlLbcCIJW73yaJ9GyAB44gqVWPF
         Sjdq8n4Jb6+xA7Thmt3DfjuwcZfV7FcRQsfxyqpYx+bh6+wUWL+etQDYIvB5OIxf2hLS
         mFyPqNORKfBCdaSh41izo5YO/ZPuXCpi9M+jreLgjlOFuMdMMVO1JOuC9bLWJYM2UAIp
         WjIA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FKyiBSs5OAGZRSHQeYs5zAwiPcaAjlR6MbWcMryxUU9XgvpJiKUE8yqZ6EgIMreI0su7eBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrJ+kmbIwiy1VnEzlx0alOQ8yE6srGonv/l7QdEc2Zabng6n6
	McRdYO1s25XlwCan88VflFutujVcho/kLYe0o40nm3rF30w1R0/wyRvLldTB
X-Google-Smtp-Source: AGHT+IGhExq8JdKsGny11i6Zdbdbwpc2gEnqW5NLKyHZ1qnJg8pMa003iAkCHFa7gSMj4dZ8TEhtWg==
X-Received: by 2002:a05:6808:1693:b0:3d9:2b45:1585 with SMTP id 5614622812f47-3e029f066bcmr1733701b6e.22.1725596110641;
        Thu, 05 Sep 2024 21:15:10 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd85382sm4084892a12.15.2024.09.05.21.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:15:10 -0700 (PDT)
Date: Thu, 5 Sep 2024 21:15:08 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] ptp: Check timespec64 before call
 settime64()
Message-ID: <ZtqBzKJ0KjfTJtcs@hoboy.vegasvil.org>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
 <20240906034806.1161083-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906034806.1161083-2-ruanjinjie@huawei.com>

On Fri, Sep 06, 2024 at 11:48:05AM +0800, Jinjie Ruan wrote:
> As Andrew pointed out, it will make sence that the PTP core

s/sence/sense/

Thanks,
Richard


