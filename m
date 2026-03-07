Return-Path: <netdev+bounces-265109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jIMqA0fZq2kqhQEAu9opvQ
	(envelope-from <netdev+bounces-265109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 08:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5622AA66
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 08:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D413027115
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9630F534;
	Sat,  7 Mar 2026 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mzgeg7MI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7493282F27
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869954; cv=none; b=eUkiH4fIQhud42WFSgvVC0xf3Lj5TDSztxv/LOqAZNP6bqkM2KPHlPgAYVfiOYoRgzGmSMd8awbgh2TDpVqRF1Gwd3iYGSksJgciNiNU9XyO+cihNrgeUkbRguQ2nBh7nmEOIbJ9iY4p5qgNnX7XnHKDFAWaySjgsI3eNPIboYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869954; c=relaxed/simple;
	bh=PLl3ybbEvtBt4usL1tVzzE3ceztfK3Ph05TigYRMy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvKQWo31YuNk11Sb9jkGEeh4dYIIGjfhPR4Jq12RIuFgwb7a6660g9AktVcNM3whsrLEg9jYSs0YJpZteJww/LrtEtfMADm5QcPTRvoLU4dj+DQywxjtzxt6mdcV6s/mJHXFmc2wassfIDFkdd0WObO6UOgmT62N2oBUeK2pqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Mzgeg7MI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso82405265e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772869949; x=1773474749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=Mzgeg7MIOIrjh+c3vI3Akf/UIjsNyGah6a6RbQ11xw0pXsGQ+c9Wsv43WQfpej1Mfo
         dtehQ3GsKzPO+PydcLr/RnoknSaS27Z/tH49od5FsnCCB7MeCkj8qyLutf1JLXc7Fdd7
         ThvyXVsnu+Q7c2an3F+1SjedMiGdA5C3dSfulg93qQwup8IWQ6elfpQlhRQOTAZH1tP6
         P+tdaZ+mC23yQicU1Zdxxf+JCJiq4BYqQ74/jU3PUECHrc1dPph9IWH5Nv+NXSVTl1AT
         cDQz1MeaW1cB5T9aGQK5Xs7tR9qRJPLK5Fki8r80GzKu0VJmH1PfO3WLJzy6zXgIMh7V
         I2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772869949; x=1773474749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=g7GXMdLm30czX1Nw2W4LNK15TeLvYavOFMbFCj6blVtD+JbvH09xVy80UFAReXeMD4
         p8QPVzTTADEmJeVbpXLQPfi8+DIjUm9edbgP3ZxFip7g7HUld4l7I2Zqb6FcPNTozrw7
         81WoFqczIi2TtL58pm7BziEWYnnvyw7K9JQvsVoJtwgoZo367C5M6yiWRh8jiUNFYjTo
         2WZhr1mswEGbPT8aPYTXNalChfsz3a2fWbXcF0pVjk4PrvH+SpbjAHdNmxuXTz58EBZe
         PVX6lf87uDGQ7IZkz0/YgtG+eVqeod10kzXHJn1ZDefObe+hYNrmZ+LKguok/VqcVtBu
         FeIA==
X-Gm-Message-State: AOJu0Yxc89lPdtMNDWg1dryS/KiPWOeIGZI+HSRk2rsIAEQqJcapPheT
	za1EbWAj6XSgUGn3ReEqw5N6lqAA1f8aLk+j4AALix0DM2XZ51hcFL7J7spWe6C7GqY=
X-Gm-Gg: ATEYQzwOe9Onjyt2zwRYHm09VI5mMKNvkYSoNx5WTCtbZ3Al1gWHJB99SDDJYw4ZfbZ
	brAAqpFLlymFGfMSf5dz8oga/y1aFI4OzVBPmu7s5H7qRywoyhZVp8feTKAktTxzuuj/7LH1uQX
	9MbshUD04i4JXp72eDF5V0rJ2TZ8tIqwdIJKTEPoyR0bD9v/CNAz2fvg08l48nFuskADsBoD8HH
	vDalNHyTPfjrMJz0gcLYfDJNHeaOqTX199vP5ioopadGmaj85+EH+8p2EcVBcruFPShBK/Qk+Qg
	mlsnLr5EjhLhZFoaJHPObN7o3Ofl4tX8eWR2UG+0n6RXGTJoJNmv+khXtQII/5we8pL7n6pSOQm
	5BI7W3PJLUVhmMtfnWa4mU09Allj7XUSKXkZcvwve7tMGjmnr+TqWphNJtvAkXtv3j3evNigYPH
	3pUFczdAmLdpVYvhocJAlq7OJILZ1wuQs=
X-Received: by 2002:a05:600c:870e:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48526951415mr82861225e9.19.1772869949098;
        Fri, 06 Mar 2026 23:52:29 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852381c61csm36839135e9.11.2026.03.06.23.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:52:28 -0800 (PST)
Date: Sat, 7 Mar 2026 08:52:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/13] devlink: expose devlink instance index
 over netlink
Message-ID: <xf2qlcvpmw64zpqsjogibda2ys33vwyectptwo5imdstwtp6a6@qokwax4d2iwn>
References: <20260304160022.6114-1-jiri@resnulli.us>
 <20260304160022.6114-2-jiri@resnulli.us>
 <20260306193253.6d7d2383@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306193253.6d7d2383@kernel.org>
X-Rspamd-Queue-Id: 53B5622AA66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sat, Mar 07, 2026 at 04:32:53AM +0100, kuba@kernel.org wrote:
>On Wed,  4 Mar 2026 17:00:10 +0100 Jiri Pirko wrote:
>> +      -
>> +        name: index
>> +        type: uint
>> +        doc: Unique devlink instance index.
>
>AI complains on patch 6 that the index is truncated because it's saved
>to a u32. Let's add:
>
>        checks:
>           max: u32-max
>
>here and the policy will take care of the check, you can then remove
>the explicit checks too

Okay. Thanks!

>-- 
>pw-bot: cr

