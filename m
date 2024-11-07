Return-Path: <netdev+bounces-142594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA99BFB4F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F571F217C2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DC79F6;
	Thu,  7 Nov 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUP9H8Sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1BBA50
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942500; cv=none; b=K48VOCxLvyowJdH16sR7eJpsq4hNoRodpO2mnfHvCCJjhyVi8Lq/omyl2Dd/k1lICAJWaxKR96HjWcGjQYIFSnCA4aGChFVrmejmlkMAHXTQ+RAUsGDlFMyomnffACqA5Izrt2x3wxl9Ylv+Mgv+viT0t6xthNqtH/P8WliN1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942500; c=relaxed/simple;
	bh=yhL+XbhV8z/anGZ/ILaIQ1RH/6eqzwqJIbPsB9bOfGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkj15D8scTTsRsxgoJguInXbl4BYm+RhaJxtLHuATOjy3OtGtnUOMibZu5fmyQxv+mexzzFzzUBGnK/tEMTB56W3hGTNihBv9FTX7ZhmBQqgrdiwAs0Nx/h64k7bZXvS2t2O6oW9JbWB47QlUJjoDttf7LBrfC0xzctvalrYLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUP9H8Sc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21116b187c4so3967615ad.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730942498; x=1731547298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/5fQOwCfjUl/6NLpy16uy0wQR4yre6efD2vHzC+Bb4=;
        b=iUP9H8Scj9W/T3hTmtz/UXhuim+hBjtVpxMkOX9w2EgfWa2yXQLiB0J4Ch5u7080eX
         4acyQ3+0aDVXkzKxd47VlmyQitnRueZg07uCirc7cXf6BP3f2AAjUOpnB9RObkoxHgxu
         DSJUmTan4P3gO/LIlFEUn29RjcMALEPM4m3vrkoORw8LMHohOQ/mKIKxqgAfmyMN4CxU
         MZ9XL+UHw7x8ucB9oHgpymh1//7+aEFGDdfy7EkH5eEod+clRlj0WyoUexdT2kdH3itw
         pC8zAGTeL7ZwyFvBUy2qntSHTtWryTWZcBMghUFVNp7Yr8X0oNd/0CFe7ZNcWa2ed1D2
         BDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730942498; x=1731547298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/5fQOwCfjUl/6NLpy16uy0wQR4yre6efD2vHzC+Bb4=;
        b=p501H3YbLoIUmPXKA2vM5KaHQgdYtmOkefoYDQPYHkE6jtG2DtzGL0dOTt838dTVZy
         CusfOezN0OEuEjljA/mJPxPbBmOLwjF7TP5Embl0dsbRHBgeoyQnE1agSS8WMcjysZr9
         5OXSkpzlo1aHomlIeUi/fnPQ934eMpbbZaRFDA8BbD4UbzELidBpptTnGHvfBc7v5vSc
         LqKoxwdXG7n32n8rRIYf4xj4+mF4XL/kFsnHkP79oCQ6gvXE9PoIs2+CL0m+e2qAeXPx
         T80nGne3z+agmfC+NniNOttX+1mrh6yszHxypwLpO5l7IrLgOv3hCaOCyr0GPgoVYbiu
         wQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsXhXNyy8l0HfjmdYrLoK+0mJkIFxZ8Dg/GSMT4fJXCNlo5YpUM7AgAru71fsQwwQyigGjuAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9SdZZS8lSCpsypi3acC22/2e8H3hEPhcWNXsowmms5LqMcfS
	yZ4IFvfU8qk96+i98Zg7Msg+WXpFolBGStEkzZS0kYy7zm3+o7nv0AXzjY+8KKw=
X-Google-Smtp-Source: AGHT+IEc47rR9iEreSIHHqDnw63JdGk7ZgHpvNZhEKbQjmduCmZ0bjdBWeom3RP52VFPlYh1dbO42w==
X-Received: by 2002:a17:90b:33cf:b0:2e0:f896:9d6d with SMTP id 98e67ed59e1d1-2e94c2b6c6cmr30734603a91.16.1730942497878;
        Wed, 06 Nov 2024 17:21:37 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541d16sm2226377a91.16.2024.11.06.17.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 17:21:37 -0800 (PST)
Date: Thu, 7 Nov 2024 01:21:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <ZywWG1Dov8jX7pSM@fedora>
References: <ZysdRHul2pWy44Rh@fedora>
 <ZysqM_T8f5qDetmk@nanopsycho.orion>
 <Zys2Clf0NGeVGl3D@fedora>
 <Zyt_58BFKnZvtsHx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyt_58BFKnZvtsHx@nanopsycho.orion>

On Wed, Nov 06, 2024 at 03:40:39PM +0100, Jiri Pirko wrote:
> >I think they just want to make sure there is a backup for the link.
> 
> Why don't they use LACP? You can have backup there as well.

Some users don't want to configure switches. Specifically, some large-scale
users don't want or don't allow to maintain the same number of switches.

Hangbin

