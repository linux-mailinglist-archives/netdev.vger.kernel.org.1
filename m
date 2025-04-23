Return-Path: <netdev+bounces-185315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D4A99C0B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5487442F53
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02C22F773;
	Wed, 23 Apr 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcjn0YRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACB20CCDA
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450981; cv=none; b=RMdOE5ZpWOBFNldHrAmY2F2hdBVADLRnpWeHodjRS4XvztmpKW8IOhGsMqo9LVNGeSPb9gP74YNd8BK76nf6nhkoZngoMUWYyG4baVUnJE7iIYhwvW/eNdCxq90D1c19O8QEjUQjX6h0DP3HDzl5/DDMb1xAAN9CHyp8sdqeBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450981; c=relaxed/simple;
	bh=0O5WtYNKdLbi+s7TD+BRlfJErmHtxMD6iqcFd67bmnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1ModMeEH/Xb1bc4ktj7dzJZcoC4jWJtMLi4XeKpq93SazWeK7A9yZj0IL5oz9Faenhxn0u3BOeqVRX8RgrfySA40vN1hw4Dc6vNooci34uKD76y+dt+8XOznITUmpZRQLNilGrO6s0IzY4H4dG2+xZs2ffRmnApG9ogmj9Fx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcjn0YRv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso5538505ad.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745450980; x=1746055780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BS+4sV4qLBvU48aLRyzMNrXGFRS5Q+zvryJvXAf11I=;
        b=dcjn0YRvl9W9fMnqSfP4cM8qVT59J6c75Ow3se/CawOcqOkaE1ENpM2fndrn27Ihu0
         HKq5uahH9jECZd9txXS0MnTI/OuPvm34nYulMtk4szCWpZ/Zyqt1hW4D9dn9y5qPqAqM
         jF9xhSv1JdfMuVIJJ0MxP8EudDQg88a5dzoVh4bW5gKUEXP6uAoP9Yk7s6Iidf46pw0H
         g9n27SV3fp86xMIDU5DM4Y5Pzrt1vm9jJBKSTBVkB7NWZQlnb79svPUHmLZbvTqfKyB2
         u45cLYitreq9H5KjFnGmSk4N/Kyy0/NgZf9hTSZavVTrI3bd+t512riAH5YifS7dOcO5
         ANwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450980; x=1746055780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BS+4sV4qLBvU48aLRyzMNrXGFRS5Q+zvryJvXAf11I=;
        b=OXYoxs8nW6duC/uOGP3Od/ahU8cofsBkQWI+3cGxkyK6Tx9/UmeIjlvYrnlFa/me+c
         VcTJ9BBDqNKlecvNw1mHFRKCqHsj+A+lgvcTBmh42teytK0TQbBwM/83Iv2ENCU2Z3at
         fTWIMsZUPl9h3vPx4B4LCytKNH3oUBvjX8n5Bzqg35n+jgAB8V8kXTC+EvubD4RKyNCl
         pR89znQ0O1/ePp9bow8nb1TDbsOnfK5JzOw4Ty4lpt2Wj6/C1ZUfAgFWOXP0md6840YW
         MrhVQ4/g9+waIjCpVLnYZkroyfJexmWOxkXd5/NoDNbPMl+zbf0TRiQqnqRKA8nJI8nl
         nzWw==
X-Forwarded-Encrypted: i=1; AJvYcCX0zDyIY3cthC9M7x7a9S3HmGuXzaj+EWGrXcwySzhcbcD4sIvnnql5cC74ruApM91RWySShWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGwBdUJ3Thrk07//5QHBnr+rwNrXcuwgHEe/J6iqZJelM+2WM
	iaOilsggLJj6KkdfNEd68rfufrXwFPDcFKGfs0jFWngM5T5chBq6SpaOed9f
X-Gm-Gg: ASbGncsiAJsQVNXhHsydpzmmrsmx4MNtf0Zh81l5S3kp1IDNdwUYy/iJ+i8AUf9ehkM
	yFQtzR3Pm8Gn6uZiJz4SgdNm6Xd7R7Mme/sczQ1r4O7YeteSKsIkEBQ1BPY9Ab6QjEYmU5bGP2g
	WM5E6L7mcN7QMwjc8+5lCrTT9KdUWS4wFXydYJW6NsO2dBjrtAIElRSmQG0qFaaYIqFtz5WDDwV
	ebLrKoMR19uf6yfy+47z60sal/cEub5Lb59qg69TXp56AVAvmEojMRsbS85/zK9GlG3yAf2wV6v
	d7mORZGNGkBIWE9XaXuXzTV7Df+vPGHKXIM9IZTRVgC9xHNZlLfHU5k=
X-Google-Smtp-Source: AGHT+IEaKpXxJyZTpbuGG0ZluRsSix0kHsl4z5QSu8f3B/k+iS8JEq8coMfu2AQ14m5awUx8UDcDUA==
X-Received: by 2002:a17:903:2f91:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22db3ba5a70mr4404835ad.7.1745450979796;
        Wed, 23 Apr 2025 16:29:39 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa908a40sm53148a12.47.2025.04.23.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:29:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:29:38 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, toke@redhat.com,
	gerrard.tai@starlabs.sg, pctammela@mojatatu.com
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
Message-ID: <aAl34pi75s8ItSme@pop-os.localdomain>
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <aAFVHqypw/snAOwu@pop-os.localdomain>
 <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com>
 <aAlSqk9UBMNu6JnJ@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAlSqk9UBMNu6JnJ@pop-os.localdomain>

On Wed, Apr 23, 2025 at 01:50:50PM -0700, Cong Wang wrote:
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..000f8138f561 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -531,21 +531,6 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		return NET_XMIT_DROP;
>  	}
>  
> -	/*
> -	 * If doing duplication then re-insert at top of the
> -	 * qdisc tree, since parent queuer expects that only one
> -	 * skb will be queued.
> -	 */
> -	if (skb2) {
> -		struct Qdisc *rootq = qdisc_root_bh(sch);
> -		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
> -
> -		q->duplicate = 0;
> -		rootq->enqueue(skb2, rootq, to_free);
> -		q->duplicate = dupsave;
> -		skb2 = NULL;
> -	}
> -
>  	qdisc_qstats_backlog_inc(sch, skb);
>  
>  	cb = netem_skb_cb(skb);
> @@ -613,6 +598,21 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		sch->qstats.requeues++;
>  	}
>  
> +	/*
> +	 * If doing duplication then re-insert at top of the
> +	 * qdisc tree, since parent queuer expects that only one
> +	 * skb will be queued.
> +	 */
> +	if (skb2) {
> +		struct Qdisc *rootq = qdisc_root_bh(sch);
> +		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
> +
> +		q->duplicate = 0;
> +		rootq->enqueue(skb2, rootq, to_free);
> +		q->duplicate = dupsave;
> +		skb2 = NULL;
> +	}
> +
>  finish_segs:
>  	if (skb2)
>  		__qdisc_drop(skb2, to_free);
> 

Just FYI: I tested this patch, netem duplication still worked, I didn't
see any issue.

Thanks.

