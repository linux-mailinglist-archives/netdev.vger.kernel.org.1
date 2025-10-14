Return-Path: <netdev+bounces-229246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C47BD9C32
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05E4E4FF1F0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E80310650;
	Tue, 14 Oct 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eS1ShkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC15313E37
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449024; cv=none; b=bZDoXZGr+a1W6awv9jjAVpy7+FcVIp11NFkHqlI+zTOR5JZvDjlvWLmHdnh0yYG8vBbS8aBnWZt+b3TBBBIvZVgBWkxBViVaHygc4Wn3ja45SItY3x7V7k5ekmmvjbxV/clajss3BdB6/BAd3UBYCEbytf+99ugJ72ltIrrKprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449024; c=relaxed/simple;
	bh=aJB5CpZicJ1RnIijeVmqnKSDcG012n4IiRAuaVjUahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjik23zgdbay5Q8S20aOTiK44PXebP6Q+i1kFZJRTkDsQg3RPmjbavOL0yH6J+QYmMplLLdXjA+0xQuXiyoAgOs2HPUStabYvE7+ivZHdkzt5/7SlFTFJ7mWtSKivd2Tk2XcJb2EuvPDMKlGCEzdNJxgXXFXyekAGZ2RZveWlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3eS1ShkL; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-633b45fad1aso5124919d50.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760449022; x=1761053822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJB5CpZicJ1RnIijeVmqnKSDcG012n4IiRAuaVjUahE=;
        b=3eS1ShkLu5jCXgZYdIe89ObK2cRNv3k51se/flwGMFw1urZz4PLFfHyD8HepP+rqXe
         Z4dPPJ6bKZI6qJHzcBFWBzBHl3VROsLWhyxo69FnsKthOr/IMJqCIVTHT76IBIfTvAYf
         niFUP6oVu0+EV2GzdZm4Ljs6ixIuTHec4l1wa81bAoOLyTd3EPLbN7ovSFEdukIFV59V
         R60Va7IoxBlseFOtjg8APQAC4xeQEgEj1YkJQjWfGlweBPfZU5X5eoFRPK4tzpy0BI4r
         JyQFDOtFLjsWrpexx8gOX4rMOsEYMVJ+xPJnAdZxMcyvx3hgqdED3hV5oSDeXgo/zb2L
         MalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449022; x=1761053822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJB5CpZicJ1RnIijeVmqnKSDcG012n4IiRAuaVjUahE=;
        b=o1gu5QXsBu3d045UL/gpC3fxDGl4nNkKUYYPVyWt3zhBuOfHKiZdksAYTLbCwu+RxG
         6xWR6d/ZvRAXCZRElzCAMouCftbbDx5YkPLuiABUNVk6flJab5wvpZhmGMZTmIE8yPlV
         d/hWUeRokWvPn8CAH09ul4x0WFJG6xYUSE61TipvZwdadufkDfmgQrIMbUnMbMB+vpAc
         sJkZkNey/5/Yd45/L6N6bgm8M5ZAewcJTpjXBjDG5ZyiChMUWKY7GcBT+MLsUV9fGoXG
         Qrk279Dlh/LbiZo2mwFeuB5HUBhd/Ihf19bS67Qzf1ZOJqTdOXSRvTBn/fUkSquyShyy
         BHJg==
X-Forwarded-Encrypted: i=1; AJvYcCX5vrC7kAZFqyqoXqQhq5NUK33eutFwB0POrKjyofK3xNRbR3w2xhCW8EQmF1u6QM7J+KzVNDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUypgp8Vv/bz0Cl606mLNvqLrDWM3ZLrYg3ncqkrw7CMvu0Gi1
	kv3BGWAmV0o9iaajGCHD42ahiNiIDz4pX8JGxMSFjLTlaZpd+S8zCA0RnlWR+f895MMvdDIiO1u
	0GsejJlY2BlWcXvQkE9DAhhGIszrClo3oOlozfgkC
X-Gm-Gg: ASbGnctJAlEDDmcGQNQlyWv77jJvWDh4bt3HfNQr/+crt+YpjN8V6mNJElARNslqp/W
	mMmdvd9kYg5L8iH27McBrAFW1f7fCJM2EUM8LfI5bYuht7S3t8ZqtZ8pU48DbCD5F90fGZRM7gs
	467XRJycGlBFa7bM17oqoI7S/6ACxdl2oB8cQxGK95z5cJi+wT0Bzb2DEfjxbogLsCo2cfuCb2O
	pwbE0hirYHFn5b9s85e9ZBx1neO8hkf8tuwG1iIKt8=
X-Google-Smtp-Source: AGHT+IGnEB9sLH3sQggCSDZjfEWoI+3McTLqcpji/rfURGU6VVNdFkU9ewJNcB6FReykEYQ6sVY1aTcjemHFQxlYp0M=
X-Received: by 2002:a05:690e:155a:10b0:63c:f5a6:f301 with SMTP id
 956f58d0204a3-63cf5a70779mr8385836d50.67.1760449021306; Tue, 14 Oct 2025
 06:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014022703.1387794-1-xuanqiang.luo@linux.dev> <20251014022703.1387794-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20251014022703.1387794-2-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 06:36:50 -0700
X-Gm-Features: AS18NWD9dBdg--F90x6lEQydWGr_BOhUHjjqsOMR-uAWRMLvcpVEmiiQJJdOgSA
Message-ID: <CANn89iKzzX8bXcqq=oUYun_dSmLBELQ0+L3whY=m_LCtUCBhog@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, pabeni@redhat.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, horms@kernel.org, 
	jiayuan.chen@linux.dev, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:28=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev fo=
r
> hlist_nulls")
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

