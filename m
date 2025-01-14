Return-Path: <netdev+bounces-157993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C460CA100B5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 07:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018CA3A4CFE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B36237A2E;
	Tue, 14 Jan 2025 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhgVqgG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A9230D2B
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736834475; cv=none; b=CMkoM60xRFKZyNLE92AM3uaRiitKLKQUCQAZdcUVA9VVMU5vesKjGTeyTZAyXb5ufGkNcmT8z793KAh9/j6mVLPmBEXUPErPUl02BI1NHl0hTil1Q8IJF/tkdUkijfhJ/isHPgOYOLnuQg16RMB5O5ifROwo/5zgDANdyx4ZcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736834475; c=relaxed/simple;
	bh=y26zlK6dNzwovEdSf+ZSnOhAFh0FQbkgFGnLA01McT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/N+kxj9kcMw1AF5PzURbuff92RtMNEcTEz1Ua+7XjP1MQWmiyxXuIxtnxDqL1PTgkXRS+vtyC4cNEbbcCbCgQGfZzboQ4J34e4fuKZ3GGZ+BZ8gTPT9I6yZ74xU+2IiztPNf9TtFlHZFVs6aVOIFdJQk6rpviuCfVX2XwkBwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jhgVqgG8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54026562221so5201791e87.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736834471; x=1737439271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+MfpBzkqBtq1KQBkE1rEnF0uU157WsksIfsGtGfs8U=;
        b=jhgVqgG8ZOBhCGDcI4fNXHU53dHXSU30AiY4IMHgwXb/15i88a+aaB3OuZK2yTaPGu
         CNqU9YviNmbtnKHEF/4Ww/cDTETGayL/N3x+lch1N9yaNUVxKtCBJgoNJ0Tx94WnQjns
         POhUdhSj+Z5+mU3lOLksny/iQCx7fO2p4xUlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736834471; x=1737439271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+MfpBzkqBtq1KQBkE1rEnF0uU157WsksIfsGtGfs8U=;
        b=cgfcLCpeSAuqoSjbVc9Tb7gGcfExuGmiHaK7KM+5dTdG6PeAsK2Keec5Aj0MtolZ/l
         9FQ942HZXd5Ma0g7APbpHtQk+Af87ssrRBgFVtr061zUQBTW/9eEcIwGYuYPh7urf+V4
         gKK0AHXEEwS9nycdQAODzUzP6DU3bmLQ879t+LknwwEO+lsmJinE9X968esC6dqNjFtG
         jIAXEOFaGmgCgmjFospOvlXsPuiY6PiWnAzi95JIJwbgcbwWBV6lYK8x8S276jUtNY/N
         udthhENlPlMGw15BFyeYeRCdV21MUPDQkH5VgsCg4hHgN8PMdPWDdcG2yMitqJHfEhzu
         5uqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXbwKAbAgirsU6JfKJgR/CNUHKRGenpX8dTYfpCfwsWs1VI9lH0Lns4F3V1glW6uUDgGq4q9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndIwYrxkuyJkuQDyYpZy2/vME5BvYgoqAHpEwJuqzv+4WdPZN
	t2PUOdAAPmiMC2Mu1EuAnXw3XkdBBvukz1Vi1SMV1Sx7vhiGAQvuk6EiuQBPiEj4L5d5NlOOpia
	wWJkD8Fl4n8gA42PEVnM4JjVEa2XW5jmkRZc/
X-Gm-Gg: ASbGncscv288YheIX8vOGhfIDDrv6Ud/RG5DF2LdjahTt4rWnkWM0/U0+oBhY8mECll
	07evL/Dfvnx5E/9UNbBo6CDgR6pJOVHSQpF0dW711XCFB/sq0UaSlRGlK4DcnGkwwBSzEalha
X-Google-Smtp-Source: AGHT+IHr1JtErWlVHX79qMcQvFhXOJNWZJaYIxYaJjGhk3eQUSkF4wLTbtJA86OIldXc8lrBhWsRsctkDWylkh+sNtI=
X-Received: by 2002:a05:6512:110e:b0:540:1f7d:8b9c with SMTP id
 2adb3069b0e04-542845b5963mr7654743e87.45.1736834471079; Mon, 13 Jan 2025
 22:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218203740.4081865-1-dualli@chromium.org> <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com> <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
 <Z4Aaz4F_oS-rJ4ij@google.com> <Z4Aj6KqkQGHXAQLK@google.com>
 <CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
 <20250109121300.2fc13a94@kernel.org> <Z4BZjHjfanPi5h9W@google.com> <20250109161825.62b31b18@kernel.org>
In-Reply-To: <20250109161825.62b31b18@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Mon, 13 Jan 2025 22:01:00 -0800
X-Gm-Features: AbW1kvZGO2dnKh9EFLmOMykm0k2dAxwLsXw0Sg0rIQW27PvNSHzYNz4ekKKY8e0
Message-ID: <CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, dualli@google.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 4:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 9 Jan 2025 23:19:40 +0000 Carlos Llamas wrote:
> > On Thu, Jan 09, 2025 at 12:13:00PM -0800, Jakub Kicinski wrote:
> > > On Thu, 9 Jan 2025 11:48:24 -0800 Li Li wrote:
> > > > Cleaning up in the NETLINK_URELEASE notifier is better since we
> > > > register the process with the netlink socket. I'll change the code
> > > > accordingly.
> > >
> > > Hm. Thought I already told you this. Maybe I'm mixing up submissions.
> > >
> > > Please the unbind callback or possibly the sock priv infra
> > > (genl_sk_priv_get, sock_priv_destroy etc).
> >
> > Sorry, it was me that suggested NETLINK_URELEASE. BTW, I did try those
> > genl_family callbacks first but I couldn't get them to work right away
> > so I moved on. I'll have a closer look now to figure out what I did
> > wrong. Thanks for the suggestion Jakub!
>
> Hm, that's probably because there is no real multicast group here :(
> genl_sk_priv_get() and co. may work better in that case.
> your suggestion of NETLINK_URELEASE may work too, tho, I think it's
> the most error prone

sock_priv_destroy works with genl_sk_priv_get().

But, I have to manually modify the generated netlink header file to satisfy=
 CFI.

-void binder_nl_sock_priv_init(struct my_struct *priv);
-void binder_nl_sock_priv_destroy(struct my_struct *priv);
+void binder_nl_sock_priv_init(void *priv);
+void binder_nl_sock_priv_destroy(void *priv);

The reason is that these 2 callback functions are defined in
include/net/genetlink.h as below
void (*sock_priv_init)(void *priv);
void (*sock_priv_destroy)(void *priv);

Otherwise, kernel panic when CFI is enabled.

CFI failure at genl_sk_priv_get+0x60/0x138 (target:
binder_nl_sock_priv_init+0x0/0x34; expected type: 0x0ef81b7d)

Jakub, we probably need this patch. Please let me know if you have a
better idea. Thanks!

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 8155ff6d2a38..84033938a75f 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2352,8 +2352,8 @@ def print_kernel_family_struct_hdr(family, cw):
     cw.p(f"extern struct genl_family {family.c_name}_nl_family;")
     cw.nl()
     if 'sock-priv' in family.kernel_family:
-        cw.p(f'void
{family.c_name}_nl_sock_priv_init({family.kernel_family["sock-priv"]}
*priv);')
-        cw.p(f'void
{family.c_name}_nl_sock_priv_destroy({family.kernel_family["sock-priv"]}
*priv);')
+        cw.p(f'void {family.c_name}_nl_sock_priv_init(void *priv);')
+        cw.p(f'void {family.c_name}_nl_sock_priv_destroy(void *priv);')
         cw.nl()

