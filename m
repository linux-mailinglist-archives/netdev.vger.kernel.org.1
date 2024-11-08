Return-Path: <netdev+bounces-143151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0479C144B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E24B28204A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265A1AAD7;
	Fri,  8 Nov 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZf+KJs8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB1BD9F3
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034319; cv=none; b=ZwStRAZmDQ9cUddhMZSPA8FSm3VTUtWdTDJN36wRVRUefdfc3YdVBPHRHDu0ScJmeDs6oS6gn1imdPjl9tqmC6F5mBqnws32zb1xFE9SG8a8ax0ZTMYnGSHVdaZT8m0UhXgbJXLg0/1UKT7Jdx9niMF8/I0eIal4a0w888ac3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034319; c=relaxed/simple;
	bh=Kh8VK9d5L/8CkEYUhAhexxkajqGGPWdrLsAZ7fXzlMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZDqRIXovLBLKDJsuBl/gD0SaSQHwXcR8d1ZkQVdTmYenmJWgh1Ig2kjJiAX2vpdKUqVJtsIiUTewACIcGm7PEyl+47p3LLHMXxZh49ewzaMBkluLEWAKy/dfr+uLlcWK8T9Y28E6jZLMY5IbWD4hSB4ZIjedx0mdKUUoJLLSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZf+KJs8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso1444000b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034317; x=1731639117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJipCN6wXPFIhpI/SOP48KL210/YED74etx7a47/vVs=;
        b=IZf+KJs8CqOx8AF4QVGTdAxkOqYOnraxyJUVrnJMd9aL4w+HENhbK9O1OwwojOiWha
         sgybPSCmPZjN1v6fuoMDLi/FzM9w0cxysxvYowStLK/pr6ZWtq6WVjgdX7OU6ajO1mNV
         w4jld5NVIeZRvVJoqtZbhYxyFMjmWpxbF0K2ScynVa7xBeKr34krAzcrZOEab7Mn05Bb
         qnjwP0gnZLeZdwedl87I/Op8WTOOgskjSVWA7UKAu/RR8SJ26JRJlnMfyDsDEg6fceZG
         82rzpZn//5YuB6YtOCXdf0krp6AAPDKuTHhfRubG3O6yNW41GTx4f+YELcimIGfS+j+T
         YfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034317; x=1731639117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJipCN6wXPFIhpI/SOP48KL210/YED74etx7a47/vVs=;
        b=JgYJRjlwWezpio794QJndY2Tsk9hc5W7+G8Pl39GG920W4l/gr2n2Eg0G2VMIManBl
         kW7OEoQZE4LinCEPSpEzXiw6ETvrf3FANIiMCApdkWRNomi+vhsHYd5AR7TCfI1xNcCQ
         YHYf19iQRtKw2O9LkuInovh/Wkh6Fg0cFP93UQWXhjWlPcewhB37oCmXeqWQdCFhYrYg
         LDrrKbOCNhtdblYLEFU6WhvsaWuFfueanwUs/xpLqr1dX+HY99w1KcczYzSRpIJ2Xv4N
         Zbr6Qh8uylUjbAvR2Von0HY16RJLQ09ohf5NTQNnzha/rVHTT58KBnL9PmpxbZziMpuf
         nX0w==
X-Gm-Message-State: AOJu0Yy7ENw+DopVW7rMxHIqm/7mcDc3Ze/FwgvcsgpTgLJ2WWZOFggD
	HTOL1FGS4bYWEnrkOq44ntfMU/6IlptqWmhGSPpgWyq+megA90tXjR7RTrb7GJc=
X-Google-Smtp-Source: AGHT+IGSZXocrKJWE/7eHyYb9y3j+y3LTNgtVDMnkw0eR7dwqd5il5N83ImmW+wXcsBXGln+9LatDA==
X-Received: by 2002:a05:6a00:a87:b0:71e:4df3:b1d3 with SMTP id d2e1a72fcca58-7241325ff5fmr1913777b3a.4.1731034316965;
        Thu, 07 Nov 2024 18:51:56 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f48abbdsm2307566a12.10.2024.11.07.18.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:51:56 -0800 (PST)
Date: Fri, 8 Nov 2024 02:51:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <Zy18yA6kNmlCl6eQ@fedora>
References: <ZysdRHul2pWy44Rh@fedora>
 <316685.1731029549@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316685.1731029549@famine>

On Thu, Nov 07, 2024 at 05:32:29PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Hi Jay,
> >
> >Our QE reported that, when there is no active slave during
> >bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
> >will flap the switch's mac table quickly, sometimes even make the switch stop
> >learning mac address. So should we consider the arp missed max during
> >bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
> >before switch to another slave. What do you think?
> 
> 	Well, "quickly" here depends entirely on what the value of
> arp_interval is.  It's been quite a while since I looked into the
> details of this particular behavior, but at the time I didn't see the
> switches I had issue flap warnings.  If memory serves, I usually tested
> with arp_interval in the realm of 100ms, with anywhere from 2 to 6
> interfaces in the bond.
> 
> 	What settings are you using for the bond, and what model of
> switch exhibits the behavior you describe?

In our network, we have a cisco 9364 switch. Which will disable mac learning
for 120 seconds if 6 MAC moves in 30 seconds[1] by default.

> 
> 	That said, the intent of the current implementation is to cycle
> through the interfaces in the bond relatively quickly when no interfaces
> are up, under the theory that such behavior finds an available interface
> in the minimum time.
> 
> 	I'm not necessarily opposed to having each probe "step," so to
> speak, perform multiple ARP probe checks.  However, I wonder if this is
> a complicated workaround for not wanting to change a configuration
> setting on a switch, and it would only make things better by chance
> (i.e., that the probes just happen to now take long enough to not run
> afoul of the switch's time limit for some flap parameter).

For Cisco Nexus 9300-X switches, the `mac-move policy` is supported since
Cisco NX-OS Release 10.3(1)F, which is released August 19, 2022.

So there do have an option to disable/modify the mac policy. But switches
can't update to this version will be affected, unless the user change the
arp_interval to an large number.

As there is an workaround (either change the switch configure or
arp_interval), I don't have a strong intend to change the bonding behavior.
I will do it or ignore it based on your decision.

[1] https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/sw/104x/config-guides/cisco-nexus-9000-series-nx-os-system-management-configuration-guide-release-104x/m-configuring-mac-move.html

Thanks
Hangbin

