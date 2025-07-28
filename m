Return-Path: <netdev+bounces-210643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A5B141D4
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57C27A7238
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904E27466D;
	Mon, 28 Jul 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5alndfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60151249F9
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726714; cv=none; b=YgzNDgAWKOYf0OD83nOqCRkdX2F3ER4hL5WX0Bg0F09jNXbr/zCRmuNI5xF/TxTWc26hP32hahuOPxEDRNjMukrtwcxc8jHhhrjBliyBMN2FeXB93fnahjTRbWCXI2Hgq17Q8Gm5AA9me8PQyAH7EILci3kWr0QxizZa6/f0qr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726714; c=relaxed/simple;
	bh=AdeJRdfJyCXJ75dUB9dz+Y8q5UgDcwwKMzTthCRUE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcfBoEXyo6fRrxfUxsgf8DHcJV1eLKcAUKoYyo4ByY1zwKF9O/DbXXZ7JfTYY6zmG7hQ1Hog7W7Lt/j623YnBdF6sQimSpQwf1v4ufcoVa8wQWYp1hwlEeTNta52r57ej7Ja7ftxhcWQwRxELHmdR1iCpLats5x+hA1wA+bpCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5alndfC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2357c61cda7so22885ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726713; x=1754331513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=934JXgrmfTiZKyG8AS6cDigjtQRPbfTN1Gxmsj8ReVg=;
        b=X5alndfCBBlPAccId3gGV7xrV3UCmBxDiSXLT5TtK2m5I5TNEf+z2F36az6UvHUbzC
         bAKMDA7LknH7nW3byaQQSr50prbconGoa+kDIpgLzPDr1Y+GimIpCD4/qCksLDqeGP0f
         sz0bS4RGQQQzyQNpOHO74xfERrFUhm77z6FVsgYnGLwzEcINZrncSKAvJc1hThJEHghk
         pPNmH3ugipt7sKjBfWT5jnB4sVNHYYbS7BXlFDld4pKWStXj4+YqZcBqtsJ+bnEX1gyA
         JRbzRXnuELgWOjAC/W56iDb6QAEgXz9GAtjaDUXqjy1Ms/qKSj5pfY8d6y2JzHuUGkSs
         VoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726713; x=1754331513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=934JXgrmfTiZKyG8AS6cDigjtQRPbfTN1Gxmsj8ReVg=;
        b=soven3qs1mdwHccS1QxglcV3CarChIhsy6d7j053lPuRXXxc98jDDKWnsvCBzwOjhe
         8lUHO3p2YhIFFWZ9G7i1Dgj/HKiXSn90YkJ3SlPWhbllW7Db5A+C5ZLoo299QZjffLDH
         /zPItlP99HSoDYQVJefWL+rl4Bg3Q8zIailOU0CARWTvhXBL2qwn98KFw64rL2/smUV4
         mAUzLwp25F69NtZCbY3imvCQl5iueIGFBNF7SAKIvRgXsckEIWt6rpd9YyZOWc6hxhUT
         uxd6Kw6/mceW034s+QISLdhJk24nXq5NKcbMLry0HFWKQHK8UPTvU6fmcBh6+yM7XtOx
         B1Og==
X-Forwarded-Encrypted: i=1; AJvYcCWOj923BJSzrxoB+gABECw7un3qptAQSqQXp1UfA5ZwwqcQnbcZ6xdWCqOOZR3HNYUjX8ATE/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywri4j+aXbfZeO3cyEYhhXX6cWsNvbVTs2k4ghDamHCxRwpytCm
	V1H9wrTNSvpWH2Nj/xZgMafaNlMWaS6vJu+MvBOYKOeOIAkoPRT1v1gt/SRi4ftPtA==
X-Gm-Gg: ASbGncsjN7ajbHTV7O26AwFdcVLjFGofh4bHYkBSi0Bb9lAh7yStyErzwzQ9rp1oMIl
	O67GZYwyamGSWNsmI6Rn4DBQJOh/Q4kBgdtj8e3PNBwZLiZ+KV6wmPDQbNLk1dWEgJiPfYyLed+
	zivZm4q6ZHSncI8rsa35cqJ4oeauuLWpEgQ19wCa3jX6DD4zKED5fYtxPhLKlqmbT6Uhtb1RIH3
	Kl+9oQLO4WBwvTsVDDkB4x4jrxI8iqBhMcThjmOasFa7HcC0CnY/TxpQibXesyQ950LK8s8AkPN
	g4q+Zkjh0QDqudzw3LfTZWGJrsiZ2KDbYelG3EMZdI92Xs3kX3ju0mEOP1KAk8yYomW5vrMjBzS
	4Gu6MTDZRiLHf+/+Iw2IiOeHElYG92h0xnx5R48EULCk4vhG4DA6Klr0QegYX+fUR6GFF9n3nYf
	wjLxE=
X-Google-Smtp-Source: AGHT+IHxxJZ1UPR2CgoRBMmD9QUIzkRhy63XqqC43AGYc+LeSZvQDPxlTzuPfaZ07fzByT4GOjK3EQ==
X-Received: by 2002:a17:902:d50e:b0:240:589e:c8c9 with SMTP id d9443c01a7336-2406788feb6mr279565ad.10.1753726712249;
        Mon, 28 Jul 2025 11:18:32 -0700 (PDT)
Received: from google.com (111.143.125.34.bc.googleusercontent.com. [34.125.143.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b0c60sm6064646b3a.126.2025.07.28.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:18:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:18:26 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Message-ID: <20250728181826.GA899009@google.com>
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <20250725214401.1475224-7-samitolvanen@google.com>
 <932a6a4d-d30b-4b85-b6a9-2eabeb5eaf2e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932a6a4d-d30b-4b85-b6a9-2eabeb5eaf2e@linux.dev>

On Fri, Jul 25, 2025 at 04:11:27PM -0700, Yonghong Song wrote:
> 
> Okay, looks like Peter has made similar changes before.
> See https://lore.kernel.org/all/20231215092707.799451071@infradead.org/
> 
> To be consistent with existing code base, I think the following
> change is better:
> 
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..a267d9087d40 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>                 call_rcu(&ctx->rcu, crypto_free_cb);
>  }
> +__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
> +{
> +       bpf_crypto_ctx_release(ctx);
> +}
> +CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
> +
>  static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>                             const struct bpf_dynptr_kern *src,
>                             const struct bpf_dynptr_kern *dst,
> @@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
>  BTF_ID_LIST(bpf_crypto_dtor_ids)
>  BTF_ID(struct, bpf_crypto_ctx)
> -BTF_ID(func, bpf_crypto_ctx_release)
> +BTF_ID(func, bpf_crypto_ctx_release_dtor)
>  static int __init crypto_kfunc_init(void)
>  {
> 
> The same code pattern can be done for patch 2 and patch 3.

Sure, I'll update the patches and send v3.

Sami

