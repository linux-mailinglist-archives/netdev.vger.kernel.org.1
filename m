Return-Path: <netdev+bounces-157558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B030A0ACBC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 00:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8D3A4324
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F01C2DA2;
	Sun, 12 Jan 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGVt2SNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E401C1F1F
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736726040; cv=none; b=ApSBN7zgNQp/yAsyinu6w8327Vp9O32va3o0HNcpthxTZD6UlHWQsoTwpVLaYrsVrxQyvCkGR+1Bo5Htsa5WBXtMU5QV4ipleyOMtQkMb8OSJhpWWIgmk9GGX2RhvhIn3ekbc8Bzyc1iaWy2kY2QuKXKarKU9C2DKj/H6TrU224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736726040; c=relaxed/simple;
	bh=YooeH+p001XhcAqW6rPDW99RIi5/w3DdvKLz8wIxN3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICo7q70VIxutJFWFrV0SN/UzPvz9K0aAehtqqaMeDZAkY4Ki7M3DZLOeWonR8SkWK8VLwJA8bFjMpH9042gktCKCt87IbiGQOjFyiNsRjjai32UNIbeeXoJ6oE0sRtttMLAwRUFrm8P6hJz8MLs/SuMjsy/43EBqVF5ddqOGGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGVt2SNx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so64116015ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 15:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736726038; x=1737330838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rENg5OIo++0a6KsxYANDprd4hMcZ7i23K5ieWTnEaNk=;
        b=QGVt2SNxy589bcgMDN4cgV35K4HjCrzb77nfm9E1A4wjsbaAcVQVdgI64JosUBEfj7
         4TUIGX2A9kPSe7DKGD3UrYIlOBAQ1LwZqHFG7hITiLH/kcH+ZgOTlp+xAMcScUZV5GLb
         Z3naqaTQ+5wCzDhBeaFil6EnTMlPIiJ80BY/KdI61Wa4jOz3TpsqGTI2WLSb+OpnolUE
         FEwVaKC68xbnt3Nzkq8TCqaG7IYJ9VX9ibxMCKENa3n7reoFi8kgHcB4PUwq9Wh3qKDg
         RNy15nVx1HKx6ECPwA9RJDbLu1I50oTvuO9whnhdZPiQ9DHQlPEQX8/ynucMcWPWgvIQ
         pj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736726038; x=1737330838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rENg5OIo++0a6KsxYANDprd4hMcZ7i23K5ieWTnEaNk=;
        b=aoAh1mvZewEcopCH+1GkEvkMBInHK615zmx/9xQFqopv5ZeLt3KKhOH7Apsg6hIYwJ
         dYvVbxz09Iyt03g/ok8xzegWgeKRoh99zoh3kUFGzyv3zwJN7MhnC6qTrasxJbyrSqIz
         KT+NYg4XByv0uSQRn2yfMQRQg5auR0tlx99qt00jivlxk8VJeC70GFezAX01yBZPG2sy
         chLo+FtVvJrVTA6qkY3XMYu7nYqiiPNGCgpOJtiYc1fZ6DCSnPkM2jrS9R3bvfvHtRdJ
         fKk6nw7Xp2shuaWSWM7wUlxTKP+I204Ww27kXMDVwfnSeTPPd+PXE6TQwJdoKhLILXz+
         LXRg==
X-Gm-Message-State: AOJu0YyrhD7CLlIJFPiU8NlpBwIb3gPmQJFPWVT0kOC6VPjX4vrLOYzR
	gQHqhM1IRdupVSLV0N9zgLW9aOI51wiTCZYAwGbCWEz/Bpu5B0/y
X-Gm-Gg: ASbGncusfh/JC9bb9dkbATifXK4154OpY9OdPqd/s0pNAfVqGOmHf/DW1Ijex1Py5a0
	cOqeS13ekuObLH0y0vF/VOB1QiUwLFCqYoZXjHe+7ab6V1hayPYMxI4GqwP+2y/fEUmEt7OEp5F
	tI+Vyt6AuIB31KN+oQ1dtSS08/nM0IHs0tI5js9pbUs4uspelCXLzPa4303USQ/fUqY0NIwyzul
	v2bTVPNVcZ+7qlv/zun1BawgCro9lN/T0b/MS4wtwhGTzj3s+7BqbX2KErhR+M=
X-Google-Smtp-Source: AGHT+IFZHeTI5fWXwgLXF7QD3I23TZijErZyTZ2T+Uq5GrRn7UkTOD8S18xG6TB7M3Mrpq+33VPNOw==
X-Received: by 2002:a17:902:db09:b0:215:b18d:ca with SMTP id d9443c01a7336-21a8d6c7b35mr236215215ad.18.1736726037945;
        Sun, 12 Jan 2025 15:53:57 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4b69:8566:fc48:9d6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07ccd6sm5840700a12.8.2025.01.12.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 15:53:57 -0800 (PST)
Date: Sun, 12 Jan 2025 15:53:56 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, petrm@mellanox.com,
	security@kernel.org, g1042620637@gmail.com
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <Z4RWFNIvS31kVhvA@pop-os.localdomain>
References: <20250111145740.74755-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111145740.74755-1-jhs@mojatatu.com>

On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index f80bc05d4c5a..516038a44163 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
>  {
>  	struct ets_sched *q = qdisc_priv(sch);
>  
> +	if (arg == 0 || arg > q->nbands)
> +		return NULL;
>  	return &q->classes[arg - 1];
>  }

I must miss something here. Some callers of this function don't handle
NULL at all, so are you sure it is safe to return NULL for all the
callers here??

For one quick example:

322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
323                                 struct gnet_dump *d)
324 {
325         struct ets_class *cl = ets_class_from_arg(sch, arg);
326         struct Qdisc *cl_q = cl->qdisc;

'cl' is not checked against NULL before dereferencing it.

There are other cases too, please ensure _all_ of them handle NULL
correctly.

Thanks!

