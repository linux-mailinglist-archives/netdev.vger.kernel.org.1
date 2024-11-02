Return-Path: <netdev+bounces-141238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDB9BA270
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 21:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448EFB22742
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF61A725F;
	Sat,  2 Nov 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNqbHqCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BE4EB50;
	Sat,  2 Nov 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730579606; cv=none; b=Qj6uzV8rNC31A2ZJavMozEpLwNy0V4nBSyNgDhqiXFfgKirxGZB88zG+iA9FQ2ppCHP4QdM4OW6KNhFrw2TykH6dPHSbiPsg/BwH6BjJBN1ryoEzzwYNucKs+In2J86VMHmBLNHegMaR/EC8OeorPCqekC+ocB1zUZOwoN7pPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730579606; c=relaxed/simple;
	bh=cPnQwBZYflq7d5IMs6Ay6eoaThFmiNtPLwzwsAEt94g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NCWlQxgYcxNgj6RHpi7PnCvJMRk/TqzNSvjxuUl5gcaqB9XgrnbOfyZo0NJABp5eVb3tI5ct1Cp/tA+sNL5k/nJXNi+7yXNMHo7u2o9Y8RbRR6KqSMTwyvLllsc+5ps+nG+KnuM8vBqq2uXMCCpstF1E72XrFTYYOtQN3rATYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNqbHqCV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1356838e87.1;
        Sat, 02 Nov 2024 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730579602; x=1731184402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cPnQwBZYflq7d5IMs6Ay6eoaThFmiNtPLwzwsAEt94g=;
        b=dNqbHqCVTsC21VTUUnyz5vVNXYonGvh2mp4fYAR4rvtZJzhMbFE/MrtuEqLNZdxFIr
         gD0YZVy+JydkmS6FXHRD4/32vyPecKgLAo2r7rlX77K6fDm2QbQYyHvJrjzQyBWoT78i
         XY8v49MhDIDUKzYgE9oaceOidH9scAtcEGjx7Gt76QnhDxeIvSPGGkInBRIPBiPqXEDZ
         CwYH75kupIRH4tjQmVMN/UO2UyfYi0Ja4uAg9/Vq+0VoXl9NdLEP1sPPWSHIgFbiViZR
         EATm+jds+XOEfUAXkup3ZEXu0OoVeKAB2bCDuns9QnRr+sZ34VozFhUMiQsBFl/S6FLh
         fKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730579602; x=1731184402;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPnQwBZYflq7d5IMs6Ay6eoaThFmiNtPLwzwsAEt94g=;
        b=osQFHX3mFkogmqqGmtLhwTPFymsA2AdQWccqWrfFL9Dg+aLsdaUT+Qb7IFrjoW0mvF
         bGU4vpFDFgbCW9AYBoUvqssioGDu0OzfYuHDU9HbaKhbvWUM1cML99DSfiOt7yga3taI
         FG02zIPgMMs/Vgi4eNi92KWIv78ps569kpb7+K91/GB+M38ZOZkd7Obm0w7Wl/GsTC//
         Ds2xZNLWba8Z0jOo6WIbCf7EwWk5v7tHfEGs300FoTKaFGdDJ5Ytja8Tsewkz9rp0Mph
         eJxL5kdRplbRwE6thkf6IK8fJ/ozha+Z53KkwhcLALDTdWaz4fmZaHwsLN+ujvLWd1RI
         EJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ZiuT9Uo0GyaDu49+0BVdFp44iwcp73xDOpJcdF4rB6f3Kz/1XfKRfa7uGPh6S07RO63EOH2FTYcAMw=@vger.kernel.org, AJvYcCWzRvMlAde+muzIqjb5O6EDxoP33WnQlviFI9i8o4N/mlEoHJSHgARh9QCjXhCXsE0qpulGlUDg@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBT9l64WIMwGtlDXTMRcLmX9x17p+k0NT/ElbX3GuDrkPFxoq
	Bua4GQoInTO0dBNZW6faKqb5CXtnQ4MwQtkoA7pcZh545C3E+/JE8vPw1RPvqmoCIWASOC/V+wL
	ibmy979tgtnYnsk7ugqrTX7JVUJ8=
X-Google-Smtp-Source: AGHT+IGoqXppe9fIqDPc/oxsvYg0tqjNuy7LHBTRSrIgWw+QL8DbNnZF6mzI/2dKk2JIvPJ2TGP0zQ1/jEXFYu9I2XM=
X-Received: by 2002:a05:6512:e9b:b0:539:fbfd:fc74 with SMTP id
 2adb3069b0e04-53b7ed185a8mr8536911e87.40.1730579602168; Sat, 02 Nov 2024
 13:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zou <03zouyi09.25@gmail.com>
Date: Sun, 3 Nov 2024 04:33:10 +0800
Message-ID: <CAH_kV5G07_ZL9O41OBYR8JrtxJsr56+Zi=65T_FkaQDefLU_DA@mail.gmail.com>
Subject: [PATCH] ipv6: ip6_fib: fix null-pointer dereference in ipv6_route_native_seq_show()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "David S. Miller" <davem@davemloft.net>, 21210240012@m.fudan.edu.cn, 
	21302010073@m.fudan.edu.cn, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
Assign dev as dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
handling when nexthop_fib6_nh(rt->nh) returns NULL.

Fixes: 0379e8e6a9ef ("ipv6: ip6_fib: avoid NPD in ipv6_route_native_seq_show()")

Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
---
net/ipv6/ip6_fib.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..6632ab65d206 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2555,14 +2555,14 @@ static int ipv6_route_native_seq_show(struct
seq_file *seq, void *v)
#else
seq_puts(seq, "00000000000000000000000000000000 00 ");
#endif
- if (fib6_nh->fib_nh_gw_family) {
+ if (fib6_nh && fib6_nh->fib_nh_gw_family) {
flags |= RTF_GATEWAY;
seq_printf(seq, "%pi6", &fib6_nh->fib_nh_gw6);
} else {
seq_puts(seq, "00000000000000000000000000000000");
}
- dev = fib6_nh->fib_nh_dev;
+ dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
seq_printf(seq, " %08x %08x %08x %08x %8s\n",
rt->fib6_metric, refcount_read(&rt->fib6_ref), 0,
flags, dev ? dev->name : "");
--
2.44.0

