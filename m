Return-Path: <netdev+bounces-237346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C6C4936E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75FC63429C6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F42EA16A;
	Mon, 10 Nov 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SelWuyn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D22E8B95
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806123; cv=none; b=gTxC/9/dEXJXeKm/3mPDldKo4y1LGEdyqr6y8DKLLXKoNUjVogDnAScPNvvRd6RghCtStfYErennSNTqBRjykX4PLSg/udntmvl6pEad/0gUgpD2z47nbxBSqYsQMA91osWpLH7SpfsoNnAC1O4GsUfHse/nkCo/4uO5owzfL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806123; c=relaxed/simple;
	bh=dbX3djFTTsHCUADqunvjdD8CDIHxOhR61szSV98EpQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+3Frn8cc+ZeIXZwdbn86DmeWc8i8GwDmOzcikN31gEZ3vYhEh8WPmTeTgZF+c3WDEeGw5vQtvG3jfVLtQFyzDI2rS3WnH3VsUv1ldcAfI9atgzvyWuj8LU0o3zB1n0IuJ/d44eIc3Jq5qt24gaW7SDDvZ7Lsrsu/HVUb2yGPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SelWuyn7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295ceaf8dacso35285565ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806122; x=1763410922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NsbQNfYSLMtHeoTSg3mfV+nxZsz0v8yJEVpHacITmg=;
        b=SelWuyn7pwrFgkpsCaw9197EWr7Jce90DuN3z9dCr1uR/3dvOzEvISdtnjBZqQW0Hq
         aa1zH6BvDpVKvoPyOKEMiExX6DnxmcwJ2QqhsZcJ42f+iuWTYT8wKneVqqqbzO/4+f5Z
         Kt/j4Qr68xEBPUHDNMpRUWmcsvlJLgJ1DMwxolrtbWpP1xKd7sEeYnC2JUUsSqF4B+5W
         nzP8X38flmHqGF0RKe5Y028I+rCJ6J9OjgrfYNpWWTniXb2yH0mgpng8Yfiv/4huorvX
         Eo7aSMPUYlw5q1dQQmhSfKmXr1v1OFWGQ3YgynN3r4wah4KaUn/xFf6ZQGkavY/VF6bG
         CAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806122; x=1763410922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NsbQNfYSLMtHeoTSg3mfV+nxZsz0v8yJEVpHacITmg=;
        b=mbzVJGGHIvwiuhDnwEpfxtBb8ec6CGWprJ155hdTE8iklCwqYPzgywfmolfd5w36Ps
         xsgMMlOuIFo/m+/6jZuPb1FFMfgtN70BJR1IvU4BqIGzt4YZKqD9pgvIPqzyiN0V7wRV
         l+X3QDl1uMi5iVYeZp00pteVF+MVK6pi6OfR0XJrSA2K6QdjHgFgk/G+TTh8bCFhHPcX
         AakqrxroZMqg7H+un15jvLutJT36Zdfk6XbTCXISZinP/FRaDWjvsRBP9WG/CysGxY0X
         7Nh05G+bKzPs2VSguD+qlxtKFtJvuM4qASmzK1pvf7vNGd4OhKpwrV/62zi+VZoLROoK
         qAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzt4mfI0WDluFTeocNJUFR+jI/qFj2wCQ7YfQW05vemPp7aMnlEJiKXUEVutfI2fabEfbjZCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2P2VSjMZ9v97pKs0eqatnu4U5C/kJvHpUtQUymzkaC0Lc8PUF
	dDPl0e/vbei3Q7CtQylS10yl9PIKP3R5DaApk6uwXxu24essfsYTu7Dd
X-Gm-Gg: ASbGncvbdGPWL2Eklg3lqr4lvowi7RnhNv2/OkNE29kmLW/Tgf9WeU4UvpMdQ9nYET/
	16wei56b0kV8WdWrsSu+kEhu6t9qQ/Wogckc+b5I0VCIZFVzm1E0DCMuklfEVfom3PUmExLu8x+
	N+Rr66LNrrbe589oXSO9QnEa2F+DD2ydru+uW+loGVIfWSHiGPgDcWddyNG41/8rkQcmX4Wf7ej
	/EMbJhsyB1AEWuJKA1qiNGSFYIDfL0Z+PBAAbqcUBEt5+xDdPF76+ZlOo4Fe4YsC/tHR46+VlEZ
	IuYCk8W5b+9YoE0iLp254WodzHo/g+6zU2axNCOx46FS8o5GNjY28iyBy1sQ/Jk74lOLa673Wku
	Jp+NHXVGDUCRGN1TZloMTfdK1yv/aEwobrl4ekDbBUPEYZid74XShKEgxh1SuZy+0t6kWfdNaGQ
	UOV887fmQdiIS2rRMq
X-Google-Smtp-Source: AGHT+IEabzgKDIb5VHMx9C90lf3vsAZ1HxutpM8UWBf8YomH0kSiEUgnlYLLDAuNZeXD8FqJY9JA8Q==
X-Received: by 2002:a17:902:d491:b0:295:5668:2f27 with SMTP id d9443c01a7336-297e54131d2mr110056775ad.9.1762806121808;
        Mon, 10 Nov 2025 12:22:01 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:9974:abff:f64:1199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccca64sm154692845ad.105.2025.11.10.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:22:01 -0800 (PST)
Date: Mon, 10 Nov 2025 12:22:00 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Valente <paolo.valente@unimore.it>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] net: sched: sch_qfq: Fix use-after-free in
 qfq_reset_qdisc().
Message-ID: <aRJJaCVk181ErQWJ@pop-os.localdomain>
References: <20251106071050.494080-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106071050.494080-1-kuniyu@google.com>

On Thu, Nov 06, 2025 at 07:10:49AM +0000, Kuniyuki Iwashima wrote:
>  static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>  			    struct nlattr **tca, unsigned long *arg,
>  			    struct netlink_ext_ack *extack)
> @@ -511,6 +541,10 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>  		new_agg = kzalloc(sizeof(*new_agg), GFP_KERNEL);
>  		if (new_agg == NULL) {
>  			err = -ENOBUFS;
> +
> +			if (existing)
> +				goto delete_class;
> +
>  			gen_kill_estimator(&cl->rate_est);
>  			goto destroy_class;
>  		}
> @@ -528,40 +562,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>  	*arg = (unsigned long)cl;
>  	return 0;
>  
> -destroy_class:
> -	qdisc_put(cl->qdisc);
> -	kfree(cl);
> +delete_class:
> +	qfq_delete_class(sch, (unsigned long)cl, extack);
>  	return err;

Is it better to just call qfq_delete_class() directly? Two reasons:
1) It is only used by this code path
2) It reads odd to place a 'return' above 'destroy_class' label below.

And, what about the error patch of gen_new_estimator()? 'existing' could
be true for that case too, which I assume requires the same error
handling?

Thanks!

