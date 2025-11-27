Return-Path: <netdev+bounces-242130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65CC8CA1D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6EC4E5BB9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C8248867;
	Thu, 27 Nov 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP3e3p4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014223FC49
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209080; cv=none; b=NVbrmz3mePAl/Y99OoTeROYRakk+9d0VNVUoHImTRs16alJWxZoIZRisy33WwGa1MMMKhnXsDJ4KACcxHVGB+i85dCjmY+Lmk5AfGdbQht6tDzIO1n/oQ/RXKwqahCTxNWz1zmy/2JCmzGwa4FmAHxJb+lqyMez8g/kfcsHm0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209080; c=relaxed/simple;
	bh=yMkE/o4qOlPv9FfY6r6Q79YCahIzYNDnzVQH7Vl/uCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEujgt9Jonlr2+i8CNoN8DCaCNM9Y0rpRNacALPxmFZdy6frQIbtP7JRzlDFYvDC1RWYn2DtCPQDSJTa5vqCdgx4UeS0/l0sjVcfdBjRQ1KMLpTKLhpQQtrGhzYUQnSIcYVhJmSwpG+wm7S0ZErIlkek71LVe8upnDozCtLvwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP3e3p4O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e239baecso11022105ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764209079; x=1764813879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbjQ9ntG+GkQ5R28D8IBXAyhiisq6W/nOPon6DKr8bM=;
        b=OP3e3p4OLJBctfE8rzlGdaH/irsqLth2WISgkKO28nmf1xVLKMZFXZxxwPuQTWFwxX
         lYWYTxllk2vbxgPcdDTP6enguv3S9mf0xKU/32TzFAf6BWSAcrND3rWScnQsamha1fqf
         osFLPfVAlhhVtu9MdsJm77Qs3/TgdfmpL7i9515Y+G4TsADl5JuPB3D3j2+/vI+UTK/w
         CXE5g2IF6WR3a8Z1f7R1LSbLn5Bd6hhfV6ivpMv+nymt5rOJZx/jImKXzW7hNGmaB5cB
         WyD8WGqPCoGbbpYzSLUyoLgbBkPVIdrB3qhq7FRHKjG70nmNWocpQ1oLmtKcPxpriTV/
         ZgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764209079; x=1764813879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbjQ9ntG+GkQ5R28D8IBXAyhiisq6W/nOPon6DKr8bM=;
        b=E5RriBfh2k87DCcG7MCqaJFJqGZy72qajA2+wNQ3pW+xe/REwH1m7zdjJNDmq9whaA
         vH3+xwx21Ck3aMNiNeUg1rwNMvXWq08puJz6UWSGZM7FN3B/0PEicqwz/rGHO/xLGIrr
         RlBkXRp5QPI8uhDE7cr8cy38PkYI1CwVBWNstGwkCHaP2hyDB7bIbdhaiSjyCXcEZclm
         YfOUo+9JnW7wsg/eVGS67OFRaBdC7wyZgvwqj6SHpmx4uxE8VXvtxRnb8OnJhdjQas3e
         BTMrNepAC7+gR1zUtr1Q0L0a6RBq6F3e7uTzoqdZlDvJI3VjOSFV4GsCxbdQKq7suzuM
         PZOQ==
X-Gm-Message-State: AOJu0YynUHpCQUmF7u+qUD/YcmH1888UHYK8EepkR6QYRjabvvXFVCs4
	4Goc14YHzM7H4lcNvnnPOsYg4xr/XBaPDirOX65VNUcavTneNTIcl5vnvPz30KZG99I=
X-Gm-Gg: ASbGncuii8q8nYllw0RKDeeAJDzHlj5BJAMT0g7XfRcqIqnWZ1KJOmlnuBISLdyRSyt
	3vncQIaHROe/1BJZCahsF3xahbxxQ0W0Jin2x/Bs4E6SKVxM/G1k4/jO59YK5R/P3TAVQze0hO9
	Zy+HQlqXX+XU4tTD7Tst66Ogz8AZUyqM9JLW3ry8ShllabkHNcOcHws1PdjSq6KbhY23un57ym9
	y+z9kbGAizMCI6XmHQNn7DTkGhZecGaC0g5qSs+BDvBkwqrg6fhCO2duCUyjZJrea4jjinXzPRk
	gvLWln0j+znXVe5Imz4GhhuguVzZ1RVmCOZReb3tpo7SHo1Bkau7xj9oHUvQhhvknVKodJJibXt
	GcJwVSXR4rV/pj8EKTHEw8aMKXpEoi45ft5x4+ayj36Vb9ZRUrIomAxKPgJanc4qk94kc2IaNsD
	g/+m4Zvv9I00OzCFA=
X-Google-Smtp-Source: AGHT+IHQrh2BPMt607VMQruEXEsMq6Cfsp2gD8cujkYpOhTHZuiA7AhKSGJQ5+rReiUz8nsaIu7XAw==
X-Received: by 2002:a17:902:ef10:b0:294:fc13:7e8c with SMTP id d9443c01a7336-29b6bf27bddmr235270715ad.13.1764209078504;
        Wed, 26 Nov 2025 18:04:38 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107effsm214329935ad.14.2025.11.26.18.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:04:37 -0800 (PST)
Date: Thu, 27 Nov 2025 02:04:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <aSexsbVfx7R3pr9o@fedora>
References: <20251114082014.750edfad@kernel.org>
 <aRrbvkW1_TnCNH-y@fedora>
 <aRwMJWzy6f1OEUdy@fedora>
 <20251118071302.5643244a@kernel.org>
 <20251126071930.76b42c57@kernel.org>
 <aSemD3xMfbVfps0D@fedora>
 <aSem5ppfiGP8RgvK@fedora>
 <20251126174144.7e9bf70b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126174144.7e9bf70b@kernel.org>

On Wed, Nov 26, 2025 at 05:41:44PM -0800, Jakub Kicinski wrote:
> On Thu, 27 Nov 2025 01:18:30 +0000 Hangbin Liu wrote:
> > On Thu, Nov 27, 2025 at 01:15:00AM +0000, Hangbin Liu wrote:
> > > > Hi Hangbin!
> > > > 
> > > > The 0.25 sec sleep was added locally 1 week ago and 0 flakes since.
> > > > Would you mind submitting it officially?  
> > > 
> > > Good to hear this. I will submit it.  
> > 
> > Oh, I pressed the send button too fast. I forgot to ask—should we keep it at
> > 0.25s or extend it to 0.5s to avoid flaky tests later?
> 
> I'd stick to 0.25sec since it was solid for a week.
> I don't think the race window is very large, we could even experiment
> with a smaller delay, because debug kernels don't hit the issue. The
> debug kernel can't be >0.1sec slower I reckon.
> 
> IOW I hope 0.25sec already has pretty solid safety margin?
> As I mentioned last week - this is called almost 100 times by the test
> so the longer delays will be quite visible in the test runtime.

Makes sense, the test do loop too many times..

Thanks
Hangbin

