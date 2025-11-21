Return-Path: <netdev+bounces-240891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A1C7BC72
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97473A1D6B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AC2F1FDF;
	Fri, 21 Nov 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCmikz44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023925BF13
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761510; cv=none; b=HiGI/zzfTwcKz8GKvyro9hsLdJCmma0wtct4hKXzixryFN8ToZi2LyuIeHGDDXhT63+dP9Y2muYpAuDGeGWYo54OtzOezpyZird1t0E/XUNZWSwxcIR94oYOEB3Z6OA1LlclAZPrV5KuX7/e8IRIiiSpIWsGIS0IJ76NcLi8UXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761510; c=relaxed/simple;
	bh=z32DxN9Kav0WRSp/vWWaJx+CSfTvxmwQvBBcHkdhVIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfRWBx0ZK/yfdWiOwBfi5FudXLOjyAJgt5AVrb8+9IF09gqv9R5zStP6Qyk1H4UQj97Y+rkM8QIe6quBe5QpTcP+gU1BfMn/81s9SBrZOlZsx0UL+I1zr/yMHQE9nF1xhA/8ixZtT57cidCus5D4qeTyj+A/+cc0K+Ew7PmeIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCmikz44; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso1938900a91.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763761508; x=1764366308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA35fyFgQqF+6EpWpt40SLAwIUfNcrBfwMFg6EWMc14=;
        b=mCmikz449TlahA1kGLsduWyNUdagerXjH4Ohq345eVtKpvW5no7pf3hG1OeLxyzTzt
         UAWM0m9YoQ6mKKgLmxh1Ng+sB+QNJ2kyljHquLcOjmhsqIAwrWrHVYq8hIls+8ShRQJL
         XMFyDFN6tj6C3P05uU0IIq21pqIAau3/Ne5o4/moTmuePSw5+DO0+ByQezIfEwshPPqg
         b4UmBFj84HyXh78nIvZZLTzgDjstQNrdSPIPxA2fJPvTQuJINviO7Sk4NzLC+TnJTSF2
         7cCfWdpLNb134LlQAo1S5dUUaSGu3KwWSuxhyANUyyo2TcCy4roPZhDwvIO24WZ+kyi3
         YWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763761508; x=1764366308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA35fyFgQqF+6EpWpt40SLAwIUfNcrBfwMFg6EWMc14=;
        b=CL/lTShNErCmqPmc5JgtvtvJGZPgOqlSwcu1MZ51MtpG3v2H0j5uOw9N5ZPKyZUPoF
         YvileqqlduG2ByVtqeDgy42apDbC/jAFbMBi/R3MaaodNVTZ8gCZRWgyI/CM6UmA1Cf6
         /Wl6Fahe15PnAHe+xuoeRM9tC1DQG4lrj3pjes9ThFZj91id9KMjV3f9eaGUITgcRfFi
         kjoE92+Zw3IiZNZqqDB6Bokoafm0AdQsukhpZ+b9d6NfNXXNcsleBR2tIRKWg0cVl8DB
         Wko3Imx5Ze/7VXDKdx+NjqjxQUdQ+plx0mJ/+5fzBgpl9vpyL34kfFB4LZLyuJVP0iD4
         0XSg==
X-Forwarded-Encrypted: i=1; AJvYcCXjDaqCtpwA4rhh3ltpZX53rWrWEYTnCSg7ZjOjAjOSs2bEZNLIqZgDSKhTBjxMZ47VS7c8U+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0nyusnIV1GocGwRH1g69D1GdZ5PWt6MMsrJ/n//I/R/AdQ7f
	8UeUkBxdpzPxr0WqmaVvu7bUP4dth2EKRS7r72ppuIPbl5B4Z4pdb0KtKYIQ6gFQ
X-Gm-Gg: ASbGncuoC0aJmwEK6RwKXsRIzjRmhGLIj2BL2Xe3c0aJ8NoPvDqYRfVIduT8YHplqAu
	Jg7bHrqsXTvBc36RegyRC6gt5mpSRlCkzGs0kkpi0s/sA3HZUjftxyu0xTRthN38ad02SIMXRaZ
	Yz3C+KTFWsPCc6fiRzovsPUMh11h7DUCQn3a4zIJbZ/Sqy4AfzMT/qZ1FtG1C4JRqpIeRAtOtJF
	9f4Q3k6JxXJ1t0Ek+hDaHkIJxjarzhvxSUIV2H3xibPgLBZi2hF7fdnFfbTyUa48+7aqP00e4G/
	69rLTzJqzUuBjaqjHV1C3zqRhPtWxpn7E8eHcQRibyf1XVFLG0SdBrrn91Gx6+PK8ZfPkroh8oT
	B+m4NYrgYDrArjpwvxlUZSMT1JF3BJvs0tQPzJdWkjX6FU/p9/qZWX8jNGWk3o8YugRDbu+IW+q
	c+o5p0lqTIZ8pQ3N9UeA==
X-Google-Smtp-Source: AGHT+IHV20MUVFR0tW1JyhJDw13+ZGu2Jkakr20yl3aunFRu/Zp9lycQASHhyd/zr3dXUuPMBLITWA==
X-Received: by 2002:a17:90b:3fc3:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34733f21e4dmr4516482a91.20.1763761507633;
        Fri, 21 Nov 2025 13:45:07 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:8181:ad0c:6a36:c3f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0384abfsm6351817a91.4.2025.11.21.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 13:45:07 -0800 (PST)
Date: Fri, 21 Nov 2025 13:45:06 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, will@willsroot.io,
	jschung2@proton.me, savy@syst3mfailure.io
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <aSDdYoK7Vhw9ONzN@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
 <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>

On Fri, Nov 21, 2025 at 07:52:37AM -0500, Jamal Hadi Salim wrote:
 
> jschung2@proton.me: Can you please provide more details about what you
> are trying to do so we can see if a different approach can be
> prescribed?
> 

An alternative approach is to use eBPF qdisc to replace netem, but:
1) I am not sure if we could duplicate and re-inject a packet in eBPF Qdisc
2) I doubt everyone wants to write eBPF code when they already have a
working cmdline.

BTW, Jamal, if your plan is to solve them one by one, even if it could work,
it wouldn't scale. There are still many users don't get hit by this
regression yet (not until hitting LTS or major distro).

Regards,
Cong

