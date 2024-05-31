Return-Path: <netdev+bounces-99752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F0D8D634C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB561F212BB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E9158DC1;
	Fri, 31 May 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUaztC7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F8158DB2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163032; cv=none; b=mMN3nZ+TqpWmK23pzLdxTGIN6E9bkmMCOvG0weAvHgznRLqD0dzxkROS9ORvgbDTMakxy3oQ7C6u8z34T8E0wVRE4GTyHJSuI/UW2JUCAUcMzl0cewswRbX7g5Oz1pzhTRt21SwFcfxtr21vnpA/k3GARQIeZ3ZEmFEl4MguaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163032; c=relaxed/simple;
	bh=/bddIuF6XoTcczOJqWwnTTDf1IpA0CXgyohBgmUbKnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nkxAkvm9z+ZcTMdl7umxRy9v+3ewBK0zumaTadyMYMdA+dqKL/hmtaQEASS7juNg9EDQUump7heU7/YYaWtNV5QAVxV4V68QLNoVv9iXdpyshSc+hGIBZIEU4An8v4YRW6zunLXg6pr4bBowAhuFsiNcP2XLLfnZDMH6aILYD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUaztC7i; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43fbbd1eb0cso11777511cf.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717163030; x=1717767830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++HQe9DF0dzDTm0DUgQT33Y3vbSFzFmHb6HPI9lRY+k=;
        b=iUaztC7igT1yCmqsiA5Ss17sFw6C11oZeoehAGINpTx7NSO9Xjdz0i19DOdw9SnUhf
         LZut2ebhkH1KbXth9Ifk8Py8Vgh66phP+gW+CJOmBw4nSBgjYzgFUMqjdB0mmeOQ1sw6
         IXPhvQiEJq6J9YQ1ptiJnsORy3TxcT7B4AtMxqar/rtQl3xhoSuq2nXZ8koBm0+hVziY
         RLaPUjfBgE2kMQeMMNtVUtsJ6qNMUr3pgBQUyvYCIG0svIlgFGErpJDgJiM2EWt7AeXq
         Yi8o+yxtqwX+W+BYZucvh5O/z0KdvnTqLG+mORU0M83xymnrxYSRF6g5JQRyfoPED0Yk
         5dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163030; x=1717767830;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++HQe9DF0dzDTm0DUgQT33Y3vbSFzFmHb6HPI9lRY+k=;
        b=LXzmfeRF/qp7vVMHj2NEqs1kfkNRlvBP1Gz/e2nCG/LzUkmunOhRPnSBSIPZQSXrTj
         Bka1ihsQl64to1zQpAaxzZWmyw2PMLyqnzmqLnwFx8sq77KOHSWRfdgGlI0xc7De24fN
         1Xjdvx3D6ZlJIybQillfJlUI9ZXCc+JocOxc27PU2sGngCLoU5ExR5WYN7SWd7qZAUPd
         /wIZNOlgLskWj5xOoHdwZaU1ZsTAUIKynWPzzvWfZUXsPHYPS0x/LWfvNPiVSw9f5VqC
         yB+hl74WA8UTmIQKwPqJvQZZlpwix1CsXKUurrj+t0SfHOkFVqMKzzaYDzzSjYDSNy2D
         CuIg==
X-Forwarded-Encrypted: i=1; AJvYcCVn+pAA1YrIiwSzgpQw0pdRONgUEs7SCh7EDli39MzOiqNZ+abQ2fnDtARtyhtBTzOQiuw3uvfX5gEPomAqUvNgwLxF+JGY
X-Gm-Message-State: AOJu0Yy3mapfS1VZb6sjqWxoDxWr+81EbbSN4qHhfQ+MInoTmz0+j7J5
	3HDiZPEcMleSIWqKtkucCI+81E5n/XMEXrzwPUwJwjIQPx8zOn/R
X-Google-Smtp-Source: AGHT+IEn0j6XjJhsnpuMRXWGeWlPQLAmZveIxjzC6yBrb4GJQ/9DPHKc7FRHk+nJWezesgs9TYlwXQ==
X-Received: by 2002:a05:6214:3ca1:b0:6af:4c7:2c04 with SMTP id 6a1803df08f44-6af04c72c88mr858776d6.55.1717163030422;
        Fri, 31 May 2024 06:43:50 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a7462f1sm6506796d6.33.2024.05.31.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:43:50 -0700 (PDT)
Date: Fri, 31 May 2024 09:43:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d415c8aa3_3f8cab2944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-2-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] tcp: wrap mptcp and decrypted checks into
 tcp_skb_can_collapse_rx()
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
> tcp_skb_can_collapse() checks for conditions which don't make
> sense on input. Because of this we ended up sprinkling a few
> pairs of mptcp_skb_can_collapse() and skb_cmp_decrypted() calls
> on the input path. Group them in a new helper. This should make
> it less likely that someone will check mptcp and not decrypted
> or vice versa when adding new code.
> 
> This implicitly adds a decrypted check early in tcp_collapse().
> AFAIU this will very slightly increase our ability to collapse
> packets under memory pressure, not a real bug.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

