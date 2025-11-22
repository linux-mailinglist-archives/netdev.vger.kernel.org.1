Return-Path: <netdev+bounces-240911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79DC7BFEE
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2D4E1B62
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E04487BE;
	Sat, 22 Nov 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cx40ruJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23923F9C5
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770408; cv=none; b=VKM6XfPZynuV8TY50pNMLstvmFMiAuRyvbVDfEhltYFtCGNQcrK/j5qSwXBXZS2VZO0JYRMypTrgXFJPqkT5l1U64q7P6PS3S6T6V2xNKNokdKjc3FPtlklskKK8pY9OUjl6dvtoyGrRtkfbk7iNIu6+4cxvqRBtjfaofVb/pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770408; c=relaxed/simple;
	bh=jlvChN0olZoELym0Xa/eioyixL7iEqg6G2L/6r5QGDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7CblMYXQ4VuLKdqOJSK2VCJAdvC7Qz3i2Xc/myCBbUiitvCir9oIkXEW5G8v4GoMp7WgeM9WW0G3T/+tu4v8XDR4tgbWIAVb/v6Nw54esdqFHWUgrCgYG7CFYSKzcTFAwmMKv36Qsxi7KEPDwrUGUPMY+GZjugTUeCAwZKygRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=cx40ruJH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297d4a56f97so37170105ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763770406; x=1764375206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nZP6HGkCtuWrnUwoaCTYR1wZI7XdoYPj1XDu0Vdaxw=;
        b=cx40ruJHMIACmNAWgBQLcOnErGLPMAnzbg5lRO0AdU62bnxcVvXrZd0nFohPSheo8s
         oYDoZZCOtIbij0XaNrIwVVFr0yyqT+QLlelagGINRmODxSKQEllt+tGKIuFLmeZXLxAg
         UHdR05MS3wRcBKWLwAn6xcCzahoTJ+kBYJXdhpOXbTdbJJmEd6tKcsOhrvMTF1hdUXfh
         xf5Fpw/aKGVuKuhfvX7jrL0pybeUx6hssrwoGVGOg5J6OS7vuO58o0FpKhJEjgghz8aF
         oXqcfJilUzdJ5Ak8cwECM+LYP2/jHt0IYod/7g8K3Ang4YFLcncIWfVHCGkukwfERPPI
         G5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770406; x=1764375206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nZP6HGkCtuWrnUwoaCTYR1wZI7XdoYPj1XDu0Vdaxw=;
        b=U3weVRciIouPFFEhmhhnM17pj0DW6Tth5aExYG+BEXP0LhE8fGfkP3FyZV/a/V1T6R
         uvFqfW2Ivq6EpcGs0uNd52JQCmIg0x4Idm/+fSgRGJBO8sU+eo0POP1BdotuQZH7Efhn
         o5RuMf4XJbSimw2qOwYdR05jHvG4wQ1JmieSP6WfwoLhb6huCim4tEJgsVQAiCf8eiDy
         px6JrgI8259jccbVx1ws8aKMra1fZRKqnudN/KtNNcKG1nSnqXJ59FPfzAa+VeIcRcrx
         rMkcD0Vttu62qRnswA040GScIPKlbemUDuHXbsCU1O1oMRGIpVEEh8KRIJxLQB/SQVOR
         cAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWDqQl1pI0wm/GOW/GfejrA1+/khnuSer9qCoWp/SNfWrXIPXdo4Is+2tMcnQ16sNWJk2FbjHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScLaT7BV2VRiMjDPBegm/qTADZXCgwb9FQ+4nUd2WR8Drc2bG
	93y1AddrYnD1Fa8i1kZreJCRxGpwMe/CxlZTQUhHZN+pH8R+dXnXmdUgiivuWagYL8k=
X-Gm-Gg: ASbGnct8kjEPSXSXyxUkdD3Ee/aiOaq8rozQPbbWjBr1QhP1VAPVQUGAIMGJB6t5NFc
	pb7uwRfmxVC8xSNfAIb7lLi6X150sf1s1LZxXv9k6IxUMiptXr6Mo0ZxMs1El0ftInvi8aWpeiZ
	kuY0tHaFr+6p1L9A2sxuaLer1vpxWCaf5I4TeUkUr2Q/6GMqwANKXEtJI2bICRjTgUef3ZVw469
	xHrbgjAvYhX8AjV6vDslxtZUnRCdrkwr4YmgnM/rRJBzapyPjWbxRrZkUe21IlPOAlqAoqdQgXk
	EGZ2xtzioWIvHMSjv8r1XDFnDN1ciQ1RiN9sJRJg4yG1Gx7UAhFMBsGwQ37/t2w+AcheoC9Z+ov
	DZWLXhkypBe1e5YrNoq/8SWzgVH8QodcVSOS63FLjq9KO+UUlusg5FZGwYAGUpi5bCB72EdP6p5
	Ye1xAh2/zJAvagfHjSeJZw9PrAzMslfK0ifL8/JE05CZUlIU6UzMlx
X-Google-Smtp-Source: AGHT+IE1M/dx82ub5q1IgvM7FqoVm/kheL+v/9EswHXoqJYlVHBI5SzNE0zrKm81b8qIBbbmA2aBIA==
X-Received: by 2002:a17:902:ef08:b0:248:ff5a:b768 with SMTP id d9443c01a7336-29b6c3c7340mr48228345ad.10.1763770405922;
        Fri, 21 Nov 2025 16:13:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm7169085ad.56.2025.11.21.16.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 16:13:25 -0800 (PST)
Date: Fri, 21 Nov 2025 16:13:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, will@willsroot.io,
 jschung2@proton.me, savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <20251121161322.1eb61823@phoenix.local>
In-Reply-To: <aSDdYoK7Vhw9ONzN@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
	<aR/qwlyEWm/pFAfM@pop-os.localdomain>
	<CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
	<aSDdYoK7Vhw9ONzN@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 13:45:06 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Fri, Nov 21, 2025 at 07:52:37AM -0500, Jamal Hadi Salim wrote:
>  
> > jschung2@proton.me: Can you please provide more details about what you
> > are trying to do so we can see if a different approach can be
> > prescribed?
> >   
> 
> An alternative approach is to use eBPF qdisc to replace netem, but:
> 1) I am not sure if we could duplicate and re-inject a packet in eBPF Qdisc
> 2) I doubt everyone wants to write eBPF code when they already have a
> working cmdline.
> 
> BTW, Jamal, if your plan is to solve them one by one, even if it could work,
> it wouldn't scale. There are still many users don't get hit by this
> regression yet (not until hitting LTS or major distro).
> 
> Regards,
> Cong

The bug still needs to be fixed.
eBPF would still have the same kind of issues.

