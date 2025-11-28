Return-Path: <netdev+bounces-242620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940CC92EF6
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00B6934A625
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2228850E;
	Fri, 28 Nov 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="JXqavXyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F027FB21
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355777; cv=none; b=h+jl0TGkz1fBsUUYsqziDKf86B0nHbjgxPhkEdhQ0Bgex2HWTZsAI9epG85JY+MooosvyhyUiT06pJLYSoEFazVbc+gzCW2bzKNnGNm/8IjNruWenrDoKPXaFNeDSMTbLJi4xoRHoF7w3F6L0AUlVaF3yETrd9zXyrHXr0ZFF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355777; c=relaxed/simple;
	bh=VznajH2pBXEOBwf6S0r4CgidMsgXR3tvOfvsfM5bKGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqvyLeVvaMb/VR8I8oXNQIajH6pBzJpdWLuV0/uCToMEfef6guicGVW4f/Pzjzrd79+TxgCOIPpVsclBWrVAEt5CQY2VfD4qd6C/ikkB4FUh9NULdU4Ua6rnPnUUG8hFmQYq8tkG2WCkkVYpC/3TVprnBveCnwOVVuVA32c6P3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JXqavXyn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b23b6d9f11so177903085a.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764355773; x=1764960573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VznajH2pBXEOBwf6S0r4CgidMsgXR3tvOfvsfM5bKGI=;
        b=JXqavXynmz40MMV6PTyezH5xuQSfjtXGEotaWs6hGvoOw21WBKtZXySOL4WhsShndU
         LmSmcyLsRF8pP/1t18MZLhPsJ14ii2gGElnPvCh7vD71vOPWzPucip7aHWArGgH+WR/d
         ajTtqO+vj9FTD3khPtHa/BJ/iqdhufEzcC9G4gzqQ/5+s5tVsBhsOyGIWw8pDvAYq6Z5
         FzZtAfWv+7TPiW9LIotCQmDWEKuJzdDPffDfWL2DNAlm34OTZjdohw0cM51M8nILRdyx
         hDRygrU9zuqttba6/27sLL2aG8WXsRPHl301R/w0lyuIocO7VHVKpkRbEoPFPU74Ba3e
         yAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764355773; x=1764960573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VznajH2pBXEOBwf6S0r4CgidMsgXR3tvOfvsfM5bKGI=;
        b=AiVBpP6omjOBVbQoPpETI5Yo6oalVrNi4gNpeNcN39R9ChPyBcqT4wtHrQa/3aTU5A
         WCssz3+1cFjk7nxzg7dlj+kgi0u51AmAdpQcu0064kkz/GAeuMqIkXQsSUvRxnMZ+JNJ
         gHgulb1bFcn6EiZH2OxzJZAgR00NZIe5D9SSgwGDxqISf01forP+9fX8QcdXglHKFOrU
         lB8rkJOcDufRAqiCdzblmbZNy+GL4ARfyH1MYWluQEQc3NqPZh6AC1+ZH4eyEs6aKvEQ
         g0ZjVcJK8QsBg+3/w9/Egbu7xK0ToAvyUsMjYS+509dD7L+z7xImMCWHu1bcoD+hwVKW
         5/LA==
X-Forwarded-Encrypted: i=1; AJvYcCVIHbj8xgmbSJsRVAU8zqMC9xxA1pD9f02t+ht7/9tThslhzQ8cKvBL3G1h08vrIWLzTwInczE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxDPKUS6EZfqNFPQJvAt9RZAwLzqqKmdy2/oQxIa7LLfZxZV8
	3i1RY/257DRvRlrYmLc9pgS4SETZYVh42O0jy62glZ6hPFf8ejp8YPDrfxiNJeBMkipFTH/TfKR
	DuHjafFWHnQ6TBUfgwcsnb+U5WG+dnH0inSPObVQF
X-Gm-Gg: ASbGncvdLjP8Z5BbFzoepCU12wYmUPqzcrO1dS0nRDq0XhwDJ1nroDOpm6ra3r9gIQj
	WgRahz90WYECqlt1ORWmLYDzupHgquDIzBEYIzeNXjMHd/vvv04VPvWmH5vROo+AX+SxyUcy3He
	vnSu391C6RzeRo/wQuDB5enbQYW0FB0k0FQHLQkc5frB6LCKw7ajw+oUZPpJJyy7TYrguFIunuw
	3LRFLX26G6Qy8k78S+YX11WrN4bWRwE1J8UgdAqSJgG4knsskX0xm0HhWOnYvW1eCobp53C
X-Google-Smtp-Source: AGHT+IFjRM/6UPV7aI9MptxB6wVmvfk+0t+vYvB6qc3V2el4sHpZfuef0Mb9rT0DSWYVUSkWvMK3q3g4bKKlBIkAe9w=
X-Received: by 2002:a05:620a:29c7:b0:8b2:dcde:b668 with SMTP id
 af79cd13be357-8b33d4680a5mr3966542085a.62.1764355773575; Fri, 28 Nov 2025
 10:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128001415.377823-1-xmei5@asu.edu> <87ikeubjqu.fsf@toke.dk>
In-Reply-To: <87ikeubjqu.fsf@toke.dk>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 28 Nov 2025 11:49:21 -0700
X-Gm-Features: AWmQ_blicLCsN0iOkNUduAiLI6to9ue0rAibm96LtZjDLhZZqQLeIAnsmPbo0Qc
Message-ID: <CAPpSM+SQzdQ4VHsW2Fw=wTuBs_yw4NCWrps88=EfoSRAVG1W8A@mail.gmail.com>
Subject: Re: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: security@kernel.org, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip. I=E2=80=99ll retain the existing tags.

On Fri, Nov 28, 2025 at 2:16=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Xiang Mei <xmei5@asu.edu> writes:
>
> > In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> > and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> > that the parent qdisc will enqueue the current packet. However, this
> > assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> > qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> > accounting inconsistent. This mismatch can lead to a NULL dereference
> > (e.g., when the parent Qdisc is qfq_qdisc).
> >
> > This patch computes the qlen/backlog delta in a more robust way by
> > observing the difference before and after the series of cake_drop()
> > calls, and then compensates the qdisc tree accounting if cake_enqueue()
> > returns NET_XMIT_CN.
> >
> > To ensure correct compensation when ACK thinning is enabled, a new
> > variable is introduced to keep qlen unchanged.
> >
> > Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN w=
hen past buffer_limit")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Please retain tags when reposting...
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

