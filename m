Return-Path: <netdev+bounces-191023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BEAB9B3D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686A1A0524F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEE123BCEE;
	Fri, 16 May 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZSmzL5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370C23AE87
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395562; cv=none; b=Te6ywDNiBXolhS2J0zDWBv258Eug6ZSxmLX+GDRIpKSCE12lSe+rhCwCmEOCpxU/MAlasPVRfnObsrC6p0z2uMuyJ1azFE2fMUUwjz/kRJg4X2/U+u7tPZuptiynkOG4Yfjfa9GTtLLJnFRJgfzizNK/AArKsawE/R5MUDtHJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395562; c=relaxed/simple;
	bh=cIjuSZ1+ekTOI2uZ7Dd2nPT7ASNNWPFnUOJTz2LIQr4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=n7ToOy3aLEHV6GgUcV4XNon9G9i9OQP/GIhGDvppG9Y5Cmf2SfXoq0Rz/efEfkT+Vt+CBqzsDMYNmxRLWAQXByiVnLIqY2snh5A6XrBGn8NwQdmb2BntnLCIAHHkDNIE2CigvY8lKiAqZHj3+Meh91DblwAeANI7qJR1a2jH7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZSmzL5Y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442ea95f738so14989675e9.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395559; x=1748000359; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIjuSZ1+ekTOI2uZ7Dd2nPT7ASNNWPFnUOJTz2LIQr4=;
        b=AZSmzL5YUodwq57ppxPvXue07xPt2l4+k4N/tyV/f/1sGRWoncjbS/h2gqqFDxbtzX
         PCCtHLWkeNz4FX4odX1RAu8/PxcLso2yfGFVWfiXPMz94NZAtNsZYW1UiTgGNl6LvqCb
         Sl+1LHKWF3yWHNRpBNCCSWuJypP//gdN3t2Ji5An8BFbhU+NRB5XSKL5b3M+CctkUA0o
         THBqzWUwa/hWRe2szyU64S3l2yzgEQaKDBZH8HRvFkfVsRGTUs2vULFQFqcy7C72Cp8a
         IdBOE55rwRsUjG+JVRWw7Ik2/7kAo22gl3n0tl+FEJGcRmDIMIxfRFAn1yBL83TvNNfs
         EFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395559; x=1748000359;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIjuSZ1+ekTOI2uZ7Dd2nPT7ASNNWPFnUOJTz2LIQr4=;
        b=a2SM9YvJHqA4RoipzRJgbKxz2ftB8WBmrXoVQllEB7+6oSghwV5IDUS9cJDANu23kC
         D7sLU4iYf+H0rvJHr+wRlxzBnczB3g+FbedwVLQK5UnsxiPKwVbFwaKirna0fsI2eQt2
         hbiecR/I+Tx1MlO/ICsOFe9N3lY1weh1Ki14LdZam/wJTy6w16mBWrb0lAd1nYslUjy8
         mtF0Ee6aGPDht3kw7PdLCHTigOhsvTX1cqPWD+jxHoPG47QMbNw5sCnoHjXJKyC1FIRD
         9vr+tGHVsVybjlebc7LaWNJs71L4bxNEYN0h+alkoZ3H3/x0NxFwB5HDZkHSRNS4cJ6q
         PT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLoe4WpSuk9Lvi1Y0BwBvRXSIdkHcg5RnsGasxNiqSLt+WCds9sFRDqSRBRlwbeyMSyGzxl4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjtzz7hPx1J2MpSy3Sx/nMf1Wz/OTlhdpIB0+dIGr8VZWiTb81
	kZWLxbp73+W6Jki+WafDHcmx38BhnffFXDtCKqDz2+cG7BP5pwh2nmh2
X-Gm-Gg: ASbGncudwgkTCjd7MmMbFG0xAjMA1qzpMni4AlK47TBUZ88s6NysOIQXFoue8KZimTD
	AlNlgAI5JMdHLEqsCz6ipLaVxOfccUcb2b1Whw2qWUaSAARhHAlAVUwdin6TSw4Biy5PjAlIDcN
	rZNJcDIeZNIbTsGkObEwKel39zESgl+Dx4hTbgj41ure7FR/XyF36S82ilNP+pjsmNeimaR+zrM
	bDA97Lg64jlB6oLkBMBATL1RiQcTPHxjFoKShkSpNxyQjnPUrQda3+nesvuJhtjx7LdQludSOO8
	7SLILPo6UcehLWQvD503WbyW8pAImMy4MvjVXLRS+tNqZLODLw4B6Cb02EHMaCZ6
X-Google-Smtp-Source: AGHT+IHHudZnnihCm10fRZYorIjV2thbHFFJy+N+89a7hnu2d7fs4mlKLN6BLYMCMCcOMjJwZbFlAA==
X-Received: by 2002:a05:600c:3114:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-442fd64e335mr32795335e9.17.1747395559039;
        Fri, 16 May 2025 04:39:19 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e84acsm106617245e9.25.2025.05.16.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 7/9] tools: ynl: submsg: reverse parse / error
 reporting
In-Reply-To: <20250515231650.1325372-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:48 -0700")
Date: Fri, 16 May 2025 11:58:41 +0100
Message-ID: <m2ldqwn7oe.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Reverse parsing lets YNL convert bad and missing attr pointers
> from extack into a string like "missing attribute nest1.nest2.attr_name".
> It's a feature that's unique to YNL C AFAIU (even the Python YNL
> can't do nested reverse parsing). Add support for reverse-parsing
> of sub-messages.
>
> To simplify the logic and the code annotate the type policies
> with extra metadata. Mark the selectors and the messages with
> the information we need. We assume that key / selector always
> precedes the sub-message while parsing (and also if there are
> multiple sub-messages like in rt-link they are interleaved
> selector 1 ... submsg 1 ... selector 2 .. submsg 2, not
> selector 1 ... selector 2 ... submsg 1 ... submsg 2).
>
> The rt-link sample in a subsequent changes shows reverse parsing
> of sub-messages in action.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

