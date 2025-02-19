Return-Path: <netdev+bounces-167781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8321A3C3C1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945F1176C35
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D291F8F09;
	Wed, 19 Feb 2025 15:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48C1FC10F;
	Wed, 19 Feb 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979412; cv=none; b=WxyZx6wq64gvXrKAMk6dt364MAQrcI50Nb6l608g8cEQkh4UoOBKcH/wK8f/pttG6vooD9VwaCWwkvyTkntQOK489absAPRAmCpFc8pUZAoI5+JWbLwl9zNkC9PrsRMu8/HTrJhzPQiWWn5sO2B+VE/qs844JlGAw9KUDTuK0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979412; c=relaxed/simple;
	bh=Ujy0BIPtNrfND0xHnHIFj/TLD1JGmnJppohKxkoYFzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKCklLVr9A5aC9VtAYQWzZ9PMG7h8gUzjyvAXbzDirOkgCjzQEhyKHwNPgW8w5Vnbe1habLHHBrsFUL2DK7k6jmZCAoJwlxadj07I9AwqVKK/7lEaVl4JG46ye4evYf5MzHo5erAFYZwCYacO81zqGnbEqgablSC6D1DmOnP7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so9311231a12.1;
        Wed, 19 Feb 2025 07:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979409; x=1740584209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6llFm8J1sbZ3d26kndvqAhLtdSFqZOZdKTBTtPApNdc=;
        b=qPxgHraFt0b4N7GCkuHKC6Yowk0aYek5kgKCEgxAkImzbvET1zia80THI0rocTqdCL
         kk0aY0It6kNiLlhSg8TJy+PxDo6Bnaxvh9aCGkOEHiPlZYf4KThi8bgPyJpZHbgyB5cQ
         7Vw0mdfM2kKlqyjowxlTJgSj6e3JIWyMyum5Uv3hc0jAFioWeZtrXJIVpi19JiEj39jG
         MmcSWL3iavOU9+8GAAYwqaTgM7XLWItBQ7doJDNRpnMFvmY10dntZwXuJnYoOAZ19TXS
         97+ZRXHI9tUT8IH2yUNYG1OXPPQyXEpap+M9unDIa93j80pEU5bFKvYEsi1JMG+OB9Yx
         F+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWgipPcmCwCxkETfDtt7XenCmWq/wJBP59TCpB81EyD8jpzEcIqSmz4Bu3zOOj/UrU3XgLg7Uv@vger.kernel.org, AJvYcCVYqdhV+Q3GJNGFRTigm4aRPFkl6PWE/UmziwQaywDK8vgxH4I61hQroX4eDtB6EawgVX6ksCT+op65huw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUHHQ3DkB30OFdB2Coul9eBzEyhNkzKuiW9/Fx79xnJPKwtaE
	y+xveQai5EbDIFBlE8BU3INej6aYdPgOGwtQLJKX0foXwGd3X5mb
X-Gm-Gg: ASbGncscIDURcbVbrFSTaxHi8Y9OwOyaEqHqHWWeeag55WBjo77taUgRgNHuP3QN37N
	NrnQZsWYl6qs/c6zOllWPCteX/uiTXXwJEai8R5ngwLqbdIxfyl8aKV5r2uJFpSyBaowfzKgWiD
	0shWNJhX7V205oRJDz8Ao5pNyX8hbiFa0SPOanPokyEaSTtuQOFqw2t5ZdD5xW9SyF70mEfZ6Pp
	NeFtOA6UzIliA3KluZw/AxS+RZ55yvPE77her946y4VH5JvTGjgJhzpEp0kT3x6ArSu+JK6DJxT
	+uY=
X-Google-Smtp-Source: AGHT+IHLbbKT+NeJwzgMUAtja4qR1bPzV8ZDiBggz1Xb8UKenPMjRNiG3pGusZx60PHjyIhUvsHq+g==
X-Received: by 2002:a17:906:314a:b0:ab7:ec8b:c642 with SMTP id a640c23a62f3a-abbccccb77amr355748566b.5.1739979408746;
        Wed, 19 Feb 2025 07:36:48 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4542e7fsm532798866b.139.2025.02.19.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:36:48 -0800 (PST)
Date: Wed, 19 Feb 2025 07:36:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2] netdevsim: call napi_schedule from a timer
 context
Message-ID: <20250219-astonishing-nimble-wolverine-1300f0@leitao>
References: <20250217-netdevsim-v2-1-fc7fe177b98f@debian.org>
 <20250217115031.25abfaf4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217115031.25abfaf4@kernel.org>

Hello Jakub,

On Mon, Feb 17, 2025 at 11:50:31AM -0800, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 09:35:29 -0800 Breno Leitao wrote:
> > The netdevsim driver was experiencing NOHZ tick-stop errors during packet
> > transmission due to pending softirq work when calling napi_schedule().
> > This issue was observed when running the netconsole selftest, which
> > triggered the following error message:
> > 
> >   NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> > 
> > To fix this issue, introduce a timer that schedules napi_schedule()
> > from a timer context instead of calling it directly from the TX path.
> > 
> > Create an hrtimer for each queue and kick it from the TX path,
> > which then schedules napi_schedule() from the timer context.
> 
> This crashes in the nl_netdev test.

Yea, a nasty crash. Looking at the crash, it seems to be  disabling the
timer before initializing it, and timer->base was not properly
assigned/set.

> I think you should move the hrtimer init to nsim_queue_alloc()
> and removal to nsim_queue_free()

That seems to make nl_netdev happier. Let me do more tests, and then ask
NIPA do finish the work.

Thanks!

