Return-Path: <netdev+bounces-123981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DEA967240
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F4B22176
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EC1CD29;
	Sat, 31 Aug 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR6dhOUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C266A932
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725115817; cv=none; b=hMo3DfbcjVzXNlNjYH7BDnMCCD75q41Fq2Dk5MB2y6DB5fVxdeJkQobTUY4KbIUtP6m1Y8vn5d6saeGW4ka7hX9deBLZAd1H8PLZNchIb3wz9w+zQncCuVF2Rym18DC/IrcgOkxrXXu31ujrrsMMUYIa0iwIsED11/P+NbYOcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725115817; c=relaxed/simple;
	bh=Qeu3fReYfEWtmwNJtdyE8chBvN5yR41MjU5E0769sRA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=X1LNRyMBuJ+Cl21CjIUnxvzKfGvWDNNbTL+VmqKEyxXFvdIMgC1vzuzsC5yw4x3/AEgERN4qZGybyGr37/cv0uNfIHd7rGV3LezfdePxQLphzt1iiywDkYa81jAvVAMOfHoboxANFCSQhYBvhhJB2KGjUu3wB+i4W8ParpmJfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR6dhOUf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a80979028so1516811276.1
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725115815; x=1725720615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOebKLzNf5bEyIIjxDmPK62oMHCwzvqettQW2Pg3xBk=;
        b=mR6dhOUfgFVK9Z7p9dVCLZC0GvRnVqBVYJKFqK2baomKBjLBxJzG3T3pZBAMBR/j8b
         rVESKDF9KuSTc1aAT2buAxXJ2G8kqMLqYJv8BgI481ICk190LMQgd2jnMYHmuHn2VPPP
         VOXSwLCYJ5bLieRHiuigCInK4jNCulAhRO+Az6LUwGzI/nKHOF+i4rTHEhuW3Brc2kT8
         eJv+pWDqTL/jK9XE6Yu4EpyoRj5949wt3fFWrqDgCz6tf//r63JXQDT1cutBYnPieu/c
         HRi57al6o+2H+pXBe6vkPQWQr8oJ9xPZlIpxYsZC2ciPX5zfiWA5K90YOCPs2Oa4NMT3
         AXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725115815; x=1725720615;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fOebKLzNf5bEyIIjxDmPK62oMHCwzvqettQW2Pg3xBk=;
        b=GgP3Q64fSv2d6KdX9mjgClqEwYlPQEo6HiLfo+nN4Z0TBWqWSNWAtWhaL2oI9+ASlb
         uCLvRTBZxNBAQ7iY6euA9uvTGUehI62QjswVQK0qyl37iqO1UfpCXRNGkq3gIvCQa3yk
         uB4YdwN7TzdxCfMzU4Yjj61AHenojxX1VvKhopwdYqnsSFnSWwXADKEWgi05xyG9FXeF
         uD2KElhg1avKfj6ddFhNgMBYwQJ5DjXxAXOdzJjHmP0wU+FhODTvzbSlihjEFgSK2QoC
         vMAUrCrJkSXf2XxkmZkoLy6SHcG7Bd9LOhTNBXuZ838GF5WEJuRxMpg7pez3G4dGqTVz
         iwQQ==
X-Gm-Message-State: AOJu0Yw1meX53WSlgSc0Vklw1gMpIdd2icjiU/BvoiY4mUF8OfHw+2KI
	oHZxR2034ei6BFHbbB5LOBXnVvvsWOfyZCuNNKOSduuhv3rfvRG9
X-Google-Smtp-Source: AGHT+IFCPK10Sc/C69jjpHLAlPLM71WY6TQNHN7iEggFqkEtj7rUn5+n8x+Admc41cKc07BOGLiCaw==
X-Received: by 2002:a05:6902:2b06:b0:e13:cacf:5a74 with SMTP id 3f1490d57ef6-e1a7a3c654bmr5522681276.36.1725115815067;
        Sat, 31 Aug 2024 07:50:15 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9802esm23987491cf.23.2024.08.31.07.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 07:50:14 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:50:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d32da65bd85_3fa176294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240830153751.86895-3-kerneljasonxing@gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for
 SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Test when we use SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER with
> SOF_TIMESTAMPING_SOFTWARE. The expected result is no rx timestamp
> report.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

