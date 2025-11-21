Return-Path: <netdev+bounces-240871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C19C7BA48
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75B9A343392
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821952FD7D0;
	Fri, 21 Nov 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dP0oZRGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931F36D4F3
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757210; cv=none; b=bMfczmPRoYXGdziMbzQyoHcyRk9IWNht2DrVK+OB/A+bHyVYV9G4Y46hwZpMqDp0BL0l6RmAsGh4UjXuMn4QQYsqUl6e5l7L5/jwtK5LnyK3zCOTMFy6dqNQFwsibjFV1E6QlIl0xMA/b4Bm/h9ZiWkOsPdFxMl/zIakqP/kgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757210; c=relaxed/simple;
	bh=adum91eYHPmgOXTTbibQ9+26fqPNP506KV63PTT9/yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpDp8burMwNDGjNDgtUJwEZPKAweWlHq8bQycZ9zbgxunhjaHiA4PuiFlvkuWAfJIZaeOU7x3rUvH4YqlOLDcKLEtQWc5phXVlWV+E2NsdY1msISy4PIC4VRD/Vmu4ILBGakY0ucIyJfHPAtu68PweHZkokGkwz/06VcY5Yr8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dP0oZRGO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298145fe27eso37361715ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763757208; x=1764362008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FBi5kMacQnAWG9But7w0e8Tjs1+tpPe/5s7yyvFG4rk=;
        b=dP0oZRGOR0QNbhujx18RFXSfwsJ7WADnfq1qQB/OPmoyaHnLa+I4Mv1/Bao8AvsZz3
         uuLfpHXhpzvWRzKsjcOXhP4xk9YuI4bKxfyfxniytvHrpJ/KSbxvEcXjWMoyRCVjo9RJ
         hQvqpcupPSCunYNMBPMgwl3aKKvTdFY5BDeScjalwwY2lAKHMC3hcwT9PHskHHEE/CK0
         uxd8ytunZSo7F5env/ZatmcTtYBirgHvv0CW8oxzk4sAISfzGv1Prc8uCYTvdx+1q/a1
         GNnj2hB9sr843RUPtC9KGsq+7DubKBzHt3HNdtU6rjJNnGmfv2E3a/jAhmtKr7H23XnR
         cGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757208; x=1764362008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBi5kMacQnAWG9But7w0e8Tjs1+tpPe/5s7yyvFG4rk=;
        b=NQ6r02/oTg8MhHni5RKocLGEAjU9/TC/ok+blsVmklXODTcO3fm/UrGSdxxDUqR7rU
         D7cjlRSXNJVQlWpCvQLDjOVwR9ablOcGShWRNnEJ64X7DQzUPTmw9BagC727kC7VuGSl
         A+Bi/y3YVIWjz6eGTePPjKza2nKQ7Jf1q1xAvFUpTcm+9PJvtLti4K8wiM9ODnuaPY3a
         F2nDfX7mFNa6sH8ISEEkOG842qPWN08AjqvzkwfoPE4h4f+NxpVEKtIQANIxLB3lxWT+
         jlOfNBa6f49M3LQ4WHyiI2q0ZQ0PJASh0YmK8Z74yT7zY1fGokuc8wULhWNDFkgpgFXv
         14SA==
X-Forwarded-Encrypted: i=1; AJvYcCX6qYmQ4/jPmV/ofIP92cdIbd35sW6qx3K6jwoqwejRoNeYOsq5uYzSxjJ6ZlVPfD2+cKc1dRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfsjU8lnT5uFMHqu26o+2k3DEKLbpfzrDg5ThupZCHjYWTTmn
	LnJhXUEiN9Cn1Fs1E/3fF6KLG+EZ/3+FuPhVPQGQ3JUyeuPd2JeGSTXLvGNrYhrkRA==
X-Gm-Gg: ASbGncsal/mOetRhBXfB1aeiGzmldg8KW0xBhvGvjvgmePrhpO202+LcJsa4WGoG8Gg
	wQiw5kodcwHh271+u841/dIzUwLGPEh6SLKvbKW5WqvVEukmsVWG/CAcJ1sAdngKk1zWIOmCn5x
	1pJGBIThYNIZ9QUxNkjrgQ19i8V2Dq0s4g59yag/QddqReZCO33eBE/frEIYD420ZqLGe+PZkE7
	bcu1GFYh0gXmuug427a5uTVUYd94TFBb+g3utN1tBeVd+W0jrrgq5C2EafOd1l/rddtY3LZB0ry
	JMaisoDecaV5ZIBF9ihcMjrqsombi2YM+PrhtDo+9VrCoUMyjxXytWbV12qUIatOCZxtdyfrbH2
	jpuVuiBb9ytNdNrRhXXoj4g3gskaUPuc5WnEeNYwjd2rYv3hKEn74FDCLuvjyYqv0R9aGC2e8+0
	ya/ds2ESfP1KjPSZ0z
X-Google-Smtp-Source: AGHT+IGaSLBaJAKIMPH1xi2NTeUPpMgSVoZ5CIFbMoXcnJPG/ei20kaVrJvhaW0vSvp12UEL0fm0Fw==
X-Received: by 2002:a05:7022:1b0e:b0:119:e56b:c73e with SMTP id a92af1059eb24-11c9d60b7aemr1321706c88.3.1763757207674;
        Fri, 21 Nov 2025 12:33:27 -0800 (PST)
Received: from p1 (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm29521077c88.0.2025.11.21.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:33:27 -0800 (PST)
Date: Fri, 21 Nov 2025 13:33:25 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: security@kernel.org, netdev@vger.kernel.org, 
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
Message-ID: <7guebhjv734hjkgtnmloyj7lwaaxj6nz5as4bjruo24t3vs72r@54ryrobt6tdo>
References: <20251113035303.51165-1-xmei5@asu.edu>
 <aRVZJmTAWyrnXpCJ@p1>
 <87346ijbs9.fsf@toke.dk>
 <aRhUsbR6DT1F0bqc@p1>
 <87a50kokri.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a50kokri.fsf@toke.dk>

On Mon, Nov 17, 2025 at 02:23:45PM +0100, Toke Høiland-Jørgensen wrote:
> > will not run because the parent scheduler stops enqueueing after seeing
> > NET_XMIT_CN. For normal packets (non-GSO), it's easy to fix: just do
> > qdisc_tree_reduce_backlog(sch, 1, len). However, GSO splitting makes this
> > difficult because we may have already added multiple segments into the
> > flow, and we don’t know how many of them were dequeued.
> 
> Huh, dequeued? This is all running under the qdisc lock, nothing gets
> dequeued in the meantime.

Sorry for using wrong word. The "dequeued" should be "dropped".

> 
> Besides, the ACK thinning is irrelevant to the drop compensation. Here's
> an example:
> 
> Without ACK splitting - we enqueue 1 packet of 100 bytes, then drop 1
> packet of 200 bytes, so we should end up with the same qlen, but 100
> fewer bytes in the queue:
> 
> start: parent qlen = X, parent backlog = Y
> 
> len = 100;
> cake_drop() drops 1 pkt / 200 bytes
> 
> if (same_flow) {
>   qdisc_reduce_backlog(0, 100) // parent qlen == X, parent backlog == Y - 100
>   return NET_XMIT_CN;
>   // no change in parent, so parent qlen == X, parent backlog == Y - 100
> } else {
>   qdisc_reduce_backlog(1, 200); // parent qlen == X - 1, backlog == Y - 200
>   return NET_XMIT_SUCCESS;
>   // parent does qlen +=1, backlog += 100, so parent qlen == x, parent backlog == Y - 100
> }
> 
> With ACK splitting - we enqueue 10 segments totalling 110 bytes, then
> drop 1 packet of 200 bytes, so we should end up with 9 packets more in
> the queue, but 90 bytes less:
> 
> start: parent qlen = X, parent backlog = Y
> 
> len = 100;
> /* split ack: slen == 110, numsegs == 10 */
> qdisc_tree_reduce_backlog(-9, -10); // parent qlen == X + 9, backlog == Y + 10
> 
> cake_drop() drops 1 pkt / 200 bytes
> 
> if (same_flow) {
>   qdisc_reduce_backlog(0, 100)   // parent qlen == X + 9, backlog == Y - 90
>   return NET_XMIT_CN;
>   // no change in parent, so parent qlen == X + 9, backlog == Y - 90
> 
> } else {
>   qdisc_reduce_backlog(1, 200); // parent qlen == X + 8, backlog == Y - 190
>   return NET_XMIT_SUCCESS;
>   // parent does qlen +=1, backlog += 100, so parent qlen == X + 9, backlog == Y - 90
> }
> 
> 
> In both cases, what happens is that we drop one or more packets, reduce
> the backlog by the number of packets/bytes dropped *while compensating
> for what the parent qdisc does on return*. So the adjustments made by
> the segmentation makes no difference to the final outcome.

Thanks for the detailed explanations. You are right. The current patch
logic is correct to handle these cases.

> 
> However, we do have one problem with the ACK thinning code: in the 'if
> (ack)' branch, we currently adjust 'len' if we drop an ACK. Meaning that
> if we use that value later to adjust for what the parent qdisc, the
> value will no longer agree with what the parent does. So we'll have to
> introduce a new variable for the length used in the ACK thinning
> calculation.
> 

I see the issue. It will be resolved in the new patch.

> > The number of dequeued segments can be anywhere in [0, numsegs], and the
> > dequeued length in [0, slen]. We cannot know the exact number without 
> > checking the tin/flow index of each dropped packet. Therefore, we should
> > check inside the loop (as v1 did):
> >
> > ```
> > cake_drop(...)
> > {
> >     ...
> >     if (likely(current_flow != idx + (tin << 16)))
> >         qdisc_tree_reduce_backlog(sch, 1, len);
> >     ...
> > }
> > ```
> 
> No, this is not needed - the calculation involving prev_qlen and
> prev_backlog will correctly give us the total number of packets/bytes
> dropped.
> >
> > This solution also has a problem, as you mentioned:
> > if the flow already contains packets, dropping those packets should
> > trigger backlog reduction, but our check would incorrectly skip that. One
> > possible solution is to track the number of packets/segments enqueued
> > in the current cake_enqueue (numsegs or 1), and then avoid calling
> > `qdisc_tree_reduce_backlog(sch, 1, len)` for the 1 or numsegs dropped
> > packets. If that makes sense, I'll make the patch and test it.
> 
> It does not - see above.
> 
> > -----
> >
> > Besides, I have a question about the condition for returning NET_XMIT_CN.
> > Do we return NET_XMIT_CN when:
> >
> > The incoming packet itself is dropped? (makes more sense to me)
> > or
> > The same flow dequeued once? (This is the current logic)
> 
> The same flow. The current logic it correct.
> 
> -Toke


Thanks for the explanations. I have understood NET_XMIT_CN wrong. A patch
(removing var droppped and handling ACK branch correctly) will be tested
and sent.

Thanks,
Xiang

