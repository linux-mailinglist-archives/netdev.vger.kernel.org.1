Return-Path: <netdev+bounces-145472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C09CF972
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A382928B46F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B881205AAB;
	Fri, 15 Nov 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ/UHhn8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FB1FF05F;
	Fri, 15 Nov 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707808; cv=none; b=hFO8elFxtfb0BznD2KtEi4AzQwFjm29wmm3raXbr+TnBXMeJuwgTciJt0olpM1PFe3eEzZtwE1b31mB3NR+CReqq/OierQUie1HsiUM0tSwKxpzv5sA7U7CcB+LAyf7yAdkA9eRWQ7T/I/ycpyBJ3LVsqku/ZstzBKABD7jHVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707808; c=relaxed/simple;
	bh=iSrtuGfD8+6y6lUul1BEFqInZFvwnsbOf5T6q7Pxasc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLdflzBF8Oe4coNQuSRnCykRydNw4iw4gnmtTj3bq+eSsP3YA1xAr7qKrh4VrO1a42PG3um0H8GLOaYPq2u+BzglKnIMyQxE+djVhc/IIM4P9QifXah6YzpSmijtuJXR1a/lo/DJJDOyODN8nFXUDoSXd8LcNtplOFyuH/aillI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ/UHhn8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso24693915ad.1;
        Fri, 15 Nov 2024 13:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707806; x=1732312606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD7swxsxq//JXgkM0jti6xAcqmP3MFJXhkgEJSTm1Bo=;
        b=OQ/UHhn8xdKOiM/BLwz8PlEqYfDUrmuAYR5KJQp2hueenA1s7y4fpEKPsyzyp7tpUi
         c4peQRkVdhIhVCx1RaRUjChD8WwBf/K4ucuQw8P2Bbsto+yJog4Lm0z1YDPlWQwSKl6U
         V+t5NEvk/ppODCBeaUWFCI+u2qJcXMNZhd31T39ANAY77MsOrve0md/M1ix9e0ilyJSG
         bStf9bm6MBDfwRBRW5UXsk+xparUszBoOrK29byIUS9YbWi0CQstLlnIdQwH9bzbFisR
         aCNZAhF5RYls77bDn4AVm0v6MsGgV1Nh7OIB6Uk1Jf2VRc/25wosXUwqXLLWJ27RkMU5
         OQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707806; x=1732312606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD7swxsxq//JXgkM0jti6xAcqmP3MFJXhkgEJSTm1Bo=;
        b=nMEhyUjR2CeY7X3HapoKPFm1H1zRkroIOLF33bHofRqa7cIsz6FCHb+pDRPK//Ptej
         uGmJzGV+6ZDreF0Z3X8JHraS4TC9GLci6FHMk4aBOUzF4T53N7tB5sjyzyTQk2XVEb/W
         J2DNuY8hH+Cs9cbMJqpVS24p829VsAYNrCFokyJpPvSmC6oWOIVYnbXpLALbpncQC8Od
         +KnFPQh7+iyRx78/BXKUyn5vRPwYtGztiJctOsVtWdLKLjnWbhEgaZIBtAamcix2FWCc
         BHsDYnP72+ExWoBwhN4uRYeysQgg7vktzoBrhj5Tn+cT7Bg7Ft2EwsEIm6COxsFk5dQf
         c3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1YWl38Ze7UcksbkghFHt54MNya4gVkG7Xwtb1ljDJJkhITfkQ9bRhfUq6pqi90QHWm8hJSu/p48=@vger.kernel.org, AJvYcCV4wHbW9OMhHpalHm9uO83q45CnIb4DECpKz/4FsjFYPXRD1WC6e0WH+NGleOn5GP4RWGLJH9XCbQFUj32I@vger.kernel.org, AJvYcCXtW7Xq8gyfk7ZP2133lx+rTJkRsD60huy0vkdIzV5Ycgs/gmz3ACWD67Be4jrSym5E/BX+fpNJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaRnPkHkUF8tjRTwiBl/2E75gKnDK3S+lS9GCZ1J64zZu80XL
	IgAAzt8oqTQQMR1Quzcq5Zcc5BnKl8sbpI3d4bxPSe8SBYie3Xc=
X-Google-Smtp-Source: AGHT+IGvtdVIJCxAmPdWtkuYTYN0xy+75yCQlHM/o2TwTwn3RYsf6LHli8ju8J7rJy3xeuR2w+6o7Q==
X-Received: by 2002:a17:902:ec92:b0:20e:57c8:6aae with SMTP id d9443c01a7336-211d0d62503mr54437215ad.3.1731707805911;
        Fri, 15 Nov 2024 13:56:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7dadsm17070515ad.71.2024.11.15.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:56:45 -0800 (PST)
Date: Fri, 15 Nov 2024 13:56:44 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 8/8] ethtool: regenerate uapi header from the
 spec
Message-ID: <ZzfDnLG_U85X_pOd@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
 <20241115193646.1340825-9-sdf@fomichev.me>
 <20241115132838.1d13557c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115132838.1d13557c@kernel.org>

On 11/15, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 11:36:46 -0800 Stanislav Fomichev wrote:
> > +/**
> > + * enum ethtool_header_flags
> > + * @ETHTOOL_FLAG_COMPACT_BITSETS: use compact bitsets in reply
> > + * @ETHTOOL_FLAG_OMIT_REPLY: provide optional reply for SET or ACT requests
> > + * @ETHTOOL_FLAG_STATS: request statistics, if supported by the driver
> > + */
> 
> Looks like we need a doc on the enum itself here:
> 
> include/uapi/linux/ethtool_netlink_generated.h:23: warning: missing initial short description on line:
>  * enum ethtool_header_flags

"Assorted ethtool flags" as placeholder? Any better ideas? These don't seem
to have a good common purpose :-(

