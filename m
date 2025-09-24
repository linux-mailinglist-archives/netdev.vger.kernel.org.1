Return-Path: <netdev+bounces-225772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B0B9811C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA08168E60
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B121C16E;
	Wed, 24 Sep 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYIbKe5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432702AE77
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680600; cv=none; b=OJhaXdbfPu2d58PuI3FGP0w/30gl1UiJizgOb0xHhp9RR2DgzEzwkJx5OCuKChrQ8/V+IBidW15xB7LE2x6BIk+GqgtwqUA46TSeoHAKcqvzQEAQIUCvq+/rImmP8QvBhIFmq5BccY4NzXZ7qkEpdinySHv3crRHEt+UG0b+bhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680600; c=relaxed/simple;
	bh=puo2H/6mO0H48GEkLudy3w1BhhOybtcbqYj55OdwEJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEmrQ/eHWqqzbRRQ7J2r31AOmaTWwEdVCsuG9flYRThvkOFvKcOGv4gykYj/alQMTkzUXSq5+rDXk1i4CvtzmcyQ2X2qOIOTTuR6EspqNlkXGpH3mxwe5ZZbuASzxbdArjcd4+BZLSmzEFFt+uN6vdEg8tnNJdjzt5SgJhEUcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYIbKe5c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f358c7b8fso369562b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758680598; x=1759285398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puo2H/6mO0H48GEkLudy3w1BhhOybtcbqYj55OdwEJU=;
        b=AYIbKe5cpIN7y9b8t7+U80NRr/vX2fEUtMQTbR5nSVfJ70XrEZJftgoH9G5tdbCTjJ
         gObBmZF3xBCTEyABjOrZMwRytbbmxUIvf5QdnQw7QASgL4jyz2v9hp7Mi2ZaY7qekKpW
         1w9OA2ZYLki+xu5qJRUf60jTewb0uEVY4+hw41ue0X9v7wQN2aBkd1p34gxHK5aWBFP1
         UOJHsuvG7KBpkDB2zDYsI5avig4gv0mHe//tt8J4UGgx3hFr7MIuQKgF4/GkHItK+kMI
         hF9aYIeDsNe6Vmzpi8Xkflujurl6Atop2R+d2rxXJIuA9jOG51tByGTk/7xd3knkVVjm
         Bkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758680598; x=1759285398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puo2H/6mO0H48GEkLudy3w1BhhOybtcbqYj55OdwEJU=;
        b=BZCCEI+WuKA1nCiM/zU1lRtGrDAvkJZQVjX+0yFqS2FVP6gNF/IFkXzGKaj1XDmfzs
         S9pPZ1O4KktecxYo3aQXE8Oi4z7PVpn+yN4FFhH0E9jJQIL0rLO+hV+88pMCLrEHmbMC
         N23CHlsXb5NOkIQgIZhnpLMMPiqnbGk7HZUP4cPmUuVaF5qnAIXeflcxUKomp7aLVRDe
         XE/EoKzpWffjCDLqV6FDXjNSviMRUa06NUIdPUrpGbryLnzIbUjt8JvL3fywOZmwog8r
         XLluqVdVGr/WPlGkvfzhNmtwRF+nfBUGt5rd/jVlTnx4TboTAwe7on9DK/M7EX8uXMrF
         +fQg==
X-Gm-Message-State: AOJu0YwOOGyRgsMedr2dHrFhS4mAuWFX1f/XiSK5sBbfDruFM5/H/iDA
	1z3Zik6gS0IbZfbbKJCjMqOJeLaMbsruKH8HKaR+TEO+diBD3z1g1uQd
X-Gm-Gg: ASbGncuiJnKDSTyHJmvT9vnTZ8fHt+vF4yokGtm3iS0j6CErTUDVPUCpoeQecyhctKH
	cG5auOUNLwdebm7kjr7avRvK1xdcNmFM+RQsNIomx5oO4hyXc/FVHaYMRBrsMhG0ly5aCamuwcl
	phXVWWt52gDYoZZaSECql9DOEUZuBfHUoJh4MsALwQhrhL8HEl8mb4rzhkZRB1jL8/eQ1PoPCbo
	pEn8upqe7o/beIu2aAPzhfogzf48KRQpMZ4aEGexWeun1U0Wx+8QpEwCqmyLRn4BMMjMBHKZV0o
	tR9ZkmBGEomiEUaw+aUWDSLMbLjB7a0s7hmMo51Zj6KqUaX7nVGVTnq76hPE8+R7uQ/Db0rlVdM
	w1OI/5CpGQ5dgYPN09WFdPVLCEOI=
X-Google-Smtp-Source: AGHT+IHYHC7RbMygklI1SWnMd2kQMMolzDCetw+ZscTfyEtsvx/wmZ03qcZprzqZt2WpPPUgC3wrRg==
X-Received: by 2002:a05:6a20:e14:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-2de94224f2emr666582637.27.1758680598513;
        Tue, 23 Sep 2025 19:23:18 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315254edsm7936832b3a.84.2025.09.23.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:23:17 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:23:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Liang Li <liali@redhat.com>
Subject: Re: [net-next v8 0/3] add broadcast_neighbor for no-stacking
 networking arch
Message-ID: <aNNWDcvO6aCG94Qe@fedora>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751031306.git.tonghao@bamaicloud.com>

On Fri, Jun 27, 2025 at 09:49:27PM +0800, Tonghao Zhang wrote:
> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> datacenter, the switch require arp/nd packets as session synchronization.
> More details please see patch.

Hi Tonghao,

Our engineer has a question about this feature. Since the switch requires
ARP/ND packets for session synchronization, do we also need to send IGMP
join/leave messages to the switch for synchronization?

Thanks
Hangbin

