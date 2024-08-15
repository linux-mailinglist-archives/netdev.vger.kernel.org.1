Return-Path: <netdev+bounces-118963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39D953AFE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BD52837EC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B982876;
	Thu, 15 Aug 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D9ya+FeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883474059
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750868; cv=none; b=vBgJP1W8/K+yyI3IAuncfxWMOdTt8I36ZVES/I+ykRhHLO3wH3NlG6HluE/aQMSuVuLc9AuqOeVRk9RsNfccIoIBkJrbmmVn72yJSub9Q4IEojtVu6fWEuQxFNfgo9ccNwe3IF9ysk2fKhA+SSaM9/VbhyvlXr5zB23mVG1kkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750868; c=relaxed/simple;
	bh=SQVdiSZVhvqVY021468Cudm+F/E+dBACe2JM6+6lVvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Jxbze5iWoRDZozsLhX/AYrm3LJGpPeHvFFN6Cnfnx8Bf3qMG9VTOQt+nBj6fqrmyP6W8oCjDrOUqBg+mtWHtVzIL5STXFS+wRJheJZHYTIiCzDejW5xUZuBTRUpXW5xY3IiFJVp4t3LNDq51a41T9wEEwNsPp5VAqgJgM7hVi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D9ya+FeY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710ec581999so1128041b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723750866; x=1724355666; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1VWISu56wcliniL1RPNMTZcS4mUkuTA+1qK0QABl0U=;
        b=D9ya+FeYa9wReAhPy+STJf3Dy5cRIYf6HBk8kKccYrSZvnnbEFntddg4KueD5vBRjX
         AdV5TU4jxWslqnVJlkSoX9fzfrw9lZQmUIm7h4LaU6BVwBy8t4YqaU06qsXIZEGIAYLB
         OmvtUwHAlLDUjTCAyX3mni4k+MNTg3tR0xcYVYPG/8Y/NqhK0neMpNEL3pDz9RZY9jV4
         Hh0IUXTkQVmtLISAH5Fkh8B7QJHESx1h8/+77HOwnrJL65bUp2wG4uSrAQ2YD3T3mcqZ
         IvZ3Dy2tXmiee958ufEWFwXL52566axMZol9X8bfb7VEEdIka1Zp6sNTAnNDOvpRFT6q
         2v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750866; x=1724355666;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1VWISu56wcliniL1RPNMTZcS4mUkuTA+1qK0QABl0U=;
        b=jHoki9wXRBxgyDq9GZ6IBrlvvLipNWioc5pZd3jeZ/l9gNpaGotzlt+M4e4689wL+0
         vXPyvX/swMrDLR72NjSG2Esvhx3xU7pCB49CtJ97/p/NGKZ2Ul3llLe0D5h9Jqw+Y0o/
         QutDgTuGX/pirPK2cO0EEJ73k1xm0d03jMDgYezJEFQScHJ45gfCD0MbK53Acc7Gpzuj
         hu99Zn01BMuX0M2SA4noD6x2UZVQJ+AXGH56pqpBPw+AnCXiAdyvRK8wtjEa0s3XpH7H
         SVtax+oS8ZjlAhwydRtHXSyj+FQY3F1CX+KnQqak2X4aMTdsbU9C8MJaGNU48mZ29Ajt
         E1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWl4IIQgnvjzlADjIWd99LGLXu++fAxdLQcUs21pEy5vnmk9xAzn10Jds+p8Bd5twqLkaT8JKHjuyK18nudRO1pt9o7D0Yv
X-Gm-Message-State: AOJu0YwG82VhS/Y5d6WaOAwXE3JvnBz7HmqtwwG3Ah59w9+uoi8gzDyT
	OVUjC+cSxgNblXeEJLvg3/zo+zhvc9fXZ282sD969d9qKWrrbtw/qoXfl+hY0Zs=
X-Google-Smtp-Source: AGHT+IGBeVra0eMWvYeLqHCk/DezHt9EnEpabZ2WKu9TSxo5+eSv9Ov+1Xc7qtkvdvQlB0z9sH91RA==
X-Received: by 2002:a05:6a00:66cb:b0:710:bdef:5e15 with SMTP id d2e1a72fcca58-713c4e71508mr894035b3a.18.1723750866152;
        Thu, 15 Aug 2024 12:41:06 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127aef410esm1342447b3a.113.2024.08.15.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:41:05 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Thu, 15 Aug 2024 13:40:59 -0600
Message-Id: <20240815194059.28798-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Sorry for the delay in my responses here I had some things get in my way.

On Fri, 9 Aug 2024 09:13:52 Oliver O'Halloran <oohall@gmail.com> wrote:

> Ok? If we have to check for DPC being enabled in addition to checking
> the surprise bit in the slot capabilities then that's fine, we can do
> that. The question to be answered here is: how should this feature
> work on ports where it's normal for a device to be removed without any
> notice?

I'm not sure if its the correct thing to check however. I assumed that ports
using the pciehp driver would usually consider it "normal" for a device to
be removed actually, but maybe I have the idea of hp reversed.

On Fri, 9 Aug 2024 14:34:04 Maciej W. Rozycki <macro@orcam.me.uk> wrote:

> Well, in principle in a setup with reliable links the LBMS bit may never 
> be set, e.g. this system of mine has been in 24/7 operation since the last 
> reboot 410 days ago and for the devices that support Link Active reporting 
> it shows:
> ...
> so out of 11 devices 6 have the LBMS bit clear.  But then 5 have it set, 
> perhaps worryingly, so of course you're right, that it will get set in the 
> field, though it's not enough by itself for your problem to trigger.

The way I look at it is that its essentially a probability distribution with time,
but I try to avoid learning too much about the physical layer because I would find
myself debugging more hardware issues lol. I also don't think LBMS/LABS being set
by itself is very interesting without knowing the rate at which it is being set.
FWIW I have seen some devices in the past going into recovery state many times a
second & still never downtrain, but at the same time they were setting the
LBMS/LABS bits which maybe not quite spec compliant.

I would like to help test these changes, but I would like to avoid having to test
each mentioned change individually. Does anyone have any preferences in how I batch
the patches for testing? Would it be ok if I just pulled them all together on one go?

- Matt

