Return-Path: <netdev+bounces-264764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFPuIfrEqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:13:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1C2204C4
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A319300E17D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1038E5DD;
	Fri,  6 Mar 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ebePal5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF8038E5C5
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799213; cv=none; b=q5U9rXAlOYuFLu8++iINaVtYIagjt6sAVuhOTp5/1ULVL4Y1JnVxIzKdkgwJojAhSpITNY4z51tRv+Rj8skV+n9iXa9BPuKQ3OBuuViiYxeFoMTTD2RNh7Ph4RwKlxNjVIDhqBjUqeFuxfL5OX4NJHIhtcRgV/nWI61O7akZsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799213; c=relaxed/simple;
	bh=iL3nHsj2qbN/ptZ32yL5eiwUDcUBsCkMTT+rcB3PMxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3CfRsJ5yGBKMGto61Mz8UugTxkuXFT8w1vYMjhucaM5g8LOpwDtUQPY8/Qs0ex2orEMu5MDSnOuq3Q/3+XJfWBFDQ30fHqH1GG2Zmk+M4TwXLjYzCDtnjEF3KStQxsmNMcc46/UaCvLyLe7GmKtTGhRbYpyuLZEqyqgJYBy7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ebePal5t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso85519625e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772799210; x=1773404010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTpTiYCmYefmS8voVHhTmV6UthynmjNZaFJx1xqdpVE=;
        b=ebePal5t6HxHoJBNoARUWaa23plUvf87O/bmUdgs1xJyNY8MgzRCJ4pZYxQwDqbNqI
         CzdVMwW/wuYjxdrwhOEHph9kMh8D4v0osXRgDx11NoFqv6QSQpzM4fhWtLja24HmA7xX
         0DfZdgtURfiBXxa8luOdr4FZpOxGgaVTLFrD5VS3R9IL8rp/dRpPJSHe5730iobk+v3e
         XdzW/mYri2yNMKXJtn/A3EmBtBIt8vS/hWWYK/eqXmjtfgqJjy7bqiOeI0FQS/obIDs0
         ArZaLYnwwKZWVKTUdwudnZDxTxRmgZKJ6gWudyK+aq7SJq3u/2DyZkjttkw/n5bZLXKX
         03EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799210; x=1773404010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTpTiYCmYefmS8voVHhTmV6UthynmjNZaFJx1xqdpVE=;
        b=khYy6X+YTIOfdHKV3psaNoCwv5IPtkaglgFQ8ugOcUx8y2cfnGdQxwc5cGmnBVuHlS
         u9L8oXBfCxPSOfDNp6W9XUgoPf2p2FdB5BvsABpeg1gk67w6bIG6q03V8YuqMbr9UaS/
         xjBa0q4bH/odTO3N/+m98aNL/+SFQ1iV4VB665DGSP6jC4sy52UKomFMEb8fj442MG1O
         F5YQjrcQMEDbupClZc0cQbCLmpOzNWzw8AlpgOtwm33lNgY8+3bXP3+kGt9WZ8EfExtS
         lgJOJ4xPN9bhL2g+b1YjgQrgsDEjJ7NBIiIUXWG43CGgpTNg8JePPo0dXgiGcQO9l/6W
         vGlw==
X-Forwarded-Encrypted: i=1; AJvYcCVsqx2IESoE9UpdYpEFiX8RWAv+6HTfaUPqpe8mG3Kx2TUwag2SfueTJPXHwRB/PD3IzNJGRCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5MADnvykRu3KshLZOkTLbTip0NiaPhWf7Mo3bNNCLYxW1Q+n
	Lh8muoXBzWLAbGPwNwZ7PudeJwNjiyyxp1Rabb9SkhlWeKPu9SzjaTcSpFWlteOLIfo=
X-Gm-Gg: ATEYQzwhmNTf0arA5YrZ0dq7rh5P2y8sAa4kS3LgKmPvp0tQrrl+ESWNVhefFSo1xln
	Iw3rxpOW5CvgqbNW/DhajahJC9wD6GjjNL9b5oSfL2DJZylDebJMoWwWCSrxv8wpdn4R3b5wX9a
	vt1MBjm8hPELBtSaGaIsa06Cpf5ZMRDDJfVMqs6efzc2Jik2WVOBJNIczR1Tk4iJUdKrYN64qZE
	VwoEq8chaoH28ypq3UBxnHtWwUOXQHfpPNdUwfDkzSgIwoy+gO9TXaTdk5ApkpWaAr9ftNP+4nE
	RrNFAZ5+fRBzmuTUh4VqsgnkS2G9SRXbbNnOjdAepfUuKX9Nauh478ZpBYPhrCsH8tS++7WHq58
	405AvJQ5IvHyUcrUaZ8IRTIgTwnvZ92++rbmwp8YF/+mQTqjq5Cn5tltG5vw4ep6kAJ+M3JJeEf
	Z8hjUMGSPwCkNl+Q5HVJFIoNjTVJAerqTezdTpFfOFXw==
X-Received: by 2002:a05:600c:4fc2:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4852692bfa5mr30418785e9.13.1772799209987;
        Fri, 06 Mar 2026 04:13:29 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485256b1eacsm30285005e9.0.2026.03.06.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:13:29 -0800 (PST)
Date: Fri, 6 Mar 2026 13:13:26 +0100
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
Message-ID: <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
 <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305063729.7e40775d@kernel.org>
X-Rspamd-Queue-Id: 01A1C2204C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264764-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Thu, Mar 05, 2026 at 03:37:29PM +0100, kuba@kernel.org wrote:
>On Thu, 5 Mar 2026 08:56:42 +0100 Jiri Pirko wrote:
>> Wed, Mar 04, 2026 at 07:15:22PM +0100, kuba@kernel.org wrote:
>> >On Wed, 4 Mar 2026 11:34:13 +0100 Jiri Pirko wrote:  
>> >> On a second thought, if we merge multiple objects into one dump, how
>> >> does this extend? I mean, the userspace has to check there are no extra
>> >> attributes, as they may be used as a handle to another new object
>> >> introduced in the future... Idk, it's a bit odd.  
>> >
>> >That's true, the user space must be able to interpret the object
>> >identifier. So if we extend the command to add more identifiers
>> >we will have to add the bitmask to the dump request, and have
>> >the user space tell the kernel which objects it can recognize.
>> >I was just saying that we don't have to add such attribute now,
>> >maybe leave a comment in a strategic place for our future selves?  
>> 
>> Or, alternatively, we can have per-object dumps as we have for all
>> objects and command right now and leave things simple and
>> straightforward? I mean, I don't really see a benefit of a single dump
>> for more objects :/
>
>What do you mean by straightforward, exactly?
>
>User will most likely want to see all resources of a device in a single
>dump / command.

Hmm. We actually already have this for region and health reporter dumps.
Only for params we have that separate.
So let's do it for resource too.

Thanks!

>
>The objects themselves are identical, they only differ by the handle,
>and yet we'd have two separate commands to access them.
>
>It's as if we had separate GETLINK commands in rtnetlink for devices on
>the PCIe bus vs connected via USB.

