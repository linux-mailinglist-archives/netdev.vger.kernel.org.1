Return-Path: <netdev+bounces-169870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD20A46142
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC1818976B3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3AE21B1A8;
	Wed, 26 Feb 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AtDrnHJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40774217F5D
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577763; cv=none; b=JOpA01Hip4Nd73vtKPCLbHrcX+1ffsqspqv7N8A4GnAR0jY1sAD/8ZALGxsHBeZxOBbgbjFKt599I75C39NQbHIkHwaZqu74/ckszexpkXEXvQWshjIa75dbqWbyO9HyvmVvCDOotHjRcQ9bnw6vNzZM2xueMDD9gTdlhe1kfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577763; c=relaxed/simple;
	bh=7Sjqx+lWiFFlcoTpiTe2+WbeyQkokQywUdjL2faY724=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnPnTyG31ymIl7+itLigGSh4QNjsnTEyxaRMMcCF51g5EqpL8I6lBwyoFhxy5Zbc2fAZG6OGGVNdiKBN8EgR45AW4Zd5ct6P7qVr9hDIDik6d26oDGYzukYQbbm6NMK/pdVdt8Sk8lungfnz5otIN8A0IFW16m60zof5EgDO+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AtDrnHJG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so8968423a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1740577759; x=1741182559; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6f2oUbpNnWs5FWgzYsSndrQ+qrKeORdGmzd9Kwn/DJU=;
        b=AtDrnHJGALKkgx4DndQbc70sTkQKVbSkk8iRtM5+5Ti4nKYp1gqgmMwF+MDh+k8ayx
         2tPHbWgqv2Bdp52ibZS0KWIwN8jM9HfxlFffXh8Gf3Zp1RaW+qbyoBX3p4DQb5OJANM3
         TyaK+m89Q4WZmf+m6FZQTo5CJzUjM2KZkSBba6lWbg6M2Jn4TSqQNbeVqEpc/083f7G9
         QvAQsZQKU9J0HDjGJJ/YQVsB7JpMA90cjyyzyj+JJXEDXx/37e23IB65vuBulH/z9WVh
         sGkUgjSa9EEsrdN7eqznE+fOn30ofWbxo7oPP9aYp8I81r2q2FHLucEysCDr50rRWd8+
         uQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577759; x=1741182559;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6f2oUbpNnWs5FWgzYsSndrQ+qrKeORdGmzd9Kwn/DJU=;
        b=UzFS+ByfGuHQKu4/vmuCyRChQxYMSnvEE8TB4Gqf2pPMO7+mrT7SqcF8SlZRIjwuKa
         CVXuv0RkjMY6xC3BNDMuBI6jo6u1zCVxoFa66468QU3ZoDxmyBvTRtQWXEODswVouwNJ
         btmuh7WSEXgBGZbq//VqbBYWhH1HyF7aK49yZfzMGVcEoFg4J1cWLv5BbYxQYWuYuXrU
         D8lSqrq2C4qC/cSk7X9QMxdzxPSO7dVgioebclaEJdIh3FM9A0Aad5F1fKGYYGPUPTYb
         LGgsiAGGrofwNWTlY5F1RxEhtezYQI0C/sog+iHYl7Kfnuuf6Nn0rvvlM2rdNx2ewAJJ
         EszQ==
X-Gm-Message-State: AOJu0YzOpmCjGJzRdg//sSBJBfjyS7ZdytqwXhKjptk0tzCiZgdNXKA/
	YSIUcNFP+qhKgYlvvQ/C1L35JiZhUOhmz2pmPnVu4vbbiDk18YPvUzNHLOjax2Y=
X-Gm-Gg: ASbGncuMb8jfzy0p8zpLGRMa7C+2x5duwLLA7GT90HX3ASbjGtf7AM55NhNVWHTkRNy
	8x1EQIov81sLIaG+mHNQeZmkpQOz1QzuiwNSnR1SXnJQKh/iAxszRG7xq1YXlhM0nLkgZqNSLIE
	Wh7QJjy1rcrPJSjREv8D5njDW5em5+uYXFK3PCdiYIy77OEkvE9nYzTixNp9EdGg/bbUBrjJ0Sa
	IHVz4hue03pSV3zqJYgKG9dl4vxSSOPNUCfdp1xK7JlMhKQpXHNgzkTvGHKEfEJmAZlqy5WK0g5
	aTqQSzQEGFdCfDjaoGAVJf69wMsMlbmoih8=
X-Google-Smtp-Source: AGHT+IF/g6bbTd7C6qwckxi2v5TGUNH2Ooq2NC0xGM9g91hQFRyQNdoBE7TwzGOd8cpZlq0Esto7cA==
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72e3 with SMTP id 4fb4d7f45d1cf-5e49348799cmr9524629a12.21.1740577759419;
        Wed, 26 Feb 2025 05:49:19 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd564esm328612266b.21.2025.02.26.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:49:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  zijianzhang@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
In-Reply-To: <20250222183057.800800-4-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Sat, 22 Feb 2025 10:30:56 -0800")
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
	<20250222183057.800800-4-xiyou.wangcong@gmail.com>
Date: Wed, 26 Feb 2025 14:49:17 +0100
Message-ID: <87ldtsu882.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 22, 2025 at 10:30 AM -08, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> psock->eval can only have 4 possible values, make it 8-bit is
> sufficient.
>
> psock->redir_ingress is just a boolean, using 1 bit is enough.
>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/linux/skmsg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index bf28ce9b5fdb..beaf79b2b68b 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -85,8 +85,8 @@ struct sk_psock {
>  	struct sock			*sk_redir;
>  	u32				apply_bytes;
>  	u32				cork_bytes;
> -	u32				eval;
> -	bool				redir_ingress; /* undefined if sk_redir is null */
> +	unsigned int			eval : 8;
> +	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)

Are you doing this bit packing to create a hole big enough to fit
another u32 introduced in the next patch?

