Return-Path: <netdev+bounces-178166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8801A7517B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962C63A3A31
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BD31DE2B9;
	Fri, 28 Mar 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGH5Vrf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A352BA3D
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194123; cv=none; b=h8jkZnG2zW4pdC5xUf5i+qqtGDdFv90l7+rhY0W806jRTwjYS0CTu7UxwYsIzcgulFPM1t/iK4by6qA+imzH7S9JFyvkIZp1mpt2wev5CxWc/lK89POWKpRhrT1J7XFo+Ehg6MWeyaAEr3XQRi3QgTIPzyUOhZCWdSIQNiS5eTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194123; c=relaxed/simple;
	bh=PM6Z62MfR02vKSpMy6sfN/nCyMUKzAJ/XHGNJ035cqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFVYHyZnki0gkmkP9XjSObpbXbYfFGFT7a49mwsbTX7whGKVon1hISH9/42DGU6NDDKmGS8t5Z7cqQ/F4VYrVuoct5yRqOPDj0V/WIzDzaBExp9zFblMjlMtCrPbc6NbYZ++bSXM+EPatJfATZXywTiXaDh2GE2XEbFq4WipMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGH5Vrf7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fb0f619dso54994265ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743194121; x=1743798921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiVDZDo11D1xeuShSQAOHmn6RKHHazRapU0u1otqQ2M=;
        b=KGH5Vrf75PxFXbdtjD4jz/vez9o7cNLyF37A5kw3Nd+LxTmYcTbqK4oyOKNkZicbdE
         NlbQCJxkQsg7XH1HwQQUTiMrbcsUehoks5qB8t5WX8ZmtoooxhWmgQmRbomrtMyIh9Na
         pcfnbtrTQuWdqhkvVqb4ry1MRQdt67TfPVVAbuzQV4Cep847LRYlNIAMWT/toYFcJvk8
         XvGwZsZKxQNloXxJDK90pxPbnL+2uMc/hooXRNLGaFzbBkOgWLK85QkPBSW5nheTIOIn
         6MrlMAbbkvibDpoL3JEgG2YdXdbZEBugKnoxdk3rp2ovfotIn5IaaMdAjvHolTUPjTxo
         uVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743194121; x=1743798921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiVDZDo11D1xeuShSQAOHmn6RKHHazRapU0u1otqQ2M=;
        b=waLMskhXKdKc/RbUWv2CG5YeNipEy2Nd8KBscIWt/FEiC9miZ6zPfl8VBuv7Cfdvbf
         WuRa4K5ODrgWB9zXpLfCzLxIyniv6+jGRn6dcHj3kWFO0m6GTwkaf51SFdHSII03SXn2
         1gaGkGuMRZ4/GxjMWkYslIPCkFGtGJpJkrAGe5eHvT53wN7LFPfkeLzh+rj1lhDvR2Zn
         SewTbUr2Bg5Z1OC3B44HRAAvca5zh+p/fF/O3yF8k/brnh+4Yxklv8s9nKYvLevBrKK7
         HR0lkiP+1M2ii8ysMNx/OqmqDmosifB3CWNuP8ltiReJKLqyHJxdIx6Jb6VZO2qdHU5A
         dPRQ==
X-Gm-Message-State: AOJu0Yy4UzZnYDmFpNjJIpK/P2dkR/N14UeKZ9YjurEK2rVSA+Wzw8/w
	Ju2OrpEfNfjaNfPwmGXOnIh4lKqRI4NoJ6L7aAqMDfjyLuF6vgo3NQ4MUcCe
X-Gm-Gg: ASbGncsR3nQhRKiJBXkiBkb9wxbhRxoXwCQ4WNS2bob2vbubxg7ugHXInMYUb4T1mpO
	L2TPglZ9YRUmK0nMkiMT/FmV9RqvBS9OCJgs5AtQggLrNoxTLZ/xZtP86Pv145QvfA3MF2bwIL1
	EcevlTjx2MbWAK4MU3xmm9kCzCfMTWt9wDI7CwoXCx8jbVXMsEV9V2+skWXQppapVlQPhI3sMWZ
	YErzqwJiF01AtjmOz7uffn1GsRXqm7tq9ZzDH6ltqKS6I6OKIXqg19G0CwVp3AWGLFs3T9s08ej
	gXP8J/kUYZRphLky1JI+7LFljfu+m9jmzRb+DH+cUHE9eYVF
X-Google-Smtp-Source: AGHT+IHFBID8oywZPQcQ5PtHRQ0ZkeaJ/mKCPQhAPek6Yltf/E2lmdoBzvxOPilf87A+/1Zjm/vhfw==
X-Received: by 2002:a17:903:94e:b0:224:1c41:a4c0 with SMTP id d9443c01a7336-2292f944b84mr10498525ad.9.1743194121316;
        Fri, 28 Mar 2025 13:35:21 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df01csm22698305ad.178.2025.03.28.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:35:20 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:35:19 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	edumazet@google.com, gerrard.tai@starlabs.sg,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for
 CODEL with HTB parent
Message-ID: <Z+cIB3YrShvCtQry@pop-os.localdomain>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-8-xiyou.wangcong@gmail.com>
 <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>

On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
> On 20/03/2025 20:25, Cong Wang wrote:
> > Add a test case for CODEL with HTB parent to verify packet drop
> > behavior when the queue becomes empty. This helps ensure proper
> > notification mechanisms between qdiscs.
> > 
> > Note this is best-effort, it is hard to play with those parameters
> > perfectly to always trigger ->qlen_notify().
> > 
> > Cc: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> Cong, can you double check this test?
> I ran all of your other tests and they all succeeded, however
> this one specifically is always failing:

Interesting, I thought I completely fixed this before posting after several
rounds of playing with the parameters. I will double check it, maybe it
just becomes less reproducible.

codel is indeed the hardest one, since fq_codel has a mem limit we can
leverage. (In the worst case, we can drop the codel test case.)

Thanks!

