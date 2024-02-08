Return-Path: <netdev+bounces-70323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2B84E5A1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56988286CE8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7E823C2;
	Thu,  8 Feb 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vg7+YDUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9597FBA6
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411382; cv=none; b=r5Zt7cedisUfN4oAcc+g6VyDCXMsDse6D7FCtnsfrc0ETg8l8pEBcQWEWP9/MUhgo67J2r00oX/Nlbmuwsjo5t7r5/FZXfrq799VALDd/7ok3QLUGLGd8824zW65UwL4Cx02GSIGmfFR3XD1xidOAlAaP9O1jBqxNSUhPsejFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411382; c=relaxed/simple;
	bh=DohX8sAB7IIvNrFjxtvDTOKnv+ntZDy+c28KQSpW01o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI+HCV5T8GoVnRNleWK767Qn6KoVjG4xiiPlK+E/GRYYnpbrKggscbSEBvbbRVbczoVtXUNLxFPMrMGS/hjnn2HA1h3BnKNum4D2oTy4Dxca6Kuxv/fh2nn+xjBumZVaxc/J7gfrTtQw27uuQZ5rcnO0VFxIr9Wctns1+gfMTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vg7+YDUM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so27060b3a.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707411379; x=1708016179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IWTganX0llgMryD07FfLPr661KFW9fTZBnn+PsTA4k=;
        b=vg7+YDUMhK5HsjRS6AgZImmojOhrs0MY1GIhTdUxtoDU6DWzBHjB5ordI1CY7FRZfO
         vANnl2eFxD8FeCaCpaONuYWUa1gQ6xwBfSiD6LrdNzetg8DUQI5f9EGYQ9/8+7flDict
         hufKYBIZxVQtpK0TCRh9EAXjB+o4Pf/ub7zo1+0dRNhVrb/xD0s/MVXQzwHrL/Gu9rOO
         z7HuBv/p4Gt+gdlBsvOH2pY320Ry6FGNY38CBH7QgABUHxvUpgLIDr79S9TWCMXpP+A3
         uugTmsvcLBBwv0suWdbU2DZaGScNdI6yTt/kZCfSIi00ica4AI1gKTMt+VlO80CV0EeN
         kZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411379; x=1708016179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IWTganX0llgMryD07FfLPr661KFW9fTZBnn+PsTA4k=;
        b=nrHVT8dbdpRxPeovsyDaos5D/w6QomDIeXQ+W/70p7tV9BsYpqv0eLajHBPhZp81nv
         tOWPkna6jqnkB92qZ6pB3MfFE5DKpcB39eojmZtnMZ2jE2RexZ2hHpkJQXfcjDxN0y3k
         Ybq0oEGCivzkOliNW2civuNmhb1G6EK0THv3+aP6431ZK+ydHNunb5J1nndufkxa32tH
         dVfG4K8P+sNbcNGppPgc3df7anBxUyMuSmwWlcHbMxBcp+SwSb5hXkVl0SD2leoC3lQ1
         XOwb4lOySA/ErQzA9CFS3I62RfHv1r92wJHHoDkHBesbqqjHCPcfIoOFWyhh2uqjsfvr
         Gd0A==
X-Gm-Message-State: AOJu0YxI9zenUokFwDMPd85uPFI+H8+oAvdzU6ZfOZHOzdXVC5t8m3RH
	zSz0I98+J5lMNyxsvMnU3LKMUQhVqzmlXmNeH9AX4C/KBvzpOzw2m8mVOwpwUQoYDTi3888PbWr
	3Uvo=
X-Google-Smtp-Source: AGHT+IHKpgciWfCvEAamdzdwajcc2hXa7KoBn4n7ri7RlokQfnb2pX5w07mQatp9dtfTTalDBHUUwA==
X-Received: by 2002:a05:6a21:3a84:b0:19c:a632:e176 with SMTP id zv4-20020a056a213a8400b0019ca632e176mr175496pzb.11.1707411379410;
        Thu, 08 Feb 2024 08:56:19 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090a6e4900b002926be9cebcsm1779604pjm.51.2024.02.08.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:56:19 -0800 (PST)
Date: Thu, 8 Feb 2024 08:56:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ipaddrlabel: Fix descriptor leak in flush_addrlabel()
Message-ID: <20240208085617.1fc58a59@hermes.local>
In-Reply-To: <20240207202542.9872-1-maks.mishinFZ@gmail.com>
References: <20240207202542.9872-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 23:25:42 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Added closure of descriptor `rth2.fd` created by rtnl_open() when
> returning from function.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/ipaddrlabel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
> index b045827a..3857fcf5 100644
> --- a/ip/ipaddrlabel.c
> +++ b/ip/ipaddrlabel.c
> @@ -201,8 +201,10 @@ static int flush_addrlabel(struct nlmsghdr *n, void *arg)
>  		n->nlmsg_type = RTM_DELADDRLABEL;
>  		n->nlmsg_flags = NLM_F_REQUEST;
>  
> -		if (rtnl_open(&rth2, 0) < 0)
> +		if (rtnl_open(&rth2, 0) < 0) {
> +			rtnl_close(&rth2);
>  			return -1;
> +		}
>  
>  		if (rtnl_talk(&rth2, n, NULL) < 0)
>  			return -2;


This doesn't make sense, the error path in rtnl_open cleans up
itself. Do you have a reproducer or is this just some static analyzer?

