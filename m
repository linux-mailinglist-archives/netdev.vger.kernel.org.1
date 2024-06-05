Return-Path: <netdev+bounces-100867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A428FC561
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2FF1F217CE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886418F2E7;
	Wed,  5 Jun 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKb9SgiM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3518F2E9
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574882; cv=none; b=c64Dw1zIjAGhMsGpGzbjYEZbu3edQBSPDZAc/DLmgb9sqw7QV6xbCC+U8CqAXnvMG/5nyndUNc6BrIf63MnjuEvO1P2Qg6a3JpfElDFvY/Y3VWTcq5EE3iVPU2Nfvz3YoWorCrr2TbtyoVaTMFzKVKE1yDV/jz5vFpVU2CPY9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574882; c=relaxed/simple;
	bh=PaE7mEZfJxLBb2yt2DAyS73D75IvOfORiK3X0XZJW+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aW2cfb9qnT15m+FVr2KtJidk7Tmz7dr53EzHJqV/p7dKcaW5y5rNFbrVsBk0aXlreL3/NP2cPXlJxNgnr81zDAOsmOxDg0MW+60zz1rOHiFJkXUQEW+flx8Zb8p2nw3YYrdZWjxLrmGDNyuA6JWEPfdxrtovQA1pe1Yqo7qHsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKb9SgiM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so45305e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717574879; x=1718179679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrCOiRPfrbF8KgkjXf2+OjTb6u3WQ9a+GX9ZNmr2TUc=;
        b=eKb9SgiM1Ywd2b2fjnigch5afjE0A0sA+5Y+7Kxa2Ik6GFQm6MkPKA79Jf6P449FLk
         wkY5C2oA4Okd3khdhVjQ4RhEhINz8LklGcuS5CSfFJfMdOfHhPxEK/TnzPk3p7N7KVei
         6P0nm/NjadEW9M5E9wJBsIbZGCbSuL0K/Dpgo54/+8521YoHQ03NS8S12V7PQGJH0uEp
         q7R4HJeIWQ02V3hIgr7kl+rS2tJeDipyE837GUaoJmxzsvx2WwXKn+jj4ShMW3xe+4Oa
         YN1AfOk6ku8bO7ZqiOQireFUzTDZPPl9Ccl8J+9kwWddNwsIIhS8JYop0nV0X7iOuNqI
         +1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574879; x=1718179679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrCOiRPfrbF8KgkjXf2+OjTb6u3WQ9a+GX9ZNmr2TUc=;
        b=U44fZwkO2aayLkHSq32SD2VJic/npi5s4y1mvuu24rbU6QKBDP2Wh8o/arX62kHXgU
         iKgYAYBC8oeAY8LqblvpH5UsVE9AHJg7eRczeR3YSCp+ezeoEPOLmlYVeZvWT+IHJSUV
         nfJWRUsGz5RetbfFVt93YwPgK+v6oSpU/Cbjy5/qQmL2Mrd1hC7RBsj82OvFxV9hIvaw
         UjMkUNFbLzy8GsBW003omMdKENwSGkSoGNWQo944/YAjKksYrGBvAchHEEVZgkhAfTEv
         v1Jss3COfOqMX3d99209uqP9BKi7jQJ7a/CHFGBoT6oew+JBgp1oKWUupWrE+dTe69oE
         vDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Rjl7+BPrBpDMex0Zzhsasriqe/esCSQEsY3Rz3CkfGPDjBmSVkBWAEetTUWcPLK+qAbGMB6MM5JkfQ0pvVu9u+rs9MUb
X-Gm-Message-State: AOJu0YyaroycuX7SQ4kJtzMU+s3Wm7uOT63eYBdgac+B9RDrUzi29HyB
	GFFnjjEu8RhCCC68Mp4jmKBtG0CWFPeZIQI226uzVfgqv8BexO2wePOvCdD50U2KGFQExnobdmx
	gJ3X76Da1x9/FOgMPoZUmbR39q/rsFygWXOOX
X-Google-Smtp-Source: AGHT+IE+9uivXSD5/gDpelbCKai6RvbBA7yxMmFIucAYEXrjABgLZaNA9/zk6SuWHQzcKrc0ReHGu9NE100jrq+FnwY=
X-Received: by 2002:a05:600c:2942:b0:418:97c6:188d with SMTP id
 5b1f17b1804b1-42157e4cd5cmr1243755e9.7.1717574878367; Wed, 05 Jun 2024
 01:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 10:07:47 +0200
Message-ID: <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); anymore ?

