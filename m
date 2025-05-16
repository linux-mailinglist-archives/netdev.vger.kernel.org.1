Return-Path: <netdev+bounces-191017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B945CAB9B37
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CF64A1AB2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5F238C12;
	Fri, 16 May 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGU4yKMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF671FF1BF
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395553; cv=none; b=P83ecgQPFtU0faxFhvNOa1mKpdhCHBPJAPmxDonOKj2gmcBqoRJgjafCEaVfRhD7BEM2lOlTphrbMEoRESHClpITbr/TmCn4FO4Xzfne95xloH6ArOY1Qnw+eOZCWV8RtABozQnhK/yjwERe7lgnA+wTnMbwiw2nKZrrjv//1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395553; c=relaxed/simple;
	bh=ngt6dCGkSlpixPgyNEiL8P+7NiJuRHbjqllQWqHXk3U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RxwR1L/TgKBGJMjuVhN9cIk9GAZupUbm3GZQUhgPz4yLxJIPNHrGkueKbPep3HlBu016Oit/uzgoPRhXPoz3FH+47lhDaWrHJHa5hz6SojmgxfsIc9fbw+YZ033Tgs1lfXh3NEBVO7nOElZUmi22fHDK47z3AJEnHkhAIj1WO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGU4yKMB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso18811435e9.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395550; x=1748000350; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngt6dCGkSlpixPgyNEiL8P+7NiJuRHbjqllQWqHXk3U=;
        b=nGU4yKMBaQlSXaXWKSLr1FmY5eTRMFpRzyr7nqvHZlo2zR+w/NGKPJjtzD7+meX/zL
         JiJBeG8IDher9fgKQRlwNvwDdt1YP5yYVE8YA3LXzyJ3zn2E4xY3ZojHqRSB/reRkS6u
         pH7s18VSR5xC4LNr62sEz5ZpuLWT1+oxO/j9MsVAaH3K2eVacDIuUFW81aYdHFvRwLSg
         9lvvVJ0sfYpUGLfF59HYDdKywVy1llYJq2HdVOktQ/vRD/Er0Skc9eTwa1Dg5vC7DUkF
         lkADViHnne+c4neWISRmIGexfH0Slun3h/YDTnKYx7RDmDTycu3QdZ3bUr/qyUsx4uZ2
         zBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395550; x=1748000350;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngt6dCGkSlpixPgyNEiL8P+7NiJuRHbjqllQWqHXk3U=;
        b=BmQtFoB/7CjAd/2wSIbKqUnnbsRTbK020E6cso8hFbEf0NyYlE4j234Oj7JNiPFT/T
         j2T/QxW01MKnO+yfkVCHBUJOlWZCTOjhKkaCzP0Wkb6y2cgPb/qxl3+t3gSlogW97Arq
         wpqN+XNlDxswZ+fNIliaVbuGgAZiv+GGkXyXPRMzSLFT875MCPNd9NRW4jHB2GR5Xbv8
         MGXU5hxiFqGl+HwWjzgghhSL3MgjMuO1mYzqu7/yHIM2cX2W+O+3M/cJhBPAazjFir9y
         mfTEsfgKOP92wBp0GNs6wWCfC1Vf8Yr6PPugqFptKRs952NRRMrk3/Y1LUDzESOyuaE5
         AE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP4L4PqNTAIAGhL8psMVezPItGrJ3IEoOnpYAsOgjDrnxP2ng3PSVGq5VWjZpPNG+p5bvin4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRrec1oHvSb/+AvBjS8jqhOMyu7EGUGC4YPAqbDN3y7MGIep5
	enl/ODuybz8CstlEarzkmaverDLj45P91Jfz1QjtNiInhIfijO4pbY+1
X-Gm-Gg: ASbGncs2VTPlKggZtZDA2hlK1CqORc4Rmjvy3juB4sj65XzEutSI3ZhS+XM8lnZ281+
	UYNUmHS3ap/J/IdhW7tIILN6/N6HSb+AwMP6Tw3OoNj7NQ12zJwyCN1qKB2wxuN0RJR0rsPYkFl
	xtIBQsR6qH2E6LwcLaE/7ff7sVgXhKbjQqGWpqXNJouoUfUC2xUQ0/JQFJLAlatp6sN86WoKHbv
	ysh5UhhLCQ7eL/wA1uBEvuV4/wmpxGAvVYP/nGZP8rOevTe7p8LrjBz53P0gowjHUky2Efb0GOk
	Ky6LbtGERW4xFzbtMVtSGFsL1LQ+8LM27XXU5EeJRVAbOYWy8kL+o+B4LU1bxxTy
X-Google-Smtp-Source: AGHT+IHnX0389L7AV+Fzm5ZoOlaD1WkchO/HcwmMd7A/IAY0q8rI/nYSL1Z3ek0FGM/g+6GXtAJUoA==
X-Received: by 2002:a05:600c:3d0c:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-44300486a13mr16643605e9.16.1747395549855;
        Fri, 16 May 2025 04:39:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3380498sm106878545e9.11.2025.05.16.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 1/9] netlink: specs: rt-link: add C naming info
 for ovpn
In-Reply-To: <20250515231650.1325372-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:42 -0700")
Date: Fri, 16 May 2025 10:08:18 +0100
Message-ID: <m2bjrsorct.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> C naming info for OVPN which was added since I adjusted
> the existing attrs. Also add missing reference to a header needed
> for a bridge struct.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

