Return-Path: <netdev+bounces-79650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220A87A62A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A7F1C20F8A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9CC3D3B1;
	Wed, 13 Mar 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1553wrsl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8883F8DF
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327357; cv=none; b=awv1hvDlnDlGDW+edaEmisPmdjWPH22IKNWMDL+jZoFq4hzPUkMjyd0PN16FBvbj0JUrL1qf8qcngWDJaZLkoob2lOXEzyGrPk5Nxfi0ffOp+oqnhmfgMyDD7Rv+2/JH4rqltrEz7DWEC3lXO7H8ZfCffpWPBLKEYR2sA+4jb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327357; c=relaxed/simple;
	bh=lb/fxTau6774fMOnijhMJw5iOwqc/gtg8hNyEEqyOVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTK2axY5Kq7Ar4u/xAAdupTGDEiSWLSSPQgbnjyr3+UT4475Of1mN+zLkPlYdbBAYWEgGSM6PVpXdcx6M6C7f3SV8KnO4jS+bmtomsJaEBCb6vAWLxytQ80zFGSRFb59znJOFGVm+T+CVGae3isFNsOj3tPLSILXS6ZYK6S6Sek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1553wrsl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7160a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710327355; x=1710932155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUbDfP+sLUXM48nDyVWIk/glEsJoVRqxJc+rC78QgaM=;
        b=1553wrsl2b8c/TdPnqq4O2k03ALxVyO4IUt6Dsas092iycU1s8wjoHbp53r/CreTzQ
         qieJ4qrhHKBWw7roD5eKjLh2LEYGOkx1PODcR66CQ98UKZ7XO26b+UW9ZLmQ1Bv9IHXm
         63LWxaONTXcyTDXl353XWTTrXAuk/Vtwl6UB/i7hTkWeYaG1zkfkB2URkUVk/NVODlzG
         GNyR8ReRUmW07OmJGtHINH0iaL5ugukvDMQf+u24CRXLZMMuN3xFrR0VkbN0Emz07POY
         bTSLcRWhIezruy1QxP6U+JRzOJ8BKTcB13kGfN927GffC/egaMakzch3BdBvijwSCgnV
         EN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327355; x=1710932155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUbDfP+sLUXM48nDyVWIk/glEsJoVRqxJc+rC78QgaM=;
        b=SJcDWRp5P6S/JW7u5kN4Dx4pS4HaHmEWjCSjcpWBX1vKWpWonNNozmF+j43McSHzu6
         1hXu4QOxKSLe5A00GoSqvwW0zlfKiUsoFwjdR6wrW6jUVF3wjdq+/ip+IfxttagqRHNK
         4BHEqTewatOLwPkcC2zLTPOStIbCt11M1pUsm7D949wwaGKcibDdg3BNJqRVWoIvZEz/
         JTyu4CxGXSXthGIn8pHebug7tjsDliXflNgvEq52LExzdVhpbeLD2TQllxiS3fo8xu61
         etPvh4VHTsi0kurxutY4GFqwvc+8cnO4GwVNTkQ0blWcNejYgtjaXOkrc9MatfHtnO3K
         ZmDA==
X-Forwarded-Encrypted: i=1; AJvYcCWtJFs+48K6AyGs5/397v3HVnU9U6N/uHQ5yH57rPdOPbNvbYuwyNk+sln+5IDLato/6A1c88guDhjsDZfuReqzzDqV4x/t
X-Gm-Message-State: AOJu0YzpVY/xLcbNCw9HXkROJklAWJYvtQWM7ycW9klwj3fzuNrz51NF
	4LAq/whcVlQVQG9say2ugqhZNPhnwHzFrVhk8sgutFgJ4jdE8k6ehhSU2aPmIVkljs0lAaFaN4I
	249th5gLKjq+tZgaiXHXHG4arRyb3/62dEGuKcR47YG064R6q6/hf
X-Google-Smtp-Source: AGHT+IHrRNQakJc4w7wh8Shn67Mfj+lyANmSwpYj0TzUp00xofQNBBhIPzQSMsCSrME7frjeeFuK5ZbFKFpyMEgJV3k=
X-Received: by 2002:aa7:cccd:0:b0:568:271a:8c0f with SMTP id
 y13-20020aa7cccd000000b00568271a8c0fmr125966edt.7.1710327354472; Wed, 13 Mar
 2024 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313094207.70334-1-dmantipov@yandex.ru> <CANn89iLCK10J_6=1xSDquYpToZ-YNG3TzjS60L-g5Cyng92gFw@mail.gmail.com>
 <aa191780-c625-4e13-8dc0-6ea3760b6104@yandex.ru>
In-Reply-To: <aa191780-c625-4e13-8dc0-6ea3760b6104@yandex.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 11:55:40 +0100
Message-ID: <CANn89iJNBHnCPNovYE9tjQT1eN4DE-OFOhE9P86xX_F0HxWfrQ@mail.gmail.com>
Subject: Re: [PATCH] can: gw: prefer kfree_rcu() over call_rcu() with cgw_job_free_rcu()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:28=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On 3/13/24 13:18, Eric Dumazet wrote:
>
> > kmem_cache_free() is not the same than kfree()
> >
> > Unless I have missed something in mm territory , your patch is not
> > going to work.
>
> Hm... it seems that you're better to check include/linux/rcupdate.h
> and the comment before kfree_rcu() definition in particular.
>

Replacing call_rcu() + free()  by kfree_rcu() is what is documented.

Again, kfree() is different from kmem_cache_free().

kmem_cache_free(struct kmem_cache *s, void *x) has additional checks
to make sure the object @x was allocated
from the @s kmem_cache.

Look for SLAB_CONSISTENCY_CHECKS and CONFIG_SLAB_FREELIST_HARDENED

Your patch is not 'trivial' as you think.

Otherwise, we will soon have dozen of patches submissions replacing
kmem_cache_free() with kfree()

