Return-Path: <netdev+bounces-161975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BDA24DB2
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A507B163EC7
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992D1D54F2;
	Sun,  2 Feb 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbVTU8FO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC01CAA80
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738496683; cv=none; b=li0G7cpkvN+ZwQ9rflJGYNKBcOi4Zzg0ubOWNfDKqaZjKSGiWjlo9i9BuPLAjKUueXRheA24bdGURs1fc2qpnLv9lMkUJJY4e6Xp0s2fDdOzi4qvicbDQbtvXcfmlakGYNoCw64kw6NoXwmwFk5FaQ2sHS2IBWrTxnkNz6JuDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738496683; c=relaxed/simple;
	bh=oNeH9BdwbwyfhWKyj5b/JxTnO936ekgZaV6nswU0e1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeOs/vYT2R+eXkep/L/MPr4SJHvIcgGkimcukphYuHaohJy5c2ervHyWeA37Rjwt4nR++qujJ1WzsMnCinGOf+yIYUHdL3jhmJYgoEQXjQQeteDV72iaGETWcAN9osc9DY0TxC4WP8vhj8mmasCOm2E+XzMJncZujmmrIuIdcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbVTU8FO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738496680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNeH9BdwbwyfhWKyj5b/JxTnO936ekgZaV6nswU0e1A=;
	b=gbVTU8FOwHmVSYbFNRDCia7/yVML4Jk54k++wXY9LQi1pKkJRYLWYHeC08MbZNuEyLxtfu
	KyBP8jxEKKK5vgR2a02D0fkT19uZEQ0+Q6BVjpeNShZetSNCD8TJRxrkU5NHriPYprZMXc
	HY8yJonnuU7b3BIsYF7YxGxjBIttJh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-QPqWZDwEOuiWgjQ5wnljvw-1; Sun, 02 Feb 2025 06:44:39 -0500
X-MC-Unique: QPqWZDwEOuiWgjQ5wnljvw-1
X-Mimecast-MFC-AGG-ID: QPqWZDwEOuiWgjQ5wnljvw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43621907030so29687935e9.1
        for <netdev@vger.kernel.org>; Sun, 02 Feb 2025 03:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738496678; x=1739101478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNeH9BdwbwyfhWKyj5b/JxTnO936ekgZaV6nswU0e1A=;
        b=MthsED/TIelYBE0YnCvJCrVh/kTBFiYFO3BMYDkxArL2NwVsFyib6JOWbv26R1O5mK
         P2UmuJk/WKldobUEuwac8pq8ZP8tYw5zv94ffpNyz6eeHAc3NyeEJihMUBolck1+7OHw
         tvr8XsNvuoaopG7DiAk0LczHLCdDnZw3f6DAZCCEHS8XSCTJFLho/izSNBkIi8MbdU0h
         T3R2Hu8rS08pcUUzyHC2TxLi74Cruw8B71tmDU8eXJKe5GaBQ6idBABPnOqKaq2ySaXJ
         WtVbbMtSGbrO58RxW69wNiyecXJ9gN9muKvNxfg93NT9C0UMt8xm+7b/ZVIdAlOvRL6T
         r2WA==
X-Gm-Message-State: AOJu0Yy0rPxExcOvOVa+j/9eZwaaTFw9em5CnLkffz2ck8wgrhB6oiV5
	Fk1+YgokrvNMkPd5yCZEQifIZOF8wIqxHUCmsVbAl446OJU/tp5S84I4LJLTGuVXqkuuPneuOf8
	jKGwJrAlfjXIMSNwb5Jy4hCdBMOza79lLLaS2mEMFCdSE3WKIXXmcOw==
X-Gm-Gg: ASbGncv4bpix0qJ1JEwGF9gfmTKAG78dDkarbu6qDKoj3dDqL/4tylblpvurm0UIvDW
	NKbbvk8L1CwCeyFAgC8E2MVWSKCg/dNJV1dUKevnJaAX4tHTf/vbxFsTxjgd3KwwZft8KInFsS8
	XZJccZvNI4NvFIWBxZ214Pc1PtlR3bTy3P23Cbs/O2/pUsMCTQZ30dLSJCBSbtRVGqYIqkOfxiM
	mi0u0R/hPtdZYFOAwQmX0BDcunJu9nBZu6VVVPmXcFodOQlGUpxvgN0NsSmELie4W6y/d+PK1nH
	MWFFeIxfgGLeZ+7oMoE/B6fQByQJ5s33GKK8EDae+yq+ZuRLJ0oKV/5eTEQ=
X-Received: by 2002:a05:600c:3b94:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-438dc3cba35mr182492865e9.18.1738496678254;
        Sun, 02 Feb 2025 03:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA1ZKj1nM5l+HK36Zn3sb3iqwRBnWFG5TnhWMwEi3I75R/qAJ33U44j4ipao7uJcW1pE1g7g==
X-Received: by 2002:a05:600c:3b94:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-438dc3cba35mr182492705e9.18.1738496677912;
        Sun, 02 Feb 2025 03:44:37 -0800 (PST)
Received: from debian (2a01cb058d23d6007ef1b63f0704f0b4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7ef1:b63f:704:f0b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23deedfsm119111425e9.16.2025.02.02.03.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 03:44:37 -0800 (PST)
Date: Sun, 2 Feb 2025 12:44:35 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] net: armonize tstats and dstats
Message-ID: <Z59ao8xud3Fw90ad@debian>
References: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>

On Sat, Feb 01, 2025 at 07:02:51PM +0100, Paolo Abeni wrote:
> Address the issue ensuring the same binary layout for the overlapping
> fields of dstats and tstats. While this solution is a bit hackish, is
> smaller and with no performance pitfall compared to other alternatives
> i.e. supporting both dstat and tstat in iptunnel_xmit_stats() or
> reverting the blamed commit.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


