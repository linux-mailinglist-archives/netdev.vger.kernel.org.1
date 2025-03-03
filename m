Return-Path: <netdev+bounces-171254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AAA4C2DF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FF9163A3B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C52135D8;
	Mon,  3 Mar 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEZ0qRPV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B121322F
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010881; cv=none; b=osWyt6wUm23fC8Okam6q7veUEfx7meam6XUEyM9x0fJfUihEWNRIrFtxg1kMoNbOGfbSNgh5MZMTh5PQq9OmeXtOUeEgiE2khld1e1R+RYoobyccy+fdI6cehIIpLjQsiQ6GupONkm7Fv7VLMSXusZH1B4khL3DpflHFPKUQ568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010881; c=relaxed/simple;
	bh=fPq/p0wzPYHKK+c+u6jzUUCZheQomQkMOBrxt3YLEuE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sdGw2KP4JWa1CBgWC2x4q04Hw5HKnEKut0T+/+PZumh0BwSsIfpm1xXxPHEQE6uyjx3kepqLR7Z6/hAe7BD/i6Nqj2Bv8rIRKJxO2VMAc4xmjBZxha1fYAHw2d+NIsNyUVO8OMgrcrYo+1dO47iVziWhgCwz16LJtBhg3CqsMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEZ0qRPV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4720cfc35e9so73779161cf.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 06:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010878; x=1741615678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJFhV+rxcW2b50dhJusVSwg9ET5CPxRkZrYhxiFiviY=;
        b=mEZ0qRPVsMKBJqCW2uBU4FpzqqkiD5AqSPXcuJ4WCy3Xh9tJSgfUK9kZ3wrVBzNVow
         CvFQ9yyeHfzfCXy+mKlH8cJ7YpvlUy1XaG29xkzrBph1T7FmAopbubavk9vGRC/ceV/u
         ZIJCGhpnfyssCosP3Kp9Q4DiAX/EDUAZ6NRuIUOdudWJo5kZwxsXjmhpP4SFRwZscdO7
         91ZOozKNQtWD9YhQCrHmhhf3IfsXugELCDn6/XGvsJSb+ZcHc+YgpEO9VVpU9DqbJDzV
         xyx2PZj00Ql7PACPP3Nn/egnA5Tca8Yh5sIP4C4WDfnlvV2OeiFYaUmxgcDbkR5Ckxy9
         9i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010878; x=1741615678;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJFhV+rxcW2b50dhJusVSwg9ET5CPxRkZrYhxiFiviY=;
        b=IEF2HKTy6QzrzR1ZRmhFwJjtoZ3byIBqQrrqE/M6ycMgMNtjmZpFo4ZPrqjFLkvK86
         IivC4TE6Z3D0MmGKk8rt28kC5/1CgBYfAMjBNAYFVLgZ1VUX0lhtnh2c5NRgL2jXHbya
         t9fVxZ7NAbkdtrSY/mKcD8Wz0X24sck7cDio1cciz2Jvy1A6ZLEU0Uvc4cvjxl1nq9ay
         ypBOcNywVj7I8XAUQly1VztENMCfwD6WZ/A8/2GU/+2VmY1m5mXmX/BfM8+SGF5ZE8Fc
         Ef11NAomr9OX1NiyFT23CgPp1+5MDMNVBqYbjEWgJftJF/VamW2UGcPjdT/zBfgX78AX
         cI2A==
X-Gm-Message-State: AOJu0Yw7VhigohuOcCTAeoNkAJUTCE9F0NauY+Ue7fkMju2YKBBubMtS
	aZB4SOAnbaypFwnKYfRloSNAwAA2L/GjDpskxk/h5aOgt/PL9QBs
X-Gm-Gg: ASbGnct6W7KKarexZFg/878Jgp4SsuFNrcMYdpWTYic36KeBtHONShiAMDq3LGFu8uL
	HMKHP/lbO2Mv9qv6/2ZzRsINtmM6OR2pSCQ5UiaTWkLVfiBJzgCK/xUmriWfa86NPQLM5I81fXR
	Evf2aDuIYi28FFDzcJ7x9QsFFG/sXXb/RpiO0zPaTMKKnj+rQG2IJs96rWvu+/aXd+WbjXv9Cnm
	ZvZriXBXKoTkXjCpNmftMPmjiUt8dFgtxHb1+ZJH4wMtM8LKok0C9DB/FvV9d57mBjI4MIpXdx3
	ThInJgfymjcwxNEg9JcRGVl1vsb5WWb0J5gkG8eaNgYxo1GkZMBgujdAh35Bt1EEJWq333DoxEo
	gbf6VsHKpgFdYouPGnZWI7Q==
X-Google-Smtp-Source: AGHT+IEx29o96y7HVgzgClTL687VWHyI2KCdYDIMwgPqCU6uhG+4yhmYIhWxcSSX/pLz38qCZQfxJA==
X-Received: by 2002:ac8:7d0a:0:b0:474:b5c1:f759 with SMTP id d75a77b69052e-474bc0860f2mr221211141cf.20.1741010878368;
        Mon, 03 Mar 2025 06:07:58 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a1f8asm58692971cf.12.2025.03.03.06.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:07:57 -0800 (PST)
Date: Mon, 03 Mar 2025 09:07:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67c5b7bd79f0e_1b83272942@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250303080404.70042-1-kerneljasonxing@gmail.com>
References: <20250303080404.70042-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests: txtimestamp: ignore the old skb from
 ERRQUEUE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> When I was playing with txtimestamp.c to see how kernel behaves,
> I saw the following error outputs if I adjusted the loopback mtu to
> 1500 and then ran './txtimestamp -4 -L 127.0.0.1 -l 30000 -t 100000':
> 
> test SND
>     USR: 1740877371 s 488712 us (seq=0, len=0)
>     SND: 1740877371 s 489519 us (seq=29999, len=1106)  (USR +806 us)
>     USR: 1740877371 s 581251 us (seq=0, len=0)
>     SND: 1740877371 s 581970 us (seq=59999, len=8346)  (USR +719 us)
>     USR: 1740877371 s 673855 us (seq=0, len=0)
>     SND: 1740877371 s 674651 us (seq=89999, len=30000)  (USR +795 us)
>     USR: 1740877371 s 765715 us (seq=0, len=0)
> ERROR: key 89999, expected 119999
> ERROR: -12665 us expected between 0 and 100000
>     SND: 1740877371 s 753050 us (seq=89999, len=1106)  (USR +-12665 us)
>     SND: 1740877371 s 800783 us (seq=119999, len=30000)  (USR +35068 us)
>     USR-SND: count=5, avg=4945 us, min=-12665 us, max=35068 us
> 
> Actually, the kernel behaved correctly after I did the analysis. The
> second skb carrying 1106 payload was generated due to tail loss probe,
> leading to the wrong estimation of tskey in this C program.
> 
> This patch does:
> - Neglect the old tskey skb received from ERRQUEUE.
> - Add a new test to count how many valid skbs received to compare with
> cfg_num_pkts.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

