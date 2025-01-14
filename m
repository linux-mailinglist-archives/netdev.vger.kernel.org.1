Return-Path: <netdev+bounces-158284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E5EA11506
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F16E1888BA9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9F2135C8;
	Tue, 14 Jan 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FcFMrv8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6C2066EA
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896171; cv=none; b=Fdm66PcnZ0jvJ6opZlU8B00+cJc94nxCzM+k3MqYbPMAXX0o27AFGShI1sx5iiXLMyrRe+T+aqx0BEsABTWm0iVJnDleRB7pjRqIz7lhdnrGB8omFg2E+P9jp/+LEdVWH+ql4PNBHpoZt/ztuIEWf4cQdwVObO0JlCDLoGFytKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896171; c=relaxed/simple;
	bh=5r778+Eqbpkugs/jmY9OcAPSZxGIj28h8YH70Orgnv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o294MRDKft+3D7HK/OF/kngM12x0TQseN5O1q4rQ1laERXg/nmIsBg/4nsRHpnGonEzGXBKhaalG2p3blOBplfFVT1hUn5UlOHSfKV0zrPuQkwahI0Gbfj8LvY+mIeJEiaIsvySJgSBZRvt2x6Is+G29nIgTmj14rqRCwaGaSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FcFMrv8A; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso8017065a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736896168; x=1737500968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qS1HHztozUdhQUU4FeDcF4zx37L6QfhQ//heONxSiIs=;
        b=FcFMrv8AZezMGkTqTYFWbVw0nUdlSeH99zztlWFF+gVyJIC7GCwYJLTb5QGdSx6oj1
         8dnndTbVlfgsfog8pa4S/G/hdWfjo9S7AyzIZxTEzpoRqj553CyZXOBNaueEcne5+u5D
         jOOha63h0QcNSnaCmjAaJPloSMPKc7IyXcC04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896168; x=1737500968;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS1HHztozUdhQUU4FeDcF4zx37L6QfhQ//heONxSiIs=;
        b=olzaZ5+jGUV+4yN/DnbjYnLh+lPb2QJETmQIR3zacH3jiu63BCyEwl0bp+PJJ3gMBS
         NcOWHmu4mA/ow+JU28PjzMfsWOnVLEXGssEp41V9sVpnr4BRkt4Y37gBawaAF0SY6QM/
         vKSjGdMk1GQzoQI6JB99zt2hABFRXRNNEDPEemHWhby8du8vz2JoQIVChfqoQEe+O40+
         2w3CFT1y79dWk3BqzCkGpcuil4nJDrSKcujRg3ECU0S9Gs3Wbx9u23Ezbo5fiHGThLxk
         AU3tjpVApVpYVYYaLC7y/z9XdSswIe2XeZfLdCprgYjOepwi49qtc/AK2VhLxXO6EvGl
         CTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJm7y7yi7dWefmsuajBjpn4C0r6PYhxkY91zepk4DRlYvC7d5Ku0oJTapcaeTuFSztBqCsc5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQXObp/T2mosdgVXy3k/OZXURBO9xiEFDt17QA+EeeX36CVh4
	RIgxmKSlQpPtwahZF8Dr+rBXghzbNxtVz4EdiOLc6hHpXPBsTCoX/FOXK2CIzNA=
X-Gm-Gg: ASbGnctNVYZ6+/rTt19K4ItaeA9oPNgZ4VFeleFs68+eYA0q8OMQMigg8KSrxkSHH8l
	c6pIFAJOHDSFBzh1BDXhdZ0Sb2Xu8IcwrnmIF5LFp5G3plifyLWSQabu4LzmpJ7V/6pR4QzXpXP
	Al28NRZJVDfIat8rwmQsiZPo7/dW5Wvyj2brU1h3l4nUBPkq3GurVy5uqOfTHGumr94wWkVJg50
	sPB9qP2Jw587wbtrhe1lQdVbdZr12hvcbOWL3zeNtzemiMw/APXIDISc2C8Z810RKCiKeLOYgus
	bkMRITNB7MJl5HNmmZrEHpU=
X-Google-Smtp-Source: AGHT+IGbaRVsWaJDIsIQBKiq0ApbVm0UcSI10liw/K/xu/BFYQp6aGnPQVHzr1hGIUNBGrK25MYkXQ==
X-Received: by 2002:a17:90b:2c83:b0:2ee:f80c:687c with SMTP id 98e67ed59e1d1-2f5490e80c9mr34836669a91.31.1736896167740;
        Tue, 14 Jan 2025 15:09:27 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c151f4csm83832a91.5.2025.01.14.15.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:09:27 -0800 (PST)
Date: Tue, 14 Jan 2025 15:09:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 04/11] net: add netdev->up protected by
 netdev_lock()
Message-ID: <Z4bupHBw-KgnnKWe@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-5-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:10PM -0800, Jakub Kicinski wrote:
> Some uAPI (netdev netlink) hide net_device's sub-objects while
> the interface is down to ensure uniform behavior across drivers.
> To remove the rtnl_lock dependency from those uAPIs we need a way
> to safely tell if the device is down or up.
> 
> Add an indication of whether device is open or closed, protected
> by netdev->lock. The semantics are the same as IFF_UP, but taking
> netdev_lock around every write to ->flags would be a lot of code
> churn.
> 
> We don't want to blanket the entire open / close path by netdev_lock,
> because it will prevent us from applying it to specific structures -
> core helpers won't be able to take that lock from any function
> called by the drivers on open/close paths.
> 
> So the state of the flag is "pessimistic", as in it may report false
> negatives, but never false positives.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h | 13 ++++++++++++-
>  net/core/dev.h            | 12 ++++++++++++
>  net/core/dev.c            |  4 ++--
>  3 files changed, 26 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

