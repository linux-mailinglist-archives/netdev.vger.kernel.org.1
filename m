Return-Path: <netdev+bounces-202680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E215AEE984
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D763A8F5C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31B28A73C;
	Mon, 30 Jun 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz0raxlC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6A242D82
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319513; cv=none; b=B6Tb9gnDnhOETMbymXArkThv98iAlzL9LErAr8+4uCeQsLGBYqqUmtraHO1nH8TJyo4bLFfFT01yPANRdN0xlTZJG2MsZdis1Lc3PxSV9/V96Fp2o38PM9HYlAeUphJzispO/ohgOawuuGg9yEcwhc/xw2ja3F7qL2kGp2PKAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319513; c=relaxed/simple;
	bh=jedf69+DW+RB15NmVdfNZOTnVNBPj4oiwQszgWYDjXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLaul65bmh5jI6zO9Gfwq84LCn2bEiJtgmfwYhButGfrV4TVWO3WfIJJYRQj3zr808QTu6NPpsPdxC1lbMscoX15Zpldm5ycxiapv9e5ZPsQJlgO5Wb8NgpHOGPKEPTCj9pFk7ZIDYyXYcPLtzLG5c2B8WCsVWUqDfhj9mGo8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz0raxlC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236377f00a1so48930855ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319511; x=1751924311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/qsxOWjX/Yqk9q9spokRC+/w0x5NMLOPFX2T37sGeo=;
        b=Rz0raxlCadBZ1LKYqsbwSlravbOOvui2a9FOVnD56oxXA+FXMYZljhyT3vvUJjShUk
         G32h3b4DE/exfEZhU1NU3qXEvnfZvxzALg+2Bu8Disp7qos4VBTBohRAbxrzDcn6PQnl
         duXcAGg4eLQMzbAThGgg1xPv44QP86eW1+P6CMLv1D107aIXxACFky8sOSdiZvkr3+sc
         iKBkd6iCfqPyZCOWqzuivQDZhySMfGwmZhPcIFUhXx7aDimQijgDLm41fX5WG9eLCVKt
         nky/ijRt23+4qOIbHsfEVZvhDhYEDpkjaKPKwzUULoMYpXcNaFlNr9ujL3DZydFUPa93
         KLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319511; x=1751924311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/qsxOWjX/Yqk9q9spokRC+/w0x5NMLOPFX2T37sGeo=;
        b=tG+rwl6DIuZX9CP86ARsrwYf807mI7dsahf5rNengRTbO2oHxg4TmKQ5V9Sud0in0Z
         sB6oKB+eirEDu6Hs8cvQmr7mtrKWzRCs0HZ35IrEymddRtDRubXNZKHF/xQrTIBIQH5Q
         ENG5QWLTOI+a2wS2erHjLXD5TCFFN/4h3zdBbzKdrL/hFWLLflZsDODa+1DokpD2wAl9
         +C4b18qggRnuQDo9TyOqV3JrGWXe1be4uXi4oBUiYZxFk6De1n9R7I5ARWp8TRmXOCgS
         3CCGXvb7P8H2CkVuqonIxZsq5aQMvSiDMzKQAbFJmSGBbu8dp/715xbBVxqKYJPL0zDG
         7LYw==
X-Gm-Message-State: AOJu0YyyAMKEIgpIaKWt1N51tvCvPi5M5+t5E+QdkOrNreCP9LBHNEg/
	GYUqOtQSmpgP/W8Hx9Kmh7vYZJt0L/lfVceiNELWOxl75o8q2q/jF31w
X-Gm-Gg: ASbGnctHqaXjfB32f87jFacIgrOwgy2nrztUAnxKaszbA4MHbg/ykYuR4IiorggXCnP
	RjODDmGHJ3mNXqGiR7MQ7Y2RDFphyzmMXpFrDXxcEPtNO0mtXasM9LV9tZH9t6EjJLacDXUARlx
	3M0zfJuC5QCCALT8ER+JP3InrqDQFxfCjSi0EPvuEYKc+3qhiz7wtHRZ+NLcMXlQ82euuw9SajJ
	nobBv+o2j8Nz++q9kcdrDpLmR6oHWcWvj0FLToOdYA1NFWxycdPxiFJE1T5GaUDKw/69gIlU5c1
	WBbcZDDBBQRVojPbMudziDp955PFZYVR6K6mfjsjwLaUytGxPFlOlugBHNtlTpOXgQ==
X-Google-Smtp-Source: AGHT+IHJ7vrzMIXvfnv3PweB7TFbnwVN6Eut2k1CKORrtkCmqQldXjFoHz6UA2Mv6X5IbKEiNoOi7g==
X-Received: by 2002:a17:903:2984:b0:235:6e1:3edf with SMTP id d9443c01a7336-23ac4633d9bmr248266845ad.34.1751319510897;
        Mon, 30 Jun 2025 14:38:30 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1aecsm94458775ad.46.2025.06.30.14.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:38:30 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:38:29 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, Mingi Cho <mincho@theori.io>
Subject: Re: [PATCH] net/sched: Always pass notifications when child class
 becomes empty
Message-ID: <aGMD1S0F9sTXexBo@pop-os.localdomain>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com>
 <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>

On Mon, Jun 30, 2025 at 03:27:30PM +0200, Lion Ackermann wrote:
> Certain classful qdiscs may invoke their classes' dequeue handler on an
> enqueue operation. This may unexpectedly empty the child qdisc and thus
> make an in-flight class passive via qlen_notify(). Most qdiscs do not
> expect such behaviour at this point in time and may re-activate the
> class eventually anyways which will lead to a use-after-free.
> 
> The referenced fix commit attempted to fix this behavior for the HFSC
> case by moving the backlog accounting around, though this turned out to
> be incomplete since the parent's parent may run into the issue too.
> The following reproducer demonstrates this use-after-free:
> 
>     tc qdisc add dev lo root handle 1: drr
>     tc filter add dev lo parent 1: basic classid 1:1
>     tc class add dev lo parent 1: classid 1:1 drr
>     tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
>     tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
>     tc qdisc add dev lo parent 2:1 handle 3: netem
>     tc qdisc add dev lo parent 3:1 handle 4: blackhole
> 
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
>     tc class delete dev lo classid 1:1
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
> 
> Since backlog accounting issues leading to a use-after-frees on stale
> class pointers is a recurring pattern at this point, this patch takes
> a different approach. Instead of trying to fix the accounting, the patch
> ensures that qdisc_tree_reduce_backlog always calls qlen_notify when
> the child qdisc is empty. This solves the problem because deletion of
> qdiscs always involves a call to qdisc_reset() and / or
> qdisc_purge_queue() which ultimately resets its qlen to 0 thus causing
> the following qdisc_tree_reduce_backlog() to report to the parent. Note
> that this may call qlen_notify on passive classes multiple times. This
> is not a problem after the recent patch series that made all the
> classful qdiscs qlen_notify() handlers idempotent.
> 
> Fixes: 3f981138109f ("sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()")
> Signed-off-by: Lion Ackermann <nnamrec@gmail.com>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

> ---
>  net/sched/sch_api.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
 
I love to see fixing bugs by removing code. :)

Thanks.

