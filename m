Return-Path: <netdev+bounces-72546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF585880B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D035FB274CC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7194145345;
	Fri, 16 Feb 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IE/wX3pE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0C12FF9B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118649; cv=none; b=Nv0sVhJiFZcmZX2918KPdcsAgI4OeZs7+PUaFzqcWCBJ3gBHN6AXXd5RDRUPc0YLk1g3dSm/+Y2+F3BchXGe8T7g0VKyArJekUBPodVHDO6skd9oPZ5zIrcgfaPzqxRrENaeuKSzWFAZ9LdBqn1tEqwDDdyt+1epgbYzPAQ/j2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118649; c=relaxed/simple;
	bh=yRurr6ML5my94Dnd4u7LtKpxo/x71aqlWH801mpbrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDZC+eBa1l1C13YhAnxdusxzJmO9pA6I54jSeZSybLqyoQMMxNoT9ETE+RmtxTQ/SAQzsAaDAg/RQfNLKQZ7+evLH9CUY1T/+VYcuQv/aSyAshpIBM4UaNhLoW1S0jWKbVWshcY5A8wGBpZD+NYF8/xuDu+x5DK8pyXlbHq/UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IE/wX3pE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so988727a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708118648; x=1708723448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1VzBaRjpVm2EeH9yEls9HP/gc/d5h0w1w0aikTVjxk=;
        b=IE/wX3pERmofrRXbJhztc9ipPiNhomXUEPmrRWsOQyb0VhIZA1PiQpcB+hXoDxmR/K
         znCSIGe5TBMtzWF8NA6/1SIbG43sVeWSRiwfTe+Nh+ri1YAaOmbwvz6g4NjaexY1l4yw
         U9g45GZjZEEimztrYyuBAbhVKl+Qd8oa83lqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118648; x=1708723448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1VzBaRjpVm2EeH9yEls9HP/gc/d5h0w1w0aikTVjxk=;
        b=BsKotaYgREARtM0jB78yhhgRmWdQ9kmxqp/b8mOHqzJS/1sHoHP4xbVR83cuCaaQ4c
         HfQdWTFiBPeGoPmmY1YCjy6mQEMhxp70MRLgvKISAfH3kD50ZyXJDoE0ygauaIlF0tWa
         eR/CsciS5iefP0K68enu5CDDxvoUUN08ejuVnnz9JcX9hCxT8wBbBGnBni0+TkrroUx7
         +Wcu5SxNX+PIc3PhgDp2DD7iZk/wIbYpCZv6d5yoURpQ0cQ6gVhaQ4Ctrp61dxcw1Q9A
         HyBn2q7nYSJNKNNviXgTIlG/BNsvQP/awLghaW8/ZccPFe/pDLkxDPSspLvvwqskSoj3
         n4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcuDgvIUbHUDhuyRkqEhymCiNa/wwVaBF+JjTOdWfvaFVPagUcfckreN1/IKVARdGPiiVkW4zQW8WMXMWu+Hog/G2yWhIO
X-Gm-Message-State: AOJu0YzH+M3uDFi/NkWqUk9wP46qupm89hTy0Aj+9aGWe1NoLmEoy0ji
	s5B2UDJlyx2fHYrFqFd80icvxLxFmSCgCNlYgALQ0fACXBLjPpsRBDMAOYLGiA==
X-Google-Smtp-Source: AGHT+IEgMy7RTzlVQNWimMaIo+ptqO8KQitq3MmUZTdXY+kjpPmq2SiCR+FO7RZ9XdiAB9UrspCZiA==
X-Received: by 2002:a17:90b:1091:b0:299:2951:e2fc with SMTP id gj17-20020a17090b109100b002992951e2fcmr4117500pjb.41.1708118647835;
        Fri, 16 Feb 2024 13:24:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pm15-20020a17090b3c4f00b00298d8804ba8sm453213pjb.46.2024.02.16.13.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:24:07 -0800 (PST)
Date: Fri, 16 Feb 2024 13:24:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC 1/7] selftests: kselftest_harness: generate test name once
Message-ID: <202402161323.8F286606@keescook>
References: <20240216004122.2004689-1-kuba@kernel.org>
 <20240216004122.2004689-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216004122.2004689-2-kuba@kernel.org>

On Thu, Feb 15, 2024 at 04:41:16PM -0800, Jakub Kicinski wrote:
> Since we added variant support generating full test case
> name takes 4 string arguments. We're about to need it
> in another two places. Stop the duplication and print
> once into a temporary buffer.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Clean refactoring -- makes this much more readable.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

