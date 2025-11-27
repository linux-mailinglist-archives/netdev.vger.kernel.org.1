Return-Path: <netdev+bounces-242376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B87C8FE5F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960994E1C54
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D212FDC35;
	Thu, 27 Nov 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em3NUuDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B324886A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267735; cv=none; b=e09neCd1ClGYL91586LiYIJeao1O+y43JnY1jqPvKobXJ2J02GPo5FbIvTYeFXckku2qTUKL3X9t9jtbjOkAOtVC72N5HvBdfuthApMjunaZ4ZKHUEyxAcXl1xMdMoL1CrRqh5hI5ydMBEcTK/eOc2/+o7KWjy1yFWnMJOXW4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267735; c=relaxed/simple;
	bh=fjQtqN+YUKlDuW7ycIzofip76NFL/CXU2USqYgPJLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c40XwReFTr5RbC4IcOQJ/YF8bFNCycRQaPXjs1hxI0Ulrm/KUJXD3NrTx9CXQTjHKZMEVADbtqGPMq2xcE/gkQIV4iP6uPWo5Y/Af/2ZkLcyXhlOz9TDpJ0JozILY4gAzsCaCS06A/LY5LFcBEIHb7UYNyWyI6BrhgNOAK8tjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em3NUuDq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3418ad69672so670238a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764267732; x=1764872532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLlmHa9xtqFKgo7ETYW4T2wGIj/hShZNl/WxQYt+MiM=;
        b=em3NUuDqHwGd0xFI2f++ZJnjPpmPq8naLJKjkRBhgG4wY4MS6awe9EbiKXKGCh9gXQ
         U8l6bLxXDBPguqHCNCGdyJ+63BBDViPL1+F/riAcS0vLPeLDxfTScHBJ0I4z3EZQevyC
         Ga1xbZqVYlNf2noMlfXo47fZk7LDZN+4ZSvCiTQEiu0HYGt4xsyhNT42PbSuJVi6u+pN
         C/AquDKeOGmhk4UjhGTobJEF4qFyJ8ZNSlGbXI5Pf324mMSlQzF/Uwnup6Pd8IPYXh2H
         JJ4IBfqfgHR06SJi1Ts9E3E+wKJIQPGFvOQdP4IOLM23KFKCJLcvpwrLWOsVrhPKZ0s5
         DFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764267732; x=1764872532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLlmHa9xtqFKgo7ETYW4T2wGIj/hShZNl/WxQYt+MiM=;
        b=ioM6h+kKLgr96EH02Lboppl4jjLg9cgTL12cPXMMrmxA5pYPo3mdqeTCt2F3EiTYRh
         YE2hvb2X8jEEQecRxkiPNt1zT+p16c2KH8FSllFGLkfr0oLvs2OloLOJugCmWStmPLgk
         F4vxQGtOB4MLWM6bzDSbR/sPHeVa0UWCxrhrfvK3u4R46ZLnjIvsy2O6XG/kmH7L/+lO
         iScqQrJPMTReFq7pNR6RfcMT3GzbEaDrk6vbM+piqYS6mKz2rZHHAyoefyMa3bIwpw7x
         Ufq89mpCAtn4iHwu87lcdHFSMH6bL34D4BJg0Hg62aPa72EKSR3F9SvPMIGaVncPbg1J
         U+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyJhGckheLRrt5gi2/IMmbAzhFtyACW2yDnlIz4rRoimlewzA2y1d3+8ZXor8DywmHD3oIImY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJ9T9CQI0JMNC1fTbDhzU6jtdDgBSm2SmMaabhg/THw0NgWF5
	wq8MG02kjEszSMVppFNgavthnYcf6fjhevzCZDtf5bIK1ycsbO1QgoWQ
X-Gm-Gg: ASbGncshBgfsHedSMFKqtydR+RHY7kp5zjbodyW6gqOIFSXHIOCrs7gTWRSkdblInHB
	ZZC9t3WVbx56K/SGc7IRF9k+XvIeA6JekS3WdId7cjSsYPCRBKfzcMBjAisIr3GsPw+QGjA+keA
	40wvrWmqGmnIheGneu11Y6Btn2FCAWBHULtPFHo1G7nEEQUb9RGAfpnKlwAITlDaEcX+FdOD8eT
	sNMMj7zXoz2Nu4Ef+g/BqbBxRVL/OlJLMIcpgjA+UN+TMjA9/09pFJNmMIMAatMcn2uqNBhYGjQ
	aLngm7f/jppegdt5r5TbDv5HJUU2MZfWcQkCE+YHSzeJVeTU+1NsD2VQlWL680VcXd7QF7bdtD8
	UYoCjsAbJ66YvVq4qHb7/x+uPuLEGFIlR1VHLsRog/BfEsqCeeJ0xuEX8d2bMTZ9CZxj0YlIS0O
	bJpCIJUwlqKrRNkIxODw==
X-Google-Smtp-Source: AGHT+IE8xcHYZfCXh6tP7khVEJw8vLXqjkwggDLc7ntQcLdUlt4y/KaDurVYmBOCuN1rVQOzoyCJ3w==
X-Received: by 2002:a17:90b:48cd:b0:340:fb6a:cb52 with SMTP id 98e67ed59e1d1-34733f4acfbmr21840475a91.25.1764267732245;
        Thu, 27 Nov 2025 10:22:12 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:ef22:445e:1e79:6b9a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b733381sm2473813a91.12.2025.11.27.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 10:22:11 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:10 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v7 2/2] selftests/tc-testing: Test CAKE scheduler
 when enqueue drops packets
Message-ID: <aSiW0k7Z13TvG8yy@pop-os.localdomain>
References: <20251126194513.3984722-1-xmei5@asu.edu>
 <20251126194513.3984722-2-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126194513.3984722-2-xmei5@asu.edu>

On Wed, Nov 26, 2025 at 12:45:13PM -0700, Xiang Mei wrote:
> Add tests that trigger packet drops in cake_enqueue(): "CAKE with QFQ
> Parent - CAKE enqueue with packets dropping". It forces CAKE_enqueue to
> return NET_XMIT_CN after dropping the packets when it has a QFQ parent.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: place the test in qdiscs.json

Acked-by: Cong Wang <cwang@multikernel.io>

