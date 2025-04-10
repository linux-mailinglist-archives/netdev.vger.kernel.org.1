Return-Path: <netdev+bounces-181350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6BA84982
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB651680DC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA11EE031;
	Thu, 10 Apr 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKj9ahqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337A1E5B64
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302282; cv=none; b=IeQD9Jzztpn0IxW4Wd9jlqmCcKX2rwINL6JSaB6bAeI6BuyoxOMyLbxi0Bgz296mHb7MwBgbt64z9RE+I75H55RHtUJBg2IVyJkR9Ybi2GmxhYOSPa41/1RvloQd2g5GEEvQSRuEEb99mBS2qs/db5aftqOPtIU209R6DC4vx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302282; c=relaxed/simple;
	bh=6v4nFtyz0M2gdeLy2tyI20AHjBf1pIklC2ygDx7e3SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0aB3JCyuR0VNZuLY6ZpB7lLVX0LP9t+KgrVCYM5MykC5sRj+bUqbSxXUgJ0dwf3dQTxlaN4HT4k6+G/GMkO/j6ZA4LPmeGULmhdRF5sFilpnO1PTGS0Ziv4DHspW/dc1JH7QkcR44/0GwioHiZPWkcazhlSkwQys+aC6EnNbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKj9ahqO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47677b77725so10055901cf.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744302279; x=1744907079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v4nFtyz0M2gdeLy2tyI20AHjBf1pIklC2ygDx7e3SU=;
        b=mKj9ahqOwM7Wd3EoRd0YMrfHo7E7Y9z3BUFM9QdcBKeUAxWwKT/sVRcpTwhKiPVaeR
         Cq4Rns/OHdf0vQdztpPo0ss4wo7M3NhkKvq+zrMfnz6ShoqDaNzLB5362oH68r3WwWUQ
         hmIhdeArCma+E7kFA9VkPYUGgg55UtI46SZ45o0UVfNnsri5TA+R8vgOArwS5xAs7RCm
         x/L1rG/ZufCoupkB3jd0wBo3KQw7WwS2osKnBi+82j+3aORZgGyxgPf7SujnW56insrY
         tzOJJY5ON2RvwVsFb6gObLn6rqim77fecGcUmZoCzdFpOHsjWiSR/8WZ8U8kSgDk4aqX
         p1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302279; x=1744907079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v4nFtyz0M2gdeLy2tyI20AHjBf1pIklC2ygDx7e3SU=;
        b=Ot8ZiNa7LS9YkVyNfunmZ4Amix4PHSv+p9mdqUUpdTGV6P9ebckLIvEqUWSO+ccJjG
         p8vrc151FJPiKfIqQCy/ZOttNB2dGoeZ0wz8OQJb3gMgR6FRSMMG3/lvP4AmvQ1kr8TK
         Ext5dyFsJuoWt+oTZ/dYPX6qh2Sd1nV3plmoEsBjsbh/70rCP0I+TuuuNnir6CWW1+TC
         6XNmNeDg6cGDNkODMeR1h5E6RaQjt11Deq04owkX2NgpgUM2Gvp3UeBNobtvCWoWOq5o
         1PDKHiXdFKPxrwZdNfqdDnYkENL+zV+xVKx69jK4bH7O/RqV9SDSisGTCABA9q5bz6Wv
         OhWg==
X-Gm-Message-State: AOJu0Yy3ICWPVHL52Ki/omqcglBCCd8x5TKFtFPdEeXOkX9WlMkmf78P
	njWAbzj77Wc5Kxx9BZUjLRyqaHIFHhFArxCNlAzZREeYWnEmHSFuk45Jo+nV7ASIMnHpvNFnp8X
	iDtbIljF+EW1G1Zm+L6zTejb42QR+QLI2eNNV
X-Gm-Gg: ASbGnctw0nDGCQoqv8x0++sfaHVxGzPjGS+fHmwvNAT6jI+0RZpDjGxFoemLc5rqvIQ
	wJJl0hEgn77xPyoHDFtrPx25IkxYDxgIwEU/4h+gRJKjiTUDdkf+PoQV7d+LkuY61ksD0OsTwxg
	SCz6wfKdcvLnpZkuGpNZeiM7Y=
X-Google-Smtp-Source: AGHT+IHlJ6gh7u/Utj15awFQ2ygVGE04gXu6kHE36bW0/saInVnGO/KvFIdhEhUEwzFys4KxIRiV+jlvLu2uaF2UkWI=
X-Received: by 2002:a05:622a:178f:b0:476:9e90:101d with SMTP id
 d75a77b69052e-4796e362cafmr49091321cf.38.1744302278282; Thu, 10 Apr 2025
 09:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410161619.3581785-1-sdf@fomichev.me>
In-Reply-To: <20250410161619.3581785-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 18:24:27 +0200
X-Gm-Features: ATxdqUGgn3yioNYaYTD9zcVd-LskD61diZl4-BAdgTEt9MIzCHOJfqUIc_ybq_w
Message-ID: <CANn89iJ_CYgP2YQVtL6iQ845GUTkt9Sc6CWgjPB=bJwDPOZr1g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: drop tcp_v{4,6}_restore_cb
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org, 
	dsahern@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:16=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Instead of moving and restoring IP[6]CB, reorder tcp_skb_cb
> to alias with inet[6]_skb_parm. Add static asserts to make
> sure tcp_skb_cb fits into skb.cb and that inet[6]_skb_parm is
> at the proper offset.

May I ask : why ?

I think you are simply reverting 971f10eca18 ("tcp: better TCP_SKB_CB
layout to reduce cache line misses")
without any performance measurements.

