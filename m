Return-Path: <netdev+bounces-243361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CAC9DCFE
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 06:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92A654E029F
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 05:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06627B50F;
	Wed,  3 Dec 2025 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvPwAgja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B91427A
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740566; cv=none; b=KkwDMH5YbCqA/kzoFpwPvbNgrcMoA1zIPxtWIIr68ugKd2ZtMnZmQ2Z1KyGTkdeW0wzxzhAgygVYDaZKAmtGZadPMSrTqPsDhdHpfiaG8vp2qaJ+mdjJOy3uq/2mlboJW3t3ptvCWNliNA6U40eS93LHxGJ4KkdHeasrnqUpfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740566; c=relaxed/simple;
	bh=Otq3WCfk1rUw1D/rmmFfkk46OFFvNyrLVDqDUGiQrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQOH7JLYfAgWBXL3+2J+QM2wEiAkKZAcb8RnTKxpXhDs4MlBmlAcEPKX1NYSGI0K0ORhfjQYdY2iD80YXXKPlyuPrkTztJ56jzseJrv2P/oumnpZMPQzO3vNw9rFYjxCEO170Ca4r4vXDo2vrnBFhov4hPLb3QPvfGMsXX49U04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvPwAgja; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b553412a19bso5393327a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 21:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764740564; x=1765345364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oF79V0ubYln3hWTBA8d7rTQHZtvnHeNi3kk7XwgxLjc=;
        b=XvPwAgja7idD5Y0nyXajWlHgWwfpQebKUq2jmVclKZFVqZAY49ZSYLwZeAjQXVpbcc
         Dn3Ns7mXqnWdijCr0/8OWjwnb+vKF+7nMju8+XOhNY7Tfq3vfU/P8E32xTAqD9tRfSLH
         EJp0wz4+HJlrq3U5lTrs0qAE1iWDcF/ekbzNjdjhDPHaEo1aJqMeIoUEttl4I1BoZdNv
         3cU8q3lD4aFVCDWCF5uKJ/1r1orM5jv8KjcN0ok2g177LBONKsFv3e3yIoLYsa0SQkEN
         bT3nljEwyrmWNoL/jKBJ96lWPgw2Yvho+wRHjq2TYU5AFMqb/TKiHJtb3gvquEGeSjOM
         uj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764740564; x=1765345364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF79V0ubYln3hWTBA8d7rTQHZtvnHeNi3kk7XwgxLjc=;
        b=BKGSf+zefRdMbZkblNUJiNlNh3BqNdE27kyf0yL3xbSnIp03Z7OS0hl4PD65OD7c8k
         RN3d0leg9VraJX0ACuVP15t6CleqdpSq2tsRXTu59+qV0iJs9VjNshoH4vBdL/TwwPM/
         07E+ZvxqOihCFHi8onhXZ8tmE0w60DKOPuYotOqQV/o6KnMmmV6n+SQrB7amQZNCV620
         LjcIuXlmuT6CFSjPjzut2+DDCK23a7ZjAgKi3hCoZAwCH1d7po7H2IrKBOjCTO8JZEWI
         pbqFsS7cNlOpDv52dGTjQ+uWW3cI4Nsbc5agvQgt6RGTzmf90p7AJfLk/XKVfmZkhKG1
         KDmg==
X-Gm-Message-State: AOJu0YwZNG0hWpEivvlFxIWUikPAE1aqWMZsgy0RE24s1a94y0E4LsiC
	deolPZPZiJLKoWNqAIyX61hDx44zP4dB/cyPsPeB38iJOoUjOMS5WRFY
X-Gm-Gg: ASbGncsDvWI2haguk4LBVaVPQx/Kk5knXqtLOOtlQ47+z6U+rAB9fVzF14gCm+EkD1v
	27d8ygIPf0b6ONBzFhoF/VKMb3VCuykLE7cWXUxNAnxijTnCOSf5nAC/aNoio266w5aF0vNBOvA
	tsiswktAg8/wi8Fo5kw/Ro5ZKgjcNPWwayx4BF81y+GzRazSVOk+t3ymNLXDVjBIOJJSDg0q+oS
	XWhbXpYkePt+DwVyA1ppXPpOyGt2fGUzMPhfyxKWTxdrnlHBTC4N8n3NGF6im1n9f+yYl8duaYq
	XLd51rm5rNlY9XQQOGYv08014MPTP4ttEucH2nJw4sDhze03O5Lgf2shW2841JetCP0dsLeNTdj
	SPiQbCxcvO3nRjUdNyl/DVSwSoUuLhLCJ6By4yCpPSM0q25IlKGd23JJ6gbOzY7bjn/XpqKScKJ
	OWSJEr28QLbgvZedebfA==
X-Google-Smtp-Source: AGHT+IFjqQr/R2Hchi4orSNb74EHa+HuoxKRcGtIIaDBcKDRC3v01CZnSsuYRiGk1saoDRvbP7fnuA==
X-Received: by 2002:a05:7300:f3c2:b0:2a4:3593:6466 with SMTP id 5a478bee46e88-2ab92e52c79mr632220eec.22.1764740564164;
        Tue, 02 Dec 2025 21:42:44 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:57e5:a934:7b10:c032])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm64357808eec.6.2025.12.02.21.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:42:43 -0800 (PST)
Date: Tue, 2 Dec 2025 21:42:42 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [Patch net v5 5/9] net_sched: Check the return value of
 qfq_choose_next_agg()
Message-ID: <aS/N0s3A4xeJqMvZ@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-6-xiyou.wangcong@gmail.com>
 <278eb8cc-0564-4883-918e-0aaa62dfa851@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278eb8cc-0564-4883-918e-0aaa62dfa851@redhat.com>

On Tue, Dec 02, 2025 at 10:20:20AM +0100, Paolo Abeni wrote:
> On 11/26/25 8:52 PM, Cong Wang wrote:
> > qfq_choose_next_agg() could return NULL so its return value should be
> > properly checked unless NULL is acceptable.
> > 
> > There are two cases we need to deal with:
> > 
> > 1) q->in_serv_agg, which is okay with NULL since it is either checked or
> >    just compared with other pointer without dereferencing. In fact, it
> >    is even intentionally set to NULL in one of the cases.
> > 
> > 2) in_serv_agg, which is a temporary local variable, which is not okay
> >    with NULL, since it is dereferenced immediately, hence must be checked.
> > 
> > This fix corrects one of the 2nd cases, and leaving the 1st case as they are.
> > 
> > Although this bug is triggered with the netem duplicate change, the root
> > cause is still within qfq qdisc.
> 
> Given the above, I think this patch should come first in the series WRT
> "net_sched: Implement the right netem duplication behavior"

Will do.

Regards,
Cong

