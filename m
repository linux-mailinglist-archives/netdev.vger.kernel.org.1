Return-Path: <netdev+bounces-204270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C581AF9D0E
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE53F1C27192
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 01:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C493F50F;
	Sat,  5 Jul 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWvSppT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF481C2D1
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751677474; cv=none; b=gekN781QCCgAAq4fBJO99cjAQyXmnybR1GstrbPjEPYP5KUohbTqEocpf9PIqu9nqEVvrON+mq2OSL7yeD/5Y7VCDYxly0uztw4YJZU3zfipdoavJtsFIYlSii7gWh+fEQ29pls4ihQRYfpNzwHWNowEPJgtcqWoJCRiIdN7YMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751677474; c=relaxed/simple;
	bh=1oi4cqeRhaYHPseZ0E63JOKlByBvQKqBM80wpoAO/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmjNeAYgSq0MNin3JnBbiEw9GSUMHO+g1isFcnuACzPjnlVO9AtIM7nxpr/LGGTxxIEaQ2gt01JP2i6WvMfWyDysDYsqD2Es5dCzmF4zMtSCyyF06TGD+YLEmKQ6AYnSIwYuP1Cf5TVU70IX/y8w2IaXck2U0O6uqtcid570Xzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWvSppT1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1082363b3a.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751677472; x=1752282272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uWxiKuTZY1yONxfCOM4zzlaNArqxuhl+/jFKeZr03A=;
        b=YWvSppT1mRrXyeocV2jSWWzIiR99FV9tk4Wxdktm9zOZQCjNLy+VRCGk7qJxAZTBQr
         dH6OnHyCyD9atRLYTM+TzvWhPYs/2RQdUdw0eEjZ52khjB4DN4cboLuHS155abbC4dov
         Dr5M/vqfuH500CztGKxBuJxsuaihUxg76OOFnB3+lNFEs8lWQkrQEZU3R+HGvWtvN5L3
         NEWpMhfm2jmjF/+0aAOlLnUeQ8q06DprSbQhxb5x9BgR3KD/uQ05vV1UUP+55rwTA20s
         rQwvqr27MOqQ8CnszB3DILMBIp2No2jOUwdMyZjjGTs/JJZ0JiViU7R4eOotBZ0yYest
         RWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751677472; x=1752282272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uWxiKuTZY1yONxfCOM4zzlaNArqxuhl+/jFKeZr03A=;
        b=YaKIeta8YGTqqEe9kAu+S+clYSJ7+1+Rep17kzZMf/yw3qTBLAANyL41FDrLRNex5x
         4U6WIL9XcRE4XZxOG/nCCiylXght/gbKnt0JI6H2/a+c7UYcVgIoiE7GPQ0ammKMHuSL
         gClOgquNRzPtLUqfw60vs50L+pz1j8vEhca+y94ZM02vaGqBHGrx7Hd4o7WAtUk30CIU
         wWppTgTnQTrXXgD5vMYKANj+NOsT9yT/J32dvumujYC/77YLYP+RIeHSsgD5jmI54g4I
         GrNLTf1h+63LGbDejuDcC4ZlH07KFy+V+jt+bnE0RNkyn8QpFqdaP/h/i52VCmnGthVc
         mLoA==
X-Gm-Message-State: AOJu0Yy9VHn3MILg5JufFFLwHKqA2A7dR2xu8QV8DkH6gMYhe9CCxs6u
	SPNS/9l2Fa4BwKHslYgtWjN4qGXaNrKaupIAwKBGLuw/X1qCLB/rnis2ncO2tA==
X-Gm-Gg: ASbGncvWvRsGC9O0PhqQ5iU2bgSr02MJW0Ty6BmLikcxj0B3COrjt0yugo4qr2AsfTB
	AT6Oujs4iyPlj2x5sfOwQXGl78P6psAoiXhDjV7OE36Tf4wH5YYFMlfANZ64i6ALFxv274RNkD4
	aHi+e8nuwVgEpj9hEcIqpR76I+iUoc+VkwZcSUU/dm6aaGefgnLADHNWbk/viUPRApIOGGSbGun
	HZAYNxD5GLyWSrqzUraqexxU/AJ5DVyUqlXb7FCgEmQgu3kCLcNlbPkr9UxDJ++kvxq+u5fYTpo
	1ITD/FSnr52zy4zveZvAVQM0jPDJHPUj9KXsJB5palztYo4I+qu5/imxIWy95EJpZ9GR
X-Google-Smtp-Source: AGHT+IGVzSPhaT2orYUcT0lqr8e2oQv9Vs3uMLICvB0rxGrn5YKeguKzy2bgm3/Q9Mv/BE1bnaXoPA==
X-Received: by 2002:a05:6a20:a126:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-225b754f893mr7104425637.3.1751677471904;
        Fri, 04 Jul 2025 18:04:31 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4a21:dfa9:264b:9578])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f32c1sm3008243a12.48.2025.07.04.18.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 18:04:31 -0700 (PDT)
Date: Fri, 4 Jul 2025 18:04:30 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq,
 fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <aGh6HiQmcgsPug1u@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io>

On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
> Hi,
> 
> We write to report a bug in qlen and backlog consistency affecting hhf, fq, fq_codel, and fq_pie when acting as a child of tbf. The cause of this bug was introduced by the following fix last month designed to address a null dereference bug caused by gso segmentation and a temporary inconsistency in queue state when tbf peeks at its child while running out of tokens during tbf_dequeue [1]. We actually reported that bug but did not realize the subtle problem in the fix until now. We are aware of bugs with similar symptoms reported by Mingi [3] and Lion [4], but those are of a different root cause (at least what we can see of Mingi's report).

Thanks for your report.

> 
> This works on the upstream kernel, and we have the following reproducer.
> 
> ./tc qdisc del dev lo root
> ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms || echo TBF
> ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo HH
> ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo HH
> ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ 
> 
> Note that a patched version of tc that supports 0 limits must be built. The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_reduce_backlog [2], where n is 0.  You can replace hhf with fq, fq_codel, and fq_pie to trigger warnings as well, though the success rate may vary.
> 
> The root cause comes from the newly introduced function qdisc_dequeue_internal, which the change handler will trigger in the affected qdiscs [5]. When dequeuing from a non empty gso in this peek function, only qlen is decremented, and backlog is not considered. The gso insertion is triggered by qdisc_peek_dequeued, which tbf calls for these qdiscs when they are its child.
> 
> When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue triggers qdisc_tree_reduce_backlog with the inconsistent values, which one can observe by adding printk to the passed qlen backlog values.

If I understand you correctly, the problem is the inconsistent behavior
between qdisc_purge_queue() and qdisc_dequeue_internal()? And it is
because the former does not take care of ->gso_skb?

> 
> While historically triggering this warning often results in a UAF, it seems safe in this case to our knowledge. This warning will only trigger in tbf_graft, and this corrupted class will be removed and made inaccessible regardless. Lion's patch also looks like qlen_notify will always trigger, which is good.
> 
> However, the whole operation of qdisc_dequeue_internal in conjunction with its usage is strange. Posting the function here for reference:
> 
> static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
> {
>     struct sk_buff *skb;
> 
>     skb = __skb_dequeue(&sch->gso_skb);
>     if (skb) {
>         sch->q.qlen--;
>         return skb;
>     }
>     if (direct)
>         return __qdisc_dequeue_head(&sch->q);
>     else
>         return sch->dequeue(sch);
> }
> 
> The qdiscs pie, codel, fq, fq_pie, and fq_codel all adjust qlen and backlog in the same loop where they call qdisc_dequeue_internal to bring the queue back to the newly requested limit. In the gso case, this always seems incorrect as the number of dropped packets would be double counted for. In the non gso case, this looks to be fine for when direct is true, as in the case of codel and pie, but can be an issue otherwise when the dequeue handler adjusts the qlen and backlog values. In the hhf case, no action for qlen and backlog accounting is taken at all after qdisc_dequeue_internal in the loop (they just track a before and after value).

I noticed the inconsistent definition of sch->limit too, some Qdisc's
just shrink their backlog down to the limit (assuming it is smaller than
the old one), some Qdisc's just flush everything.

The reason why I didn't touch it is that it _may_ be too late to change,
since it is exposed to users, so maybe there are users expecting the
existing behaviors.

> 
> Cong, I see you posted an RFC for cleaning up GSO segmentation. Will these address this inconsistency issue?

No, actually the ->gso_skb has nothing to do with GSO segmentation. It
is a terribly misleading name, it should be named as "->peeked_skb". I
wanted to rename it but was too lazy to do so. (You are welcome to work
on this if you have time).

Thanks!

