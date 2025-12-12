Return-Path: <netdev+bounces-244536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B0CB9A03
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B280300F3B9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634C224AF7;
	Fri, 12 Dec 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGa7Eaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E53B8D75
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567057; cv=none; b=CIsOLp7LOGIqHx0Yw4W1pdsZfzO/Qjw2gKruYoNpGXrS3xtWfYXJBRytg9XSeDYhTjbKmQPmlthrydo4/d2UcFiu0AB8eadFz/GSjtEAhoo/40muw8MTedcZwimBk0Yolu7texqlHQ+KoCByuwOvMdtJQPo1Ztz7l3JH3kFau5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567057; c=relaxed/simple;
	bh=kAJEIijw1h39dwP0oiHddBkEtMnWkioxlFQC1ujPckI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDHrYc8p70TsAKfPcoNyPrTg4eBrbRVOMuLzM1E1zZ6cZrHCe/qmk1AeQQW+jmzmlllgtpXJkBDvRbXNreVIqmCNYofMZd+Dp1Bu0iDqnzqEmXyhKZR95T0MFs4U9hOzOtLnhBMq1KRTSyjb6ozkbAoRrXD8BChYl+UVaIYMD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMGa7Eaz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so1920769e87.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765567053; x=1766171853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iAGiWGntUzRzKLCpTz264YmDdwQESuNb3m83qNK0Aw=;
        b=UMGa7EazKdu4mUTd42ewrExmUBHtgXLsQMY0O5Fsds0PEiir2KfpeFOyjCiTBfFAJe
         reN05mjfVVS8y6lNGSYdf94tYYOIXhzh9HA20Ja+EnHjrz9o67S134Ou160h21UvrGMu
         0vxdI6KQyXTDt4i2ybh8iGZk67BzoA8Ni1jsRNb5ml22LYi6fsPsOj/CJi4x3cYA015Q
         C9vWvecbUW5rQOTQhPuYytq7gLz3Bcfyb+73O2QosxaZOfEVXeygbd6yI2aiE1yiRtmW
         VPwjewizCpmY2lfVUDpNwmBKlrhFfnTzOeyk4ZDYiyKAirMPy65Zt2omTtrE0DaAH5wk
         h0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567053; x=1766171853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+iAGiWGntUzRzKLCpTz264YmDdwQESuNb3m83qNK0Aw=;
        b=uFWoYt6ALRgnS20WdiT4WlOnP815XWvq26FWmhnZDW2H1i5+G3eTTTAWi00xfiFV8j
         +vCxonAn4xQd0mkHhU9NFE9HkA5hnZWKNFyWMUeFfJuSVfDWdNrPgGHsNNnXBY8b1Jjj
         fX5SpLwFY97ZrXb5q/k/tVgCMGLK79YcX4YmcSMJ1gsjBqNUNW0RqqPm11dwfqkTvFMb
         3ohxpt4ZBZ7VkumYQUAa6b7514mXIsiBJWDUZKNXnVXPBRP82SzvrhZYnkO8fTUJqPlF
         L+HcKRfxdfDq/jJCJDMAs1YavqEQr/0OF2pa4wuXZo4TY+MfI/24h/gXkWTwVeoWIezw
         pOVw==
X-Forwarded-Encrypted: i=1; AJvYcCVrGt+LRFb3TkPsbyxSxyHEPxfzc8kV/tF+FerrWvVmu9ex1V15AGGqJQvnO4D4Cngp8V7SfKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+kwA9ClEdrXXlnKe3xHHdhxZNjfnS1GsMDEWSBDeTd5RY5v3
	5czl7m0t7+Xez4wH9GRaRZy1mNCtFK4a8/RWX8A3ADTAL978m2VBMshKg3NrLQ==
X-Gm-Gg: AY/fxX43LJcqlMVsfLObAJUgYYAVbcnhl2MY2zJBoaSeL1RTZ8G0R6dySWs7fmVPBCD
	ACxzotMIx3E/PZ2vzMf6m4HOQQd2zNtY+JbnrVxAtMkGAp2bcDNljahFFps3JIT1M4zFDgr5LCc
	tCfEM4xcPvUf4wiJR7wJPINRef9WL33xf/ueS1OJXef7PeuNBR5sMc7DIjJO0IZ06OmPXMl6QAv
	bmALi3glxEl9sn2bwGCvVb/NgnSNHluHvtJsUV3fJPOs60Q/WyjrMHTxpKAy0yBiOKhU5RcFynD
	g7232JON/39rzWBEquRtqQyTtaCr5kADXgWCnowTCtqdWYfPQUF+lUMTwgFZ+U8Au1LizKU4tUG
	3yCc/mrc3bC+oiCQlvpD/Mwv9vTrT/NvBbl4dElrOPZzx0TwZICJQsfV6gs1UhuzsIKBabft4WJ
	bQJTyYBbdNI8WCg4Mo+7Ta/oxNnPaUSBEq78e95C7UxAYO/y58Lb+k
X-Google-Smtp-Source: AGHT+IE4SzG9SEUo36H+/RajRuGXQKEqi8PEHCvRAZiuCC+tFu11I+7qLmwsFCnbEjl5dXnaqDhnFA==
X-Received: by 2002:a05:600c:4451:b0:477:9fcf:3ff9 with SMTP id 5b1f17b1804b1-47a8f90f54bmr26022385e9.27.1765560968089;
        Fri, 12 Dec 2025 09:36:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f7676ffsm43676465e9.4.2025.12.12.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:36:07 -0800 (PST)
Date: Fri, 12 Dec 2025 17:36:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Ilya Krutskih <devsec@tpz.ru>, Andrew
 Lunn <andrew+netdev@lunn.ch>, oe-kbuild-all@lists.linux.dev, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer
 overflow in
Message-ID: <20251212173603.46f27e9b@pumpkin>
In-Reply-To: <aTwqqxPgMWG9CqJL@horms.kernel.org>
References: <20251211173035.852756-1-devsec@tpz.ru>
	<202512121907.n3Bzh2zF-lkp@intel.com>
	<aTwqqxPgMWG9CqJL@horms.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 14:46:03 +0000
Simon Horman <horms@kernel.org> wrote:

> On Fri, Dec 12, 2025 at 07:30:04PM +0800, kernel test robot wrote:
> > Hi Ilya,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > [also build test WARNING on net/main linus/master v6.18 next-20251212]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Krutskih/net-fealnx-fix-possible-card_idx-integer-overflow-in/20251212-013335
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20251211173035.852756-1-devsec%40tpz.ru
> > patch subject: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow in
> > config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 15.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202512121907.n3Bzh2zF-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/net/ethernet/fealnx.c: In function 'fealnx_init_one':  
> > >> drivers/net/ethernet/fealnx.c:496:35: warning: '%d' directive writing between 1 and 11 bytes into a region of size 6 [-Wformat-overflow=]  
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |                                   ^~
> >    drivers/net/ethernet/fealnx.c:496:28: note: directive argument in the range [-2147483647, 2147483647]
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |                            ^~~~~~~~~~
> >    drivers/net/ethernet/fealnx.c:496:9: note: 'sprintf' output between 8 and 18 bytes into a destination of size 12
> >      496 |         sprintf(boardname, "fealnx%d", card_idx);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> 
> Although I think these new warnings are not strictly for problems
> introduced by this patch. They do make me wonder
> if it would be best to cap card_index MAX_UNITS and
> return an error if that limit is exceeded.

The code seems to be written allowing for more than MAX_UNITS 'units'.

Actually it all looks pretty broken to me...
'card_idx' is incremented by every call to fealnx_init_one().
That is the pci_driver.probe() function.
So every card remove and rescan will increment it.
(Is the .probe() even serialised? I can't remember...)

Then there is the MODULE_PARAM_DESC() that states that bit 17 of 'options'
is the 'full duplex' flag, but the code checks 'options & 0x200'.

And I just don't understand the assignment: option = dev->mem_start;

The code was like this when Linux created git.

	David

