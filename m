Return-Path: <netdev+bounces-167587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42462A3AF8D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF597A3BC9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF02AE6C;
	Wed, 19 Feb 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUeuL8sm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2731AAC4
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931847; cv=none; b=P/jogW16QI08uUAgyiAZCgOYO1FLz6wI4pHW6M/pCsPYDWCwCWHBf6JoGYfF3flHtuZuyE42LnYoTHGJYmrQgQr7b1/z+JYUGqbNiymWcmZbcPCGaDBC+ExWX1LYOSGm2IGnSqkgekFOPr6vlSGg8VYjw4z0IsZtutfiOe+OM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931847; c=relaxed/simple;
	bh=eHixGNnLfwpaeHptz4nU1pzNVqA8UZq4y6obJenpGtI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=szRnUfXvZYdrlQvyr44So22C+wHSAv2Y2O3/KxoiAJ+uXVKdfyvQDlrtiUe9DkY17BuSixG9u5ia7V9BUsrv2QKie/uX4dDNoNX65Wufb+CAhCDkf7e0Ftx5Im1hsCyegzqGyO66cWKtlhOTrxZjFZOFroV92uE60YvCsRcAFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUeuL8sm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08f9d0ef3so179734285a.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739931845; x=1740536645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AuTAADTlLmSqVPnDOmBI0Yua6HrHqxEKIiMnLLR+OQ=;
        b=CUeuL8sm2ayqNqAcpLIhmYvYN2JdS5Zzk3l67kuYvZCt+KQiwbowbh97714nL96tX2
         umlh2qaE1R4xK8A2y8CA9siO3TwmzXTzML/QaJ6vIUGTha7SAcRcYDVCuuIhyNDKLOOd
         d7GPjN7LC24lb9mXzaQcvOBcIaQrp4OMhU/H3OiAeF9tX82+dY9PCQBCSjQ76QX/QGzP
         mpwP9Cra64sM7U+lhaJ4QvzFgSFvGqA/0zwhLuF0aSYs0xlG/CdJMyZdNC1rb9WPuFt1
         H5BVYIv6fZAyL+sX8omjHOGrp2jaD0CktuqKCwokE+fLcuTQZROGVxHWrZvYT+e4QxMC
         4sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739931845; x=1740536645;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1AuTAADTlLmSqVPnDOmBI0Yua6HrHqxEKIiMnLLR+OQ=;
        b=TSIAGqDBfb1hM+HO2ixGDEvFXxTw2HZDBkaOhCe5ZqzjQNcgLPG5J3zxWxWnXrbSdU
         JNqsXdePjK1UXFZD3U1wttY5K7s32WDbMslP07nIOhiVr9gpsbOILFt05SHzt2Fw7B4H
         yqwmMHKsJ86q8fOZ0wV5thSO+S4h/CoMFwAKhFpStZfL2/KSYSVqSzkdqzoJdPKXDcBf
         mDOAcH4CiWgbK7OzlP9vPiOKUsz4zOj7WcaME4suFGKh2eiRY7rsO7feEDK7Wlkf2gAt
         RvmYRJ7e1AOeytSXhzm1IKZHLJHInrYTvQw5/9UCTnWaUHju+mYFLqGRpadydtOLTSgf
         IzEg==
X-Gm-Message-State: AOJu0YyjhUQa8cpjJoRaLoSPE5aDarYg6EW+mecK3f9BP1aO3xixcLAj
	rk/pMCik9wp4GJbZ77pz3pPwDhLUVqQcNWiNwV7gJwhIeqauhBZP
X-Gm-Gg: ASbGncuN2olqZ+YtobbK11lX6TsyINtCzkvPsYE6mY04AGmBAIIMZ7KVJ7FIYMTS70d
	yp8Feo+hbteaXjJB5XuAVSeV1rwlTxtARujM3z9OzI4wYYJKLNs0prd1OLGmsp7FMQMHZlho9tf
	qrT+17CCaacKPYMzHftFMH4GHOO+vmwCiv24jcpSkQa42iQfQIQLyyOCGxj3Z6Z7+2j5zOgRdms
	fqIKj4L4zttmIQ13BEF0U3JE79nEkOQdSZ194PIUkbh3/+NwIUWTJgZqPWr4s5eaOfAFWHPyiAj
	Hkax0EBAWnimY2uqyizOmjJBj/ChRO3XvaGoDs9tLfg0aoNSTzaxjg7/SZfJJHE=
X-Google-Smtp-Source: AGHT+IEKdrtUpJ1/eLSXBRJ7Keo74ORdEPyBAYEsUlmoWHiNTzT3CaFV1s22uBEDFVw3TMg24/41CQ==
X-Received: by 2002:a05:620a:801c:b0:7c0:8175:3656 with SMTP id af79cd13be357-7c0b5285d84mr304411385a.32.1739931844947;
        Tue, 18 Feb 2025 18:24:04 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad3e87b6sm156562385a.42.2025.02.18.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:24:03 -0800 (PST)
Date: Tue, 18 Feb 2025 21:24:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 gal@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b540c2c1057_1692112944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218225426.77726-4-kuba@kernel.org>
References: <20250218225426.77726-1-kuba@kernel.org>
 <20250218225426.77726-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v4 3/4] selftests: drv-net: store addresses in
 dict indexed by ipver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Looks like more and more tests want to iterate over IP version,
> run the same test over ipv4 and ipv6. The current naming of
> members in the env class makes it a bit awkward, we have
> separate members for ipv4 and ipv6 parameters.
> 
> Store the parameters inside dicts, so that tests can easily
> index them with ip version.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

