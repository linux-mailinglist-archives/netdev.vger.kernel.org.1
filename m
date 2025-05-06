Return-Path: <netdev+bounces-188474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A99AACED9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F55A1C074CF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91111CA0;
	Tue,  6 May 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMjCBo89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB5CA6B
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564019; cv=none; b=Ia59VgEqSZEU7KDkj+M+qMwpczMG1bj8SuUzo4jsnuEnh62QltR7p+Di+FyOzVNG69XSKroWBdd/C8F7uCn0JpnV31WXFHExfyJAdmo+55h1rRHJeO/8kxJdwMlC2/tPotXffX4G7xZUtNWlahKsNp1logWKTWUKro973B3pHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564019; c=relaxed/simple;
	bh=fHPMFFzOMABPaX3VDb1UExZue0kUfOn449yA23fqF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUXGdaVOB6r+t0sS1oxONQvN/ofzHbZukiIaK5678swG8N2hBhxzF34PiEZWCeRe49SVWeKDMCps55Bw/plFvMp6hF2uX3o+SbLPhIxMtZb2RPCxKG3QsGzeLYGBfNbDak+HGHBUtH4BdaHPO0obSQReDClH79fs2BY6EKSMq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMjCBo89; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74068f95d9fso3219844b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746564017; x=1747168817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pprqtj6nNwJ7kvGMAS6wH9Xjmd67CzDbSMXZu91bNsE=;
        b=aMjCBo89YY9HY0W9ZojqLkHgFOqAeVsAK9631X2j7gkcONwIcuHvmkhWTQd1XElk33
         QXj/a20FkDeoQJzZrD4ltSJqnev4KP9cS+I0D+jVf3YFARi5bUUvkJK6KbN5/1BR+/OH
         Ejb8SfRam2gbxSryLsKKiPmZbbRpG0XxACn9DR/yczkxY9Jg203bLw59UuSubLcy7qhZ
         96mtv2RcBibbul8qeEsmePoE2xYF6wwsl99NryXXpiKhOgSprqnW/mYzTCo2n81v0zeh
         faznZ6E+mr77jINx3JOhVTYrde/Eh+K9wVK5cl+DNcttu1E9zJzHnHtXHJCbqP7CJlHS
         mMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746564017; x=1747168817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pprqtj6nNwJ7kvGMAS6wH9Xjmd67CzDbSMXZu91bNsE=;
        b=tnF4S5LLWUNKzBauUnw8APRVkQ8LtgPDKDMQY95sWQcIUbQS+zK9sPYOmY0xR8/coi
         C27UrL0nVx+OLYIrkNrQQjnKRn/G1xrkJ2xKLppLWFSsS7U+gA4pI9Zckvxq/lOLAiJp
         K5zzNhxfclmhzp2Re+R+KZFxjfARxyQhTfL2ha7fp6wFGINVYvJbyC85xbqp4Q12ftKy
         0Altt2lyJUsoj366ytwpKFvIQDuEDsOFaAbg15RTP9+aDoWPX/ioDtBGHZZLfBGD6eUr
         oc3lr61wXS2hvMVSlWOkqi0s+73HqBpHE7g08mUm7Z24Fg58nby/7q2DKgfplGXFAygO
         7Hog==
X-Gm-Message-State: AOJu0YwAffWMDGOhhOLMTNpZ6Cw1zTGbW8s1hNrdQ1X53YUX9bel6/UL
	j+w1fidsvGaTZMFkzJn57BupVcmO1q0oV6wUt+zZpZr+1Y255rH0
X-Gm-Gg: ASbGncvHUrSZIoWmMnYlLijL2sCX+tu2EMfkudafwnLq5BIZIJ2cLULOdPn+Cc+aBBJ
	CFAkb3b7aHNvfSakTkWzFe//SlLQnpEt0rrwKBOfoEaJSbvqlP8JbgLAk4H3GnNf+tzZHtyuVMS
	xuJ1lW2TYgmR8BDLTfFLNwM7Vn7p+d0F4lw2+qGcIQm9j9udhCAvGZSr2T774JGs61evMkGQye4
	QgdCk+QRlMXefVSmhyhcCb4L6uQ87hcxo7NEkfBR2VwvNfL/gFhuAt9B3TIOn9Rx0OoUgVzKmoN
	9TuYnjmWdZ2cinDeDKzsqIdJxpmyr6VKLL6zTuXYddWH
X-Google-Smtp-Source: AGHT+IEF1s7O9vut6ixzO5bv4GCT3R+Po0/p4+ioZsXM8d+LagD0fdM3d1tsS0fQb9+wxwn/G0iXSg==
X-Received: by 2002:a05:6a21:1193:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-2148b526afdmr1023524637.2.1746564017439;
        Tue, 06 May 2025 13:40:17 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b5ace3sm6670464a12.21.2025.05.06.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:40:16 -0700 (PDT)
Date: Tue, 6 May 2025 13:40:15 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Savy <savy@syst3mfailure.io>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	willsroot@protonmail.com
Subject: Re: [Patch net 1/2] net_sched: Flush gso_skb list too during
 ->change()
Message-ID: <aBpzr1ey7MmHObLR@pop-os.localdomain>
References: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
 <20250506001549.65391-2-xiyou.wangcong@gmail.com>
 <krDuBwNbhtDxUlG2tgiXBwSA9KUwph1GfKqwvjBxYDSJv6nVQ98S_inVmQxaRBsndKdgg-rh_vN0xouX4zraF6V3UyQHpWNJUv-rvd-Cwfg=@syst3mfailure.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krDuBwNbhtDxUlG2tgiXBwSA9KUwph1GfKqwvjBxYDSJv6nVQ98S_inVmQxaRBsndKdgg-rh_vN0xouX4zraF6V3UyQHpWNJUv-rvd-Cwfg=@syst3mfailure.io>

On Tue, May 06, 2025 at 02:00:36PM +0000, Savy wrote:
> On Tuesday, May 6th, 2025 at 12:15 AM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > the main skb queue was trimmed, potentially leaving packets in the gso_skb
> > list. This could result in NULL pointer dereference when we only check
> > sch->q.qlen against sch->limit.
> > 
> > 
> 
> Hi Cong,
> 
> With this version of the patch, the null-ptr-deref can still be triggered.
> We also need to decrement sch->q.qlen if __skb_dequeue() returns a valid skb.
> 
> We will take Codel as an example.
> 
>         while (sch->q.qlen > sch->limit) {
>                 struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
>                 ...
>         }
> 
> If sch->q.qlen is 1 and there is a single packet in the gso_skb list,
> if sch->limit is dropped to 0 in codel_change, then qdisc_dequeue_internal() -> __skb_dequeue()
> will remove the skb from the gso_skb list, leaving sch->q.qlen unaltered.
> At this point, the while loop continues, as sch->q.qlen is still 1, but now both the main queue and gso_skb are empty,
> so when qdisc_dequeue_internal() is called again, it returns NULL, and the null-ptr-deref occurs.

Excellent catch!

You are right, I missed qlen--.

Also, actually I accidentally messed up the 2nd boolean parameter for
some Qdisc's.

I will update the patch and send out V2 shortly today.

Thanks!

