Return-Path: <netdev+bounces-91672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20F8B3673
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEF1F22508
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A5413C9A7;
	Fri, 26 Apr 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YySyLS+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC313A3EE
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130519; cv=none; b=IvczZUWZ0crlaenFmByrBUEFdWRNm5EK2QlwIsJ6OPZZT7A/wZd9ft+3turxBVYm9b1zd7HbzJ+3Im8wQX83Odk97DNj8zBXQ3y87xXB/2qa/tAvvKJPTrL/HGRfQfUy5CGJvTLROa8KLZCFDq8CUaJ+5iMHnbdUUIOJ+SJchUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130519; c=relaxed/simple;
	bh=gwkCy6xMbh/yPmS2o3xydcIfm1bRaqlr9/qp7O2uUL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXwq3421SHTxR676NntdWKxo8nwRSq5GUFgVCNQyjmCYTZsKxqNtV4fyYfGAcsmEyE3KCtJObgxv4OCr9oVWA1z97B7Onf2p6ZQAhDE8sa1J/1zzb1Nv8kWDSrAcgg6a10HV3cTK3x98FgdRr6jN1ZEp0yBEu/wwTQURLIsoDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YySyLS+T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b79451145so6213755e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714130515; x=1714735315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwkCy6xMbh/yPmS2o3xydcIfm1bRaqlr9/qp7O2uUL4=;
        b=YySyLS+TFeB143kvBrLhVNffqOVUXhsUtXowAsoc56wgTS+mMhpdfZ+OCMKeYmP6iD
         5X7Vrmj064IX0FOEH8/xE9WAkaxqKIbxqDyqjNcAmtU0xtC5c2iVdsdBjBlVROVHPXhA
         ofNyFeInCv6K2FqLBKwwY3xQXqc8IeUtKJsquvgcPsFr+YKUMeGiA+h37Sqi1OaBALPN
         iSsONONw1j/VMLOzzRgD1SHPyVRa0iGEVoJktVAMdMF9iBacdv/rVnPaD4luHue7cTqK
         SfFySeIWXNZ81eJocyHFYoTL9bkf4BkatTzTQfKzrDkM0H1PfTaPCaarazDU/ESOWL2v
         lSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714130515; x=1714735315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwkCy6xMbh/yPmS2o3xydcIfm1bRaqlr9/qp7O2uUL4=;
        b=coU7iMBlAHUR1alkjkoQnaL4CXe6DihbOWmVdYHcFkR+R2+90O+lcSbXbSANbyAPcg
         9fPZe6QvJzq3414WjWzoxMNEBpxsehKGKQiWJC9IlPtkqlfgGiYickd5MyCmdOFm0A7G
         pVIy3CIxySNBH3hpAXTUPpkIBnDT3k1y0PCto1sqWBQ1WVUN1BsWLXkLVvpOjT7LzaQy
         EtVu/a53aTrbfYarEVp2H2py5BYm72Gj24vh5dVgw3JV5HEO7bPEAFGQSP3QBIM04PUi
         DRXhuC+uIVbmh61TxbYyZVMoBijva8jokm1zuZ1ppObOL0BcGeqXT6xab6eYucv/k690
         vTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjTkrQSmNZgxIOkjOhthkId4/pfls96FFAiNYhaP5xK5kROFtfwpztC1B7+zkQyjUSWkWqRf9k3x4ArLc3HSsb60U1GpHD
X-Gm-Message-State: AOJu0YxUVWSj1+G+AlO70zCLks0lWtpcxUZKZ37mxw38wN6Wpbh+gR8L
	4eLY0Maca5b5D/r6giQdYiEKMBzF8eu0tWlxILLOOnzCnfWKZDZeKUzaQmrhJkA=
X-Google-Smtp-Source: AGHT+IFOrEgBGTYIZD6piHMM1uka4e+bHKPHVQZ9opPcfYzn4O3rKgIW2j2MZFHO5rnn7+/qlorfmw==
X-Received: by 2002:a5d:628c:0:b0:34a:9adc:c36e with SMTP id k12-20020a5d628c000000b0034a9adcc36emr1593412wru.40.1714130514914;
        Fri, 26 Apr 2024 04:21:54 -0700 (PDT)
Received: from localhost ([89.24.35.126])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d434b000000b0034a2d0b9a4fsm20973093wrr.17.2024.04.26.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:21:54 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:21:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: use call_rcu_hurry() in
 fib6_info_release()
Message-ID: <ZiuOUUlqo9naSyAd@nanopsycho>
References: <20240426104722.1612331-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104722.1612331-1-edumazet@google.com>

Fri, Apr 26, 2024 at 12:47:22PM CEST, edumazet@google.com wrote:
>This is a followup of commit c4e86b4363ac ("net: add two more
>call_rcu_hurry()")
>
>fib6_info_destroy_rcu() is calling nexthop_put() or fib6_nh_release()
>
>We must not delay it too much or risk unregister_netdevice/ref_tracker
>traces because references to netdev are not released in time.
>
>This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

