Return-Path: <netdev+bounces-151685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB59F095C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F64282F6E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D351B86CC;
	Fri, 13 Dec 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="hQpJn3os"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85018A6D4
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085513; cv=none; b=nrVXq9BamsFz54rDvMDjlzosSXj5GW+VpGn5V90vKfg/xcCqZnWWLxYkfqHPizMy7WmmnZjCUBL9/dD2CswlJq+0kfKhCdOAouNFDwrSMVtHn+PKo3TTC5ynHzoRAmZ4faxhWOaHlFqHZ5yJ4vtGn9GXZVYK5ewAKOR32tkqwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085513; c=relaxed/simple;
	bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpDaKNCud4Ic9Y5xAI/ma10EoemX14gvK7TE8HQPNIXH39JA3wg4UCGzDjI4639rTxlDYhQmuT4lUaL/mhWZUKlFOOZi7giYPFlFUgcmkWc4WgMJTeFX+TDb+2v8ElMCGh8jKi38kxew21Z6mvxH87z+5yU5cF9TruZPLWqTMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=hQpJn3os; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27d0e994ae3so667968fac.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 02:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1734085510; x=1734690310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
        b=hQpJn3osqN0K1oOxjUy4TmM9KFFnde/LbmCcdBPSMPPUdtodaosp/KE7HH6qLDG1o3
         ritlzG+cA4KHfbVAHVrP1kpeHJpt6s/BQGA4sBcc/DC8KLEHubwtKhEka7ibTUvXIzaN
         v5lr1zUvRvYsYyvwCCpCEvBctC9mKlNVOwsxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734085510; x=1734690310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
        b=wRmk4JyIZOQt31fJd31jaujsQL8q5f9GHDWXCrrP5SR8BAZUqK6xYTQ/lSJYe/Qe9X
         ALQV1IJ0a+NFTU7ZyPRXQqIVKSRhzSgLT7dPFudaa4YRo1IWvGEmfskZr2RXq72uhaT5
         M0X7lFuBBBF0N32zf5DM9c1+WhCcYil7u5kD94rkNI2pf2tLJGKAWtqMhwIG8XmQ4WOl
         vJKk25Zxb0OBWgcP+3i95is5Ic0gt+LDYCPvw5u80xe1c2pVO2G9G7yuWI5RDajnmj4K
         kM3Xy/YDS+aPrVGIGS0kPkUpHz+UcRy5ggShvu/xoewtoZRcQp8usFev75GOMJkZZoJg
         /Tqw==
X-Forwarded-Encrypted: i=1; AJvYcCXyFjI2lfpVtLtxAhvkv63RHwaNI7i+oNr818QWSrGgX7+IZ3gBxIvpN2g8oJmQozX7fPB370Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1clUmRXCwfruwJYiMUL1GCmqhFTl4fyDq+mhxD/MDblaHOvEp
	gB1ltwuaJq4Z3giscQhiS+iyANxkQ5WQZAgXzZBuSOr14cNQB5B74EA5h9aQRLiWi7ye+RD1TcD
	UVAB6pd56IycrdDbV7K1+pO9PfHquSoME8oOxeg==
X-Gm-Gg: ASbGncuANu+Ec2pkTzQPw4iZeRhrMSCki4eDZv5OVxAiqJ8dWmNMTb9ThbtddJiBE7A
	xGkdXrVk9R4i7eq88eNaYjedn5EOrz66mvg/Vg2DdjBKCNg6SoiFm6tZF2ar7fQjTHVjBdA==
X-Google-Smtp-Source: AGHT+IEdT/A/pmiS2ym+9RC5WzDSjkjUMBatBt8gNsmX6iOQyltgrvwe461J4dlxyPDv7Ks2W1Btk2iEGxVCCFVfE2U=
X-Received: by 2002:a05:6870:7011:b0:29e:3d0b:834 with SMTP id
 586e51a60fabf-2a3ac614135mr1216192fac.5.1734085509982; Fri, 13 Dec 2024
 02:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh> <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
 <2024110634-reformed-frightful-990d@gregkh> <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
 <2024121233-washing-sputter-11f4@gregkh>
In-Reply-To: <2024121233-washing-sputter-11f4@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Fri, 13 Dec 2024 15:54:58 +0530
Message-ID: <CAH+zgeEhb2+SmB7ru8uGuNs+QX==QAWxeDgOHUQ_G3stWbMBWg@mail.gmail.com>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address calculations
 via out of bounds array indexing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Xiangyu Chen <xiangyu.chen@windriver.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> What did you do to change this patch?
>
> Also, what about 5.15.y, you can't "skip" a stable tree :(
>
> thanks,
>
> greg k-h

I have not done any changes to patch but tested the patch from 6.6.y
by applying to 5.10.y and 5.4.y versions

ref:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.65&id=26b177ecdd311f20de4c379f0630858a675dfc0c

