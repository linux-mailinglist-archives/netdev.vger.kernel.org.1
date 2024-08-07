Return-Path: <netdev+bounces-116374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FB794A342
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB9EB27F19
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CC1C9DE9;
	Wed,  7 Aug 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OQ/7Q8u4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558C1C9DDB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020239; cv=none; b=Zy4XN72wm0bY7YiObO1tThVP9I0Kp4DBWakzmvASPjRGdh39K/mwuZt8nWGHWaXkSSlU1GUqon8f6cu1J7fgDkLGVN3HckNxdxhEmhcz5as9ihnwYqlwoVX2+9w9ybR/cpo9FizfIEpVOR4e+YScruoQXJhMrrlMI9KA+VFUwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020239; c=relaxed/simple;
	bh=4BstarA/azTj0MQhXEHPNbE5+HYWrDilUXJZYFWQ+iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WtCmJ7GQlRL8Ki3IobwCjDPgxGlcu45QFf+RLju4TCd3FIgsZRWqvKP3qPzGD/2bpzyVgJKfI2tWisufFFDwn6kAlB5h0SOpTvD+6bt0/5rTp79+ei4QSi4+uZVcn6yn8GU6SoQtv8SkrhNl4BP1UXRG0CcvCAvXrGzSlOH6hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OQ/7Q8u4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-704466b19c4so840070a34.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723020237; x=1723625037; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iw7Tv+YETDv5W6d9wVYOGpd/7bHckBYfrgRk1yNks+I=;
        b=OQ/7Q8u4/rKgMnmfsm92qJn7lrBnkLHDS7V3j1hcMV81mDoVvMWsnxQROcu0pJMJGj
         EI08rcLDW3Eyfc3NPVQZBrC8vDKHYTY1tWy6Hp7oC1MNfThqO9lHJajnYRIHx55rVXwx
         zg6xupztTNS25AZY12LDyIRaWcNlBIeVMGs2sfP4hqj7E9PUgypFUBQPatUkQzlNVE5W
         lNuNBNZAj5dKHPLNoR67BDKudufTdASj2yVN3ShiXyLPuEAxPtWmBgt6Aahj5fsSuY2l
         j6F0rq+zMhRNHWg46KQmQl2nGVpmMdJ5QGPAg1aRgHR8A9/ihe9zinHGNO/hs7I9Kx6N
         6TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723020237; x=1723625037;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw7Tv+YETDv5W6d9wVYOGpd/7bHckBYfrgRk1yNks+I=;
        b=XD6CrgAjTax593dTlv1uj12wc3/oM6ko3oJ1VWtqf1GlwNsH0YCyOMlGTAN5uUH/1R
         Q5hxyGIVt8ei1q2uXNWli3O+E5tRiENSUAJCgJo4awCz6pOnw9wk8aS+5CwZr7GtUaMM
         BZU63dRZOZ0Urx9pHMZlKAG9UMLp80pXuQP6vlf1q1R8ZhsBFjj0BhImXR+ZOwB+l5NC
         qO8YVz90ZvjXWi2r9d+zT7xNQLn70SyQAlcEQ98SdKRSZsqAL4yQ3jhig+3JcLQeNCmT
         6Lefrh2+7HXvClV7xWh1o982aWtFlfRLMGt+jcFV7aYFyAdKHJUIw6mUhINl1sxx4F2O
         9M+w==
X-Forwarded-Encrypted: i=1; AJvYcCWboxywOWZcc3zefhwd3izhJh0ezpWEBC7iRbYQlQLU5lgwTZctGH8Mg5eqYBsmB4H/YYAsIg9QwyfAh+ln2sqHGUW+Ty3x
X-Gm-Message-State: AOJu0YwkGzqESR5SarLjZ3hiU1tj3E37ubNKA3SYN6+SEXkennAVu6kt
	UvwEt/jOyO8e7Ii2JrghUJQXbkP/+ld2xJp8FdluMQyUCLVJUtjWAU+Eq8twOws=
X-Google-Smtp-Source: AGHT+IHGDJwgvu27ZoxkF/Iz1RMQROmHIKs8TmuQAxLdh09B6CWq3+c9Jjh5o5EFESeTZQUuMmrUsQ==
X-Received: by 2002:a05:6358:418f:b0:1ac:660a:8a69 with SMTP id e5c5f4694b2df-1af3baf62a6mr2337848555d.18.1723020236454;
        Wed, 07 Aug 2024 01:43:56 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7b7654bf852sm6742435a12.90.2024.08.07.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:43:55 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	macro@orcam.me.uk,
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
Date: Wed,  7 Aug 2024 02:43:48 -0600
Message-Id: <20240807084348.12304-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240806193622.GA74589@bhelgaas>
References: <20240806193622.GA74589@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tues, 06 Aug 2024 Bjorn Helgaas wrote:
> it does seem like this series made wASMedia ASM2824 work better but
> caused regressions elsewhere, so maybe we just need to accept that
> ASM2824 is slightly broken and doesn't work as well as it should.

One of my colleagues challenged me to provide a more concrete example
where the change will cause problems. One such configuration would be not
implementing the Power Controller Control in the Slot Capabilities Register.
Then, Powering off the slot via out-of-band interfaces would result in the
kernel forcing the DSP to Gen1 100% of the time as far as I can tell. 
The aspect of this force to Gen1 that is the most concerning to my team is
that it isn't cleaned up even if we replaced the EP with some other EP.

I was curious about the PCIe devices mentioned in the commit because I
look at crazy malfunctioning devices too often so I pasted the following:
"Delock Riser Card PCI Expres 41433" into Google. 
I'm not really a physical layer guy, but is it possible that the reported
issue be due to signal integrity? I'm not sure if sending PCIe over a USB
cable is "reliable".

I've never worked with an ASMedia switch and don't have a reliable way to
reproduce anything like the interaction between the two device at hand. As
much as I hate to make the request my thinking is that the patch should be
reverted until there is a solution that doesn't leave the link forced to
Gen1 forever for every EP thereafter.

- Matt

