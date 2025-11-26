Return-Path: <netdev+bounces-242101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2FC8C4D4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9760D3492F0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33B301718;
	Wed, 26 Nov 2025 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by2F9uk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F318CC13
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198823; cv=none; b=cvcx8nhq/uW4eMCfjzFnxeyJN4iGGeAZjzOROZ6YJEiDzCmnm+C5M0L3YHBa9aVvaQovx92x77wxod78+CUpAPctsRqLjXGwsHHfTcWNgBM636I/O4uHApN4H6UL480SbtEwI2/ZY0eahDrZ0T/y4s9ZnwHVisatg84Vp7pwR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198823; c=relaxed/simple;
	bh=xO67hytYTZ2V1rW02DaW//wluzqg5Pq8v5zCckzDt00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtqoGOmS3isCCRo2kroAujoTME5Pn8XHGYfNmKzur34F33frGMP67xNv6d0G2cG+pZUT+cyiSIXcsaXBroOK9efz4a6fYoxfWJyfKbdjRA07XYDOIXYMqtnAUKRiZnxxNT02vx+qN7t//rrkQCwgRvKykjINc6Pv6vMKTqT47lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by2F9uk7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso183477b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764198821; x=1764803621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8rK2X9O0vFmHyb3W8i87gN+YyshwdGgH42cvBO9DN0=;
        b=by2F9uk7wA493+apDWcrEcc1BMGJQRbVBj8MA2nzs7ixyHPVUgw6pnCpdqL/GXsXFr
         cdZo91bWsCyKjdw5ZS8C8X49BT3NvQtaYPzSP5nJUhI+htxrDngdMPSRVrwXxnHg08ct
         pCWQ3jDukOajfQEygAEQf9qGf4nwdiCRIjXpDz5Z5hOhWabgUF/oelMeJlygZeytJnEr
         gclfmlLqrhyd1aqL5HzuKQY8aB0vz4JymdvvGISjUVb8MwPlYl/yT/I81kuXWPDoSoP+
         mTNE3LVECu+tH3006gWAcfb/aUStYHmm2CXpKuCFeoebB024hMOfIDCg5Zg5GNxIFxAh
         vHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198821; x=1764803621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8rK2X9O0vFmHyb3W8i87gN+YyshwdGgH42cvBO9DN0=;
        b=NoA7BiEpcMT6O1Jh1tA9rHLpcrcx78spZ3+BTCT+nWyafF4AygsnS41pl05+RPUWm2
         mcbPYm4HvxXowlyjo4Ma8job+lhZp4osFRGHHUzdWYgaWuVq6E6Ftp51WbyHKscRSwwz
         YpKaE8seVaMF8X9a3xCa5xLK1MTx1uf/e+gEwez/ZZpHQPyqyiK3/Pi4d2X7hFzp8ECV
         yLkM3q+R3ft+W4DYsdRhZ8KskhkSmOckV4e/PTENFUPHA5rSRKNRDPJPF1lIXGZokIHX
         eHg7Ph0e4+jpv5S4wlHLXAfHS1Q7+1CKzBNl0eUQWPXXyFmvyl62pDWGQUgAzy1zPBqM
         ufaw==
X-Gm-Message-State: AOJu0YxDrti+J1VN49GXB4laIt7Nbki/O/yrSWU8o6zFiNSIsEIITA41
	tG7wGpWWlkp7VDqL60mbuPX72w1faYCFsQYMFfS+ZgGmyYAAvFV9fI8D
X-Gm-Gg: ASbGncvjYXFaCSjAd4wJC9z29f/nPiawJSrGv1Zlx0TqEyJ8IqEr8Ypv933ijqjGttw
	PAX9/6MSkxLev+YZ6cmQ31BGfkGH5vxrBDeDuqwY1nWKmkaLPXKavRmauULdFhfy6ZRWBRyuuMd
	4GhQmfpHG6H/Lge4SqAYP7em92lscf4Zb9yvGhXq3/FASX5fB/zWfnGmuXNB8rduPC7AImX0BPw
	ZjysTyKCKr5QQrcL3uquitKBtatNjrJf1lVv08adpKXgBXRnFmMHr4LRfZBnTsJw3gyRSuIEHHH
	xq2sJym3pp9GkpVDD0IrycY8KomnKWtr8vEgtclbhT7tlyn+v5AbD8GC70li4G0dtSpnt5xbiu5
	bxfJyZT4kGVM32nI/qlNpG4h2YDJJP7Fxhx+bFgakMZqaPJMeBtulNSylXstzOQLH/mckzVuNTr
	/Uq0qaU1PBOQpmoIE=
X-Google-Smtp-Source: AGHT+IFxC5pelBMzNRrfB7k99KA3yefZAmqF/d/EbbSziycRFUlFhx68g+jEapYypoPBTA6ZgMQljg==
X-Received: by 2002:a05:7022:ec0d:b0:11b:9386:825b with SMTP id a92af1059eb24-11dc87b150cmr1068585c88.48.1764198821164;
        Wed, 26 Nov 2025 15:13:41 -0800 (PST)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de82c1sm71680815c88.3.2025.11.26.15.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 15:13:40 -0800 (PST)
Date: Wed, 26 Nov 2025 15:13:39 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aSeJo5C9tA93ICcy@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-4-xiyou.wangcong@gmail.com>
 <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io>
 <aSd6dM38CXchhmJd@pop-os.localdomain>
 <JgkxCYimi4ZuZPHfXoMUgiecvZ0AKYxbIhqPQZwXcE4yC9nYnfproH5yrmQETZUo55NOjj5Q9_bOFJbWI351PFvc9wv3xiY_0Ic9AAsO1Ak=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JgkxCYimi4ZuZPHfXoMUgiecvZ0AKYxbIhqPQZwXcE4yC9nYnfproH5yrmQETZUo55NOjj5Q9_bOFJbWI351PFvc9wv3xiY_0Ic9AAsO1Ak=@willsroot.io>

On Wed, Nov 26, 2025 at 10:43:07PM +0000, William Liu wrote:
> > 
> > If you have a better standard than man page, please kindly point it out.
> > I am happy to follow.
> > 
> > I think we both agree it should not be either my standard or anyone's
> > personal stardard, this is why I use man page as a neutral and reasonable
> > stardard.
> > 
> > If you disagree man page is reasonable, please offer a better one for me
> > to follow. I am very open, I just simply don't know anything better than
> > man page.
> 
> I agree that your change does not violate manpage semantics. This was the original fix I suggested from the beginning, though other maintainers pointed out the issue that I am relaying.
> 
> As I wrote in my previous email, "as both Jamal and Stephen have pointed out, this breaks expected user behavior as well, and the enqueuing at root was done for the sake of proper accounting and rate limit semantics."
> 
> The previous netem fix changed user behavior that did not violate the manpage (to my knowledge). This one is the same - you are fixing one user behavior break with another. Both are cases of Hyrum's law.

They are two different things here:

1) The behavior of "duplicate" option of netem, which is already
documented in the man page. This is why I use man page as the standard
to follow.

2) There are infinite combinations of TC components, obviously, it is
impossible to document all the combinations. This is also why I don't
think Victor's patch could fix all of them, it is a simple known
unknown.

For 1), the documented behavior is not violated by my patch, as you
agreed.

For 2), there is no known valid combination broken by this patch. At
least not the well-known mq+netem combination.

I am open to be wrong, but no one could even provide any specific case so
far, people just keep talking with speculations, so unfortunately there is
no action I can take with pure speculations.

I hope this now makes better sense to you.

> 
> > 
> > Sorry for my ignorance. Please help me out. :)
> > 
> > > Jamal suggested a really reasonable fix with tc_skb_ext - can we please take a look at its soundness and attempt that approach? No user behavior would be affected in that case.
> > 
> > 
> > As I already explained, tc_skb_ext is for cross-layer, in this specific
> > case, we don't cross layers, the skb is immediately queued to the same
> > layer before others.
> > 
> > Could you please kindly explain why you still believe tc_skb_ext is
> > better? I am very open to your thoughts, please enlighten me here.
> > 
> 
> Yes, if we re-enqueue the packet to the same netem qdisc, we don't need this, but that changes expected user behavior and may introduce additional correctness issues pointed out above.

Again, it does not violate the man page. What standard are you referring
to when you say "expected user behavior"? Please kindly point me to the
standard you refer here, I am happy to look into it.

> 
> If understood Jamal correctly, tc_skb_ext allows us to maintain both the re-entrant at root behavior AND prevent DOS.

No, the whole point of this patch is to change this problematic
behavior, _without_ violating man page.

> 
> I hope you can understand I am trying to relay problems other maintainers have pointed out repeatedly; I personally don't have a strong stake in this.

Your independent thoughts are welcome, no one is absolutely right, there
is no one you need to follow or relay.

BTW, I already responed to them. Please let me know how I can be even more
clear.

Regards,
Cong

