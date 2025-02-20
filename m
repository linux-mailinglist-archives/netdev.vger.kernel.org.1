Return-Path: <netdev+bounces-168139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA91A3DAEC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AA318996CB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0741F76A8;
	Thu, 20 Feb 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5uS8/qG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA331F584A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057040; cv=none; b=L+PWn7Fxe8gR+tbYiY6CCygzsRlh+zmseiJ94uLUQB8zfWH/TbAjK++KDvOhWXhDFQB5yy/fQ5LzKrcSMGto/rhUJ263coiyWUoLMUv5Qlt76Opq4qXT0m+5Gu7Hnc6sok5qYbSdR7RUGRk3CaVmfhiRLWW2RcjpSM6cGVp27hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057040; c=relaxed/simple;
	bh=QYsSw+flWPb/XypP/4ps0OqqUsuT+gRfcujoFFzAAiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evzpjBOQRE/HDCieCA2p8yEcniqSLb/z9MwLUREgaf9oQam0Y1k4O6CsLgh2i0oxALBG73W7g+vX3WRc+4cMUCA8y460cXj32/MK1AZrRcru0o6xtzfXMdFIgA4fexA0WdYb75WUWHlxYcH7e5BhvVbxOXnyNe19PcPUth0p+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5uS8/qG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so9217a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740057037; x=1740661837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYsSw+flWPb/XypP/4ps0OqqUsuT+gRfcujoFFzAAiM=;
        b=T5uS8/qGz1CmrxX763gDPf3OIX9/4ZdRjxgJZbZWTYl6bLZCME5+RpNztHJhoSoj8V
         1zgB7nhDVp/nMXU6avvtysEd2o4D/ZuhbK82496EUUJq4nO9Oa6MPgbdPFDemo8gySSq
         vXutFAWvwiQ2XbfgWB7pQU00BLTWgcefhLp6s0LMQhRIjFU1sJ54QQ0zFXyj/X3vqCGQ
         nRZhW2qnAUWr6HvCeEXDevn3YgtbF/4OfVLhh/0PxXN1p3l5SFLim37aAxugoTbP/zC1
         EnM3Uepby/4dDOcLbdj+6RtJZx5IerJWPvGkg1OLNci7SL9FPgo9IpnPnomIDI4ecw5m
         LIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057037; x=1740661837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYsSw+flWPb/XypP/4ps0OqqUsuT+gRfcujoFFzAAiM=;
        b=FSuTNyIWmfBgBrkoayyvGM1QBRlWmMHiK30oFUwr2JmDVlc2qNTM7cs2zinkuNFYWQ
         x290byAdLM6oKpndkaHMwXNPKy73GPZlLBkEYSr9qBXvEF9huNc+V6iR8ZniCYucgmnJ
         VuHv12smslsarNyiZOj/UMn8AS3XZRFfFZTkw7CnRX2TQYUcDajjXtI6xjI7OrKMjp49
         AIeEZGzNgLkNuc7cFPnAR1K8Zmz5lVGkY87EkHsR1z57D/nMBRWBjyBhMQ9Gcegm9O3y
         dPkh5C2MqsXl0Pn1XGcqMOR4DWHmRg931/K1ONyzjB8dJHYSKbhRHkusCGwwsz90WYym
         LSig==
X-Forwarded-Encrypted: i=1; AJvYcCWKY2SLhI6Ml7FYNcIiqFhULfJ2pPLxukCBfx1Ws3qvMzTZGZgmoVFlIYXmXNEMaXUzLJ6eB1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dDEVoyiiSnu8vIZAsdq17MuTOhD7Yz7fo4R6VgeUDDn2emMu
	PRc4C/yDHbLQgsTW4KwOkEDSx9sarDp6WvfAawHAcxZMWBWpnAIdy2TJgv2hB9Shq8+aMqHCX5s
	K91IPbpMBK263ndCkxjn6cKFVAQw+uJGs2EEd
X-Gm-Gg: ASbGncuFhOeNwfNXf90bc2oCLvwvZ+wm1dmV6mKMQl2aquL9uDbSvnoWDqHeWr+bBKn
	aWiPcU1JkH8y4hVXf3J0xP5EGd24BlGpRufLuiBpHWmdNcZ6ri+xfwI4PExlMPIVaHmX4Zsc5fm
	23k5rcIPkcKvi1cubPorV38IACychplQ==
X-Google-Smtp-Source: AGHT+IFQUimq4C64r7AXRpR94GstIGlhMvNAvLyciN0TAGSzjli3D56Lo1KaIwQaz8ozbfED2rjUEOtwjX1bACxhPvY=
X-Received: by 2002:a05:6402:3488:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e0360a781cmr22502038a12.13.1740057036855; Thu, 20 Feb 2025
 05:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com> <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
In-Reply-To: <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 14:10:25 +0100
X-Gm-Features: AWEUYZnvDrmz6WrdC3BpeEAy4esiyp5n_19tTqYxbq7z0e9bJLWLCahCCbEXlcA
Message-ID: <CANn89iLkbgLNXZSrko0uW0XVkm+Y-9McU7cA6d0gioHBHwKB7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: advertise 'netns local' property via netlink
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:03=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL =
to
> dev->netns_local"), there is no way to see if the netns_local property is
> set on a device. Let's add a netlink attribute to advertise it.
>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

