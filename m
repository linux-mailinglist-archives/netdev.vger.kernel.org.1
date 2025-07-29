Return-Path: <netdev+bounces-210863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBCB1528E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C4418A4684
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42623817C;
	Tue, 29 Jul 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrJG7Cdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54B2AE8D
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813066; cv=none; b=Pmyaj2XK7EPoHEflmyfyGykPc55iwGF/LTnUOMJTUpbBs0WfPz+I0il4/YJWJcUsiLk2esfEnrsZg0h/WqTN6RE7WXE534j04QR0hDwV44QuEMMLIqCIlaNUcL5NYWe/BbKCBbk72lHPDe1B5dYSwqLX5gyAodtKnCaMJGZFGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813066; c=relaxed/simple;
	bh=90zZj2Wi/jSSStHprtwOYJEKOACLou5BBOJZbWY93Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hThHE0yotaIqv0FGXcnQx0X+iV7vHPx9Ff9kHHTkHpD9d+Lz0b7Q9pjuSzwbgvYwqy11kldxpDh0409g6ggMcKBb6c7Gjrtde67ZwhRWF4j9rSSh6WSwULeIxEQtrZQEim22C5pIIi+z7Y7OZpf0Zf76nTE/Wqi5vwvwS7iW7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrJG7Cdq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-240708ba498so23495ad.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753813063; x=1754417863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrELFtAsQyNIYUQCqV5rIFM2vQCd45+6wkPo96+Xm4M=;
        b=yrJG7CdqcQNaR4l81QKevCF+jrOAgwAlYklwQl7+TWhiNpRxitjMTbnmIx8pbVInbs
         M+gt1KliRRCEtc8ekJc8ORdjjBm03q9Q3jxQ5WoyAwD291+GYEoKtmBvDZw5gfLzrrxV
         LKJerj891HEjUvr7j+oL6yAL4n7z25LG1IFIHb9GL2IPdBv4hpluhYtkbqpWCZHoCrZJ
         EE7AdqW2xBmvsaWaSYj2SM9t9LNKVS6tYKdsU9hTgRjLZC1ycpCQF6Eof7aeG5NMMoDq
         pMwJH/9gLtbQoa0YxVMNf0Ipz/ApbZ/Cl0bE6HPDbxiZ0WvaEPUqV7TAbjrcz43PMXgm
         al7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813063; x=1754417863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrELFtAsQyNIYUQCqV5rIFM2vQCd45+6wkPo96+Xm4M=;
        b=CFCeA//nm8RGYWMCvAMTnZ2sx1SVMg1dHrAM7tTDBz+ZnW9u7p0k2/6TkV5QoguJ+a
         DJchh8Fbz0AQvypocqzAjTFkZZhPmR3qKzyV5M7BAyiQ50ycm+jxSV0u2aT89LvRRrI9
         yVVzvRipee+SuXXkMUeGCWXdodCc6aQ7lWc37uiDx7nn9oEImP/+gzKgkaI8hokCMQo/
         NBKUknVKIPxDUQ2XMI4jI0UwuJe12qKcxi3FEqSMsASZ2Y0jyncJW89L6swLgNXs2IMt
         5SODMjRVPQyHCfbcN8yQcA+Q6wZ7IGvyGk8iq9DxEAdX4zz/oxE+9G1YoZmob3XRoaR4
         Awyg==
X-Forwarded-Encrypted: i=1; AJvYcCUBRdWYCxybukuKdkmW2VzpsPnprcldVqRkfOCsSTWjAI+vojufsKNs1vSuY4IzqP1NaKw0YM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+obQJBeJ7Lc7jZVQcZp+JdYxM5xcj9YsAFEkudKlzwOj+Dyk
	Zjp8NXINUs2jtcqK9NB4+hPGs9EqOycJPG1rOkx73kFOVFRAsiBbWmxY4dc8r4Qx+Ar7a+SJ5H2
	A+QUh3Tx9brCUsO9PFPCX31DH+qS5L4uywm+vPF3i
X-Gm-Gg: ASbGnctFV5/NdGNtMrJRufE9wA79/S2HHnu7pEeznKIJbrqzt8DZSMn3GCpmJumfR3U
	WQufIHcPzs2ULth3PjHEXS0lZU1eF3AGT+jj7YRYOpuTe/CjiCJ0RudWApCBAoGrJ593eVI+9Ql
	hnDKSrVLfDk+fleOEoCBIdvhNGC4oOSQfcwYgQq8IvItAouOY8BHdtvQxE7FzDFux3gDuS+ZCO7
	9+D
X-Google-Smtp-Source: AGHT+IH/JGiXh5XiKWwlu4CDnIGhqRo+jwrPA9qHfnd8CZIjwn6cTGQgk7e/thnN52vXlk8rPFqbbZX1d9enm1CVFgo=
X-Received: by 2002:a17:902:e80d:b0:240:469a:7e23 with SMTP id
 d9443c01a7336-2409a044697mr269765ad.20.1753813063049; Tue, 29 Jul 2025
 11:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728202656.559071-7-samitolvanen@google.com> <202507300122.RpqIKqFR-lkp@intel.com>
In-Reply-To: <202507300122.RpqIKqFR-lkp@intel.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 29 Jul 2025 11:17:06 -0700
X-Gm-Features: Ac12FXyTkIKUF3oE37TmSDCsrlZi0YemuCpY3RAC5JJl1HoxExctdyr3bgTjL2E
Message-ID: <CABCJKudjiU8KZoBa+0k9ey5ccPp5E0JhUc5n-DRKbOamSO==VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:54=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Sami,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 5b4c54ac49af7f486806d79e3233fc8a9363961c]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/bpf-=
crypto-Use-the-correct-destructor-kfunc-type/20250729-042936
> base:   5b4c54ac49af7f486806d79e3233fc8a9363961c
> patch link:    https://lore.kernel.org/r/20250728202656.559071-7-samitolv=
anen%40google.com
> patch subject: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destr=
uctor kfunc type
> config: alpha-randconfig-r111-20250729 (https://download.01.org/0day-ci/a=
rchive/20250730/202507300122.RpqIKqFR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250730/202507300122=
.RpqIKqFR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507300122.RpqIKqFR-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> kernel/bpf/crypto.c:264:18: sparse: sparse: symbol 'bpf_crypto_ctx_rel=
ease_dtor' was not declared. Should it be static?
>
> vim +/bpf_crypto_ctx_release_dtor +264 kernel/bpf/crypto.c
>
>    263
>  > 264  __bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
>    265  {
>    266          bpf_crypto_ctx_release(ctx);
>    267  }
>    268  CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
>    269

__bpf_kfunc_start_defs() disables -Wmissing-declarations here, but I
assume sparse doesn't care about that. Is there something we can do to
teach it about this?

Sami

