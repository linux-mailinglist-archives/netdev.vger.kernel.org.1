Return-Path: <netdev+bounces-96346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C078C55EC
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F3D1F21D7B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7F3F9D2;
	Tue, 14 May 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcLVZSqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D86219E7
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689144; cv=none; b=B1AYf3y1LOVkF73i5eATDZO5nOsZynbmXFLo3ERaS3gbv+OlvBmIrEE1RpoT0qLBBc7WUl0iEEAVLSzjZxvuMbYZH8Sq8EasfUYYzUIRb3tFCjX0ZRjh4qe0GeoQhCz+6c0+mEk4fqQjD8UYAMVdr1Xbyv+liB0R3EpZqLcd44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689144; c=relaxed/simple;
	bh=SOBTkwoiFDlqkTZRK8lPUxvTkg7sOoOa00MeqX29k1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABNxPPuwq24GpGV/mv2+3jp+ZN71s0DkXSpQ5NE9eiVtUbbXTJoMF0aH9ssjf5nm5X3XrSmeLqO4S1VhBKI7bjXtFdacOtEyByKfuPiZABBhGBfLWvT7ItpOhZXDrjZ8Ms7u2f3znulTNBL3CXKkyQ6prntMzpUuQmCFRTZL4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcLVZSqv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b9702e05easo696329a91.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689143; x=1716293943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/M6RcHxLr7rqLfy5+3tJEltYq84WQeLwXWf97w/s/4=;
        b=YcLVZSqvzYB2CNkA8C2IY3vm8Qstmog2LGrujnNgwGDCa1OuaIHbIx7JDIT0OD/6iZ
         Jym56suzvJtwtOJbdmT+h87KEWyMUxuCKuzoBDKW9+J0EkUi5RbsTE/o9G8uiGzOobPm
         vD2plrj17uyQdn6au8spo1ZBYrlpW32tynTe5aFEYL0g3DoennUsCSZoX+CqkgHx6vUc
         Kt6rXZu2wiEu8cB9TdMn2mIPD/XxCSaoEdI8T8OlOKa+YCJxqduojlgkfFxWQKHKbXNE
         TNE/qHg8oY4mviA4YCddDeXYZubNhHYH9E/hM8PTTY7M+oNfwHJK9m/Q8spWOybbBLfg
         ssiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689143; x=1716293943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/M6RcHxLr7rqLfy5+3tJEltYq84WQeLwXWf97w/s/4=;
        b=QCE9Jp9jmF81nYOkIk68fUaTWvoSr22fzegk6avQCxIMKXvox04BdaTU7iDYhuZwT6
         NpoGBorcrQ8WaJQ3yIEH122DGQDHtxyueA9NyTDuk637H7BC0GF8TUpcmgenSkDj4Mwu
         uLiJjgjaZuEvCe/y7fSAXaB1pPW2GMnvYzHH2KFuC3V5YujNgqamtD5oIlf1xqO28zAD
         n3z22qI1uG1meFCozjR/qGG292oGzB3bcvNCjiQgHBc8hy3f4Nhv5vP/c5IIC12HCvrb
         +LrLQfee7V9m2wdxkvD0y1b8etKKzMAPHjbM4ikYTdz8AHyaAgN7GZVdi1WMSZuUZb+t
         1KyQ==
X-Gm-Message-State: AOJu0Yze2gRTfa7mwOhEgkSfwzvCvlC05CO6j/YDwxR5NI/EdVyskNqr
	W8pmLfhjj2/8/OPmjDNnxYSbP3xcZ0qgow6gjWg/N6F/Tk7YIpxP
X-Google-Smtp-Source: AGHT+IFtqdhlT/FlzWhzWeejBHdaSlmdcrHWnWz+l+xcoHaLF9lHC52dvea04HREoO9qhPea5ZYmww==
X-Received: by 2002:a17:90a:d18e:b0:2b4:36d7:b6b5 with SMTP id 98e67ed59e1d1-2b6ccd85bf8mr11254959a91.34.1715689142540;
        Tue, 14 May 2024 05:19:02 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b5e02ba6dasm7288971a91.1.2024.05.14.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:19:02 -0700 (PDT)
Date: Tue, 14 May 2024 20:18:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
	bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
Message-ID: <ZkNWsR04SdTpjWRZ@Laptop-X1>
References: <20240513105257.769303-1-razor@blackwall.org>
 <ZkKzcJm5owdvdu6B@Laptop-X1>
 <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>

On Tue, May 14, 2024 at 10:46:15AM +0300, Nikolay Aleksandrov wrote:
> >> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >> index e2b9ff773c6b..f84ab2e65754 100755
> >> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> >>  
> >>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
> >> -	sleep 3
> >> +	sleep 5
> >>  	bridge -j -d -s mdb show dev br0 \
> >>  		| jq -e ".[].mdb[] | \
> >>  			 select(.grp == \"$TEST_GROUP\" and \
> > 
> > Maybe use a slow_wait to check the result?
> > 
> > Thanks
> > Hangbin
> 
> What would it improve? The wait is exact, we know how many seconds
> exactly so a plain sleep is enough and easier to backport if this
> is applied to -net.

I just afraid it fails on debug kernel with this exact time. If you think
the time is enough. I'm OK with it.

Thanks
Hangbin

