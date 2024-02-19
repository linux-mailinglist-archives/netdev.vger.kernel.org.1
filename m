Return-Path: <netdev+bounces-73098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CA85AD7E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97D4283C9A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA194537E5;
	Mon, 19 Feb 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wZQgpTdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99051C47
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708376102; cv=none; b=kq9O8hUKeCqo/CgN+FHt5OV+RrGaCoAI36J6eHYYmPhFODOMbnWLqG0oo3LJnkm0dY4duCPtPFPDKZuGk2EjmR1B3agre0RAo2eJuJ/adlLoVK921rCIK7zur4JvvD2zH4OjPARe9c70AOZE1+7dgrgitkQkmUgoNYGKPRVueBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708376102; c=relaxed/simple;
	bh=PRWFNSl5rdyh0LIam4lOCvZVzrH50yS0VHN/syfc6O0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QVaFOkKLFiYMIJ+Q/Tz6HyLWU6r06mBBotSaJXR8g62Qm+9qHJPhlXxzpvfKyziSq+PPjL/thK2cySPKOmSmpLJ089zipY+SNNyvJ5jn413eyzc6lEPbs/2WDdBhHuDjWdOaCwJPih/Dxv3T1I46d0i5svrUEw9U6m8LxF7kGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wZQgpTdg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60853ad17f9so7549927b3.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708376100; x=1708980900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRWFNSl5rdyh0LIam4lOCvZVzrH50yS0VHN/syfc6O0=;
        b=wZQgpTdg1IXJW+3pJz2pDeRelZJStxFfeYZwj1TCN3I9wndQLgPucomWofYrPaG3ye
         +/i5OWWAQwr8w3FVbI4IQli6X+Y9dQ3lgZPko67X+9SlAG5U0R0Fa3g3zS5yVTkgRHc/
         Sxa6Wj6TkMok77tlYPsMR6ptSswjiWksNxA/Bx879L2xSJDBetC2k2JeEbdptMOjbmh+
         C2pVGUpE6qYSeOKe8OjSjNHGTc2EFqEOU1fJACWhjaWcM+vqfFpwm42cqDTvBitgmnZz
         Rwlpb8/XaRaWmpJj5UX8gewFS0sfKbZO2WjGobr9/dMI0eshFakhNB9rDyc35HJA28po
         YXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708376100; x=1708980900;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRWFNSl5rdyh0LIam4lOCvZVzrH50yS0VHN/syfc6O0=;
        b=EjSNhlR0DS2BuAbnXv2tEDx3VsksCW9FlaQx9gSeFVrsLtJiLXB1rqCwJ6LBe+f/Gk
         IVnCX6Ys9Vu34lGQY8Yvs1JuOBjuO37JjE0ZCu1D9WC+Wvul562U8bT2vOkObUIXYuR5
         NMylS9pzuvUHqFcF7XS2GGf9v8tajhaWYcv+UxDsaOj2xSN9TmzgRX5mKwtYy7rIybCo
         IBliFnc5BpFbCh4nlFHhWRPeSwewRZaWrpP3hPlBFI+4gEKVT0BHkRxlo3DnJErJouc0
         7EccGp5/QiTqoJ2gOxBegZTzOyn0zmm3of/UJrUZBcEx28KsDod9DlSmgZ0cELaWs5tT
         MJpQ==
X-Gm-Message-State: AOJu0YzbLUQK/T1WDNrMcyd2dc54pXFruzCjhliqD5zTE6MZECJqAwFl
	DanKRfEhCmQFfWUQmo33tvHoOdZv5Zi2nBJlUGXBpkG1ULdHdwUFIWpHbqhnM4g5H9PS/g6jk0u
	bU0yh5TDqqDDs/20Z+VYijecPG8Ys6NUc4W2SuolPiMYMPiZe9A==
X-Google-Smtp-Source: AGHT+IEYs9O4Ab1yXvBQtfWhC5ZqPyatv9UEtkAwagoVjMYA+WQEKbhT/qSO3Lxx5Ueqx9uSy89tetRorYJ3R+zsRQo=
X-Received: by 2002:a5b:18d:0:b0:dc6:e75d:d828 with SMTP id
 r13-20020a5b018d000000b00dc6e75dd828mr10375199ybl.18.1708376100043; Mon, 19
 Feb 2024 12:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Feb 2024 15:54:49 -0500
Message-ID: <CAM0EoMm1Vff3hLrLEySnL=bfa6vr3BRJd7L+TjiN5zsAY_As1g@mail.gmail.com>
Subject: CFS for Netdev Conf 0x18 open!
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, lwn@lwn.net, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, 
	"board@netdevconf.org" <board@netdevconf.info>, linux-wireless <linux-wireless@vger.kernel.org>, 
	netfilter-devel@vger.kernel.org, lartc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are pleased to announce the opening of Call For Submissions(CFS)
for Netdev conf 0x18.
Netdev conf 0x18 is going to be a hybrid conference with the physical
component being in Silicon Valley, .ca.usa

For overview of topics, submissions and requirements please visit:
https://netdevconf.info/0x18/pages/submit-proposal.html
For all submitted sessions, we employ a blind review process carried
out by the Program Committee.

Important dates:
Closing of CFS: Mon, Apr 22nd, 2024.
Notification by: Wed, May 1st, 2024.
Conference dates: July 15th - 19th, 2024.

Please take this opportunity to share your work and ideas with the community

cheers,
jamal (on behalf of the Netdev Society)

