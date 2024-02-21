Return-Path: <netdev+bounces-73658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2A85D749
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD4DB2454D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29444C84;
	Wed, 21 Feb 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvt1SH4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC934122C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515666; cv=none; b=XnBcgIf3t+bevo6koXKSzqCW3z8FFz9/bZv0qVwKB9680KeV9/rZDUPmevWOPY7FHwSbfRr5M2ppoBwxw+dhkCXPsCA3jD9n4TERoqP03NdxG/BQ7j+Nl9hnEmeh9o5JKhhpmj9TbdBcbS25+fL79ClK4HSa9UiSqJo0plrXOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515666; c=relaxed/simple;
	bh=GAeJayqA2HREeeBrER39skthm7UFJclmqPVb47TF4Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNq4L83CakmiKpbpVaRTcAsuhYxyGUE7GdUaMpXJbmGiKywVUd2g4SXK6gFSn18nLVb5XTGZTtpagzBPhx0rEUktvzKX97Y87+kVj+eKfDfmxtth2EkDJxK+wX5hS8WXTGc2/WxYjRr0GQKkf5VsgmmKWG+BNJiJrcNXN3vfwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvt1SH4u; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21f2f813e3bso575291fac.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 03:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708515664; x=1709120464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GAeJayqA2HREeeBrER39skthm7UFJclmqPVb47TF4Pw=;
        b=Hvt1SH4uqLxuGBlXvcW1qvpArjGabzDzcUZov2QOjIP8iT8cukwxS6P+m+nP1uSAi4
         LEpPcP3eFhB8b+plH/yMvY2I/7ow8yK8+IolCfgE2D3rayOowoKbySJ8uRLyk8W8aGF9
         NXDFAv0vQ8DnqxCJwOuEwYZuVhnVryuoy7zCAzpBNNmkqjgdecUTFoVyawmktO1PQWnW
         dUeBX2KLGfP2eTZt7EHdiso3aTb/Ijry3kQBTJJW10VEzRtu7ZpLU75u5ztrzIKd90pl
         uphZOBdLrx4bxTyQM3Rgfugz4A8tqFqRDf+GMxlc8/APlDvz8IY/0P0d/9Lb4qYh+jxl
         ggtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515664; x=1709120464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAeJayqA2HREeeBrER39skthm7UFJclmqPVb47TF4Pw=;
        b=XdA26BHbyr3U3HamAdzSZc60VmDC0UW48/3saJJduXhcPBDatmMOLd8LYTg9iwJllx
         4CicEkE+LtFZAW4HLWZSxkXyZTAJp1NG6+FtGMquoWsSr5qGFfF7IMTUwB/ABCKbvyvA
         hVK5d92E+2LcHoc/MEh7w6Dxu3oYf02wS4l1O8Am4jv+obYOmvgmceBtz26ZlRozorSz
         +0LhyaC6DQYHLV7pIg9dn6si5UG87mlrw2OT9sDejVqNKNXSCy54pJ/+1i+Ys2pSzNR6
         tIght2L1tKqTW+TB3HXqeGTs+Hf21Q8w5EChu+hUl7ifn55Glh2Ie8qEydvjVJkdkwAy
         zYsg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwI3nKlnl8PvcUqdUy7eCz58BzSlpIOqwCgGakHhGIp862eF3h75+z2zJQiqQ2AHoYcRttzvVA7ZzoazZly2coMCVpIed
X-Gm-Message-State: AOJu0YyEM/Avd4tUw3BvxjO7z/YXAtb1YHISoE9ugP202BfJMyTprpJh
	+EwJNUISjTVIzEDxotlMCXTPVtoCd8f5Nz2v4tnA52dm4xm6EYWjUrol+bavMjcdOyHh2xcllIT
	Zi0uUw4v1QOZ65rQAT4xLU9tOVWk=
X-Google-Smtp-Source: AGHT+IFcp6i0Hn1yWYZtyhTKnO5+ynGB7WwP0tkBHPTT1x3cpzZbNw4KbI30JLBLRzXhbHhKgw8YkuZ+0Rw9D2tDOl0=
X-Received: by 2002:a05:6870:e389:b0:21e:6c0d:41c8 with SMTP id
 x9-20020a056870e38900b0021e6c0d41c8mr5776740oad.16.1708515663665; Wed, 21 Feb
 2024 03:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219172525.71406-1-jiri@resnulli.us> <20240219172525.71406-4-jiri@resnulli.us>
 <20240219125100.538ce0f8@kernel.org> <ZdRUfZMRvjMlDqtX@nanopsycho> <20240220175918.73026870@kernel.org>
In-Reply-To: <20240220175918.73026870@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 21 Feb 2024 11:40:52 +0000
Message-ID: <CAD4GDZyx9eVcGorgOgdSinM_pGRNhqqLCNX-SAvdZAXqTCy+KQ@mail.gmail.com>
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum string
 instead of scalar value
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 01:59, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Some of the sharp edges in Python YNL are because I very much
> anticipated the pyroute2 maintainer to do a proper implementation,
> and this tool was just a very crude PoC :D

Hah yeah, I looked at pyroute2 a while back and thought there was a
bit of an impedance mismatch between the dynamic schema driven
approach of ynl and the declarative / procedural code in iproute2. I
think a code generator would be the way to target iproute2.

https://github.com/svinota/pyroute2/blob/34d0768f89fd232126c49e2f7c94e6da6582795b/pyroute2/netlink/rtnl/rtmsg.py#L102-L139

I find ynl to be a very useful tool when writing and testing spec
files and have been happy to contribute to it for that purpose. I
think we have started to remove some of the sharp edges, but there is
more to do :-)

