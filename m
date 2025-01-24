Return-Path: <netdev+bounces-160699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F5A1AE54
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6EF1673A7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EE1D517E;
	Fri, 24 Jan 2025 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE5MCELe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00413AC1;
	Fri, 24 Jan 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683601; cv=none; b=IKwGVu+qzcC/FaBLKum6hIbkQqHt5BAJKZuDSEV7ZMylQetxttAkm8uz9zfmBgyKclE9aaQLrZkmVMLhQVpBbI+jR5aORLellJr49QNtlsOEKrPCA4ODeA39LmUbG2kVFYIbSMkOZX9BjXWO5fFXnZcsfd2QZMth/S9cXmRLEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683601; c=relaxed/simple;
	bh=oIVH55boL2m9UVr62y1iv+ybohtXiohRGHO8GDRb3O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVIRH5iP4zCLXS4mKArGcsacS2LPHmT9V+9nZLxwoT4/pDcklKx1ZOXSXDJsVf8dv9gcgR8N/VxbjZaaiIKad3VvbGQxpgndxwHn1jpsN/pPbM3P4elMknuOv2lRuy99VuRWfd4XggmXXrMHoU6AKxMZ4QWNwTtdpyG26JZ29dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE5MCELe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso38550785ad.3;
        Thu, 23 Jan 2025 17:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737683599; x=1738288399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CIWoUy3ha4vzmjbfSmJFxTGA26KK4HHUmc6qsOMGbs=;
        b=LE5MCELekGR+8FHtoPvWs4TOy27/PJukuIZ/EBKX+SrRCI2FODVKpVMF78ylZsTuDp
         VZfiKJJXp89ShLvqMgQ0EqHwcWRMRxYKZitu8Em2TdojGIU05rgzQlkm0h66buiFpwrI
         9eVXa8a0NFkun7DIzGnE7IGDEJW9znGScGOWAHNNJp+qya/pfzp6TuPh67CdFOxgAo7b
         a3m0d2mQuq4+Hf99L1veCfN3T39myaIdgRTm8JUhtONChNTe+hufKLf601neqIZjoxLy
         mWWihO10ABxbHOOLwCK72bIJNdHVYomhZIi68JgY/cZEhSrR9g0ijz9CF4EajHZBDXmt
         Oc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683599; x=1738288399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CIWoUy3ha4vzmjbfSmJFxTGA26KK4HHUmc6qsOMGbs=;
        b=t2NtYJSCPuX6XgLMOqELlLJr+WWZYtfNnC1ZdnHALeJKxsOXLdFBsAuzRkW99FDjs/
         62CmNDbEWbmTycE3fL6dvLs+LkbrZkvT+I2h4ZjFCWqa+Wpv5E+niQZyUt/Stkt4PPOS
         Vs7cbK2FY7f2xH67Q6Fd28ouhC1F4jMsSmjkGULwCOPTOigRkqP4lwR4c7WCXJxr7l2Q
         qxoKcuaYnMAgLxMHecreCPDBfcxxXsRN1NziLddzr3woLoh8X3k1UQDaGPlPAEiYj77J
         4mG6eV0tp/+Xi99dD7URheT9QYqRPljo28SmeH8qkC4uJq0KV7K23mXNeiQC84f7PpKM
         mldA==
X-Forwarded-Encrypted: i=1; AJvYcCUQKiZmrR73Psk3wi/I/DdSWdyS1zcUcqFgrJ9nj7Wb+b2naqrxB5IprqRtB9Qd6vRkATO76M2P5UdiUgA=@vger.kernel.org, AJvYcCW2X+rWTmQMgr2xWhdrtV5O/beE5EchMO20hD+Hnfy+bhI94QaxbpcpyWrc0RzNYhFCQVnGa3hn@vger.kernel.org, AJvYcCWUdpfuhvdlGRPUcsqfWkiKmSpH4lkFTcvE/x56O3F1iGV9BiKVrka21EEE4KrjSFOGdQa7YGSzzU8h/K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRM0GxlSOimo8KaFySlqNO0Xr7yJdjyYHTEtCWXvYTOzaqBJTI
	9mGQMHtcGdUFjaY82quzCxPTkPGtxU73uf0gunhykk+93hTlK8tF
X-Gm-Gg: ASbGnctPgygee7U1vCx5PjfUjCjDIK/KcUtEXzPmCNTZ1DsOKIfPjpna4wRIkFuA6WK
	D3WvBN9uGs1PO6lUja7ZL7CPguFroU3KYXkvyzOoTZVXwwWfAOkEzD0tJjsrVwFrDKJaXIc8Sgw
	KuQzRdqDkx65E74aI1FsIgmSLt2DtjK3dO5ip04wtswd5HApc4Zks0MXPIDbO7b/t5UrJDLdi9Z
	2J4ino5flX+tg9XECUys56tRfCyN/SUoB4Gn0ma6+5tEsNTU2K9nmzktD7d3Rv9griBiZyq/60n
	Dg==
X-Google-Smtp-Source: AGHT+IFZRfnI30bnwFu/Rtxq5p6ANLOVPVizJ9I6bLn4f1DAiaJJMm0/EPmYHmngP0TFWmohDF1dbQ==
X-Received: by 2002:a17:902:ce8d:b0:216:591a:8544 with SMTP id d9443c01a7336-21c35630a13mr474511075ad.34.1737683598984;
        Thu, 23 Jan 2025 17:53:18 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141100sm5538865ad.137.2025.01.23.17.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:53:18 -0800 (PST)
Date: Fri, 24 Jan 2025 09:53:05 +0800
From: Furong Xu <0x1207@gmail.com>
To: Brad Griffis <bgriffis@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250124095305.00002b3e@gmail.com>
In-Reply-To: <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 11:53:21 -0800, Brad Griffis <bgriffis@nvidia.com> wrote:

> On 1/23/25 08:35, Furong Xu wrote:
> > What is the MTU of Tegra234 and NFS server? Are they both 1500?  
> 
> I see the same issue.  Yes, both are 1500.
> 
> > Could you please try attached patch to confirm if this regression is
> > fixed?  
> 
> Patch fixes the issue.
> 
> > If the attached patch fixes this regression, and so it seems to be a
> > cache coherence issue specific to Tegra234, since this patch avoid
> > memcpy and the page buffers may be modified by upper network stack of
> > course, then cache lines of page buffers may become dirty. But by
> > reverting this patch, cache lines of page buffers never become dirty,
> > this is the core difference.  
> 
> Thanks for these insights. I don't have specific experience in this 
> driver, but I see we have dma-coherent turned on for this driver in our 
> downstream device tree files (i.e. dtbs that coincide with our 
> out-of-tree implementation of this driver).  I went back to the original 
> code and verified that the issue was there. I did a new test where I 
> added dma-coherent to this ethernet node in the dtb and retested. It worked!
> 
> Just to clarify, the patch that you had us try was not intended as an 
> actual fix, correct? It was only for diagnostic purposes, i.e. to see if 
> there is some kind of cache coherence issue, which seems to be the case? 

It is not an actual fix, it is only for diagnostic purposes.

>   So perhaps the only fix needed is to add dma-coherent to our device tree?

Yes, add dma-coherent to ethernet node is the correct fix.

