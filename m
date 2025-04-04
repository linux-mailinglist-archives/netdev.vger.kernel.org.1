Return-Path: <netdev+bounces-179353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9397A7C178
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88042178FBD
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F720ADD1;
	Fri,  4 Apr 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXMvlLRF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA03C38
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783758; cv=none; b=jG3JiuqJQF2tfadYku3pQKGSpachPk4yds1qGZ0rqqo5khEHMM3/vvkQOWxt/RcXGd02aTv8J70oOZIwtCrYHm7ICVkAy9IB68d3cPMALnLUEukwrlyZ4smFy45Wc+ye+jXqc9Xt13rMX5uoq5jIQoux5TO5uQVHXR0WtBvwadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783758; c=relaxed/simple;
	bh=v24dW1KRhTy6VnXitE16MKAf4z2+rZZmShLbMWGtAOs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AqS8LN57DBZKEaIUaCaVj9nw4m0LiVA1cM9xqZGFPK+6AT2x0EaARS/P0AhbICm2o/9lFtEnitPks4bqcIceDoVq/DJ1vq3O3rwfipX0v6nV1qTrSUq83yHuURFAduxHpX6lY/1ycAkiM8DHT/KeXshTF+21r05e1J3nKPBaRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXMvlLRF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5f720c717so336500085a.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743783756; x=1744388556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC0QbfvI9zjHx8skXBEZo5HadNAibBkIJUKkeIYgOjA=;
        b=NXMvlLRF5hS8FSK+W1XYsb++aRN9pAtGpI1L1TDAYfOthPl0rfjpWIfbhJyvGpZLjr
         oo07qC3qTrect80rLqOPGaSeoR1jCHrXkxBI99SShI2mvZMFfEq9KOYifuqsRgU8H6qF
         J+OlCjCMsAW0HBiAVgp+Z8awRqYfxVBSvtvfghDSNYTIGFtShl4avL+Pf3nmTnXi9XQU
         8z+ROWKv0Ns4vI3P06hEVajZH8vkrhscaJm4XMhgCogk1cRuUc+7capQERJobLmztNrL
         HmPCjF6blfKh40mdhQlZlpuwHIOp6Rlz3b2IJZ+YIuPvZpcqqJBJ3ACPQ639O7tQIeEG
         BpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783756; x=1744388556;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dC0QbfvI9zjHx8skXBEZo5HadNAibBkIJUKkeIYgOjA=;
        b=VV2HN5SBa1j8NE3BZWbbZ04fIRM73kzSzGOax0jYH7MTlrW82e1b2kUWhUJNi3HN8K
         ghN9tSFBhUPuqo85ji2EUJyugnWsilcaG5xz4/CcbbSt4II+XYNeuEnwFtV+w8Xis321
         xxnSYuOxxbW3WV5Bn9+2Zthk2kK9PUOX6TWRoBUYca7BO4wsWKnrRRfxpRjbccF5+rxw
         5KXXdEvtbqgSpSqS8sJGTH59MJweUNUQ2HKREVpjvvLWVqIEO+uXoa8mFQa6+wEWyv3R
         Lf5OAtORYBl9ALOY49BhrF3q6PNSg3Le4rNzmPfRgd1KXTlAEi7uXQ7+OstQCrPDZjYy
         VpUg==
X-Forwarded-Encrypted: i=1; AJvYcCVtdCUWZ4PRBYIVvsHF8xHWbvWhatja+mwcv2fQhgxrhb7UhQ99du780WYeSi/rfRWfm96OeCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbf6PqKptTCygenwWarxxgNCuR/36azTtOKTNZZ0S+wQ7qJsMR
	b3newIRGl+rU02V0YwNbQH1qcX1luxP8T1i+2Z7j37ZLa4Qyl45g
X-Gm-Gg: ASbGncuVNNCuH893+ZaciCuIYGXliH+pUIeNSquTnII7N/ck2uUDwKfhODPnbtMRwyA
	67drpzXQXBU68Ip/AGUnWaT++zvwu7+lBxHzbdGuufYKgb8ZN+o8jWzQSNLMM2K3ki7A5bNhza4
	eEZfmwxRiODw904999Nmf58IL0jv3+wX5wqiPQ+HNkDvOfvbkk1wGyKeLAtjvYMtMfO5bZF72We
	LW6QluTD2r5IMpEePN1DeTXLqbN3+jayU2Bl4GH1cnS7jefElgPI3bQhLBT+zd5DcuQ4sK0C9rX
	WccPDuoMTgDit9re2ueBWjn5z1Mp/9sh/rqwuSgKF+OY7XAYDE4YmfaCDeQm0kMEUYzg7XE0NxY
	Bw1OFsyLAwIxrw0YSu6Nke/m002Fm3amZ
X-Google-Smtp-Source: AGHT+IEhFYYRvYk4Tf/vRZrnslBLcOm23aT052iXHAd5S+yQJStkcYIesKAfhIJITRN3HwDL6+lB5g==
X-Received: by 2002:a05:620a:2a06:b0:7c5:9452:4a60 with SMTP id af79cd13be357-7c7749b3db5mr531085785a.5.1743783755679;
        Fri, 04 Apr 2025 09:22:35 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e7354bdsm236402085a.20.2025.04.04.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 09:22:34 -0700 (PDT)
Date: Fri, 04 Apr 2025 12:22:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 gnault@redhat.com, 
 stfomichev@gmail.com
Message-ID: <67f0074a96bd3_1e86fa294bf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250404074938.218ac944@kernel.org>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <174377763303.3283451.9282505899516359075.git-patchwork-notify@kernel.org>
 <20250404074938.218ac944@kernel.org>
Subject: Re: [PATCH net 0/2] ipv6: Multipath routing fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 04 Apr 2025 14:40:33 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
> > Hello:
> > 
> > This series was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Wed, 2 Apr 2025 14:42:22 +0300 you wrote:
> > > This patchset contains two fixes for IPv6 multipath routing. See the
> > > commit messages for more details.
> > > 
> > > Ido Schimmel (2):
> > >   ipv6: Start path selection from the first nexthop
> > >   ipv6: Do not consider link down nexthops in path selection
> > > 
> > > [...]  
> > 
> > Here is the summary with links:
> >   - [net,1/2] ipv6: Start path selection from the first nexthop
> >     https://git.kernel.org/netdev/net/c/4d0ab3a6885e
> >   - [net,2/2] ipv6: Do not consider link down nexthops in path selection
> >     https://git.kernel.org/netdev/net/c/8b8e0dd35716
> > 
> > You are awesome, thank you!
> 
> Ugh, rushed this it seems.
> Sorry, Willem.

No worries of course.

I just did not see a more authoritative Reviewed-by and was trying to
better understand the code. I trust it's fine.


