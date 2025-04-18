Return-Path: <netdev+bounces-184084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB64A93392
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F97D8E1AFD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00253269B11;
	Fri, 18 Apr 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Onv61T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F624EA8F;
	Fri, 18 Apr 2025 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744961973; cv=none; b=TM4PYRxpQCz5HWTL7lvECgnZ2adgnO9o9fy3YQB7Ko2j+NZbmVx0HiLvdeXBf7b+cp/g51isT11kSaIZRtPHWkeIL+dAAGpe3WXmitxcl2+2TEeG94qvpltiXddZ0TiqosDfDnKFvcdv24OSrj1T9whe76pkNesbi0IAnpu7nGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744961973; c=relaxed/simple;
	bh=/1VuCG6jM87M8/EyQ9lV8hDOl1vR+F4qeQgogQnONP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5EFRjEBmTkSOBvfMVy0GPwSiLRWXizDJiFeKcCFSrYz3gUdydVMeoNSN9mWVYSftROaq0onyhCn/2KqRrVVQxR0TvgIdGUNw/LMCIQOUuetRAR102WUtY1WsSGzHFqmTa/W4oe3XY0u20GzHEHLL+6OFRqXvbR8cP3pu/YocTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Onv61T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso18124725ad.0;
        Fri, 18 Apr 2025 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744961972; x=1745566772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HROl9wmdgf5B5YanpO2ZDSQM3+H0ccOnWXPFfSab2O4=;
        b=P5Onv61Te0LlPkH9Lm1sVv7gdCpkmIXLi+eHet6N4exnM2QLaRFzPwghWOK0tcGjQ6
         /JEmdmR8SMopaeEmN1zIBXjMGu5Evt1MnT3CFG9CeddJek+moKHEuMkOV+4TNgPevuPR
         tlFPtNn37yZpI3ymXdYokQMXMbpQFGxTCEWUzj2j8c9Fo0tIYY7hzz/qO3X/okevdvJh
         sKgBTSstNtCfOn38WRhiR5sRClnvkg4t5nVYTDajtynl20YAsmGVBvNo0cEHxutuZRTn
         iipUDhqsVggI4X9EyTt930m6f+hwRB5oJmNZcMGNmjy9sTPs9c8cY0JFUPmIKLxyiGzU
         iDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744961972; x=1745566772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HROl9wmdgf5B5YanpO2ZDSQM3+H0ccOnWXPFfSab2O4=;
        b=vm7pz4uhZVjVWUxh6EHJLYXz2jprs2QuliZ20sIgqnM4uy4W9aJIZRcx1oeAmWSkKr
         sWrgbfIrPoJy9jOluQ0oy4RKZHh0f6v/YN1Dp7xf8Ko90tvDAS27xIA4n7KAKnjQLJKk
         kPfqgLn/7y+co8V7xWQXfMQ52A6fFMj1DblnUsvnGg7Tgj60ZsRlWoZyWrCbMOynIinN
         eIdENJVMl3pJZRTXeyeWeqSu6uUlt0ZBkw9vTZQpCPewptEscu/2DwNyjhpRVo4f3quL
         Pr9St/a9AqwChoovloENl01mGe29li7GszvqiA0JQgAYWjc5i2Vo7CZVggn5SBdVj6ua
         +r4g==
X-Forwarded-Encrypted: i=1; AJvYcCVn+GQX1ujU4xzcGPqUP8AuefUhStSC4kIEy78beyxW61HWLYXsWE7Eg7c3QrPUG1/DQRHJ7fOQjOrrpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIT2oa4qdMJDdIrS/SkVGPgFT4NK2sDa4iN2/BI7Z/ThX++ctJ
	F6PH5hIlg4hfSjGptn8VK9nExJlwbumFb8cunrG4Qkjyosu9Hf9JrgCbkKjyGyc=
X-Gm-Gg: ASbGncvuVa9N8IyVy+PhvBMibzzHiQEJiUnDMZXJnD2Wum6DhkBaf517ZhDSPzO8TR+
	+SABtXdo5o/GmoojKlCUQJ3wO/zJFXFWRO3t9iGdxxsK3O7ElBm1NbyK7SZSIMKD6AYXNJb82L5
	3XPIyzvxKY9/3fAvr1LJsny6wubXi85SQShJK/xxa3EZWCGP6aEt5IoJAZ2EFma65SB5BGbZt7P
	hp4l9CiKErMMISy2HKyHdYKpVuhrI1ueQnHPFuCGALFsVDlqCUV/0+AV7A5x0tRRBbvFAdMSbXW
	1rgiccoFnR2hmYkXH8WdQi7QB8nAG0y4JLWyJpmsNSmaYQ==
X-Google-Smtp-Source: AGHT+IHyZMidMmNlgGttYDo4UR6LkO0j1A87Po469K62oxAGa4H/lp14QfNk0SSwNcYq8vSOCL45/w==
X-Received: by 2002:a17:903:19ed:b0:223:62f5:fd44 with SMTP id d9443c01a7336-22c53607f99mr33798015ad.40.1744961971605;
        Fri, 18 Apr 2025 00:39:31 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eced75sm11327355ad.173.2025.04.18.00.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:39:30 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:39:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <aAIBrKIWltiXw_av@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora>
 <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora>
 <155385.1744949793@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155385.1744949793@famine>

On Thu, Apr 17, 2025 at 09:16:33PM -0700, Jay Vosburgh wrote:
> >Hmm, then how about use bond_for_each_slave() and find out the link
> >that has same MAC address with bond/new_slave?
> 
> 	But even if we find it, aren't we stuck at that point?  The
> situation would be that the bond and one backup interface have MAC#1.
> MAC#1 may or may not be that backup interface's permanent MAC address,
> and we're adding another interface, also with MAC#1, which might be the
> newly added interface's permanent MAC.  The MAC swap gyrations to
> guarantee this would work correctly in all cases seem to be rather
> involved.
> 
> 	Wouldn't it be equally effective to, when the conflicting
> interface is added, give it a random MAC to avoid the conflict?  That
> random MAC shouldn't end up as the bond's MAC, so it would exist only as
> a placeholder of sorts.

This looks good to me. Thanks for your suggestion.

Regards
Hangbin
> 
> 	I'm unsure if there are many (any?) devices in common use today
> that actually have issues with multiple ports using the same MAC, so I
> don't think we need an overly complicated solution.
> 
> 	-J
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

