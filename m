Return-Path: <netdev+bounces-173376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E5A5889B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E891693D4
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F11A9B34;
	Sun,  9 Mar 2025 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG6yJvBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999916B3B7
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556787; cv=none; b=I2LGpX/rFF4YmQpuwrnNzgdCbSIqOnQySjPoNnzX6KMI/tWd99aNTp8FxanzhNyI25CAIJdVodpJvTswZQ6d/sVCig6Y2hb/rQP/1/KSZX2zGGmRmiLMSVTyNcBOwZG1/6w0RamLpyahsf36aHoD6fUaTr+iUuZTxZ2+B2SOFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556787; c=relaxed/simple;
	bh=qOk86JjgRkPjSH4Uw7BzviqLUXft4TcAaDe0l/OOuss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIAqiwHYTrtfhV5NmRG3JS9HfsnvKApPVjhogIlzTPLM7PVts4Cih5jvx0rl6deEXGhSqpDghJ2mTT/xCa9qYMmgLGul6eIVQUvEWcsxf4nnOxKO+Rb26HnWptoZG4jwNIjIGgeHGARY76pRmzkoZUfKUZb0bGLUwJiBJbGHau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG6yJvBl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso65508085ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741556786; x=1742161586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/BTfmSm8EChEeOhoMUJpcs9FoW8R/xeWAGJbkAAuIg=;
        b=GG6yJvBlfizbngqjIIETEeG+ScvGVmcDrCrCkUxLp/eRG5DvQ7appx2KgT7qvhxXTz
         RFTEcHIeyiEIdSZpwiNzkNzHmFnHcRR7dUEY383O9rVfgL7NO8ktJo/V35Y14SOth4HC
         SgnU5QwschiqCQKIhAYLTOu/kL5knRwZCSksovgfRJtC0HMSjEApZf4g3jrBlRjCDrdN
         BnrWPDTaU7yopqurDRM5qPwso8hNzzZyYqzD607pklX7YK9Z/yEx23TfW+UAd+3d9FdD
         2a+yayvD6DUY0mYBRRJW8qMheUg5nVjL4bFIRKzw7tqfZV8IhqSQA7GlvG8LRok3uu5O
         Mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556786; x=1742161586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/BTfmSm8EChEeOhoMUJpcs9FoW8R/xeWAGJbkAAuIg=;
        b=AVhte1IsG1fftvNIm/QJEBE0eiYdUA1/q8kP1tl5a/HCdZWlwAbCo7OMcAGK8BGg+S
         3+xD84pHcF7d58g0uEyArKyLKmxzxGiDHzJIgZ1gb1Gs8U7iUUPAJYgj2gpEtcZUPO75
         3FSSj7L/bxH1pn2UyOTcq3qBAZ0R2YJcz6bqwWgLEE7VAlmoznGFMzuY+4W7Brn+m1Ed
         7K8SM7jf9UbzFjtRXl90tl91osJcc8AJfzcn+Gnv1dFxzi4G7L8YYrHFL6XwFKVMSrt2
         k9KdHZYI9zBh/grO3PzH2E9Y3+vnj4bWLu78dQodSmE5Yc3xjqMhl791mlhJkvBbPpO9
         2BuA==
X-Forwarded-Encrypted: i=1; AJvYcCUzgWmXTIhFuor9x0ORP9Pbtq98ypMJlHARuqcIaY5ID9lMvnTRbHRR+WGiWyO/3e2NR0otzZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYMwEL+aDiWUQkAfXuP8XDImCRshGaEGx4yFR0luxZ8pR5woe
	h4QkO3R7EiKMJLxGwEX3n1WmefLo9v3g3zabU25dIrS8iJ7gEgM=
X-Gm-Gg: ASbGnctWJOHXCFnfW36O0NqpbcgSeW2w9DGFjxp7Mh3ck8jot6qG6MZjB3M/dYX2/MP
	vw7JpNy7RYh0n2MYvLOh89Gzt3BUdfqETWxJOtqBn71AVcZ7aZjzqjvjwRo9sXxUdX6Y/MEjY88
	j2cXDyrtBVwii4mJeNmz4xD6Xxwhfyqo71AiwOSu4MdPz/roALTy4dXcR4GMkalCMGeHrgpOWiE
	XSQMV9oP/m3o6imQemC+yU8S36yBbDbU0AB2x/DGTYkv3goCXrqDBsfAARinN2213ap/Fk3Lrui
	M7wlc75tmtBZ2JlbwgFb/HRILOuqf1oC4eoUJOeAEn6t113h0+8Bo7Y=
X-Google-Smtp-Source: AGHT+IGXsuAMwVp7U30tyej31uu8h/qWVgAV6S8SqBU2DT62cr4BlZN/DEbW0V21UkNmJ69Ds+0zOg==
X-Received: by 2002:a17:902:ce0b:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22428a9e676mr187928105ad.29.1741556785598;
        Sun, 09 Mar 2025 14:46:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff6cefb8f1sm7021279a91.18.2025.03.09.14.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:46:25 -0700 (PDT)
Date: Sun, 9 Mar 2025 14:46:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: lapbether: use netdev_lockdep_set_classes()
 helper
Message-ID: <Z84MME6rwU6q9aJa@mini-arch>
References: <20250309093930.1359048-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309093930.1359048-1-edumazet@google.com>

On 03/09, Eric Dumazet wrote:
> drivers/net/wan/lapbether.c uses stacked devices.
> Like similar drivers, it must use netdev_lockdep_set_classes()
> to avoid LOCKDEP splats.
> 
> This is similar to commit 9bfc9d65a1dc ("hamradio:
> use netdev_lockdep_set_classes() helper")
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67cd611c.050a0220.14db68.0073.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

