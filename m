Return-Path: <netdev+bounces-162018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178DA25580
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ADF166890
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984C2940F;
	Mon,  3 Feb 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjAtaoFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23891DC985
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573838; cv=none; b=KGWCzt4lgPDX9eamr/B8N0zfx8w82GR1etBHhbKiW+WL4+jeo8r0t3kP6bI9Zd88znsjpQjePC3Vk5iU5yenvcZq28wYX0QqfUBD/XYJUQfi+1SvHD/OlCRVnrpptkYN/j0wJAjDGJNvv19RcV4D5z8aWhmgTWm/lfV9CLivI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573838; c=relaxed/simple;
	bh=ocxPT1lbqfzyDB56mU7ObzFnYZPycivjv4mqPUNVj+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J61K6jEekN0hpQxzENszs8kamfcwmP4gv+a0tYg9LHKLH+DSSgzJrLkmeGmfxsxkv+DWqb8xTJucl/yAkzl6NdQzKhX/wYMvhijxmIprMEPwgth3sq+RfG8NBVwjPgbE7tq/PEh+jEqY6q7OVD0aMRhnxEgRlg3qhHm9AIaNZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjAtaoFi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso8186334a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738573835; x=1739178635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocxPT1lbqfzyDB56mU7ObzFnYZPycivjv4mqPUNVj+s=;
        b=gjAtaoFiLWasVFxEdAvBGosX0vkmHOG2Fr+zj+lLIT98wSJU8Ll5/f/+pF/TJTXVDo
         7ltPx4V68V0V+wy2FeA39qebyLaV54AlIOkNb59uZ50eQD3LpTzOEKlFEbkJ4EKvpvXd
         2T5jNiLb/yT1fUor9uTRUVqSWxhnsJpXo316+19sMpFM5oSLyOcGFiJqNkOAYpSMrxRo
         dGktOVqRE8PxBvGrzbLbAeY9/tWcCx5UJDz1eK8vGgidHVMRu5IjMTFwbrejQfFrGjKW
         I92GuIVFIETJi050YNghYma+x8+L7SkKsWv+ebqIgvX6saGUYYwqdY3XwXT8GsKOJ4ie
         Cc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738573835; x=1739178635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocxPT1lbqfzyDB56mU7ObzFnYZPycivjv4mqPUNVj+s=;
        b=eiqQLoin+7m+YFCOGL+Q0fRtFZehcw3bLAhPCthWc+2KzK8oedwH2EeFtIjb7lE4da
         D4kxgghpVDrKMLuTAiDXaaioDbGXYhQpQHC2xeuNXZrENCd9Any6OVUor7HLFi/hwxPP
         jc5R2747ICMWa1tO+EepYv6IlFEo+jCoAxejAXipWXNnWY7zjgpPl8ntPFdlDR9+ctwu
         /xE7pnKqmSV50wT8b3NByElRfz+xhVD3H05B5AXtSzV9Rlg+wsJ0R8Fg9VCcrVF/0r56
         D6JIHFp8povzkfL8HNFquGSJu9cbR8iN2v2JVLuPpAfSUwKDsqI6tTbWpph1+4ibl2ar
         RiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsvsgGdqw/d1VjSAzAdRnx9gdIuzUpG+Of6EQKJNsKejdnRdPPthR6M9SDhxt/n8WYv7FnhAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdyiOXyVmW/8TTVHW3ZzzrMDVXwfYMZfcY5c31XO1DZdRBoQ8
	slmOmpujz1N3B/br6X9KAY/IDwa98HNmAMzxaBS5pri9nDH4yy1yCIAUcKuwOr+5Heh6zyVDXqr
	Z/chglLaffJ9gSLQi0fz+UPY8UyCLXz3ZhJs19KqfPrX1AnCM4nME
X-Gm-Gg: ASbGncvelGFdLv9xb+QLzaBR4R4N7e0I+3UiOIoQv6wPUDS0Jds2XzCQ7HWBMYgXCkr
	gMy1zQqKhmD59WERY19I9XcGQHMiqMbzmEAT6lPx1kl1dSQezwcg1VC+61UsJAvEpJIfoQVK6Gg
	==
X-Google-Smtp-Source: AGHT+IGvzQ8yAWqouldOlBDUvhH9M5l3F4L1NLQZUnOrgGIjV8myosH+UMFOnemCONS2lI0g8sQDGc3I0oTpbJuGSa8=
X-Received: by 2002:a05:6402:d0b:b0:5d0:d91d:c195 with SMTP id
 4fb4d7f45d1cf-5dc5f0313f7mr23910921a12.32.1738573835042; Mon, 03 Feb 2025
 01:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202014728.1005003-1-kuba@kernel.org> <20250202014728.1005003-2-kuba@kernel.org>
In-Reply-To: <20250202014728.1005003-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Feb 2025 10:10:22 +0100
X-Gm-Features: AWEUYZn024dafWLdI2px9ZeBd8EskNsHCT8wQZJuN8yZsrd1ary4SnTPBbI_UcI
Message-ID: <CANn89iKEiooQgAErcHqKEmSdCTqj0+4noPMx676UvwVv4ewujw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, kuniyu@amazon.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 2:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> List Kuniyuki as an official TCP reviewer.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

