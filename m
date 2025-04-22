Return-Path: <netdev+bounces-184735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB2A9710D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB74173E0C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28F28F94F;
	Tue, 22 Apr 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+LK/F+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720D2857C9
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335953; cv=none; b=Rsau7LRjqXgu32aUQ+ni46je2k6Gh3A4MXsXuFtYtJmJqXadh3XQHKlrdbK99h9deo9d5AGJv8KUipPFS8QAn1oBjEY5U7DG1mNyfQEUKtF7mggOFz56svXvSUCEcrqiStHhHKN71nD3goMO6lL5WJAwzv4m66ZPWA59SoF8jf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335953; c=relaxed/simple;
	bh=3iLZ6/Xk+KIMMqvsw3XazeI9R0wol8DQUREYt1qVlqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH+5d6HRsDwCYsvPkUkLUzX56bdBP2xhQ4kNV8LJAvHoDBEdg/bbUopJE2O0adS5jPwTy8mqdSodwv60awJOBhOD22XYR5qJruKgSfhbANT5ehiz0N5yu2bYSVIVSSuqcw6eDf7uyCcUof97pElO91KbrJcBbVDdE4of4c3ifY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+LK/F+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30820167b47so4928822a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745335951; x=1745940751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UI8UekRx6SzQBgHt6Lyjt0jwFeKfomPbkSxvXHBJgpk=;
        b=bG+LK/F+g+ZzTh2RxFM8psLq8XphBOS3RJ9/JIN5CCbTCUHuinkGSpzWWFaep2FGAz
         xC/JOEiiQ7mXgRLvDI6h3nNA8BoypzbDzG1UEmZWtcI+BjA3g7Cpzrswb//amwGWXkQy
         oB+7QRInmHTjSkGA/Q/n+r2QoYQcoZZMrOW2iItmasdQ3tAC4+IbSi/lQxMZ3GVXbTfo
         tc1/BZGo2Wq6qycHoJr9XFaaKh0P3UyzroRCVpdIsL0/UZeoP+XHTOBq9HAf47YCqYdi
         XAcP+G0YLuBaVdvgtkhMmMfn0+Nusq00LrPCHSsLP3A9OgJ811LLYew4PWONlTSbuuOz
         hHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335951; x=1745940751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI8UekRx6SzQBgHt6Lyjt0jwFeKfomPbkSxvXHBJgpk=;
        b=S1J3TzLIVw8tT0eMy3gyBY+EtbHkmp7i9vnUztu0FABBC02U4mWxDiuBa+YM6079m/
         sP/DZxvAwswUUBdPLG/1kez2AHsgiFPyegC3YFKDEFlMoaYMe5k2ayN+kOgcVAK3lFPz
         E3wT2a49QCEIco/aTjxS+rFd7+uie2fqjUe0z3N05VfciERM3iGmEkjoACfLpJ8Cce5/
         I82LxDDX3DHr62Um8Cb3ADC5gjuddKYhhaLOb/Bp22PNnism4/eniBWfSlCcxkrPqm36
         n8Bp8QGEObruav8AxGaXHv4B4AaNCUWqET1cym14as7/XxGh8Ud7HQncg97jzw0p0JOe
         KLfg==
X-Forwarded-Encrypted: i=1; AJvYcCV2irU2kaM45C8rVdMzp5jepy2DpQA0zNp8spDBRT1Up8ux4Lwd/xRimbijpaeaDjRhbgaIjmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssNSmWv6caCM4kWgY7tewEAx7ktZ6MHkczMuTN4gFfEeKDBp5
	9DeHHaqAHeSnUXA9QV6XSNYavovf8hwdFxwAaveYcRI/q9mp79g=
X-Gm-Gg: ASbGncvn2DLjQUp0DTxbjIsBxNPZcBbM+h4SOBzH5CZhCV4SwdLh0aa+sboo73CtU8V
	c2V3xXm4vejLZiS2YHrG3L9lmzOG5dp32jDT1Zjp4JvP+eEzJlqfyKhcLoZvytokwrNF7rYwLaU
	xNjodHk+uZQryenqKVvMAQUGDTJGWRk6Qc6f4v7etCGEdBK7XqdFxL3t6gdec3wFK9S5xNm0ENO
	7r/XvNkrwnmogmpcrF+qjjL02Y4d255nxBaq9GLLAiPUKAENsbkd7paatwE592OBU+sKLr+5EB7
	305Mrvg9BIZ4fHhrXO0nzT+Qqkx7VO4TpT18jSPx
X-Google-Smtp-Source: AGHT+IH7/yPJ5G7UeRIJD3HBrBRT3MrIEYXbpuzbL/4t8ofDIXOhVhDmPm8YHMks3ZWcvc2r/K0xUQ==
X-Received: by 2002:a17:90b:568b:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-30879ab0397mr22843432a91.3.1745335951092;
        Tue, 22 Apr 2025 08:32:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3087df4dfc5sm8783423a91.32.2025.04.22.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:32:30 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:32:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 07/22] eth: bnxt: set page pool page order based
 on rx_page_size
Message-ID: <aAe2jaAUi0-deSeI@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-8-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> If user decides to increase the buffer size for agg ring
> we need to ask the page pool for higher order pages.
> There is no need to use larger pages for header frags,
> if user increase the size of agg ring buffers switch
> to separate header page automatically.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index b611a5ff6d3c..a86bb2ba5adb 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3802,6 +3802,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>  	pp.pool_size = bp->rx_agg_ring_size;
>  	if (BNXT_RX_PAGE_MODE(bp))
>  		pp.pool_size += bp->rx_ring_size;
> +	pp.order = get_order(bp->rx_page_size);

Since it's gonna be configured by the users going forward, for the
pps that don't have mp, we might want to check pp.order against
MAX_PAGE_ORDER (and/or PAGE_ALLOC_COSTLY_ORDER?) during
page_pool_create? 

