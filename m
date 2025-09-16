Return-Path: <netdev+bounces-223638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97511B59C8B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D732401E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581E371EAE;
	Tue, 16 Sep 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hNIRgHDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2B34A32A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037900; cv=none; b=FYGLc6Sjr67103lMAIeAdPavOZERQijMjH2DpueGRKB60BZl12dgKDbQ60AObxorZyhBY1yRRtS2JUiNrfu2eX/iVzDpPO+Fwn+L0kS6b4VU48p0IWgT/RwWu3/iADFJqCWUYut5JEz4MDnSKNCls09AK51n0Zb7emgsIwYHSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037900; c=relaxed/simple;
	bh=LWvtPY8JOaJUdfA6RqqgaTmXzD6Rya5jbmVIeuYMqlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLq4EJ8rrb43iOmkeMcGd8ZvXhjgAEaF5zYEApUFdcztqrVr7F7hzuIdc4DnLamub59VakalPBFwiAjVXueBYHh/ToVGgA6JWbq5y0xe1Wg/7+KmPy3c5Ji7grcm03wiucIWNIyIC5MkUUXjuUjCDVGE8rY2DFONFW6KB1cwMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hNIRgHDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2016C4CEF7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hNIRgHDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1758037895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWvtPY8JOaJUdfA6RqqgaTmXzD6Rya5jbmVIeuYMqlk=;
	b=hNIRgHDFOvWoOo5UIDpm9aZNXdiRLOJsfTHAOFrCrsquyKWaDg9BzCx8hD8C6q3be7bSK/
	BWC4F4Yx8yi+gntmdZH3jEB8dhuOFYc3iSXtRZc1VQk1e2QmaP19TK0IhmeO+TW4wVk4oW
	4b9eQuouwsPRWoM+TLjNw8T075e652Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5525dafb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Tue, 16 Sep 2025 15:51:34 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381df387fso2540723a34.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0ycVuZ/MwGaN/SPQ6vKPd4Sj2CJDNgXcTepylPsWYn3RDrmDCga4jaaQedm7Pw53iQ/FY5Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qwJEQLOWzOOQSqFztk7QNEKMQA9wA1NFmeCkk+DMnwupiB6+
	5jKrEC5Li0ySsufmW8gaLOZheqJ7TKOuPMqRmgOI1docbkI5454rraMW5mbpvQ4+KF/opwo721i
	EslJnTnIvuAM5RybqpuZYnViunYtjgi8=
X-Google-Smtp-Source: AGHT+IGP3SbAdOU4oqfpbda8n9JY4xGEouxACuVPUK518Vvhsmppkle9doyRfdV089EzJh2FTqLp3XYTq06dthgl3G8=
X-Received: by 2002:a05:6808:1b0a:b0:438:384c:36db with SMTP id
 5614622812f47-43b8d90d7c5mr7717876b6e.15.1758037892410; Tue, 16 Sep 2025
 08:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-wg-ynl-rfc@fiberby.net>
In-Reply-To: <20250904-wg-ynl-rfc@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Sep 2025 17:51:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9ra4_P0-FdVV75gaAWiW8yWsUJJsmTes_kac0EdTgnjHQ@mail.gmail.com>
X-Gm-Features: AS18NWBaLEA3oFeqxFk5qRFGjst8026RADBzbjhLf2Na8sHUXJEqAzutzDYhGUA
Message-ID: <CAHmME9ra4_P0-FdVV75gaAWiW8yWsUJJsmTes_kac0EdTgnjHQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/14] wireguard: netlink: ynl conversion
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Asbjorn,

On Fri, Sep 5, 2025 at 12:03=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> This series contains the wireguard changes needed to adopt
> an YNL-based generated netlink code.
>
> This RFC series is posted for reference, as it is referenced
> from the current v1 series of ynl preparations, which has to
> go in before this series can be submitted for net-next.

I'm not actually convinced this makes anything better. It seems like
the code becomes more complicated and less obvious. What is the
benefit here? As is, I really don't like this direction.

Jason

