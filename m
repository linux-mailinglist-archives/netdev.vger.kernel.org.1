Return-Path: <netdev+bounces-193837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4CAC5FE0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9101BA341A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA41DE4C4;
	Wed, 28 May 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWyu1Vbv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4F3F9D2
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401992; cv=none; b=guQUUWreIGjv2uehBceV4fG/7j6GRUom/cLYNyE8cfoRGgUfCTmVjTwPMiYmLGJBhkFXr+nDG90DH1dvcRWGLW9E4s0oXdU2iSh8/dweF996k+QashXxOicfBrCYZ34X0H4UJ7lNT57FEL2Uo87sPIyoMUO0JtAEx/6yAPJIXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401992; c=relaxed/simple;
	bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyZb7WTkzhq4PZQMxPpq8yIgJPo0K4d0SrpG6m3r1rqDnXUp5ONjMiA/AM+gmSyKiLT1OX5M85T8UbTUusTfBLbzzZtaY/jsrPOOLNy++hOzlXtnC/zXhotFqwJrhuX5M46xvc4o/D/LBg8chCIssQyYEG+yTVyPSZOfkyzhz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWyu1Vbv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349068ebc7so134035ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401990; x=1749006790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=ZWyu1Vbv2ejyjuwmvqu1s5LfjEB+ZlDCoQcWYYNoKJEIHuwynv37TA4DSBtp1UaZ0S
         zuJRuTA+hcMV3KHX4mCcQuBv+9ATmxDFcW1KDMbqI3vgmdVEBlR3+86X/gnC/kjumIqo
         hpUv4Z8VF64uiEztKO29w91LCXXBm7SB4I/vRih3EVRgbicfFWwMWAnptFa45ZrwtrwA
         3Vkq3epp/y39JSoFZA72R55fuSQflQs7VGkORFX/afLDoMqhcUcxbL+A3PXGw+R8XuYt
         ehXEjMr3F8JgaNKtCttMdDn0q/wht2A2DHeROq5FlhKDhmnDC1MRv7OnIiWcp7MKB8g9
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401990; x=1749006790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=BNxarHG6QqK2ss5nKc+ryHXZapx0XurcGCqW6sOyko2H+dHvYXG1nz73SGELTJ8apE
         HP+ByPNEeN+b/nLvRMCHmWM5X7m5Ht2+HIpnW4XkNe1pG/jbhPozMDtZGoc/QV7BON8r
         MiucOrjZ+kg6NEebgkU7BQIrPbO5OMtaLrM3lxnrVX3+QWkpJeG/T+VgLLwwY2r4D2Lh
         HWBuMYrmyFsDTKNhNUrEbzSOlIoLv9u8z3nbgBZMS9yVVqs5JijkDNFdfb1EkkothvcA
         BzrolvbhzAEn02YnOE/h/hH62Gu/SAttLQhe5aI4eXsVRgr1m1fHobX6AJSZkCGbqUGn
         EEDw==
X-Forwarded-Encrypted: i=1; AJvYcCXWqC45nhV61wtOyCtxjD9JNAdDvLVCqAOJvB0yRbXm94a36iUw8Ht9+3RDNr8QPMs3YTBo4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEAQL58jH9egFDMp8+JR4ICUcKYYcLgxjmx3q2iiEUvH9JT0w
	8Ofw7fIU/fr79JSUYcarcUD3xD7Eb8Tq+onda2Nd9vsVgLSBwlJGJwX6TTy1pc0SkqQeUYaPO+s
	hLvhKKLT9onVDGcMHkDtAIWRx0POsoOvhKniMcaMF
X-Gm-Gg: ASbGncv9m2CSEr4oqHFnJeH9zayh9Lnoh3EHda9OLTG7m+P5i9jtWsxIzgayhCUVuGc
	QrdoYEP5WHLECe+W+vwiEr9vjj807Iod8YIHed5OXKiDcefpywQ4xRGJIBVxGFQTtnx0iaD8EPJ
	8N1dbk5a9zfrb7e81+ELqgt3x2+NtZ34hvl5rA81sbp93x
X-Google-Smtp-Source: AGHT+IEDUY7riFOOR08zN+pI5SwQ05vmhq98GyByeU8awQ87xrmYDNUTemcQa8sUY7rtO1VWlklZOkyX7GAf8CRHf1k=
X-Received: by 2002:a17:902:f785:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-234c5256552mr1833575ad.12.1748401989824; Tue, 27 May 2025
 20:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-4-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:12:56 -0700
X-Gm-Features: AX0GCFstQ8TSymZiP1u3KsDOqDNDhSVZvkeBqi3jCf2XyHkp_VooW3rcyXYh7Xo
Message-ID: <CAHS8izO_ypBm4htYOZ6mDqn5hge5S_3DBKHHTdEW7ay86MsSZg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

