Return-Path: <netdev+bounces-249578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D622D1B293
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEE630393CF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E036A027;
	Tue, 13 Jan 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgcf9VMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024B3191D0
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335026; cv=none; b=kltke2XimyuN/u3ThoLLcryaWTjxBJkzYkPFZqB9wnDAd1UoEE+7oPFJRre/7LxHzQIArxEcpbIg0U2jSxGkKsdo/tXoEvSReJrw25LuJUhM3VjlqqQAokhGj6xs9KZgMC6mbUq3FDRuRBB9mlsqBL1jNiyRtRCj+avIQGcJEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335026; c=relaxed/simple;
	bh=PISqowe2c+4RDD8+Y4LJYF6tRP/gV/zX+U5Yg9psxTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9jxtQ2TQJjJTAVrLKULqloLcdbCVsrdD0MLZrD0ADOwnGUnHny99J6Eas3iPDMs8mXYgRknokxFHLHWoiLN4X//SLWMWKUzwZR+bhgwRERPZq542jBgBjIzFERv8BioYfQ72nKdqYAeZ4+W2GW5V6PKyvev3YxwPVvofAYQPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgcf9VMx; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-944199736ebso2431092241.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768335024; x=1768939824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PISqowe2c+4RDD8+Y4LJYF6tRP/gV/zX+U5Yg9psxTc=;
        b=dgcf9VMxJ1/K4XNYip4IbzCvlRr6ktVMJYXp0hHpj8rc0xkbkik/EF/fkOUesDZqa7
         YDaNdIFLvRQmYZvK6dIltZzTb8gP9DP+xotlr1eudJfLMGbpEXiM1onTNpnCj4TGH1yk
         X0Z5SDx2KNFBDMP7JUTEsupinwNxlN4XBuOM2LUmUlweWPSWaDDI2IU5fvjUJwjlC36j
         SPGt2VKPH//Mtf3D1/WqPzZaxkQBvZNfiTngKHek8Zc7Jw/b/zbjVGVUNZSObY32cQXN
         GAshSYG7Z0y0oUU8Sx0UousG9sHKg05k0wmke751o0uv0vZdnVV1ELyzLdby4jluV2dq
         2UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335024; x=1768939824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PISqowe2c+4RDD8+Y4LJYF6tRP/gV/zX+U5Yg9psxTc=;
        b=hjjarE8VqJH+tQNwHFJFW0XuYb4iCYNK70Bs3YUrzlQ+FFjZ64aknY/5qHo5+IhZvR
         fAwFdHCYgUP8Q5O7o6mxJr0S7+nUhU3DEcmX/PVNXAwnKVDQ+OCuv7qXFSBGo/K80/du
         2Syr/M7SgEVNH9wvLaT9bwURuctXLqgbucxLPGkfGn1kv//1Dp0Ddg+Rf6Hy+QKGREqn
         EsDoYCLcAUSEwDg+nORrUMcqK8zb47V8vRzb1nFTVXlGUt23F3umKBrY/SKEF3J/1+fa
         P6sN9H5EnVMkPb4fPi9N3bw4sai6G/ZVGEJfChzUi/0UuzY13TeoqY0VmtP5W6oCJIz8
         h+XA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhE8nlK+uKtaNZu4NzHvAIS0rBjVMnc/wImdyc0ht+2bqUwK9Y0QP56iwL+37xCpO2rFZUgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqY2GLnHLXHkuAIfEmCclEOSkxWrCPNUllO/uyHFr0LqJ5jizI
	Se7/tOSnXhJuwBfp30yT+T5i0ZScxZdK8EGe/SMluXIAagOh+6jcshHqNx8HeHI0+c1dEh7BKc3
	ivNfNB6iSnTixuB54gQQcv/xEA2W0Khc=
X-Gm-Gg: AY/fxX6Kp7Diql8m1we4dxKaDt0yLORROLOnn7gDNNglImQnkDLaDZlKhwQZq0IUd7q
	KpsVr4hr7cBJoRrgGI9Q9g3vOYxcOneapaRbFr1OTCaCbANVHLfWJSK6a2DsNibrsh0BlbS4OSH
	RSlzQYHpkm1IJrmQ+PQBmkWv+MHE/2DAxgMjkHHycCiLZ4W2To3rwh+zPpqa5EIFXMh3tV3Un5r
	lgdyMH58h8amVKWnzhgr3crFTSFdeqcaACiCur4aRMEh+HdlFz1qxm26UvskjORtm6VtTBglzvz
	8cRw4dlRTGdZKROtgYrjnsuzkn2U
X-Received: by 2002:a05:6102:292b:b0:5ef:a247:4749 with SMTP id
 ada2fe7eead31-5f17f584f40mr196449137.23.1768335023609; Tue, 13 Jan 2026
 12:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com>
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 13 Jan 2026 12:10:12 -0800
X-Gm-Features: AZwV_Qh110CfAjqIeJ9pDoXr3a--Err3wGqCF4LHns3UhhlVCEjcOsKHE3kYvJQ
Message-ID: <CAM_iQpXXiOj=+jbZbmcth06-46LoU_XQd5-NuusaRdJn-80_HQ@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
>
> We introduce a 2-bit global skb->ttl counter.Patch #1 describes how we pu=
ti
> together those bits. Patches #2 and patch #5 use these bits.
> I added Fixes tags to patch #1 in case it is useful for backporting.
> Patch #3 and #4 revert William's earlier netem commits. Patch #6 introduc=
es
> tdc test cases.

3 reasons why this patchset should be rejected:

1) It increases sk_buff size potentially by 1 byte with minimal config

2) Infinite loop is the symptom caused by enqueuing to the root qdisc,
fixing the infinite loop itself is fixing the symptom and covering up the
root cause deeper.

3) Using skb->ttl makes netem duplication behavior less predictable
for users. With a TTL-based approach, the duplication depth is limited
by a kernel-internal constant that is invisible to userspace. Users
configuring nested netem hierarchies cannot determine from tc
commands alone whether their packets will be duplicated at each
stage or silently pass through when TTL is exhausted.

NACKed-by: Cong Wang <xiyou.wangcong@gmail.com>

(I hope I am still better than your AI.)

Regards,
Cong

