Return-Path: <netdev+bounces-170760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C469A49D43
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1DF1892519
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AD1C07F5;
	Fri, 28 Feb 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e53WS13A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE631EF39D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756082; cv=none; b=FDhN4tAjanqo+HIzyd2JW7WjrwZgEZqKMFyhyGk7/29InJE331lx7Qu/Ubg0vxPmNZnXgEXrfGPdQhsqfTwk47RmqZY4+23ITboBm24/VHK64vxyMRmuAK4ivStHhdolgDYARQ3rru4nov2cY1gmdgvOErjwPqXk+EbyhgiksTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756082; c=relaxed/simple;
	bh=pkUS0dxq+XS8JXCS+489ptynr+MG+HEBtSx7FUDteI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv0j3NBlRuNRg4kVHSlad2vkwiVuX1SAgyS/IcxJUxHeQX+02zODxzMG1qeY1Z6DQOM5jQpXfhnw6QjjAqqxN4RMG0+lpUm6vzfY+GIbM48duHaJPLesDeFkmmN7TUxuANvUzxs8nWPdmeYZO1ZIigWR4HV2yRRWyV0cLScEdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e53WS13A; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so1342008a12.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740756077; x=1741360877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9EViRPYq2HVhKkgccmDazkTAr0IFND/cK6cxmuj1xE=;
        b=e53WS13AV5lRo8lu+9P0LtKIILyHiJFMdbASvziLEA1wJokydCiGLcv7t8E8vOZSyj
         m3KsYo+B38/kQJdI8jAmfDJaF26Cmg8Kg8G8mIHi9tC83Vr0kXwODILsJtX4HseI3Y4D
         iK3inF7WZMOLldLybOSvOIgtJSUAumCQ0gnAkWFN7v57q3RD04c1U675p3zxYoOeHHbv
         u4Su4EzWOHEOfBI+To5/Kt8Bk8C7pIKl+gZiRo1S1t3s8imlB1df/G0KzIOKfDv38cvO
         9EdDlWFt2zeYdYRbK5NGAB1yWmSuFtW7EbuyfmOKk61bbfDgUZFl4WrVH556xV733qTA
         ybPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756077; x=1741360877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9EViRPYq2HVhKkgccmDazkTAr0IFND/cK6cxmuj1xE=;
        b=pSfkNYCkgLji4iL9rA58jZ1vIZi2pDEU05D+nqsXJ7fHV89WmCukXYyIw78Fbg8lUV
         xF9n0cOzIAtYY9cnXyLNV2r7Q6iTDVRdGHixaFgH7Gc9aOqynhxyMZSopOTxa/EDvb8I
         l9MEY3IvXO+MmI9DDMK30YTWAl+j2WBtpeveZchUG697oeDfY7eoZzS5XAmL7KHI0Jm6
         inYzfAbxNOL01lUzk2wtwqLjKQvChYYBKm4/Fi70nl9LI1UWaIrLyRFnZRmk3u8nt5c7
         wcQaZXhdCUKk5KL3wK7KtJJsI1CAP5oFxg65Dgz6rt6Tz2tijSHBs7xqG6zMs7ALen/X
         FfRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4bTKfOLE6cJr2HCfSJ0eEcwADul4Z+zaAxzFXRz1SKoRtgL8Uto7/hxUa3onXG5RzWYhIY7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDOXR2HKpdLLFegzGTvsIw/LcM+y5Mc5nESLz77AkaeWBDpjE
	st7B+oMA4tLIe6hLxWit4N/rKrnCuiO4bQtohUl3DRJxTytIKfSTOkBG3D+ofh4=
X-Gm-Gg: ASbGncsQGKIevJz014FtQ4IzqwZoGo8ESN0xZaXnNihq5gOYQSVDkFVLr5MII35rgBV
	uGutFWx1iadszrX7L//pv20QrepecYKlNGyAZPbJtZaXKGZMgWPcBRRBeDb3w3x4qeR7SZwrK78
	J+R52ly3DPHW8DSfAKUIp3/AeC0VBwT0v8CixuwPRPzCV/LjjJQy/3/A9AdY7pYnrgutiIc39/Y
	CkKk3XKOJ6q/BmKPdTWGtb/UeKAqVwpO4JxIVRA+PtEhTX5YzYXdTR3MRPLWnYHYSWdvHatYZ1S
	IvHzVfuz8QE/TqrI+HEG4zJn/soGtSshhOyS8RMDHTj5yzkLXCpNbQ==
X-Google-Smtp-Source: AGHT+IGBaONpOzIw3FLhnvKJT/dsnQBmYcgeT7RHvhcWWGkv0unFqwBevh0jLh5bISZo0gqJ4Pmt8g==
X-Received: by 2002:a05:6402:254d:b0:5e0:8007:7497 with SMTP id 4fb4d7f45d1cf-5e4d6af1682mr3290629a12.17.1740756077050;
        Fri, 28 Feb 2025 07:21:17 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb4391sm2606956a12.52.2025.02.28.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:21:16 -0800 (PST)
Date: Fri, 28 Feb 2025 16:21:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 07/14] devlink: Implement port params
 registration
Message-ID: <aw3z3xgjlp3thulc5i3qcfqsr7lamm2u67yqdq6myomlvtkd5x@6vecjicqvib4>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-8-saeed@kernel.org>
 <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>
 <oqeog7ztpavz657mxmhwvyzbay5e5znc6uezu2doqocftzngn6@kht552qiryha>
 <d2fc9e7b-e580-4989-880f-9b47fb5b5b4e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2fc9e7b-e580-4989-880f-9b47fb5b5b4e@intel.com>

Fri, Feb 28, 2025 at 02:23:00PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/28/25 13:28, Jiri Pirko wrote:
>> Fri, Feb 28, 2025 at 12:58:38PM +0100, przemyslaw.kitszel@intel.com wrote:
>> > On 2/28/25 03:12, Saeed Mahameed wrote:
>> > > From: Saeed Mahameed <saeedm@nvidia.com>
>> > > 
>> > > Port params infrastructure is incomplete and needs a bit of plumbing to
>> > > support port params commands from netlink.
>> > > 
>> > > Introduce port params registration API, very similar to current devlink
>> > > params API, add the params xarray to devlink_port structure and
>> > > decouple devlink params registration routines from the devlink
>> > > structure.
>> > > 
>> > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> > > ---
>> > >    include/net/devlink.h |  14 ++++
>> > >    net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
>> > >    net/devlink/port.c    |   3 +
>> > >    3 files changed, 140 insertions(+), 27 deletions(-)
>> > For me devlink and devlink-port should be really the same, to the point
>> > that the only difference is `bool is_port` flag inside of the
>> > struct devlink. Then you could put special logic if really desired (to
>> > exclude something for port).
>> 
>> Why? Why other devlink objects shouldn't be the same as well. Then we
>> can have one union. Does not make sense to me. The only think dev and
>> port is sharing would be params. What else? Totally different beast.
>
>Instead of focusing on differences try to find similarities.
>
>health reporters per port and "toplevel",
>just by grepping:
>devlink_nl_sb_pool_fill()
>devlink_nl_sb_port_pool_fill(),

Sharedbuffer is separate story.

>
>devlink_region_create()
>devlink_port_region_create()

Okay, regions I missed.

>
>and there is no reason to assume that someone will not want to
>extend ports to have devlink resources or other thing

But looks at differences. They are huge.

But perhaps I'm missing the point. What you want to achieve? Just to
reduce API? That is always a tradeoff. I don't think the pros top the
cons here.



