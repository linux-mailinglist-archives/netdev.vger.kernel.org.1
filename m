Return-Path: <netdev+bounces-119555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40389562F9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD88282381
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5214AD3D;
	Mon, 19 Aug 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usv7RBmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0814A4D4
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724043604; cv=none; b=najuNFYPZ0HTvxEKGp9GXMAC43Ys56hleFY4+D4QTBqXllVFcTMC83zGCtZXDGgcXjXGgtQ8b3wFXUYn3/PecniasyeKvjOv5SW6DNgUetex9dCwAr1CEy7Khimz5k6RZuqc0wcHmt5Rk/Ma0bklUHcvnuK1HhUY32BgChxsE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724043604; c=relaxed/simple;
	bh=DOLL5PO3QkpVetqdHckQ0XqsmBrgO73sau5qMOfsl9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV9IyeffNfKKEyyrryG+g3Wjn2dPwHJTY4NPCJu1e9cfe55d6z6QjuG45+cFL5bkD1GL1QOIC10fAB4QHbqQScN6bNe1p5RlMzOu1rdSrYQ5NUG0VCozafweWLt9Ig2AkDuZ2uIr1IVdAJN3qtbTPAwwKWu9gWa9fyi7WT5Dzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usv7RBmR; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-267b7ef154aso2581500fac.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 22:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724043602; x=1724648402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTyUAN2wiN1V5sRFAfyBtKJlxItuozFV/6OJQeOAyWE=;
        b=Usv7RBmRaS+bWIoAZljRKfLiPHIhwHL9lsYK+YcsGytinAIWD6ueZ3as8W1s053T1l
         X3zfYZuhrfieuFkPqtjXkiNjEMBBzTh5zKYJtsKi5rjOLg6sJHHC5qbUaj3eiITxjFMZ
         o3NGMndW3E8AaWJpE1WuXUihhLWEFnpyBhXsF4FnY2n/UMrJPIudXYGJwBUTtjSnGu9g
         EjlvbKyAoVsP5bpKo9hh797w4bOHDuGiHzYFN29fp23rrbBeD+hRM1h7YBWzouN7j6CH
         jcvGr3SDJahdY4kQ1e7ehx/rhXiHANDM6vcvHq27216hQNfQeN8P4Jj4fEMepRDQbL2f
         S9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724043602; x=1724648402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTyUAN2wiN1V5sRFAfyBtKJlxItuozFV/6OJQeOAyWE=;
        b=qdGfAlSmJ+DB7qw4bW+nE4J6cNjLGhKAvzjsKiEU5Ip+0nN0VdVlaNqpFhsLX5+Jie
         YGv3XZUwvttBcela1+lT4NzC014K79XaMQR7ZJ+CJaicVZLL1/bQ8cIGMv2yuXORXnJw
         TXpyumYH29GZr+BlxTGZFV5mHelCofE/0hN9xlqCbl37wV2o33bR969WS33YQG/fWwz2
         Rtan/QOqIiiN346LLrFs45Um/yOdsvjkfCE0rimNyWdsMI+Z9ygYlLhtTiFH0WH+Bnoq
         3yZY9+wyHcvbLrbrDswjtx6v0tze0qnS3SXJtwi0Sh8TFHI86kUwbHClQSrqgPxcWlJc
         6z7w==
X-Gm-Message-State: AOJu0YxeLLnwOD/40HgEuox9ZEhXJw7iVubwwr2onLFkApmeGRq2eC7b
	4MT4wXvNJteN9AxYYzk7KCPgCbCOxFgJMeRA5EFArPFoIUnlVFyP
X-Google-Smtp-Source: AGHT+IEnJyCV+24lgMikd2ZK71FvIerYxLeiPrN+m8fvc8rMEETl28uWF6F6AUyUNZ6Uh3Nkjc8UgQ==
X-Received: by 2002:a05:6870:b88:b0:254:94a4:35d0 with SMTP id 586e51a60fabf-2703426ae4amr6911847fac.48.1724043601969;
        Sun, 18 Aug 2024 22:00:01 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:a389:123c:83ee:f652])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1e3e3sm6129670b3a.179.2024.08.18.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 22:00:01 -0700 (PDT)
Date: Sun, 18 Aug 2024 22:00:00 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next v3] l2tp: use skb_queue_purge in
 l2tp_ip_destroy_sock
Message-ID: <ZsLRUBb/+E+ygTxS@pop-os.localdomain>
References: <20240816080751.2811310-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816080751.2811310-1-jchapman@katalix.com>

On Fri, Aug 16, 2024 at 09:07:51AM +0100, James Chapman wrote:
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> skb_queue_purge instead and remove the unnecessary lock.
> 
> Also unexport ip_flush_pending_frames since it was originally exported
> in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
> l2tp and is not used by other modules.
> 
> Suggested-by: xiyou.wangcong@gmail.com
> Signed-off-by: James Chapman <jchapman@katalix.com>

Reviewed-by: Cong Wang <cong.wang@bytedance.com>

Thanks.

