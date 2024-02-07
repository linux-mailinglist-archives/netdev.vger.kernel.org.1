Return-Path: <netdev+bounces-69955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A174C84D21C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338CD1F250D2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111085953;
	Wed,  7 Feb 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fZONvztv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571785659
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333253; cv=none; b=JWIckH16HwzmxJtUnIbKdpYaETC+svvt0e6VwJjIlY0Q2Ef6gTX2wp0AXRXe6zAffXfUJvp48D+ht9HhCixpb+ngKkU0LcsluY+6fgMaqJwUiwIvWxAfjzEQ72uqYnsVFVIcfBIaC2v1HhOxwLYpAOc2/bcPYoz6s/+uCfgHdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333253; c=relaxed/simple;
	bh=KXyViLhzEsxPVRLuCQTh8V/0OZj8FhwAW35ZH0hE6T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUwCKHgEp+qWiQ6/k0jI0nU5mkA/RnwOQs+Zdl0tUz/k9z31ou7YM0VQJrV0Ygt3CfDKApL8YeGIbqYiSXwP1/5v7reixcWVgPIq+cGIXtP6m2UHc5PvOKkdlxyZNdm1Y290VZWJnFyM88iS+RBmhpQ53JKWOHhHAGr/w7oI0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fZONvztv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so798529a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707333251; x=1707938051; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/rKAwAEfKEl02Xj6qqBCTszWTSTMP2vNPDD2/t6tnk=;
        b=fZONvztvWp/mxTS/uTGQypIynf86WVnSbEmWNHzk+PaiWqyK5G/d+Yj3XU+/5BBrJl
         EcOECn3E9BQNGwzGXP1AcygtG5IDuYYbp00qHpoUD+Ffjw+sHd5X8aD/uMAvCY64aPVR
         cs4cYkBoNN/8yfZjLB8T/WdCCoPp6B5VKr5O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333251; x=1707938051;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/rKAwAEfKEl02Xj6qqBCTszWTSTMP2vNPDD2/t6tnk=;
        b=wveMzsxNcspXPMvdB9XlrkMZBpEXp7M1DeGS1zgiDTaFYK0BoVL8vjvZXOWjiSImZv
         AkXMT6gs/tJyWrLAE3lyDZbk2lVSYBCXiwn/qSmUgAqP8GimWCCdgjKOpeemieV5Iysu
         0YWIZmZ28jCRsVZx5B58H/4E4V99aDxJE0viDpHodAPCv7/DqpgElKZdOZo6dA8ONkIa
         8QOrEH8hy2WtCDPyMta8nOuSyC6CMqSQ86vtqqFp6L8uOrhjezy1H4ZOs4W3kX6vjhe4
         4PV+hkEw81SmYgP/68nSzROZXyeyGlG9aOrN/jWk7M6fAUr9z5uaOgc+XYPHcFRnnEYg
         P02A==
X-Gm-Message-State: AOJu0YzpTcqv9uODRniGUeJwkDHjDSjXhhbg4btg5joPSpS5eT7+tBO1
	mTKywIqcjrhPV1XLNRFHToVOKqRJ25uSTuTknyQlaTgc1qnb3Q8uKdeFv1VSiUY=
X-Google-Smtp-Source: AGHT+IF06h+4rJWxr+0ujFL55YOTd+msyLT5qWfeZkXbPmu7FfyJPyksEpShqn5A9dLfjMXWCiAePg==
X-Received: by 2002:a05:6a20:8698:b0:19c:93c2:7ef3 with SMTP id k24-20020a056a20869800b0019c93c27ef3mr4183085pze.46.1707333251675;
        Wed, 07 Feb 2024 11:14:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG+1M2cR4xp1y1p4GRK3cgTXg3DcbRpzJZL35j2Vm4cwz7Mu6m3KbetTNBxQ0yfcUQ0B6QdBnQhYcYfXGNvcvGnukOln5ehLAoTx6v0kcWWHpMrzdj6NTydogDKldDrmIyQiKPf2DzeR5hVWjWMYRMD8BQteYm3r/cbFQ36wwpODv3aGXQKYlp/Qh58DyKHxSO2rld6GX0EbALHj6Am4Ey/O6WuoqwMxe+X81LGnF7OkJqEeNMJZNJMSJVnuMEFcCB4t8aTu+OG5Z4vqa+9T+H1EPf0rq1ZFjKVlITrpujOtfIGCwcLTYjnefAtwZtvkE+rv8FMyYcDl8hLNeBbuKg4roZEa7kh0rKW4JF6rFA4XmdhpRGPrlf30Q2Q55DGrjZ3p38U+DJ4f0RCBUmR5lTmLovGVj+7rfPOBwDp+nNgJBLsNUxjF32r58L0AywfMjppdJQMOIThgRY6LK++kDoPlmvb2G4/g2EriU8U4e5vB5tluDE+QL9xEo2EkNR0XnoRZ9bgXcqyVJH3w2svwdvpvLAT/RMhAt+c8RulCOeaa8HSuIJRh0p6LUzii9RT0JC3jGAizO8YPDw4qfVznxRvpw4niUyVmg2mjOasSvLQw==
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id mi7-20020a170902fcc700b001d6f8b31ddcsm1819227plb.3.2024.02.07.11.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:14:11 -0800 (PST)
Date: Wed, 7 Feb 2024 11:14:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	weiwan@google.com, David.Laight@ACULAB.COM, arnd@arndb.de,
	sdf@google.com, amritha.nambiar@intel.com,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240207191407.GA1313@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-2-jdamato@fastly.com>
 <20240207110413.0cfedc37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110413.0cfedc37@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 11:04:13AM -0800, Jakub Kicinski wrote:
> On Mon,  5 Feb 2024 21:04:46 +0000 Joe Damato wrote:
> > Allow busy polling on a per-epoll context basis. The per-epoll context
> > usec timeout value is preferred, but the pre-existing system wide sysctl
> > value is still supported if it specified.
> 
> Why do we need u64 for usecs? I think u16 would do, and u32 would give
> a very solid "engineering margin". If it was discussed in previous
> versions I think it's worth explaining in the commit message.

In patch 4/4 the value is limited to U32_MAX, but if you prefer I use a u32
here instead, I can make that change.

