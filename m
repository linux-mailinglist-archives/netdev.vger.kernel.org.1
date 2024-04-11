Return-Path: <netdev+bounces-87152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4918A1E27
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009E028B851
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BD3DBB2;
	Thu, 11 Apr 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbOnznns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388ED3D0B3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858020; cv=none; b=N/5XYl8mH8NGX9cSyaTayfoBpQiHtrieLVTC5dnTV9LMK973F829UzHMGKE921b1zjo/1oJdPpG4LRTfBQs8DkU2XSZOU+GuY3wTYD3ZsHS/Drf9a9zXi7YuLaLn7JZt9BLBSwYSUPQjsOvZE4VIrirIdnEu9T/RBVPQtOVvxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858020; c=relaxed/simple;
	bh=B0HrmIvCCHp7o7TPXpEgjWp48PXZzwoszLotG5+zcrw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fgt2ZA9PIuf3w1jH9trVcXn3LhEst52DFov2q4TwIDWsblVrymlSgvs/MNRukJyqCxjY1zOxMmJhn01+pKd7o4fO53pzkRt+RRYZmYSyf7msitvBU6ZU1OgjDpY2i3107IaWWqL02bm80o2HpMLJEs9iWU/SWMnhKyJEXst77Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbOnznns; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a450bedffdfso7566866b.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858017; x=1713462817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sp0lwP227flTmYXDoNIBfXzzsTrPc7/WvnkcCEtgSpI=;
        b=jbOnznnsjtyq0EgsHiydRBdgdX0gWW5MUshnZC73tSgF+BT43OtEoamZtG5V2UrZhz
         wlyujZslnb/2IbTgsk9bI8XUFW3h2dLbuA++PzUtfKWEkXrYN/DaAxguA/gkZU+aFCN8
         S8GA/L2VUHw25wMMHRTBNYz7k8qy0ddhfPCgXKbmwpQy+xR8xEcP0SiUyaFF1j4+p3FK
         tu1BlV4Bq9+f9VWtChsj2Lom5tpuCMqgBlTwCCHmioz9XhvtxjIB1hgJrfz837ZHH6XG
         tz5PGNCsXgQiC/MIwvjQazuAYp+CtVMu5wiCF4C+czTGqQRCgyEuXpDpC8qwUb2z3H4T
         FhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858017; x=1713462817;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sp0lwP227flTmYXDoNIBfXzzsTrPc7/WvnkcCEtgSpI=;
        b=pd/i1hNAH/BYKWe0fdB2JAlqGChS3wDY1ey2ub8xQvYL/ReMqKdhnJdi8xdrdcfQ3t
         La3eWU1BL4mzx16cp9z2Jsxr7mXDLECwOa/Fxp53GGLvCeHNRHzLade/LKDyhS+ILQU7
         LvzgBVJHU2qFkx7dnOWgFF0BTlrzvzsao7LpFYKhMM2yMOlM+F8/oq2J7dJGuPv/SBBl
         v7fZQ5HWVe0WVUTk8w3QrBvtP3N8usW6TuzwLC3yZO3nE9KQdEOgF61Lptpam97uv9vt
         e3WSeOtAPwyKJqKD1TjKMjiuAGvyVBaHnXUpgkuuGnMdcK69xUJ7ZS6NfX8Vf1yzo1lz
         Wrbw==
X-Gm-Message-State: AOJu0YzaazEq25SL8XS7584J6xwjFh8WVsyUiNzBMPpWkH+t6UkXo0nY
	mBF3qZHCjHLXH8P0zWx8hkIr9OBUA6nwJcfl7iY/lJA/XYDKf5p9tlWgMLd0DeQc0sLj4DOe6Nm
	90kCDlAy0LLNU4veA7wJMg0ZB79I=
X-Google-Smtp-Source: AGHT+IGPBsUY83qE49qusjl5v6TT80JYK4ck4TNT8KFHJ1i4jE03qy8x+LYS1OJxWGwxjdYCA4NtpzAiPeASDYHTvuA=
X-Received: by 2002:a17:906:4c5a:b0:a51:82e1:ef52 with SMTP id
 d26-20020a1709064c5a00b00a5182e1ef52mr289587ejw.11.1712858017210; Thu, 11 Apr
 2024 10:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yick Xie <yick.xie@gmail.com>
Date: Fri, 12 Apr 2024 01:53:27 +0800
Message-ID: <CADaRJKtHCvBH_GJkqF2+NjaLg6uzo4-8s6YDuzT=HzJdDM4hHg@mail.gmail.com>
Subject: [BUG report] GSO cmsg always turns UDP into unconnected
To: willemb@google.com, davem@davemloft.net, willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

If "udp_cmsg_send()" returned 0 (i.e. only SOL_UDP cmsg),  "connected"
would still be set to 0, later inevitably "ip_route_output_flow()".
In other words, a connected UDP works as unconnected.

A potential fix like this:

```
https://github.com/torvalds/linux/blob/20cb38a7af88dc40095da7c2c9094da3873fea23/net/ipv4/udp.c#L1043
@@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
        if (msg->msg_controllen) {
                err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-               if (err > 0)
+               if (err > 0) {
                        err = ip_cmsg_send(sk, msg, &ipc,
                                        sk->sk_family == AF_INET6);
+                       connected = 0;
+               }

                if (unlikely(err < 0)) {
                        kfree(ipc.opt);
                        return err;
                }
                if (ipc.opt)
                        free = 1;
-
-               connected = 0;
        }
```

