Return-Path: <netdev+bounces-64206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F94831BF5
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55CBB22311
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D5B652;
	Thu, 18 Jan 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNYT8fbP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7F1DA35
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590418; cv=none; b=K++GcnTuI4bjpA2/vg1HUKBLvXeERjYJ/wspHd/O05SPGBGiTZcCDRhmWdZEdLNE33cup2XPnRsUsWEQ15m6FeQb+zg5Dnmc014n5aecby/woS62PmuYYNNT7uMOIT8ERBV6uWYW26FWeWFpfFTSIygCJT7A/1PY78J5rysAuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590418; c=relaxed/simple;
	bh=6TJ0nVPtSD7ULjk7DDBMKsEu3Yt9tYCP6Tybo0ZlLFU=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=nUw1lQuDRZc7dlQrQPZCPpuHFwnKJg4j8YCl970rBbAomD6R7MgWgCpRsiT9ZVhmkV1h3Q1pzQukGr0UnhaPv7YHodXISUWrJfg2kFt+xdx/A3RYJtbvmoRGxEVxCaqrMA+CYYeGALwasGZgBwmtye7UadcJ+pV7FLGdJhECzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNYT8fbP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705590415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N2RBLL8JzqBfYD52SS29LcZxgb8wKFDcMuLxF6/LG2o=;
	b=DNYT8fbPdooV9/9sFWA7MixzFboQ6vANy4iaByC9+YYqpeIGcJ28v4znlp8JxWN33/gjtr
	2OTCdxF4k7Fo+mb6tSvy8/ht+ntL9xpEtSIbVDg1X2S3Leo9DjoB5cNoJ465B02/jc4KP4
	xOvolPosVQ0JiMbpMDnUk233Gqp7H+k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-wZtNJRq8OFmcx7MGuYELwg-1; Thu, 18 Jan 2024 10:06:54 -0500
X-MC-Unique: wZtNJRq8OFmcx7MGuYELwg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42a0334713dso7792521cf.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590413; x=1706195213;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2RBLL8JzqBfYD52SS29LcZxgb8wKFDcMuLxF6/LG2o=;
        b=M2rNOaZ5WCfOCe8o1NwgHO00smU/eVKOFzfnXV7VNC1Rk6QYGgl6QiFzgnYr/TsLKP
         GEyYRq7boUYasDdTMlG4mBSRaWT0GET8YR/BOFKvDfsYNDFhwUhN5AWn71eXKdS7mAGS
         Vci4GXGueoorI9bWZ9wdrKUKgAvUPMf2Eu5u7Ex+Foph/hcQeaW+2Q05v6Xz4Lf7XSdN
         yo42IVcGMiJ4MK5XiFF62DgOw3aRaqdO3X6KAuMJJRPIL7s56xIoTWQLzIli4S5vDler
         ACWvE8NcO63rVffCf8bM1KI8yF5bba3s04r7uNueCBvaqSeTA7b27hck/518QVgy9CQF
         vm+w==
X-Gm-Message-State: AOJu0YyFomcof3hkfhQqnMbrN4WI4FAJMAr/XGQlTEvKb249GUPVRUHA
	aqm+cRzWA2j5ccxaILbdUJq8Pr1NOA3RSqtkbM9ENh+bqzhAA77bN68t7BLZMvfiwYLky83X3Ex
	aHXh5hq1sEISUzyRY3P6qaz5I7cuAD6g9308iBWeKuaA0IkRX9DfYXw==
X-Received: by 2002:a05:622a:1a22:b0:429:d914:d3a7 with SMTP id f34-20020a05622a1a2200b00429d914d3a7mr1880628qtb.2.1705590413528;
        Thu, 18 Jan 2024 07:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKhHGnTIiB9sz8uzhNJbQtsROSDKgK4PtUFMkBKMn95D8ejJktMLp4xOc5ab0hwjQkH3iRsw==
X-Received: by 2002:a05:622a:1a22:b0:429:d914:d3a7 with SMTP id f34-20020a05622a1a2200b00429d914d3a7mr1880598qtb.2.1705590413138;
        Thu, 18 Jan 2024 07:06:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id y4-20020a37e304000000b007834e855ebesm4215664qki.14.2024.01.18.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:06:52 -0800 (PST)
Message-ID: <1ffdc2fe1956a44ff95f1dd57982836978f3a4e1.camel@redhat.com>
Subject: Re: [PATCH net 0/6] mlxsw: Miscellaneous fixes
From: Paolo Abeni <pabeni@redhat.com>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Danielle Ratson
 <danieller@nvidia.com>,  Amit Cohen <amcohen@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, mlxsw@nvidia.com
Date: Thu, 18 Jan 2024 16:06:49 +0100
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 16:04 +0100, Petr Machata wrote:
> This patchset is a bric-a-brac of fixes for bugs impacting mlxsw.
>=20
> - Patches #1 and #2 fix issues in ACL handling error paths.
> - Patch #3 fixes stack corruption in ACL code that a recent FW update
>   has uncovered.
>=20
> - Patch #4 fixes an issue in handling of IPIP next hops.
>=20
> - Patch #5 fixes a typo in a the qos_pfc selftest
> - Patch #6 fixes the same selftest to work with 8-lane ports.
>=20
> Amit Cohen (3):
>   mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
>   selftests: mlxsw: qos_pfc: Remove wrong description
>   selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes
>=20
> Ido Schimmel (2):
>   mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
>   mlxsw: spectrum_acl_tcam: Fix stack corruption
>=20
> Petr Machata (1):
>   mlxsw: spectrum_router: Register netdevice notifier before nexthop
>=20
>  .../mellanox/mlxsw/spectrum_acl_erp.c         |   8 +-
>  .../mellanox/mlxsw/spectrum_acl_tcam.c        |   6 +-
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |  24 ++--
>  .../selftests/drivers/net/mlxsw/qos_pfc.sh    |  19 +++-
>  .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 106 +++++++++++++++++-
>  5 files changed, 143 insertions(+), 20 deletions(-)

LGTM, but still a bit too fresh to be merged right now.

Acked-by: Paolo Abeni <pabeni@redhat.com>


