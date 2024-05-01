Return-Path: <netdev+bounces-92815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DC8B8F71
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DA31F21499
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089F146D5F;
	Wed,  1 May 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYKo6iSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304432C85
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714587404; cv=none; b=h8hIXgdi+F2KI3yII7fgUC64MrP5MJ26BPMiqLiCNHGEf8yIcGgXL1PGt+dIVCTRolq2aGt/EXZc3ez4S6Jaj9lrCFfWMsW9VyYYzySEoQr1DifxdFVhaesqHWweF/HiKSgpW3CGcF97HTSLFAOKvZw3ko6bfXJbHKa5wXRAU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714587404; c=relaxed/simple;
	bh=um3QI+jS2eRa0Wi7aE0atVKG7SKSi6QmpIMsI9TiMbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6+vaIRCxkCL2C8ZMEyWxXT1DjYnINkkBFFgfwK9AoHy9NGrrdS5h7b9qJPH9zqqaXOkX3imtlVRhjTr8ZJWyiQ2vpqcxBFEhSB77LugWhu21hKmI5nd5l6ziEUy8BJsCkdIN4klDAvtntibFhvEHwfD7r0otD2WtmJcAvgSQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYKo6iSn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ef6ef5c5faso1008447a34.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714587402; x=1715192202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h07FLRwiamUXF7mmKRoLxadvWj3yvk6Y3EfSpj1/B9U=;
        b=gYKo6iSnd6sisJNgMWQLkhgX+8HU3LeJzzyQxGyZGmLavPCLIJNZzRCWBYjrjUD45T
         nx6pRElvf3Mg0FXOpT+7LbJjTsOXF3MJEntOn71TGk+iJbUSFKBdjldt8wYuhKW7BFxp
         Wjv8j8MLVuaWIvio6OPwawtXbTZRUvpU+WyAgYpY3oTV6ct4dCStfaoroEr/qhG5wh0e
         KvC+1hajBYpfetusJmUBsHPigZJCPiuLHBABzT9H6qGIjRlql11n7xBQPst9Bf6qH6zC
         gxirJjNHG7W+fCiMgEvigP4YIwwzr8uMllYOJig5bo36XJKvTbd9uFiI89/7coAEPzUN
         bf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714587402; x=1715192202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h07FLRwiamUXF7mmKRoLxadvWj3yvk6Y3EfSpj1/B9U=;
        b=tgCHMbX+dBKK3OGLQ894wo/YLVCo4oNJO58LaQF3Y4sTM5FQVF2nGIWXt3TeAUyynA
         Xcvg3zxZVN+hFsxrA08bh541jTwtwdGSV+ycKrXsSe9CXYv1RR0W+tmIT/VlcP1UiGZ+
         sZ8iJ35JBD9F61xMU5job5KelWqQ4DA/8zMs3XITtfr5rF3O2pKoObZsETvvGLIqsTCv
         e4xrx1vyeC50J3eNBoOq3vw/YZY/x0K7B6Ko9bGqfmgUmSBAs72tSdJJTA5k5tLnGm74
         +djvPD4TmZXit6Jmjfsr6+CTL9MrSPF9LQCSMm37LFz4V8HPPGqBK+fkBcXuYHinkXvm
         mdmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzISOOyxLbHRLY7+t8i3II3fx0MHhWYpLOex3Z119hl9eX7Suecsfq3dQQ0Oa55NLIkZjvYXXUESrAH/W7lZIkkSVqpIcr
X-Gm-Message-State: AOJu0YxVeKWACnqHbPEZm6SkvsEV/hNdoWZI5YxKNaM3MSMUzVAZQzXv
	rNpBFROXf0pdf0tORPkCPMryZ/+RT+nfsOVRo8xFLqsTkclF/fop
X-Google-Smtp-Source: AGHT+IE1+sOI98iQqkK1I1qG0QYLtfPeq+B9BbPlq8q3xsrAoJJNXVGYw2Hj4WWIyl3IEKNHZGwrUw==
X-Received: by 2002:a05:6830:25c3:b0:6ee:6675:fb47 with SMTP id d3-20020a05683025c300b006ee6675fb47mr4112010otu.0.1714587402357;
        Wed, 01 May 2024 11:16:42 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a022500b0078f13d368f3sm12058890qkm.95.2024.05.01.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:16:41 -0700 (PDT)
Date: Wed, 1 May 2024 14:16:41 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Shane Miller <gshanemiller6@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
Message-ID: <ZjKHCTe9j4tAg7yp@f4>
References: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
 <ZizS4MlZcIE0KoHq@nanopsycho>
 <CAFtQo5BxQR56e5PNFQoRXNHOfssPZNdTDMEFpHFVS07FPpKCKg@mail.gmail.com>
 <Zi-Epjj3eiznjEyQ@nanopsycho>
 <CAFtQo5B5oveWMr9PoUEmFnsbxwjQbxtHDcFpsUg646=Z__fJtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFtQo5B5oveWMr9PoUEmFnsbxwjQbxtHDcFpsUg646=Z__fJtw@mail.gmail.com>

On 2024-04-30 17:29 -0400, Shane Miller wrote:
> On Mon, Apr 29, 2024 at 7:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
> > Nope. Think of it as another switch inside the NIC that connects VFs and
> > uplink port. You have representors that represent the switch port. Each
> > representor has counter part VF. You have to configure the forwarding
> > between the representor, similar to switch ports. In switch, there is
> > also no default forwarding.
> 
> The salient phrase is "forward between the representor". You seem to
> be saying to forward ARP packets from the uplink port (ieth3 e.g.
> the NIC that was virtualized) to a port representer (ieth3r0)? Are those
> the correct endpoints?
> 
> Second, what UNIX tool do I use to forward? As far as I can tell, the
> correct methodology is to first create a bridge:
> 
>     ip link add name br0 type bridge
>     ip link set br0 up
> 

I recently learned about this too and here is what I noted down:

In switchdev mode, two netdevs are created for each VF:
1) port representor (PR)
	`ethtool -i` shows "driver: mlx5e_rep"
	sysfs device/ is the PF
	`devlink port` shows "flavour pcivf"
2) actual VF
	driver: mlx5_core
	sysfs device/ is unique
	`devlink port` shows "flavour virtual"

In order to be able to pass traffic, the PR must be added into a bridge
with the PF:
ip link add br0 up type bridge
ip link set dev eth2 up master br0  # PF
ip link set dev eth4 up master br0  # PR

