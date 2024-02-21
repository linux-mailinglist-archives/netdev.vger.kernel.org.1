Return-Path: <netdev+bounces-73779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E236285E552
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A12839F3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B1585261;
	Wed, 21 Feb 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKVGS3F7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709B42A8B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539312; cv=none; b=G892pi03GVwipSWQZYN16zkv2C+0gUEt9lZ89x6cUjqDBNFj8Ylf8pmGBK3x0uzuJ3ybz7iobZnVifa7wHnTi0jABU4DGWiHIqTuHDwT6KZDzWCs81xjaKgJPIG1xB2m/2XgoC0WxKmbhIQvCwKyREaWP6Qdid+UfMMIo2ce2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539312; c=relaxed/simple;
	bh=RmcFLeHl7HfDkogBM5T7IDqcnGg14lRaslWi8venEzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuJuvVwX2Aaq35lvVaoiEzP2I5Br5drcwKhqTq3/lNiFhO3xfVGTbh8itBrREHH9UkBAqpwh1T3LQpkVATRxYj+Ogf415WhOot++ChY/iV3tD9wwNJpkwkbcjKuk3fYCogAZRdzS7FbpAWqqlJ/u8WD1aob3eBaU6+XFlLLb/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKVGS3F7; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-206689895bfso4361819fac.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539310; x=1709144110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmcFLeHl7HfDkogBM5T7IDqcnGg14lRaslWi8venEzk=;
        b=VKVGS3F7P1b4Ch+X2F0IhGHtIGvgz3ldqhk4TjaubRXdWI5b9WcK/9VTHiPPWH06Nq
         BrDtG3+137tcuQIRMn5cSMEVHFT2ArzG2KNgMQqmLA2FOrH+leP7ZSd5rhD7rPUzsqmZ
         TzlHs7kAKXhff+/yS37sR0cg0Ku43nu9E0vwtM/Kx4/RISIyPkJNOptlbgOEWo9vpRAw
         2Ibk64Efh5vVbKobdWa6QfNcy0kmi3nwxglHgktfPG8U6t/zBVq4hj6uG41If9kmNBof
         9jK5jAIl++1hMOCDSEasNWCTJfGoPlZXB+fklgVK8AYwIRmYbmDUrpWI7jvIUQKfGHHP
         PrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539310; x=1709144110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmcFLeHl7HfDkogBM5T7IDqcnGg14lRaslWi8venEzk=;
        b=LZTFkfoDiiwuZKIIdVyehw6S4aEeEJO49xWvaROTJdrrCb8rgTPjsrrIn6VREqHps0
         FQIaIVOhrI47DSv12Hzjbp9HTSCKMG/yfAkMeAeAQ0F4jDTGUnaY6doVAcZ/0HvG6lLr
         YLds5A16c03wIQG2tqt/hC/JbSMLGp9xFgXqpC83Yrz/m4i04NbJ04xRL8XR7BRfQDrP
         myf2N5mlRwKwMwXwj82Xe0KmeCZ1VUvjeEWuK40vnpjyGOP+09WeozRi9xuILntaMRFZ
         GU3LEakc9lTSdDsrY/+whuvDUoJyvgO4JfJGdqj0+uWvMz75al60BQWxYBCnxNToC9Du
         yhww==
X-Gm-Message-State: AOJu0YzPMqoNvjxnX4+oQo4JnM2IhEjsniJTqa22ttdYfGdmf7HztZj4
	jVO3o2PkiR9F49jo8shBh+BhWmIMKqm+6YcQQlSIBdIwHb9znRNkNWxDusracNidauAXfrJPvEi
	+ul1ni5p1plstOFmu+AZz7hdk/hs=
X-Google-Smtp-Source: AGHT+IFsDKJPcGOvLwMwq+QwuiIW6N2A2igZH2arDOM2nksGdP24OLRTOSODsz7z2bV8oLKk4U3ydkinuU0YjQNNtik=
X-Received: by 2002:a05:6870:ac1f:b0:21e:7ad8:dce8 with SMTP id
 kw31-20020a056870ac1f00b0021e7ad8dce8mr14818557oab.23.1708539308664; Wed, 21
 Feb 2024 10:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221155415.158174-1-jiri@resnulli.us> <20240221155415.158174-4-jiri@resnulli.us>
In-Reply-To: <20240221155415.158174-4-jiri@resnulli.us>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 21 Feb 2024 18:14:57 +0000
Message-ID: <CAD4GDZxhVs6hmYGR7+6u1TOa0JMF_89VnOjobUAdgM6yU9Z4VA@mail.gmail.com>
Subject: Re: [patch net-next v2 3/3] tools: ynl: allow user to pass enum
 string instead of scalar value
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:54, Jiri Pirko <jiri@resnulli.us> wrote:
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

