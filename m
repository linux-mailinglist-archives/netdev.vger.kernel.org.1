Return-Path: <netdev+bounces-124438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B014296988F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65934282A75
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC819F43F;
	Tue,  3 Sep 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EhhwXCW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A119F429
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355060; cv=none; b=MCoUx6ibBjWiSHNBgVPH8oppJb0W/TvbReg2vprZq/O76W7o+pZubCjxCPLi4K7ECHn/MZNbPXUuYgvqa91ZqEf+5aM4DHg0jPUu2oGvWO7Fw+m5doptoIpWCL0kXFJy6vmfkjdZQU6jLm0J2ZgCugUSuDsjViegF9+iheyfif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355060; c=relaxed/simple;
	bh=LkdS7OCCBAZXkA+UXUJ+Kq5JMyhgSe7KCq0sN5hnqKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQep8GUDjdQP9FRA69uVWD51/t4tGTxYq6IddDrCTR3xW6jyB5gWdrwvbGyIVCkrOf9PhDlkH18w3tpL50KCMi+Pm2qSHcH6O99Mchyb2QbLDPsC/scQbyCF2RtDJxetUde3SEjI7gwUVB974HlplCr+ToX2LjmHWpTddR3FQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EhhwXCW1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83562f9be9so467855166b.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725355056; x=1725959856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unYnDtIsElsDse+Va0cHUHNbjndhn2ZWY0Tb6Z5hUhk=;
        b=EhhwXCW16W8Mw97ajpkYO5RU6uUM5IwyU+IvbERWuMY9K4fXONGqPAnXtztUHnPhVg
         pwICVx+NPhCXmcg6NV4q/MmGYflrFiLZ/PfKs4WyBqHrdK1IgHt7vABXyzFHqDnsxOVU
         1xM2M9wWghyUASEwWlNFT1yqZ0xdRaiK5prZCIdyXhaP9fhVx3PR8oUniV5RL3VhTd51
         +xRjLOXpvA7YkXqvrdFIW6SMdhehRGRqYc57n7jex6N8nhrKe5PKIquljwwY4D11li+t
         8SkuCvVkq54qigrhHOAwQM5LdZknWfdjwzK2rc47fY0I/hERuRCXWPlJjdbfUspYxfVB
         1niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355056; x=1725959856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unYnDtIsElsDse+Va0cHUHNbjndhn2ZWY0Tb6Z5hUhk=;
        b=pd/P6CrZxvZKj+5tqETc+bDApdRltF0uf/BjDDqpkQfKUYkcngWYKB9lK31XRGM0PU
         jbWSQQNWlRWluPD6+2XOXOqq4l2O+XYPzEArOkhus3iFjcoV7j/Gx8u/r/xyUj2Of3FS
         abvySsAJmNpOZiNS6miEVoAO57isD/aSnMq/gnd8a1Zh1g8RtvCRnKkQydJRVp1zzGpi
         wwicHZ95VKqhKdj/Y0oBhOKvaFQNy05/trawfRxTBfRUQW9LWyfH01ilSEWaNKFkMeqg
         ffk36wGnlnB2Od53izA8kR1njAFUcXdhukbcSLh+BXwSNXF8fgVoZLQiquV5B9ADz85/
         pysg==
X-Gm-Message-State: AOJu0YxSGY5Jr7LDMwpxLR2S1y6BjW9MXFZ0/Jp1Cfs3igifc8lSVwX7
	v9UfgaTOrJlDS8DXLwehy9yAc+0A1cjegaf39gwGMkNYmF7Ss9SoAnq/ZeGDs10=
X-Google-Smtp-Source: AGHT+IFG9ytyEwPybheP1Q8wR61RKVp7onDXGutB8ticYWnuOKRSaVIFRBo0r6goH77sKsY3TTGAVg==
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a89b93db796mr722813366b.9.1725355055846;
        Tue, 03 Sep 2024 02:17:35 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb05csm658804766b.6.2024.09.03.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:17:35 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:17:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Message-ID: <ZtbULbRQKHUvUzYq@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <ZsdOMryDpkGLnjuh@nanopsycho.orion>
 <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZtWiWvjlMfROMErH@nanopsycho.orion>
 <CH0PR18MB433993BD0B4FF3B1F98A7628CD922@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB433993BD0B4FF3B1F98A7628CD922@CH0PR18MB4339.namprd18.prod.outlook.com>

Mon, Sep 02, 2024 at 06:37:32PM CEST, gakula@marvell.com wrote:
>
>
>>-----Original Message-----
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, September 2, 2024 5:03 PM
>>To: Geethasowjanya Akula <gakula@marvell.com>
>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>Subject: Re: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
>>representors
>>
>>Sun, Sep 01, 2024 at 12: 01: 02PM CEST, gakula@ marvell. com wrote: > > >>-----
>>Original Message----- >>From: Jiri Pirko <jiri@ resnulli. us> >>Sent: Thursday,
>>August 22, 2024 8: 12 PM >>To: Geethasowjanya Akula
>><gakula@ marvell. com
>>Sun, Sep 01, 2024 at 12:01:02PM CEST, gakula@marvell.com wrote:
>>>
>>>
>>>>-----Original Message-----
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, August 22, 2024 8:12 PM
>>>>To: Geethasowjanya Akula <gakula@marvell.com>
>>>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>>>>edumazet@google.com; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>>>>Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>>>><hkelam@marvell.com>
>>>>Subject: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
>>>>representors
>>>>
>>>>Thu, Aug 22, 2024 at 03:20:20PM CEST, gakula@marvell.com wrote:
>>>>>This series adds representor support for each rvu devices.
>>>>>When switchdev mode is enabled, representor netdev is registered for
>>>>>each rvu device. In implementation of representor model, one NIX HW
>>>>>LF with multiple SQ and RQ is reserved, where each RQ and SQ of the
>>>>>LF are mapped to a representor. A loopback channel is reserved to
>>>>>support packet path between representors and VFs.
>>>>>CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>>>>>adds representor support for both RPM and SDP MAC interfaces.
>>>>>
>>>>>- Patch 1: Refactors and exports the shared service functions.
>>>>>- Patch 2: Implements basic representor driver.
>>>>>- Patch 3: Add devlink support to create representor netdevs that
>>>>>  can be used to manage VFs.
>>>>>- Patch 4: Implements basec netdev_ndo_ops.
>>>>>- Patch 5: Installs tcam rules to route packets between representor and
>>>>>	   VFs.
>>>>>- Patch 6: Enables fetching VF stats via representor interface
>>>>>- Patch 7: Adds support to sync link state between representors and VFs .
>>>>>- Patch 8: Enables configuring VF MTU via representor netdevs.
>>>>>- Patch 9: Add representors for sdp MAC.
>>>>>- Patch 10: Add devlink port support.
>>>>
>>>>What is the fastpath? Where do you offload any configuration that
>>>>actually ensures VF<->physical_port and VF<->VF traffic? There should
>>>>be some bridge/tc/route offload.
>>>Packet between  VFs and VF -> physical ports are done based on tcam rules
>>installed by  TC only.
>>
>>Where is the code implementing that?
>We planned to submit basic RVU representor driver first followed by 
>TC HW offload support for the representors.

Would be good to describe your plans in the cover letter. At least the
once that are in near future. Without TC offload this patchset has
no meaning.


>>
>>
>>>>
>>>>Or, what I fear, do you use some implicit mac-based steering? If yes,
>>>>you
>>>No, we don’t do any mac based traffic steerring.
>>>
>>>>should not. In switchdev mode, if user does not configure representors
>>>>to forward packets, there is no packet forwarding.
>>>
>>>

