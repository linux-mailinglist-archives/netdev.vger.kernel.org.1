Return-Path: <netdev+bounces-202176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B5AEC82D
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80207A5873
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9B20E328;
	Sat, 28 Jun 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FKZCL9a0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61727EEA8
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123717; cv=none; b=OutiqPndsMG1pywbt+1QeiOQ0DaMiJuG9oQdxarQAktUX65YtKn9/8YIFRZKzAy7fFzw21S7ShDGXCXyQtXvkrB07z+QUdVak7q1yHryDUh72u+wMiH15bD+UbA9byoU7lFjzzOCnivo3vbreQEu83ivmoW+GQ1HNVlPP0ykxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123717; c=relaxed/simple;
	bh=G7UVRSgxzuhZbkoIFcSCapCevOtNNz5dlwAPHJQ1BXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFV58fim+yOvFsGSmsBQDzXBR5HrrEyCPqfSEjxD+NpJcEupNaI0zp5yVcL1crmABGom0CHl1QZPJCTWgs9r2ymjDsVK4LpXwDrBBZtIpRfosPhGBez+TqmO7fyjSVX2RQe4AVgGFtn9qG/7LPGDB9ab8TVtsJ81MCGpodhQstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FKZCL9a0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so9929416d6.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751123714; x=1751728514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1gsAVVlyI6mTUQAO3yPNBzPWEoEL/3yhZmBnqrYyKw=;
        b=FKZCL9a0A7x6ij82yvZiBT0fvZfV0Qk7bhVtgYB5fXGBd8KRqAOlc5KalYDWP0TYEG
         vI6MlhP/iS6/AaJBS9wvpme4HUp+wfntpn1i/VR8jUCivHudH20gtTaRIqYool8CF4u6
         rNbUDWbQ3xO1VtXXLfgBRWDqBdFozaXJFp/3TmwanPge4MbVqMBbk0tVIjuGbhX+yGK/
         YdfMQvwT4HnuLyq1yhF2s3k0OBuBASbdD18z/4kxv6zyYwAfyF4oBwbXp6lkpe892csm
         KG6ofivvJE/WO+4E99/fTBVrilmMMAsu7l9EEWG8L5VeW4/Bo+W07bZ2yyHHGoDFLX83
         tDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751123714; x=1751728514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1gsAVVlyI6mTUQAO3yPNBzPWEoEL/3yhZmBnqrYyKw=;
        b=uz0fmo2Cu+symL4Wy4rw7s/okABuFAnaGslAXyWZ5gcNcq85KKHKcdN/VkO6x+Wz2F
         IBzEpAArq6JGLIY4H8jUk3Oqlzo/I+AMx75Ab5Xd/SFd/nQ4fMhJWj5BYno4xb4GmHWc
         oidJbdMyIdH1yuUhAWZZpst1avh4JE+KipVefgnsn4r8MN3pH2+peBFWn8aytuAhzsU8
         izA1ooTEehRc/YFQGOZPXTLYRdLYgm4X20IcmkPUrmlXNCYtwNZ8DLgNEKLf62EezQOU
         KYG1BpiNB6V+DLbIy6G7iQ2iq+IygDVmhee/EPNE+Y9rmYSI7r1RVea9Ssrp1Mo1wdEZ
         H1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJDdklEZFHhoHksC1QS79Ev4CEPnMlvk6Qm9KFiEpCjRmJbfGk5KKAF5R3CYWdkQlebGksvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7Vt7MtLCf7EP9KAxJ2Dlcu3nDkAj6jHdhtKV1gGCEf8v7Qg9
	4MNKCMcvk/EjcwMll5t9PgiMzQTecJPqCuBl1hNojEiuuGedGBhYg7O03GolBN3BWj4=
X-Gm-Gg: ASbGncvi+YhuCnAtllc0GG8yMzLt6UAVnmLiMrF02wOZchXOELnhVxz+yzURGuKws6h
	GJBBFx0wXrQEdZ/bPyZwAY8M0lVg+Vb9Qhc0gCU4sEWbNs+jgYII9GE+ueqaxWv1BZ6uprohspI
	3Gggcmrivxjt948L6ZYtzNZWK/8kbtAz452SqTa3J66DCSg4t1UV8t3PQw/pIAAJuLNcc5siBOB
	92S60k4Nk+vHX4nO4xmK7KisTKJrozshHTmiL/+1ktbvy44qFB5gwV2cHUTUBtX3rSDKUG3kIzC
	WcFCFkG8RZgA90OSOW1urkAuy5ISN0m8dmvL1um66fSgOz+NgBvEeMy4SJ8HGGv6I19UK2wUm4M
	Jp3xgCYIDiHNUb7uic64erAgUoRtB9RPLI00xmSc=
X-Google-Smtp-Source: AGHT+IHYlBdp5uC9/Ujjqa2LmEWKLCXO8GI943qUKi+QebbVWT+rUakFkx7ykX3YG8JlRSkcqy1cpg==
X-Received: by 2002:a05:6214:4b04:b0:6fa:c653:5da8 with SMTP id 6a1803df08f44-6ffe433b290mr116138446d6.0.1751123714197;
        Sat, 28 Jun 2025 08:15:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd773245d8sm37784726d6.123.2025.06.28.08.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 08:15:14 -0700 (PDT)
Date: Sat, 28 Jun 2025 08:15:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com,
 pabeni@redhat.com, kuba@kernel.org, dcaratti@redhat.com,
 savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <20250628081510.6973c39f@hermes.local>
In-Reply-To: <aF80DNslZSX7XT3l@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io>
	<aF80DNslZSX7XT3l@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 17:15:08 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Fri, Jun 27, 2025 at 06:17:31AM +0000, William Liu wrote:
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
> >  
> 
> Thanks for providing more details.
> 
> > Previous approaches suggested in discussions in chronological order:
> > 
> > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > too specific a use case to extend such a struct, though this would
> > be a resilient fix and address other previous and potential future
> > DOS bugs like the one described in loopy fun [2].
> > 
> > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > per cpu variable. However, netem_dequeue can call enqueue on its
> > child, and the depth restriction could be bypassed if the child is a
> > netem.
> > 
> > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > to handle the netem_dequeue case and track a packet's involvement
> > in duplication. This is an overly complex approach, and Jamal
> > notes that the skb cb can be overwritten to circumvent this
> > safeguard.  
> 
> This approach looks most elegant to me since it is per-skb and only
> contained for netem. Since netem_skb_cb is shared among qdisc's, what
> about just extending qdisc_skb_cb? Something like:
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 638948be4c50..4c5505661986 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -436,6 +436,7 @@ struct qdisc_skb_cb {
>                 unsigned int            pkt_len;
>                 u16                     slave_dev_queue_mapping;
>                 u16                     tc_classid;
> +               u32                     reserved;
>         };
>  #define QDISC_CB_PRIV_LEN 20
>         unsigned char           data[QDISC_CB_PRIV_LEN];
> 
> 
> Then we just set and check it for duplicated skbs:
> 
> 
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..4290f8fca0e9 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -486,7 +486,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>          * If we need to duplicate packet, then clone it before
>          * original is modified.
>          */
> -       if (count > 1)
> +       if (count > 1 && !qdisc_skb_cb(skb)->reserved)
>                 skb2 = skb_clone(skb, GFP_ATOMIC);
> 
>         /*
> @@ -540,9 +540,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                 struct Qdisc *rootq = qdisc_root_bh(sch);
>                 u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
> 
> -               q->duplicate = 0;
> +               qdisc_skb_cb(skb2)->reserved = dupsave;
>                 rootq->enqueue(skb2, rootq, to_free);
> -               q->duplicate = dupsave;
>                 skb2 = NULL;
>         }
> 
> 
> Could this work? It looks even shorter than your patch. :-)
> 
> Note, I don't even compile test it, I just show it to you for discussion.
> 
> Regards,
> Cong Wang

Looks like an ok workaround, but the name 'reserved' is most often used
as placeholder in API's. Maybe something like 'duplicated'?

Why a whole u32 for one flag?

This increases qdisc_skb_cb from 28 bytes to 32 bytes.
So still ok, but there should be a build check that it is less than
space in skb->cb.


