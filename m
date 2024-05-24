Return-Path: <netdev+bounces-98022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FF8CE96D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488551C20A84
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402843BBED;
	Fri, 24 May 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5BObF1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B43BBD9
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575010; cv=none; b=dGxZyXbKCLQTCtQHUCIYpTOAJ9o7broA2EoSs6ZDUN9a7m2auRDuadXAlI8pSaDoCJ1dZe/iip86Ck9pJQxn/EPU0qvIWt7f1XbqmNVGzYbf0I1Y1N1tI+Bl7fbnkoxbMG4QjMRz88zifp+wkUjklKE8RHnCSVZdscq/V5cgj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575010; c=relaxed/simple;
	bh=ssaZ2ZvQLO2+x5T1AnbVNh8qvDSMflzkHf9RSXN9t7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mu4SxZj55DU9oPhZY+RyLEH4I96mJKf3zeAguPHgTD5btQDTp+iH95L5iAvTDlpS0Yz6CNm6czZtXNJWNpoSVKqRWx5+EoTqQ9X6OwigYA9eVSkKh3UGXLUW7q48QXJVMH9E9Rmi6KXcjd6V3zonLEDduUR/eUBP52z/7YvvSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5BObF1N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2bf5bb2a414so1151924a91.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716575008; x=1717179808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAohSQ62YVirLGMyGzfikcZH1eASapmzNWEJeAHAMIA=;
        b=X5BObF1NxsgwRyZUMc93SiZ01l/yY/SpIGfivOLmUMtgGnXEAEmAnCUeLiNET//BMi
         qqSbU5SGf+J8q9N2iXSgxi2sRKPju6PryXUzYYDCmufWVy5t7pIY8AbE886bgQuJHtPu
         CeYpj7kRS9J6WXRzGWAjra2WlpUMLHss7Pfsz4bO5bG/bsU+ZV6FBb6DOMLf9pJVieGJ
         FrTo1uzhk10kwg4shXLqCsjoBocVxddW7EU032pYObwPVaIHxF9RSjConOOjmbz4O4Hm
         Za8kmOm3hfbv3Vil/FpxEnQ7y+1+tHHXO+LFnkbiN18+rsYveImAOfmXjvGdO9jkcIoL
         JfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575008; x=1717179808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAohSQ62YVirLGMyGzfikcZH1eASapmzNWEJeAHAMIA=;
        b=hxsHD+MOXtaeJy/Uxe3t0VMad8b02evqNGb5BPyoSOEA1iW2pz0ZQB/7LsKmq7WEnI
         xHqkGRNmFRVczsopeFEPslwUDJ0pGDaT0tZIUYo7qpX65qwSvJaFp/qhAO/Vmktt0sxr
         8mOuYHYxw9ErDW93TZ1L6fGOMw1vswaQ3pfbBnv4Img/kVlWRH23H0zqPj3B64hy9xZZ
         fU4+ugvwSUFxu8nMbJqjkFIX1kcG+/sCvSxT7vMQdjsCmfJM2Yvr+TdpzJYO4dMXmLdX
         QtDGJo0FxaFu9nnFoHrzhFUkMDM5tcuok/87zBXAYNatpuk98iae8NUFx7Fqq3KINVcN
         e9OA==
X-Forwarded-Encrypted: i=1; AJvYcCWcrp6Q4JpB9JuN72RJ74URfnCHFqtGl9QL63f2lQ8BoRwtJKqsR1m6nJhwVKMPYBYFWG5VXFTsO8br9hVvnqNllg1OsKvw
X-Gm-Message-State: AOJu0YzGrfp1uDiiXF11DIXUuFo5XeBk/CW2GxC+PCaz8dLNwzBj9GX0
	3OoNC8BFGlZotUYmrgowt40RBqtRDyEN1SQF31k7Wdhb0VsiUQhhSQeT5sqTZdvoxQ==
X-Google-Smtp-Source: AGHT+IHzDvKhdXYqjAO0NqxWnqhEY3Nbf+Yi1HEclwUlPxnuo1q7VEycBUlP7Lw6z9KNCM7cruACNwc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:ec09:b0:2bd:e2fd:a084 with SMTP id
 98e67ed59e1d1-2bf5f407ca9mr7606a91.6.1716575008161; Fri, 24 May 2024 11:23:28
 -0700 (PDT)
Date: Fri, 24 May 2024 11:23:26 -0700
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524163619.26001-1-daniel@iogearbox.net>
Message-ID: <ZlDa3Wk0djxSd2AW@google.com>
Subject: Re: [PATCH bpf v2 1/4] netkit: Fix setting mac address in l2 mode
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, razor@blackwall.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 05/24, Daniel Borkmann wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that it is expected to be able to specify a custom MAC address for
> the devices, in particular, cilium-cni obtains the specified MAC address
> by querying the endpoint and sets the MAC address of the interface inside
> the Pod. Thus, fix the missing support in netkit for L2 mode.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

For the series:

Acked-by: Stanislav Fomichev <sdf@google.com>

