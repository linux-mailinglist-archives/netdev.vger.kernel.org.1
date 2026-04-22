Return-Path: <netdev+bounces-280426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLlIKbrN6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143A446C27
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5471F302C6D6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86483CAE65;
	Wed, 22 Apr 2026 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlnqBRvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57038381AF5
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864262; cv=none; b=Lnt/uvh4hGEiw2OHtQjSpmWL8QdXtQXl8JlGODCcXcUwjLx9qFLzH6dAdhn31d5NSp61YwS/UtCn+h+9MYoLZODGGIT7wh0sKJix0/9s//zAHMxNReflNsFhYDXiEWmd37Mq8h7lf99cKbE7tkOzwGTrDdG3T69EJGRYaO1kc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864262; c=relaxed/simple;
	bh=vgxoIN557nDFvzI/TTrbPnjmb1JV6mfBHH85hdg3Vag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUoiyKfFH5uwPfR9IxigxU3YZ4Y1nlG7cn70x0qeerhyJZIeMb7tmvDxZc2PT9PS1qYU5bsJimDGAAL7IWAqmNYNiGtdxyLPI+mHb0ghcKUl04r7w/cxrCjsRD5/nNtp8AJmuWXrkJYlNZhOfBoqHAnTdvRknriQ5eiYVK4IXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlnqBRvx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79db5e18ac6so66251277b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864260; x=1777469060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oy65WrzLsyhPH4xON3+ggQSwKY4cV96EkJ63SIR9TYc=;
        b=YlnqBRvxMe8d8c2SguxtWdKgtb+Mb6lpObECA+l/XlFqXJbIxJ2S4DWw9HoBeUlMeZ
         rMWROTKh/OiWcec5GOprJ49Xj8q02QP4QRatMDYasQLtJe0CSE8RJTGqQh//8QSOM6/O
         68QMMSrHCbiYBtVmfwtS6hdOjre6MCrtUA/+IpwD9IGqz7qQPQlQbas25rfJso3omMs0
         uzMAjNVEDkQJL1ZaExop0LLk69O1fo8K7nqoDihwmhJPNCUSTRHlAXJ3axAW568SJU8s
         /ucimmu7Cs/DOOXN017Iy/qXTyPGZLwluBBQj8gTdOrSAIxGU1Odz5aALBnrKwCF9aPp
         wWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864260; x=1777469060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy65WrzLsyhPH4xON3+ggQSwKY4cV96EkJ63SIR9TYc=;
        b=IWZU9A8EVKLCLA6XOYFXMAuQ7kyIwybAngx0VLgj1+fh2sXmt7pOhmhzqnhKpWDIdg
         JJWivgZmwv3exgyUs8zCmsvJw2wMOQVFua2wfZRWsHaXKMa3J00s/rfTeU+R5QKWpdVR
         B2+fRjGxQMqP8BFgycOD/in83fmzpAzOixnKmPbsApM6/pQ47f26vfaXIyaPqUKiNOC+
         j8iyP0etvNyw2rwYxD9mqGVHsawFoZzlvmy3HCr9bu4nb70lBi56XYnhDAz4r8GZSxGC
         w4b3M2ETNPFH2BC9uEb/KRDkdgiQz36NBeRZOgRKwKCieTV3qLYgE8fW/xjvi8R8hKhy
         lW9A==
X-Gm-Message-State: AOJu0YyxBdfTlnFQGRn1QWiL0hXbnLIgUxqzdw6g9SKLvR3epyjDUVUF
	7E+mCSFlVtpOz4nteMKB11HP6lNAQGCCIAHfasu7hEs2nm2YdeTJc/5A
X-Gm-Gg: AeBDieu54UThxndUtNpAyeHm364JJV5t0SyGVaZhSE7hTZEmFHm86jb6hAqppoNfIPr
	MBFy6KGfBKGp3oSUc6B6bNHccDNEDZfU1e8X33ftYjMDgUpnWTIKVOWWUg2e1r+K8UhdkXUDXBa
	raOJaiaVvXMlNxlq5kT4uqGZAwuezEFYC+gSQOiQ2GxT/77DBR/dxwq3IfQGPN+tCUA/tjAoOLc
	B/lcSfcQA4cBAOAivc0TnaeYGM0AR5/8z3NX40Vlh2d+nhRHjO9dEiuWt3tWAkj3QOlG+IOlaWK
	IcspDSd41J5tEUpFYIZ6udrTrDQpXniXw2AUQ23J7YA3NUwHbgR1iSCEIs/ydBmbLz32Cj0AVJE
	c2rH2T3Ro3L9zlAYD1ClzNGRe1qCHL+dL4WaRCcNAvbAT7UN51UqTXajLQD/vYh3mE2Yp6MXaFP
	MkeGJ+JGPA/wbffD6U5YKz5+lckmyY
X-Received: by 2002:a05:690c:11:b0:796:45d4:9e55 with SMTP id 00721157ae682-7b9ed3d2454mr162986717b3.15.1776864260449;
        Wed, 22 Apr 2026 06:24:20 -0700 (PDT)
Received: from localhost ([172.216.252.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ccdc4sm67554937b3.43.2026.04.22.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:24:19 -0700 (PDT)
Date: Wed, 22 Apr 2026 16:24:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Message-ID: <aejL_upxRzEZx3qG@stanley.mountain>
References: <aeeFh1zQqhVysvxI@stanley.mountain>
 <CGME20260422105813eucas1p1a59a07ab8c1ac0c4b7eba37d509f69b8@eucas1p1.samsung.com>
 <20260422105710.268003-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422105710.268003-1-j.raczynski@samsung.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 3143A446C27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:57:12PM +0200, Jakub Raczynski wrote:
> There are still places in the code where manual calculation of array size
> exist, but it is good to enforce usage of single macro through the whole
> code as it makes code bit more readable.
> While at it, beautify condition surrounding it by reversing check and remove
> unnecessary casting.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---

Thanks.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


