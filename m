Return-Path: <netdev+bounces-291636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbvKaVyFWpbVAcAu9opvQ
	(envelope-from <netdev+bounces-291636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC215D4042
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0C7303A905
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937683DB623;
	Tue, 26 May 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTxvaGzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5803D9051
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790152; cv=none; b=ZaF+HJaGGhwxv2yy89lvny39CRjrq5X13s3OyrLLFxNucB6eg4JuysBsI5hraEx7mvRWUq7MlQPvHcwnFGkFPN6oqgHSybch1bWPP4IVVwwk2SwKtAHKvyhLNEMVVKpi34wiHSOcb+1g8E7o1Zn7vTvesVli+0UkeqemP6FEWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790152; c=relaxed/simple;
	bh=BJ+37IuAjAouSblZo44lXPzZcdtzmRe5yJctpqEfmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAtlBySCs++jO+dVIq6E8QCX9bblJvRegUy8dfOhjeF/qIQEZbMCYY284ZX4M4+Jv3Kek7EONGM8bA1L0seB7KgfAQ7ad+TSIrzqZls00RU+RMw4Zwg4AfHDyzzke73k40+XWWA57vBdVkaUlKfhvTgVVT8EH9m+CFbgzkaE/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTxvaGzt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe608cb92so6307369f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790149; x=1780394949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz28OK+5uRErvSO52GxHA4GJ7xySuYdInquAfmtjKwA=;
        b=MTxvaGztoMb/Kk+QGhfNldzNfZejvaHY16o5/BTonUXNvj4vySSPlu1I6ZSpaEOzl/
         BAM+n3sj9gYSImpbXgTwbpDREtCNLhZY5Wam09Bu0xY83ud5jCDdQT0ibn8fK9uC45Ke
         Ff/WxM+qR9LbIAtWTYmWJHHlOuW22eGOGn5HeCTamLfXYz8jKc/8mbti30U3/Cwk4iTE
         wh0uvdyAD7pOfB76U8u0jPFBapm3jsnGGpVzYqpt4dzcK/Xt36SWQhH74A1pTaTAAkA+
         dFlgL68M7IKr8doXtA3M4l+K5FIX5r1pHs9IFSsX0xYcJwfkiSMEJlKZBEWZTY0ymcQF
         34Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790149; x=1780394949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rz28OK+5uRErvSO52GxHA4GJ7xySuYdInquAfmtjKwA=;
        b=qFoLeCvPDeMrytJhpHL/6NIFIzIKHD6ljzpgIJKC9ToXRKc0HCNtL/A1ePY8tSPJzO
         gBzih9g8qdUF0kLVQ9/ApKhnziTy38CxFnmPPVkKjFFPKkK5tMwQh8PRiY3vo5JeILSi
         nmCfxvLFViGtYTfqVI6iptyBtf/XMXBoCgdBAH0IS/JnOsM4zP/UWBinrsGvCSYM9eWt
         mNu1PiOMnOSkTmVy50ewkdPVBzLs3pbjzQIcCPUMNGjojR/wmtYQpQ3/IlbSSc0OPJUf
         DsozTpComjpufE6BleLZZjHDuk9NFcKZt+5Oui8Thqq5CasIgEEIn+b9bGj8QtJQqu63
         Z6Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8CqplW9RtHYWJ6hTPN/qiMv2ess2sLoxwfWxhm7eYIrSZP6EbAyipgCc0ERxBMYCvLwU2KWAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTzemnMga3XGpZRBJ1VtcopLj4wnHZhexAulVa+ifSgcpy7xk
	T0rsmjnSz/CzAAVTfftjqqLG8tdxQa/1mIrCnndwaCcnOyIf3zVD5vq0
X-Gm-Gg: Acq92OGTNBDvxp35FtREiAYpW65wS986sXaHDlDuBmk6VGZ6lAwps5G1VDZYAIyKbFJ
	sdq2lXmrsc1nXW8tjd12KYmEIBslqUaLGgbIoJ4Aa5vIMl6Fj8TLFwRWA+hBt2t+IJ7zqJElilf
	z9GEBiNMqzF4VyWxLYqSiYAqO5D67aOSJFgyywm1dBe4CbR1zClxFyxcI08+B6AdzsBY0rW06gD
	nySzm94Mac7HtcjuOoCsLL7I8KUM9QuQbYcv4rJ0KnbL+srZtsTMnyPkiZQMWDc/tOvBMZSRDsh
	akLOgk9pXhrpCAYE5pV0d1E0Vrd8GmoijF4ayAU9aHXqlVsACXggLJdBLJDBp6V7xn4e6vIFObM
	v3ctayxLogYlupLNslNExY+zZzCFSRto9hK0Qklz9GTBXjEkXr7vCE+9hCCTvFe2BKUsOCcksT2
	ocY+mL9y9diWvSLLOZg/tXPI9Ash4ShOHo+a5MaaIG0tQ5aFHM8wvLgmDMEZakPHo9
X-Received: by 2002:a05:6000:25e3:b0:45e:739c:f187 with SMTP id ffacd0b85a97d-45eb38c5329mr28176468f8f.22.1779790148603;
        Tue, 26 May 2026 03:09:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm33661340f8f.5.2026.05.26.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:09:08 -0700 (PDT)
Date: Tue, 26 May 2026 11:09:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
Message-ID: <20260526110907.2e9c1fe9@pumpkin>
In-Reply-To: <20260520102130.423044-1-sangyao@kylinos.cn>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291636-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9FC215D4042
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 18:21:30 +0800
Yao Sang <sangyao@kylinos.cn> wrote:

> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
> with the CQE initialization pattern. When entries_per_copy >= entries,
> the function copies array_size(entries, cqe_size) bytes from that buffer
> to userspace.
> 
> That copy is actually bounded by PAGE_SIZE in the else branch because
> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
> However, GCC 10 does not derive that constraint and falsely triggers
> __bad_copy_from() in mlx4_init_user_cqes().
> 
> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
> explicit and avoid the GCC 10 false positive.

Why not just calculate 'entries * cqe_size' and then do a memset_user() loop
for that many bytes.
(There might even be a memset_user() function, a quick search didn't find it,
but I didn't find a memzero_user() either - and I'm pretty sure that
will exist.)

-- David

> 
> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index e130e7259275..7b024a5e13c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  			buf += PAGE_SIZE;
>  		}
>  	} else {
> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
> +					 PAGE_SIZE);
> +
>  		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> +				   copy_bytes) ?
>  			-EFAULT : 0;
>  	}
>  


