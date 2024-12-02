Return-Path: <netdev+bounces-147984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6689DFA2D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 06:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BEB162724
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5D1F8AFA;
	Mon,  2 Dec 2024 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iFCLwv+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3E1F8AF2
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733117348; cv=none; b=HQddzohqSN1gLw6GjB56fzaC3zZMiKwJdf2D6wQ/aGGWGxW4pZgM1rzR9+IYZsjiCBxN8t6fgSerYUwipkeGr0zHyjx9G9KiqRtYS0tFobm+OYXDV2iE+lqYJyytVO8aniDAUhrsEg/oC7z1i/of8h+neXqplTi5Zt17Ed6xelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733117348; c=relaxed/simple;
	bh=ri9C4EnczmANi1+uc2hK89jgj7Gq1j5HuZA0DhuKJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAici8ocR2dOq+rBI9VML0MDsgMa488QZCDvNxYN3Vu4pPuUK14BCtfIfldOgd8ttpJjAgiZeUj6KETZYjtkvAxTpQCAhGPDdchJCYhFhjOVJlCmXvfl2/ULy+LNGk4byPBGbLB7ULrv/1KBkNTcsHRuYHqv/3sn0OQFuAGn3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iFCLwv+A; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724f1ce1732so2882273b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733117346; x=1733722146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9/ewA9rLToSfTcc2kOPnMXbBaHZShyChtB5veaHjOQ=;
        b=iFCLwv+AKnUDNS3J8w+2rEuAWActyezl0nMtIXzi8HQPNny0Xo5gxtiNXAHysrC9Fp
         Bq2ZjS1vSCnMh9nDyo6HLr3dTqChTO535s+LLVNpLwgQNrwH883XrU/aHd/CEdofY7SQ
         /pXk/WidFcV/g/gNCaS0iNu3yynAsnYDGUuHptp50b7LNjhllahLApLufpTm1mL9uMm0
         vXUdhuRz41WmzSNMmlUzKa59cT26P0oR+DfGfFFgxjk1VJh/brXLUm3kQRP+5f78MOW6
         DSmp2nelgRBiQlG/iXLgVKfGBveTtiBUrx4sveUQu8c84ouByKqqQyJ53pbLcvfWCAP3
         TpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733117346; x=1733722146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9/ewA9rLToSfTcc2kOPnMXbBaHZShyChtB5veaHjOQ=;
        b=AIgOP/sbd2FfxAiMt7NL9cCycIAqNavfJfLq+iRAabXqddE6XCxM7CnVcGrxYK3CCg
         IHoFyEE05MZWMFibmgRXYXYb59v+e9zYm/HHy7fisJbWe0L8nj7cVJ/896gyhHpgZ8vL
         /Sgz+OxTnjKpYog9JYSFhbiWeMbd3MZ9+ya6X9Wb9u5uHFjazbyi7p86V2l9grpKms7v
         7qxgq2vrw2IyboJDwcbDJnFRal0Bp/qNVcySlxo2i3XTCTPM0cG0FWVebKssGQwSKGM/
         jbqLJlQEnLDezD7l4CvdbuRZXAAJlf14/4xBK/xoLBPQUInZ9VPlhUS0+DPU9SrYlBkb
         MxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYaIf3gpfzpbvjqBotqa0hXxEYDy8AK5iObXoQ1k8NrGiNVzWmP6Aq+9lj5RPgnJDvJ/qewoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDm+lhA1svyKlt69roTf5h1bDX2xyKjYeYjypzGtjpDlBv5ao
	MQ6h0OkqmqIYyudNMfxgqOPrKh45QTc4bEbHqOGX8kZ68/nIS5ltBAILLX3bxPU=
X-Gm-Gg: ASbGncvAXKbKVtB0xT7E99VEb9me9/PyT3V/HsY3D7tfjF6z0uZml/9eEsnltxcnhw5
	BNWrnOrkwcElBRoJNbUwNKahUpNxpjsHFqev+b6BofgShjbTuzhmhUh2iYIIZ5ycvmJLR83ELIc
	5Z761qxlqWoW7NvPs9750VL6fcquJtPSRTjGecQmDWI9cSCnYMbfWDS87E/4Uj3mBpwDt936sny
	Ve9jPtlVda8/dxLAh2TuoJzANrD4xhGCnUpn5ZCl0t2ce4o/f36QcHqClOttZ0rXOdaFFTppMMl
	/t/De/wADtpYpgEZJpLyYEW6AZU=
X-Google-Smtp-Source: AGHT+IEC4JaQRdvfLHkC6wbFfEV/IytmFEWvvpiTZ3oJ4bzxdYi7wFe/2m384cAlwdJP3cbs+P3KGQ==
X-Received: by 2002:a05:6a00:3cc5:b0:71e:52ec:638d with SMTP id d2e1a72fcca58-72530010f7fmr27740462b3a.10.1733117345894;
        Sun, 01 Dec 2024 21:29:05 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c388ea6sm6945868a12.57.2024.12.01.21.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 21:29:05 -0800 (PST)
Date: Sun, 1 Dec 2024 21:27:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: hadi@cyberus.ca, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Bug in qdisc_create" in Linux kernel version 2.6.26
Message-ID: <20241201212747.13b37633@hermes.local>
In-Reply-To: <CAKHoSAtJSK6tYjZ8djK27LVuPvAVC=r+Hziv2oxA7vAYZw+30w@mail.gmail.com>
References: <CAKHoSAtJSK6tYjZ8djK27LVuPvAVC=r+Hziv2oxA7vAYZw+30w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 12:31:00 +0800
cheung wall <zzqq0103.hey@gmail.com> wrote:

> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.26.
> This issue was discovered using our custom vulnerability discovery
> tool.
> 
> Affected File:
> 
> File: net/sched/sch_dsmark.c
> Function: qdisc_create
> 
> Detailed call trace:

You are testing a kernel that is no longer supported.
The 2.6.26 kernel was end-of-life in November 2008


The dsmark qdisc was removed a year ago in 6.3 kernel.

