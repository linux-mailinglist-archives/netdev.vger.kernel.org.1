Return-Path: <netdev+bounces-55547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CA80B3A1
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E87B28102B
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79EC125B3;
	Sat,  9 Dec 2023 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yiNqIcAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88EF9
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:37:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33340c50af9so2985799f8f.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702118272; x=1702723072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RD+0dX0solrlL5ajoIfWf8xwttsASZtvCAvC75BHHzg=;
        b=yiNqIcAorbLE8gPVMaNYzAqRgf3Oxsognt6rSqNOcbTDnugIIuN9xczlciOMkXqGHU
         e4cx64Iw3ku9QyqDzWbA8eLNIR08t0k7m6g21n7uqLlrO1r+lVNKPRCuhrkiKN6onB0r
         GzeH3rN8JPvyg2q4DMGv5DqQ5KgfBTsMkOhs5Iv8AKEi4pKwXo3OwrkmRl+/vLYCGUW9
         7EInpmfmqk4xLpFU3T+RgtTz+4Chg8w7lAjngO2BS+Ll9B6U0XdHEzIpckCluq6T41Fk
         FmuLDNWlFbN1nVZ1fO7UGZgazP8C5UOEOJ51umEfDcaMh7Q4rPiyzhTDdPe8Kwlb0FMS
         tc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118272; x=1702723072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD+0dX0solrlL5ajoIfWf8xwttsASZtvCAvC75BHHzg=;
        b=okefCuCUcriUjNkx0mjAcu/UOxiVF8F/FH72nfZrODUYeCeEmkTgZZA9rExim44h+r
         qPR76peZ2b8Nrl+giJOql1RP3pVBwaovsUSmblji7F+zvxFRR1pbhs2o2bXS75+2Umzq
         0VvRryW8bF+UhJlw8Uc8vPVQoQIeIcEvWMKk1oaTCDnqkuJJr4EknT+tMcuppNkK8Zpi
         SAgYKaqN6tM+k3ERG4ovQ+eJqCXLctss+uY7NrxDtvoki5Q6L7B06ac+7wDY9LioO9BO
         C21MmaRb5dI359c2/TE2D326fpdOCZocH8fxsG+QEPOTEd0eGMFw757C49SbfLfE8uBA
         B0jg==
X-Gm-Message-State: AOJu0YzBFnaFKHIC9Dp6Kkg9bLziXZaZ4PKG3tM/1wXSDT7w3arm5qtF
	4z5aqnJP7ptuYD3kdhLNAws4xA==
X-Google-Smtp-Source: AGHT+IFk+2Unu1gvHcfAXT+paZJlFyaYl71JIijh7SLpWTybjHo5ccJye9QRC46yEsRyZTAYHzNpaw==
X-Received: by 2002:adf:a3d4:0:b0:333:2fd2:3bb3 with SMTP id m20-20020adfa3d4000000b003332fd23bb3mr609918wrb.108.1702118271996;
        Sat, 09 Dec 2023 02:37:51 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id re14-20020a170907a2ce00b00a1f751d2ba4sm1359318ejc.99.2023.12.09.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:37:51 -0800 (PST)
Date: Sat, 9 Dec 2023 11:37:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	richardcochran@gmail.com, jonathan.lemon@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [patch net-next] dpll: remove leftover mode_supported() op and
 use mode_get() instead
Message-ID: <ZXRDfqlF/cf30N3V@nanopsycho>
References: <20231207151204.1007797-1-jiri@resnulli.us>
 <49d5c768-2a05-4f20-99cf-a92aa378ebdd@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d5c768-2a05-4f20-99cf-a92aa378ebdd@linux.dev>

Fri, Dec 08, 2023 at 01:06:34PM CET, vadim.fedorenko@linux.dev wrote:
>On 07/12/2023 15:12, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Mode supported is currently reported to the user exactly the same, as
>> the current mode. That's because mode changing is not implemented.
>> Remove the leftover mode_supported() op and use mode_get() to fill up
>> the supported mode exposed to user.
>> 
>> One, if even, mode changing is going to be introduced, this could be
>> very easily taken back. In the meantime, prevent drivers form
>> implementing this in wrong way (as for example recent netdevsim
>> implementation attempt intended to do).
>> 
>
>I'm OK to remove from ptp_ocp part because it's really only one mode
>supported. But I would like to hear something from Arkadiusz about the
>plans to maybe implement mode change in ice?

As I wrote in the patch description, if ever there is going
to be implementation, this could be very easily taken back. Now for
sure there was already attempt to misimplement this :)

>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/dpll/dpll_netlink.c                   | 16 +++++++-----
>>   drivers/net/ethernet/intel/ice/ice_dpll.c     | 26 -------------------
>>   .../net/ethernet/mellanox/mlx5/core/dpll.c    |  9 -------
>>   drivers/ptp/ptp_ocp.c                         |  8 ------
>>   include/linux/dpll.h                          |  3 ---
>>   5 files changed, 10 insertions(+), 52 deletions(-)
>> 
>

