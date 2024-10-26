Return-Path: <netdev+bounces-139340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63179B18D1
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C9E2814BC
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA47182B4;
	Sat, 26 Oct 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZqQFtMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A54208B8;
	Sat, 26 Oct 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954493; cv=none; b=BD7cDm9YZFewXI9LxMTJUMTr9Y15ZApV3+rGSCx0bXy7ML97hOF/0xSxPcREG57nz2zaZrQA2BUmu3QStrlBAB4is4d3QwI4kgKLgCg9kztXl/HpxVGgOhElt9cy7sY9vCLeGqT/Lqy3i+3CCAIQMWdupq6nkGeH4269jd8i0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954493; c=relaxed/simple;
	bh=viih1m8/p5TRLElx/VBw+mf8cOACAUXWUvv18KkGO88=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nDvxQdYGB7iJXyTS5DqNrVXns3wnrZGtYGcf6B1zIV5hk4xFsg6s99e9U6r7h9BnH2CVwqjWjsVSscJHKF8S1mz5B5rcK6s62GQuPZxW2wv7VD/Hcf5hMZzy6YIW9BkFj6uDgFJOtJV5GNSYNK5q4pgEQtwoO9F6EDuJdzPqSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZqQFtMI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b14077ec5aso370549285a.1;
        Sat, 26 Oct 2024 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729954491; x=1730559291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcgF/aUxNbbjw4zD8BNREKYWrP04wlH7Vc8wRsAS2tU=;
        b=iZqQFtMISG/NSKgYdo2rvIYtD7W2rLPI3yfwD6rDQO6JUv+sDfnFt6dzqYBQU1dSkr
         6mZ3kx8Ep3jciY2QxKd0JHQkvtJDpPxAxY/X0ITzGNAeCcXOyLD2iScI4y/p1DsGDncS
         uJvLjsxt3uOy626gqaoE9FP3u3AD7ZXntYDheuLCct2nttb2Y1CtLrZs25vzEN0tNyXn
         pqZW+cVI/YxBmKScN7A3NSyVd/zzQkiLU3CmL/g2mbQYkrImzXkoftAuCCkzSMLaQd5B
         TW3MQXTAkRicNt03gVJdREnGbmNKWK1NxFV/FEHO1kn5ZwdecPu2p77VYSiUcfsrLgr+
         a1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729954491; x=1730559291;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcgF/aUxNbbjw4zD8BNREKYWrP04wlH7Vc8wRsAS2tU=;
        b=nFp7hLYpG4dteFgEIKc1P1zgcmY3xeLl5J9QKKnLTlhoJLWHOvIz5Mep4bCtQTT3Ta
         xXldZu/F1KnY47gySe6VZryO2OBx8UpIawXd+ybFVKwlv8DiO2MEsGMvHa3OWktRFaiR
         J4pCc0Jkk4RnrVFwJlwR7Ngd2RTwYi4a7maUvnMjwmmDyGVH9WOpBKZoxbiHZ3l/wHa5
         XiTxNXDJoKyaQaxhrm9w6aA9TadCz2fMxmvIoHPs3ANzWfH6SOgU5UPLVfyAkjTf+ttM
         OdbmiBaXA4XefT2KK/SgWSqafhdf9HUt2cLHLdx8n+wQgyI4Vh71y8pdF6Zw5AykvGsK
         nl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+6PDr0HzmWgFgGNd3K1CsLLT94Jq5UPW8cXewsWBQNyB2b8GSSkvgjyx+37jjox8XO5p1KHFY@vger.kernel.org, AJvYcCXbYRDXtARKioaH7vIKhK2OUP0idLTE1qkggTGfUB77na8O34Jkl7DfRPBD3rVUgPhoyvkX/u2S3ZqqNEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9yOOlfyvXHT1sxcBWGT6XRQDQJtrlbTB/jRMjowu8Jsff5sS
	yij7QovjgOvESws0FHt1qmEe8HQewZQeLimpPK368adqikHs5n/w
X-Google-Smtp-Source: AGHT+IEszTqZyo3lypN6VMlQcfaiGzTXehBaGJCZqxevexYNTNti8lDnp0U+uk0YKAVRdrhq1kJ9uA==
X-Received: by 2002:a05:620a:4410:b0:7ac:dd88:cc80 with SMTP id af79cd13be357-7b1865d33c2mr1636903685a.8.1729954490735;
        Sat, 26 Oct 2024 07:54:50 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2aac53sm156065985a.59.2024.10.26.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 07:54:50 -0700 (PDT)
Date: Sat, 26 Oct 2024 10:54:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Gou Hao <gouhao@uniontech.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <671d02b9a3601_ac9fd2942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241026112946.129310-2-thorsten.blum@linux.dev>
References: <20241026112946.129310-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH net-next] net: Use str_yes_no() and str_no_yes() helper
 functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() and str_no_yes()
> helper functions.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/core/sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 039be95c40cf..132c8d2cda26 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -4140,7 +4140,7 @@ static long sock_prot_memory_allocated(struct proto *proto)
>  static const char *sock_prot_memory_pressure(struct proto *proto)
>  {
>  	return proto->memory_pressure != NULL ?
> -	proto_memory_pressure(proto) ? "yes" : "no" : "NI";
> +		str_yes_no(proto_memory_pressure(proto)) : "NI";
>  }
>  
>  static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
> @@ -4154,7 +4154,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
>  		   sock_prot_memory_allocated(proto),
>  		   sock_prot_memory_pressure(proto),
>  		   proto->max_header,
> -		   proto->slab == NULL ? "no" : "yes",
> +		   str_no_yes(proto->slab == NULL),

Just one opinion, but to reiterate from a previous similar patch:

I find this less readable than the original open code variant.

include/linux/string_choices.h mentions three goals: elegance,
consistency and binary size. The third goal could be an argument for
this change perhaps.

proto->slab : "yes" : "no" would arguably be even easier than the
current form, and a conversion could similarly use str_yes_no.


