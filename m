Return-Path: <netdev+bounces-114960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21580944CE9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD521F21EE8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687AC1A0AFF;
	Thu,  1 Aug 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Y1gl4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1E158A2C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517998; cv=none; b=qCeqx9ZhrVBTmOXGc8KqHlKeE9CAeQeGlM9uBwAL9/NHRu+ubq9FxgmaNNFpF+XJo7QI5B2iT7q6EhITnwli/k1jRH0HxFC4VU+n9mMIE4KYji/HkYrBqEMdL3lG/6Py5n/1QlJDK43qGh7Etx1uUuor2WnIPZX6hPj48e5N584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517998; c=relaxed/simple;
	bh=uCgX81GwQgSgSL4jzGm2Ij55tggTpuvOylZ4YghZjT4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hHxIIqL024l3+wvejsqes0jgOZiNh5q4IWCiCLKNYyiP2LuQHH9zudRM01N+wG0Rtk/Xa90wKSDbtXahI9CqzTpbyNXwXC8JGu+ztgoz1ZGxChlfj9Lm4IhTDUba6OxfuaVkVxluqRuP+iVDFLlNL4eRu7+itlXKdamQAcztDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3Y1gl4L; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d984ed52so408523985a.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517996; x=1723122796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+49jp0NmXOMR3gBx0/8WV7zzJpfYqj5eocNt9Fspqg=;
        b=Z3Y1gl4LAMkQH0H2JVsDONoxhgMCUAqC5F1Zzg4bBBAiShPm/DSnhpG5TbZaNebGui
         tBhU0SMKtCNy/XZR/E/HELEfBH3lHQhnY4DMG/eFf25K+WL8WJzKlyHzrRVaxUh2jdsh
         rVkHKwB5Quxl82FECE2QRDoLOFyBBQLmy7NG5Zq2t4jX39J63KAFJSHVCuLNDpzQjoL9
         0UyLoKXClZZ/uyZ4R3UhtAZUK91BXJypncUGOffh7qkbbiMOqsIGntvVLQHNuuwRyQYb
         xjiXrZbjRTkv94e1TNAu10KGfwJ5Ir+KTOGM3OnPSsvMmEwkhtlLIR0qWpvUnd6DK1nt
         jzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517996; x=1723122796;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+49jp0NmXOMR3gBx0/8WV7zzJpfYqj5eocNt9Fspqg=;
        b=QD4rRojq5XqoUsJZh9vzvFs+fu2yD23/wtOG7L1tS+A7FJTOIV2ff9lpQJFaqs/383
         7MaE5+9YZBpVlL54GP+AiFz3DN829TTRY9pIYLv+Xs+EW2YucSydh+NKkd3F4hLYj6qd
         GoOCx5gT27mhUusimmHPzt7cIg0MtLtaCm3XrPccJvr+uEzf5gvvLCFRAHQ176D60CGs
         GuY+unq1Tog5dpBvXLd9TBqWlLdeNChTkRQOGq8TBoFt32BhggWrZii5McYiS3dLhV/O
         MmBuDBg6bXCqvPNhAlPqVw+5n+IP/ik6ST4oUNZfuTV2b4n+esjtnnBASoNWYMNVNo7J
         Mkaw==
X-Forwarded-Encrypted: i=1; AJvYcCXa1ESsE1OYVdq4hJTi8m3kLZa7l+k+27wrGsk+8e9rLIgXqqErJV50litVu2d6dQXI1I0HMecX75umLRkWLBRKQLS7nS52
X-Gm-Message-State: AOJu0Yy7v0YDay9i+Tj0763D6UwOz/qeJQJqo89OvEux8Wnzt5qbgjza
	Eonqrp4AGNdmZZntVZRjqCMVKhNtCpqKtJLdH7Sd6iCmj8M64Xgu
X-Google-Smtp-Source: AGHT+IFTZrVHd+7eEeZFcm+VV3M80m+yUxUpmMPhbUvRnx+VY0ST80ft67mQWMWcZ7JAwtAwbNoCKg==
X-Received: by 2002:a05:620a:c4a:b0:7a3:4946:ce58 with SMTP id af79cd13be357-7a34946cfe1mr196098385a.69.1722517995499;
        Thu, 01 Aug 2024 06:13:15 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1e845f7bfsm626992085a.115.2024.08.01.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:13:14 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:13:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab89ea3de76_2441da29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-4-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-4-tom@herbertland.com>
Subject: Re: [PATCH 03/12] flow_dissector: Move ETH_P_TEB out of GRE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> If the GRE protocol is ETH_P_TEB then just process that as any
> another EtherType since it's now supported in the main loop
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Might make sense to squash with previous. To make it clear that the
previous is not new code, but a (cleanup and) move.

