Return-Path: <netdev+bounces-158588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0657EA1297A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5510B18898E9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE01ADC7C;
	Wed, 15 Jan 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4IKiFib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78631ACEC4;
	Wed, 15 Jan 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961110; cv=none; b=uWHMW2DnP/iELh+JMT88rfvtf90GlzKKQUdUXM6/z7dsAXpZoyPx3SHhFOESmUsgO5pYh5QLwJq2kEyjWFyNwHS2nk4WKtTyV80d57rWwjzPlMd8QURV1rtiA3Iy5vjZvuE/aG7cAMVJi1PAG3NQL0Nxi7oaXNBIViw6cdBZ81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961110; c=relaxed/simple;
	bh=XlU/adRSa3jtRhh1ynh3RW6Wy0OScn022bwzZEgtJx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLEbXuclKj9YFyMFxeP56pJhwpnZeNlnvGQG2DVqP8Jx2ZGt1pwlirkAeSLRTB2zFxW2U2kTkLEzsiZffkR6s3ZxiaMMUqI14mnjBRJXG+2gBLx+ugEhbl7fds2EbJgMgbppFDAouZVDRolGjdzPFhzPvWmHDpI/K8q0zqdoilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4IKiFib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE5CC4CED1;
	Wed, 15 Jan 2025 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736961109;
	bh=XlU/adRSa3jtRhh1ynh3RW6Wy0OScn022bwzZEgtJx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4IKiFibDF0zJACRB9Fm+lr35g36XtSFNfP2ATA4xdLDeyIZyeepSyfTGtVst4G5I
	 HuNbgow5irTNvI5FEY5u9Kl+h5V67SBiXuneWbkWiMRkCy0kyhCOIuyxLfpHX7hQ/o
	 rYJ4OuuXQjy4vMh6K5qEXc5v3MXhhAu0cbo21LpG0j8trHmln7wMJYNnALJyPkaJsw
	 NeiNH6FMQVmGllFC9wlhTqDOjAMRKjqk2T3Akr6zGWJ+68FZX3JkcJB1pS41ymCMa8
	 TEcCMX1gL4yfi+OR6WelkCH+lHxJJUd2+snnqqH5RKklnWv4HGarqFBEeDmZWbbTWS
	 Iw2ft3I22ZljA==
Date: Wed, 15 Jan 2025 09:11:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH v13 1/3] tools: ynl-gen: add trampolines for sock-priv
Message-ID: <20250115091147.0d4c7497@kernel.org>
In-Reply-To: <CANBPYPiFY1YYXvo+uf3=0mmahFp3qTBbW=dxp11MsPf68j43Lg@mail.gmail.com>
References: <20250115102950.563615-1-dualli@chromium.org>
	<20250115102950.563615-2-dualli@chromium.org>
	<20250115081324.77cf546f@kernel.org>
	<CANBPYPiFY1YYXvo+uf3=0mmahFp3qTBbW=dxp11MsPf68j43Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 08:44:37 -0800 Li Li wrote:
> On Wed, Jan 15, 2025 at 8:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 15 Jan 2025 02:29:48 -0800 Li Li wrote: =20
> > > From: Li Li <dualli@google.com>
> > >
> > > This fixes the CFI failure at genl-sk_priv_get().
> > >
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Li Li <dualli@google.com> =20
> >
> > No, no, this is a fix. We'll try to send it to Linus tomorrow. =20
>=20
> Thank you for prioritizing the fix!
>=20
> There's another trivial issue which I just realized after sending out the
> patchset. When "sock-priv" is a pointer (like the example below), ynl-gen
> generates ugly code and fails scripts/checkpatch.
>=20
> Should I use typedef instead although it seems discouraged according to
> https://www.kernel.org/doc/html/latest/process/coding-style.html?
>=20
> YAML:
> +  sock-priv: struct binder_context *

We can adjust that later, but I think cleanest fix may be to wrap the
priv in a separate struct, even if it only has one member.

