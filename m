Return-Path: <netdev+bounces-200499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C47AE5B81
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A740717D0A3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11251DEFE6;
	Tue, 24 Jun 2025 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfhoJ6Fx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DC6136
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750739247; cv=none; b=GsZFabwyKQom67bObydTn+vjDy5OLqjOotmzUyt5XFCNXpGQ97fKAia3qhkY0NBH2PqfdP3mMKPsX+Tzoiv1AcoTyuDf0A1wohkdzrkMXz39NguuEko8bS3ie2aZyonJCHyM10ML3Kb2aqaT4mnHq9SXzlaDY9oFiJt6TFRHJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750739247; c=relaxed/simple;
	bh=n/aJEgRf65pC65sEJWHdh6fm87+iA7dNguu8vgrjkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n34FPnef1hy4iCgN77bfVsBChv3bYO+3Y28JnA3n8ihGFEchEfOwWiqvjIOVRnYOGMMy1sfbY3uHENz7hpzVeNWcNhniUfV41qORvGQX303YkQ6i2pIecEs85n0ncGXax6OASixXeRkxBDY+Z++K2O73kA46+juPck/ye5qGmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfhoJ6Fx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d029e2bdeso159485839f.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750739245; x=1751344045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0AhUd6AMi640cWgcuOXOj0hOAaPfwv9AcLL6Evg8so=;
        b=jfhoJ6Fxtae2f9NFr2Irtt4pkDgCx0YYASe3W2c1f8oArvh6vUwH9jMrzaGehi28kb
         zOMiGUDBKLWsHXoPH9miSQihmYHB+DwuLA94ugwmk2nmWFD19EujXq88b+purEF6v3XB
         UYzS6be8IFvELXB87k6yMQv5fNu7dnEQtVyXof6FXTY6OwHeAem7IDBsFGKF3dSSf3+D
         +Q7fcI6BlduMzr2XgzUKqbjAu0KWxxnS1vEYRvbNtttnKyjZowCVQWvm96ukT5efQEEx
         5RupU4mxA4sYYCkfubnTVHvgpifn8IkQbEc04Ha1ePhpZHeyR1CvsERkKu4pBYv3ZPh8
         LhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750739245; x=1751344045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0AhUd6AMi640cWgcuOXOj0hOAaPfwv9AcLL6Evg8so=;
        b=nMg4hQHmZgYtGwbDSq/PAQDHaMhDhsJlDrAMmQX4kStLzWir/+gnDUl9N/EFYksP+j
         8QQWUn6XM01GuDK9fuOwOH3TU38MQrU++610vma3f92ynG8JaFmEQ/8/3ckJfg7pXNNq
         Z2gQ4+UAlcrkot8esUzreywwE9vqPO8PKQXzXw14v9SALBESLDm1/7KPFlGaFmLxIcqi
         1wdp2m1+QSyuNomlPKabXB2YCeZJRZz4CkH6G5VIv0APRqkl0UCINdlbpQiVt66dCTc+
         tHmnWQ/km0QPteEa6A1Ms1I8lvHRaKV9Eubq7ZwmXyBPPvkPxk8Y0V94OwCPsVr8hXaP
         BcLw==
X-Gm-Message-State: AOJu0YyWVZ8tGHjug5Ky9840aHVJAzaWK7LJmUoaaVDHgo4kNBAAwcAJ
	ifHL9XAAR23spu0NT5/yx1ENIaqANPgiyUejomv9U5wy9hEflR3nCVAtDKBT/AlV
X-Gm-Gg: ASbGnctfwUrnH44W4HykiGDjxkUaUSHicPqnCGXpKBSSBHztjOYp5mmynDedITRj99F
	ybaUdhCjqfbjLrd1s1R+3GYuUCUiNueXCQXlH2+WsCuYb89NflToOzr+tGEervEu9r0wC3a3TiY
	J9HWLWmet2xa7TLPKIgt3s/auyT/w0deryOl65+yzhIJEwbZs8KKWKrlGk/VYmMhZezmwdvsx8r
	DzrpEepgwqTiIHPdpzR9lSAfRLznYJyscDhaQzIrWkS2nj0yfAoAB1XYdopLEYbsKBEMW6UWHzh
	miHzAwqGmwgdK9CcngfVjxTESjCE/WqzAeVSHED1C0Q7Rth6Bx4gV9de8KBR2MvO
X-Google-Smtp-Source: AGHT+IHf7OW3iEWCjtqoFCAXEUUFhGmEVZCFRG2VsMUnbouhYEHr/m4/N4LL/xX8C7OxA2KafRQkGw==
X-Received: by 2002:a05:6e02:1f0e:b0:3dd:bb60:4600 with SMTP id e9e14a558f8ab-3df28905bb1mr24819865ab.5.1750739245218;
        Mon, 23 Jun 2025 21:27:25 -0700 (PDT)
Received: from localhost ([65.117.37.195])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de3772e9c0sm34407865ab.36.2025.06.23.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 21:27:24 -0700 (PDT)
Date: Mon, 23 Jun 2025 21:27:23 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org,
	stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <aFopK5iWHa0wrEIk@pop-os.localdomain>
References: <20250622190344.446090-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622190344.446090-1-will@willsroot.io>

On Sun, Jun 22, 2025 at 07:05:18PM +0000, William Liu wrote:
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.

Thanks for the patch. But singling out this specific case in netem does
not look like an elegant solution to me, it looks hacky.

I know you probably discussed this with Jamal before posting this, could
you please summarize why you decided to pick up this solution in the
changelog? It is very important for code review.

One additional comment below.

> 
> [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
> 
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
> ---
>  net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..308ce6629d7e 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
>  	return 0;
>  }
>  
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static inline bool has_duplication(struct Qdisc *sch)
> +{
> +	struct netem_sched_data *q = qdisc_priv(sch);
> +
> +	return q->duplicate != 0;
> +}

This is not worth a helper, because it only has one line and it is
actually more readable without using a helper, IMHO.

Regards,
Cong

