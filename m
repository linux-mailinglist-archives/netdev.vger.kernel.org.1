Return-Path: <netdev+bounces-173989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0585A5CCDC
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E639189DFE1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EF221DAB;
	Tue, 11 Mar 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItqY+H4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A11C3C07
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715709; cv=none; b=LRd4ZBmGydS2niP+KmV9Brg2V7dVHaOKEHlX6QS+V50G++FgojleV75l9/0BQhj6lkDP1WYNQIRqVkICVaDwjIEblJRT8lzFldA0QW5QKKrQgdOCEA19PEuR9NcJlyTRasd3gp1s9i6FCYUW3q4qGzGudEDxywOhBTIRwI8uswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715709; c=relaxed/simple;
	bh=hEXLh46BYRw0lHzBYVFTBCaxb/vhdVOLpv2q6rV+EgE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XGuN9z6ir08g1JnVuhTeJKiCL2ulX601ju2IGGDzZg2C49PeySvTRlUk3tXFdgAAcMrtQICnRGa3Akfke3Fsjq+Ec3KUZebAdjPRecpk/ndyODc1rvlGsgMLU2LDnlwE8D9FgTboeq10iXmVfVk03u8ZNijUZnB8WaZy2M5/e1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItqY+H4V; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08b14baa9so531901485a.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715707; x=1742320507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsactOZoCaj5pXhtF+fVXuVEuJMzuGe7ZOvBIniq9lU=;
        b=ItqY+H4V7lM+M7evrxMsUcggVR7aold4dYpZQyxyfbIs7esRag0uw+QbwrQv3XDpr9
         GEpTB3M1yeArKO7IY3lG5NsQQt3QLbq4FpLwK12wW1OiBGOAHObHpTyMrrgwy992BP6i
         UMhI6SvMP0NrtD68FWB+QeUhfa4yxjbMgAkgLBV0m1Graq6Kb2P0/7vODW2XxrYSscBy
         kcTkcyIgoWBacwiWgqTttiU0ygnbutfgwAH4LxMi3RjWuVxRRfrXfSMxMGFrMBThigHl
         tPqS3QD7NLc2rJbt8reCG7yIoc9gZ8BRckFXTK8xcejPDQWsEBsqYCrVi9JE9JH6MurJ
         jMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715707; x=1742320507;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsactOZoCaj5pXhtF+fVXuVEuJMzuGe7ZOvBIniq9lU=;
        b=MNGAkMImXAamVasNGyNSPXV1LtxPrvu0JeUBIJOO59nLB6jAKnOnPusRTaJQqK8c7m
         qH6RPgD/Aw4rIytpqimZ5R8lRWKgdVul3xZokcpYhrFZZ58bZwoKn4rhD9u27UwsIngH
         ZK2JKwHwEqEaEMIN0m44EdqPy6bEhIfyEMOpjcmVSacGU77N4KLtzxvNTcdOLUve/fGp
         J+wX/DpbTAmWfVOMVDvY/sTD6oQJ54oRAwKqpL/vRpHdtpt3/8SoXUEVlS0gomnZ7p0S
         ddTSFuFYs+OUuRhiaYDBYaxSsIWyWOkaKf0Sx3O1L/fbykh0F2kUKIMhdHYaRCi32c94
         DZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0ctPcOlNmczv/dvy8kSPDvo4Bm6JXa3CMJ2i6C0MK+YdwpDulr8STQ9sKGNvmCmZcKsyivBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+rEVB2AF4cC0u/Fpz4gPY97Gt7UCzrdBpTceImwPAGMuin+F
	E90Mch+ZLC+yXSqPx9kkdsffGhjf9k0XdjHrsHUeSf4zmx5Oe/Yp
X-Gm-Gg: ASbGncvUi42KOed7KUSxKY5rt6E5rcT5hGL2YtkpCKl2Md0EkUb+eiZ9q3G0IFgSkkU
	Udz12G+8MsorVYLYF5nqBcFNe7G/abkeeW1D8D0OxIKlrgN6R3vvZGZGl77Dj4Rw6cFzsiBE3yF
	fZaZ2JRmFLguQ+23e5sz+LR/mfuNJojDhGJ8wt+2E5lYMxKYRe+/3QnVsncVxfDd8EeI8Ta8liQ
	XXyGa2yFUzLL6EYzwxiHzhWXuDlQJ05f+0rONwGhMSX1VvYlsQYtF5P+iFWbcLV1t6ifL+OaFCQ
	kbabRiE8yDHPsOAwCgynYcynfI9SviV1UbU2AQMbPNctS+UKUNgcH0R3bqY9J9s0og3kgR14zeC
	8yYRSs+vb4XHKVY0krd38gA==
X-Google-Smtp-Source: AGHT+IEu1a3L+eIW2V6dbi1GFJKWblZQNT1FXX6UGkAJfSE3JDcQ7enYUJuIxNw/3ulowYH3PMY/EQ==
X-Received: by 2002:ad4:5d49:0:b0:6e8:fbb7:6760 with SMTP id 6a1803df08f44-6e900604389mr269497186d6.1.1741715707247;
        Tue, 11 Mar 2025 10:55:07 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090c41sm74428716d6.43.2025.03.11.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:55:06 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:55:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67d078fa5b11e_2fc2f8294ed@willemb.c.googlers.com.notmuch>
In-Reply-To: <44a45278-8ebf-4d79-b64d-f1ad557c8948@redhat.com>
References: <cover.1741632298.git.pabeni@redhat.com>
 <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
 <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
 <7a4c78fa-1eeb-4fa9-9360-269821ff5fdb@redhat.com>
 <67d0730b8bee7_2fa72c29418@willemb.c.googlers.com.notmuch>
 <44a45278-8ebf-4d79-b64d-f1ad557c8948@redhat.com>
Subject: Re: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 3/11/25 6:29 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> On 3/11/25 3:32 AM, Willem de Bruijn wrote:
> >>> What about packets with a non-local daddr (e.g., forwarding)?
> >>
> >> I'm unsure if I understand the question. Such incoming packets at the
> >> GRO stage will match the given tunnel socket, either by full socket
> >> lookup or by dport only selection.
> >>
> >> If the GSO packet will be forwarded, it will segmented an xmit time.
> >>
> >> Possibly you mean something entirely different?!?
> > 
> > Thanks, no that is exactly what I meant:
> > 
> > Is a false positive possible? So answer is yes.
> > 
> > Is it safe. So, yes again, as further down the stack it just handles
> > the GSO packet correctly.
> > 
> > Would you mind adding that to commit message explicitly, since you're
> > respinning anyway?
> 
> I was confused because this patch does not change the current behaviour.

Oh right, this is also true of the existing __udp6_lib_lookup path.
 
> I'll add a note in v4.

Thanks



