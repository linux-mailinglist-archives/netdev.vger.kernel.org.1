Return-Path: <netdev+bounces-251210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 828CFD3B510
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C7C30A3A35
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37732ED24;
	Mon, 19 Jan 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxoPuxfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32C32ED31
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845603; cv=pass; b=RqsydtmttxYFjp2CnAdkrBKyvjTfRIbZbgbVoy2ndGKcHrkJdcGnOj+Fpsuj2RcFXHwSN4sAJmacznJsQm/JFLV5yJf02ne4REPxnR2mlcd6vtCco5f0JTdRcbxoomyChIuOZbS1oxx5wl+S93igfBTRUNkquDGrG9VvvjvBJF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845603; c=relaxed/simple;
	bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQcnObKU01+to5N49KqpmHHVZEyjHu87DenGGTUG+T5gT9YNqllA1S4mBq55tXWQuIZQ5Leqcb6B78EQI1DEDJNEaBvszetkOABI2ouiuWnLl2ztyP62DI6h2FfKB7i4YnhS1BC6CvPVxsHZQGNg+pLis2QD3rjQhpJgUHzRL4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxoPuxfv; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014e8a42aeso49093331cf.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768845598; cv=none;
        d=google.com; s=arc-20240605;
        b=WYgyyGiw7muYm/N54cq/QJ48mKCmBeAt2/rxCR5aCbUU4nuFFnr6xOVoD1YRv9dsWM
         Yu8baOS7POAX8tMdQO9SNiuFR/CYo8BMO0elHvpkbgy4AZmo9Kl8BKjtA/k1va1SaGCc
         jN5bG2J9lYQetf1k+9MnJV6YK9bw0egcR2zGZV50Hx+UuTCAJRNJKrvTdB/GF7lWixsw
         1NCsm2UVuPgpgB2m0gpk+bIBYsSX9AVnQNdlxKDvpB9EB33GPnLld/jQ9Z0LM8y9q5AU
         SSRXqO9xhKJn+Pytej9mzT/2RYCb8Yhs7OusvQZv9UsyWliFvi7l769L1B2eggSA2QB2
         E0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
        fh=ih2sBE3mQ2/fblzgbLkyuBRGc+40+wtlwCCvOr0X3vI=;
        b=GCiVcVQn/iuWiy17tNb+NAqGOHpd0rymLNWAap820uUOlWc5p7hxfQZRCbVXbxu1Tg
         ipEMIMRzTl2PT1BwlHZKFzbK4Jozb4WqCatehzT1umSG1OfhzhHj7QfVNDaioTPB3+bl
         m32t+W6zTX6v9FLC/FCFYugkvDXI+ILI3AFkuqMbv5ESHd/OM/av8f3h9waHlNj3JVmJ
         zw8+wJe9253zQiL1fZMX0VW8I+BThC+YQg/vwfDvKwpwsQSW6QeInNHnXbPnv4IStmFp
         W2QgZOQeaCQsBUtd1qwQc6a3qt9rOeJGplA5cOgl8bc2ukpbijZqmb+RjC2nc6ykJO0F
         Qumg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768845598; x=1769450398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
        b=BxoPuxfvnTyWHZQhMq8KCvC3mU3ZteFSOwRzKnDZ2BLL24Mwj/lne6W+hbzeD1TW4G
         dEHRCpiO2pRCLSAoYPOY9itXGEJ4AXMuRxHLxFb8jC1+VUFsRSu/ni6nxYfBnMw1t8aa
         dvnFNrbJVRtbtotW+z1QT9yaLoQS/+DphWixaTZNbvdcDx1bGSg+1yaSbGR9bJMYnD3j
         q7NsmGK+a3VBILbJ1uCvku9om3R3EOKJgZiV2Fv7m0dpFvASiUR2pQ0v7MfOzGT6c562
         KJC3xQweqdltWo+8hAby/cmfUUbx/d4EvU4pQ+PbVB+0tFAyQelm8XTGacItrLOg2VSU
         5cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845598; x=1769450398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHo5efg8CgLD6lt9DbenrpXRwBIRAyaPdhr0/HDvpMI=;
        b=CAN+N+dJ6VSgIft8GysDaj7sz4Nk7DJG3F04kV9nACJDn/RVBuJeDs37yDZNCz/VW7
         diVVwK/6DDuUh+1JOCg8PnYZxCezKXXfw0DrujKvh2njPiFBVR3AjDC86burvIyRU4wC
         Ot26vR466RY0WgLDH8duiZ66GcpQ4+5hmBtwAiRdOqk5EnggCEKc+lgmoWPRNkAszXYk
         g0wC7ye1d+qNlQpqOAa9gOSRkkOvqBPIkjcuFdJhTBgLDKUUuv/7cSddETLszA/UgXiX
         6B5OnkFNeAzK5u/lIiZ50aocSB9BSb1cMoElUPKzjWZpQ7FB3B8pvJFIAnprjabN4PRB
         M9uQ==
X-Gm-Message-State: AOJu0YwgxnOWE78OojzORxKGwpQqjfwpSI9R6otnXnQtk95vIOZ2vxtl
	ipFjJ0quXXNJgllIwOBB5FmruyY8oZtLXE3lmu+FXrp/QIWqs8OUlgOI+tOSz37Tbsgic6NNFu0
	s+O2TiNwRU/EGfEWe94qbj9awLYHQPYWtPBJSVCea
X-Gm-Gg: AY/fxX4sQSFqdKkMpC2YlUUhWBAMaIjLrESAbSlheXiUK6iKx/y+L/B3nn1C8upUlJd
	HhlgvI0Afl9wzh6XPt2yjePopU0gzrzyPziyoWQrBHIu3lZvgbQRA7WrM2cFKXQoOrd7QwV3Yqf
	STNTBNqse+JKkQE/s+4c5qKHe8HxRGgZmxPREFXuVldKW9kFurbYASoyLjW5mE9/A4to3fIvWLP
	PIq7C5vyiI7F+usYDq+x7NL89YdywAUGkOm1nKMdqWGZTVdOL1k33yWc4S4p+D5Kt+9m7HOsAv2
	CaaULOs=
X-Received: by 2002:a05:622a:356:b0:4ee:49b8:fb81 with SMTP id
 d75a77b69052e-502a177b60amr199991471cf.61.1768845597498; Mon, 19 Jan 2026
 09:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119162720.1463859-1-mmyangfl@gmail.com>
In-Reply-To: <20260119162720.1463859-1-mmyangfl@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 18:59:45 +0100
X-Gm-Features: AZwV_Qgbc4ou8ErH-5XVKLl9nYMf59iH7JV60bo76qy64EVbM0CTi0OkQh8LZ1o
Message-ID: <CANn89iLuo+A3M0BSXKJwwsd4T+crXe8u0KiAns7=ks1TXnWaeQ@mail.gmail.com>
Subject: Re: [PATCH net] idpf: Fix data race in idpf_net_dim
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Phani Burra <phani.r.burra@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Alan Brady <alan.brady@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:28=E2=80=AFPM David Yang <mmyangfl@gmail.com> wro=
te:
>
> In idpf_net_dim(), some statistics protected by u64_stats_sync, are read
> and accumulated in ignorance of possible u64_stats_fetch_retry() events.
> The correct way to copy statistics is already illustrated by
> idpf_add_queue_stats(). Fix this by reading them into temporary variables
> first.
>
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

It seems ovs_vport_get_upcall_stats() has a similar bug, are you
interested to fix it as well ?

Thanks !

