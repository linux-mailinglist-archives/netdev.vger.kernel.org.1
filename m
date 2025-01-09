Return-Path: <netdev+bounces-156504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6B7A06ABD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A827A36D4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976C22339;
	Thu,  9 Jan 2025 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsbioz+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C1B677
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388586; cv=none; b=uaJk63AS/yWdAjxJ/HxAhcT/Qq2lGwT7/kNBOKPcIHFXqHqvFHdXh7UaocSKw5optC36QKmMCeAS0xpij7FtZEiaj9sq+C8Azk9e8uLPKsz3KHgMZn3aSRpjJzSh3RlKgq3EQpqTvEb0YAYmb6ZjJf/saIhj8QPwfU+CpFvPVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388586; c=relaxed/simple;
	bh=RQCroYWa2RIpndvniBhc+nEzW+xgirSrvaBgEUnjeIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB7JH8xuT2YN10o3VvUgWPXnQY7RcrN7MM6lkzGBNYyO5Y1UEJT2piIqzbdzJkfgMcjROo1Txz/iHnii0HQsmXPDt/q+W5JWpUlQ2Tb3xKBheOWvsBrJ/1kQLVoRXmsjajc/TIoAnvpxa56g9kftAPmspUsDygn9Wep5no7acKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsbioz+c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216634dd574so3986455ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 18:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736388584; x=1736993384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBu9zwaldD0I2kKZNy8ryR+6MM6s4k4SCSM5cCy+M6E=;
        b=Xsbioz+crIRwtY0jcBncVhgmKBupQUs5S/FcCuDW5Cq84Cf5MiH0o6Z2080a+4sMp0
         Jj9mIH/GOf+Tm+dS471zaXO+3+x8z970vFIB8Uk9pAMMvuB4jeO50UCk4twcy6jnAw6T
         a/eUzkZUhzVuepfaP0wOyVDt8+5ZYdBs88kuPkdsgmZBQ6Vlg0woE7owUVZSCIkBjCE+
         bCUiK0+1WDoNidqlDX60IFd79ihEwdf/+djVa6H/1bo9RnDdLIHXLDnB+5Voyke3xAjB
         vGP6nlwHwaQsnAey5uTzNSmUusjifDdmOBjRAgsyTHUgjDIaL22c9Jhnpw9laM0uAROK
         2xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736388584; x=1736993384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBu9zwaldD0I2kKZNy8ryR+6MM6s4k4SCSM5cCy+M6E=;
        b=e5z3EFBIzIOxmRBFNug/n6wB+9VVBxU7hSIyWCGKaqJxmE6ONwEmKXcjomQdeuROwp
         Mn3Agg+5BQpEdoALWhPgRsAIQ+UKmjRVNRQviJKUpqm20mVTTYD8FW+NXWuxxj21Z8BJ
         xOFU1x38LYSonAjSQLY8m+8lDrnXRd/0RHGbwHjoq4Y5ScsfFDv9S4nM4CvApCTHB04E
         OsdmugruNaUKyi4uJ6LTlDGSW2x0p0xpUwpxyzHLA/ZJaGI6EvS7WBoE/l/S38HSWKJl
         oAYRXX/NJ1wRPCIvmtMgGD+VnIoNDMp1JNJ2vSdXSAIQadOnMDNEP2m5mMnKuI9wGdrL
         bCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKUpY4nGEUN5TVUAFTTGwGjgsL1/tBg3NA47QGPerskh4RHACFOpF1UiI9MZmcr+EHuan6AIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCla7b1d6vIsIi6R3VvI+9/5/HIWgtoowgrZlhfD38N94Up6o
	SubhEDg8BdsYEfT14o+jOWlNKrO3aFT5sd9Fhnjob8Gkdd344eY=
X-Gm-Gg: ASbGncsSVHb2ALME592a7+iBZCKArJwFs2aBpf4vXguNY684WPQFjfS8e0kmoPie39i
	cdScTGW92Apmaj4GwCYCLtHCRBgi12cOVJyp6TnrKHuOHZ8O6DMuChYL0aBO2k+d0iLXRchyXTy
	09nuMYYo0UzGAP2e7JGBpxnT3ZpIsRsOHMKvagLV1xkZjHK6b4h87cBr+XLcRmyR0MX17W/uE4x
	ia2NaXG/qAHk1B4deIlzOq3nv/G1JazuI4uLjCFPbwOm3uXeUYfxT+J
X-Google-Smtp-Source: AGHT+IEUyoUqgQWSGqsv0aI6hwpUUSgqsIuDj4bEJx3+tyIW1cUBboz1Q2rzstn2FFmJkGioqG4aJg==
X-Received: by 2002:a17:902:e74a:b0:216:2e6d:baac with SMTP id d9443c01a7336-21a83f649e0mr79552065ad.29.1736388584398;
        Wed, 08 Jan 2025 18:09:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca014b0sm334917685ad.233.2025.01.08.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:09:43 -0800 (PST)
Date: Wed, 8 Jan 2025 18:09:43 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, donald.hunter@gmail.com, nicolas.dichtel@6wind.com,
	sdf@fomichev.me
Subject: Re: [PATCH net-next] tools: ynl-gen-c: improve support for empty
 nests
Message-ID: <Z38v56eT7P57n3V4@mini-arch>
References: <20250108200758.2693155-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108200758.2693155-1-kuba@kernel.org>

On 01/08, Jakub Kicinski wrote:
> Empty nests are the same size as a flag at the netlink level
> (just a 4 byte nlattr without a payload). They are sometimes
> useful in case we want to only communicate a presence of
> something but may want to add more details later.
> This may be the case in the upcoming io_uring ZC patches,
> for example.
> 
> Improve handling of nested empty structs. We already support
> empty structs since a lot of netlink replies are empty, but
> for nested ones we need minor tweaks to avoid pointless empty
> lines and unused variables.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Looks sensible. Assuming the context is:
https://lore.kernel.org/netdev/20250108220644.3528845-1-dw@davidwei.uk/T/#Z2e.:..:20250108220644.3528845-8-dw::40davidwei.uk:1Documentation:netlink:specs:netdev.yaml

