Return-Path: <netdev+bounces-127562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AD975BB1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F80E1F234E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9F1BBBEB;
	Wed, 11 Sep 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu23TnYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A31BBBD2
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086320; cv=none; b=LyuQtG3IoEzG2oLDOFaNYwyG8sWIR5RGX0c/VKjkT/cgmgONKqSzwOiUe1ngyPSNQbP3Xjp8LN5JptUPa18W+OCeFzpqYUYOeT1Yj4Y+hNiODkosbROwyFb9/+ntXsjBFTxg+b7RkRl7v1Yv8gcmtOIQh+UJ7I+xHzrDgTsY8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086320; c=relaxed/simple;
	bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFhiznXNvC2c8yVQP77iNmpVos6wnklJR7e34mrCu4Jo2a3jQ3SJCZtw9p9JalJsgrAtczSXrvHTcuC9Q2+y15D9BIR3RtP8IGNM4j+BxYaNv8N3N+MLUlDT5DyVuI36Ool2M0/pONCcwB3IWvBx+hby+bE1l01d3Yhav6rm030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nu23TnYP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso226270a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086317; x=1726691117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
        b=Nu23TnYP27d09xVXdL3O8USoIL42HV5QDrMrIvYQpFWsCg7O3xAHJQnq+c52vEBsvv
         7DJZiyeBT7+7AdP27EBP+q5w16YKBta6kO0AGkdK/d9ILUOauPnksS5AbtGBd8NtHA97
         Nq/Z4hMO3a0uUWFytu131bweEwGS/Y8HRolTg0xHFr9VqgG5qrvifIPIHI1swjWZpS/J
         WyROvnTMhHvxv4kgPGDEY4pGjSPfCGzkEMLOwjQQbzJm3vdGU2bTrQMW5Gw16SfwawtH
         AjCHUL/xStYjeZ56PPQqKKFrtMDIl60oUTHe0JIkPpv2h0q4caEWAAkqZLMUncXNDEQ4
         FTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086317; x=1726691117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA7u+UZJCFjVYkHzh9rRqVi/HTXF1QCq70f2BOwy1Rk=;
        b=ZTk9Qw60wOeb2JKlj4Ei6MIJp4DfPHL9f0f5LRR59mKKw015Y80pF2OTJh2frhWcKh
         n3C0zhW1eTsNWXM9MsMzHhQBeYE4dG20Wz8VANdVWXafJAnVlhgU/UMmie9m10Hj7uv8
         D/ixz2EHzEDqeVeo5KtiXzbgOsqsGkcfpoAKm8ZIXd0vc8+ull+2SVBmDwOvRocIwDgQ
         AAVKTRry2VNQMTJZfiKAVGT20dQRLkguDlXi/6I9MD0rJvNudleg51qWyxkEQs9ntVkN
         HTwaMia5pxMBUOEyxnaYBFnLOjiRWkKv+JlufQuyIpkzfoJXY5e40+8P37a9qJGUHPzE
         khpw==
X-Forwarded-Encrypted: i=1; AJvYcCVAM1wUNWyIk6g4la525F5PmzBamE2sgQ1LYHp1jWME/9YbRWXN4UGYvHasrN7O5ejFSZAuGDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ3+Rph1UCK7sTI3GrFQbeaBPU+1KV99PF/E0qgGVjwB9Swbu
	te1WlJACb/bLutJHAmaYA0LFJz2kEg8KG//Gakte5glqKtemahlmVwv940fJBevgWFoFCwokGYM
	vu5S+SHTyG6C6BY35mGfbY7JRBPvE19J1zfw=
X-Google-Smtp-Source: AGHT+IFMjRe77yFuysdfaosrC8DOmjCWlZJ2RFEl5VdqH/ls60M/dHZlo0e2StLsun7t07Y99I8+FEnKM3PFKoVIoZ4=
X-Received: by 2002:a17:906:d7c7:b0:a7d:e5b1:bf65 with SMTP id
 a640c23a62f3a-a902943596emr54029066b.21.1726086317086; Wed, 11 Sep 2024
 13:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:25:04 -0700
Message-ID: <CANDhNCpAOQvUEg1SSqmdLevH6JrnFnu5qib8p7zygt8LFcCgYA@mail.gmail.com>
Subject: Re: [PATCH 09/21] ntp: Move tick_stat* into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

No objection on this, but I wonder if it might be worth dropping the
time_ prefix when you've moved the fields into the ntp_data structure?

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

