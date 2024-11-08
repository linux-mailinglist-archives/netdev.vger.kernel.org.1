Return-Path: <netdev+bounces-143143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D089C1429
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB9C1F24435
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816793B1A4;
	Fri,  8 Nov 2024 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="oLju61dA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BB2EAE6
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033464; cv=none; b=ZliwDBGeuZjSjZx7MOSGcE3cv9+FP+CG7vF5qDWlg1+M5OMwna6M9E2tkVW7Fs/Rs6fvhetxBUBPcVHxd/xn2Co2UhSlNS11AldtbEfmKuXDL9pdwmixbDjJm8JCwI9GY4S1vwVz+TTcuYbZyEVJNx1dTIeCfM4QX90GxnkZSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033464; c=relaxed/simple;
	bh=uEnmWZfKiN+uFlTrQY2HbZF5tWrOHez49q3kh8IszPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsCA3lbIKRadItJQxhUtDRzkZDFP7Zm9qdGVz1Onw1fpzcsL/2wvHMMlNQzDfgsaow0Q03NJUW4mrwoKPVUh1+x6dPNOL8NF58dzDnuNpmlApgzRUhN2d2Wie+ZtY7qHNjqLP2NxgdisT9yloRXUSvvjKHnoN5AYX1CfzdzMvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=oLju61dA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1359601a91.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1731033462; x=1731638262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GwuTyrVE+5I4I4FYLNKR6yYv0TCkdnFD8YeyKGlZckk=;
        b=oLju61dAf7woJksMA3edIhfWwFepoZnhkAlGZJ3W560oBSAq8pWq2KvCghy4CkejCI
         tmlWIsZIox+qOizn+T+dMKNIFKaU/ESOCmAaXmiRCnkhYmtNoW1FTQYXd82kQMoHanJW
         kczPMaIL9L2c5X2R7Clac49M2WL7Bl1iENcSJEerOw2ceFOFh0xe8PxkI8p4iEiTm+Kv
         BNeYYmg2QxsHgBpCEuExdJvjaUbkfxuSdSwLMx7C8alek/2xB+TwOBoomEB7mi7oWcK7
         NNolgaDdcSOoijbh2rWRpj+XsxR7XMtVspMdwr+E1M3175An6wKSNBlINQp6trkvnhRa
         MSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033462; x=1731638262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwuTyrVE+5I4I4FYLNKR6yYv0TCkdnFD8YeyKGlZckk=;
        b=SIdZp69NfYhY9FMv7QcL7I4K+svNPMRxsBli91xiuAWwc2GyFKNhMOzRz0iT43DjC5
         jLaHtt2UwXRMcaEVdio6TGMJ6h8vI/tVVow5LsmuX5Ju5M0R5JvROrgJVKY/OVwHJDAj
         VNMTasFUUdifKBP2WMwB5eJmXrzTsKh8nNOdPVTAyyvrIeL6VhAUYD46ZtaZWjyQQbgN
         GSBGMhbbYKNmK80+RTkT4C7h2nHwq3qucYYkuDAwimUpYUh06MTGQXHLbkytShrgAPtv
         QVpU6ZjeLWxR2ChJ9F6/Xx00hOO4NjUaVC0ACFplFdgw4WM5BTBNSPqgzWUopptn46h2
         Nb4A==
X-Forwarded-Encrypted: i=1; AJvYcCUy5ek2DKpLtlB2ZpUwqoAq33SI5/jQxQTOWlg1cv5NEucIsijjnfyKuRk+vIuwowRDZZe9eeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTYYunMKIbQB7xuc4ooHn/TbFyMPENR6K7j0dAcDlzeWXKkr3
	6Zp00Tee4SoEkbfSxVdtpFiMv4SeiBBD2YaRuArN90QHQi0UNI/fhZhVhTffPtA=
X-Google-Smtp-Source: AGHT+IH8ncqrcsfunj3ifretZRkdIrgX4/OntQnqoDh6lQXVP8mNX2kaJzXPcQ0u2qL58nEWGKGpVw==
X-Received: by 2002:a17:90b:2748:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2e9b1754affmr2018796a91.34.1731033462451;
        Thu, 07 Nov 2024 18:37:42 -0800 (PST)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e69daesm20122845ad.228.2024.11.07.18.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:37:41 -0800 (PST)
Date: Thu, 7 Nov 2024 18:37:39 -0800
From: Drew Fustini <drew@pdp7.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pinctrl tree with the net-next
 tree
Message-ID: <Zy15czmqRLN4Ov4u@x1>
References: <20241107214351.59b251f1@canb.auug.org.au>
 <CACRpkdaxB1APxK_rRFEhcwBw0JZc20YN0z_881_iYVxeKs95LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaxB1APxK_rRFEhcwBw0JZc20YN0z_881_iYVxeKs95LQ@mail.gmail.com>

On Thu, Nov 07, 2024 at 02:59:25PM +0100, Linus Walleij wrote:
> On Thu, Nov 7, 2024 at 11:43 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Today's linux-next merge of the pinctrl tree got a conflict in:
> >
> >   MAINTAINERS
> 
> Thanks Stephen, looks trivial enough but will try to remember to mention
> this to Torvalds.
> 
> Yours,
> Linus Walleij

Thank you for handling this conflict.

Drew

