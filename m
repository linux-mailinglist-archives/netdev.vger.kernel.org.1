Return-Path: <netdev+bounces-76194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F286CB4E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177511C20D18
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802321361B0;
	Thu, 29 Feb 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WW+ahL4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE471350EC
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216326; cv=none; b=McBYyrbm38bkYsjyJQ1feZitzxHMX3s+MamE3W9YH6hzXzd+mf/uq984Zy9tW3vJ1r+QwckoTeXhi/3n2ANOoVIgTu159kJVINseL5MJ7FB9WEaGkxocU4exY7IAonMy/KtNhyUS1shm0mkOaE3kauTrrnDaGqSEdWC0cCbXPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216326; c=relaxed/simple;
	bh=BpAV1h7vAElCeSAMfDCr5+w4VE6qrWqEnQwLWE0fDlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMpwe615bpXeLbyInimj4pcscnT45rHW/mRHbsbtd/bOcdZE3eQz0HTIbFyRC1K/C8q8as9RL5YQ0ieku2EWodHn7qcrCWzUPpZVFvNobKfFtqZVLON8350GUmCiHciYTK8O9doyA0lumN/mta3GEu9PmpnQFzt4fctqKEgaPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WW+ahL4I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412c2352f74so1982885e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709216323; x=1709821123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aaee8JFqOYnvrJG84IqHUBI+lXohaqSjazdLmgQKB8=;
        b=WW+ahL4IH8GLXNmV4ZCgK8quy3KCBZTv1GOJHyTEmP7JkVEX7QKH11gmRSJGBVjm4V
         V8Evop6Uk3dOpT7r6M2sAzOtAvXR4INzFs1w14bane2PVtLesgxnCRpzeyen9Kv08/wx
         x/r2YF7i9qFOFjB8p8mts0foBphhdZKNS61cjN5QXjUhymL732PnS6roq3XNwQan4goO
         TrA8IsSSWgi0liy/TiIsZoGbG2SleDhbcyr3UCat5W5TvpdwiXKgCpPt+IN1G/RNY3Oi
         OGn7Q9EdUwSdLPBp1MX1tx5rB929rsAkk53egy928zewwS13J9gVkIMIoWjn48ok7BcQ
         qurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216323; x=1709821123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aaee8JFqOYnvrJG84IqHUBI+lXohaqSjazdLmgQKB8=;
        b=qA7p5AGzJCaLcbKiRgS8rINLAFPSGJDt4De7ovDMDAjhvXfr+8phg8P0D+om8Df1Rw
         JJe5wyVzb+PoiYxgQ1k5AMC8RHZ/dBv+O4bJlCgGUjZYQXtmAFoHTBjGIq6KeEmkigMJ
         /Dfqxx8guoM1W1k/1iplU9UqtKNncB0ofatwfg7uWXrU9bjGsuTda4O4zxBdKPEUa3oI
         tjayUTw/kjJw5s3P2+ba5EvWA+VrswibFD8UwudOZykvX4BBdLBQ9RVmkd1CJ1eY0iKJ
         OnkAH2wwFru/ANzgmg+ezbFrwBXuW+VbhtN7NTBdN9/zxNcqLgyahh48KVSulM2+Upqf
         A8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0Ypyw4WhJnxo4E9ED/qhQ+Kly5g2qBkvM3Yc7DBCSolYP5NWkKgJzvRL7kMEwXNtfWzJKbZw617OjN4mvO00hc4KgWti
X-Gm-Message-State: AOJu0YwUW4nPjK9sVZA5+goHErlzNo9RWRJ4Yp9Uk+ZKA6LXcBIpTFW3
	pCCvfPZk3dqkuHO7513pfni6TtbdykUqnE97CTfWwJTdyQgxIv59Na5DnaW8zQE=
X-Google-Smtp-Source: AGHT+IE7f37O3UCk+CZGUG3+ngXGyeKj8odD8yxHPGDPeUg8uafik3Fbx/aDSVyacE7BpicLkAY0Yw==
X-Received: by 2002:a05:600c:190c:b0:412:b8cf:150b with SMTP id j12-20020a05600c190c00b00412b8cf150bmr1727204wmq.10.1709216323024;
        Thu, 29 Feb 2024 06:18:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jr18-20020a05600c561200b004127057d6b9sm5325317wmb.35.2024.02.29.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:18:42 -0800 (PST)
Date: Thu, 29 Feb 2024 15:18:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/6] inet: no longer use RTNL to protect
 inet_dump_ifaddr()
Message-ID: <ZeCSPyJ_5ARF35mw@nanopsycho>
References: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>

Thu, Feb 29, 2024 at 12:40:10PM CET, edumazet@google.com wrote:
>This series convert inet so that a dump of addresses (ip -4 addr)
>no longer requires RTNL.
>
>Eric Dumazet (6):
>  inet: annotate data-races around ifa->ifa_tstamp and ifa->ifa_cstamp
>  inet: annotate data-races around ifa->ifa_valid_lft
>  inet: annotate data-races around ifa->ifa_preferred_lft
>  inet: annotate data-races around ifa->ifa_flags
>  inet: prepare inet_base_seq() to run without RTNL
>  inet: use xa_array iterator to implement inet_dump_ifaddr()
>
> net/core/dev.c     |   5 +-
> net/ipv4/devinet.c | 166 +++++++++++++++++++++------------------------
> 2 files changed, 79 insertions(+), 92 deletions(-)

Looks fine to me.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

