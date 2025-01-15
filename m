Return-Path: <netdev+bounces-158584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D561DA1290B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9991884B80
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE69192B79;
	Wed, 15 Jan 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehaWxV94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D016DECB
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959492; cv=none; b=UBlIynAgCqiiMJ62eXbASD0VqAYAIiEbolXOYsd/3dBwfoOrMHhelnvsJqoYue/SKp+eROSaTVv1RMYuOrjpOicOnOQUF/B1tbVOtY74z1TgkJPYo6hh6hvxOuq4pUeYz1v1KtmfEaDIKBSvGkRgxfAzrXYePkXqPlSElX3e4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959492; c=relaxed/simple;
	bh=byrCqsR/sDHcgtdPmErvTP1MMNBghR1QTQfXm3qQM58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXO033WKm0ybbWpyq/LuGdzsHPLrRaF2sjjOJERpVsiMEdGokuIrBFiCC2diPJmmyJU4JSRbmnpmW/8dTyfnXwthT3TaQkrXkrwrWIebg/UmWtMawVTrk57pCDjVpspG9wgN3DAaQeyG6tjOxo3UrQjCSCek6j5NL0SQQuA1bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ehaWxV94; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54263b52b5aso7158478e87.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736959489; x=1737564289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRqTDNR+wu88sckzjZy0egJFYIw3bWrH2oZ1rUrMA/8=;
        b=ehaWxV94LIaVST7apk9kvl5pVnfny+bWR5pBhGm1yzPN8ceQWGozolEn9plGozIx7t
         BF5s4jChM9/KQgtp0BiO/xn6Ni6hFKKv6a1PaRT5g4tOS0ta7L8UbCMcAdGX/UtaqJOs
         3T3dYyLTa7I62DJ0mk/dv50JjKjOnA+83p14U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959489; x=1737564289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRqTDNR+wu88sckzjZy0egJFYIw3bWrH2oZ1rUrMA/8=;
        b=PqgQ1d9v5UQG7IfQqXQOpGOUYp4ckz0t2qiPPQZ66yrUshus7Xj2v2vLzYpymK0H31
         psB3HMp9PB3YER5YLpAMapgkVb264sOgXZZ9jM8lAQaKSqTB/b6ZUP30L2H5T4BsWUAQ
         lwkzruhkHvX0w0dQq5f4qLI/L/0bCIVL5W79LWvkQvEhKiu5m44/FU0iIY+tfTnE1psD
         I5TlNbTaL3MK+z0Aci1E57ubnBwDiVk8bOavgM8NBpNLE24LCzvk3EE41BDqm4znjQ6R
         vdH1pdz2HA2bezUWNlrssHi3omaBb8GYF7MrLBXUlgZ3lK+yla/F+SlvGG2y5mxuVQT0
         hNOw==
X-Forwarded-Encrypted: i=1; AJvYcCUfxT+8h8tAt8V0FXpAqlE8yMD6VmEy4aSFvyq0drAtlw/CwRKhuPgP51mWFVJHxnEciCtiqZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2SleSqrnB/ByJFpEWKvVew9EBi+wTPaJ9Z1/9pyzJjC3hOT6
	XLT4pMr6LdF2NtEfgvQhzUDWNk+UARYpOodlrH+qij4EynBJHuyqejKb7iOUUFv+TSmflzzlTo1
	b4YO75JFnd4qWP3Ybk6/mCGY8sf8T7daOosdk
X-Gm-Gg: ASbGncsH5FrR+5cpb/i71Dg62ZNg0u29MQ4akXzth8f2WP3Z7gEFjOqq7JtvZG3Vpdu
	by/gXSZOrSNK7wE/e02FFmSvzYcnZVN32a9nEWg==
X-Google-Smtp-Source: AGHT+IG1IJkSRLkdR3tBT1SoCLlLY9m1FFZQSHAVtlX95wOZ8jJcWLXIhX1ynx2PLeHZMN9gxuVMyxprb40o4TL7/xc=
X-Received: by 2002:a05:6512:b87:b0:540:357a:5d85 with SMTP id
 2adb3069b0e04-542847fe865mr9041453e87.38.1736959488724; Wed, 15 Jan 2025
 08:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115102950.563615-1-dualli@chromium.org> <20250115102950.563615-2-dualli@chromium.org>
 <20250115081324.77cf546f@kernel.org>
In-Reply-To: <20250115081324.77cf546f@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Wed, 15 Jan 2025 08:44:37 -0800
X-Gm-Features: AbW1kvaJXF2icOCW9xQPir179J54U3AlhjVj275Vcsq_SMpV445BVjZSh0ym4ik
Message-ID: <CANBPYPiFY1YYXvo+uf3=0mmahFp3qTBbW=dxp11MsPf68j43Lg@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] tools: ynl-gen: add trampolines for sock-priv
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 15 Jan 2025 02:29:48 -0800 Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > This fixes the CFI failure at genl-sk_priv_get().
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Li Li <dualli@google.com>
>
> No, no, this is a fix. We'll try to send it to Linus tomorrow.

Thank you for prioritizing the fix!

There's another trivial issue which I just realized after sending out the
patchset. When "sock-priv" is a pointer (like the example below), ynl-gen
generates ugly code and fails scripts/checkpatch.

Should I use typedef instead although it seems discouraged according to
https://www.kernel.org/doc/html/latest/process/coding-style.html?

YAML:
+  sock-priv: struct binder_context *

=3D=3D>

Generated code:
+void binder_nl_sock_priv_init(struct binder_context * *priv);
                                                     ^^^ extra space
+void binder_nl_sock_priv_destroy(struct binder_context * *priv);
                                                        ^^^ extra space

