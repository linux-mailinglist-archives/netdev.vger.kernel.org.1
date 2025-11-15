Return-Path: <netdev+bounces-238851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7AC60304
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 357D4356D89
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559526ED33;
	Sat, 15 Nov 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ZVZg23hm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C2199FBA
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200997; cv=none; b=SPyJPU6pvmEtOv3r9NHahJkimDrOQpOmUm3q4rKplCRY85itJUkSxDx1JRdhMQBN1B7xxJ/oMlOKCpZFFUzf+85DgVgGsYyYgCI6g77On56h/AbLE7nnTeupH0k3R1ufKfoVrh56NgiCdZKINRfAq1krDb0WMLScPXgRurOLe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200997; c=relaxed/simple;
	bh=W9kX6Jb5psMZpzTOuwBfjPDmKL5evxzDgqfXVp0iVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7xhfPw0BmQMwlFCH480IZURU9jSv0YO1ooss7ZTP5vY0uc/rDJpbID58my4uwqm0UKNRsCA2hD0QCpMO3PCTsY2UB4mTbsGVFgV5MisiARociFkNX/HEc99CY0P0VHgC02NRtZc5xDYpIvHRMz2XgOxiGHO8c8BnroN3redVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ZVZg23hm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so2797167a12.0
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763200995; x=1763805795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IR26Gu69S7L4LIVTgNluDTIVChHkdTk0e/UFirULlO0=;
        b=ZVZg23hmcnTH0p6SBrxfXnqyH05ZGv1U1+G2bQtFRX8T5fO96Ky5uzGraHjPlXGr+t
         zPBElOZzqCj9CLrc2HHwCfgS+ykO+puw1EoDOy6EU7Fu1E9+lQnBCjqiUp5CCJBUv4/z
         k35Fc16gG9Hqr/KtKHPMXIt73mIzQkXm/SLHIl81DVbQKXE6Z/Z4P0O7KBnMwtzp/HpX
         CXpsJcgDNc8hrFTfrMN9Cg50Hv1CFiokJd1ueUppO1Yu9teZV0fYXGefK1AwF1Frx39t
         6Uph1sjTVJKFqA5wk7mGrnUDuJxsh0FLIHt2VHOzIVf65TrASTwdyhISSiUFIF1jMxSI
         5thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763200995; x=1763805795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR26Gu69S7L4LIVTgNluDTIVChHkdTk0e/UFirULlO0=;
        b=VZZ87820CBrCXV23/5sXICXbzuR/6G/0Ndvb26SS237nJV5WBZuOUsRbBHtnQxbKCg
         um6pmRj6pAvWcycC1Ldw086F7bRIKZpKcKUmY538E2SH+URUjtpThkzRzOooAIk9uZTq
         EXKeeCRdu85mMyigguIkzBvxmY0A8QKS08dQFgCDfbdS+bJch3ItIGBRQu0oaMtEyBws
         pZK+LJ1dQWQHe6/F4gmg1A+7gjmsxxpXPolIlplV4WcNNRGz9up+3LIM0CATqAyh3A9u
         d3ZE8PFJ7Q2aN5Hk0/Qtt3tdd9U5wOBv6iauhqyvitHwe9oWzZ5FtWyC3at8yCwONkO/
         +fbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5fiS64bQbajw5OtoXxreL1tOjkWvzWn5zfmv40uRzRgvq5Hlxc4uZ9PTctItlbE8i3H1T7CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28VXnwaJDA/tCl9h2hdpz2SDSxNU9XiqiCiEaCD2r7ntsiGtc
	EyGtd6ENUN/pA8SfrhsVCdm7MbSQ0ecrUvg9ordre3c7fBQukgWrLasrtWgdZxyz1pohXrfYciX
	m4a4=
X-Gm-Gg: ASbGnctu1YqcT7Em2pkA8kymb0xikwAuF2cAFVTpCEuf9t9MbyKXrXnclLJ8QPvBXp/
	Q2lTVh0dr+HYBRa6iQXlrByvgIk+MqPITWACEOqZaKm8X4K01v3GRSYGMuXjeEwPN9H9CWzFwsd
	mbJwrBaa3erdyoOwpAkeUJLt4aFWy12LrJRyzoVd+5engV4kddUC7WedE3pj3eNVyQGoDeidRFC
	dbeuOO5eX6CGEQShWwg3rKWETNHKp6LKcUsi0FVsfehP6q6T7SGxzIjFU7M6j1wyHBd1XAFhDIP
	WBA+ofWlwPZA/TKg1vzCLdMS/lanoYzkYjXlXcPaD/gHEwl4o/RdauQADJ+PLGx0qwv2F9e6zjC
	MwOUgVwFk/voWK4myVf4l1+7E1GqpoojYwUH4kaef+Y8oR9/0s/2XrQx7CzPJTGF2UToFlA==
X-Google-Smtp-Source: AGHT+IEmh0x9vh7G0o3s7CweIVMaOIOPJBIgyTFSUzhJzS7KSJpA8awwc7mKbUjKBOt/1T5wS7Qeyg==
X-Received: by 2002:a05:7022:e06:b0:119:e569:f865 with SMTP id a92af1059eb24-11b40f7f558mr2283141c88.2.1763200994804;
        Sat, 15 Nov 2025 02:03:14 -0800 (PST)
Received: from p1 ([2600:8800:1e80:41a0:1665:bc8c:7762:7ff2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885f9sm17481686c88.4.2025.11.15.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 02:03:14 -0800 (PST)
Date: Sat, 15 Nov 2025 03:03:12 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: security@kernel.org, netdev@vger.kernel.org, cake@lists.bufferbloat.net,
	bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
Message-ID: <aRhP4E7g5yJh1vP5@p1>
References: <20251113035303.51165-1-xmei5@asu.edu>
 <875xbejcel.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xbejcel.fsf@toke.dk>

On Thu, Nov 13, 2025 at 02:21:54PM +0100, Toke Høiland-Jørgensen wrote:
> Xiang Mei <xmei5@asu.edu> writes:
> 
> > In cake_drop(), qdisc_tree_reduce_backlog() is called to decrement
> > the qlen of the qdisc hierarchy. However, this can incorrectly reduce
> > qlen when the dropped packet was never enqueued, leading to a possible
> > NULL dereference (e.g., when QFQ is the parent qdisc).
> >
> > This happens when cake_enqueue() returns NET_XMIT_CN: the parent
> > qdisc does not enqueue the skb, but cake_drop() still reduces backlog.
> >
> > This patch avoids the extra reduction by checking whether the packet
> > was actually enqueued. It also moves qdisc_tree_reduce_backlog()
> > out of cake_drop() to keep backlog accounting consistent.
> >
> > Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: add missing cc
> > v3: move qdisc_tree_reduce_backlog out of cake_drop
> >
> >  net/sched/sch_cake.c | 40 ++++++++++++++++++++++++----------------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index 32bacfc314c2..179cafe05085 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -1597,7 +1597,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
> >  
> >  	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
> >  	sch->q.qlen--;
> > -	qdisc_tree_reduce_backlog(sch, 1, len);
> >  
> >  	cake_heapify(q, 0);
> >  
> > @@ -1750,7 +1749,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >  	ktime_t now = ktime_get();
> >  	struct cake_tin_data *b;
> >  	struct cake_flow *flow;
> > -	u32 idx, tin;
> > +	u32 dropped = 0;
> > +	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> > +	bool same_flow = false;
> >  
> >  	/* choose flow to insert into */
> >  	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
> > @@ -1927,24 +1928,31 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> >  	if (q->buffer_used > q->buffer_max_used)
> >  		q->buffer_max_used = q->buffer_used;
> >  
> > -	if (q->buffer_used > q->buffer_limit) {
> > -		bool same_flow = false;
> > -		u32 dropped = 0;
> > -		u32 drop_id;
> > +	if (q->buffer_used <= q->buffer_limit)
> > +		return NET_XMIT_SUCCESS;
> 
> While this does reduce indentation, I don't think it's an overall
> improvement; the overflow condition is the exceptional case, so it's
> clearer to keep it inside the if statement (which also keeps the
> variable scope smaller).
> 
> > -		while (q->buffer_used > q->buffer_limit) {
> > -			dropped++;
> > -			drop_id = cake_drop(sch, to_free);
> > +	prev_qlen = sch->q.qlen;
> > +	prev_backlog = sch->qstats.backlog;
> >  
> > -			if ((drop_id >> 16) == tin &&
> > -			    (drop_id & 0xFFFF) == idx)
> > -				same_flow = true;
> > -		}
> > -		b->drop_overlimit += dropped;
> > +	while (q->buffer_used > q->buffer_limit) {
> > +		dropped++;
> > +		drop_id = cake_drop(sch, to_free);
> > +		if ((drop_id >> 16) == tin &&
> > +		    (drop_id & 0xFFFF) == idx)
> > +			same_flow = true;
> > +	}
> > +	b->drop_overlimit += dropped;
> 
> The 'dropped' variable is wholly redundant after this change, so let's
> just get rid of it and use the prev_qlen for this statistic instead.
> 
> -Toke

Thanks for the reminder, and sorry for the delayed reply.
You are right that we should remove the unused variable.

Xiang

