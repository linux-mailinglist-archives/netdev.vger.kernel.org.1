Return-Path: <netdev+bounces-143277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA49C1C6A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95749B23196
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE51E7C13;
	Fri,  8 Nov 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVSCtydw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99951E47D1
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066276; cv=none; b=KiCh32/2LSDt7m+PpCIHEL5f4ZMrpwrvxlYMAEpofhgOkrwGz3H7shpik3tRtI7+PRsMjVAvqN7SGSQDL+cXA+xawxAGgNdFHF1G4ZhjLM6uyeZ2DBVZ4p0/bHFzUeyawTnrKJOAYIoiGcul5ExGzjukNJ0rZGtH6Kpmb4k2idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066276; c=relaxed/simple;
	bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaBNq7hCVUg1d619vKwGsRu0Cv9dxWSdQjt+9L+aI2HltDo6slsxPpD9ti9Cc0Dyr8SyVE+oZDKCBOWwAeH6/r8qxmtgQtjhuJRa/7qoaXJipp6dM83AnqS1SekNQj7yo3/Ur8bhVhV3XaGR41BLcP49SDoIszBlHdXk2Q5bNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVSCtydw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731066274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
	b=hVSCtydwz50YxxfowPm7sHvuEl1gDU0HJpIJ/OmxOSVN5AA02m02JA9g/xdYSzWAfmzubl
	/pgvHRMG6njOy9eUE0SIFcrYuFLaatUgXpzuusN7G/mfuZ3uEFRldynarQx9RoYsYPXSTT
	BcFw4Mty8MqhbWh2aFEhLZcdRsu98WE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-rNTGkcTmNxmLmpDFfhWxRw-1; Fri, 08 Nov 2024 06:44:32 -0500
X-MC-Unique: rNTGkcTmNxmLmpDFfhWxRw-1
X-Mimecast-MFC-AGG-ID: rNTGkcTmNxmLmpDFfhWxRw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e9b5209316so501450a91.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066272; x=1731671072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
        b=shkdseaFFBLpmFLjn0cpPDOP08GMFNcJwEpejFJZaxoLvjWoN109zThpi/vWw9Jqz+
         lx4V/FIGXc8ReLkEteoVwmoR0cpYBdDblfnadwHwJpc42t5XulXirPfsMgrHxkUZiuLQ
         cNTUZ/PracMIvP6ECMJIO6zr/AHn2uvMvpzZr32qHWJFeta0v3TrhYt6RJbIy28jjyUM
         2xUNGUwONylxUIIsFjlaywCwjbFgdY3ZYfu5j+hWi0SIq7GdmwegA5vV6Wo/KQhWb9kw
         Fo6rIySk4nSR4jAH55fjNWCWl0i/y0PTRphnm5/imNp8tQQN9duxZW/X3peTqJfAHZ3Y
         L6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUmsHwMT5TVLZGlNaQwR11RgWYeQhP1l44D8kILXUmNi5v5n85sVl9xf16RKghRqjEz8lM+oSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddUbHWzwPrkLn3slNJs0Yv48nb1MszbBtDL1zuM0dpp9vKXOt
	cIa6dsn7O/7YoyGVcAKnIrYrQvosIvO86BzjunogKydATJCFkIRRQWb0cTAfGvkTseoD1kbuQzK
	ZbpYNU7+JIttfzEgE3f98cyq4EUy7xLeijelkVeyfHKU0euiZxAi/OVJWGR6DmWb3wSXD2EdLPq
	3c68IQmwKL3wVbyLPSkoKd9rmkaOkl
X-Received: by 2002:a17:90b:1f8f:b0:2e2:b02a:1229 with SMTP id 98e67ed59e1d1-2e9b178fe37mr2922941a91.35.1731066271837;
        Fri, 08 Nov 2024 03:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxIMFhFEJaXhMKyQro+WyOM48KyqyrmXQzVcAxRO+eiRvB7RVIYRHANvMBBHAupPuqRNnBIAp5H2+HfwwyoV0=
X-Received: by 2002:a17:90b:1f8f:b0:2e2:b02a:1229 with SMTP id
 98e67ed59e1d1-2e9b178fe37mr2922923a91.35.1731066271591; Fri, 08 Nov 2024
 03:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106111427.7272-1-wander@redhat.com> <20241108072003.jJDpdq9u@linutronix.de>
In-Reply-To: <20241108072003.jJDpdq9u@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 8 Nov 2024 08:44:20 -0300
Message-ID: <CAAq0SUnrtYadVZb=2G5PW0dBJxovzS2F2841-gCHqSp_5VgsPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for igb_msix_other"
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:20=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-06 08:14:26 [-0300], Wander Lairson Costa wrote:
> > This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> >
> > Sebastian noticed the ISR indirectly acquires spin_locks, which are
> > sleeping locks under PREEMPT_RT, which leads to kernel splats.
> >
> > Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> This is the only patch.

Hrm, I had other unrelated .patch files in my directory,
git-send-email might have gotten confused because of that.

>
> Sebastian
>


