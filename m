Return-Path: <netdev+bounces-238853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC17C60338
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E30434F4BF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAA2580E1;
	Sat, 15 Nov 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CF4bSo70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6D1ACDFD
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763202229; cv=none; b=Crv1gQigGCZUCeYrQ4POV0r9wk8eX2FTizD37MxSe0dauDACzmLK57qbaxjEzyRHFIrUSTly/PHB4VcE6FYtI0OdqkCJichzwwYTZ7Y3wpFLpLxdwRllzHEsr+txQWIn+9BVcNoZxxdvEWX+t+FYITZ4rh90x8iZsqPoOjCW0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763202229; c=relaxed/simple;
	bh=AQyFcGYH0/5CWgghrxdPWpEv6+2cgz1bE5+gwzLzzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWtiMCLMYAIV8JRhvLp4zkVAOWaEUTZZirEAaNcv+YCbCzHQmAkYP+AMnQo7oq460viR/b3GM/Y+vmpDEZ974p8cFXOPBbHktkS+/AKUjbWNj540JPbmMGSGUx3xqFUMQZ4oHZWVwA1ZVN8qA9a0/StSLc5/+mQhBFLQlJA6d+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CF4bSo70; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29812589890so35843515ad.3
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1763202227; x=1763807027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYOc0IUNPX85RhlM2z4VxJh51pDy+UaQAYdPvoblagA=;
        b=CF4bSo701YzNDbcZWXKKayInL/CvUCwEzak3knXFLOlFobicH2jmxjchvQlO+TdoM6
         Jqg2RDwqMJugb72UreTqyykRKs8agEn9OtaAV5qFbc5RBZifE6qZTzjAHdZzt6HtRmp5
         yYBXsXIYnYEAiMw3g/aLqtTsD2557LLFLJXWFHwOswPsiPVKDL5nEHRSKE5zY0H6QlHj
         8G2X6baS5TrlXSqa6Uw6FVfLyfhadSazLwmLjVgRyTmcF1zZq2xfHdlbh7xaWv590MGM
         +rQ0cWdYIGJMXUy+kwASsKRkRrR/a55xLV5SJUi4qksz36doFVtVKehCW7x5dzDSGxtI
         ou2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763202227; x=1763807027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYOc0IUNPX85RhlM2z4VxJh51pDy+UaQAYdPvoblagA=;
        b=T1ODG1WTaM30nsezYWD/n/pjC2UDVGJWGTbEQU8ze3gAxGafqiAvMXiJZHsx3QBneT
         clHw5xBgiIOx0lxsy3zKPfTw1piXOJqvZkAuem920/MLCq0J5rXiTGFH6mVuRY8XYb7P
         By5c5OdwDLTr42F9+/g0gxs0Sef/lfRnUpgDaRP9KeEg8/9TreRTCDpUbuA+sImJTnrU
         /8TqKm1hwT7u98Zul6Baj372ATS8kQ2avTB+9OzmHECJO5eiwTru6U1VF0UM78VsqZeN
         lIDW4ch//3L1AvIJMXEe+afIGMAF5krS2/RTH6pC0575i10hTXInhkddYlKxGt30X/Zn
         CFSw==
X-Forwarded-Encrypted: i=1; AJvYcCVVJMMesHOfHHngl2KYTiPis3thY1HBHrfNRDS7KuA8AcCiG+7vR3jwDHkTpZx36bD+RyzIFec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnt+hdj0QutoZWcu8C3aWQjOwcGHHv9m90WYgWiT0QK51EWbf
	gdpsm2tQZUbmLpiallZZhXgJZkczRlS3uNWTUNO7TEgALua5Y6OyxiM16JpefrTWbIsawoS1inZ
	rb4o=
X-Gm-Gg: ASbGncsES03GwGPWzIeVnvZtCxpdw0q/KJPckNthCMc1re7pNtAoP60jb11CUUcDlof
	s2pxUvBQ0/HX/Oei0T0FBDuQBeGSfv7L86BVokqf0PXx2S0rA2MfVrLpMSyHdIOPEtZj8Gtz0cf
	PQMWubQsAPHpsvKjfQJ+PAqcWLbBgF/cPK9UdLPvuIVClhLjvhZd9gdWydvOd3ykg3LtEJHc8YX
	4/efRG7Wh7hw3KbIZcBjlwkATMUkrCnoNIU1d/MzpyNwYWAZLTq1Fquf5NEH0WQy+A8ABIo5dBN
	FzTQNEm0eSEzaqiOw7QquFpLQRahmaZCDUpSrI4rN78Bx4+SS1tOlOfjihuTZjE4jveRAJhCBQZ
	zmtqjbC52yLRGL7iJF42dM/V3DSLMnw55MkvBWIF7D7sPsl5UMElj1og6cSqF8nVLo/Kj9YGlMq
	T5I2Sx
X-Google-Smtp-Source: AGHT+IHrBU43wvC6gMDgSE5qM+edUPrS5jQNdJRECY2EPUfuN1+iqG0qBZBMUYHmlhgLOuBycVT5uA==
X-Received: by 2002:a05:7022:62a9:b0:119:e569:fbb1 with SMTP id a92af1059eb24-11b411ff1b8mr3401108c88.32.1763202227360;
        Sat, 15 Nov 2025 02:23:47 -0800 (PST)
Received: from p1 ([2600:8800:1e80:41a0:1665:bc8c:7762:7ff2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm20398145c88.1.2025.11.15.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 02:23:47 -0800 (PST)
Date: Sat, 15 Nov 2025 03:23:45 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: security@kernel.org, netdev@vger.kernel.org, cake@lists.bufferbloat.net,
	bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen reduction
 in cake_drop
Message-ID: <aRhUsbR6DT1F0bqc@p1>
References: <20251113035303.51165-1-xmei5@asu.edu>
 <aRVZJmTAWyrnXpCJ@p1>
 <87346ijbs9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87346ijbs9.fsf@toke.dk>

On Thu, Nov 13, 2025 at 02:35:18PM +0100, Toke Høiland-Jørgensen wrote:
> Xiang Mei <xmei5@asu.edu> writes:
> 
> > There is still one problem I am not very sure since I am not very 
> > experienced with cake and gso. It's about the gso branch [1]. The slen 
> > is the lenth added to the cake sch and that branch uses 
> > `qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);` to inform the 
> > parent sched. However, when we drop the packet, it could be probmatic 
> > since we should reduce slen instead of len. Is this a potential
> > problem?
> 
> Hmm, no I think it's fine? The qdisc_tree_reduce_backlog(sch, 1-numsegs,
> len-slen) *increases* the backlog with the difference between the
> original length and the number of new segments. And then we *decrease*
> the backlog with the number of bytes we dropped.
> 
> The compensation we're doing is for the backlog update of the parent,
> which is still using the original packet length regardless of any
> splitting, so that doesn't change the compensation value.
> 
> -Toke

I still think current method to reduce backlog may be problematic:
What you said is stated for the GSO branch when cake_queue returns
NET_XMIT_SUCCESS, but it may lead to issues when it returns NET_XMIT_CN.
For the normal case where no dropping happens, the current implementation
is correct. We can see how qlen and backlog change as follows:

backlog:
	-(len - slen)  Reason: qdisc_tree_reduce_backlog(sch, 1 - numsegs, len - slen);
	+len           Reason: parent enqueue)
	Total: slen
qlen:
	-(1 - numsegs) Reason: qdisc_tree_reduce_backlog(sch, 1 - numsegs, len - slen);
	+1 	       Reason: parent enqueue
	Total: numsegs

This makes sense because we split one packet into numsegs packets of total
length slen and enqueue them all. When a drop happens, we must fix both 
qlen and backlog.

In the not patched code, cake_drop() calls qdisc_tree_reduce_backlog() for
dropped packets. This works in most cases but ignores the scenario where 
we drop (parts of) the incoming packet, meaning the expected:

```
backlog += len
qlen += 1
```

will not run because the parent scheduler stops enqueueing after seeing
NET_XMIT_CN. For normal packets (non-GSO), it's easy to fix: just do
qdisc_tree_reduce_backlog(sch, 1, len). However, GSO splitting makes this
difficult because we may have already added multiple segments into the
flow, and we don’t know how many of them were dequeued.

The number of dequeued segments can be anywhere in [0, numsegs], and the
dequeued length in [0, slen]. We cannot know the exact number without 
checking the tin/flow index of each dropped packet. Therefore, we should
check inside the loop (as v1 did):

```
cake_drop(...)
{
    ...
    if (likely(current_flow != idx + (tin << 16)))
        qdisc_tree_reduce_backlog(sch, 1, len);
    ...
}
```

This solution also has a problem, as you mentioned:
if the flow already contains packets, dropping those packets should
trigger backlog reduction, but our check would incorrectly skip that. One
possible solution is to track the number of packets/segments enqueued
in the current cake_enqueue (numsegs or 1), and then avoid calling
`qdisc_tree_reduce_backlog(sch, 1, len)` for the 1 or numsegs dropped
packets. If that makes sense, I'll make the patch and test it.

-----

Besides, I have a question about the condition for returning NET_XMIT_CN.
Do we return NET_XMIT_CN when:

The incoming packet itself is dropped? (makes more sense to me)
or
The same flow dequeued once? (This is the current logic)

If we keep the current logic, the above patch approach works. If not, we 
need additional checks because we append the incoming packet to the tail
but drops occur at the head.

Thanks,
Xiang

