Return-Path: <netdev+bounces-68361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B3846B24
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA881B2852D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988460245;
	Fri,  2 Feb 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UNU/vfGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049F5FDBE
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863501; cv=none; b=n3tBjhlYmkPlR7pziTEwmaW3TtveWlbpuJEBizh+FuaJ37mYLoKHmZhdEOAuTjUso8Q1zTX+GBjiBggiSCgj9zEKlQkBhGzcKj3iUwbhDkgT+jN8F6otEvkh2pkmudK94V7MLUFE7/xfhChljrN6o0RDh0CTfE63KBacfD0e1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863501; c=relaxed/simple;
	bh=9+HRBcEjuxJQjICAlTBgia2cWS/haYLBsiPRDxvUW94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViBq3SdzjMqvu/D2rhJj9YXIotUyanNBp95RDcOxBXSSNHYoqO9L3WS57yolccThgUVpX6+mpI1yby+kdPzpt6lAYipxtRH84N/Y5Mf2MPwdUokiecHnBH+YFzOMNli2Uykxtksp1/gKzcCR2I+fDBRBwZ0rS0PzHGiDhaqFrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UNU/vfGN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b14702adaso980788f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706863497; x=1707468297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Lkl6TctuWgyWRMIew9d1ihW3lZXlosPrNdqOtkjKs=;
        b=UNU/vfGNXwwmToyQFhUuaKjkkFMFM1fnkcfCvVZh2LFR1KVPS9jIir3tTN7yFCt7YL
         eZ9aOZER3UjZzZuc5CeHdHPLsUrVIsXhzJ/WsHqXDVd6E8MBqKVEcEZfytS46dEruUxo
         YrkG+JNaW0ZHXWiy9d5eWP1T9sW1tY3nt4gU3jvVF/PuJ8Pq7f1FNAXQxYWFP0sds16J
         otjMwGHxSW2NRjXgrFs1awOK3FhL5ksiQl+DboXsagza5V28jTW9x/lC1FkgRGvPORIC
         ha7rT1sy9y6Xmv67JGxXfVFdXxOJT3DbX8NP48VLWrF0R7jl/TRJBlVIJBoOPTbge/RL
         a8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863497; x=1707468297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/Lkl6TctuWgyWRMIew9d1ihW3lZXlosPrNdqOtkjKs=;
        b=X03XcCN3RKGm9zxEwZymfuHZgab7K916ca2J66Mump1ctCKmeOGOD93gtH+jJoJUTB
         wX4oAhg3xFeLb1zanJZqQb7PP3Tah69PkfHWcAYLoD2KljNGA8jPMvQCGP7qYYYYVh53
         H3oi+atGj+q9MniA31K9JqklL/oJgqqTlD4HKU9D/JocYIoO1bPQMXvmK9NGtkvr4akp
         m7pe3ZYUVqCb9VYa0LmicNUg8hGgyw+dB0wH5LC8fumsWvygyyXCsftYNMOTdB753+4A
         TkcuCCSQMTgfAyQJ20z6YtJMtMzd+ZbX3eSpqh3nOhQGeLvoNgUfXSrhq+6Ie2sfYPEs
         VGPg==
X-Gm-Message-State: AOJu0YzKwpJXbSrSkUSy27uZmwESBhOYbzqsnErZEiMyPtTMlPF4mGUn
	rYP8045ymKuP8h9FM+6qS9iwMSrvVVlctJbMYzAAx7CPRoRn4kFgsxawThRzkBSr31gJ3yMN+6P
	/vcI=
X-Google-Smtp-Source: AGHT+IG0rTuGxx09YFVMFEJqENagZSKiLDJb5ODNhTkJv6UkU5vdREIrJL/cn3AsegO+hQAhFcM3gg==
X-Received: by 2002:adf:ea8f:0:b0:33b:26be:c5c4 with SMTP id s15-20020adfea8f000000b0033b26bec5c4mr40716wrm.58.1706863497090;
        Fri, 02 Feb 2024 00:44:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWE7mX9UOIb3xS84kImfMP3cDRfqQt/jKtyJNoKlfygBP1ixoJzye3XPfZzL3/ny5oJv5eFJARREg7xQpx6WLdxbVt69aKFPQWb1h7hfs6qowiN7czzy8K3ui7LOtxmYOdZNsRg18wD4BgHnwS/DS4/yfpJM4RCZE4r4SuYPoJ8Tqdz8U+vlkniEs+zYfoXmXNd16pY+VsdG69A9axLNvB6AbAe3qijsUqyb+5yPUaDkfFLvTXu4lBM7GbJMSdubOJqJ4BnkF8=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t8-20020a0560001a4800b0033b17ef5fe2sm1409110wry.92.2024.02.02.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:44:56 -0800 (PST)
Date: Fri, 2 Feb 2024 09:44:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xudingke@huawei.com
Subject: Re: [PATCH net-next v2] tun: Fix code style issues in
 <linux/if_tun.h>
Message-ID: <Zbyrhnt9yAFwegSI@nanopsycho>
References: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>

Fri, Feb 02, 2024 at 08:25:55AM CET, wangyunjian@huawei.com wrote:
>This fixes the following code style problem:
>- WARNING: please, no spaces at the start of a line
>- CHECK: Please use a blank line after
>         function/struct/union/enum declarations
>
>Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

