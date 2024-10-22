Return-Path: <netdev+bounces-137938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB09AB2E9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351DB1F25039
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0102B1AD5DE;
	Tue, 22 Oct 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxIH6AOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439419D06D
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612644; cv=none; b=bo3g2PnKYViSidZxWufBHeg+WAwRSRNm5BntZCZIBq5M3aJOn5qZMop4O1XN/QFdufflGcPsdo7uzLu9pZYTBvRDGLlUSUKdfxFn+q6ChWTuk7Klvd66N2WTl0f4EB0pD/onWk2pSezERYoRn2HOaPdHBOb3ZQfOinKzhMOk1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612644; c=relaxed/simple;
	bh=N7cAEMaf1mlFuzdL/FPzQ96w9eR4jhq5EWnwCbJpUtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chpn+EyTdMz8diHhy8PUirvxw+VkjO20XEoTXf/GgwVlGKU37TWJrrvguP2YW80BGqRCnuLeHD7eJzYgIq/hU4YMuqNJp53TwESWpTiGRQQq1gzj2YQWYKNA3RkdWlH0rPfER+FcgFww09LITdD3e4u/CDS8iSOxGggPGDCtcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxIH6AOb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c6f492d2dso67203885ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729612643; x=1730217443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HKcVDh5jjKYY+erdOhr8V3ANrTCvvnSJSkoqusdWYs=;
        b=JxIH6AObBEh2FMSBsdWL0kXZ/7mYP/1NpFL8bK1icVdVJ9+GYVP/SxERCiaDpD27Z5
         RMOktf/RIdILIIb4vChjTfJh/Frg50AHoNPb2fLr1+V87jCcqvxoLJ62eYdc1Q0gjAj/
         d6kHLmG1XXKiyHbxpIXyM5R3h6G2MGz9JxyEsnSABLfeshVMAlucyrf1BWWmGfY7bRCl
         iH62HdzC79oSVESPE0AhFk+916KqyfjCZkJSo0JPiGYhvJh6nyz4TRMiGQ1OvmIek71o
         VDFyYepug4HhM8VFAl0E9HM6HX5s1msxN1mpfhMuXAQG5Zail+slSTU5ONj+RtemGkxt
         akYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612643; x=1730217443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HKcVDh5jjKYY+erdOhr8V3ANrTCvvnSJSkoqusdWYs=;
        b=doA8o7WsglB2U90Ag0IZOZkaQZUyxSELoFTqWIGoaF8YwgpYOUQr9PKBEshpwNfeXD
         wBfRDUt9rIpxLGZXP3qy4bLdddSiAEkT18mZuL2ISWpIvLNXIUFH01wP3JWplfEKC3gb
         rTDdY58wfDBJ15fzCIYO+eFMbJzxls+h/Zo6hOri/kUWp+CQuJyNAvf5ssK42x02SqnI
         1TkFgb1riarp1pX5BEJHwFFpK39cHcjOoHLz0zm+bIu0kzA96IAJXutmlN9FtaiOCNbD
         Gzi6vzJTMMqwQjAoqD2DzSq+oj4qTtP0VdCFEpXznzfS1FKuPW8kK56SRM3w62b+4Gm9
         S5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVlWmGuMIUGHhjQjFAR+jya9hsDmjssRuGFtmnWxaH0zd9ovKJmcftgo/1G/1kV9Bu+4fo9EKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDuJeHo5KgnUeV00w9gZX458PZiE8WbjZarCu11PriSduLkBP
	8osb+Wl5oUC3B5QvuV4MxZku4KOW+1olvahMqsoC6SHB2C49n4c1mX0N
X-Google-Smtp-Source: AGHT+IFaWH61RJx4/85t/1P9LrQPN0CfXMOc+ncoUKwuP+76Au2pXGPzG3SNgdYcoYJNyo976gDGaw==
X-Received: by 2002:a17:902:f54d:b0:20c:aed1:812b with SMTP id d9443c01a7336-20e5a8a40d4mr187063645ad.29.1729612642708;
        Tue, 22 Oct 2024 08:57:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef08d29sm44502165ad.64.2024.10.22.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:57:22 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:57:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v4 12/12] selftests: ncdevmem: Add automated test
Message-ID: <ZxfLYUC5dk-CDCF5@mini-arch>
References: <20241016203422.1071021-1-sdf@fomichev.me>
 <20241016203422.1071021-13-sdf@fomichev.me>
 <278ca1d0-2a21-49a1-87b5-34b0f03bb9d3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <278ca1d0-2a21-49a1-87b5-34b0f03bb9d3@redhat.com>

On 10/22, Paolo Abeni wrote:
> On 10/16/24 22:34, Stanislav Fomichev wrote:
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 182348f4bd40..1c6a77480923 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -3,6 +3,7 @@
> >  TEST_PROGS = \
> >  	csum.py \
> >  	devlink_port_split.py \
> > +	devmem.py \
> >  	ethtool.sh \
> >  	ethtool_extended_state.sh \
> >  	ethtool_mm.sh \
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > new file mode 100755
> > index 000000000000..29085591616b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -0,0 +1,46 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import errno
> 
> Possibly unneeded import?

Will drop, thx!

