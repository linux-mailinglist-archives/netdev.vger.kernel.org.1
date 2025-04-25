Return-Path: <netdev+bounces-185881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B8A9BFB5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EA53B8952
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293992222AC;
	Fri, 25 Apr 2025 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vXKK/f19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1D34CF5
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566054; cv=none; b=o0y+1xEPoyFaWPxIJdjJNLD8YYfDp1v3zQwLA3UGmlljKE8+VIzc0UUrmR3jHJ7OnXbRyqyUiw/wslTxE+NZ/Em7YuBqWM/emig86dQt1tV98OWm8T2u0KCK1MGMucyqxBDywJPkguiSSfGb3dE28DKq7rqOibgf47sqZGv5FA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566054; c=relaxed/simple;
	bh=3xso4MRl8H4lblLpPr2RV5VaEdRg7Vpw3ViA1nJtwY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl8dv6AWjCUNNle7Ne1Xq1b9m0kXWv0qkPl2BcHRTDgz3qE7g4tn+/6iSZdWYs7LQb/vas2vMyJgq92BAPldzTvKjU5PWAHm/cWNVqNomN4UIOav/T/i4kC5hZWXx8bOG8Qo2/FAl+LqSkXnaIiTe3YoAPNJ0CvlUKse4Y2aTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vXKK/f19; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso15335545e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745566050; x=1746170850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGFoUQDq04rKNiRk8IE621ZcnwHxGE4vxpM8LZEMwsM=;
        b=vXKK/f19pt8vW/NQGzbnuC+QKp32wRTWjPNGlbmXXx/mYunGvzXbh2CanvEul0gAfY
         cYdyTPlty7hxy3hxuVn1/ylG4iPnqBWj9VCzlpVEtziVfvjJJzuCTrWqpSFTV8KX1cpQ
         h1uOu49XfUR2DDqaMYnqPrqdECdZ6E0lShBRvKAnIkfIBhGYfQqTm/Oor0O6alv0gez3
         WvvhU50JcGdH9nLK3TWSfWhCrvE7SnszGuWsLz/VPQ2RIGthiFU15SL7FKqhyb5d5eVF
         P7uIaBOZm71YyZ6QWhJ+EGPkwT3l8Z5+E9+bfUwNuHxse/4HTVgqw8WYQ7dJwTpZ4zww
         a6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566050; x=1746170850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGFoUQDq04rKNiRk8IE621ZcnwHxGE4vxpM8LZEMwsM=;
        b=hotrdSoHQcXQlbWZvvELBjAAm2u4+YyYtKX/t3Y+mbeyp9xwXDXo6Ty1UY5TDWZfM2
         iX8yVtPoVzQIscbMN5d/I5SWb6UNLTRZj9W2ZVXtCuvIPk+BwU+dux57RQwW/nlWpU0g
         /gE+7Wv+icxeCbecVbm+jhxI3+e4leJ9XNiUj1LAL8XPYguYtf3yBL39X1+D39acEa6S
         n54V7FuUXdRH/AXuESg834F6s4VeUTYVBXOC1jlQXS81b3cgqNkTtqj52/c1Xlshc1A8
         gg3RvCA8bKl/wQf3SLmz9GClzk8LRztqTUuMHYUT8iGecSUp75LMdQEfNGNiSylbQg+6
         IVUA==
X-Gm-Message-State: AOJu0Yx2C4+EfbTygC7xYzFYST0L450gUNBiMbxafhcU0nnbZ8/pboZs
	HF+lq/LKTukc7pU/+uKY65Fdlg+naZthtrEAPwYf8CCV4B1QfN5erMBrCowj+ug=
X-Gm-Gg: ASbGnctHEZMU4PVDdT1JigyjD3fo0z3ffnakhFSCSLz4JRXgoYf6bTn8lX1DGp1IMZu
	7WByHrVX0TafTbhFuxrHHyMfmt7q0f9jlg3+DQ8BAnRREgVtTNwMVeXcC5aFU1MddidXKzoY8/f
	I9i6A73Xsugnj4Z0X03XRDKGRTtp6xvk0jGZdwaKJMcNjijpKNyKdmumIqt+f7DpjiwIJnh6xF6
	WYDFNqBvsJSMM3sg/MGEX0kWbzFKtamOgd2mDVeh7OTXcWjASU0ggZEfHEX1cbGmFlf94qMxv3b
	+vO1GMwUw9RIFgqm7UrL+UbibKZ3Ze9VDp1bCGfh3M+zuI1D
X-Google-Smtp-Source: AGHT+IHs7o1e1KYOiRqNq70mqcnxnwWyiDPaOI2zEMleHx9AmzWD66gcz75taZCBbgJM3rDSNBl74Q==
X-Received: by 2002:a05:600c:5028:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-440a66b6f63mr11691875e9.31.1745566048971;
        Fri, 25 Apr 2025 00:27:28 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5369cc1sm14751045e9.32.2025.04.25.00.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:27:28 -0700 (PDT)
Date: Fri, 25 Apr 2025 09:27:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
References: <20250416214133.10582-3-jiri@resnulli.us>
 <20250417183822.4c72fc8e@kernel.org>
 <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
 <20250418172015.7176c3c0@kernel.org>
 <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
 <20250422080238.00cbc3dc@kernel.org>
 <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
 <20250423151745.0b5a8e77@kernel.org>
 <3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
 <20250424150629.7fbf2d3b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424150629.7fbf2d3b@kernel.org>

Fri, Apr 25, 2025 at 12:06:29AM +0200, kuba@kernel.org wrote:
>On Thu, 24 Apr 2025 11:42:09 +0200 Jiri Pirko wrote:
>> This you see on the PF that is managing the eswitch. This devlink port
>> is a representor of another PF, let's call it PFx. PFx may or may not be
>> on a different host. It's a link from PF managed eswitch to PFx.
>> 
>> So you have 2 PFs that are in hierarchy (one is on downlink of another),
>> each on different host.
>> 
>> To find out how these 2 are connected together, you need to know some
>> identification, on both sides. On PF side, that is port.function.uid the
>> patchset mentioned above introduces. On PFx, the same value is listed
>> under devlink info, which is what my patch we are discussing here is
>> adding.
>
>Still not clear, sorry, can you show a diagram?
>"Downsteam" makes me think the NIC device itself is a PCIe switch?

No, in theory, the PF can manage a nested eswitch. That is not the case
atm if I'm not mistaken for any device.

Here's the diagram:

               ┌──────────────────────────────────────────────────┐     ┌────────────────────────────────────────────────┐
               │                 host A (DPU)                     │     │  host B (host)                                 │
               │                                                  │     │                                                │
      ┌────────┼──────────────────────────────────────────────────┼─────┼──────────────────────────────────────────────┐ │
      │        │                                                  │     │                                              │ │
      │ NIC    │   ┌──────────────────────────────────────────┐   │     │                                              │ │
      │        │   │               PF0_devlink  info_fuid:A   │   │     │  ┌──────────────────────────────────┐        │ │
──────┼────────┼───┼─phys_dl_port                             │   │     │  │        PFx_devlink  info_fuid:C  │        │ │
      │        │   │                            PFx_dl_port───┼───┼─────┼──┼─virt_dl_port                     │        │ │
      │        │   │                              fuid:C      │   │     │  │                                  │        │ │
      │        │   │                                          │   │     │  └──────────────────────────────────┘        │ │
      │        │   │                            VFx1_dl_port──┼───┼──┐  │  ┌──────────────────────────────────┐        │ │
      │        │   │                              fuid:D      │   │  │  │  │       VFx1_devlink  info_fuid:D  │        │ │
      │        │   └──────────────────────────────────────────┘   │  └──┼──┼─virt_dl_port                     │        │ │
      │        │   ┌──────────────────────────────────────────┐   │     │  │                                  │        │ │
      │        │   │               PF1_devlink  info_fuid:B   │   │     │  └──────────────────────────────────┘        │ │
──────┼────────┼───┼─phys_dl_port                             │   │     │                                              │ │
      │        │   │                                          │   │     │                                              │ │
      │        │   └──────────────────────────────────────────┘   │     │                                              │ │
      └────────┼──────────────────────────────────────────────────┼─────┼──────────────────────────────────────────────┘ │
               │                                                  │     │                                                │
               └──────────────────────────────────────────────────┘     └────────────────────────────────────────────────┘



info_fuid is the devlink info function.uid I'm introducing.
the "fuid" under port is the port function uid attr from the RFC
patchset.

Is it clearer now? Should I extend the diagram by something you miss?

Thanks!

