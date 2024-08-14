Return-Path: <netdev+bounces-118447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F59519F6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BA61F23403
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D61AED3C;
	Wed, 14 Aug 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RU7lzRw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD483A29C
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635205; cv=none; b=FNSoHwuNRmpyQwrN6WUEH2os0MVW9N1rQ6X5bQlTzv1Cv8Zsn4jlflu593HoAR2/tdvoKFwX63b5+NMW2QFHbjNcAswIpQo8wY5xiYWaU2vskxBYg+PJaP6+qOpI1MusIdXxHEspm0wLB1kxTOWjidsywM/5A+Z4FXJAqiiJwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635205; c=relaxed/simple;
	bh=sJxo3o8K9KDeAWhBjPPWO10Ny3PWd7xWJyRQuyO8sf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9Mu0IAfTScPbFWSqjYfueez24ZynL6bnyr7zb+YSmMq0UxF+TJJW4y0anL32hrOcWbVaR1jcNi0Be9fhHF24CXCXfds5ppB1eCxESo0qts2WIwO1OJ8U9Ocq6G27rxmxVtLNlE9h3B3afCZUto0vSV1brLtFSKPdEuuXfnSYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RU7lzRw7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42803bbf842so64135105e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723635202; x=1724240002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEzhaGqc2uKIO2GIW3tkbCIZ74uL5DIJxcJ/qRFa2wk=;
        b=RU7lzRw7RVib9/YMOSS1v1KSNN7PCO6EECFFmDzIgnR6YwW4pBfaCIuTI/fUqcOx7k
         PXbZlyS8c3f3q9E8BTQ1SEPGqGMbJlyHWZEMJUr6o6XjWoxHFQtalOItfxlrvnsUCvKc
         eNc6qyHrYOvgFI6L1MaT5e1ra0W7ZcnNMbRVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635202; x=1724240002;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEzhaGqc2uKIO2GIW3tkbCIZ74uL5DIJxcJ/qRFa2wk=;
        b=ojCiWdwtRP0DqcEUL1bdNZ/NENTWU9yaSM94gFifKo5fY64c6DEvrwX1yDEkZcfrqW
         qYacUUEwxo6R5HlYjlE6I5b9qRUSeNaV/Pes2Pxh6ZqUqeImNB0MjJJAk6hRsCknFFy9
         ev+RoCOHcIBnN/Jl7F6UgrPBiSc5NDPZBsby7zdCNiOPWmIy/V2xb4oadGK4PePRJVsW
         uKTZPZE/FE272WFNJl7scRYMZuo88pDYxrTuUPlYLQAO+0hRECEHOynODgREejBKG07p
         40VSCvi63+HtwbCh3LK7m/KXm0L70dQM9ovNln4Jqsv3KGGNu8ig7MnTd6ogN2KUPc4O
         +5bQ==
X-Gm-Message-State: AOJu0Yxvyu6p7hBOEjCTCnckC4IhKb2Ixz4sn8jGXJzqRUCYyVRjibod
	6NDJxvah6COKTNI66+zSya/XwokcIbpBHMkDoakCRieuy6byjcMhTBNZp0VbpCA=
X-Google-Smtp-Source: AGHT+IHZRC7tiMJ9Hv2wWUkB/F+PTMZkEaHi1EnDmtBDYexvU24sdPR3Mx6Ff6UfCuT4fjOrRyIftQ==
X-Received: by 2002:a05:600c:4706:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-429dd2365c1mr19467345e9.11.1723635202092;
        Wed, 14 Aug 2024 04:33:22 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429dec892c8sm17668235e9.0.2024.08.14.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:33:21 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:33:20 +0100
From: Joe Damato <jdamato@fastly.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com
Subject: Re: [PATCH net 1/2] ionic: Fix napi case where budget == 0
Message-ID: <ZryWAFkWSmp3brjE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Brett Creeley <brett.creeley@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, shannon.nelson@amd.com
References: <20240813234122.53083-1-brett.creeley@amd.com>
 <20240813234122.53083-2-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813234122.53083-2-brett.creeley@amd.com>

On Tue, Aug 13, 2024 at 04:41:21PM -0700, Brett Creeley wrote:
> The change in the fixes allowed the ionic_tx_cq_service() function
> to be called when budget == 0, but no packet completions will
> actually be serviced since it returns immediately when budget is
> passed in as 0. Fix this by not checking budget before entering
> the completion servicing while loop. This will allow a single
> cq entry to be processed since ++work_done will always be greater
> than work_to_do.
> 
> With this change a simple netconsole test as described in
> Documentation/networking/netconsole.txt works as expected.
> 
> Fixes: 2f74258d997c ("ionic: minimal work with 0 budget")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 3 ---
>  1 file changed, 3 deletions(-)

I think fixes may need to CC stable, but in either case:

Reviewed-by: Joe Damato <jdamato@fastly.com>

