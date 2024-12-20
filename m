Return-Path: <netdev+bounces-153847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27B09F9D49
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD42C188BFFD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A621E08B;
	Fri, 20 Dec 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="HD5GE55A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542661A3BAD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738734; cv=none; b=eNMurS/DWv+QvHTKYLPF2aZsjFo2OShtlKY2V0Si0+AFo9pJfUkZID7+bQWcgFvMcs+bukkvoya/WQmcA2qwsCpJIZ1CFpxrPZj61/WwuaghV0V3qC4GGBYLO6MCAqq8ZRIFC8HLuHL7ZiRgNjJn5bMsjNFaw2Rv3VONCxEwltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738734; c=relaxed/simple;
	bh=ocSwRrEewH8Adfk/sPj+qADI82/ipq2sXjmivI+Q8ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwfPZFA54VW/JOJX1vvXKTCiRiy/+/B9Z5ntf/3gSpBCPqm7NCt5FqsncYyvcV0FiwXEYeF9pl0++bMzGhxz+QVPtfQEKN0qfwjJDhFj/pkZ4yF+EfSK9DxoxOlAb4nd0P3e1bRDaA5zSAzztU0Ln1F3NWBKsIuTo+mJmD5ukHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=HD5GE55A; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ocSwRrEewH8Adfk/sPj+qADI82/ipq2sXjmivI+Q8ig=; t=1734738733; x=1735602733; 
	b=HD5GE55AXsgwEldw9JaPCo0lf5UaK4c+iMPijhfRO9thGHxjU8kqt/MLg1b5QjuNoM8WI0wkdnK
	o0VNsy9Og821EugSK2H0aYFat0skBiubfL5ZHumdKyLc3ph0ujTPH/fbM6VR/08NjkrN+Jro5nUcM
	2hzdkXRY/DvmPr0lBZgxOkSqhRL7hyx4CM3dOEH7sNOoE9U8RLIELA2lD8aKACUah9F0NpTYcLdaK
	cxRs8wL0h+EVlJCylGFLpfwp9IjMn6v/CQXksYxA8BgxprQe7wYNAW97XmDsybvow7Rqh6vm7Eu79
	RNpjsjtQ5KD88xs5Ausxm2qlsqxexRGBqfSQ==;
Received: from mail-oa1-f43.google.com ([209.85.160.43]:58635)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOmmx-0008A6-Ta
	for netdev@vger.kernel.org; Fri, 20 Dec 2024 15:52:12 -0800
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29fad34bb62so1155166fac.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 15:52:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5Ze1aKP732g9GMJOp1JZTxx3lrffTjeCcXeJzq4gGocjgK2CLCWabcUTJkUcCJpYhACgjt3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSs0C+kaTX5Db45T4/P1JlBccOvgwHtEwpHbihVNkb0XDf6Fc
	3nj1nuewof7wQfkAz1DpnE51xeOrfPjvmtOz1XVdrgmTfM6ho8TuJ6R9gRd9+XBglDR3VPU09Gd
	7i+GVwKB3xQhlwcdsTv14gWuQ104=
X-Google-Smtp-Source: AGHT+IHPFCkz9iH3n1oJzmgZXGywJTkkkg0pIUygRp+h9hJBHaF8bVN9DT1S8rM2/rKEbPcz/Dgzotuj8yOL2cUgDs0=
X-Received: by 2002:a05:6871:a585:b0:2a3:d9b3:3d02 with SMTP id
 586e51a60fabf-2a7fb566179mr2530213fac.40.1734738731378; Fri, 20 Dec 2024
 15:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org> <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org> <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
 <20241220113150.26fc7b8f@kernel.org> <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
 <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
In-Reply-To: <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Dec 2024 15:51:36 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxaCcbJy5cygga13WegYTMp-LeD3KCdBYE24Eow=qoZDg@mail.gmail.com>
Message-ID: <CAGXJAmxaCcbJy5cygga13WegYTMp-LeD3KCdBYE24Eow=qoZDg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: 58355bea2820b4cf9b9c8322cdf0b49d

On Fri, Dec 20, 2024 at 3:42=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> I hadn't considered this, but the buffering mechanism prevents the
> same socket from being shared across processes.

It just occurred to me that a Homa socket should be sharable by
multiple processes as long as the buffer region is also shared at the
same virtual address in each process.

-John-

