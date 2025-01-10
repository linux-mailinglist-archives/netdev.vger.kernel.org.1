Return-Path: <netdev+bounces-157229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1106A098AB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB61E3A2183
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2F2135A5;
	Fri, 10 Jan 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XuLHWiSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B057212B1C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530705; cv=none; b=GjKzwFctl1bZKG4mTLmo+TZ8VAor2SBf7zN4cX7O6tR9GS+Fqia44rDz4Mt4PLDFuNE46wF79RCYIy2QRAYBMKkO1j2ei+1f8BubrdsOSH2tb8qHqVkJM70dBB8PltDxg3AUz57GMjpJVwMZReACAa0U6it7BbXKY5zQedBLqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530705; c=relaxed/simple;
	bh=Xc0LpgSxeWnVXm4Gt0fYSe89ljh2mxgpVSUJyXzY328=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr9hUEf1ov6iiUFvHr9/3ZgG/6Bd2NSDTBuLFk4WFpi22sCSAgD6poju4Ckr0uXVj4I7NDYnx3CXzD5n01/FjUZDumnxwbqKfN0C6wbPTfBPP8dfQDU0RTxCxG4eMaBOuGZHVqtHgG8V4vyfA3ORZJF2+D1zfQAUVlWmE2CBL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XuLHWiSz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21675fd60feso51848225ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1736530703; x=1737135503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaCF3XWNWiv2osYod1MG0foHbsq7nHjfgxfahU2MLW8=;
        b=XuLHWiSzFb46hcRu2+Rste4jJyh3m5HeNczWiqoBI5Zg0hB1S2l3SkcG6Whq9//0I+
         djaEUIorF5euJoGmSv4Ndsfmngf6OJizk8j1NNcft9S1/4dfeqTRZz5Esg7CrK7qfwfm
         0Q057DQlnMX53uLYbi9ql9/PYsc9EVyYm/B/epJMlo+aeWcvS7wG7Q3EKPw1dBcX6Lcr
         shkUpEcNjg9hW3KMmGIyVLo7Qan1j6ncdBOFS2s7X5gfNhOESejmsAdY708WAGG9VgA2
         dS8gnqEcguplgFdmVM5GdjPS4CBM4IbNhGi/Z6PY1w7ej1dRvIJxNzIyzpI6MmrwqBfO
         EmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530703; x=1737135503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaCF3XWNWiv2osYod1MG0foHbsq7nHjfgxfahU2MLW8=;
        b=iy+Y3AYgECT8h+4THzyFI663XpviPmQ6j76VQdUOVEyDw2XOE4LweLRJ9Yv8a4vLoq
         ZC+pPV4MsRcv3H3fMvlJBW0j8MEA1amb6dcyNQv74vA/wOtTjDwfP/QP8Q1qGGlRy5r8
         MXUnJGoYIjyKJVD3XpPLY5p6wJygd6hmo9xtSoP/k8mA2JVcTCmi0NmDSlgP6p566HqT
         C+5SUGLBElZegEJN1qvyWY7I0KYbLLWiOHFwU+WeAC72kwuKRSWV6WQe76eIbNIkXFSD
         Bqto+x2ODK7zV0ibHtCMRHLNstRjaPCUlYu6dq6EKcbMSkrtRRL87AVNROtWXn2t74dj
         nvEg==
X-Forwarded-Encrypted: i=1; AJvYcCVpFIYTGhKYuIT0hlnjObj11Sewut5YL8kPGLhysFKnAR6f0VGNHhA0kyCSmIYtDlIT4dVvaH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkRl+V7Y7rKe8vjvrXKAVddH8QappXQJl0Q8TPn2MFUCkTzlI
	1HFo8EvS0fJBLfwdh8tcesBwJX7I3BFI9oxsEOyrRSsZdCiGOO7WufvII2r1++ohcZ/N1ZGJhhM
	j
X-Gm-Gg: ASbGncvcCjnRffFRiEnBXsRdfc55QNifFmKDK2XvmIZO5+mlvtxKLY0byh1TLgW4JpB
	W7Y9f+fUWL9NTE9x53qrW7Zl3BsaMvzwVU/IvGyCCLVdTbxxSM4W85Jg3wyoTP1qp/C0dZc5EJR
	eoOp6C/pmeZq3Jl3dE3wQUs8CP27Y6Cf0Hy/Sv+7WlCPX7/0Tq1JqVVjey39lLlOB5944c52k1v
	R0hXsH1mnr85w6GvuuZ1USO3nqI22esKweic/hDZ6U/q+iCTdokspBXnxRpPxz5cTGLVuUEpgAi
	twtm21GwSzquVYG0PKffgYEQWDMv9iNQnQ==
X-Google-Smtp-Source: AGHT+IFruOsvLZwxdgb2eT/ZWZCtZnr1qJLKlmbhNl+GSWEOYy1xmGTwD6FNcA0bViHhul3jyXRZ0Q==
X-Received: by 2002:a05:6a00:3a02:b0:728:e81c:2bf4 with SMTP id d2e1a72fcca58-72d21f4eefbmr15914264b3a.11.1736530703600;
        Fri, 10 Jan 2025 09:38:23 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40591da9sm1794105b3a.73.2025.01.10.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:38:23 -0800 (PST)
Date: Fri, 10 Jan 2025 09:38:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [Question] Generic way to retrieve IRQ number of Tx/Rx queue
Message-ID: <20250110093821.4eddeff3@hermes.local>
In-Reply-To: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
References: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 10:07:18 +0100
Daniel Sedlak <daniel@sedlak.dev> wrote:

> Hello,
> I am writing an affinity scheduler in the userspace for network cards's 
> Tx/Rx queues. Is there a generic way to retrieve all IRQ numbers for 
> those queues for each interface?
> 
> My goal is to get all Tx/Rx queues for a given interface, get the IRQ 
> number of the individual queues, and set an affinity hint for each 
> queue. I have tried to loop over /proc/interrupts to retrieve all queues 
> for an interface in a hope that the last column would contain the 
> interface name however this does not work since the naming is not 
> unified across drivers. My second attempt was to retrieve all registered 
> interrupts by network interface from 
> /sys/class/net/{interface_name}/device/msi_irqs/, but this attempt was 
> also without luck because some drivers request more IRQs than the number 
> of queues (for example i40e driver).
> 
> Thank you for any help or advice
> 
> Daniel
> 

Good luck reinventing irqbalance.

There can be multiple interrupts per queue, or one interrupt can serve multiple queues.


