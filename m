Return-Path: <netdev+bounces-183337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25EA906AD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D578517003D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596341B424E;
	Wed, 16 Apr 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2a8Yna"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB4189B91
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814446; cv=none; b=kxFhq1PAJ8OT0WkYR6Cx7Wm1yG6xnmTk0/cVJNcLZ3MkPFbCDPlXZv1l9Hkd5jn0y6/v6EgU289cVO5BdkwvbGmd3QaNsETDh/pJAwqtp3XIEkN/jWKcQUSQjNONJVvUsuXV1+vNqT1qkndenVnRC4Dnhe4hzpd0Yxz7GK20HnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814446; c=relaxed/simple;
	bh=FqZqYDGXOdHxPQ1z8jRrQOYUnE6Iqe2hsS3d5EAEnpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdRIbs8wGBfnNocpOda69bySpeLlMSpazbATw2L1WGU7D+5xWXwasr9rzf0VV+K07lJRl24VdSDAiKE8b0cnHyhMWs5YfaSVZgfY1g9hUCbSyHc89TZgVKGG2RwdUSFB8mUirGwrQmUKH7IGIRYy3LOa5Lj9qSfe1gnlfq+FagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2a8Yna; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3085f827538so1175920a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744814444; x=1745419244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZiMk8stUnBWghM4WIFczikLQvmossRLDZEVBH34gKM=;
        b=OS2a8YnaDoqDDdrttV1JnE+YONyCf4/V7CkByrN+xKGQ09owWmscQ6zwdvg2h5W4va
         Er5jNAJbeP0s0SZ+DRMakj3r+TMJiDXUFJZt1fluF2TavlWOFUKo9m0oD+8X14TOuBKm
         gRdZIz+tWtzYI3AeyFV7ZR8D5zazExFJxC+eDccNlHQYGibDH9x/+VNmI8J3NDC8VSSn
         bRnpUw8jXEklS1FSVC0AoKjMncUGlG3i0P6wHexkVrnt36zECn69QT6kO0Nxev6Se522
         Nf6m2u79yrRXue4cDEbefrYF11htOnFqclGqzxSZx+yW5/byylLB8RkRKjquwbnwQt9f
         ezPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814444; x=1745419244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZiMk8stUnBWghM4WIFczikLQvmossRLDZEVBH34gKM=;
        b=kVAvl0I0H81uzf7RncwxJwYoMDrbZ4yDJA3tljLPwG2uNPoOotnRmAtXLwEv5LKdrv
         8ZOdXpOadWGJIZ3vVJDNPdHOaj3Bs38v1SKXczBWaunnniWmoMvwc9OdjsgI/XNo6a27
         8qt6zvJYBxSvQ+MB7LQW8vCXYpojJMjnzAvA5mXBQGnZ2kFd6+umyAqLOo0FO6qbc0yB
         eZPRgDqEVwgQVV0yUponGZ9c5zzJhXun8J2iAjI8Q2SjLE1YDIj3XZqEYKwuWPihxQmA
         eju4lIl3Oc1Dy6oqtrTYEYrHE7T4kexfyrJotrO0Ym9Fh3cummCWQEJEmiAXPJbVYh4g
         JTSg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1SMfggX1huJkQqy2OUo5V/1t3DMNjzpE69nri0W207ENqcseUmZZYidfSqRzyiThc428MFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYiCaEqP9lbuS0BWP8HTHDw+odStk+TM9vAIu8SEq2vu26ynz
	i4SkZJSlkfbdQ3agjD2sMczV5IrPo1iFc1XvV+BsqaoHtbd5iKo=
X-Gm-Gg: ASbGnctX8xOOExTajU7s2NI8PXOdgK22OKfwgg4uhofR4wr3gzz2JwEjc3w0ToLh4Xa
	ZLoXU8k8bKC+uN5i+8nbsEv6k6zmCFvkpMJsE8CxlgAHVAJu7Hepq6X4m6RIJpKDfMZOJtkPIp3
	enLXe9GfuE4W253oNxvxP20u16cdnAafxKZTtB7PE3UrTUvotc9dDfmG/1W1XLM5Zh6jMCyszYm
	wASprmXaPjvFsRB6ZopR5pxSJ/9RALLGnSzBB/Oe+zYl1MPHP3/GJ6cDlMAIehGgfvNbY+wePdo
	eXqDy+1z9DC9g0n6mWFQZCjCAYwbXjoh4RLSH2HH
X-Google-Smtp-Source: AGHT+IF5Ut8MJ8zAUyCb8AVk0z6u9UiN5JJ08yQPKGcjmzUc+KaB1Jq8ns9k9vAeYY6oX72UWORCxQ==
X-Received: by 2002:a17:90b:3d50:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-30863d237a6mr2935919a91.5.1744814443929;
        Wed, 16 Apr 2025 07:40:43 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-308613cbff8sm1654769a91.49.2025.04.16.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:40:43 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:40:42 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, sdf@fomichev.me,
	jdamato@fastly.com, almasrymina@google.com
Subject: Re: [PATCH net-next v3] netdev: fix the locking for netdev
 notifications
Message-ID: <Z__BaiugfGiVtB-N@mini-arch>
References: <20250416030447.1077551-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416030447.1077551-1-kuba@kernel.org>

On 04/15, Jakub Kicinski wrote:
> Kuniyuki reports that the assert for netdev lock fires when
> there are netdev event listeners (otherwise we skip the netlink
> event generation).
> 
> Correct the locking when coming from the notifier.
> 
> The NETDEV_XDP_FEAT_CHANGE notifier is already fully locked,
> it's the documentation that's incorrect.
> 
> Fixes: 99e44f39a8f7 ("netdev: depend on netdev->lock for xdp features")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://lore.kernel.org/20250410171019.62128-1-kuniyu@amazon.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

