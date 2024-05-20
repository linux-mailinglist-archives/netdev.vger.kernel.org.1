Return-Path: <netdev+bounces-97170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51D8C9B00
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B84FB212DE
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5A4D58A;
	Mon, 20 May 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gKIC9PEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F44C624
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199722; cv=none; b=mCHKAfHKgdplP11RjbRWlruc2sAhjS/s1sbCbbXJeWtDBV9Ow14jbDnBBSdTb5vCJUX2BypoXCqXjW4APo0/nD3wZXQRZ9vadZRE6Rx6QT1Y0NOYBHzVS9UHI+JCZXtS9LRNJIchjGs7tbEY+eltZdSybocuN9Sfdi8PA2s93Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199722; c=relaxed/simple;
	bh=YH+dlNTqQYr3J4wDFVlPpuyE21hsTOLsCLCyKuzkWr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZApJf74soPTFPjSjwbC4aHLOvqiTEHOwrKbJhS1VV+DkfRu6AJGUE8kFl570TpYBbsAY+hL0E1oKvE7iACTaL2h/swphIg8snmN9IqRygW4Xsw/Gfr1Q9qfnJtEL7gDvoG1J39qL/9R0WBljNa0Y+YyP04jEwGkbj8ZBTcHnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gKIC9PEk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so7870210a12.3
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716199717; x=1716804517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YH+dlNTqQYr3J4wDFVlPpuyE21hsTOLsCLCyKuzkWr4=;
        b=gKIC9PEkSbD5k6qEeAUBmTKapbMGaM8F9bBz2p4zh+TKxz1iZJOiEBPgZVgA57Qk6q
         yPaHBCL9Wd+05bFqiT5+tIG/5S6KLoTip8IXPK3GU8rvwveMuuETgLl4MZnM2/eJoWxu
         EwjkrpPHXEPYi2c9u5c8r2qUeubJ0oNGd+bDd6RBHURzJMTrhLiSie3i9HvjLATJdXuN
         COB+NQ5v7jqHqEUiXkwnIpACKYC78Z+gXRBYWXIDf38oUELjAt+1a+eGyWAmXLSNuzsZ
         37tN1SwOlm9otKslhP25kFupRMxqSOPCSCD53VbP6qwoUjxsmJEORye+9ToLHhE6yaom
         pEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716199717; x=1716804517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH+dlNTqQYr3J4wDFVlPpuyE21hsTOLsCLCyKuzkWr4=;
        b=snfQxoCWVH2t8wTDgOd6Ybi1E6iWaoiSIErUY/R4PHlSd1EY6TEzgHH55cxw1/PFob
         P7l0a3RtENCihAQF/T5BZYuLfMjFnd8zNUGOkJu2PFRA2pp61MTA0tWWNcEbzXeNmhB+
         87NxW7yR8IhVMlWejf1jde7WfeKilCxnIFh6PW3qbatat+sP+uhjiW9q/vA5gvwlhOLJ
         ZsOp+/PseMncUQd8+oYkzArw0zADzBOZO+jthwe5uhNZaOncj3nyYCroqVpqUlkCTCSO
         oxdqYbTaahKhdbOxiP8ptk+OmlBCP0e0SrobWFqB4pUlxB3trI5OWibNLYYJOmp0g3Zf
         km3w==
X-Gm-Message-State: AOJu0Yz5+fchOHrAb617W8jIqzJhy44opPIz6uB4XTtyG8Yho71gfQpa
	phnlvBGB7Xt1zCrKwWXlqNHKwe6N2L9o5peDwqnLVtpeLKn7SI6xVTWyEfu3n/4=
X-Google-Smtp-Source: AGHT+IFlElcrNnu2NkgaONWm5xMrcbsN0oXL0JLXpQsiYVN1MTheKcbL70Ar0XpSbekbs6ypVFBaRg==
X-Received: by 2002:a50:aa94:0:b0:56b:cecb:a4c8 with SMTP id 4fb4d7f45d1cf-5734d70603cmr30261278a12.39.1716199717224;
        Mon, 20 May 2024 03:08:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm5095355a12.61.2024.05.20.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:08:36 -0700 (PDT)
Date: Mon, 20 May 2024 12:08:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ismael Luceno <ismael@iodev.co.uk>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [iproute2 PATCH] Fix usage of poll.h header
Message-ID: <ZkshIGzdbLTR5dJq@nanopsycho.orion>
References: <20240518223946.22032-1-ismael@iodev.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518223946.22032-1-ismael@iodev.co.uk>

Sun, May 19, 2024 at 12:39:44AM CEST, ismael@iodev.co.uk wrote:
>Change the legacy <sys/poll.h> to <poll.h> (POSIX.1-2001).
>
>Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

