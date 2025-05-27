Return-Path: <netdev+bounces-193715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D887EAC52B5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50911BA1FAD
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F427F724;
	Tue, 27 May 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhB0Z72r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EF27F4E7
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362249; cv=none; b=PSKgSKJHScRjUrZ0eYeJDjIxn5nadXgSOIjcnMYVhNnvvbJu3I1SsxSVNq0WASWRs5emT6mU9hm6+NlM1gQSK31BnmtfdnvzcokFW556RBqI8ux5GY24XQCZal5tbz1u6k0dD8X95c9Z/dimBN7Nm3+4u2trNu5Tuxv6mu3aEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362249; c=relaxed/simple;
	bh=C+jtZ6M73CB86PrCh9GgPsh2zWr6HUxw7D8YoYK3uw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asCopckpEvCQSo39BHZHgx1jWQDAPWdgD6kkIkkWqyJwLo50enMjrJKkuCORw6cuAQiLCVmm4WR5vtRNQD13seCGpBgaNTcNNC7JnbQg9vS++PUIl0efxm/AdnJexVFP0JG3TD7ks5qxE/dGCudztgV/4BYD+VJ+eBU8mRjPJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhB0Z72r; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso39718371fa.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748362245; x=1748967045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+jtZ6M73CB86PrCh9GgPsh2zWr6HUxw7D8YoYK3uw4=;
        b=QhB0Z72rpGSMmz4oezKHETPxEVn6IUmud14dt7OGQHEIG+E5GQR7EvlicXP0tU6srw
         pDTXYLBO7pT6BRHt3b6Snv+5bW9T5HJu/b6qY3GAMwl/YmoAiVLyLQO6S64ZelDC31Fa
         OMKa3BoGXX6Qiqbqg4aNJN91uz5TUDf1IJZtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362245; x=1748967045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+jtZ6M73CB86PrCh9GgPsh2zWr6HUxw7D8YoYK3uw4=;
        b=huf6DbU6FxtwV6CnjKG8VGgW3pvdhVIBB67SFE7mN0u2hdygIxzfypxuK3PFeelsJ8
         rxyUKK9O9RVOvU7mn1K5WrGqxzzGdk1yVe0VW4kGGXSBwJqLOtpbVkreYpKcLTc8Mkxj
         ow3Ky0GIfvoJTiUfdtIYCRFJ2vfXeSHXix9ujar7R8CNvOG7sVfP2pFnyN7la0IAo8OD
         xcIhFFl74FXtkgTEdQg1mARNRyKQkTvJh8ZJd9Ez99yU6bu1/4r4F5dYWE1sZDUrnChM
         VEWyG8AZ8FqiDFq/2UwX0SUZk8p3BdlaoAruXxObzQPpU6zpjMOzMExA4PLCkE8m2iK0
         l4QA==
X-Forwarded-Encrypted: i=1; AJvYcCVCVD22tHnEilXXTo5TY7hId00IOHtF09urPvdt3NJ/ereVaesqRQmc3xbYGtVzv+eDkpoJXEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9f2ddjEIsa6gyFD2snUjvuztlZcpw9DQgQPfpAK+0zg5O2Iq
	kKJvM92FDi3ynF3Fd5ejElaQdyQDZFmO449bBGSKC3N7PbEtwjePZKjeEN4Jdd/91i96u9rCdx4
	78c2ut6Zb6P121nNUypNuZTwEaCYTc72RF3XiDSs0
X-Gm-Gg: ASbGncu6jzcp+Hx7nwQH5nOLeDReqfZrw5cG4YfQoJYpPZy3CmRGekxW2pJ6otO9U+h
	sbj81tKtJk1Ha/f3sZDy0ByfPjPmnkMYTSrBSfFi9NxhLXB77cJvkfwA/r0t1uRxFtlhtoalcMr
	TG1caVCSM1qR9+8j0J/xixQLsvmjYHa5+u/CAJSGJebVy9
X-Google-Smtp-Source: AGHT+IHnxXSpwPQJnq00c7CWCY+PUWCLeRzCHONa/qE7pZ0tlcnlmLKnoWAnQH1ws4NnK/iqPjFX0jR0V3/BiQ03ZfA=
X-Received: by 2002:a05:651c:3137:b0:30d:626e:d004 with SMTP id
 38308e7fff4ca-3295b9c6dc1mr42932431fa.20.1748362245432; Tue, 27 May 2025
 09:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
 <20250515070250.7c277988@kernel.org> <71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
In-Reply-To: <71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Tue, 27 May 2025 09:10:27 -0700
X-Gm-Features: AX0GCFv-bntr7V3eITdVmyrlk7O4Ra37b0K8G5XqblYoHppcZ27xPhxwkEjCxzQ
Message-ID: <CAP1Q3XTLbk0XgAJOUSGv03dXfPxcUR=VFt=mXiqP9rjc9yhVrw@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Guolin Yang <guolin.yang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> If otherwise the traffic goes into the UDP tunnel rx path, such
> processing will set the needed field correctly and no issue could/should
> be observed AFAICS.
>
> @Ronak: I think the problem pre-exists this specific patch, but since
> you are fixing the relevant offload, I think it should be better to
> address the problem now.
>
Can we apply this fix which unblocks one of our customer case and address t=
his
concern as a separate patch as it has been there for a while and it
has a workaround
of enabling tnl segmentation on the redirected interface? I think it
might require quite
some change in vmxnet3 to address this concern and can be done as a
different patch.
Meanwhile, I will raise an internal (broadcom) PR for recreating this
specific issue.

Thanks,
Ronak

