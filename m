Return-Path: <netdev+bounces-56446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DC80EE86
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C651C20AC5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5C73177;
	Tue, 12 Dec 2023 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juN+FD4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50E8F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:19:15 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5910b21896eso1082948eaf.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702390754; x=1702995554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+iG7jHdvIfqMzPDtzAk2IrM1w134VeGVNuUxajbE2c=;
        b=juN+FD4mqNLHRSGKN9iw0OFgvQ6U608nekZgi3Pqj37GLC1KNuSrQCBLa+1bFqAgf9
         KKEr5DNZHOagoVpVF50W1DZQ2+xIQOxAxhfDqXpeHPPq65nKqrR0NGlFanz7grsbab41
         qFHOA6fuli77wwyltZnb9uoIOYBGyuh+ziUSxHO+c1nh5Cd2XU+iRQao75jiTejaYYr9
         oKx+Ue5vtqg/81iUwbHt3Pmz0352ZdwF0jYHDFpb49dYiWYFlgGA0jmCcaUZDdcVURHs
         XIknO/wxYGyKYumZUzeAvq8ySVZIi0Z+GsBk1lwSI64hZszbv/XlwwZ9mmt0rI/d7WHp
         JJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390754; x=1702995554;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+iG7jHdvIfqMzPDtzAk2IrM1w134VeGVNuUxajbE2c=;
        b=SRoFXnaBAKPqZTMMbFOB2VZA5FaxPyHdQmj702tvVi38RRSeDMdtP/k7oC/A/vdrMi
         3DzFMYOwXf3Q1omaTSo0l6tMvumr8D9banBuKjQVuD/DQEA9W7LTKvxvkLQSJTGUwEzp
         czdBLSHdgeoNJgNzzFtpj+wvkHL0IoAJTTGpm6gSSTJWAITXDqphVKv+keaAONt9MRmd
         NraCCRilMbpfOLgiVauTWECLrUoFiRuKnxzUaCi0/e6S8Hc+YkI0fh+NSJPUWV2NpSNO
         2oB87ixs7+MJu7iBmhuo7dkRavsqZH1XSZcjwQJl6t7lhXmvJwoRLaDmfCxTfrUr8ZKV
         1NJQ==
X-Gm-Message-State: AOJu0YxWgu9uePYpF5mRuP7ie/dRASd6oYvB6EV7wX17Uj6gjgmlczt6
	1iXJldixg+uWClq1QOO2/lQ=
X-Google-Smtp-Source: AGHT+IF40F1NYE8FXT4TNUmVADdoDwKphVAaLMi93H2Iq5OJgyUHIUl4txCKJz5d/VxiNTYr0Gkz4g==
X-Received: by 2002:a05:6359:a2a:b0:170:17eb:1e9 with SMTP id el42-20020a0563590a2a00b0017017eb01e9mr2944301rwb.44.1702390754082;
        Tue, 12 Dec 2023 06:19:14 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id l2-20020a0ce6c2000000b0067ac2df0199sm5291qvn.128.2023.12.12.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:19:13 -0800 (PST)
Date: Tue, 12 Dec 2023 09:19:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65786be1539d6_27f3a52943@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231212110608.3673677-1-edumazet@google.com>
References: <20231212110608.3673677-1-edumazet@google.com>
Subject: Re: [PATCH net-next] docs: networking: timestamping: mention MSG_EOR
 flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> TCP got MSG_EOR support in linux-4.7.
> 
> This is a canonical way of making sure no coalescing
> will be performed on the skb, even if it could not be
> immediately sent.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com
> Cc: Willem de Bruijn <willemb@google.com>

Acked-by: Willem de Bruijn <willemb@google.com>

> ---
>  Documentation/networking/timestamping.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index f17c01834a1230d31957112bb7f9c207e9178ecc..5e93cd71f99f1b17169b31f2ff93e8bd5220e5cd 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -357,7 +357,8 @@ enabling SOF_TIMESTAMPING_OPT_ID and comparing the byte offset at
>  send time with the value returned for each timestamp. It can prevent
>  the situation by always flushing the TCP stack in between requests,
>  for instance by enabling TCP_NODELAY and disabling TCP_CORK and
> -autocork.
> +autocork. After linux-4.7, a better way to prevent coalescing is
> +to use MSG_EOR flag at sendmsg() time.

Good catch. We could even remove the old deprecated suggestion, and
drop the versioning, as this Documentation ships with the kernel to
which it applies.


