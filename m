Return-Path: <netdev+bounces-194282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935BAAC8582
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FE11BC41B0
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC722D9EA;
	Thu, 29 May 2025 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sTswQAmL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BF21B9FD
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562860; cv=none; b=MhfzDIia+BEpKIpdqBBGvilb3QSyYmsMpZk8iLj7sDLuzKlotl2JGN1fAQ1J0LLDMcAR3ZtL10zrMfd3Hg3zHAj3Lg8qha+7aZtPF79UpnxR+Mvn+TBDav7xDx9Xg1zrs5xkYYLvhN1fulq3bpuP52C3T4EaBjdRMYXJ8rkxeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562860; c=relaxed/simple;
	bh=fzBmoU/GBNrBZNry8iZF8TyWz5qhRHlF8PO8t/PwcGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u31ByNibO9Nrkh9gqrtSl3cN9S43dQn6vGpF+W9q721rR9riwPxD8JG+m9gkgNDKjBiLrj2iTiBxAka7x4boqmfQAQUvIc/RiIcuKObrtAms0Z4efoLYUEm+umOFuymlRrhUJqITWyhqTww3aweHpW2rHDru13Sl6jvasrf2/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sTswQAmL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c035f2afso930834b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748562856; x=1749167656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN6gTy630QM8CTJZaRMOSiOMF0uSjwbW1midZ/W3Pq8=;
        b=sTswQAmLopSf6mslRPiyoxyWCsE8Qv7oU7wvQLo6EwSH2q/fUzw8hu9KAv1ePXPR5l
         WhwsUz4k/LpxRhzJR7ATAsoc6uAQAcOcc7MDFOsBczd3c1ysoV3Y4w9+S7vAXL1e1jXG
         AEe1emN/IZLAC4dfAF59QhdpKLvcQYKd5uX0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562856; x=1749167656;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN6gTy630QM8CTJZaRMOSiOMF0uSjwbW1midZ/W3Pq8=;
        b=B91y9Uuwxiqjmtr4B9N0g7AStfigRjVQUfdPIvxiNcSX1dNjnzl3E1Sbc9AgVq1Sgc
         a3jpiONoLz9t78iEl/mveRULmuC6q/J7BP6ERVSn45gZFSW6y1gJ/0W/h+3q04Wkvva6
         eVYc2U4Fch+931fH7vIpqge3BawPdC9CDvVMupmxqydQie543PGlshtlG+pgx/qmRkEw
         lgfBH03Hh5AUdTyD2ualymnVOS5RuGSw1uUX6cVlGKvz60sDQU48NP9oi9iuXlYeSSKi
         aUM4ajEeadSqvraSvfHPjcaBPGLhVlNg9IehdQ102HH4t8PGL0N+kHuEcKRZknoUp174
         5ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUxzkSwkiTPTBwYJjneNrUWfuzfsDou1NfRy1b2hs7mG/BGKGzFe+wufZ7XkrPJpPu6OSeiOBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqcywJGvSSJf868+zicUqbd7hdnhqnKZQytN4P75IWovhzDky
	TBuOrbkQG0tzUeZQp6od48KRHb5B1ESmhvdhvNh2pByuFtOU6Vo8efnMxjMagMYJzYKpXd5nvma
	ZVhGp95E=
X-Gm-Gg: ASbGncvU6oKJF8oDlN9Ss3tBzSYbi83faIsEmDXchVM2BdUbqkLPkjcS0pavWi4HWNM
	2G56UBxkt3DFO3MeIGhkc6euXFw2oW8W+oUnmkgO2kEJlNbAcHob7ppfCYj0TWNDeHOKO1lEuZw
	PLrLbEOMRTxu66btdMEbXtKAaEVJVfVU6M1o5RC9h6PG5ubihavebMvJ3g9K/kSCCAkYmFOhWxf
	eRCqeZ1ngr8rzJc+EqqeN/Y13skV8e6a6uUKudAwHCq79lj45TEOOKGp89tmuHAySycIVFzRhyT
	tiCpYSyRR7VyvOI/n+58ZAA/XRR3eck1VlS6OCbZ2hTzcRr4m/HxCCgw40aJs/ZWQT4wYO8Lile
	2h1b3e0bIWUwPsmIOMZVHWTZOfabVdJox9g==
X-Google-Smtp-Source: AGHT+IHRL6MZaRCV2qyHdIA1Ey0rZLl6zqYTvtI9TzqaPZDL2PqmYa7bTx0E2QQp2U5dgOaO4Eq8Hw==
X-Received: by 2002:a05:6a21:6494:b0:1f5:5ca4:2744 with SMTP id adf61e73a8af0-21ad9572f95mr2027987637.17.1748562855934;
        Thu, 29 May 2025 16:54:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affadf5asm1874242b3a.115.2025.05.29.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:54:15 -0700 (PDT)
Date: Thu, 29 May 2025 16:54:12 -0700
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_newlink
Message-ID: <aDjzpDHwcFuGhAqp@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <683837bf.a00a0220.52848.0003.GAE@google.com>
 <aDiEby8WRjJ9Gyfx@mini-arch>
 <20250529091003.3423378b@kernel.org>
 <aDiPFiLrhUI0M2MI@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDiPFiLrhUI0M2MI@mini-arch>

On Thu, May 29, 2025 at 09:45:10AM -0700, Stanislav Fomichev wrote:
> On 05/29, Jakub Kicinski wrote:
> > On Thu, 29 May 2025 08:59:43 -0700 Stanislav Fomichev wrote:
> > > So this is internal WQ entry lock that is being reordered with rtnl
> > > lock. But looking at process_one_work, I don't see actual locks, mostly
> > > lock_map_acquire/lock_map_release calls to enforce some internal WQ
> > > invariants. Not sure what to do with it, will try to read more.
> > 
> > Basically a flush_work() happens while holding rtnl_lock,
> > but the work itself takes that lock. It's a driver bug.
> 
> e400c7444d84 ("e1000: Hold RTNL when e1000_down can be called") ?
> I think similar things (but wrt netdev instance lock) are happening
> with iavf: iavf_remove calls cancel_work_sync while holding the
> instance lock and the work callbacks grab the instance lock as well :-/

I think this is probably the same thread as:

 https://lore.kernel.org/netdev/CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com/

I posted a response there about how to possibly avoid the problem
(based on my rough reading of the driver code), but am still
thinking more on this.

