Return-Path: <netdev+bounces-237812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD82C50809
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0495E1899E72
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968692641FC;
	Wed, 12 Nov 2025 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSHRxYl4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531033985
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921485; cv=none; b=qUwb70V8TekSoLiViQIt/HK3u24MkWm2+a689DT+zKpai8oCQz1crU4+yi6ismb9V8UPt28JkjL1utWRr/cCgp2dAtrz2XsuEnWw0vqIQHc6/vW6GExHJ2F2XXcUHq4St8Ypu5PEOW1rwWpS1AwU3fbImjKouBsSL75K48SXjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921485; c=relaxed/simple;
	bh=/tllHra8RRTKbmOxeehAy1pOyA9ktXWH/rK7QCPRF5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+R1IoZoVoNJxmM+TxjPc0WEOyuYHMAIzfvufhzZWjuwkYbgqX/DNixE+FYqPm/OLIHEcC0mi+6EyuFUt0cMuoglSuvS2aiUIsckpm5oeSJR2akGFCR1zX6Cd3eH10xNH1YjlmKF9Ah/5t/5fVB8NkP2nhmDILLqpnXScff+Ss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSHRxYl4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2953ad5517dso4313345ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921483; x=1763526283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tllHra8RRTKbmOxeehAy1pOyA9ktXWH/rK7QCPRF5w=;
        b=hSHRxYl4dV2Twd2Mb7hW7j1mbzGPwQqx/p869aAk6uIG5SsHkSIDsSI1WoJA+rU8hM
         YVBxMRM2He0MhWx436XIzgnv3BeSZ/Dig29ZcAZmArl9bwDAAU4egG4vdI3K+U7fp6Uv
         /4FJ5ik1ocToBF+pkvGNIaZvqHHaaJSsIMk+ZGi96TEOjjyQZc5PwcywcX0KSBKFusab
         IYlSwDpxjBE+Z54W3530o/Z5vx9ZH+zG59V8hfV+d3znPHX/dEWSozFl5TKkqC/JAnJ+
         mgMWYfppIfkQJQvwgQfRkqGjfDAVFgYKd0btxe8KX2VizFM7xzKg+ud139PXhl12FvkG
         YoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921483; x=1763526283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tllHra8RRTKbmOxeehAy1pOyA9ktXWH/rK7QCPRF5w=;
        b=f43liOUCICxkZR11w9BWQPDcjHgs5UAAAetCwXFrRmWmazZv4BVR9lP8oFxAaXRL73
         yPQKvqz7Dfv538hEcS65uEKvgBpzFQbqFwDUmkMmyZKJDW4Cs8A2TGs6bZf/gDS0cDn/
         hxOespJiJnAG1HABVoFoWoBIDNvQ1MzfHnVAJmfkuhK3Kbkh3WoA1vLWv/pn7/sg5XFg
         txlMVib5i7kWE2UTfH+bzWCnd27WUAKU6D3NAmTf9Bo4iC0U1Pmcaxrb5Ul76bluxJx7
         r0f67HJcwW+X01SoE6ht9u8aliVMWW2z9DTm+19wIK5PxIblsz0mU4pFy8UGZSI48YOR
         HyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2m5VYGM/bFAPPzrj2NiaB6cIOMLRktnWfPvmmlrG/jQ/tnagTJY/NYrwTf38agQyqZTIQP8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3osJbq386dh1Pvv9TEUfdK7p7u7i8Aq3V1E14+ArAFynzLlH
	x5dRam3DViKem6q0OMDB3e4aucL3A+xtxJlQ/GzhGJV1Ilf4W8dGHdbpBk2A6j8Zziph/ryatuE
	3GKYaZXZJbXbYayPnQ3G+L6IZjEzUsew=
X-Gm-Gg: ASbGnctOFdWKQZu6YGPTe3Zdb2fiZacLAXpp+ATOkwsj9HVmzrJRYaLN/HFckocYF2r
	bIL3XYLnNXHm3Ou9gbyRoLyhzpVIbQ3yni/sCZorFF04A271eghFhrf0cYBemDpHsFxJcGd9iQl
	uIfl+XJwtdQWXdAqXNSzzQLj/vOKYFEl/TpVNW6rBUxDXOkv2PBy7YCdeXmF0BE2jOHwZPUJKYr
	FjvLpH5CKM0zhDqYhF0rzNa9D1JeZmTZXNeAO587nXi8HeSWKCMq2fGk36L
X-Google-Smtp-Source: AGHT+IEMY5walP11w+yvSjwgCuSr2muuH/0M8k5N6FChDDBt+NJeUcUYAAv/OpAFX60+4DrNMH0vl4m1b1r3O3FhFHA=
X-Received: by 2002:a17:902:ef43:b0:295:223b:cdee with SMTP id
 d9443c01a7336-2984ed9245cmr22894845ad.14.1762921483348; Tue, 11 Nov 2025
 20:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110195030.2248235-1-kriish.sharma2006@gmail.com> <20251111174234.53be1a97@kernel.org>
In-Reply-To: <20251111174234.53be1a97@kernel.org>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Wed, 12 Nov 2025 09:54:32 +0530
X-Gm-Features: AWmQ_bljjco1_GK9xQfpMqsy_ZLU3apLeOjSMgxTOwfwiucVSIgUq2JPJmQyM1Q
Message-ID: <CAL4kbRPWAfH6AXjsXtwugtpGaH-Omc3uNmtzacFOt1CUqNNWbg@mail.gmail.com>
Subject: Re: [PATCH] dpll: zl3073x: fix kernel-doc name and missing parameter
 in fw.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> What do you mean by "documentation build"? make htmldocs?

Yes, I ran make htmldocs , which triggered the kernel-doc warnings.

> This now makes the kernel-doc script realize that the return value is
> not documented. Please also add a : after the Returns on the last line

Thanks for the review, Jakub.
I=E2=80=99ll add the missing colon after =E2=80=9CReturns=E2=80=9D in the k=
ernel-doc comment
and send a v2 shortly.

