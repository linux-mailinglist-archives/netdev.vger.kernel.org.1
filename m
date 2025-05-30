Return-Path: <netdev+bounces-194383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF80AC91FB
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17737160A51
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7064323505A;
	Fri, 30 May 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYeEN0TV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB179E1;
	Fri, 30 May 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617653; cv=none; b=nSOCEkSJp6Vc4qRGAp+Z877CJAqH3ksBHaEJMO+Bqw9NN7fYwTlntnacIGxIaxUk5frzwc/mO5jB0WcHOHNmJCYmlDbo6tyhw49aYoHTsVle+ruIanPg87rHITE0eJpS0cjmwO7gmC+nCrglWD/8BOKhP92WcqbwoIZrQDjf4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617653; c=relaxed/simple;
	bh=QgCNti3HVuSAS1BZqkaTqpHk2m73Mm31QWe9D+r0Uh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFSi+GPlnUP6IlUUjnTH/g1NZPZ4Mupf4WyRWbiyLk/tk1OKeyhfhG5VopWWzBAeNzijQmwXHpkFtgFAV3BYmvM3giUd2AuHXIyQJAVSGEwpN4O7DRfFlnfeF33TDe2QIk8tgGmcba70VnpupvTsBej16rz21M/tLPTtJndMeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYeEN0TV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350fc2591dso13621565ad.1;
        Fri, 30 May 2025 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748617651; x=1749222451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6qdI8/H6FUFv6NVTYVjlRQps5Gkl5ZjJBcqTPMVnmg=;
        b=QYeEN0TVUYkMtTTsmQmo7xJUsddj3I1FNXBMtxy8Okk2BeWXAfebx2goSmcwMdM8SL
         P9Y1FeZm+t/rkP0qojun0Ci/Ip9t2EnxSd/fnogZdD1f00K0sRn4Qt/yTtbBLXrNVFcS
         qqlHsY38yPWotrDjd6ntRTGyyrFxPotJLpsfKGe4+ii0Fc9lTtwPAqNHF4abgPW5cKdw
         t9VU1xlFSI3TaazI/XvOKjQD//U2rG+Lcg1cghLIveZ5Nn74+kJmfPjve6O6K0XzjH2M
         vOBg9N+lXyoAwXThh68nqnjm68x7KTEjd7nY8PBeOsNTTqhJzU0+Gt9FExVkrS2oTiAu
         2JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748617651; x=1749222451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6qdI8/H6FUFv6NVTYVjlRQps5Gkl5ZjJBcqTPMVnmg=;
        b=pePlzSS0EqXnQ2Sw3zCiafb/psL4YgrlAeVWVVv63jjKSWQGaPDoP4WncRznpZiGzq
         e5ZtDo28lpG6mQkIfPvCl4RylrvTltnN2fAyUptNa3R+Y/ue5yWZERnK69YhGp1kcN7/
         bUW/lgDMrGk2+3biVf2aKQXST9MFkW3xbAXdyuqlCs4YOoBiPc3WE3xcWWIexkJYpRfb
         vWarAVQL2jIgOT8oLVHpvOGZTT31AzhLYDHcRzZU/G0OBY+LI32RlUytEPSXmH/4xW92
         G1O6eD6VENdK6aqEEXT5oUc78XvJfxMCo1yS5nRkw2tFnrstrakrfrasNOGfa1LL1iqw
         zj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWAmZ8IBylhO6i/T6HcgFr/6JcTBCyQ81W9DSVLSBlHlIn56IHaug5vsL5ZY0H4F/+zkXgDDyzmqPA8Hro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIShAw191LAGatdLhkrC2keknNv71zP2MYPZKJ3guKPsDkg/x
	YKku1FnYu8TICFzzVD+ZPx471Y4wlqWw1a0+AUukKAnwmtYwqVHjFmM=
X-Gm-Gg: ASbGnctbBs02Au82412xC4jWUgb44/VYCnaKA9uU/slwPQvuIUQWUZJQtrYB1PQaV8E
	ILP9mfEdwRQe8IUncu/RL9deGegU345hybdEJskl+SOmrY1HXT4qgTjyrOZFh/xQiCSWLgeObLU
	sqZkpENvw5nQBwQF0OsImZgHSx4P0iN8UScH8HlBEKdlOORXg1s1mT6M8gm14WrLMYjtTG8iHPf
	oiQR+Cyb7CFev04AWeQNmnnV/Mxq8yEwKiNdex5VprlHxlcGDNe+WIrHDBlu/0pXmqQick2Dvd+
	5eB5a9uXN8OV8Ai5KHBAr3lTJwjN//vXLhdxxrGfJGB7CP7xmdNtm+80DqRtfSfnTxeCzwfz+Yv
	9gXN9DRBqagYD
X-Google-Smtp-Source: AGHT+IGlTTPOmzXUsUpJ/7FdUyOJNuOAbe0a7n7VjK/BZAqbeinV1GZA6IG1AeSirgWPRHNewicsDA==
X-Received: by 2002:a17:902:cf10:b0:234:8eeb:cf8c with SMTP id d9443c01a7336-234f6a08adfmr117720865ad.20.1748617651021;
        Fri, 30 May 2025 08:07:31 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e29f865sm1328221a91.7.2025.05.30.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:07:30 -0700 (PDT)
Date: Fri, 30 May 2025 08:07:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, john.cs.hey@gmail.com,
	jacob.e.keller@intel.com,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] e1000: Move cancel_work_sync to avoid deadlock
Message-ID: <aDnJsSb-DNBJPNUM@mini-arch>
References: <20250530014949.215112-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530014949.215112-1-jdamato@fastly.com>

On 05/30, Joe Damato wrote:
> Previously, e1000_down called cancel_work_sync for the e1000 reset task
> (via e1000_down_and_stop), which takes RTNL.
> 
> As reported by users and syzbot, a deadlock is possible due to lock
> inversion in the following scenario:
> 
> CPU 0:
>   - RTNL is held
>   - e1000_close
>   - e1000_down
>   - cancel_work_sync (takes the work queue mutex)
>   - e1000_reset_task
> 
> CPU 1:
>   - process_one_work (takes the work queue mutex)
>   - e1000_reset_task (takes RTNL)

nit: as Jakub mentioned in another thread, it seems more about the
flush_work waiting for the reset_task to complete rather than
wq mutexes (which are fake)?

CPU 0:
  - RTNL is held
  - e1000_close
  - e1000_down
  - cancel_work_sync
  - __flush_work
  - <wait here for the reset_task to finish>

CPU 1:
  - process_one_work
  - e1000_reset_task (takes RTNL)
  - <but cpu 0 already holds rtnl>

The fix looks good!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

