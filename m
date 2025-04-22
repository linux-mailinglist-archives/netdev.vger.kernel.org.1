Return-Path: <netdev+bounces-184579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151FFA963FA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF90C189A76A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFD2550DC;
	Tue, 22 Apr 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ELJ67bb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EB2550D9
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313284; cv=none; b=iIj2pEwfqNG4IE6eKfbLTcZ27OW6VlLshQztDn2rSnVNB+s00hIa0nIPlrSI1Nn67X2Gp+Ap5nUfn0Fk75vGxoQxpv76XhvdpQ2lwwyqYdC+G0JZc8MmHGuDYVWmgTNbSkjwLtigoHltdolaQK2zXrlFRABtQx2dpO6Y8Jojgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313284; c=relaxed/simple;
	bh=hb9nRR5K+0KKUCCIlFPq+xn+7rN/2O0ZIk1vYiWfSco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blxLm1BL7FiBLWlkFU95Ry337a1EUBKQU7bHPNVdgqYXZ7XezQmfpa6cRa58Bwc1VZjrHB/ztWfYIBJBLqhjH9dHuYXApZSVmgZXqoXthqJvqO8PPz2zSGw+TuHZFSyiW7obiuuw1WMF7i3gpEfGo7GDM+m2HBWlptzyUHDthcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ELJ67bb9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso48686025e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745313280; x=1745918080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFmmnpl4XwCXv99by51T09kPcELv8zaWE44R4O9qreU=;
        b=ELJ67bb9x7Qox31okJNi8eV0s9coanHBJmc5rjmIOTtnodwfzqNshZ03LxjdSHV0l6
         PiqDZJszTQ1W9pZuZVrYdq/cDSSkTl+IiJXdg/oaXorwtQDryPTh9sX1afTzBCPertqH
         ai+qSLERnUcX4zsDg9YWs+xBOdSzfAkBV5E48X7zOWqBRgPHrwZdi4/cvoPghIKjxTMd
         sZuC59TvDaOGin/9PaHDoGeXcIaDF9JMOxnUNePjlFgi5GOQ9kAjIadcdOEp7XWZ1sF7
         CmLSWhmZsf23t+cJfixn6INByb0vgpIbvBjXJSCVbzhhNV6J2LIvYIMKpmcBpKCepwtI
         iYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313280; x=1745918080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFmmnpl4XwCXv99by51T09kPcELv8zaWE44R4O9qreU=;
        b=sceje5wHlAmpTz5uiaPprBrWQgx7ZgXIipRKq5pnyOI/qR01Q7H+sPozgjhBEjg4eP
         BxjNUoJcn995VUJ7tmLDgp+bGzLz6WuXToA9VnHDliG7wO7lcKbpx2oHU28gk8JvxqOH
         qPlbswJ1K3HOpQzh4XpPE2QW5ErzhincGmiD+gBg2YArdUzXl4stuYDDiPZje0asYjfb
         1m7Dpcv65pbuc64JOxjnoRPkEMPNvqrzpiRREu3eeilWgja0Dvoo5Bdf1Jgx1zeLv9MK
         +rFZuUzmmQYCoQtjPSBMj4ir+KekszMTHvu2Y9fvXKFRKv347JTuf4PcWocZFvmlGhSB
         fqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbPpBCB1R8gJcsEO/qZviUcLLQRPltbqZj8gZAGs5UfTq4YPGR2wKERQYD9fPB8J/6v+qBkDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56+BhH2f0UJ7ucJ9lNR6PonL7wuRowVWhB+tg60swJe6Wlobt
	K82SeDd8banCaeqxCbrL+KSWaLgkZppek+ef7J3u/hKwJP/yD0QiDDJGuIOy++OP0YBMl9MIknE
	e
X-Gm-Gg: ASbGnct4+wnNQY1E4xgtQmxTswwGAjlNw4T4YYO5+6pB0FM+iU6M24Nnp5jwPqgGiW5
	drZ17S7ZAmfNTRt1HkMzNYj531UlDc49hOM6KFs+hBdCtnAbDqCHWSjJ9xtOMX+Vcv5/MGUzm/A
	yB3hl//dFmkPwjKkguZv7YucNWMquL6eax4uJhharrZxMny3qJOeyxOuyEiQvlCgBpzSVnqwKoA
	fKCqLn3pCukZlDABG5o6ozN4sQfkcbHlDw7sMxXtvSg3GIlGBJnchQrD3DtoDXqAcz6IVYDzuiy
	lG26ZbseLbXH5+GXE6Zmt5jAdEl0qu0549QeX/YpfGSnP3gMpJes9Ajp63v+8ca4N/J3
X-Google-Smtp-Source: AGHT+IFxYzUGc2lgbjAfZgS2oqJIHWXh49D/UwBkdHf3tvHrVAFdZSmGuS6nB61/piapdKu93vl6dQ==
X-Received: by 2002:a05:600c:3b9b:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-4406aa872fdmr144472485e9.0.1745313279991;
        Tue, 22 Apr 2025 02:14:39 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bf20sm14292446f8f.48.2025.04.22.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:14:39 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:14:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
References: <20250414195959.1375031-1-saeed@kernel.org>
 <20250414195959.1375031-2-saeed@kernel.org>
 <20250416180826.6d536702@kernel.org>
 <bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
 <20250418170803.5afa2ddf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418170803.5afa2ddf@kernel.org>

Sat, Apr 19, 2025 at 02:08:03AM +0200, kuba@kernel.org wrote:
>On Fri, 18 Apr 2025 12:26:50 +0200 Jiri Pirko wrote:
>> Thu, Apr 17, 2025 at 03:08:26AM +0200, kuba@kernel.org wrote:
>> >On Mon, 14 Apr 2025 12:59:46 -0700 Saeed Mahameed wrote:  
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Devlink param and health reporter fmsg use attributes with dynamic type
>> >> which is determined according to a different type. Currently used values
>> >> are NLA_*. The problem is, they are not part of UAPI. They may change
>> >> which would cause a break.
>> >> 
>> >> To make this future safe, introduce a enum that shadows NLA_* values in
>> >> it and is part of UAPI.
>> >> 
>> >> Also, this allows to possibly carry types that are unrelated to NLA_*
>> >> values.  
>> >
>> >I don't think you need to expose this in C. I had to solve this
>> >problem for rtnl because we nested dpll attrs in link info. Please see:
>> >
>> >https://github.com/kuba-moo/linux/commit/6faf7a638d0a5ded688a22a1337f56470dca85a3
>> >
>> >and look at the change for dpll here (sorry IDK how to link to a line :S)
>> >
>> >https://github.com/kuba-moo/linux/commit/00c8764ebb12f925b6f1daedd5e08e6fac478bfd
>> >
>> >With that you can add the decode info to the YAML spec for Python et al.
>> >but there's no need do duplicate the values. Right now this patch
>> >generates a bunch of "missing kdoc" warnings.
>> >
>> >Ima start sending those changes after the net -> net-next merge,
>> >some of the prep had to go to net :(  
>> 
>> I may be missing something, I don't see how your work is related to
>> mine. The problem I'm trying to solve is that kernel sends NLA_* values
>> to userspace, without NLA_* being part of UAPI. At any time (even unlikely),
>> NLA_* values in kernel may change and that would break the userspace
>> suddenly getting different values.
>> 
>> Therefore, I introduce an enum for this. This is how it should have been
>> done from day 1, it's a bug in certain sense. Possibility to carry
>> non-NLA_* type in this enum is a plus we benefit from later in this
>> patchset.
>
>Ugh, I thought enum netlink_attribute_type matches the values :|
>And user space uses MNL_ types.
>
>Please don't invent _DYN_ATTR at least. Why not PARAM_TYPE ?

Because it is used for both params and health reporters (fmsg).

