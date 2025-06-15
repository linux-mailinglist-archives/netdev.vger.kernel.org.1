Return-Path: <netdev+bounces-197859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E42ADA138
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B8C1709B3
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A3261588;
	Sun, 15 Jun 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="xnMDdUIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E61922FB
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749973040; cv=none; b=Q6OqyMpkSGt83SwUDFdvFkSB2FKBPJi2kTo1fXmxMaKvDs5BBhdZlS+ooERsfB/7lP5+qX8MX3uc/utAsraw1K/SAJ3KzVPbwd/PH3J+dsr+5VmoPBAB5JDwy4KCox+ApA5xdp1zJ1qobGfemvF8N+IJsaaZh3/cmD5pQjLD0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749973040; c=relaxed/simple;
	bh=gmI+OB18/aEFLmeG+0NzWDalnJ1KU2lcY+ijh5E8H5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT46IiJLpSNY+fkup+3vuVOg1Pk+Kj0LO21UUyYL/eMkt08flFfsjfANwMUXOcRKDnWVpG18saBypW1xCGq3JmxtenmiXICjgcAqJXd6BYgASdPtpDQkFtiPI+ue3rWOBfyPDoJN3r5FmfhOjbqxCnVRwo56AlFOjmhI5NJuvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=xnMDdUIK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so14048825e9.1
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749973036; x=1750577836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZe8uQenlqylTmWqNC2hIY8BhxwJwY3Ls343kx6UWFQ=;
        b=xnMDdUIKJPMVG2IugNAPrWYQpsfUuBz+NiDCwuiKaSd17T15lDcS4VLBHX8j9aA/gX
         qxTXl23somu9+2UCHe0xD0GFAnc5JeETz+/n0OH12B72Dee+1Cx2TVhMPxzUuWYO58c/
         0Af6K+4yK0+RhgVFLJX6DTwv9PdymbFhWSeRwBSyNbsFbXp2rQjc/86T3SHgYJxx6hvr
         jtXz6zux1pH7G1bGva/2RR79eyJQOyaNOlsG3ApxSWKhLGzZTkRPZqrXIVAB2zqIqppQ
         S3CxE19XQJNUraberPbxmN7Ko3Z9dcxkn4lF5YxQSiDSBDgsgkwHYbyMwg0j1xkhXz+n
         R1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749973036; x=1750577836;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZe8uQenlqylTmWqNC2hIY8BhxwJwY3Ls343kx6UWFQ=;
        b=QtDNeUo29CDlf7aSzpDbGkY7z0/pr2ix3q6CJzEMIZ7LelNgYI2DmUWArs6l/jXb4p
         8Qj586kxnIA6I0kSMxRViaUoSUcBY7+OMolgbhuEMeLTTYJrz88ae44PmrW2aepBZNH2
         TIMTmMGIVHhD39HlE+m2ba5iH4CDO1BOSGB50gp5R17k8OcSbQQb2A9n/PX5gGPuPhO+
         uEhX3Mz7lv13AS/g6Bkk7ST0IGbNeBYrPwdwXb3lL3ruCeH1XC1QoIzwdlJ4XeWhe7lO
         UfgRxB1US6+18ok/k++BfPmV24NcF48UTnmxR0Q9QONyhz824nt2r179bITSEaSmWfWY
         lgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtp+uLdKDDrLsnhqq7V1s8/+elJ2ioxpcmvYf6JFNMNcigu1tIEunpUVPnhOXVgWzy60BZqd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAy9MxPs4eTHOuiel57w03gPh9VgvNU2L3my/gMVfZ/2CPRpuQ
	aJqlEKCho7hmxd+Y4vQejFuM1ZdO6dSgIWJNqglnNP6h9OvE23dZ8R7JaXMJ5kQA84lMEMQvCYK
	X3ekz3bE=
X-Gm-Gg: ASbGncssyHP4wqlV1JgGNsurW5gqcj4IHLmYm1wYSi/o1txLXGl05jti7v9LrylpzrN
	Zjxb2NWN8iMtjvVKek0orZA/jYLJq9Jp3uUr+Q1mjg0kPI32ApEa+hK/U5N5hWDAE682Eq76QML
	IomfovRNQYzGSS8D3RCCGY0rb8TdK9dZS7uLAL7xBfsQr7FW4O1+4SX9QmJausYrSIpBFipY5L1
	EQIJvxdR69NocO9Wl+dnHNyR+5i/1BrX7uISEtpTxGpDXQwqbm9+5uIKP/rQmP2tu4ygMSTbI8j
	Oa0/bApQwIvxhpZAm4nCwMiizB29hZMubbfYiKVtm5EPIKthO0l+jM3c/UQLnAtEV7k=
X-Google-Smtp-Source: AGHT+IGT3aOKYj3HxP/dNJ5wrtCJCS4jvbys/KYqEQvAxfZyw3IyNpDmpHTFfLaisw6FIEWMgIolQQ==
X-Received: by 2002:a05:600c:83cf:b0:442:f4a3:9388 with SMTP id 5b1f17b1804b1-4533cb3bd51mr47139255e9.19.1749973036451;
        Sun, 15 Jun 2025 00:37:16 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e253f64sm101318935e9.27.2025.06.15.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 00:37:15 -0700 (PDT)
Date: Sun, 15 Jun 2025 10:37:13 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] docs: process: discourage pointless boilerplate kdoc
Message-ID: <aE54KSsCaTY5cxri@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
References: <20250614204258.61449-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614204258.61449-1-kuba@kernel.org>

On Sat, Jun 14, 2025 at 01:42:57PM -0700, Jakub Kicinski wrote:
> It appears that folks "less versed in kernel coding" think that its
> good style to document every function, even if they have no useful
> information to pass to the future readers of the code. This used
> to be just a waste of space, but with increased kdoc format linting
> it's also a burden when refactoring the code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/coding-style.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

I suppose I am guilty of this ;)

Reviewed-by: Joe Damato <joe@dama.to>

