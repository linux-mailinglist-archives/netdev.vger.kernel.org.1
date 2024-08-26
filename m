Return-Path: <netdev+bounces-121834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B930B95EF98
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5741F22106
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AD1527B4;
	Mon, 26 Aug 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BoEO6PKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBFEAEB
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671036; cv=none; b=t6wIXqLDXfte49izsBZc2yvHNu1MfMo6AivepbwVl65rT0hBVSeaPg8nxSDMUABC8mNOuOlcXAwgKGzLbjt/q4xnZspTYMqn7kw1lRtII25+ZKnv2hTvsNln++P9P0efG+h5Qb3u/oE5W7w4z4tUxLRao0GoOT/mRj+FxSvysYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671036; c=relaxed/simple;
	bh=aTkCnUcaak8drKj6XFZjbaBjymrfYSRj02UB4ucupYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3r1rdIGflgzJUtiycZsKCrfboHbRo9dC6DTgyuub3pq9yiRGfgzEntfLuHckfc6FjI6mXyPrGSAhSsaFSF08/9CjeiQXOsza9bbSkZym4mEv4zsctQgsohQj5J/H0iY22I9uyYQk+69OzS9MR13d7bGH4VFw2lHO2s5e8O3/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BoEO6PKW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso37466665e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724671031; x=1725275831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BeeKjSeu/IotUBDN38yV/e9Uvcg1qhe4n/stuPS3x48=;
        b=BoEO6PKWTm0MAKcwk1yDSrQvnxsB20kGmOcd8DYY/iGUlURN8lil6hunkO2iWK1SDS
         4Bi17oaTAlhfY4IklH8L6cm8fFScSo3nHxclOBgiVHKoykRdfTPHORGzBAotGc5X+n1T
         OvnV/2WHzLuzcequAM3S49ZF7IVU4V+oScyyB7wJ89IVY6NjT/3kXmNQz+3NpGEhWNIy
         H24oWD7KB2iFnibbEboLrpJXbU6tq1NSyn44WRlAExRO+6fdSQBDyF76etlvER8hOfAz
         PeWVV1u3gtU8mmJ6x4tWrHSG/l0ntFs3+xlOnP8wTiiri44KnjnPx5jy60oG1p8sqa65
         1uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724671031; x=1725275831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeeKjSeu/IotUBDN38yV/e9Uvcg1qhe4n/stuPS3x48=;
        b=E7nh9jb+O9w3dBfeRbgJ8d0Nxo2ANZWLwuiUVuFMixZgZ/8VIT2bz6t5WFrESdAufx
         fkCputnfpRcqCM0XyzI73AhT0vbglHz8HND4GvwmT25KxLPM+qFdQvjuOZWIAhh3BMG1
         UjTtTLg7k/kmP23EMjLKTg3gQTquTcnKLudA2EhCW0t1jXqq7sZKoDeuiOXOoqjpFKHs
         jHWzk+XCSxFYFyyNGeESBTq8uHXJoHAySvSgZxkHiSYCKsFwyOPJhJZpyt25znQQTFMt
         pWAh3fWqf4DcY95uxrFqza8y/fS4hy/6JyQG4inTHS7kg1cFmsL+dJKVaBQ8McJZdsqk
         UC/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/jTLGwZWf6LmYb6PnQOgMhQn5x5C3jegQjSUPMYn9pWkkY3fjOJbrvNttV+UQ6YMXQWd+R1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJokLnNTi1vWZgWXUlag2dpoV93yC638jGHzyHshgqJbxPZ3PZ
	GR1cKaNsKTe51cJN6LzaMw1Kj2IYh0ZlXg5GE0ywpEAGZmoWotj7KFn6y2lkpbA=
X-Google-Smtp-Source: AGHT+IH3LF5TgW/96b8uQrBttjNQY1xzoK+kqZn39Elvs0wiG1Pqxhyat+LJxE5XRzi93o0N3TNueA==
X-Received: by 2002:a05:600c:3546:b0:426:6822:861 with SMTP id 5b1f17b1804b1-42acc9fddf0mr55152175e9.36.1724671031029;
        Mon, 26 Aug 2024 04:17:11 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308265518sm10430049f8f.108.2024.08.26.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:17:10 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:17:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support
 SRIOV_LAG
Message-ID: <ZsxkNTbTHYSEEA7D@nanopsycho.orion>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
 <ZsxNv6jN5hld7jYl@nanopsycho.orion>
 <20240826121710.7fcd856e@samweis>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826121710.7fcd856e@samweis>

Mon, Aug 26, 2024 at 12:17:10PM CEST, tbogendoerfer@suse.de wrote:
>On Mon, 26 Aug 2024 11:41:19 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote:
>> >For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>> >allocated. So before accessing pf->lag a NULL pointer check is needed.
>> >
>> >Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>  
>> 
>> You need to add a "fixes" tag blaming the commit that introduced the
>> bug.
>
>of course...
>
>Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on
>bonded interface")
>
>Should I resend the patch ?

Yes.

>
>Thomas.
>
>-- 
>SUSE Software Solutions Germany GmbH
>HRB 36809 (AG Nürnberg)
>Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich

