Return-Path: <netdev+bounces-189272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB5AB15DE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3B1C2691B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65928293461;
	Fri,  9 May 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovK10yk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EE2918F1
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798605; cv=none; b=OM7SrLZvb8OsRCuQ2H0jcIG63PYA5kUXB3QyptSuoLApIRWkOv+TYBYYCjekl2m2HHvkRxc7JCsL8a20ykOGHKASp0FPBOlgJQDhB7p7ljKLVKihlU+b6krGJue6utylszwR5RfIb+cb/CfaYitvoSyHQQQLB2ZMFbq+w9d4bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798605; c=relaxed/simple;
	bh=aESLthb8Z+2pWZxn+QFXNcYBqV9e9s72Xbp8BF3F5X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgyjTU21GVglumX/PwSM59N+meIKDn9LFWS1sEJWYeNbgLQd4iD+jDufvVC07fvMS+8E3nhoA7fJ++DHsR62Ffvmm4resW4XKc+yDquw/c6SQl6vZPwftwRn+totUXRL+4Vzpl+nG96uMcPXVMJMdl8CPdzFg+TXcgeCKMCtGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovK10yk+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e42641d7cso230085ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746798603; x=1747403403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aESLthb8Z+2pWZxn+QFXNcYBqV9e9s72Xbp8BF3F5X4=;
        b=ovK10yk+YW29WDmxhpGY0GgIfXCqBFgSxfTtlo64xQFzD5xpw+vnKvIHMylTPJyeDb
         eEZPsfXl6/FEJ74yFwacwiHocnZU+0fT8ZvrAix634HQ1Zj4yNfvcMB0N9JxlspXv4AQ
         pcaSJKXcBRDEtXIIuJL0g83fmnp6PFR/+d+HErq55gLNvSPVXmjz+LayDpIEGC2sHfsC
         oerfsPIMUuQgrAmupLj+O70tmqTgU557bemKhWSsxzZY29mjKjco7FKCWUHibsatg/5F
         jD2fT8cYjg0w8SpldAvlFcZTMO6cw14S3xPDqv6fp1vgLC6XfBrE4hUOyLSmDWel9hHr
         OkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746798603; x=1747403403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aESLthb8Z+2pWZxn+QFXNcYBqV9e9s72Xbp8BF3F5X4=;
        b=FF0lMRLh6tF6omkEy/vCK1sYTjFxSqCrY0L4lFslvuKb1+rUvns7cwJgLM2amWYGJ7
         8Ev6OCctFM66R+gSp9PlOGDDbk4ZUpapsVjSqpx6QTI3wPn66Y7gLiZxov2cVIb5SHBx
         nkbJo4shcgj+UYaiyr+BZEFQY4Y1rBv3e82lGG4IMEJjvXQI2qqrYHmgsHOOOFT6sz8r
         z/rBgdLVQLPDO1cjnminrOs7SkPHxc1e6cnJeBoOHAF73lVkpwIaHjlO3fz2kT1bGmDP
         VuR4PfUEkRlezuLEPKBaKVaqDduQ6WHEpfSIDn26oGX/aMqTSE/e7ney5lj2TIi3o3xL
         G3sg==
X-Forwarded-Encrypted: i=1; AJvYcCWVIS6c4V4xGsYT6jD23DkjZstYrcuyj7pzm7SQWBueG3DkyvnCeFi/YMmSOKQBRuvtpckq50o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCi/fzjbe+v+BkxmchjIR+MuQOY0uON25o9KSNxxLg2J6Et6vt
	zk1BubgB2dcVxNe1uzlUsMOLAOSno7420a2Z0KvrU6gmjLbWkCRbzcTohl7pM12WlmjltJF15PY
	JYufxnChVF1quibp6yE/+knpNIoK7V6n8SxB/
X-Gm-Gg: ASbGncuam/2Mg1RS/BFXxvQpCYmH0GfGqSTM+VAubEEL4r4uqzrzcbrn3k+sMKtGhzU
	+Ol8JCxfgQiD5s3uiAxXHPbUZwPpOzNwkBSF0hTAZTxOskw4Ck8MnGOkGcOab1RhCpGBhQ4+Vst
	Wg5sKw4ELj15H87++3CsW2MEAX0VyPngZYdQ==
X-Google-Smtp-Source: AGHT+IEfTvbeddSsGXQw0Adqt7tCr2STU9I+nNXp33bwH0L+hwSuMu3Ap+LkCEkaM7YVgRnUCqsQFmKiEpSpdE4GbZU=
X-Received: by 2002:a17:903:3bc6:b0:216:4d90:47af with SMTP id
 d9443c01a7336-22fcfa7aba6mr2053135ad.29.1746798602848; Fri, 09 May 2025
 06:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-19-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-19-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 06:49:49 -0700
X-Gm-Features: ATxdqUHck40zobds03ZWqEtBJr9EV4DbGl61dJI1iqWRJx4DXr7sKcZTfrJfI7E
Message-ID: <CAHS8izO_xRpQ5=t4XRO9BvzkwQBhavL02t9+YHXAxxery8_sKQ@mail.gmail.com>
Subject: Re: [RFC 18/19] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:51=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
>
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

