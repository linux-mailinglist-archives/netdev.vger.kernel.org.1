Return-Path: <netdev+bounces-129287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731D97EB14
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D41528178C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABBE197A7B;
	Mon, 23 Sep 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YateBYjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FDE433D6
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092372; cv=none; b=TUCqO5/hHaJC0gCDD8J4FdINKe3oxCyTEyfg5nQQKSXBxRcf0tL/67aSNXZlAKalMKYYbdgqAN1YKbId47vgXxc2rL6pyS7trPjsKWsPg/WY0t0Oz+Xe1dPHebSrXkZkmpi6DysrPhj6X06k0Ekajm2TkEuUBp6SmIQrCbH/X/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092372; c=relaxed/simple;
	bh=HZTG+GQe52jS6g5Tcq06PZcX/VJwn6XsB9avf7KWn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9Xs/rOtQ/eoiFO22HsFpezjlfcYqrTZyA6Qi/AL8CSqaw4pDQqsfyXvenn8nA4e3uPP0idlvZoOzXydld57e98PVy980L09fLKfDFzS6D/u/a10B5cSOQvdeCMMoJeHcZezBeZW7Id8W8ific6ctbK5+hVRYPJbEu6jdITlvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YateBYjH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e201f146cc8so3772696276.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727092370; x=1727697170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=YateBYjHOHSWxRV1t2MxnJmlOFpCzBtukb9MpkAGPlTCRIZQvfoGWiS3m6FohcDJWF
         dGRm/mIlTTBk+M8bFRrObWfaEHIDkgnyqSUizo0FPvAWKEXXcyhqaCMX2kQakPK3i+kQ
         O/AzsbRZRrmSMcYBSMnx/MewVH5EvR9m6Y1Q+wuEGCk9fJDzyyU1WLlP1bd7dr2oMzqU
         l9lrbLJPWLV0SdbU+3K5ACxNwp1rFCaDkkVZriWE+r2zh9lcPZnmRjj5DdTsj/LB8ySt
         bsv9zH9UoztlApSnJP5uaJCldD/gXoAYrMUkrck1ZHHa6+z1zob/L/aCtbSbWmBh1ABr
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092370; x=1727697170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=N+XZzQF7Ph7fHZU3lGquBp02clz/adgzvm4ps1gMYtCf4Wd/ynT/2KcUxMQNsQtTTE
         qnu6ChpMLKjN5AdUgmJ9qI1hkweg6GQh1wggNvcLTwPtzYpMSvbPwMB4ZsRxqrFg8R/R
         gq0YZJNZoPzt2DnRIg4oCaB+IW/hkb83WxijUp4vZQHF6w9fUFsfWRYbuXaVGnZeQUUM
         rOA1JuEbPB4v41nqrRLJkOr1Xg7grL7MpMhnmmegizNWJjPXe9Ve+jknb1xJQGRuzAX7
         zbXHJk1W1H4tvkN+Kf4BcU9j26q/t5CAcGQ+OPFEDVtv9coO/hypIgZF3eKnr7mk6LV+
         D1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8q/YVop8drUfd/jzKkvakHahu/yyqA4afpjz+r5T/nxaJL0EqYyfKGiruBMNCGkkvthFIgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdY98PncMJ4kVWtjeksKhmSycZwsrUEgKFTytvLmtchLz2GaRr
	9f2YCPMI4/7hO5V34VsnpesNwcFrpAd2meW5Am/5icSB9q0WFgv5TSbtKpLnT9hZYf1+8aF51Jm
	8PJbG3p0n6/+WJxs+KenJWelxn+rwE2q2TZhB
X-Google-Smtp-Source: AGHT+IH67k8daKEYTW3HHmz6negW5CiPM7iyxdQ5CKiRgxjRoq1/X/Upes8Q9bMpCpOlddu//dq56AyXXaFan3/oJXs=
X-Received: by 2002:a05:6902:248c:b0:e1d:2300:29a1 with SMTP id
 3f1490d57ef6-e2250c5483bmr7783067276.29.1727092369977; Mon, 23 Sep 2024
 04:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 07:52:39 -0400
Message-ID: <CAHC9VhQM7ingdydXFZ7Mt9FHLc4E1q7Mg_FR7FbFajw068TBig@mail.gmail.com>
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:08=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> add a comment to doi_remove in struct netlbl_calipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 529160f76cac..4afd934b1238 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
>   * struct netlbl_calipso_ops - NetLabel CALIPSO operations
>   * @doi_add: add a CALIPSO DOI
>   * @doi_free: free a CALIPSO DOI
> + * @doi_remove: remove a CALIPSO DOI
>   * @doi_getdef: returns a reference to a DOI
>   * @doi_putdef: releases a reference of a DOI
>   * @doi_walk: enumerate the DOI list
> --
> 2.34.1

--=20
paul-moore.com

