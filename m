Return-Path: <netdev+bounces-207243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D4B06584
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C96E7B2444
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80632980A3;
	Tue, 15 Jul 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lreBpZYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC752874F7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602614; cv=none; b=b2MS/hYQZTZXg1reItzfDpy7EUjJ7Hg1uTnMzZ1SIVEqI6xCAwDV+BHo4iVuSv1nfBMdonXUW5sgRKaJdkGMn3OlUz3vEqQHXYg1XQ05G7tdEGzvPv6Tw9ohoTJDka1OKsoGlrNUrDKjcqR/kYMc4jNn53YZwhtuCxQzyGrY9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602614; c=relaxed/simple;
	bh=grONTDHMtYhzrNOx63wyb/Qi6y245xbHXde1u/zJfUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrizhNQSHD9VSLMSxs1uifM0DIDd6JBow1yoCUgGEdAUF/Y/fK1zDM2jvRrdiNKXNQf9ENB5yzdz5nNS2vika7Mr0gQ/bnUIkvagx3FjNuV9ttBcwDHdW8AqRRXHy6JFEaCANYnMMej7cc6JeR/Y6LDg9I+u0unWvHlO8zInY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lreBpZYc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73972a54919so5258290b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752602612; x=1753207412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yD1bNOH0Nq7pNRYMUT7CnE5h/Y2yIsNQdwwE2zDFn1I=;
        b=lreBpZYcKOhb9VeNKES2lShAZtKLSEL/P1fNCjy1hwvWnaoNf/Dk17DsEHsrqKzhvI
         pMvGkpUOkxg8e2ezdVAW9+e/Bz2dJOI8XkrkRAqQX4DBY6JDoOHmlexiuzg5VWzgAYHF
         uyWbd0mQumQ1bwXk8iqfmU/qg5B3MCMCSOIUu4FUPvhRvn0NTfD0XzFgPGbHwhFpFQoI
         hz6ZXGonnbGzyZiotd543XybR56tFspmnYd7QHXdMEefHqTCDlGh3SqxVtBBSj8qYiSD
         WF8E0uK4El/8+SOGm5TgUhYxG7tpQI1eXmHiLv4pmrukNzZG4x+2Sn22o3J78X/B73gm
         CGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752602612; x=1753207412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD1bNOH0Nq7pNRYMUT7CnE5h/Y2yIsNQdwwE2zDFn1I=;
        b=kx6FjwPolLDQsjonlaZ1o5ByH85ocaaLl25ly6HieDE8Nnu/yRKJWMcwQg2oQf/4Ym
         9j7T0AtSgjwixvhttaPDACH0LGTwJRLJWRUH/VL0LcDtCRrlo0QrmOY43dJRavPo4/o7
         SlKOs1vRYx3Fe2+fLRfhXJeC7Fnx03nCtkKfm334FbN+fAsbkpuJppQBkBdbv1MvtZGz
         nmaSeeG4xvLHHJKyQY0QgaHB5vpkQN2Jiz2VG4ZzFU5k94VzzDNHS8Ae0YwYqxVHyvPy
         5ef6up/We3CEUQE7oBM6RuvD6p8g2SoaJhIHPGSKTs3/v3BnkL2ppF9bIV8CY+d/sWOw
         Oe0g==
X-Gm-Message-State: AOJu0YzV2TH4ywcapSEUflA0maB3rXsonxa+DOcZl849QVKNdvzFYrPd
	jo4E7TzMOY3lTLga3Nqa5T+2jW9GnNyFTEyu1MqjkpMOCEz5PxUYC8di
X-Gm-Gg: ASbGncuGHbEG7BEOjxmFET9DS/Ipft54VqmkyKJpHVXEtwiTJoe4mEZVEqf0P9sGUvP
	e0pcYRFgUg6KlaCatP85d4oNKjVaa4wpR43sL4D8/0Oy/NOhlyT6u2fVFwqVQFtuL4NXX0HVr1O
	VrqkJXq7Ia7F9ufQjENRJlHFfjLxMAv+JXgQl/9vl5LZC9I0C/JtPBncE2ekcUnlJfj7NrGB3KJ
	SR4/eZBVt0eoHSiXBnr6DB3Yd+J9oC2LN8boUEbAr5oLpzzKMoSwU1CCiXAIZ4ji12rtwrGdze6
	LCywGVNztVxaTYvUdEJ8c9dLeE2YZevehLqyhnl2o6erGeYyXD3nedSvbb+RRq4ItIqT2wnHZjY
	7+l5RojpMIiaV1NtCNKyvGZpwlA==
X-Google-Smtp-Source: AGHT+IFwlYG2w+pCEclYzgDxXO52cU2EnojbuRv3/4lCn3QCKw9kClBr+Cz/bsyNdwPw7vRfO4gwpw==
X-Received: by 2002:a17:902:f682:b0:234:8eeb:d834 with SMTP id d9443c01a7336-23dee1e8154mr288516025ad.16.1752602612286;
        Tue, 15 Jul 2025 11:03:32 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428b8a0sm115643985ad.8.2025.07.15.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:03:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:03:30 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aHaX8n8o/fLBi57L@pop-os.localdomain>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
 <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
 <pGE9OHWRSf4oJwC4gS0oPonBy8_0WsDthxgLzBYGBtMVeT_EDc-HAz8NbhJxcWe0NEUrf_a7Fyq2op5FVFujfc2KyO-I38Yx_HlQhFwB0Cs=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pGE9OHWRSf4oJwC4gS0oPonBy8_0WsDthxgLzBYGBtMVeT_EDc-HAz8NbhJxcWe0NEUrf_a7Fyq2op5FVFujfc2KyO-I38Yx_HlQhFwB0Cs=@willsroot.io>

On Mon, Jul 14, 2025 at 02:30:26AM +0000, William Liu wrote:
> FWIW, I suggested changing this behavior to not enqueue from the root a while ago too on the security mailing list for the HFSC rsc bug (as the re-entrancy violated assumptions in other qdiscs), but was told some users might be expecting that behavior and we would break their setups.

Thanks for your valuable input.

Instead of arguing on what users expect, I think it is fair to use the
man page as our argreement with user. Please let me know if you have
more reasonable argreement or more reasonable use case for us to justify
updates to the man page.

I have an open mind.

> 
> If we really want to preserve the ability to have multiple duplicating netems in a tree, I think Jamal had a good suggestion here to rely on tc_skb_ext extensions [1].

Do you mind to be more specific here? I don't think I am following you
on why tc_skb_ext is better here.

The reason why I changed back to netem_skb_cb is exactly because of the
enqueue beahvior change, which now only allows the skb to be queued to
the same qdisc.

If you have a specific reasonable use case you suspect my patch might
break, please share it with me. It would help me to understand you
better and more importantly to test this patch more comprehensively,
I'd love to add as many selftests as I can.

> 
> However, I noted that there are implementation issues that we would have to deal with. Copying what I said there [2]:
> 
> "The tc_skb_ext approach has a problem... the config option that enables it is NET_TC_SKB_EXT. I assumed this is a generic name for skb extensions in the tc subsystem, but unfortunately this is hardcoded for NET_CLS_ACT recirculation support.

IMHO, Kconfig is not a problem here, we just need to deal with the
necessary dependency if we really need to use it.

Like I said above, I don't see the problem of using netem_skb_cb after
enqueuing to the same qdisc, this is the only reason why I don't see the
need to changing it to either tc_skb_cb or skb_ext.

Thanks for your review!

