Return-Path: <netdev+bounces-241291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98621C825F4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55E3E4E1285
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8032D7EC;
	Mon, 24 Nov 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFqWpBvv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E52C0272
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014862; cv=none; b=ikLxg6k3E+UNuaR5u00kb4gGl9inEql5+XMsItkHej4ndb/V+yE5Xwo5egyRcuorvNahfy6wQuITJB0pJKiG9TkLZm8gDBYThEeiGJ2L3wmm6xfAIe7FYdZiIJOru4Kk9gv54q8LdkCSg8sfZnnoKlc/HZBUCvS9AD9KNvQOvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014862; c=relaxed/simple;
	bh=B5PBtsL7rWWD/4xW2wiKyeu2/yxouUKlgbj/UPN2104=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri2qhJYb2IbMEQXnNV9cjkhSigP4zFkfYNi171aqmR1FEpOBaVBytIV/YgHmpIv9xqPNESDnuajNgZE/VcOIOYzzz9+L3VcXzW4kBaUA3HSIWEk242TxkmfXfd9R2vsuH8Pqgq9iNuNtoWoJ0oO1sb4DlrG8t20y7Fa47FQ/IMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFqWpBvv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso4014524b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014860; x=1764619660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5PBtsL7rWWD/4xW2wiKyeu2/yxouUKlgbj/UPN2104=;
        b=kFqWpBvv7DGATRj+CdCv6nxLXxYtTXWVVesYadS9hVwiaOV0UPLRLHwUbY241GMnZ1
         NThg0Odby+zlQaFV5fvTr1n6FEe9dlXw3dQds9fdEUQw83eI7b7kIE6kW4mrPdttKb3s
         /sBkjSNRtztnfUwuqSM/TqhvGKyDq68OfE8PU1dq0QZFOTHKcSpCa6nQf1jK1M8Idbbn
         LRNTEdB0U24YhET1WwBa5yCt92eRW4LTA8jT0uwi+f2qgpDl9ltZOhOMJXFbFXGi8ycp
         xCVid0rJ3DkC8btWrzZ8VI6DEtd/xyGKEIhfEmvjsbVq1fwQNEsunLLdxrlmkYdKgBmw
         m8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014860; x=1764619660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5PBtsL7rWWD/4xW2wiKyeu2/yxouUKlgbj/UPN2104=;
        b=TEwJetJ+fM2670awtlOOs20I7br4/KXiED28cuc7nS/R69T9VpcRQgKlgwPTIW8eMg
         sDmQPYDymgCQMqUEFjWF8YwoGhTWlLkks+BhRXUD1YyqUs3j09ZpO+2/nZSJ2Sl51Lgo
         zJKFKkm6+h61mluYpi7FzHspOrZv+FfFp7JMUdEf42QiScZshLOkNoh/7cVeSjYr2kuq
         2heVAdAtKAmfrMScWsGUnA1NtusRrbTRJ38HIigbPr3gq7GlThS6v9LX61m5ff28D+Gg
         R86r8GPn8yo6N1QfcynSoSFhBc1ukX/8sx7otOfP9O3MHMqWGBxifPF2SImbfvg+T+8r
         jchA==
X-Forwarded-Encrypted: i=1; AJvYcCUYNXGuCs6aalQO5RfDG3ExjYgGuHp2uKr1Kvd2GUUzfsQJVwoqPniH/ft1OII44JeY9L0WwrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4BZdLI9chVLyyTU3S4rCpJZ5Vci+iRCeIrDl+qgm/gWn/Czx
	9eRXQ6RKgJ56X6BGKT24iLN3nABRiu1CRHpEZXQGT20RRKrHfzSNnwI+RMNPCcA9joL/Bh91tuN
	loFS78nqk2/t4VOc+xwnzCTy/+X8/vwTUBJBPwiNi
X-Gm-Gg: ASbGnctmsOWMJfuTFIguKTU62HKCp6LLgKsSjEYW4fsnQ+oZ8kV/6nlIsgP6C64qkRm
	igI6goeV56pQrgkCuOmh7K2WhufPlTR7ljP9BeneNFISe7PE7Nt1cI+Kx5C31AW4YVfqu/0/nmW
	O7ziAZEtXxDiUW4j3aVqNIbDERDTtr2sRJ9h5x9qRVkkaIPM/5s1kW4Au2PFe3dcIKs+t+FhokR
	6vqmYN9B5AgHdPPso5nJ/Zvtb2yI50GmWlkqr2G7073gHRmgNJ9DA9N731jBF31sn56H/bsoLP/
	x8t/uhuanB/pWEZ6jq2rRdhazdo7KK/RHplvUcg=
X-Google-Smtp-Source: AGHT+IF0qFEz0HFLBVHLvtAC78b8Zf5MEE5uqW6oG+XHhLQZUjv72gF0qQqMiXeQmJaepCLZSDK917TkANIvQaX2taI=
X-Received: by 2002:a05:7022:45a3:b0:11b:1e43:1c75 with SMTP id
 a92af1059eb24-11cbba478b1mr185604c88.29.1764014859947; Mon, 24 Nov 2025
 12:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124194424.86160-1-kuniyu@google.com> <20251124194424.86160-2-kuniyu@google.com>
 <20251124115145.0e6bb004@kernel.org>
In-Reply-To: <20251124115145.0e6bb004@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Nov 2025 12:07:28 -0800
X-Gm-Features: AWmQ_bmewGTl6_YTHGR7VcqTYfA7O4ssL9toRr6xHcTRK4pLRJmYGx73RkELl4s
Message-ID: <CAAVpQUATnxEVBE8uNt01eih=CnonmnLwYSrEZEhDk_EEk7Pemg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] selftest: af_unix: Create its own .gitignore.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 11:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 24 Nov 2025 19:43:33 +0000 Kuniyuki Iwashima wrote:
> > Somehow AF_UNIX tests have reused ../.gitignore,
> > but now NIPA warns about it.
> >
> > Let's create .gitignore under af_unix/.
>
> Thanks for following up!
>
> NIPA says it doesn't apply:
>
> error: patch failed: tools/testing/selftests/net/.gitignore:35
> error: tools/testing/selftests/net/.gitignore: patch does not apply
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
>
> Does it have a dependency in net or on the list?

Oh sorry, I forgot I had some downstream tests.
Will rebase on clean net-next.

>
> > new file mode 100644
> > index 000000000000..694bcb11695b
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/af_unix/.gitignore
> > @@ -0,0 +1,8 @@
> > +diag_uid
> > +msg_oob
> > +scm_inq
> > +scm_pidfd
> > +scm_rights
> > +so_peek_off
> > +unix_connect
> > +unix_connreset
> > \ No newline at end of file
>
> nit: missing new line

Will add in v2.

Thanks!

