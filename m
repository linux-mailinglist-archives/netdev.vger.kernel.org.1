Return-Path: <netdev+bounces-130501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB498AB1E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D271A284D0B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2D1925B7;
	Mon, 30 Sep 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiAHL+QA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FD18EAB
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717621; cv=none; b=Tqh1xIHRXtKyyx9WqL0d48NY/q5uaz3dpk79zkwiYz2J//LBRcuEYSwFWRe2IYkrk7RxbuXQWJPYx2V3AlQ0I+Vvh5k3Kq5NNuNQLOtVQIvyX+/Q0Fc2ML5nsZbJI+mcgP0KPc7Ag4P2DH4dyFIDle+opeLeAFzFHQi3bbc378U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717621; c=relaxed/simple;
	bh=9oIk77Y9lXxV3D1So9OWJpCarUBx0Rn4cEN6n+2achk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EGdcQqsJ/Px0amXEs5L9Btp9bnD/pygJw2tNouhUdohFeFn/yo+YAlWoKBzeYglieQd1vjj9fqmAPWKKNI+MsYKo5ObCphU115sjhnRSi5J1Ulae/cPa2Uj5HMM8UHTJANtL950BfwkZPPo4y3g5X/9GWEXlp34zza+ekCB7D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiAHL+QA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-457ce5fda1aso40800381cf.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717619; x=1728322419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhJhueQXyggomGUvllmIhlmWg6hCvYOfZCw0csG3e3A=;
        b=JiAHL+QAoV8zI+rdxQPYjqzXQgM6heGEOpYXzajUf46uV/qA7vq2SqGpm+HmuBIHAN
         ZEFLu+b/9igKaeo8DlqCtkGgcInRUBnkOFjaY7o5LzBZLc1bso28P2lbZ81ytrlKixwU
         DeJMGXhyk/eSWuzC6e1HUzT6EDsfUom2EXX+TbOevMI0TaPqIjRiaQQleThhaQEUQ1hE
         6Vso6I6mUHk1jRJ556jMTdbLVDoDuGWe/eYp2VN+U4XHR1Higl8h3nBwV+mcst/jIkZ9
         2apgHtERPNJEy7l9rhPYV3P/BNjsi2ebLxGpDiJKi8yE3/4hW2w4oYkiJqkP/t0tD+rl
         QRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717619; x=1728322419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhJhueQXyggomGUvllmIhlmWg6hCvYOfZCw0csG3e3A=;
        b=KA3ZYpKeo0pdMBLhx/dUHYYqcDYYNzjwIiBuNgWKRZooi4+8djS4novEBMUsA6erJR
         ynDiDd+xBsLy2HSft0ItPy+0lH9EezU+nPdaaI8n+aDhrB1WPMD0nCZ1nZ3mUVUmk4Ng
         g2MA+rU7CjdHNQFAzus2bdoKH0if8Lg8J3ULMb2NcckHoS9ylNyjNGy7esKl1C/7dee0
         1m+rE0/P+X97NBPM05ePoLSj95iq7pGac7EVJSR0v6ohf0n9tmudIkPlo+Z57iJNxXvT
         yhqOWckvK4mqggKETTRKhpe5ktTE11vHIM2kxEKUbz5aMdBb3hd4KhbLXVMSZgJ2RQSK
         +lBg==
X-Forwarded-Encrypted: i=1; AJvYcCXn0k+MSpT6FZzwQYh4OgYebP+W3XfAzhPFhVG0NsZpQGw+gZs4AKfhXeJs5OcohGH3CtMvOVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeoaFEbkbUWbNfUqztdbRMYMyvz3uDNJ2PDz2uypn3U89y8ZO
	1Cy9+zsbDPr2Yc3jzsU/DFXNffDBdH6572RD16Fowayk5MjIPIaV
X-Google-Smtp-Source: AGHT+IFGyhz+snMczrNoaySyXrnnq3rVKz3pgaYatGvkXsOSdJ0CAzCTwxxBlD3AMZdANBCuNeg9hw==
X-Received: by 2002:a05:622a:1208:b0:456:7fb5:1bdb with SMTP id d75a77b69052e-45c9f0aae7emr245897301cf.0.1727717618793;
        Mon, 30 Sep 2024 10:33:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33bd7esm37782891cf.62.2024.09.30.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:33:38 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:33:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jeffrey Ji <jeffreyji@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66fae0f1f12f1_187400294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930152304.472767-3-edumazet@google.com>
References: <20240930152304.472767-1-edumazet@google.com>
 <20240930152304.472767-3-edumazet@google.com>
Subject: Re: [PATCH net-next 2/2] net_sched: sch_fq: add the ability to
 offload pacing
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
> From: Jeffrey Ji <jeffreyji@google.com>
> 
> Some network devices have the ability to offload EDT (Earliest
> Departure Time) which is the model used for TCP pacing and FQ packet
> scheduler.
> 
> Some of them implement the timing wheel mechanism described in
> https://saeed.github.io/files/carousel-sigcomm17.pdf
> with an associated 'timing wheel horizon'.
> 
> This patchs adds to FQ packet scheduler TCA_FQ_OFFLOAD_HORIZON
> attribute.
> 
> Its value is capped by the device max_pacing_offload_horizon,
> added in the prior patch.
> 
> It allows FQ to let packets within pacing offload horizon
> to be delivered to the device, which will handle the needed
> delay without host involvement.
> 
> Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

> @@ -1100,6 +1105,17 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>  		WRITE_ONCE(q->horizon_drop,
>  			   nla_get_u8(tb[TCA_FQ_HORIZON_DROP]));
>  
> +	if (tb[TCA_FQ_OFFLOAD_HORIZON]) {
> +		u64 offload_horizon = (u64)NSEC_PER_USEC *
> +				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
> +
> +		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
> +			WRITE_ONCE(q->offload_horizon, offload_horizon);

Do we expect that that an administrator will ever set the offload
horizon different from the device horizon?

It might be useful to have a wildcard value that means "match
hardware ability"?

Both here and in the device, realistic values will likely always be
MSEC scale?

> +		} else {
> +			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
> +			err = -EINVAL;
> +		}
> +	}
>  	if (!err) {
>  
>  		sch_tree_unlock(sch);

