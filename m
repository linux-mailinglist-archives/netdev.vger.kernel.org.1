Return-Path: <netdev+bounces-139982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB39B4E8E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE941F21AC2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB029194C6E;
	Tue, 29 Oct 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhTJN25g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6C802
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217194; cv=none; b=AOwYY9Z6PLb8LfsMWkWziguKFmZQ5ExO0VwKIJdv3Kvu9qQg9quAYTGMG3T3ZtqTD6nBjtzpfK5Xz8e2i1v0IF/YlBs74dheQ/OlGHMWtXWkg+Oga8tlWwtwJxEugusKjBl2owADcGPGIfSY+Kp+zearb3q7jsElJBiDup1ca5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217194; c=relaxed/simple;
	bh=Q82MjAAJzY011abIoj9mr3/lCIvynpDz1KuaP8yYE3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx7gsIhv/Gz8w50YPBNn5YQXLpzlxF+bQ09kM5xJFZwBKupBFFGWJn8A4ItRxZXiMXL9g1vuYFUTFXw7KIGTPVOkWBJ1vLBjgV9rkHkmq6PrCLr5h6+ixZi46Rwxe9I325wJb+sneXDa2sf+LLGExhhQQpdd0lC8id3eC/SY3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhTJN25g; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so8736621e87.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730217191; x=1730821991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll51C0PllLi1/aohJqQbI6RPBpDmFIRC+GA4ELQxeFw=;
        b=dhTJN25gmGQnWVvbZHc8HZzVc5aEPMmtMNvZJLvBmiFgavwUXcHdgbezBKjI/4x9DT
         1cBxNiLlrLyiJg8N2xdN4TU0WddqxEUkXcw/IHQQCdmuBiL9OzAR2f8lz7kSpN+G9HV6
         FalKknhrBFfMv2+BNq2IuzeXoQPmZ+HjPFu6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217191; x=1730821991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll51C0PllLi1/aohJqQbI6RPBpDmFIRC+GA4ELQxeFw=;
        b=US8VkTbMFBnalvayI0rE32bYbgbztAO00y1gFD/+cz6T7kBHD/L7ERyqM2x823rUUt
         9k9hvzflmUhR44j2tV40B1myQw7GFBvHykBM0YEppXHTOOu+YhZFEk9zwYCCJO5iVpbf
         hVKsuqvR0Ilb7WGn8fP0tWIiAWn1H7+qZn+FbkMTHWHUmi99cGiZ4LkKDzoK2VcsVQkk
         KcgPzS1r4BpjePyUTciIBTgCCSxYyYqG1BpN/NOB9ncnQYjbreZTonm8CM/+My5K1C7M
         z5piDxU6vKeVjzXHXNnBHO/3JP5jGkcQ+k25m09l+StcPHRm4P/adrFBEDPguzYih+tW
         RS8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVWcZlvWu+ntQQqAXwf8RP7n6jBzZE0fsRAL1lHpOdTpR8nqfKy71XLADEdW9gC1nzcGO5k6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcO/hA/yFkqAy78TEuChYSsVPq4I3XAHnXDBeqWLEHJ5y+Tw2
	yWkBnTTbPNXF4D8AA5q+mOJyBopY4DZHVzRSmBzjf70nlQkKj+cKIa2/FWQ1NKtdSIBfXN1aKs/
	09qLgeNZ/f+Es8n6SUJnoptf6b+j7nzzN4cWJ
X-Google-Smtp-Source: AGHT+IFq8kVq37MNUAjH9Q6myVE42MB00LVqimrYgoawu+grZEG8upkwKXnNYybcruxqIxH3d1HozSkgBqx+9rgCuS8=
X-Received: by 2002:a05:6512:1256:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-53b348b9fecmr8822368e87.5.1730217190707; Tue, 29 Oct 2024
 08:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028101952.775731-1-dualli@chromium.org> <20241028101952.775731-2-dualli@chromium.org>
 <20241029071437.2381adea@kernel.org>
In-Reply-To: <20241029071437.2381adea@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 29 Oct 2024 08:52:59 -0700
Message-ID: <CANBPYPiYAVDMeBUNRm8_wJojropMSL00UkGGV1ar+E3Y1STYfA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/1] binder: report txn errors via generic netlink
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

On Tue, Oct 29, 2024 at 7:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 28 Oct 2024 03:19:51 -0700 Li Li wrote:
> > +                     report.err =3D BR_ONEWAY_SPAM_SUSPECT;
> > +                     report.from_pid =3D proc->pid;
> > +                     report.from_tid =3D thread->pid;
> > +                     report.to_pid =3D target_proc ? target_proc->pid =
: 0;
> > +                     report.to_tid =3D target_thread ? target_thread->=
pid : 0;
> > +                     report.reply =3D reply;
> > +                     report.flags =3D tr->flags;
> > +                     report.code =3D tr->code;
> > +                     report.data_size =3D tr->data_size;
> > +                     binder_genl_send_report(context, &report, sizeof(=
report));
>
> Could you break this struct apart into individual attributes?
> Carrying binary structs in netlink has been done historically
> but we moved away from it. It undermines the ability to extend
> the output and do automatic error checking.

Sure!

>
> BTW if you would like to keep using the uapi/linux/android directory
> feel free to add this as the first patch of the series:
> https://github.com/kuba-moo/linux/commit/73fde49060cd89714029ccee5d37dcc3=
7b8291f6

Awesome. Thank you for the patch!

