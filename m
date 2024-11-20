Return-Path: <netdev+bounces-146536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5C9D40D0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836BB281292
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083F814831E;
	Wed, 20 Nov 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Wf6f2Mxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C7154439
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122517; cv=none; b=ZkGxkg7OpfOPJuvJmwpq3fKwuRZLIdgT+LWE6oCuhtiWKpI5mUG6Fsdx/z2SgZjeVL+Kp8mzINwC+MRTw/OUwdAnoD7FG08Qok/BClCC24sBGj9wvRKQnZw/wMAGECiiFFjKKA1TpjozQY6AL32KCcxY9GnlDbBkkB92aagktJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122517; c=relaxed/simple;
	bh=LdmnBg7dEkkDqK/hRmLqgPc54YrWxdEeTQ0bSbwJuB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojzWtN/mZJvmF0MUimNnQmN85PZfBlfAswYv1kMBT5C4tKRkh7uX+OHXTHtLW2qArbqIQnVMdjBtQZfjPvkyo1vrz/Hm4Ge7wgKpBBZyumeXTqDMVtArsHg4k6zRC882xGEjs9yhP+nGOPvJUlncCheCHI8bggSgy8rLdx1E6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Wf6f2Mxp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20e576dbc42so62351545ad.0
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1732122514; x=1732727314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx5Yf0Ry6m4y3ClWCHX8xWT4YyXCXGE+2A39W9IT2Dk=;
        b=Wf6f2MxpY+Rgn08M4HpIe9yNSfyCkvMp/mv0RGHrGZRoJHN0jv11JtUw17TzoIQM9T
         iPZE+4LDlBdjTPk5RQG3Ftv3poTrzE20ZwfiAe5zSHkW5ZpN0F15B/QVvf4nXEPBgbiy
         wIoMcnyfHhhbNF57h54V/QTRuuPtEMgGR+my2W0zW1Za1b9jTEv8XQwxAExOsHoZc/KW
         TZVni9xe9rHk7VV8/ZLg1uv+t+0Ipx4sPFJ/0WmV0+t6XvC2VlbHoEZjvG9TVxNTxtEy
         VKJ3yHHIv9WmV0vp5kWrAs1pYSqH9SxnqK7g2PGQJnJMFoannx3kg0kSADfPc5PSQY2X
         fR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122514; x=1732727314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx5Yf0Ry6m4y3ClWCHX8xWT4YyXCXGE+2A39W9IT2Dk=;
        b=UEIYSiw/Hmp6O14KiLC5xEqhC78lNUtp2AOqsOX5uDTY3Q5BJ2fD93PA5gQ/2c6+G6
         G/TsOy7KM+PoLdb8AruNecp9scA7MaIuAFGtYb89mjqlolvr81FYpquzthLfI2eAGljv
         GhNJbCnfHJ8Lrt+vYD3hjy/MIxoD4sR7AXMNX0zbrLSxC00gnsDwhLBc8kvf+2d3qnFt
         GK4g23TmF6/GhIv2mSkfxREzehRcXZGZHXLr59IkCTIdH5h91L3FiLiY/iJOnES1Nasr
         h8tfqQCWLUJWP+2/OL4WO8BEhByVRfhr3l34934nwmCyrKrR9gh1nPMNz9R42A6bv9Br
         y4aQ==
X-Gm-Message-State: AOJu0YylmHpgyshT52Aw4FVt12kqJdwuHkU3mOHUkGsgqiyT5EN395VA
	Q4OQ1Hk3Dn4JDnTAy9RVu5m5+KDNcPRL2fvo5dHC+nBCTR4b6imEp3IMtkfW3k8qNEeDrFtY0z5
	d
X-Google-Smtp-Source: AGHT+IGPIJ+5sMLGEO3ekkSiyw4NkWuw5Q4lRgs0ENedLGl1BAc1iALK8sr30fLb6ZNd1C+idOONsA==
X-Received: by 2002:a17:903:8c6:b0:212:3f36:cee6 with SMTP id d9443c01a7336-2126aebbd8cmr40679035ad.33.1732122514342;
        Wed, 20 Nov 2024 09:08:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befea7adsm1943930b3a.189.2024.11.20.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:08:34 -0800 (PST)
Date: Wed, 20 Nov 2024 09:08:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: netdev: operstate UNKNOWN for loopback and other devices?
Message-ID: <20241120090832.5b413ed4@hermes.local>
In-Reply-To: <20241119192353.2862779e@kernel.org>
References: <20241119153703.71f97b76@hermes.local>
	<20241119192353.2862779e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 19:23:53 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 19 Nov 2024 15:37:03 -0800 Stephen Hemminger wrote:
> > It looks like loopback and other software devices never get the operstate
> > set correctly. Not a serious problem, but it is incorrect.
> > 
> > For example:
> > $ ip -br link
> > lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
> > 
> > tap0             UNKNOWN        ca:ff:ed:bf:96:a0 <BROADCAST,PROMISC,UP,LOWER_UP> 
> > tap1             UNKNOWN        36:f5:16:d1:4c:15 <BROADCAST,PROMISC,UP,LOWER_UP> 
> > 
> > For wireless and ethernet devices kernel reports UP and DOWN correctly.
> > 
> > Looks like some missing bits in dev_open but not sure exactly where.  
> 
> I thought it means the driver doesn't have any notion of the carrier,
> IOW the carrier will never go down. Basically those drivers don't
> call netif_carrier_{on,off}() at all, and rely on carrier being on
> by default at netdev registration.

Tap device does have concept of pseudo carrier. If application has file descriptor
open it reports carrier, if the device is present but application has not opened
it then carrier is reported down.

