Return-Path: <netdev+bounces-74054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8AB85FC24
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E982896EE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A214A0BE;
	Thu, 22 Feb 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsozwwjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E7148FE3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615166; cv=none; b=kqSzNFy3RqB6LHt3ehNisY4DaF51loacTzdOzOtmUM7U1z8fWBzVzL8XX9SSGX1XWLmlS/ddoSm+rogmkETECS7V5ZNnhRHVzwocDMDwnRl/S45MbtpyDm145y0t8AlrWpbLDXL8WWSUgBrceuGb/yA38BhOTqds6yCgz2Mk/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615166; c=relaxed/simple;
	bh=DD6c8TtHTmyYpir3UITEluWHtF86DiSjuQT7S5fR060=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLLWykcqs02kczZ46OSy4m+DZK/BYakujG6hPWMyuqp6hu0xy5LTDyrhtx/gNGz8UtZbpH63m9O28gK/kgkq5O3JeNskhNiv2alikkgpt5Ja1bz29s8ByLC3ifQF7cqANXaSaIiw65Pu3MWkCqLz+uBnR2+UUkKjufUBf4m4jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsozwwjO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21f5ab945e9so399177fac.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615164; x=1709219964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DD6c8TtHTmyYpir3UITEluWHtF86DiSjuQT7S5fR060=;
        b=FsozwwjOq5/giK/RzrOlZdTAjGzjjOKf3xJYQgua3tD0URHhRlAUs3gPegN/FAYjKR
         AuCP3FNLdQ32Jz1GqT9dXmlPyFLCcOotq/JmjwETdDWjhnsSrZtnUC+qB0QxPMFEQWCD
         GYtzU5a7k6WUNMYjqHyiYMl2cjVurFvwLxrngxCW1rZ/DDP0r739ofPgKlTHn10VZxTI
         xDUv4gGpOh/BiHltVehucZZr6ervmf0Qekh+Cj402CXYD7HIDla9V1+aQOyjhShaJ/VD
         ByRU8Mv3agqBr2VrlZZIZJxCOGCzDbsz06n55QvVTpdtcpPdbrI+9k0gGi758ZT+X1PT
         SuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615164; x=1709219964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD6c8TtHTmyYpir3UITEluWHtF86DiSjuQT7S5fR060=;
        b=iRViqZ78nh2cAqUze8vAhPcg82tn2hV80NT0N5nr4Y/NYtJ89m5474iq7UpEXgnCUS
         l6xwc18yk22Ujh1YGEiaPx7CPkJTKsDbp6U8pBHKyqz+HW0AH5j8YTDV9rz2fMDfSKWU
         sB3rlg1UvMXIeyfMZqhS76FUOUvEWd7vUsALkNPOZCosxr2/LwrHXnoOTetjef8ehR2g
         dsx9feJCwwd3wiLedrCNotIMe3B0x18Afz7Z1UBg3Hl71PjJ/dY/2SU/HTs1sK68E3GN
         OWO7VI/vcz0EBMqG/Onz+BaOxiwhNj948wkQp4GiK4GHYQPSGVBKw/z+yzj4yzPDK6t/
         COHg==
X-Gm-Message-State: AOJu0Yw+ZXYlxo6Fpb2djymlYnBEVMrXcTDDHSuejDG0Oy+cSs0LiJAM
	A33B2aBW0dfB1UowdGTg7hBIzcKbcPZj03BdZJJ8SJDnG6s3MLTvcx7BQbKJFa7bj5Tx4aZ9GhY
	PH850hn6yCthmTDhshzg6drYgYNg=
X-Google-Smtp-Source: AGHT+IGsJLG49kJ2z9lIuDmSVZkjyNCzPd1SOgqPL/uJa3LfYsn+u1CKUpIkiIsZGkPgoML1jSXTQVWPhsJ9IVlkzVE=
X-Received: by 2002:a05:6870:3289:b0:21e:a713:2af5 with SMTP id
 q9-20020a056870328900b0021ea7132af5mr1314701oac.9.1708615164452; Thu, 22 Feb
 2024 07:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222134351.224704-1-jiri@resnulli.us> <20240222134351.224704-4-jiri@resnulli.us>
In-Reply-To: <20240222134351.224704-4-jiri@resnulli.us>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 22 Feb 2024 15:19:13 +0000
Message-ID: <CAD4GDZwCQGX3guJUi-WsegTw7-EyEjEiM0mCvNRtFwJaCLLaeg@mail.gmail.com>
Subject: Re: [patch net-next v3 3/3] tools: ynl: allow user to pass enum
 string instead of scalar value
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 13:44, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> During decoding of messages coming from kernel, attribute values are
> converted to enum names in case the attribute type is enum of bitfield32.
>
> However, when user constructs json message, he has to pass plain scalar
> values. See "state" "selector" and "value" attributes in following
> examples:
>
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-set --json '{"id": 0, "parent-device": {"parent-id": 0, "state": 1}}'
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do port-set --json '{"bus-name": "pci", "dev-name": "0000:08:00.1", "port-index": 98304, "port-function": {"caps": {"selector": 1, "value": 1 }}}'
>
> Allow user to pass strings containing enum names, convert them to scalar
> values to be encoded into Netlink message:
>
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-set --json '{"id": 0, "parent-device": {"parent-id": 0, "state": "connected"}}'
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do port-set --json '{"bus-name": "pci", "dev-name": "0000:08:00.1", "port-index": 98304, "port-function": {"caps": {"selector": ["roce-bit"], "value": ["roce-bit"] }}}'
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

