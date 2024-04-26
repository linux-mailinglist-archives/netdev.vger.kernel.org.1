Return-Path: <netdev+bounces-91680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B18B36BC
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065B01C21DD9
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C121144D3F;
	Fri, 26 Apr 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzTB5ViG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295C143C70
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132284; cv=none; b=AN3CnsuwM6nEJPqYvL0yqnlSZI+mH1/T0pAUsN187Mu8UsOS3DRQRLgR0YzXiU9pPgTMD0DZS3SWTbuZ7RysfDRPqG+jHPts6pac7Eew3Yp9b8eTpxyBdtevIKS/fMGWOxLRjvCNW9CFYaEPAKpS0qyj/nh1lsKsvkFXVvQMps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132284; c=relaxed/simple;
	bh=VmIPSWi0MXfvMqlZmLGcUP4LbXsyQ7N36GwQUATgYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLx2neO/d71mNsDDu/vGS5cihFT8iVDZiQwx9b1uI1j/h6tS9AMD5NJ0GpSO6SKSJh+KG9QmrwBrlSQA1dKDk2YXvPSmiRJ+imr3Ews0RASQmIBzuGheivw+RNNOVJ7ERc/1PO9YiQgD4YEwL6pwMShGCNZj0/kIYEGvqi/c1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzTB5ViG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso28478681fa.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714132281; x=1714737081; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IpMXDXCY61hSAyAXAg7p81EWz11ZLARqtD9KzsHp5gg=;
        b=bzTB5ViG3yO1yGuujHRrNXZwwVOFi7VNkm6xs5BP2TFoW7pRSip0fGyRIUFKtgUGH/
         J4ticOGpZ6DShC/SOYRlbz0KIp1uTKGVBLRIaY3yNDKpF/cWbopPUQJY57H3FCIK8XyS
         Srju5vyU3mQwZeKlLVHSenr+AYU+G8sgh26x4dCBwkVL9dDKAorTiozTdmASIB/t9A+p
         UYezJO4U4OjOBumNquDLk8Hu4W3EeZ/4iDy1N/I/w++GsljI4r8hC9koLd6WdfqFTssU
         pA5jUyHDO8L2Y3+qVRAfO/b3yi+NAY1Xyr9wQQB/uBthBgkTLArkvvSwjikNwytBFrYM
         f72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714132281; x=1714737081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpMXDXCY61hSAyAXAg7p81EWz11ZLARqtD9KzsHp5gg=;
        b=pb2TLlPYmHWZKUtHSdUpNb+7CPa7P25MN9nf6mbygqiVPTmK5oUQADuEV6aHlLTFA4
         lk4ZzFQ8x/VaDYXz5dQ0yqzTX79U2TWt4c2ofay2kZhgL/780Ra9XyoG4vc6eJ3dico5
         BHp14NeSFF9nqUIrKusfKGZDnnBHSipDU3bLZjgRkP/pP4Ez8zUGqgSLENLuKnspRuOI
         04D09Tnj4xEnJJwMxIUkNS7cclw3b58vNHY5E/LGURPNZ09bLAH7sSN1znHaWswmzzu3
         NSLBBP3hSRxBs3Wnd03m+YhxAPDTsbW3J44nYIHhH9lbZrBtRD2huP+hqz3EbdQK/oYx
         ldgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiSrRK6clGodPOMHogx2C/U5K6+FL0uQiU8UyMUq9lZFiGFAswmcH2FubV2ld8WDSgunvSVj3q/uhhGnwr0PZ+HBk5Nz9K
X-Gm-Message-State: AOJu0Yy1cAiLNW98sYnjVYZyvHT+6SbkRxUxeE7TD6BU/ubw66rqth0K
	sxZBPgDVN8tQuJpG05pFkeAQXZutHCmlQdFG+wEK/4efBiRwjeAn
X-Google-Smtp-Source: AGHT+IFLt8vTULyrxCrpY42BbujL7W9aUP2UK8HuVwbMoqcY19dwx2D+WPeBPKJhbjRYzm5f1AHu0g==
X-Received: by 2002:a05:651c:4d2:b0:2df:827d:870a with SMTP id e18-20020a05651c04d200b002df827d870amr458586lji.13.1714132280481;
        Fri, 26 Apr 2024 04:51:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9f52000000b002d9ed7ce8c9sm2602068ljk.74.2024.04.26.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:51:20 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:51:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 00/15] stmmac: Add Loongson platform support
Message-ID: <qxby276tzvf7v4qip6q5soqziiutdxuoxum6kp5t5imokysalq@truwa4cbfm44>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <go6zgo5mxqscourw567e756tngt3xpbrnuqsid4av2luu4zkfm@h6xjnlosexwi>
 <21325271-95bc-41b9-8f9e-53b744369e79@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21325271-95bc-41b9-8f9e-53b744369e79@loongson.cn>

On Fri, Apr 26, 2024 at 12:55:34PM +0800, Yanteng Si wrote:
> Hi Serge,
> 
> 在 2024/4/25 21:19, Serge Semin 写道:
> > > v12:
> > > * The biggest change is the re-splitting of patches.
> > > * Add a "gmac_version" in loongson_data, then we only
> > >    read it once in the _probe().
> > > * Drop Serge's patch.
> > > * Rebase to the latest code state.
> > > * Fixed the gnet commit message.
> > V11 review hasn't finished yet. You posted a question to me just four
> > hours ago, waited for an answer a tiny bit and decided to submit v12.
> > Really, what the rush for? Do you expect the reviewer to react in an
> > instant?
> 
> I'm sorry. It's my fault.
> 
> 
> I did this because I didn't want to repeat the v8 process, we talked about
> v8 for
> 
> two months, after I collected all the comments and changed the code, a lot
> of
> 
> changes happened, and I seemed to misunderstand the comments about patch
> 
> splitting, which made v9-v11 look bad.
> 
> 
> v12 is actually still based on v8, but it's just resplit the patches again,
> maybe
> 
> it's easier to review,
> 
> > 
> > Please understand, the review process isn't a quick-road process. The
> > most of the maintainers and reviewers have their own jobs and can't
> > react just at the moment you want it or need it. It's better to
> 
> Yes, I quite agree with you. In fact, we have been working together happily
> for
> 
> almost a year. I appreciate your patience. With your help, this patch set
> has
> 
> gotten better and better since the beginning.
> 
> > collect all the review comments, wait for all questions being answered
> > (ping the person you need if you waited long enough) and resubmit the
> 
> Yes, I understand, because I also do some kernel document translation in my
> 
> spare time, and I understand this very well.
> 
> > series with all the notes taken into account. Needlessly rushing and
> > spamming out the maintainers inboxes with your series containing just
> > a part of the requested changes, won't help you much but will likely
> > irritate the reviewers.

> Ok, I will reduce the frequency of my emails unless all comments are clearly
> answered.

Not all emails, but just the series _resubmissions_. It's much better
not to rush, make sure you got all the comments correctly and resubmit
only then. Should you have any doubts, just ask and wait for some time
(day-two-three). It will be easier and much less troublesome to fully
clarify things first and then send out a close-to-what-was-requested
patchset - less emails traffic in the inboxes, a discussion
concentrated in a single place in the LKML archive, more happy
reviewers/maintainers - less meticulous notes.)

> > 
> > What do you expect me to do now? Move on with v11 review? Copy my
> > questions to v12 and continue the discussion here? By not waiting for
> > all the discussions done you made the my life harder. What was the
> > point? Sigh...
> 
> v11 is not much different from v12, except that it removes your patch and
> then
> 
> resplits the patch, which improves the review efficiency to some extent.
> 
> 
> loongson_dwmac_config_multi_msi() is the only comment left that didn't end
> in
> 
> v11. I originally wanted to include this question in the cover letter of
> v12, but I
> 
> did send it in a hurry and lost it. I'm sorry about that, let me copy
> this question
> 
> to v12.

Ok. Thanks for re-submitting the MSI-related discussion to the
respective patch. I'll revise the rest of the v11 discussions anyway
so not to miss the notes gist and get back to reviewing your series in
2-4 days.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> 

