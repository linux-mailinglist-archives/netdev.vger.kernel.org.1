Return-Path: <netdev+bounces-110324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA692BE3B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68FBB21066
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CB19D08A;
	Tue,  9 Jul 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkX6HUN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F519CD0A;
	Tue,  9 Jul 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538756; cv=none; b=M+TwDljjuEqrpFnlgshqKbiC1JIcMlxPLHnVRpFN93SUsFj+c+LsLHPw3T1hmoqHsf+hczLKjnCxVEgqvU1XcW+7N/sXiWQwHraDAejTCW7GzPhE7LER40QKNvrIBefnEUNgH3FNPXGgpzuh+KP/b+ouujCtZV9D9Bxd07DF2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538756; c=relaxed/simple;
	bh=uYI1VF4OgeMzpAHhQoBVxsymSg1MML7D16rAqKWGrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aahq5kGrBXlBC8H9IeCHVlWjRnc85PZkob1okypd+zBpp4xa62RkK3vbDalvWIaURyUM3W5mOoJ7b1UXWyS7Fh+gv/C3zFlB7j1oPh+pj8g7yVF5vmw1BMoE1I8mSVpDHJsfwW3akT8PBa4TIo/DuavWFAkMI6jgvUjDt9/ybpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkX6HUN5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36796a9b636so3622769f8f.2;
        Tue, 09 Jul 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720538753; x=1721143553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEP9HFUIvOyMzrlfw2zh4onk/mGWAtEnPNTkOS2BI8k=;
        b=FkX6HUN5ruioc5XFbChYRTVnjaQhHDELQh9XTiullUFn8N2slpiW0UFBtoyxs6mhmv
         TJrucmdoE4HqgI3PnZKrVeGUHHd2Msjs8mzHbwPNkLzdG3VvEEj7OVsYBtu78ojxkP9f
         g6v4NmX6sC5Jz/+K9ByoTuw2W1gI81gxpNt5I7Zr7hXdtxehiW1jmPUurRdU9mQCYqQo
         puEWecx2sYo/qfFLgAnC79gvyap88jPCBTddizla64lHP+BpfWdAmrEOoTbrFbUuVMxB
         qL2Vi+dRiVbLAJi/RY23AGfc5jovsHIbMszMF9bN3duv0cv4gz7+T+6Xs+923Eayzezk
         iU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538753; x=1721143553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEP9HFUIvOyMzrlfw2zh4onk/mGWAtEnPNTkOS2BI8k=;
        b=e+L+O3l+yGpqcCl9ayTGUM1KLFXHZaQC+0eaaak/rlmKaLCbjsO3d6YVwEBoTAaUve
         zahkb7zNik9aPZZ3UpmK8JMDxoMVXNqyQmZVLsTJmmm13cbBGHTsJ0w1xak6O9mOSoGR
         H0Znm9/HwdCXfdiQeSGR+uPusuKI1BPAxypObxK/YaTpaBkGVNQoOtcsxZLYmoHpNBA1
         MqQuUYBD0OcNlQsQroKzEhgfqzyNKnvH4xQnHL8hqBPcZ67QEJDoCxdiUbkTsRtSKbu1
         pG19Rit/3XelZVULnkmiPFaUQIVyAzbeKW4YGMBjOCin7onzcmw/wk33mvisqt6Ne65n
         7t+w==
X-Forwarded-Encrypted: i=1; AJvYcCUAzCPqZ1r1cVcJFHHpaG2eeYcUtZsgiv/VXaGypZvvevWD2iSZM1BtB98QaC86CYOoJ4j1WfkP/Ihz3thUG+N9l/hWoxJRE2cY5vMC5/ohrGVKku+VH11xQhXZpE2BYyEkgDLj
X-Gm-Message-State: AOJu0YyxgKwGF8LMER3vZK2u1Sr5NYudEJJYagfpuG1BOk+KqH/DqJbc
	4J9QYnib5CE1Ey8UgYrNEzgNu7Yaf4eIURavfGtrmsSZeLB9y2iE
X-Google-Smtp-Source: AGHT+IGaU+IhfijAp8zflrrfJXXMbDU1JKbjE4Rpg8g3NjL5OvpVpNRl2dIMiWa8Bd6kfcsTT2jamg==
X-Received: by 2002:a5d:58f1:0:b0:367:8900:c621 with SMTP id ffacd0b85a97d-367ceaca897mr1943578f8f.56.1720538752641;
        Tue, 09 Jul 2024 08:25:52 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab136sm2849553f8f.98.2024.07.09.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:25:51 -0700 (PDT)
Date: Tue, 9 Jul 2024 18:25:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <20240709152549.3yak6yeij7x5dlal@skbuf>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
 <Zn2yGBuwiW/BYvQ7@gmail.com>
 <20240708133746.ea62kkeq2inzcos5@skbuf>
 <Zow5FUmOADrqUpM9@gmail.com>
 <20240709135811.c7tqh3ocfumg6ctt@skbuf>
 <Zo1UC/grXeIocGu5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1UC/grXeIocGu5@gmail.com>

On Tue, Jul 09, 2024 at 08:15:23AM -0700, Breno Leitao wrote:
> Hello Vladimir,
> 
> On Tue, Jul 09, 2024 at 04:58:11PM +0300, Vladimir Oltean wrote:
> 
> > On Mon, Jul 08, 2024 at 12:08:05PM -0700, Breno Leitao wrote:
> > > I thought about a patch like the following (compile tested only). What
> > > do you think?
> > 
> > To be honest, there are several things I don't really like about this
> > patch.
> > 
> > - I really struggled with applying it in the current format. Could you
> >   please post the output of git format-patch in the future?
> 
> This is the output of `git format-patch` shifted right by a tab.

I don't want to insist too much on it, but this is not correct. In the
process of shifting the patch to the right, something ate the leading
space on each patch context line. The patch is ill-formatted even if the
first tab is removed. Try to keep it simple and either attach it or post
it without any change whatsoever.

> > I have prepared and tested the attached alternative patch on a board and
> > I am preparing to submit it myself, if you don't have any objection.
> 
> Sure, not a problem. You just asked how that would be possible, and I
> decided to craft patch to show what I had in mind. I am glad we have a
> way moving forward.
> 
> Thanks for solving it.

I mean I did suggest dynamic allocation for the array since my first
reply in this thread, which is essentially what the patch is..
Given that dynamic allocation was already mentioned and then you
suggested to replace NR_CPUS with something dynamic, I took that as an
alternative proposal and an invitation at using VLAs, which is what I
was commenting on, and what I was saying I don't think would work.

By VLAs I mean:
-	u16 channels[NR_CPUS];
+	u16 channels[num_possible_cpus()];

Anyway...

