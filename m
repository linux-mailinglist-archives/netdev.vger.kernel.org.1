Return-Path: <netdev+bounces-88886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748C8A8EE3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0431E1F221AD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12E71734;
	Wed, 17 Apr 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rbRFsGLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F479C8
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393234; cv=none; b=F8NmquPkLxqCHExVKcLYPmTO/yWzCazsw7CSiZy08JkC6iufaizUik5ySVmDDdVJRKYWkLkSyAKD0iLyMpbyoD6Ts+kKRTSIFOzK/kSWHP9QW++OaQFEzPDA4wqjQ0SM9wf0za1sjbFgMv3YEW5aM/CWbDYt2AjSZJcH+8ns12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393234; c=relaxed/simple;
	bh=KTA9SsKIBbSi82lEX/ZexJl+60vj7LolZfz/m2xDqJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBagidM3yhQex8uKatseqeWlAi1Cr8yEfLGOOzBAKYyVAlKPn8DxUub2dd9JGUpQqNjemk4dAUF7OAe8F3rdteXFuaRirFORw81x41KbOwkGkx/PURhtyY77doWVR3t9py24thWj2/GQZePV1HsqoX9F184EeZoNP30z7OvmhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rbRFsGLz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so276986b3a.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713393232; x=1713998032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R52rYT1dARSSIRt9sQy95dOt643R9bbrWQVP+MHoopk=;
        b=rbRFsGLz4IQScc9ECB5U9ucmdttuCQlqiiagcyWvt7xtNRqopZtfb8ZViyHdaJRAxc
         l80zCe0HE1QgFwRzsE0JaxTwkwGhCT2LsQyR9qsIzS16pcKmYWQ6bfvuRjN9ZFmjl5a3
         RdkkImN0uK6n/YjCUYSGB7XgDcgFVRspkKcq1Y3Fo7Dz6jDNnIwIWv9bYj/AdapFRtD7
         ldGG5PaP5xbUpz9JT4Ttst0mvircRfPXI2jEXyjCl9Mh4ogkXGYWhVra5zY77Kkm2KyT
         ZX+T7wBBUGFa07ghpxNfWOxtHcHxgA7qt2vQN706qn1Z0vMOXWsR0/w8g9H//E0CVv5s
         ZV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713393232; x=1713998032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R52rYT1dARSSIRt9sQy95dOt643R9bbrWQVP+MHoopk=;
        b=tKQwB+7Rrj19rUK3NSaqGhnQLTjJHN462AAHp0FrDygQW0yPUqPxbAWkyMtu7zjPlK
         GhGop6AFmTfCr6lC8eCSH7CKcifHnc7xK9NfNwNmlHheDySwPio5bM+quyVew5P0FlXP
         OqtBqgyBRP4TprrS32CNste+AcZwJiJCtJsWCsdQn1XL+NNtXnVvodiXXW2cGkT/oWqF
         RbpE9MOUDpVowkbNxvvu4GSiyOGs+1iCkPl3o+PLrOYIw5ki1KEw0wdox6z5O2bQ3DPK
         tt1kiKmmi0iOk25Q98oRU+M9ljft4OCIr99UkdumhL2TtVTygYhX5h3eMMr+8SDCBaWS
         t2hw==
X-Gm-Message-State: AOJu0YxhfNppsz7u+liwtHqB2eynHvy236Wo3M9yWg3xSNUd1H7Pu8lm
	8ou+uBknknBlk8JsHfFWNxR8zs33F03WE7reIzDTIMzIrj2Th0bLePWqQz3olMQnIyljJF7Nc5v
	K
X-Google-Smtp-Source: AGHT+IGkkosnm/uuBWwlgZqJZyYC0+6woyovDsEahboigkTPZDdPdxIe2jWoWGC7HXVnjeLw0IM+qw==
X-Received: by 2002:a05:6a00:1d0b:b0:6f0:28a4:a6ac with SMTP id a11-20020a056a001d0b00b006f028a4a6acmr1200649pfx.8.1713393232022;
        Wed, 17 Apr 2024 15:33:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b006f0830a298dsm174990pfn.156.2024.04.17.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 15:33:51 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:33:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: 2nd RTM_NEWLINK notification with operstate down is always 1
 second delayed
Message-ID: <20240417153350.629168f8@hermes.local>
In-Reply-To: <DS7PR84MB303940368E1CC7CE98A49E96D70F2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
References: <DS7PR84MB303940368E1CC7CE98A49E96D70F2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 17:37:40 +0000
"Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com> wrote:

> Hi!
> 
> I have a system configured with 2 physical eth interfaces connected to a switch.
> When I reboot the switch, I see that the userspace RTM_NEWLINK notifications for the interfaces are always 1 second apart although both links actually go down almost simultaneously!
> The subsequent RTM_NEWLINK notifications when the switch comes back up are however only delayed by a few microseconds between each other, which is as expected.
> 
> Turns out this delay is intentionally introudced by the linux kernel networking code in net/core/link_watch.c, last modified 17 years ago in commit 294cc44:
>          /*
>           * Limit the number of linkwatch events to one
>           * per second so that a runaway driver does not
>           * cause a storm of messages on the netlink
>           * socket.  This limit does not apply to up events
>           * while the device qdisc is down.
>           */
> 
> 
> On modern high performance systems, limiting the number of down events to just one per second have far reaching consequences.
> I was wondering if it would be advisable to reduce this delay to something smaller, say 5ms (so 5ms+scheduling delay practically):

The reason is that for systems that are connected to the Internet with routing daemons
the impact of link state change is huge. A single link transistion may keep FRR (nee Quagga)
busy for a several seconds as it linearly evaluates 3 Million route entries. Maybe more recent
versions of FRR got smarter. This is also to avoid routing daemon propagating lots of changes
a.k.a route flap.

