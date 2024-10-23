Return-Path: <netdev+bounces-138287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7579ACD6B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A131F246FC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D251CF5F7;
	Wed, 23 Oct 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3lW8u3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377D1C3041;
	Wed, 23 Oct 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694034; cv=none; b=D2LNN6PM1B7tUcLzn6uHKhEesNDJ5T28zrtt3sLzhskBMCI43mmNV7tdt5iW5hYf2UTjNhmsXQbvag/L8YL7+wNh0bDSt1j4sZuQoj/Z6wzyFjRyl0uKD2zkHqJz4i8GXbKgr/X1rBvtZX4EO3rZvuEk0//rTG/0sdvn9AepjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694034; c=relaxed/simple;
	bh=HmRM3d08xFricdwnH3iJ+2OhdGpv1cRmYZdrZ1jjTLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+mJLxc9UlLoTLhPP+tNt+QFPUGuQ4GpXUIR3LkQokRQXQ3tYsqeKN48zxoEo/LRiUwg6/nhhW25yq87RLRxKZbINdodiSWDMgvciawJ/hEoqJ8IsMfw34QUXBEutiReffEQNRogBv1GAaHjD6px4hwk7csgAfbKFs3INfgTycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3lW8u3g; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so8742706d6.0;
        Wed, 23 Oct 2024 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694032; x=1730298832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmRM3d08xFricdwnH3iJ+2OhdGpv1cRmYZdrZ1jjTLw=;
        b=L3lW8u3g3xofsA6DmroFa3m6IZmgS/LFlmJbA4sfFVOuYbh50Yi1jO9PhOSvYuJzOD
         7tRENbORY9VMVBycEjERMxZ3xWZ3Cte37UZZP2EnZ/josizVwHQr0W4oWMpE+zqgpfla
         EVQzfP1nweQkgrldYeYbZu5XkJHIVYyfjXkjFsCrRCQuvoXt+GAnOB9yNNRixlFylcvj
         cTPu5UoeMgM1HBmcC1lSHTD1pRMDJKQj1YiEjt/BBAayDkycG/PiUdtyZxbgWbSwNi3F
         itAJuHVAcNmJ3NmZKb9vDcxsyE63iw8Vmw5ABgjw/GQL+YFfgOHJECXkpZYyiZeHtogj
         9DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694032; x=1730298832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmRM3d08xFricdwnH3iJ+2OhdGpv1cRmYZdrZ1jjTLw=;
        b=AQwa5w6v4peW7nGhg7YK61WfKpc+yAVASqiwHCUwXiixt/R16j5Y420FJd7IeXxq7W
         ZOVBiR9CXddTeapNjO9irt8Kol6Bsxn+HkB5hhJw6APVKubCjRkItWRD7SZ+aJ40jopq
         MwcQI7XJ+Hioz9pOGytB+182iMsi/bAi8r/ZIM/pLLNCmCw25nQjUpu91CXWC4ApX4ce
         NW2xJ6t6+HUpZCT/uAvFAvHprVWm4+8r4jreUup4JJ+n6Dq395lRY6PgqJsvM4KPYV4g
         wGK9vJUJ1graDAjPM0f0VXup+zVmHbPG1y0A/6q6NzQaVqlXkHwmX3t7FemywYnRgxtP
         N4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKlmD770kDVsWnRRuiwQ4a72YmC62RL3R1kziezrI018vUuc0WKkKezEo76VHGThJjoFJbi2d@vger.kernel.org, AJvYcCVI7pc55bwf52+ewZdmvqkMoD63RgNScyeetgsLOx+0h3l6MmNZsCUpmOkeheCKlK2f6aBzBKbPplT+JEVqNDBlpX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnecWXKoKAq1XikpGnzYXBJYB9DRyJzKHBn+wJ6M31NwNaIib
	iXGXfV5NNQVk5n/CKU0OoO5Iz7grcaZVYtzuc8T12QxFop2s66uevAaDRzZdbpvIVhSVinQTirE
	OGr0yjyeWbq/2gZUluVVFE9jTov0=
X-Google-Smtp-Source: AGHT+IEfDzRf9dWHDfzyH+e6g66/bt8kDfUdo7MvudwA+PJEpStYO2WwPirLFJuaIHEe74QWWeKAeALP020qLXD8/yk=
X-Received: by 2002:a05:6214:1d2b:b0:6cb:5ef6:93e9 with SMTP id
 6a1803df08f44-6ce219d5220mr112755706d6.9.1729694031866; Wed, 23 Oct 2024
 07:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com> <CADxym3YB4ywpSp92Zctmh_k1K5OL7vTUAadFOsFuV=RdEvvwgA@mail.gmail.com>
In-Reply-To: <CADxym3YB4ywpSp92Zctmh_k1K5OL7vTUAadFOsFuV=RdEvvwgA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 22:33:15 +0800
Message-ID: <CALOAHbA9CDE0QCrp5TKJam5DejBzuw=AJsZZFqpWQeKxkaaHQg@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:59=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Wed, Oct 23, 2024 at 8:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > We previously hooked the tcp_drop_reason() function using BPF to monito=
r
> > TCP drop reasons. However, after upgrading our compiler from GCC 9 to G=
CC
> > 11, tcp_drop_reason() is now inlined, preventing us from hooking into i=
t.
> > To address this, it would be beneficial to introduce a dedicated tracep=
oint
> > for monitoring.
>
> Hello,
>
> Can the existing tracepoint kfree_skb do this work? AFAIK, you
> can attach you BPF to the kfree_skb tracepoint and do some filter
> according to the "protocol" field, or the information "sk" field. And
> this works fine in my tool.
>
> I hope I'm not missing something :/
>
> BTW, I do such filter in probe_parse_skb_sk() in
> https://github.com/OpenCloudOS/nettrace/blob/master/shared/bpf/skb_parse.=
h

We prefer not to hook the kfree_skb tracepoint, as we want to avoid
the overhead of parsing extensive information from @skb. Since we now
have a function that can be easily hooked, why not hook it directly?

--
Regards
Yafang

