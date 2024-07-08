Return-Path: <netdev+bounces-109958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD492A7A5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41841C20BE4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A80145A08;
	Mon,  8 Jul 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfVdkc++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAD13E41F
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457607; cv=none; b=mCkGxeUvhqc8ZHCteIF6ctl7ucfBSBvP1SVazzEJmlBMEnhhjnXonFTSQvO6M/82Jb86rW2jaF1tUvsKq89qTq/qswqqw6vMfDMWh/1uC/RyspeoT7Ek1bmkzqGI/CmOL2oRVKtxJajc6n3WrILmfW+/qbCjEHtCy8UoarrIerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457607; c=relaxed/simple;
	bh=kiKW1t5LZA95CizG+2tsYIoDS6pAKL3RGA3QS652Qj0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HH0KWa0lgwaaRbgmx/EreeYVvZd+RwyV9m07NkCPUv1o9NuBrAscvkpl8kTGox4yzm2yYwv8yE712pQ5b+AHFWs6HIFi7RwS84WRgmyB+xehjrWAiYmjVEuuSmrgU4ZMe+0tI9dOFdIsMWCMZWfGKFeOFeyHLdI8mjcKgabCzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfVdkc++; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f02fe11ccso116354985a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720457605; x=1721062405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwSp1uk7BhPpusC2EISZChXAexdKpE0st6kZYD5ETpM=;
        b=VfVdkc++RRZX+oIBbmUHeTrUL2xkpLgpDuRzqc1x8GDUvNJAvjIWq3gYrV7NpslXTh
         53MnzwXvytbFLcZrFccplz+zojA/1qY6x+NzlK72Ka1RZTInUHzv9JxVldj0op8ujFyt
         UNGRG8KVZRZr6xULEbbFOsEn+MsR0hOp4Ogq31M9Z5tTF2cGMiFkJ1v+EPGOWTGFaDTU
         qlYs1P1ckw34EDFinDDODb7T84GCoznPz6pfNFECtLyEI6JrCraI/LEotLMdMMmCzHWa
         WkKGF9dnuBt6tLOOwBq5dj9rTA0axwGfU57iN00Qj4m6PViNI/yOEl6DnJAQzFjkcErw
         3+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457605; x=1721062405;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KwSp1uk7BhPpusC2EISZChXAexdKpE0st6kZYD5ETpM=;
        b=TmBhyl/ElS+HmtHnqn1JRJotl+ciGE1fA87qfoNSr/DJ78rKy95ukZzFmGuABuCb6o
         yop12jpbjSDxw48BO0feJwloFTg6lh0ZVUkNetGu4NIYt+o5Jh3COCMG5R8EaZjUmy4O
         CXLyEWTwHEQfPikTX3eLrEiEGJlZyHb4fNfxOYoNYhTzLduaRCLdPZF+qWv/2TuBHvhz
         B/f4vHQexdBfXT0cHYgzDWwx1M/KJrKEmZZobEZLoRZaW1k+K+ZJx67TDBfRO7thW679
         fjY3jPI+7hjlYkOHiFOAMImzTpWBEyCkvEddlFTcFa2U1Mr1QdCExtLxq7CddPKHUQlW
         gOHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7aeFXypC8TBJtTpzh6ARTmIKcnVS7Wird8TR7A3Tizy0GCxv8PZ+C/UM2yPm74DATVRrk+3CXUgxd9H9TKjHlkuTdVcZ0
X-Gm-Message-State: AOJu0YywTohVxrdeYaiKPQ2jXrTgcSFMZM1BYDFYpDlZu9y1E3lSjVyT
	aOlxzc3xiJ3Ub4MCyV+heYk7CndTqKPG2BsqpV0hfWJrW1VyE7YU
X-Google-Smtp-Source: AGHT+IGwqANMm2VI0/cZQ/5K5nLQGZrlLM8DZS6cKooYmnkY9na3gVHpkIvLO+Dgw3hlmb4fZGBOtw==
X-Received: by 2002:a05:620a:100f:b0:79f:1002:f29c with SMTP id af79cd13be357-79f19a6f538mr9554585a.21.1720457604637;
        Mon, 08 Jul 2024 09:53:24 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19086b38sm8083885a.90.2024.07.08.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:53:24 -0700 (PDT)
Date: Mon, 08 Jul 2024 12:53:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 ecree.xilinx@gmail.com
Message-ID: <668c1983f09b5_1960bd294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708091326.4e704b46@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-2-kuba@kernel.org>
 <66894c659cee8_12869e2942c@willemb.c.googlers.com.notmuch>
 <20240708091326.4e704b46@kernel.org>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: rss_ctx: fix cleanup in
 the basic test
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
> On Sat, 06 Jul 2024 09:53:41 -0400 Willem de Bruijn wrote:
> > > @@ -89,6 +88,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
> > >  
> > >      # Set the indirection table
> > >      ethtool(f"-X {cfg.ifname} equal 2")
> > > +    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
> > >      data = get_rss(cfg)
> > >      ksft_eq(0, min(data['rss-indirection-table']))
> > >      ksft_eq(1, max(data['rss-indirection-table']))
> > > @@ -104,7 +104,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
> > >      ksft_eq(sum(cnts[2:]), 0, "traffic on unused queues: " + str(cnts))
> > >  
> > >      # Restore, and check traffic gets spread again
> > > -    ethtool(f"-X {cfg.ifname} default")
> > > +    reset_indir.exec()  
> > 
> > When is this explicit exec needed?
> 
> When you want to run the cleanup _now_.
> 
> We construct the cleanup as soon as we allocate the resource,
> it stays on the deferred list in case some exception makes us abort,
> but the test may want to free the resource or reconfigure it further
> as part of the test, in which case it can run .exec() (or cancel() to
> discard the clean up without running it).
> 
> Here we do:
>  1. constrain RSS
>  2. run traffic (to check we're hitting expected queues)
>  3. reset RSS
>  4. run traffic (to check we're hitting all queues)
> 
> so step 3 runs the cleanup of step 1 explicitly.

Thanks. I was wondering why this test calls it explicitly, while
others do not. Had overlooked step 4, which requires the reset.


