Return-Path: <netdev+bounces-279253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAq7ChHm4WmKzgAAu9opvQ
	(envelope-from <netdev+bounces-279253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C3418281
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E025305F3FC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8F37F8A7;
	Fri, 17 Apr 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBJAKbcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C73815CD
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411814; cv=none; b=mofae40CH3tgB+AsantFjXdSMyVH+ijFS9sydjDIUzWozQPjYdp9xNxfp8ITKewDI78J8DGh0jbYEA8qz6Aucje73Pig/ebMdKPYI0mwX3iLCstNHdyNh9GSztM2YacLjxbSIE4dCGUkpLamVe9G399u94bbCOV+Vnkfgzah768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411814; c=relaxed/simple;
	bh=7TDAbrtzems1mdoWHs3U16Rrbtm6ftMbK6YSU6s+wjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJSs/hMmYNEAr1Ciy3cRKc1KYItSIolmy1DEjJ3idIYfZ70YPgs2v0TGz86obnYDTj8qHKczt4poYmt+IUprmJa7ysSMtPc5mEvEQ6Cbe3rytFRepzuDlUyXZkBmeDGQjjqXuar3CDUga54Vk3PMukuZUQqgw1+EDC0/JHwCWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBJAKbcM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso300689a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776411805; x=1777016605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1ZNdH13ipZme4Y4qMwgwn38uWUUdSJtBL0WmZYxRa4=;
        b=BBJAKbcMCskLI7fqOGmXtLEEvOXnA4IXf/slg8KXy7LF/3zX67W1H7B78dxABBJt9D
         kvFHIY4NV0e6dyVKu9y/vGoUCZkcOff/vM4y0QzUH4YDJ1eOVqz0znEqX+DaOvfbl7x+
         CGDJ4x2s2O/YtPbZZZXSMkhFforF2lSjiN0Ol7NXETO9odYNYJLkvbl4PwwONfqwD5/l
         o4pRlxWX7Hobin5fJDkn3E04b13azwWuxkrbreo0wLN3i9IrgLDwaEPCmQc0JLyIc4rn
         UW9zAeECDRjJkZqfZ/BN4zS6Gfk9WwLqIXq/sKtKnO68LaDQ36Gp9oWrCMT+OZIt+X83
         uUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776411805; x=1777016605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1ZNdH13ipZme4Y4qMwgwn38uWUUdSJtBL0WmZYxRa4=;
        b=h+7GizabmFUL4Nos5IsOTy0KRahaxLqJd7xxq8zvsFQ9nfOgSIf2Sp6hZlLxhxW9cC
         8PzCAuAlB1nxyVWPr0N1fUcZCRLSJ7zG06vcr4PLJ6Cm6fgErIGXdJp2yrMuec5iX5GJ
         ZUwtcy632v2AYQLty2YaTfuJmWR2qIrv3j8pDNgZbwYbtglG+10GwihmrJlJzyejLgI/
         nNcSNmeqGul9zx9pFPjuV1ljBIoYYZuwGJQMyKzhtTRhO5fZk7eqnxOMP6qIutaGRxP7
         4PLm61i3VxmMmtp71ce82KxD36R4MOFKyGBD6w/3H5ff35097BAahQbHwYAY+PZe2Ii2
         eVyA==
X-Forwarded-Encrypted: i=1; AFNElJ9EGwVp63uZgarZ1pqVPwOG28HI57Z8sr8ff+wGiirUA2KUUuxOajgSpxhh5dEbs9mxDQ0aNJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuoB6MVDtb4RVWy9tX3MEGsKMvJy0/mu/ZTaz/4+cQKThMPKLL
	jNPZt4GpKbSbn0gDUzlmNQ4On9CkMXgNziE7uXT8xjwRjev3PRyQA9gCbp0oq8WB71c=
X-Gm-Gg: AeBDievLw2uBZlOIRDWlayx+lyyAWSIoHUraOYjyr9USzyFrQ81bKxyhbotx6xfIz5C
	JSNZJe1CYfEZU/2tiCEuTMZpdUVLYVnkUv2nQ3O4kSNoo+uyIwOo6cDcAv3bVkYJUGA1vLm5lwI
	CQLzg1sqgkmYfzYlTqJ3B5EH3fnPeeNbX/Ezlc17Gg256aPEJeyTB3eb5N48UgKeTynPc1KYt50
	a+HO7Ysa6Mf0KDbVAxLlubNu/eNnd62NId00cIW71WyEjxcIjvOaHEZAbfupDKiMN5OgVDdUVVd
	o2/6QOCa1Lrf03IyX55xMHzwYALkbD4Kfh3UNz02Pwlr37GezIGsR3luR8od3HY2PgN9FPesuzd
	SJdU/e9Ld1ds0oDExGfDw/Wp3bOBYSPIw/S9+7UCG8UGQ8luam0LQ3CinTITSbVnBpcyLcxl+1O
	pWo73QJHLtknMl15xLJDpCbgjc6yHlRXZbTGGQtk1xp10=
X-Received: by 2002:a17:90b:2785:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-361403bda05mr1752318a91.2.1776411805038;
        Fri, 17 Apr 2026 00:43:25 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141973c57sm1079042a91.14.2026.04.17.00.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:43:24 -0700 (PDT)
Date: Fri, 17 Apr 2026 07:43:16 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Brendan Jackman <jackmanb@google.com>, Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
Message-ID: <aeHklHWA6YpY98RN@fedora>
References: <861b722f-6d5e-4f47-9d17-00a98fceb8cc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861b722f-6d5e-4f47-9d17-00a98fceb8cc@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279253-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.mk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B77C3418281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 04:07:08PM +0800, Qingfang Deng wrote:
> Hi, Hangbin
> 
> This patch broke selftests run with `make -C tools/testing/selftests` as
> make uses /bin/sh by default:
> 
> /bin/sh: 5: /home/qf/linux-next/tools/testing/selftests/kselftest/runner.sh:
> Bad substitution
> 
> Add `SHELL := /bin/bash` to the start of lib.mk to fix this.

Hi Qingfang,

Thanks for the report. I saw Mark helped fix this issue.
Sorry for the inconvenient.

hangbin

