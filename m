Return-Path: <netdev+bounces-75370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CD8699E4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F70128384A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DFD149E1F;
	Tue, 27 Feb 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qnd7Pxa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B15149E1D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046440; cv=none; b=mWDmJtb3QrxNW6+67jDXVM9+0FjRujqFeKw/uQysTYVxgYBULm7qir4xRQ7T3gnz6hPVmtpL+9l9fvR8R2D/jhI2nuBzqE9vu4UQ/CT5/acKEC3qoZ7zqyVbfOlvpA/Bp6w9u2piKHgvFveeVdDME/pOMXMG7kR51yxYLDE3ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046440; c=relaxed/simple;
	bh=Us/6713pf16zhZV4QzPkLFnfNT4fVJdkuAUvvs1MWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5CuhEGGTbin4qm4E279FImnxbFu+zWjHW42BHF9TtZDkTXhvAjZeW+iAsZk9pVmGAc0aIUy4jh/Q+lE6buTo4nMQgM7QukgiB45r23NRoNTcDj8s4G7FUOj+bpNkogbepQc8xu4FddCEvMtOmn89DiEUAHNTsowIL4m5+WY2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qnd7Pxa0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso47900471fa.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046436; x=1709651236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vulhCN66cUevk5GIGTwNe/HX6DPTkr4nao/EUtWTWuU=;
        b=Qnd7Pxa0To5nD5BhU06GGn6zNPOZl4LrESt2k2EGoZ3pmmNEy6onqWh1SLYEk7yO9V
         7TYfnT1SNzIYtKOCBeZiwETma2OhUrEZHlF+82jihUaOIq9G4/YVPFs1Dj1VyPigvC6D
         YZrLGQy+deM6ojo2FqTB4datJeC7SF85X9X4NoHW7HuvgC5nDiWqQTER3T/hrcdXQusE
         1hAR4dwiZPR+ca+KLeRnmdEIwGnX7OBPpcs7TLMVlD7eeSIpmBxZzDunSv5J0ykcc2FH
         Skoe6Zk0nUdbMuQu5nspJYfF3WhrUmlSzf2gLMG+uC04S7OwLJvwvv3DvoIB+l/MpTAq
         jrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046436; x=1709651236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vulhCN66cUevk5GIGTwNe/HX6DPTkr4nao/EUtWTWuU=;
        b=EgjoqsvGoYMFO5VJIONMvPr5Qcqqd3BX8Nx6Bf5+04epQM90Kw33fsT1yz8FyFi93M
         xZTYVw9C/b5yPl+TYhCx+hv58iw5jQkFLw9B62ntuB/6q5SYCu/Mo9vClaOerRIgTNlG
         Z1H//jfSXA5vChcax7VwO9dq7A5EJHKxdr7nXZGGzCFKDQa3VzZ+wDsSWHPyeWpKn7vY
         ceMyiY8nKiqqbGgp1dHtrFz6J8zdB66ok86QpXO+msYpVCCEGsxUJEzU8s1oJcvAb033
         v/PhbbPyZqmYV5wfVr1/tmGJri+f/nkbwPypZe3MgDLUcNvAvZpWrCZ6Al9loxBpdsHG
         UGpw==
X-Forwarded-Encrypted: i=1; AJvYcCUxAk8XCKWovkko9kK0yeZ5MrlZquE3FN2OpQgVm0SrsVArbInVqk1jOgmKQZa5x5IO8kzSORVCUVoGUvaojpdTVxQ+GVkN
X-Gm-Message-State: AOJu0YzwyCrAnEljL8WgHJKL3zhFkRH42YJxUsG4gouLwgQE9TqOJ7Qv
	yGp8QKPQZ8g/Rk8+TMtkuapEnKaBjJorFSHtcyT/zDvzOle6bMBlJzOGyBGnmAI=
X-Google-Smtp-Source: AGHT+IFnDvQHsuJdoXosr32631j+ALSCHrOiQqDmyqkWzGENLMhHb/ghivWR+AmQzLLdV629cF3S2g==
X-Received: by 2002:a2e:91d4:0:b0:2d2:4450:92 with SMTP id u20-20020a2e91d4000000b002d244500092mr6113926ljg.20.1709046436426;
        Tue, 27 Feb 2024 07:07:16 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jl20-20020a05600c6a9400b004126101915esm15277513wmb.4.2024.02.27.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:07:15 -0800 (PST)
Date: Tue, 27 Feb 2024 16:07:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <Zd36oZMvIvqtNSzr@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
 <20240227065424.2548eccd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227065424.2548eccd@kernel.org>

Tue, Feb 27, 2024 at 03:54:24PM CET, kuba@kernel.org wrote:
>On Tue, 27 Feb 2024 16:03:02 +0800 Xuan Zhuo wrote:
>> Now, we just show the stats of every queue.
>> 
>> But for the user, the total values of every stat may are valuable.
>
>Please wait for this API to get merged:
>https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>A lot of the stats you're adding here can go into the new API.

Can. But does that mean that ethtool additions of things like this
will be rejected after that?


>More drivers can report things like number of LSO / GRO packets.
>

