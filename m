Return-Path: <netdev+bounces-123709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491CC9663DD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646011C211BB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA216DED8;
	Fri, 30 Aug 2024 14:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B007DA94;
	Fri, 30 Aug 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027154; cv=none; b=SELXui5R95Bu+NQ18Pmr32SQ+NF9uQHI9FvFSdlHi0Z0hCt4Zk8oiZwfLAlgYrswZTAkg9TYjM9Loq1V6n61TZugnKTgiI9UqecdnBxm8Qyp3+GaYUEsg25TKDwSla4TYu8fiQ3kpvxvkQb0fb+tFJxwmosdMUENUGXj49+iSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027154; c=relaxed/simple;
	bh=qnrkIxunWgp+Co0ZG3M+dWGw2LsVCYta/suFMBAQkL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGut2cjoKw4KyP2A1x3IqTUpmE3ZQjPgpQwcG5ZTGBJqg08E/i9N+XHn0oxv7uj96UDnU1eCRBpg+hgHu08teALg6mLxZphnW4LOUBo8rCKv6Q34S8lPzNFRS5y3XCDMBn0ySeeXAtj0pVF0ZrtqgCmcNRSVfCOd9104vtHBXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so2041143a12.3;
        Fri, 30 Aug 2024 07:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027149; x=1725631949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnrkIxunWgp+Co0ZG3M+dWGw2LsVCYta/suFMBAQkL4=;
        b=LmQzYb98WDkWIeyviTcm452OevxckYLf77HVCLc2O4/3r2jXKFhF9YZcOapHPZ5eVf
         vbgx/BKKfExKkF/4f+Jd+ekQVLGhV7aGbCO/+PdZ58kok5xesITUZWYCXgbCN6j1ePNI
         k+/UDr0Kx+WPYpHZCMGWw/YXL+oa8e4Km7J86N2EyodBuhuPJuE8fxU3G+jBHIqD4Buu
         bPL2a2tEI4jK/5yRTALBGnwqe9IdFO/gsC+9r1o2HFT/j4hLIo0FTqi9eL/zW/T0tzBU
         aFW2sCJOiMoKMC2hZCY1y3+sc1IH3E47AWzGnzVkZvoYXPJSOLkaiEIwelBVja5xcd/z
         B1fw==
X-Forwarded-Encrypted: i=1; AJvYcCW/5tcwDcGihKwrLtKM7CgE0DYlvpiqZPvvGA4XMGFCIwI7akX/5aDgwUe6pIAm5CXXpEFUnOXTtW1YU7M=@vger.kernel.org, AJvYcCXVsX+ADXnVHGp86zsjI6F94RfW2OI+logQC1VfmOZtA9edyQgqDPKxBnYc4F8vp/3kFHWVU//F@vger.kernel.org
X-Gm-Message-State: AOJu0Yw149W5j+HuLL1fjqDlWJr/tY8TTP5yxJ7Koq6+6F47bnmYQw04
	Mwotw8lKTNmY9AjPcdXutoj5mtGwrmdfqU8CY9gWuqGAhO4I9ODRfpTFFg==
X-Google-Smtp-Source: AGHT+IGTuNw62zUcTKO0VX9voHRSqrGiqwPYaE2L2gmGp3TArNxQTlqDDMCjPqlmkzGqOK9hM65HSA==
X-Received: by 2002:a17:907:2d10:b0:a86:817e:d27a with SMTP id a640c23a62f3a-a89a38247demr139237866b.61.1725027148187;
        Fri, 30 Aug 2024 07:12:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f079sm219377366b.66.2024.08.30.07.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:12:27 -0700 (PDT)
Date: Fri, 30 Aug 2024 07:12:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] netcons: Add udp send fail statistics to
 netconsole
Message-ID: <ZtHTSexXueMjYGh/@gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240828214524.1867954-1-max@kutsevol.com>
 <20240828214524.1867954-2-max@kutsevol.com>
 <ZtGGp9DRTy6X+PLv@gmail.com>
 <CAO6EAnUe5-Yr=TE4Edi5oHenUR+mHYCh7ob7xu55V_dUn7d28w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6EAnUe5-Yr=TE4Edi5oHenUR+mHYCh7ob7xu55V_dUn7d28w@mail.gmail.com>

Hello Maksym,

On Fri, Aug 30, 2024 at 08:58:12AM -0400, Maksym Kutsevol wrote:

> > I am not sure this if/else/endif is the best way. I am wondering if
> > something like this would make the code simpler (uncompiled/untested):

> Two calls in two different places to netpoll_send_udp bothers you or
> the way it has to distinct cases for enabled/disabled and you prefer to
> have it as added steps for the case when it's enabled?

I would say both. I try to reduce as much as possible the number of
similar calls and #else(s) is the goal.

At the same time, I admit it is easier said than done, and Jakub is
usually the one that helps me to reach the last mile.

