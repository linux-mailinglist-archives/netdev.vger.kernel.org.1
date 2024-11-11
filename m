Return-Path: <netdev+bounces-143836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED39C4648
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A21B2573C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8B1ACDE8;
	Mon, 11 Nov 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI32nPPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FF132103;
	Mon, 11 Nov 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355116; cv=none; b=GlFwcBtgcKooy7s2h0tHMaRgNYPCHEBkvYfsXpkf0hb9CzFdHpwvJ36Sq/ZDcV8ksGAwYL+tK9y4L4ZRyUr/A032Jst8ux+kV7EJzSzgxq0HXrxGN/DTNQ/yh4OH1gWgNNzItEty2yOWVKsqxFZnCgrPZmnZaooC1N02VxIu/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355116; c=relaxed/simple;
	bh=ON0AlIDhl0YDHxKdU+ihcdwjaxm89f/8egJ9/sEc23E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHzGp+WpSxMigaCZcmqpsqOtaDTLKNE6ycybJhV17IoU1NsptdvJ/PhWcidMSulu4agkY24Kq1wt6brpmwTc5TwubJi1pPXCd8s0rPebOpj4TsfwG/0ZwktODVPbj95wP/RSgDNuk8JOhu3b61pLUQYGnoT+gIyyrn0Yf3N06+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI32nPPj; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71811c7eb8dso2492324a34.0;
        Mon, 11 Nov 2024 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355114; x=1731959914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8A8rUuy7/VTAf6Kqmu6xBinSUmiSsndYcym3H8tihfk=;
        b=XI32nPPjfIMU6ZLCx6+fBvTUOqBfb9cJ18a+iKkUyp7PApsbwX4sfMsgiEKJSV8N34
         On5xrzULMuQNi+geuaJRoc4mLN96bn5NeETfHl49pepxcgg1sN8ps/9mAc/LpxMk0jt/
         eY3CzFBFcf3/sW3Em8UkjwdMPjSEkWBLwBT9Hxhf23GwUmVcUS4A9IjirGM7dJG+sQpk
         c03MrJApvZiKiVPtfniLNtw9uI8M0J4rni3a2AJMuVfmdlctLHFR4QU2bwRD/vGu4ry2
         33YnuhBOl/BgOTBOpZeVqKd+k1plM1Vs2akyHGLrNC+d7Yo/4J74YagIvgRQhoW7lu2N
         BatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355114; x=1731959914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A8rUuy7/VTAf6Kqmu6xBinSUmiSsndYcym3H8tihfk=;
        b=n0ZicFSnSZ+o5n3vw30vGQQ8QNEIJuvypaThoTgDymmWfBZqhV+ADiCibzWshFDJgR
         KHzUNWjwkekFywQ0XGllKP/nGFZueCKVt1JiOsBPAHPIZZWlldvLjJacct+IbIweyinT
         fs6B6pcY9I6mOP4ygvJNjaZwUFot2x6GjF0jXNVt5ngWZ+OEfvxMEOkDV7YRfP7/JaT+
         aybjkAnkYmxf/L/TIi4skODtdCxbs2uUbEQVfVEki5hshR3LnYvgcj/VdS7OKngKSkEo
         adD2Jis7zozIU3xWlyQPG1+8XfnAkO+0kCudaqgpp3wvgR4AAtpQyD4EMDtIoCQsD39x
         pLXA==
X-Forwarded-Encrypted: i=1; AJvYcCVOQGMuE1HiVarvnziDX6K7IyoUc6TxsT/gp7UNhge1h91I97PcYpBDXCYrywyodQtugvS7yBuu8qrLWMYW@vger.kernel.org, AJvYcCX5YphSUzBsHM8uVjPi3KqKEe69IxJB3PKdusFoiwC06OCxfOYc9P5XpvlcspXYIcOyKqRm1dL0RAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwI2mlD80491GKfdPyd0uK+VNnU5FmOBQZFoqmlBN0ZKLMflj
	8Pe7pL9ir362dk1YxcpTOP//KbQEce+7RiQoojIADfwJVQr44Xi7RcwUfh5jcNomcDxv3fc1K6T
	2OB/AXs8yskM/rvJpcY3HEZwzEwo=
X-Google-Smtp-Source: AGHT+IHl4KbP/5DXOESiWJzk+JWleWKSocATe2GWysNXBghLSGXVooAIQDhl1191eehYfflm+3RpcwXkVZ1sonrBEXs=
X-Received: by 2002:a05:6830:6a8f:b0:718:12aa:f7b5 with SMTP id
 46e09a7af769-71a1c20c4c2mr11194291a34.12.1731355113755; Mon, 11 Nov 2024
 11:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109025905.1531196-1-sanman.p211993@gmail.com> <e80299f8-5fc4-41ba-8e48-37029078825e@lunn.ch>
In-Reply-To: <e80299f8-5fc4-41ba-8e48-37029078825e@lunn.ch>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Mon, 11 Nov 2024 11:57:57 -0800
Message-ID: <CAG4C-OnJv0+GyHT86q-Y8h_pav6qMXc8vmO+8FMzRYi2T4nptg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] eth: fbnic: Add PCIe hardware statistics
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com, 
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, 
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Nov 2024 at 10:00, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +void fbnic_dbg_init(void)
> > +{
> > +     fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
> > +     debugfs_create_file("pcie_stats", 0400, fbnic_dbg_root, NULL,
> > +                         &fbnic_dbg_pcie_stats_fops);
>
> Have you tested this on a machine with two NICs?
>
Thanks for the review, Andrew.
No, I haven't but I have tested on a 1-NIC, multihost (2) system.
>         Andrew

