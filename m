Return-Path: <netdev+bounces-245749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D647CD6E5E
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 19:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1AD302A951
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354428751D;
	Mon, 22 Dec 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="E+QKCXdv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102913635E
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428339; cv=none; b=rc7Ln0znDCbUwYrRBzHO8T+VWFFKEE39UxEk9Ui2aH7zxVIiA0mKzFWgwfu3cJoNbnlxniwBnEMzH5skA9iXNrOazB7Rv6ZxcrzBOxxEc0gP8B6c53oWRfUVlAm52tE2QARNPiA+2+PERWWKnjz9F0lG+0isx998/JFpTwKA5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428339; c=relaxed/simple;
	bh=n3ea/aH2BHpTlM1CeqgY3mZukIew1SUR2MWc6fVgMwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOjsg1JUAtoVd3KW1DlNv95rRIs/UnSlm9YHTwdGfDqA36awI7cfFL6Ettkfz0OgRRNP3D/dNMyhSW92BBanA3eOX/TbG/CwUAt+6V4DQ/HQhjABuOY5+ySValNuJc3ZbIvAoTMvA7ptgwSsBD6XOWafvKdZLdTIb6WJAblv3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=E+QKCXdv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso36127505e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766428335; x=1767033135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+yb6h0ECI3KX22nI1fSNyqaGpSlCBOwjfFLZeBjxoM=;
        b=E+QKCXdv1t+6FXhDsuSQ7Kdj4/vXi7p9IxX1Z/E8uAB3seqCS9VQUtdTqxI7J6jYLf
         N57RhlWhbsEldXhxkB4Wmxx79IP/fiTMj435AvQPT6/i8Hf63Y6NXzx4aamoOljwPY55
         281NJ9JeVIZZdoCWOO/fqFnMfcHAnb0Br2z3mYFd9+B1w4vSGuoEwmzlIy3j+vBCa8u3
         tv3cTtPL2/diBNT0RUF4tFAt4oCWvdOVnxBcmonsa/9PIAjsCQlGXiZWGas/dtmNOJ1R
         uVGUGbYLTVgm1E33GsHSPE/PwY1kveTB88xoPdlFrR77HRIn+AJqbOczj7U750JYGc2w
         TiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766428335; x=1767033135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+yb6h0ECI3KX22nI1fSNyqaGpSlCBOwjfFLZeBjxoM=;
        b=igxb6WIX3lmulV6FUutuXnWuJw9cNRtV7YbXhJB3b/7XNxOTo31cVA9NfafLDfOTGD
         AmLkxC68fwYTMp2s96s6Crvfr4dYbLgj2SFJJEA2NDFzVgmAK0HQ453Xx/7DOlVZb6LB
         lapGsXQUcDZu6CBSowEEVG5spfWTBwhIvK//tVwYhdlRBXMkOFcOoI7v8A8CwMD3UtP5
         um5SbQW7b2DpWZG3XkYIbJC2zo4eexyt485uZbj8gn25GC70Wf0/fQs1JT0xtDaLNv4A
         karFAtjAZ0eHOid73l5A6PWTwdz49sLZoStJCO4OpHqnvTI4J1amZYUfZVvpzBCTMgg1
         WjBw==
X-Gm-Message-State: AOJu0Ywpth6uYfhr3b9N+V8cdLzvcDSLBhdk0YTYGjAi+iMAjoNdvJxT
	ue/JMHivBXuxBfgx4gDkfKv5ZWrCETtX0YvGyy8lKK+S4MY2IGzF/ORf4MEQfbIniAk=
X-Gm-Gg: AY/fxX4vzl+rLg2GhNfcWThtp2oZCzRAzu37dLC+Urxni1SATA7s4A5aT72YNQ1FNIl
	NbSV2WvbgezfUTFmKCBTIUVsHTB47RS/FZ2FxJyEWweKXvvqYsg6f+PKWRMNgovRnoaWull0moW
	khlo+49DTOJVJrCh2Wdugq/rqtcJ71F0AxjnPyl66gmI458a1Edm5zWNikAFQCxKXs24+h1bZ2v
	nlXod4Wq0lDInFHCXqJn1A0XEepTPBbpNQ7PUigK43XwKh7/BbDcye98Lf46IJ4He4feZ0PsXAv
	ory4sp3mDyAEMX3C6DoL7Ob26cbHcNW/bCuXfrbXSGoCduC/gVjCTlRVC0sUmVayXWBpWdjIqLT
	5kbF1lI2ZvdV3iSm0GE6fy0qOROrjAihgl6chlBvt1ut/4XxTBlqxB4WbBjH3zZsCV/fik0yGVY
	EYe49+YRTegYWl/pNn+59wBBUlb4AnlpLiKuZqTH8AyWQZPkJmg1BG
X-Google-Smtp-Source: AGHT+IFhJmt1mK6QhL1e1lj3QjqCYLXY33vBfcj+daLhtmnyhfmDwUsTWUl2RkKIKKB9lvYT3BNtSA==
X-Received: by 2002:a05:600c:4fc6:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-47d1955b35fmr111300875e9.8.1766428334856;
        Mon, 22 Dec 2025 10:32:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a203d4sm99188405e9.1.2025.12.22.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 10:32:14 -0800 (PST)
Date: Mon, 22 Dec 2025 10:32:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Masatake YAMATO <yamato@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] man: explain the naming convention of
 files under .d dir
Message-ID: <20251222103209.0f9e03bd@phoenix.local>
In-Reply-To: <20251217154354.2410098-1-yamato@redhat.com>
References: <20251217154354.2410098-1-yamato@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 00:43:53 +0900
Masatake YAMATO <yamato@redhat.com> wrote:

> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  man/man8/ip-address.8.in | 7 +++++++
>  man/man8/ip-link.8.in    | 7 +++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
> index 79942c1a..e88a114f 100644
> --- a/man/man8/ip-address.8.in
> +++ b/man/man8/ip-address.8.in
> @@ -331,6 +331,13 @@ values have a fixed interpretation. Namely:
>  The rest of the values are not reserved and the administrator is free
>  to assign (or not to assign) protocol tags.
>  
> +When scanning
> +.BR rt_addrprotos.d
> +directory, only files ending
> +.BR .conf
> +are considered.
> +Files beginning with a dot are ignored.
> +
>  .SS ip address delete - delete protocol address
>  .B Arguments:
>  coincide with the arguments of
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index ef45fe08..67f9e2f0 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -2315,8 +2315,11 @@ down on the switch port.
>  .BR "protodown_reason PREASON on " or " off"
>  set
>  .B PROTODOWN
> -reasons on the device. protodown reason bit names can be enumerated under
> -/etc/iproute2/protodown_reasons.d/. possible reasons bits 0-31
> +reasons on the device. protodown reason bit names can be enumerated in the
> +.BR *.conf
> +files under
> +.BR @SYSCONF_USR_DIR@/protodown_reasons.d " or " @SYSCONF_ETC_DIR@/protodown_reasons.d "."
> +possible reasons bits 0-31
>  
>  .TP
>  .BR "dynamic on " or " dynamic off"


The man page is slightly redundant here. Already have a README file in the
directory.

