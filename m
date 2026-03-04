Return-Path: <netdev+bounces-263710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI8nHt8DqGkRnQAAu9opvQ
	(envelope-from <netdev+bounces-263710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:05:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647C1FE121
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34CE2303BA05
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0239A068;
	Wed,  4 Mar 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XsN3t+Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449C396B7F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618714; cv=none; b=XaeRZMU4DmtSX5B5YFjQX48kfvwk8rGaLCCLuWo9l1rWlF9FkDY0V7TW58c6AECMbl+cIuB59NTtPdhgvMNOMsEB5IR/4JxHyUhg5p/GB6g2v+LE9W6uciKLbFIkMH8agcfmkIl+i3Qza1p3XvL5Lg7Si821fAB1yUkpwgh/GIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618714; c=relaxed/simple;
	bh=dgVJAhqnOIPqC5PZq8vBwCOU9OzRV/WoR8Mk8PnVt3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7916RBaXY4TVhNM9e/nfBa4OdZeoTmWn9MsbGMv1vJINCf+AFBXTH2gDQECtyEZmfHOgsvOswQP0JV9AS5ZaboBZihm9TH7StXUBAUBMu/jzK8WpYY2/pI4QocFxa3andg+YQuqxc3eex4WOa2YOhMPY+RW96rRipG39x4dY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XsN3t+Kv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso72184425e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772618710; x=1773223510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gDnR/GlX5r3MxOQp0wc5+efc8WjR6tGLkWS8cjDDi4=;
        b=XsN3t+KvRjLmQXyGUq5jGUsYLtOoKckGDvdjFPqdf+t/WgrKa6MuFAOCdwrn/g8WIe
         nDCe6oN/KroI47pNwQbREv9OVhK/qaQtApRuGJrJPNsVOd/l6yRRCX25RS1NyYTdwb3p
         jOG3z+IQbhDsiwrq5LBFyGR9t0hpChPYPjUB7HZE31HaMGx9jYjv/som+VbRtbWiDsY1
         WnXhEoQrS3MNUnX5RjG4CuflIR9eyXQ5OGt7Z5i7gICKuHo1uKY6gLIYSD8Vr5dgq/aP
         oqes1OLZxrrSZCaWBGcGsDHBlKbuu7j+k5pSqOARsJTikBcEQBvsCtEnGKZ9qpCSbuwS
         NNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618710; x=1773223510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gDnR/GlX5r3MxOQp0wc5+efc8WjR6tGLkWS8cjDDi4=;
        b=TKIrtSxb6r4GpMaI42b2+wC1Iy4cFmzX+lM3W2IqANexTfrxHBxctOpLPN0sWv3GSo
         1c2rTorxTDuOvZvTMFwGUh5+dKQeS7tT8VZ42oJuydXclDFSLQseS0p37KyA9fSI/gB/
         QpGdMMAxA63heJigJfq8SXGyHqQ/0DsAASbqdFD/7Gr7LWLj9ycrxufZ5ZP0lEBiwCgf
         vRH8ckaXmYPuHAGoK+XGrEglQQ0l9JmTYb4POgpKTXmrOyLAhjBjltxzSghY5Ezzkd8U
         Tds/StKKZuKiBASaOW7hXVtW26dG/93edw7BPJUaIiwwik3HiUn05krYRx/grUJwlXoL
         8UKw==
X-Forwarded-Encrypted: i=1; AJvYcCW+acgFDoWZlCUCw6GbQW2CMZDgwMLcN2TB37J6sDpS1h2SIKNTZNP8HLRd/voe+lJx1HHMDWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxluH9JKIj4lFmlJI5jSTwuQGcfjX2a5kXAFzLq7ktOaySLw3C
	rMAOKZrjQtNAQvXJUvSYy8ZVvg1/FQfOeDN3FuCxiCWUQXHy4cfkB0zaKNITgmw9SWE=
X-Gm-Gg: ATEYQzwzviWVPkneDMb3YqgzNWu9YAGg1jk3eswfMSJy9Q3QeyVos8kLu/u3fIJ3J/a
	wAjQa6FodusLlvGLrFf7CSSrdLg17Y3elTnfqRCRae65V935w0xpp4UPBICfgl+EEqvInoRZw4c
	EEjjwZj/WIJr/F8PIeIOstnV/FqC+XsYC7/Dz9EoBSk5qaN6UpTnOqKdRG6c4nkDKI7EvZ9nx2j
	gfqXxdfnxW/VbySGgheEKZY5LBtd4GVcggtY/AYW/XWwShb2WLz3NYCNlSrOsgvh3YyjHFr0p3T
	sA+rBbGRUZ2Ng2wceVk/CyA4AIGXP5fd+ZtaODKZTbY9Xoq+jMYz6tKcetxLRsXiXr0Vj0C7+5B
	bZNdsCFEkwqPkQp3DFs1Clkb6L+K+yMy+j1x+ct9kQ/bUZYZ0CRDeYeRnM8bYsGxsIdAaCS9Btp
	RUZ6EURLJUGEu0BNClJr/zZHTZVmFa74yKbGk=
X-Received: by 2002:a05:600c:1c06:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-48519851b59mr26465905e9.12.1772618710225;
        Wed, 04 Mar 2026 02:05:10 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187b7851sm70235585e9.3.2026.03.04.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:05:09 -0800 (PST)
Date: Wed, 4 Mar 2026 11:05:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302192640.49af074f@kernel.org>
X-Rspamd-Queue-Id: 1647C1FE121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Tue, Mar 03, 2026 at 04:26:40AM +0100, kuba@kernel.org wrote:
>On Fri, 27 Feb 2026 00:19:06 +0200 Tariq Toukan wrote:
>> With this series, users can query per-port resources:
>> 
>> $ devlink port resource show pci/0000:03:00.0/196608
>> pci/0000:03:00.0/196608:
>>   name max_SFs size 20 unit entry
>> 
>> $ devlink port resource show
>> pci/0000:03:00.0/196608:
>>   name max_SFs size 20 unit entry
>> pci/0000:03:00.1/262144:
>>   name max_SFs size 20 unit entry
>
>Code LGTM, I have a question about having a new cmd, tho.
>
>Does it matter to the user how the resource is scoped? 
>Whether the resource is at the instance level or at the port level?
>
>I worry we are mechanically following the design of other commands.
>Since the dump handler is new we could just dump resources with port-id
>there. No existing user space may be using it. Alternatively we could
>add a new attribute to select a bitmask of which scope user wants to
>dump.

You can specify what you want to dump with dump selectors. For example,
if you are interensted only in port of specific devlink. That should be
enough for most of the cases, no?

>
>I have a strong suspicion that the user will want to access all
>resources of a device. `devlink resource show [$dev]` should dump 
>all resources devlink knows about, including port ones.
>
>What's the reason for the new command?

You are right, one cmd would do. Good thing someone forgot to implement
dump for it :)

