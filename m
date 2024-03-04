Return-Path: <netdev+bounces-77180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF068706E3
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A141B1C20962
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D747A6C;
	Mon,  4 Mar 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBFMkmdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88973BE4C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569285; cv=none; b=eUFQKHsFkrUB5gTy605wZ5iZtd4VDXxgF3RDJ5OA6sBPVwrSm4mNOJNDB1cAkYpuos/WMIqviG+6WUTzhHcQJcJbVNo54Py6doMo7Q0ea8YCJAAyXf99W/qdHLbz79WURCH7o87eX4n58LbJj2kAvrl50JJEJfojIXRNu5BYuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569285; c=relaxed/simple;
	bh=wJLhuxpWGzu9VKI5XsTzTTOu//qGDyFb9WwZNvkqgyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqKWCEh3DAQRTAiTA6BHJcyyVw6S9kkKF4bDPPTOVBe/ORNRvbwUAwP95Yp3lLDgZ+VurcxTuOxiOr9tb9te4WrQIDeFer7ff1tUjIrc1hOxQu5YgnGMGS31qMK8W0Ok3/aQrT+B25d3bqcwcQnbOdsYhs3/N2mHidS9SvAHCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBFMkmdZ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-220ef791617so1128810fac.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709569282; x=1710174082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2z+DSH2/uRoAhaWivlYqQrOAdsEVPYzvUouJQu41qM=;
        b=mBFMkmdZ1SqklaP4zH2MfSJuPuEv8/xyP0sInH8zDKKdDroUvGJ0EwRSsd1sBwus5a
         KrpKh37d5NJSEBc43LT51/c7Sgw5Zx33SoenZgsiidtis/tm4CZPUNxaKBnL+u/XSQ3V
         asT0OoLWXELxcRkVhuRnF2tRDc6uuV+W9UlCx/3KSVPHVO8Bs+wv/mjrhRTJtCKCwNC/
         QYxeXfAGuO98VwGVSaGTuu0CU3mw2q+8/MlQ6jo/PyqOzWEncUHH20eElgu9AiHv1r/r
         CMqv2x93D+d/b8RiVpm2qQzM8go3/r8jSA1eRSHEljVlrWDp0pK9qLoghvhTWQ4yX2HF
         aUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569282; x=1710174082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2z+DSH2/uRoAhaWivlYqQrOAdsEVPYzvUouJQu41qM=;
        b=iPk0mhJVTCHvbUcuZdEqp4u2OpYvSz4IGcxGsdysm2Pscg8Xr9PLlQ0UOW40LmeDw1
         MTqKnOYyBKtgDi8X6O+uoTo2EHVdRT0k98V2ELuNhBbcWVfIbJrwBhwaiX7/yVNs5M2W
         S2uaWQDn36ElX1gm9NS8jijacHNwQQRNdeZUEPbuOFACef+H9dixMXhJ3CmLb7M8Wxd0
         q7J7TIbUhZNSy9rWNqKD8Be4iOo1Au1cqr/BbintHrDcucy+FHug+e004pZX5ZgOi4tQ
         YCEHMI78Nlqm12zy485ZdCr0eoDDBA54P45mSsYz+d66kWtDsNkJ+ymAlYGcWd80EcHo
         cd7w==
X-Gm-Message-State: AOJu0Yw5x/1i65a4NsgxCiHAMvDCjpKWiXTN3ANcZQViOPuC/9SHwldA
	Zql229nGdCwOE+fYPOyCQQ+0N/oebv13Y+7Dpj2ifhDF5BI4HKWlIEKBXaRFoaV0huJ5gh5Rkpm
	24ofNgfeEe7Sh4offayRiPaY/Ae4=
X-Google-Smtp-Source: AGHT+IGWxFxzt48b933aAguKpG/MO2KZs+I/Qx7oCkrYrcoY1lM7WeqgamJMDN825XwjkR/sYWTtocT6bPsRK1yek28=
X-Received: by 2002:a05:6870:a18d:b0:220:847a:14e2 with SMTP id
 a13-20020a056870a18d00b00220847a14e2mr10689713oaf.46.1709569282595; Mon, 04
 Mar 2024 08:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301171431.65892-1-donald.hunter@gmail.com>
 <20240301171431.65892-4-donald.hunter@gmail.com> <20240302200536.511a5078@kernel.org>
 <CAD4GDZwHXNM++G3xDgD_xFk1mHgxr+Bw35uJuDFG+iOchynPqw@mail.gmail.com> <20240304072231.6f21159e@kernel.org>
In-Reply-To: <20240304072231.6f21159e@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 4 Mar 2024 16:21:11 +0000
Message-ID: <CAD4GDZxP1VwOw2uTtZH27oEx8jooR1a9jrM88Pg2MLk+T1aQ7w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for
 multi level nesting
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 15:22, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Yeah.. look at the example I used for type-value :)
>
> https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#type-value

Apologies, I totally missed this. Is the intended usage something like this:

      -
        name: policy
        type: nest-type-value
        type-value: [ policy-id, attr-id ]
        nested-attributes: policy-attrs

> YAML specs describe information on how to parse data YNL doesn't have
> to understand, just format correctly. The base level of netlink
> processing, applicable to all families, is a different story.
> I think hand-coding that is more than okay. The goal is not to express
> everything in YAML but to avoid duplicated work per family, if that
> makes sense.

Okay, I can go ahead and hard-code the policy attr decoding for extack messages.

