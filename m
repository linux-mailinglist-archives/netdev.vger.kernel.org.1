Return-Path: <netdev+bounces-72423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB47858060
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C69CB20B59
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA612F589;
	Fri, 16 Feb 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hN3pdbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29712F58A
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096434; cv=none; b=oJWWN2e2RhJUnJC9ZN7ITt5n5MB5sBB6fTa6m9iDUbnYATUURtBRjciWYUNVip6QB4wcq8oB+QNmJR3Y44iuvAaB1chNKN8/wUEK6h7YBARNHyUsAKgHzYaT4XjUs1JULq2Ov1X40BJb4adszrEez8nCzIBREl0jbie9VVZXLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096434; c=relaxed/simple;
	bh=iAXmVR2EdKQ3QMpwU3Q1n+bECH3oE8QWZEMs6vIgsS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEmGH+BPapkh2DJWxZX1ukvzic5WKxo905fd3tmhI2f8LltWXg9ThRp6yzGpRukoz12yLAHy442MrR1O7hZ2BdtwxC135/klxKWJt6Loz+GrSK+VuVRj6wvc4+TsK8M32Rz3YXmQW3dvNthjAdfTOoQxfev8KXgAblWoCsGzx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hN3pdbz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so10995a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708096431; x=1708701231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlzUsxX5xRqjM0C+rrFrgpdfv7K4hAD7PeqQ9NvpPdw=;
        b=2hN3pdbzRjrT2t6hzS4zACpsQkZhboFMeGnxxXZjgFi4fUDzNiFB9YdvKyAvNR+Bsj
         QpfoTZHwxjmRPnn0FhCdannbyMQtGU5JfSlqGu3O3JEysA5KKqQjEfuW+gS7MiBNJ6wi
         ghNeOB3Jox2M734YStEK7Ss0e39WHanr7Vlu1JKGgJkUzR/UZSZ1eyKgYzHxS4eAU0/O
         uQtECZOHstWRp+JEoxqHKcNX3nQdK1jKtukzMbjiSKLNfjRnftmmyKzwbJHbmXmePtKj
         yOgsG/XIs3YiiIZhuAWnoE5Jmq9drt7IqMX1TTcJac38JWJgV9FITIpId5S+k0+3yxsF
         ImcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708096431; x=1708701231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlzUsxX5xRqjM0C+rrFrgpdfv7K4hAD7PeqQ9NvpPdw=;
        b=Qkyjg8OlTlAkG4jvSjC4rPUbtXCRAN6ReORw0FamytyF4aCsATQ5FEzEW8+bVdk6PV
         bkKWhgKoiTa6h2njnGV4927HoVppAS0mZPsje03vSqBPcKJiZ4fnylZ0QxT12FjrEWKa
         Xt3LDRRbq/6aReKKC1P6dOkG7/MqH2uwa+ryDneMwcZF8f2lBuWahuFy30bmlsJ3C/z1
         Xm1P+u3DUW1e2opAnXSSWNDskcvc+qvO+qT+XSGL9qOzEp7EVEn44liXtdDewX7ba+lW
         DfqqQYvOXPp9VyGkjnZa4ZN45Nl6ag7A3D2OrMu5FUa9b7na+W4SBDJ0F2Wdzotfm9OD
         g76Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa5ssVU5aZ9hXCax+CFn1bwUo+pNMt8tfYG6Mnvw5i5whZqOXj2j8ghbB6OfO26Zra1c9Jv/H3KQMzpHXuQ4HHvaxzogzz
X-Gm-Message-State: AOJu0Yy8JfqdC+BVLUue5QZgvJEuuYJ1KknKQh2QTzZv9W/bmdiTY0wg
	a6cynwyLgi+j1OHrziMStgcmJrbNlaE+ZxSAv71eY/vrzFxfnyNwU9lcWpCwmoKQmjfR5heGpOA
	3R7Tn+r1fReKtEMAERLFDOnmC78DwtFUz8mJi
X-Google-Smtp-Source: AGHT+IG+M7deEBxxkgFpHNs5JAXWJcmAQfWeqbNiMRsLv9An5XTtHQYV8EX86maNUeI326aH8IvAOSL2GhZTR4AwF7c=
X-Received: by 2002:a50:9b1a:0:b0:562:a438:47ff with SMTP id
 o26-20020a509b1a000000b00562a43847ffmr179726edi.6.1708096430980; Fri, 16 Feb
 2024 07:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc9493j46rZMRIDv@tpad>
In-Reply-To: <Zc9493j46rZMRIDv@tpad>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 16:13:36 +0100
Message-ID: <CANn89iJkjrBr-giBTA3=5t5-EMhc76X1gG6jha3rmm90NriEpw@mail.gmail.com>
Subject: Re: [PATCH] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:02=E2=80=AFPM Marcelo Tosatti <mtosatti@redhat.co=
m> wrote:
>
>
> For systems that use CPU isolation (via nohz_full), creating or destroyin=
g
> a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> static key to be enabled/disabled. This in turn causes undesired
> IPIs to isolated CPUs.
>
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d548431f3fa..cc9a77b4aa4e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,7 @@
>  #include <linux/prandom.h>
>  #include <linux/once_lite.h>
>  #include <net/netdev_rx_queue.h>
> +#include <linux/sched/isolation.h>
>
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -11601,3 +11602,14 @@ static int __init net_dev_init(void)
>  }
>
>  subsys_initcall(net_dev_init);
> +
> +static int __init net_dev_late_init(void)
> +{
> +       /* avoid static key IPIs to isolated CPUs */
> +       if (housekeeping_enabled(HK_TYPE_MISC))
> +               net_enable_timestamp();
> +
> +       return 0;
> +}
> +
> +late_initcall(net_dev_late_init);
>

CC netdev@

SGTM, but could you please add netdev@ when sending patches for network tre=
es ?

Thanks.

