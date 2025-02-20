Return-Path: <netdev+bounces-168225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB733A3E285
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59F01629B4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B92135BB;
	Thu, 20 Feb 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGy3lYPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AC212D6E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072597; cv=none; b=T81rJ+CzB5hgya0S5LP0CwsiG8JekvgLKYDr7QIDNJ51HUWdA64mnOWn4zD3Kf2frF0NLxZzrKPA77RV/XRV0z/EURVFyCeHVzrHB+GIShSeJplA9PksHxQZAKhiIsl+Ud8qxdsfJ7vJ+d84Ajh/xS3AQdeveZpK2hchEJz1LKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072597; c=relaxed/simple;
	bh=JS/oFnpQMrFBwEcfRSGQl91ghKK5VBp/fPdUkQC0fIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlhOhdg3iKB6MeA8anuqvVXe9YByDekIdwIL0MFq4QuQoRq7QueBpuh8BRyXLU0EC8f4Wnui6EjEM2dXsWkA+0ZZ5WMob4TT/kaiuqlFQCjpZ7kOeB5K47damCUcQu62W18TwOhvBClzSpopzIZP/j8CSqT8iDuOpCT2vSbPJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGy3lYPh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212a930001so32306115ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740072596; x=1740677396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2DGRFSteRymWNB/IS3l6n6cXX99sDELfNIAlb86v1M=;
        b=HGy3lYPh3r2L7i3Sit8vXHP7G9g1AlI5vSeMa4R4IQ0RLmiPqvA/0/5QprG7jPi/NN
         d203GMgh6g5EL1X1vHLW8kzPK1L7sJUqIusN9++S25srjdqZSRMoz879mzyLc4cIC+uU
         9BPbDj1m0OOlyerav1IflAfbrkyaKp4n2MzIESTsHemlWxGZIfWfRDcgu0UeCMcIOpNB
         VmzH6Nvu8wmhLQVVUMSZfPqmzTMFjUfSllPYhR8rmnFHd4tIsK1zSB4gT7ilEOxMT29e
         CyCLdgM+WzF+C7paHknbRwMT1gk72Yp6nOGq9N3+Cgpk2BA0XezrBtFi2pcoj31GPE5h
         bOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072596; x=1740677396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2DGRFSteRymWNB/IS3l6n6cXX99sDELfNIAlb86v1M=;
        b=NLM++i/l+Nd2g4e/+vqPtEJD+WNpTzzchAYnf6z/Zp08jMtIeHiM6UuCD7Qorgl7ZP
         1K5MCeQr7msNRWcwo3+WqPE+l6LU/E50MtMJ5E5aZf/zOt7mGg7zx11GmCqnz9v6waaC
         3e3CddlOg30M/iLdBG20J/LZhx4qw4t1M9jWNnhAK6dFmlBkjj7Ma4n11TXJC0JUJVNR
         iqhuhk9qdcyUqbVWaEGIN4BxIeiIBdAvY9S41iAWznaSvvus1yXO3iX510aqXVgDtt7t
         TzN74De1fqUnDwabAO2cd5urXMfCMxSUJCgcDp6CZTwGsCPoD79K0yZ3/n0HVZbvTsvZ
         6E4g==
X-Forwarded-Encrypted: i=1; AJvYcCU4fcB2CcRDX468N4L1ebQ8yTzfSFvJvCOXuUbXW4f4zRTrDV2setG2arQtCWaEOyPRYMASoAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ng4qRTjG8NlfgsFoD9fyNKR9SZdMCOVGainno3SSHis2mpze
	9MKAmWp2nt11YxAkLDKE+xFhsoyzVqXmooocwdkhAIidv9a4Otc=
X-Gm-Gg: ASbGnct20cZtxF4xUTyHCcK72txDsjykgSpitM71q75HQke+CqW43mOhsCUwA4e845y
	5v+sjqdUd1Vd9+sv5KJysRCu0GKVS5aMjDGuSgfGqWXLTt4ZAriINjX3kePF30+H33OyCM+CZqE
	jfsDBSiPFwLYY93odBV+BnvG3RwbxnuGA9hmyPA5KnkbpfUrlQsp9Kft8BgLGuHxPCsi9TLDsRe
	nvvHf0dTyHteo3sfHPOv14y8tg/5vaeg2eXYQzq0/nWOgwQXmCXeekX97b+QZh+88ofJdLPyg4a
	ybIu6oqSMBFcE0c=
X-Google-Smtp-Source: AGHT+IHgvp7XK21JekYr3E+kyhv3cYv0WJZf+P415mkg5Unbhj8Yv4I4SuV2s6XdudViZCkjirMBYA==
X-Received: by 2002:a17:903:3d0c:b0:220:cd9a:a174 with SMTP id d9443c01a7336-22103ef4fa8mr294984955ad.8.1740072595684;
        Thu, 20 Feb 2025 09:29:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98b3305sm15987023a91.6.2025.02.20.09.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:29:55 -0800 (PST)
Date: Thu, 20 Feb 2025 09:29:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 5/7] selftests: drv-net: add a way to wait
 for a local process
Message-ID: <Z7dmkkgJx0deq3_g@mini-arch>
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-6-kuba@kernel.org>

On 02/19, Jakub Kicinski wrote:
> We use wait_port_listen() extensively to wait for a process
> we spawned to be ready. Not all processes will open listening
> sockets. Add a method of explicitly waiting for a child to
> be ready. Pass a FD to the spawned process and wait for it
> to write a message to us. FD number is passed via KSFT_READY_FD
> env variable.
> 
> Similarly use KSFT_WAIT_FD to let the child process for a sign
> that we are done and child should exit. Sending a signal to
> a child with shell=True can get tricky.
> 
> Make use of this method in the queues test to make it less flaky.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

