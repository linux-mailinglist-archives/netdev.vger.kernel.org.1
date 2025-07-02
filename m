Return-Path: <netdev+bounces-203101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1BAF0831
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB841C0453B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991F6F2F2;
	Wed,  2 Jul 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF3dY6Es"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D93C26
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421467; cv=none; b=jUaWmOiA9ml1w8/NaGfsf4jzjK00/hDVvDy/owou5QPlTN6w43412hC4jR2R+BVsfUcMIF3C+OIb81fX6GSQgxRyE8rv/dPtHU6vsSwmWrJGeMF917HoNuXEUiPh5siTC6KvjOJLTlDJ1rUuk0GsPUUMPC1NKZsAgtUrx0O2KL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421467; c=relaxed/simple;
	bh=cFFcBlQNl5BO18LLVynByenciNWzHkVZIR8XGk05ijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paSxbodsFCMev6v3kqAUEoYtO8XOKU2vNb89IgFnkuGMFSdOKGruAQyzgeM0ktBNokhsyIGeqmKzORcCV1TTltQNSsR4dzKdZBbAlfirVFW1wVei7dXl/vx7xE6l9sDvF/l8dNE/2tOdbfTBj+Cw0+dCAcVkgsenVbdsylvsfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF3dY6Es; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so61227395ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751421465; x=1752026265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePiW7aqYD0qALSKskjMbzEKCrjQTfN8/Jlp9bJXKkFg=;
        b=AF3dY6EsAngyRYjbXFbRMlbjNe76A1GlEZcwsLa7ElHB0Y47sEI28/e1NtZB9s/H/2
         Tz1WvLfwa3QPyKHPh/8rFR/yXbnc/cXU7LDyMurvIvH8DxcLGvScqIbc4Cv+eiEYcohd
         cq3EN05OjA03FCoVx9Vl07NIP37r4OAxkcC0YgyMmvhBIPKxjd5nNXD+X+zDeWVzYbBX
         RMcpY2lP/ZeF81B8sCH1tsEWLlufmBYl021e8nRhdHCK4eOMhaQ0WvwfqkFf3csYK//Y
         HR6hxKQn6mtKX9HDXtv6dLvYQP7joDpgz/6KEpkBrxMIXgeHfKn2/mRdcxGf4v5ronX7
         SMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421465; x=1752026265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePiW7aqYD0qALSKskjMbzEKCrjQTfN8/Jlp9bJXKkFg=;
        b=fMu1zoO8h9Fje1RrKl5yC5njmzD+4xkNAA45X1e4OYlBOWT4v7zeLiTZadyZCdBmNZ
         GXlIa/xNCVP8cYj0I/nc+CUl8XZeTVo0KEzcF8Up4NQat3JINmxvh3aiIDkS/l2fgPp5
         oLO9hb6/PXdN2muumTvOERKcdvy868Fw/W1RAl0pZ13sCClrVgIX0Iu15hCqSZhb0NxW
         zQJtZpA12Tm0l2TEtprnT1nt+W0Ch+monevvVIEFPU/QKx4M3N2j1YCypcvdTESiTIYt
         p8jxKLK3U7vG/SJwIVM7tYrdOuAmbDfliqsr7H/1YxXgQsV+2fDACRaKXKSZxnp+yY/N
         Abwg==
X-Gm-Message-State: AOJu0Yyh+g3cmGKE5VZxGglK8NxCjyL+oICgAEQzi++0Hh78PxLuRWSd
	kTrJtH/RSMqpsxpHQsQ9ukE+22piU1gWHkUgHqGTTe/uC09nb2vO7DvFFcy5zg==
X-Gm-Gg: ASbGncuwPI8tE6qS639jEDy1cISoEL9AltwrcPrQuGWb2eYUx/lPyvjRgTgAdDRrZ+C
	Sa6BsaJapMDGqZ/ntYbp1G4h/1Ojx1J2GJjUKSsfn0DUMHCcZ82L6i0/Fzb6r4/U+0KOgQ33sY/
	NEcwv2QSGBRn/EFP9pZNhcTcdF01bWyhrC0KlNlDVpXDLXXT+/3zAMCSO5YRSIxW5SL16oTd8pz
	L1/DUM0IIZ/de0jD5jqQGfDQjDpY2UHIh1F/baqvvC1saJ/e1UttjRFRJFNRlMYlQO8OXvXocjW
	sJ1WH9+tnEs/aqA63hpA+2uqPB6tj8ZEocDJhpIdzVl3WJAh0MuvC8H7E+S0FhRiwtc0
X-Google-Smtp-Source: AGHT+IERmsDWxCjPaUAp1AZ6+tQ5smCfiuNr1HoxJGLkMM7NcMDn1/4rY/lZpgdyKctUzC1u9/L9iA==
X-Received: by 2002:a17:902:ce05:b0:235:f3df:bc26 with SMTP id d9443c01a7336-23c6e56165cmr10625535ad.3.1751421464972;
        Tue, 01 Jul 2025 18:57:44 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:9468:b035:3d01:25e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3acc62sm124267655ad.143.2025.07.01.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:57:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 18:57:43 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, will@willsroot.io, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <aGSSF7K/M81Pjbyz@pop-os.localdomain>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701231306.376762-2-xiyou.wangcong@gmail.com>

On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..33de9c3e4d1b 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	skb->prev = NULL;
>  
>  	/* Random duplication */
> -	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> +	if (tc_skb_cb(skb)->duplicate &&

Oops, this is clearly should be !duplicate... It was lost during my
stupid copy-n-paste... Sorry for this mistake.

I will send v2 after waiting for other feedback.

Thanks.

