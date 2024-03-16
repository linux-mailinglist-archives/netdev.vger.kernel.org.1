Return-Path: <netdev+bounces-80223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B626287DA91
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 16:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526B11F21954
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA01B948;
	Sat, 16 Mar 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFN0gmYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB79199B4
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602716; cv=none; b=iCNd2HgIOXGx1qSJqtIf6V0LNwcDmxEJnKpgzacZt8AGTtff6/unAsclZsbKy9NbaehxH9wdZgd0NpP+v2dH7GHsA4WBs54W22lPluAlauYxUJ3nPwr1hETFol08OX+fEKCl7TxOl3BEcKTZ+To/KSSuDWo0aPBF4Fh1wbePbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602716; c=relaxed/simple;
	bh=avMDPaa08zhOl1Fv2Oswi0oyTGJ8Gupf7WTpwW8mQks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qt5evkhqBd5xxjCNWj7oKsZt5GS94Va9kX1TB0E/2bbAVj54sem5eMoj/lK3E2hRsKurxKcv31bhV9LqrwyluUCrcLffVPbrFwRl57UUFHXQh1R3XSqQr18SF7Dla8BJe7jWPgXtphfHWUeeCZ1u3kQHpHRp1wTJTr9/MGRJ9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFN0gmYh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e67d42422aso994038a34.0
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710602714; x=1711207514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZUhZ+AQpGlMRROppFFZNXzDbjtnsMgo/9MOpeYW554=;
        b=cFN0gmYht9v7g5WY/aa8g5ujMHu0qUVO7d+uR9aoOcyd8dZKkDNSnaduZ1z2TSmHUi
         X19abXhM7e4nGkUAyWKcsBGJ/yXhg08VoUMH+xi6CZjDtx3bDQiIHKJU1GQjqc77LIoe
         jRGcePzzYS1Hk8hqU3sCjely63Xxb5z9oE92ta2xLU7oO7mqdM5Q9YESvbpQhtiOWFR/
         tp+l3TEAQ0PkraZu/5LhTA8A6vx404AylEqS4KIjYWwV1etputsXpZvSR6UIq7nBRArT
         JPiPq90PwIRO0b0NOizFxx+jRCZtKsgZs3uZBvcPS8L83qf7C0mVTU3pi1iHEBCzA9px
         MsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602714; x=1711207514;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZUhZ+AQpGlMRROppFFZNXzDbjtnsMgo/9MOpeYW554=;
        b=C1UTrfV90+Pxw2Z+rh7xJn0099sRv+eiNMR6d4qnjZlllJduum5NupG4DGAOoFr7aW
         JZ4G3/l1b2EhKeU8nvUBWOcjmjYErNwtfa6yN6xD1Cp4zMRYfYPr2MflcDIpa0EhYCFg
         8/M5r0FiO7mV5/ouIiDyTX8OyyM+HX5vkyxPEcJioP+i83y9o60X5xi9JbCdy+/yROXp
         FqBisMtaLMoKW8nxO3MbGRspLEYTvQWsAkQriJBUhpIm3UqYqXMswAyN4O1k9q+0UF/i
         K4Ae0jVgwEM9zcDFzjfyV5oNASscE252uO/noKqJFKeHXLnbmJSRpB4zjka4kofikE3c
         uZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0f4Bdtl+YPt+cXCREGG20QYgMFCECIduNaRLajWU54LK7Ftlf6+FxNMWFTuHFue7Gy2c//NEZ45UP4HyfIrGDlnnarEd7
X-Gm-Message-State: AOJu0Yy3/i1RfZiRQ+7UEya/5w26gZUG74ujO2cAsBE7oyXPZn4Wr50D
	YPM2c6x09vBZyV3c1Q2TLpIRUszRlq15aFQuwXOXucYHB4JX/lbl
X-Google-Smtp-Source: AGHT+IEnKxTO/DH6szzJ4xyaWwqauup9OHmW7yqSqrIA4ELcvUC0HIo5Q4zVHiCLuVVFMQBE/OLfdQ==
X-Received: by 2002:a9d:7f07:0:b0:6e5:c099:3313 with SMTP id j7-20020a9d7f07000000b006e5c0993313mr8139429otq.19.1710602713946;
        Sat, 16 Mar 2024 08:25:13 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id l8-20020a05620a210800b00788791f23cbsm2942511qkl.89.2024.03.16.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:25:13 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:25:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 netdev@vger.kernel.org
Message-ID: <65f5b9d952450_6ef3e294f1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240315151722.119628-3-atenart@kernel.org>
References: <20240315151722.119628-1-atenart@kernel.org>
 <20240315151722.119628-3-atenart@kernel.org>
Subject: Re: [PATCH net 2/4] gro: fix ownership transfer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Issue was found while using rx-gro-list. If fragmented packets are GROed

Only if you need to respin: "If packets are GROed with fraglist"

A bit pedantic, but this is subtle stuff. These are not IP fragmented
packets. Or worse, UDP fragmentation offload.

> in skb_gro_receive_list, they might be segmented later on and continue
> their journey in the stack. In skb_segment_list those skbs can be reused
> as-is. This is an issue as their destructor was removed in
> skb_gro_receive_list but not the reference to their socket, and then
> they can't be orphaned. Fix this by also removing the reference to the
> socket.
> 
> For example this could be observed,
> 
>   kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
>   RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
>   Call Trace:
>    ipv6_list_rcv+0x250/0x3f0
>    __netif_receive_skb_list_core+0x49d/0x8f0
>    netif_receive_skb_list_internal+0x634/0xd40
>    napi_complete_done+0x1d2/0x7d0
>    gro_cell_poll+0x118/0x1f0
> 
> A similar construction is found in skb_gro_receive, apply the same
> change there.
> 
> Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock reference")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Looks fine to me on the understanding that the only GSO packets that
arrive with skb->sk are are result of the referenced commit, and thus
had sock_wfree as destructor.

