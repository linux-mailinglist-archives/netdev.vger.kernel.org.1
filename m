Return-Path: <netdev+bounces-106409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45139161CD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D5E1F21B64
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8D148836;
	Tue, 25 Jun 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dceZs8wx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D0148838;
	Tue, 25 Jun 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305924; cv=none; b=QEW+Ij/2BTc6FcNF6hR1mWRHXt6DlyGP0AQu0tYE2QVW4tKWBPxix7nqzYL9iL5cYSe2BchmB1pRrvLgGqj+vaopc1nCQTakKwkTlOIu/iCcQIvNNHmj6nKvdgQ/JU2TSnEWlqyLxE6rBKbb/6+QLVi85fCeIR7QcvSx9H6hiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305924; c=relaxed/simple;
	bh=WU3VqLGsBdzfEJYnnltbRrjlPOjaabGULDshKiXcHi4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KaK17v1tImSoZlv5ydUdtLDl7F++bgKbmtbsDkDit/qz+wJMdowNr54selBeM3P44dlFH3fzQ+qGvEqbJG0/CSnzCcR7RZLBnL+LhDxws1na09ZjEsv1d1e5pwF5A1gmbqgHLR32gBVoX2lmn7qVQLYeFEwO5hMwOFL5n1g3q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dceZs8wx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c0e7ec66dso3939185a.1;
        Tue, 25 Jun 2024 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305922; x=1719910722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkxIMZ5HlzbFeKj4Inli7PFThpXhbLBIuQGVc7VbQA8=;
        b=dceZs8wxrwfjHPGMnDukhyh+1SqN38ZHN95AUq1jeFLfWBMsE8IKGJFJqM+W2s7wBL
         XzdHIZxCPwiO/XQO2a4JPDkzaneElW5AS66qYsBXuGFqO+28slHyRXNwqEq0dGMWYThw
         95OetK3FSyXaZ2b8HupX/ORdBFlr2fMu/dXCue0DYR0CdE8sqIMeZ/LPjl0+qSSqBgcW
         xgYGr2KLTWJjGdAoVQyEB3vccf+DTAuyxuJ+wNbaVFcgW947ZqcaDQUCxFtj3PJCBCa4
         5BpeRSA9Y/IP070repE8bvyMBx+D3a2nNDCg4wloSnxJ5N8Ar3j4Awk8lqi+UkbYJr//
         l1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305922; x=1719910722;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SkxIMZ5HlzbFeKj4Inli7PFThpXhbLBIuQGVc7VbQA8=;
        b=Gua14RJf2aTNRXf3Ap2ccfR63hbwaHzR9lWFjuZ0MwGnNKLa0nHmQOgQsaVMJnAWjs
         umB3gpwra5Mk2aq8VUZGwH9gokZIBxMRM8prGlU1q1o2XjNnPLyTCHyqsLYbssSYKoUS
         KV4LJ+ita2Oo6dZ3Nj/Dz0zqQJBV9PxdWAQ0W5dPs0FO/pTa58lvyt538lMTP8uohY/p
         3mOppeCoG7luNp7DyQ5jutZsnH/7m9gWS4x2G/LLARm+HkeitG0Q4kAhU5D2LYk3vXP8
         9AU59TdqqTqZQKNa77L9AptnbVnc9+AkSZHxKL2S+9id3ra6oGYPlOo/mZSKhGa/k7nM
         bfXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKnzug0WV606ixOrmqygn3P90xaMn1+4P26JybdfFhVt9N3hYfjE2iv8iSSn9lrNDL7XxxkZtuFDmWW77D6GSxB16WSqBXpL8m4DvV
X-Gm-Message-State: AOJu0Yx+MkbFBt6t9v1eRD1sJsGN57/5pWvQ1NmzhfGhSo070C483RNj
	4cR5GZSat3akjj3LKwdnlDaP6G22FpGIx32kuX8j6aOf1/pzS6BD
X-Google-Smtp-Source: AGHT+IHWieQ9aEO2MzHRJIbaY+BRCmR9i41EFge+jIHv9bN25N4CAo5jWQvoUBKHeadHCgb8FTyGCQ==
X-Received: by 2002:a0c:8cc6:0:b0:6b5:70bf:78db with SMTP id 6a1803df08f44-6b570bf79e4mr9490036d6.55.1719305921579;
        Tue, 25 Jun 2024 01:58:41 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b536d02d65sm27975346d6.26.2024.06.25.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:58:41 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:58:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: echken <chengcheng.luo@smartx.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 echken <chengcheng.luo@smartx.com>
Message-ID: <667a86c0f1552_38c6b529456@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240625083324.776057-1-chengcheng.luo@smartx.com>
References: <20240625083324.776057-1-chengcheng.luo@smartx.com>
Subject: Re: [PATCH 2/2] Add UDP fragmentation features to Geneve devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

echken wrote:
> Since Geneve devices do not support any offloading features for UDP
> fragmentation, large UDP packets sent through Geneve devices to the
> kernel protocol stack are preemptively fragmented in the TX direction of
> the Geneve device. The more computationally intensive encapsulation and
> routing processes occur after fragmentation, which leads to a
> significant increase in performance overhead in this scenario. By adding
> GSO_UDP and GSO_UDP_L4 to Geneve devices, we can ensure a significant
> reduction in the number of packets that undergo the computationally
> expensive Geneve encapsulation and routing processes in this scenario,
> thereby improving throughput performance.
> 
> Signed-off-by: echken <chengcheng.luo@smartx.com>
> ---
>  drivers/net/geneve.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 838e85ddec67..dc0f5846b415 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -1198,10 +1198,14 @@ static void geneve_setup(struct net_device *dev)
>  	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
>  	dev->features    |= NETIF_F_RXCSUM;
>  	dev->features    |= NETIF_F_GSO_SOFTWARE;
> +	dev->features    |= NETIF_F_GSO_UDP;

UFO is long deprecated. Nothing new should advertise it.

> +	dev->features    |= NETIF_F_GSO_UDP_L4;

NETIF_F_GSO_UDP_L4 is included in NETIF_F_GSO_SOFTWARE.

