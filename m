Return-Path: <netdev+bounces-195268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52627ACF1FF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440DC3B02B5
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADAE19C542;
	Thu,  5 Jun 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JozWpcYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610E14A4C7;
	Thu,  5 Jun 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133657; cv=none; b=emUfOFOGF4mIPQHWbRSAeSFsXPXfLSl5Dx0RpRLYtskwYXGoniRscloixbq0sF3csfoznZ1TbQdFA2VeL4a64AF8njEwx0DETUoamc3OmJxkSmh632+enOGzkAyxyGqEi96uz62Z8G7h8yh291ReY282nNVP+vYXgG2ciVHAND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133657; c=relaxed/simple;
	bh=uV/SiPiH+VxV3hdqcIhcquwwMlIrac2VGP8JHLIbLtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsASHTLOXOZ/3Fc/ag//CPW/jXo4CyptRuToedVz3Z2sO2dCWa3K6uhAIK4+P2DGpcVTY6nUT74MRApU55V0SDhqJ+NIuzMv2et8jMC70RvhFzya69CmfLC5iElXCyNFJCXq7Ch+Xxe3dT3A/C9IVnUyH56n/eOxSF5UUzp1mkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JozWpcYC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso806858a91.1;
        Thu, 05 Jun 2025 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133655; x=1749738455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q28lIFu96QWF7S1IK1ZB+vzOB0OSf7nSsE4vmyIWPY=;
        b=JozWpcYCwGzfBAtLr+/FkFrwwiq/C2yLe6hm+4+3UhEbuEV5KCXhotXcY5z224Uc03
         3u68u+23WrqtlKwAOiL2twvA4EWZ5ZuWzn7Wge89uHcjY8E/9BZWTxY3Bm5RwiMs6NCN
         MA4oe1cyTn8bzZ29mgAtzn2ALMs+ZbIHGhZfPdV0zFscxR9dGOyP7ZSll6rJ65Gli0WD
         duMZoeZJp7j+RiZtH9b/voqGnlpyOMcBcsEWtokHBDBj8eBdnxoMGCoZBFr4YUrH5hBm
         8Vd+xhWFrx6xghIgsJuWU7k+ccAHK5D614857jFDw5eh0Ktvu4+89aJ6sexlVS9lrK/7
         bR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133655; x=1749738455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q28lIFu96QWF7S1IK1ZB+vzOB0OSf7nSsE4vmyIWPY=;
        b=PX+6+EVEKw46pP7Ta17z2Pwb3z7gWWQBBHp8S5J+uPmi3FGpiF/BHzS40gDYB/8GPF
         XinyIY4dysYKTLG8Y1Gth/zU75lKeZnzib7lsPBCWuJRlH+PbaRJ8nfeRb5GdI1Mh1V7
         ucf/xTf79tmQGlMP2Qsfaf8pA+shtBUHnnAehNEdN/VoeeiGE8344OaTylUo+sFmYzrq
         D3vkmWbN8/fLn6ULuBXg6UansJhHB8Ae8E0aMl1+Szcc+2nmuyL22GnsF3Xh9fvHsaxX
         0/LHqFG/inwrxE1ZVXpV+Gq1/XQn8mEwqu6QTY0y83I4JyFRTYWtVxb+aLn1MvN6V9oS
         ofdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56aGUMMXQKF9/g4ybMhWWLIOjc9mhOW5o9FdjfGlz/UhoeAfBQR6qMoT6lt4DA5iefrM9tXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8nfX35OEft+HWQvJI6KWgo9sK7HvglLgh+b/hQnv/oqbSMVF
	P8RpjQjaYfBxhVFwozkimYHm9mWq1qVtmA8Nl1vEbjDcNQPoWd4nKoIM
X-Gm-Gg: ASbGncsLGlXHv83ABjtEfS5MC53lHF4MBTn2NtwMxXlCC0Aduheo9yN0aTj9PkZAQLE
	eSIZ8l5OnxLQ5MQNUtKaoAWZOfuyKxVC+uUoNieR89J8Opmaxn0jBuKPNTTwpIcYAe6aVBIhXK5
	i5XWMgXOn0GqPtCz2jMMee0YKmdh77JbCATawDdy+sEjyKD2y/Aflzuc1/npVmba5/oGsCihP2l
	0ZqtzRzzKZUDfiMZrBCp2JwITWzcTdZcceGQ8hjoJaFR8pgQ96YELzW8Cz6HLWo4+5/+/A2K+ym
	Mo1xARu39taol/gqa6hr+w37n8vD99DnTUzroGmcXQjK2iXRXGw=
X-Google-Smtp-Source: AGHT+IEt8bxaWIw/PHmchHRiHaGxj9qQl60heZBunPGOxQIGpzlgK2FphKwmGP2vwSFRRoNu/4p9LA==
X-Received: by 2002:a17:90a:d444:b0:311:abba:53c0 with SMTP id 98e67ed59e1d1-3130cd12d75mr10796094a91.9.1749133655156;
        Thu, 05 Jun 2025 07:27:35 -0700 (PDT)
Received: from gmail.com ([98.97.41.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313315eda23sm1364295a91.0.2025.06.05.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:27:34 -0700 (PDT)
Date: Thu, 5 Jun 2025 07:27:30 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev <netdev@vger.kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [for-linus][PATCH 3/5] xdp: Remove unused mem_return_failed event
Message-ID: <20250605142730.wv5rsc4eg6ynwpga@gmail.com>
References: <20250603171149.582996770@goodmis.org>
 <20250603171228.762591654@goodmis.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603171228.762591654@goodmis.org>

On 2025-06-03 13:11:52, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The change to allow page_pool to handle its own page destruction instead
> of relying on XDP removed the trace_mem_return_failed() tracepoint caller,
> but did not remove the mem_return_failed trace event. As trace events take
> up memory when they are created regardless of if they are used or not,
> having this unused event around wastes around 5K of memory.
> 
> Remove the unused event.
> 
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> 
> Cc: netdev <netdev@vger.kernel.org>
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Link: https://lore.kernel.org/20250529160550.1f888b15@gandalf.local.home
> Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/events/xdp.h | 26 --------------------------
>  1 file changed, 26 deletions(-)

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

