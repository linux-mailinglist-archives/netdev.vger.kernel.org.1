Return-Path: <netdev+bounces-194712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3AACC131
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3697316AA21
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CC268FFA;
	Tue,  3 Jun 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="VXsIkSk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FD1F4C84
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935625; cv=none; b=oHtimZBtta716HDt+ujlMKeyNcqdtHfmEAoPNtSK7jXp93Oy72ti2VuBohe2okW5yzp6LizeMBPnaQv9ylzcwjijVkIZzs5RplIBwwHB4gUVJ58prT6IioOXzL62t8pg3oOzoDxLDZW7PR6pBMxjCpxMMcALwz8KOblMMgKSWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935625; c=relaxed/simple;
	bh=Xoq+mK9zf0H8LenpVm3kOakbdazUu+08ZQfDA4mYe84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSxxWKfAebJvgArqs4uMgqqiuqrjBM8pn0bSHaow1pFu0mWV4rb28QiQunWWhTqnyKntRO24BFwHYaWzBH/nCohqwQR6KWrNv1xTB/2m/7Zi6PRvQuT22Nn2ghmCE4hFupNr+Ls9KDOsvcz2PIGMMutY1cFHnSv+tROSkzaJOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=VXsIkSk6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55342bca34eso3063024e87.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1748935621; x=1749540421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xoq+mK9zf0H8LenpVm3kOakbdazUu+08ZQfDA4mYe84=;
        b=VXsIkSk6XB23DTAkiwYWsQCnnRWrWE84H9v7uB2THELWqwCAEN+ek1k/SN0L+zFoAN
         Ben0C8tgFyepytROeaYDGCuDXPmT6Zg+SCXK8nTPZLTmD+YI8zpUw01a9xOa7lHVKnbs
         OxKuAPcO4S/drwnnbJsInKi7ALifevKe9jgan/seOLWj0ReTXN9RmooyJZmPWCJTAAng
         RKEP6eJw4Jy7ygN9nptnra0iWP3zTFHBr7WOUVQaFOywe0GgDjyjW9yUSMCEg5FDC9HM
         9H4iUyP8ws0oezs0jpMrPnyJOYQ5lpSJL+wC+u4puC9yHLIkkR+IlHyCglDTSGRTslLx
         ffIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748935621; x=1749540421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xoq+mK9zf0H8LenpVm3kOakbdazUu+08ZQfDA4mYe84=;
        b=kttSvQam463cZ2RZI8H24eHWmet2/EkqLwPiEb0JcOq4g326KBa1V9uqIKd/yYhGRL
         q2k0KhzT+DM7wHcw/e0bfZ7bBlnjuVxBg/lx9KHvZt9nTbc8pb8tTGKG+kWPMXjEHe+E
         /3ab1IWTAO3WlBjSIn5Hqs5RYWNjmnS+/K/imK6DOk78IMwO+aUvM6dg2oYc6dSS5h+t
         nd0relyQWwm5UPRaMxzWQXCU5PdPiAsnXKJZmk04xMh1XB0EVPBretnU6xVA6EefNFpG
         bjCKgzGwOZlN8xLXbB7gqChNrSUmiMekGtTP80tnsCqYhMLgoTPGOo/hMbziTy9SosPz
         upcw==
X-Gm-Message-State: AOJu0YwSsu377CqeZq4wLRHCWddlK6A9lhdA/t2bNef5urT2zjSWSgtS
	NE7RZAGv1mfJzlMz4ibT5irN16XemQVkJOIAzSBx6qK9EU1r6BXjVbPnysRc3Xy5sX4zEQlEThI
	5oT/fbsbYosC7KaSGLumZBDx4hwaJoDlnEPALH1E2Bw==
X-Gm-Gg: ASbGncsSKqJF62uePj+ToWgF2UPq6I8Pz0L3ciU8D+Fd1/26hTO03g6JleqYtZWUNN4
	DB2iz9DljnDxRAYSncN0pRLyXk76xb33uwMASgKzIrehsTUR99U5ifYGgqB4e3bKI4Xj4r4UVGg
	X0vG1o6D0uToVZdGPU4fJx7MCO8pCX7/6D99u3TOjB6j2HWMa0pJjhwlp9uAJmul1BeFycr1VV8
	slo3A==
X-Google-Smtp-Source: AGHT+IHnOxMpT17DyGanETutgx7NXTaV3I4W7jMEWt2JfcisYDMim6rkuN1QzE/OAIBe/2KU63V7kSYKFaZ1T/mZE6k=
X-Received: by 2002:a05:6512:4615:b0:553:5166:5a5f with SMTP id
 2adb3069b0e04-55351665bb3mr911040e87.53.1748935621291; Tue, 03 Jun 2025
 00:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
 <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
 <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
 <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com>
 <CAAHxn9_waCMAh3Me63WQv+1h=FmT10grA13t09xaym4hX1KgCg@mail.gmail.com> <CADVnQynDkHVmTdnMZ+ZvDtwF9EVcOOphDbr+eLUMBijbc+2nQw@mail.gmail.com>
In-Reply-To: <CADVnQynDkHVmTdnMZ+ZvDtwF9EVcOOphDbr+eLUMBijbc+2nQw@mail.gmail.com>
From: Simon Campion <simon.campion@deepl.com>
Date: Tue, 3 Jun 2025 09:26:50 +0200
X-Gm-Features: AX0GCFv1Rv1rI74thQJj53yrO_PV_noWK-5GOkjRjS_d2jJ6BjN9rMxxjFLAqfE
Message-ID: <CAAHxn99QAYkxcAS5nKdaR93taCPykzxLXOXEJfDh7a1k0y9sug@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> I agree it will take a while to gather more confidence that the issue
> is gone for your workload with net.ipv4.tcp_shrink_window=0.

To confirm, it's been over a week since we set
net.ipv4.tcp_shrink_window=0, and so far we haven't seen an issue with
TCP connections being stuck with a zero window and an empty recv-q.
So, it looks like the problem is either entirely gone or occurs much
less frequently with net.ipv4.tcp_shrink_window=0.

We also attempted to reproduce the issue with a program that sends
data over a TCP connection but leaves out the first N bytes.
Unfortunately, we haven't been able to reproduce the issue so far,
even with net.ipv4.tcp_shrink_window=1 and with a system under memory
pressure.

Simon

