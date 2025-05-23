Return-Path: <netdev+bounces-193061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AFAC2484
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADBF189AC53
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7329373C;
	Fri, 23 May 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEPsRVuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAADC2F2;
	Fri, 23 May 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008332; cv=none; b=Mbu7flWamKGU9BRh7NnOFw3FF8epPmLlUjBpahLUCUS/gRFq/ua3j1JCX0pPePkrpmXY/9xJ/DiYBfZEuXCoXpVm7uvCUM8aSYUL3fbFnnvBEmJAyFiEommuEBU/nTcPC9/HAejrlDNmA4yGplw+mw98WEfoehsI8/zC29HMxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008332; c=relaxed/simple;
	bh=okXktSXXKlwWCc+wTRfTeTOzXuBVh67f+79xzSw5UCA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YBPVzjiTFXLPk567ggoooMUiCfKtroKn4oJtm1slywNwtKmImXPMlyd/EdrsTHR/MY/Pl6kuVb/oCcSy44XRUY6AGxvbsapdOWw6SX/kLoz9lv7mrYNVRiIz140UYPmseahPBTxK/NNrm7deM3OlEN+4pGKFPdDsWbNu8y3NDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEPsRVuL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7cd0a7b672bso619438285a.2;
        Fri, 23 May 2025 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748008329; x=1748613129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RemTPIobewrO6gBHjEJRlgNmZpEaAhVrFdbsi5eaHYI=;
        b=AEPsRVuLtV1vbE9NM2fhIZA6tMWgjz4Dq/d+1W7AiPvntEvCVnn7xUeeT1Si7mW7fj
         5DF85C7JiNRcsbnQS2dDx3EAuAJyd2F7ijQybK+h+kvLQmsyd/zV+fD5ahEBXw/sqniV
         F1sQ1FYhAOznxjvVD4ValUSmu84o9lmCDP2Y9/+Kw8I4x4a6cOn16X1duMUvjPNRbW/H
         cQfGyB3Yb0llhqzxuSESrI0FUfroh/aSd2Xu6PKFTVKCAsT7KGgd0skhIq6Sg7SkgceQ
         HdETdHxGfohir5uEOvm9XFCCrWMSeRkhfv4nhlkWR7esnAyPn0iWSO9x0fp7CI6pUkmy
         oVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748008329; x=1748613129;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RemTPIobewrO6gBHjEJRlgNmZpEaAhVrFdbsi5eaHYI=;
        b=jlJVlEZWPbWmTaTd8rzMI5DKfBf7hyCdm/80AisuRO30Au21L/15oarNZ7C1iGmzgL
         ituT47PAqMqiAgozM/G17DE03BUCXpCRl5z1ckJ0EjcYS41dCRg70YadyxXDGnCpH25p
         cwjMPjH/RSfC8jx1a1w+Tk1B8uyR7Gd8UlS5+V/YmPyMMXyOgDLARUvHe/Ook/A/bMx+
         UcvwIiO/9JhcO/KlPbt512kIKoaG6AuR0CPWtt/WQzFf8dxhLx74M+0LdO4B1tV++koQ
         dF1GFskk5AmfKdlItYv7Bw7NK3ylP4MLR8ABVe3/gelUM6zJX//bvvhxWCbuujHtkKIb
         4flA==
X-Forwarded-Encrypted: i=1; AJvYcCVxFnaGMT2SHFF35pqrzRYAxQ45U6X5SEZd6Ni5+u9O3zTBs+lG04MrRV4ELXzSMKSN8Qj64gho@vger.kernel.org, AJvYcCW4/mo1ocE3nWKoJKuYww5bA8T6z5Tr7S/Yq+QWLdw6cAX3/7Z4vslnLRelRDq9wD1Y3pF/mlEwY00peF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl5GAjQ3Hi0Y/OXdW03DSSMzD7/1Sfiyg0iKUComIPYG7m3NP
	aAmkH52bYZZcpfSJIMtZ6XByR5xSAWuouCV4Cz44fexJ6Cx88Jz+//v6
X-Gm-Gg: ASbGncsvxGlUtsb8XpxMrpHWDGuHVqqrAN10llKexKo7iTCEOrV59ylnZlZ2YXe+mSP
	P2YqYAlKj33JU8UYLYUxvInaNoaePAryRmMwoBMWodLG6S7IufmKepBu2lALh3f/dR8X7mA/da3
	71BYz8JWeB/q1mI58wz1iSZ50QF+9/fi4ymFArEBt7+wqU5jx//3uFPXP1rZUDwlBJB88mt77sH
	eqJjyyVHVq7zfMX1BgBART690/5cqaaHLl/TvEdtGdt5BLix3DsIyo06s7KXsAWOtqdz9m0nwAZ
	zGwubX7GUk6RLLEGelZwJvcVuT53am1AQx3g6fzy0RW7sVF9OBKY+8jal8TFHSCWB1EF+f54Iva
	ixW4GAA8ZGAWI5HX5BSqRsy4=
X-Google-Smtp-Source: AGHT+IHqLbATUy/WFPl30772cHKchFOV8vW/thCCQHyPMvtyml4xGVHEDLLvB0GjHW9MepKaGc74xQ==
X-Received: by 2002:a05:620a:25c6:b0:7ca:df2c:e112 with SMTP id af79cd13be357-7cee326c929mr433516485a.45.1748008328640;
        Fri, 23 May 2025 06:52:08 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd47c2d217sm1159876485a.92.2025.05.23.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:52:08 -0700 (PDT)
Date: Fri, 23 May 2025 09:52:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Shiming Cheng <shiming.cheng@mediatek.com>
Cc: willemdebruijin.kernel@gmail.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 lena.wang@mediatek.com
Message-ID: <68307d87d58f8_180c7829432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250522094954.2f8090ce@kernel.org>
References: <20250522031835.4395-1-shiming.cheng@mediatek.com>
 <20250522094954.2f8090ce@kernel.org>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 22 May 2025 11:18:04 +0800 Shiming Cheng wrote:
> >     Detect invalid geometry due to pull from frag_list, and pass to
> >     regular skb_segment. if only part of the fraglist payload is pulled
> >     into head_skb, When splitting packets in the skb_segment function,
> >     it will always cause exception as below.
> > 
> >     Valid SKB_GSO_FRAGLIST skbs
> >     - consist of two or more segments
> >     - the head_skb holds the protocol headers plus first gso_size
> >     - one or more frag_list skbs hold exactly one segment
> >     - all but the last must be gso_size
> > 
> >     Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> >     modify fraglist skbs, breaking these invariants.
> > 
> >     In extreme cases they pull one part of data into skb linear. For UDP,
> >     this  causes three payloads with lengths of (11,11,10) bytes were
> >     pulled tail to become (12,10,10) bytes.
> > 
> >     When splitting packets in the skb_segment function, the first two
> >     packets of (11,11) bytes are split using skb_copy_bits. But when
> >     the last packet of 10 bytes is split, because hsize becomes nagative,
> >     it enters the skb_clone process instead of continuing to use
> >     skb_copy_bits. In fact, the data for skb_clone has already been
> >     copied into the second packet.
> > 
> >     when hsize < 0,  the payload of the fraglist has already been copied
> >     (with skb_copy_bits), so there is no need to enter skb_clone to
> >     process this packet. Instead, continue using skb_copy_bits to process
> >     the next packet.
> 
> nit: please un-indent the text, you can keep the stack trace indented
> but the commit message explanation should not be. And if you can
> run the stack trace thru decode_stacktrace to add source code
> references.

Most of this quotes my earlier patch, but without saying so.

https://lore.kernel.org/netdev/20241001171752.107580-1-willemdebruijn.kernel@gmail.com/

Btw, my email address was misspelled.

> 
> This patch seems to be causing regressions for SCTP, see:
> https://lore.kernel.org/all/aC82JEehNShMjW8-@strlen.de/
> If you send a v2 please make sure you add test cases to
> net/core/net_test.c for both the geometry you're trying to fix,
> and the geometry you got wrong in v1.



