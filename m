Return-Path: <netdev+bounces-197227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90DAD7DA0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63FD3B5B3A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5842253B0;
	Thu, 12 Jun 2025 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="p3lIRIFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAB222593
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764100; cv=none; b=iS4joA3rYGEeLzYX+z9zmCFQkyXJgWsItRwT4U8Y2ixIV2MPx4HOUc5YLOCPkmKPzUYIXmQLdvHiimFiruUdw/NQwJuTnQRwJBNe+AE01F0SjLqrHUtYu0tYlglg4H6X+WKtEmhevQBuq+gN9rCY3XyHXluMkrcpciNROurlfBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764100; c=relaxed/simple;
	bh=G6nfH7qtVb0luwT+qydvB5nbLQ+F+r7gI5/wkQOvhTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq1fbwKksOQN+AmXZqb2xwHQ66h1mIDiW/UVS+mAXKTdfB61nBq5BBZziC/XZ5aE83b3EnN/UBgXuXveWNtPkT0Trkadu4IEPZtw0f3sCtVDEkhiY3spfYdk6nIa4+exbJgpjpOHg5j/udmIDfObZYx/s5FsG+PPvLhaIsKzBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=p3lIRIFM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so1220172f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749764097; x=1750368897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXxi90nBsj/LCd7ci/GNah365lLC7/sEG1Td6aOxQGU=;
        b=p3lIRIFMGVFgc3fKfczr543g9rWDIPimOxHUkk75RMt/6RpdMFLpd79zDSmvBwWRuQ
         dywJU8iaB23hnPDcnQcJvfWoFgOO4ZilLo9zdSXAToF91BxfQ3Vxz5PuDApFFCN6oS2B
         09qHy44U+9FNbBv1YoNJGUahASSa8I57eQigPFAvfv6hyEpr4RylJAfEQ1tdvArFnnuz
         njMNFXfkgu1wyJFY3S9cGaqO+CeeyY4D5basr/HTgPD8e/t7ZPTv/lJTH7fyab680+b9
         QoJxUvj9a35+D2eadH49GZlXvRlow8sx66XkdLO8gLw59+SaVIZzhslnWERC0u2kgRJI
         B2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764097; x=1750368897;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXxi90nBsj/LCd7ci/GNah365lLC7/sEG1Td6aOxQGU=;
        b=tNkAkRJLXV4lie7uwda7ulRWSyp3vr+oPWLa68jUz3Xkn6jiYxaNCBFrYZmTGrBIY+
         eGJLpBhLMY4BY+JcbNC+Ulix2K2jAUWKBnEOdp8s7zREAuf7dt7N9n5E+hpOhD2ACV9o
         NkTzKTSeNQvSNFESTikq1WkPjwOr0UzGuiezSHqJSuojF1Wys7LbgQUStaO+1FnoDRl8
         1sMikNQ9rJqsGRdI4eMNA3Eokz75oDw+lkmhogwKPQmgP0EOxvWFcnajmL/OuZ3ae6el
         N+I0/tE3De5GQGRYaP6/TjCTKW4o51BUzQX3gx6IWHI9mVoHVWEtnqwbgYLdlAEXnBxv
         rm9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0+v/f8s6+Jt6yfJ0hIfGsby+xcHd+JG+AKEy1CM6vQNBFJLWWpNNGo3GyPe5em0ePKpD9MBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4V+qrOwj4S3AsPVVwW1IkFNFRYphmg2RFNaNWFzdPAiWzHxTf
	dSBR8K2JiKZ9kPhAlx5YJQG18hJq6DDQIz9YyQ3F6/aZQqQ5Oq7cmbwTEolRgKRyo+0=
X-Gm-Gg: ASbGncsT9eZ4Ytd4zoLVKAnkfnJJL/Jgf+n8grg6NKI0h7Qe33Xby9BLihxqGftZpYa
	jTD9/Hnv0VAds2wWEEXP8tDUbg3EuCMgtTsBO0p2KAc5977l6dlPQEPVySa5duOir1HtZnn1RrU
	Qq8291A8LBimyfzEJo+k5Y+NFyTAg7u1FOJImTPpoB+eUbvZPJU6HTFPLSxQI7o4kLeO2riMoBs
	/P3ZMVP3pd6VTO8XzF2PyI0+KWo2gkYpijoCghqC36brwG5vuTbDkBCnNKZg/bmABoWo0lD3qNZ
	9Td3gO66C4Iiet7sLW9gIXwxdz5nAYHq1gHHrhkMZbgqbWLEq0gDvAtTpkJI9VCaNjs=
X-Google-Smtp-Source: AGHT+IFYivuOEOzEuBZvFgyddD6nwstSYFH0zmRdUUpwGG9awwwfsQ9QAvBeu2Iky1RSiPZCJ/uCyQ==
X-Received: by 2002:a05:6000:1ace:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3a56876be36mr546882f8f.36.1749764096932;
        Thu, 12 Jun 2025 14:34:56 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e09c21esm32764095e9.17.2025.06.12.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:34:56 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:34:53 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next 2/9] net: ethtool: remove the duplicated
 handling from rxfh and rxnfc
Message-ID: <aEtH_ZTQYKO_ubk1@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	andrew@lunn.ch
References: <20250611145949.2674086-1-kuba@kernel.org>
 <20250611145949.2674086-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611145949.2674086-3-kuba@kernel.org>

On Wed, Jun 11, 2025 at 07:59:42AM -0700, Jakub Kicinski wrote:
> Now that the handles have been separated - remove the RX Flow Hash
> handling from rxnfc functions and vice versa.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: ecree.xilinx@gmail.com
> ---
>  net/ethtool/ioctl.c | 57 ++++-----------------------------------------
>  1 file changed, 5 insertions(+), 52 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

