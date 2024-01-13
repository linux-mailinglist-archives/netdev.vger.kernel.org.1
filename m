Return-Path: <netdev+bounces-63419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29182CCDD
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C435B22245
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9C21110;
	Sat, 13 Jan 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+pOrzG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DF21340
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7831aacdaffso665603285a.3
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 05:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705154255; x=1705759055; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uKJZgZr0HdqOukC96W6RN/B6BtWPtF7xgZHshHwGSU=;
        b=S+pOrzG9OEjN7Qbk0JZWreCz9E56/WnxjnaVUxK4EdviTTU52vh/P6nniQEZsXbnuW
         WjxG0uThPSuuGHrTZHL8+FZCjAY9LumNyYJu8isFNAFoUQRb3WfPAaxrhN2d4r6T/fqV
         kjaUcxhqPw+lYI3u9DX2t+xlgJYdTDxXb0D4DZOLZGy/0KqY2FPLXEk0z+hSYc0R5aiB
         FzWggtvmRbcNtYC56gs979YsvdurNgTg5ymueMVmCF5jRQPRB7/8mRAqoH8IbQ39S+Kd
         JSOQPiURz5wd9vbCrr0buukBIu9qLNBP4iwv0uNFCdmQQ+4H5j4GIRW7BvNjeDG+VJ44
         rH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705154255; x=1705759055;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uKJZgZr0HdqOukC96W6RN/B6BtWPtF7xgZHshHwGSU=;
        b=QGpjz/PnY56LM7sHRxTU1fB6dVyl2FxZRtvGCJeYyrm0CoDZWAh/zmMPPJS5NyI07b
         ihPsOxtFnR9ecJipPA/bmohbTnsp0pwWYPOp6r3IL+APDQTmThgUWeZ68m7yEkxWtuvm
         1GaYQm6opfpozL8YlrKsu+v9bQXbQRbNHyR3g+zS7G1wVxvwgeyz9n/li8NAOAvuBr9q
         bZ/w56oRDZn7lMKEjawykXayJ5lRWsyoR9om0/f0VH6qUo3+Iz/vOtVm+ZtH6C52/t9a
         zbiJKP+nKB3ufsG8Y8dP7WHB60diDvBXm1sKiqVMq7W/BvCwYgBKkRV9fNLxHDe7ylcA
         X30w==
X-Gm-Message-State: AOJu0YzWGbHbLY2Dxgs3e1DrmZJBZyuYIhmDuuCPRZqEtMOHMZpGwAVf
	+NHyri1RIJOPZJHobb+LC0eXAN6WK6vq1AzrjDqMn+XLJOc=
X-Google-Smtp-Source: AGHT+IELh7dyvPs6p+twLsH4QC0fSQPPpzhD8bP+F4zmtwUpMa80UB4BWoNVBwk1YU5nwQ7ufbmuff5YbFNEW0Nh+io=
X-Received: by 2002:ae9:e218:0:b0:783:46b8:1dd3 with SMTP id
 c24-20020ae9e218000000b0078346b81dd3mr3462707qkc.100.1705154255038; Sat, 13
 Jan 2024 05:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC-fF8Sv3rEx3-st-vHWqcOGerSN66-6qv4Xv1Sh2wDLQ2yNmg@mail.gmail.com>
In-Reply-To: <CAC-fF8Sv3rEx3-st-vHWqcOGerSN66-6qv4Xv1Sh2wDLQ2yNmg@mail.gmail.com>
From: Isaac Boukris <iboukris@gmail.com>
Date: Sat, 13 Jan 2024 15:57:23 +0200
Message-ID: <CAC-fF8TCqQ4oejHjFZPHqcNRqY5WQLzynw+KoaOOvjv8ZZwObg@mail.gmail.com>
Subject: Re: TC: HTB module over limiting when CPU is under load
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 2:40=E2=80=AFPM Isaac Boukris <iboukris@gmail.com> =
wrote:
>
> The attached script reproduces it for me, when run normally the curl
> command reports ~1800kbps for all modules HTB, HSFC and NETEM, but
> when I run the below command to incur heavy cpu load, I only get
> ~400kbps when using HTB while HSFC and NETEM still work well.

The original tests were made on Rocky 8:
uname -a
Linux Rocky8 4.18.0-513.9.1.el8_9.x86_64 #1 SMP Wed Nov 29 18:55:19
UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

I've now tested with a more recent kernel using Fedora:
uname -a
Linux fedora 6.6.9-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jan  1
20:05:54 UTC 2024 x86_64 GNU/Linux

On Fedora with the aforementioned openssl command for load, i get
~1400kb with HTB (compare to ~400kb with the older kernel), but when
instead i use stress-ng command for load then HTB only reaches
~1100kb, while HSFC and NETEM still achieve ~1800kb in all cases.

stress-ng --cpu $(nproc)

Thanks!

