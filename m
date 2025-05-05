Return-Path: <netdev+bounces-187828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D809CAA9CBB
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389E0179D6D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF71DED5E;
	Mon,  5 May 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVQbv4AU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFF1684A4
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474277; cv=none; b=h0EuCyUIhalzrSGyHew71LUlPKcnPZeBHvqSygRh7FPB6w+pyrAlq7qNJY+qeVV/BnQYjLCCe9QUkOgSXNfZx7jFmARTN69i1tX4jY+zeaHWkdnOU/9FJ0iownCvgYT+gMYnGxSpuoPPvdl4MT6avQ4W+43Ncxs3IcplSjXe0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474277; c=relaxed/simple;
	bh=FIU3C15HMdDoIyO04SIlCSqXtCWA8PbBT/0ridkCzsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkSasGlyGostCgr/DLT0l59Z/oAgcBHowv7KDvHzATHS6j9QeoJMeRfYs1w0vEgKOqZoeDYtlS6B2a/kUVQAUYKh2by7sheCZ933Y3wzvbSI5NEIOYfKnRkj8+2AMfXTg7kaEP1ybaR7D9GajHdUcPpq12qPKt6avhqk8lZ/XIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVQbv4AU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af548cb1f83so4652102a12.3
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746474275; x=1747079075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8b2RS58kS+UBOT9kP3uDOYyvhTTboqGcQTIlcuEiNY=;
        b=SVQbv4AUvg/GvVK10vq+QpJhOSf+l8g23YzyceRfj8V06frIvfhvsV+g3mI9jxRn/g
         A8aDS1HUStYQUF0/VWDiz3YboyzO+bs70UBHmEphTxk3aO9FwD9/z+qA5JjF2V6yhjMg
         kYcmKfQ6ddAKbRjqzvIV9hXoeCVHZHH+vKli3uAtLEdg8EwdhxXD4EljHcdB2H2pCL5Z
         DxNuXOdtePYxuExGTFiEoy/RSNUTyoCwzw/ApogQI5I0kukuJCzHdWr05y1v4GoTAv+O
         9QqTWlrj69tAwxryuFo5yEGKfm017q5pRpMle3TFbw9foxaEygAXeWepJv5GKKPXYyTt
         4S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746474275; x=1747079075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8b2RS58kS+UBOT9kP3uDOYyvhTTboqGcQTIlcuEiNY=;
        b=gTq0wbUIBFOc35UyskCYpEvS8un2LlAMvJDWAQ1zDLZec59JYuWIOV//xk5THxpKpD
         ei7QWqbNa8Zah/cYithjA2Pj4otDU1CALHwLtERRu7VmQhjhh/PYIdyu1qwrwIoUoejU
         0+muA4vI2xT4XCoVj5Yhon4l7F3zjuC6CljhuZ8GbMLfo8/0axtb5sC0gQdUb/SXFVV+
         SRugknC9RiT31c2PGa6vouq2GABcW+J9s6eHstooX5AKcpWiYkOov2JhRB4mGGB6M89H
         gk/cNHza/1gj8tlawB5CzIMfSwSGGEEMOm/SXtOBzN3EzvnZ/nK98zWw2uwx6zenYo60
         +COA==
X-Forwarded-Encrypted: i=1; AJvYcCVswAqJIOWNuJbDe9D7TOisDmw9IAnbvPYAOmlVZPNSYwNA+HKakT8G33r9F9FSeQlzCzP6LyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOAe3C0sjifyAZgc1HSeJVxfPVGshpa1nzVXVY8xxH6b9qMll
	QTtayu/HK4J4fZNnJnay+YAXFy6rkLB7DcPGCie4BZfbCQdlmd/P
X-Gm-Gg: ASbGncudXJUvs6WD+Ne+XXcFM0l9dc5n8zppMk4gPn/7z8zy7ifDRzxaRbf8FrSsmwC
	O+XhHOqCHEzxvwJSCtc6f3hR5jZa/Ayvj7r+mLw1FiY0wvls2+ghrkeA7D7mv6k2m2UD5Ysk9Wd
	CErhVZ6ZxXmdDq4HGBF8oA0emqfhACyKOXy/88cKo9q/S9wYCmhA5sZFOP2KiaG9rqMF2PBnY89
	w2H9j+oXfPisTljFtDqUW14H9dTRCr9wefmAOZnkrj2Zj4YyaZsPgrBmP/0rGInc5wUaHP8WkCp
	51vSY6tzpd2EVafyGu69wYeTGrLrT2Ac1OFtAUpNg9yb
X-Google-Smtp-Source: AGHT+IFh3h/cLhKscWBMuZI6rfCG02KLjLiFWUzh4I7s4mk1wE91lg4v57jg0tlbLLOHvDmKBFIq4g==
X-Received: by 2002:a17:90a:c884:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-30a7c09e74cmr1159194a91.17.1746474274916;
        Mon, 05 May 2025 12:44:34 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4747681fsm9436696a91.12.2025.05.05.12.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:44:34 -0700 (PDT)
Date: Mon, 5 May 2025 12:44:33 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Savy <savy@syst3mfailure.io>
Cc: Will <willsroot@protonmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, jhs@mojatatu.com,
	jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in
 codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <aBkVIY4GZBnrolrq@pop-os.localdomain>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com>
 <aA1kmZ/Hs0a33l5j@pop-os.localdomain>
 <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com>
 <aA/czQYEtPmMim0G@pop-os.localdomain>
 <EBHeQZeq5AJteszZoHrsiJv6EGOnuByQ-XNejgA9WiqQ8g2jIXowzoGjuJowDcV6xi9xBgyMTwNlS8wN0zUOlRl4Bl2Mv-x883IKCvdySyU=@syst3mfailure.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EBHeQZeq5AJteszZoHrsiJv6EGOnuByQ-XNejgA9WiqQ8g2jIXowzoGjuJowDcV6xi9xBgyMTwNlS8wN0zUOlRl4Bl2Mv-x883IKCvdySyU=@syst3mfailure.io>

On Tue, Apr 29, 2025 at 01:41:19PM +0000, Savy wrote:
> 
> On Monday, April 28th, 2025 at 7:53 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > 
> > Excellent analysis!
> > 
> > Do you mind testing the following patch?
> > 
> > Note:
> > 
> > 1) We can't just test NULL, because otherwise we would leak the skb's
> > in gso_skb list.
> > 
> > 2) I am totally aware that maybe there are some other cases need the
> > same fix, but I want to be conservative here since this will be
> > targeting for -stable. It is why I intentionally keep my patch minimum.
> > 
> > Thanks!
> > 
> > --------------->
> > 
> 
> Hi Cong,
> 
> Thank you for the reply. We have tested your patch and can confirm that it resolves the issue.
> However, regarding point [1], we conducted some tests to verify if there is a skb leak in the gso_skb list, 
> but the packet remains in the list only for a limited amount of time.
> 
> In our POC we set a very low TBF rate, so when the Qdisc runs out of tokens, 
> it reschedules itself via qdisc watchdog after approximately 45 seconds.
> 
> Returning to the example above, here is what happens when the watchdog timer fires:
> 
> [ ... ]
> 
> Packet 2 is sent:
> 
>     [ ... ]
> 
>     tbf_dequeue()
>         qdisc_peek_dequeued()
>             skb_peek(&sch->gso_skb) // sch->gso_skb is empty
>             codel_qdisc_dequeue() // Codel qlen is 1
>                 qdisc_dequeue_head()
>                 // Packet 2 is removed from the queue
>                 // Codel qlen = 0
>             __skb_queue_head(&sch->gso_skb, skb); // Packet 2 is added to gso_skb list
>             sch->q.qlen++ // Codel qlen = 1
> 
>         // TBF runs out of tokens and reschedules itself for later
>         qdisc_watchdog_schedule_ns() 
> 
>     codel_change() // Patched, (!skb) break;, does not crash
> 
>     // ... ~45 seconds later the qdisc watchdog timer fires
> 
>     tbf_dequeue()
>         qdisc_peek_dequeued()
>             skb_peek(&sch->gso_skb) // sch->gso_skb is _not_ empty (contains Packet 2)
>         // TBF now has enough tokens
>         qdisc_dequeue_peeked()
>             skb = __skb_dequeue(&sch->gso_skb) // Packet 2 is removed from the gso_skb list
>             sch->q.qlen-- // Codel qlen = 0
> 
> Notice how the gso_skb list is correctly cleaned up when the watchdog timer fires.
> We also examined some edge cases, such as when the watchdog is canceled 
> and there are still packets left in the gso_skb list, and it is always cleaned up:
> 
> Qdisc destruction case:
> 
>     tbf_destroy()
>         qdisc_put()
>             __qdisc_destroy()
>                qdisc_reset()
>                    __skb_queue_purge(&qdisc->gso_skb);
> 
> Qdisc reset case:
> 
>     tbf_reset()
>         qdisc_reset()
>             __skb_queue_purge(&qdisc->gso_skb);
> 
> Perhaps the skb leak you mentioned occurs in another edge case that we overlooked? 


You are right, it is inaccurate to say it is a leak, probably just a
matter of ordering, because ->gso_list is logically the "head" of a
Qdisc.

> In any case, we believe your patch is technically more correct,
> as it makes sense to clean up packets in the gso_skb list first when the limit changes.
> 

Thank you for testing! I will add your Reported-and-Tested-by and send
out the patch.

Regards,
Cong

