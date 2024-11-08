Return-Path: <netdev+bounces-143109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF4F9C1338
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1269B21B57
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D19629;
	Fri,  8 Nov 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0BLpyXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCB23D7
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025948; cv=none; b=bcWAvgS1xKH3pZtdtLO/oKg9jdt5tcUDVzVRC5ZzB3Y7/gzzaiB4AQ1BAveuT+Ea0MW3CJnplGl6dPRvtgZ+uPPPZeLn/41fXbnnp/tRZvwSDA1wkRAxsoKlJWplGdw8TNDmeI38InK2s7c6geNAJOljBSAMK8ZDYt1g7vsR53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025948; c=relaxed/simple;
	bh=sczxAEid4gJKo+gcq0odH8sVvFXDz6D3xOJMU0iOZjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUNlbyOSSqsqY04UGyddBKMcTlBBpgi0//vKqgEG7X/rArH1YM1R9h9ju9MpwaX5AhBtUr7iflqhR+I3L4ycH2JKtLPa2TS+F9a+6rWk66aBNcgKIaypN7/pqu2mQ0Dq1P/hntdlV6927jV3adsqWemJxsIJFtwIR7F336boOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0BLpyXA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so228629666b.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731025945; x=1731630745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MdQhdEvTWjG0pfyca11rQWeHHiBydcgShbkIhg3ZNsc=;
        b=k0BLpyXAXeFGRqoBgJd60hVPz4mVp4vrwFpRafYMULi6W9ecY1YI4WJEL8taU0/Dw/
         Ac2uqCjA2bhvPxE5P+hJknQEu/OB2pqC3Kb4aiIU/Vwp1qgTEiUX4hhICgeKQbo17SBc
         i7b9RWoVSQP6lTWqrkUee1lxLxeGwjL/laD8gwJ+rJGAj1TGPRyRrCxoRTUUco7FSyGZ
         8BKrjqM4v5dW+vjSpLzCEvSb7ZFZo1XhJCBV2WKm8YgbF77HlL7a3h++QjMRGkNRYfx4
         MX14BJ1KuJXXpGToQA1K1vsc2R6+fwIpN05sA211R82jfPlsW0Ust4jUGZL+C3bNsKeh
         KDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025945; x=1731630745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdQhdEvTWjG0pfyca11rQWeHHiBydcgShbkIhg3ZNsc=;
        b=dQ6hbuWHtXYdyj8xvAPI42lggZnWG10hK8vPd7l4t/MiA49STsVx2RbDAYVNwW59yO
         PSyXhSYCnSL7kixXZCXCAoe8DsCFtA+5jXpZIqFlqQWXWuMBzzB/bwgnSd26uvwYA9iN
         hz2uUEeH3rGt7zo+EGh+0X8S0TaUlqdpFUkC7wSOsHWvNkjAAHPOILoVNf1tpAA+7AuK
         pvYOZ4Pa2nXyDHuJAbtvnbyxwOM64Aj/54b/E7thFYdZhNrD0mS8cEmWsLArznmIhuoH
         WI9H8N+2CqwbadOabfG/bOmMFwaDIjCQAtM/OrEmX4cHSISb0XYRrIw34NbTPlfKb+iM
         Ls4A==
X-Forwarded-Encrypted: i=1; AJvYcCX3BQF4W89lp/hRotreRbnWdu0INYsQPEB2tyVOqMtAt7lzqzNkTDNfXXKGsP5aZ+WLy/1H4Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJExdt+sNLnRBL6I8BVpuVVVMsqhmBTVPq158M3hxTUJe9OEi
	7jgqPxOF2Iy+0JZZ5BhFXycaROFF7TcZJsRqDCAd2CkgpF8mN10kzVAH9pPZVaS6m8ETTe9Jb6B
	nm0ZuPmAbBothj4wS4hd/Qd75dcjI1SBEFpHF
X-Google-Smtp-Source: AGHT+IG6eMM2vyTObQCqAB/HeBq2WlN5QRXSJfzNZDw5e6gbnugLsKXTpOW0WXvgUZLQRTmchSOn52ddZP6re3qW5pg=
X-Received: by 2002:a17:907:6d0f:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a9eefeec9f4mr55270966b.20.1731025945471; Thu, 07 Nov 2024
 16:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104233251.3387719-1-wangfe@google.com> <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
 <20241106121724.GB5006@unreal> <Zytx9xmqgHQ7eMPa@moon.secunet.de>
 <CADsK2K9mgZ=GSQQaNq_nBWCvGP41GQfwu2F0xUw48KWcCEaPEQ@mail.gmail.com>
 <Zyx/ueeoeBdq/FXj@moon.secunet.de> <20241107115031.GK5006@unreal>
In-Reply-To: <20241107115031.GK5006@unreal>
From: Feng Wang <wangfe@google.com>
Date: Thu, 7 Nov 2024 16:32:13 -0800
Message-ID: <CADsK2K_D8EZCm2_BtJ878z=a-mp2q=dUtwgfT50ZgcPafrs3XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>, netdev@vger.kernel.org, 
	steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"

Based on current kernel implementation,  the packet offload does match
policy and state on the TX side in the kernel.  For the RX side, the
driver is responsible for the selector policy and SA match etc.
I added some logs in the kernel, and listed the kernel function call
flow as below for your reference, this is for TX side only.

 (1) ip_output -> neighbor_output -> dev_queue_xmit ->
netdev_start_xmit -> ops->ndo_start_xmit -> xfrmi_xmit -> xfrmi_xmit2
 (2) In the xfrmi_xmit2  {  first call xfrm_lookup_with_ifid() to get
next destination(dst),  then call dst_output() to send the packet,
the dst_output in fact is xfrm_output() }
 (3) To trace xfrm_lookup_with_ifid()   xfrm_lookup_with_ifid() ->
xfrm_bundle_lookup() ->
        {      first call xfrm_policy_lookup() to find the policy, the
policy id is checked here.
                Then call xfrm_resolve_and_create_bundle() to find the
SA and generate the next dst
                return dst;
        }
(4)To trace xfrm_output(),  now we know the next dst, calls
xfrm_output to send the packet.  xfrm_output() -> xfrm_output_resume()
 ->
        {
              first call xfrm_output_one() which goes to resume part
directly without packet transformation(this is special handling for
packet offload) but it calls skb_dst_pop to get final dst. This dst
has no xfrm(SA) so the driver can't access xfrm(SA) using skb_dst.
              Then calls dst_output() with final dst, this will route
the packet to stack again, going through ip_output() etc to pass the
packet to the driver transmit function, and send out.
         }

I did make a mistake on calling xfrm_sk_policy_lookup in the
xfrm_lookup_with_ifid function.  In fact,  it is NOT called.

Thanks,
Feng

