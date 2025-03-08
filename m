Return-Path: <netdev+bounces-173184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D838A57C03
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0AA3B03D1
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C911E1E12;
	Sat,  8 Mar 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F70o9oYp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6D1DF97C;
	Sat,  8 Mar 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451736; cv=none; b=qx6oZ29ykkmQ9xHokmb4HLzDebXrpgvvAXHuISJ0E/poVmyrOsawaGVPiYuUPU0U8E+wHu7qffkqgDBedm2YzE7OzkGju5G1ulPZK8KBWg2tX6yO5gqGQ0qFRKAdI7roVod7eQUZNgW4DQOLqM9Ke3cxRDL2IX76NI0jIAvO7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451736; c=relaxed/simple;
	bh=RIwW7eO1EJwvrd3VVoMhJVapyB6IvOmF9aB7VdpAhZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZqEazYaaiZe0k2QtyGl/Sr4J2Izi0l3yg2MSs+HL2MXNPPqmQm8V8pkWDG5db2iZ6Hvh2/U48O0TPqWtcwN853pUOpy8UeWj+GZowPf1bCu7iHWmTqI3GfjZ0jcE6JbcmQmVJ/4Am0Mk5TaSV9E+4ZweSod17XEge6iRrstPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F70o9oYp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so3469094a91.0;
        Sat, 08 Mar 2025 08:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741451734; x=1742056534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2ixVN08UWIJynEo5bLIccBxGvDmgvF24wCvxvnHlHU=;
        b=F70o9oYpSWJ5QmWtw+8J2aOuRdrD5j1yLqxVS/BuKz16ZHgh6lN2Clwp94oNI+KsCJ
         WtdvPDieucUk+jOdir4fI+R9wenkEDMAREfZn2JU+Qn16nPd7IQZAZaWqog0uZWdICeA
         klzlVQjzKHZXsnHI3I3ex5emY05ZJcqz63RFoeadfjMuDJmPdIP5o/SKsFfFWFpMux8A
         FeB0HjBKbaAyAOWfI1yOYws0aKCo8M8xxtDyvQOOYOXLreaDaaK6eSazY4sG4gpedlja
         KvEYAYm15tYzlr1eB0xOTpSGSEqCB9iA/q7v37+TPJaQnnpuXf8oxz7GWzmjyhdiOUj+
         IGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741451734; x=1742056534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ixVN08UWIJynEo5bLIccBxGvDmgvF24wCvxvnHlHU=;
        b=XimYeHZSgF0DciO+3Pi9oWDNMphdgYMQ3e8vrjXjSco7bMm7ibWYDIyBCaJYMyKnLL
         CeJTI72OQRbGQ9xxOYIDc8JAq9dtsyvcPiiYJvvAIxO20D8U+R96w9122gJ+bk1knQNh
         BPu131iaRT1iWcTCRGGLHYEl9VHqWBLQcL7oDtoOtDQ57vuPjJ32+vTaRSyIEpfZCkcS
         2lS4/wCmXTvZ+OJk4IBhbAkj88E7MlpZ2tI5hANR2dyFQvBdWKTxV5JW+mC7NFbaRnRO
         r1UnqJxYzUOfy+rGqCJmPbayxY3ozV5NOXX7xOXSh7L1tTbsZHEeIxPF8aSGng1fM5ha
         msZw==
X-Forwarded-Encrypted: i=1; AJvYcCVwhRno8YNxNXsvqSjGhTDtM9qrX5Xk4K2AuY3wuhGxnkgR1dxzB/luxWRh9zsSFhkDTQj3dCVW37DfXuQ=@vger.kernel.org, AJvYcCWVrRgeUk2p9ecGXY+hLwjWRsQSZVfzsMHo/Pl/4nTKV5CxMvicvbpKhQ6ewsgAWzbOxyrlq45d@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrIwb/3snvoV8t1bwp1WspfkzZIozG3qpHt1Af8lxZqZzmeUn
	9NYHuV3d5FyMfwK2lgxgQFYNKYu8L0MyaICiKtCj1Gr7CHLwbIy6
X-Gm-Gg: ASbGncuIhfTskX0BuX2YYTgQBXduBCWX/ux43R+Pw+mkDwlcbSguxScUUsz5ImzexVu
	yQkpAbjVYSo47KLGePXzhBM8naQ1sHKROfpkDf9PXljvoGiSmpwG6/AgJZUzsrICK6Osemx04MA
	YEebcINxgTN32ej61hm5jNcGxp7q3GLHHSprYjRmMUaryYFyNwPLlxPKfetExNCFCYM1gWvyLFw
	lu/5i4Xek0/2pYUKR6seWZXmNMwmcuXH+2qY9v1190+5uBX7d/yepdTgC/viTKnRTScnX2n1+l7
	rFhJpcpn21yXKYIOkVk78aB/6S7Owq4avJOiXBI3/Z4EBxs=
X-Google-Smtp-Source: AGHT+IEllU0GwXPBCLuRcx/4+jszmSTr/axljfzv0oTkjgVskpmReKjT67EUiTsOqkWQmkdwuEEi0w==
X-Received: by 2002:a17:90b:1f88:b0:2fe:b174:31fe with SMTP id 98e67ed59e1d1-2ff7ce7b3c1mr12704804a91.2.1741451734474;
        Sat, 08 Mar 2025 08:35:34 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbdcsm48671545ad.51.2025.03.08.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 08:35:33 -0800 (PST)
Date: Sun, 9 Mar 2025 00:35:29 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH net-next] qlcnic: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <Z8xx0aN4vA7d-73i@eleanor-wkdl>
References: <20250306163124.127473-1-eleanor15x@gmail.com>
 <20250307132929.GI3666230@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307132929.GI3666230@kernel.org>

On Fri, Mar 07, 2025 at 01:29:29PM +0000, Simon Horman wrote:
> On Fri, Mar 07, 2025 at 12:31:24AM +0800, Yu-Chun Lin wrote:
> > The 'crb_lock', an rwlock, is only used by writers, making it functionally
> > equivalent to a spinlock.
> > 
> > According to Documentation/locking/spinlocks.rst:
> > 
> > "Reader-writer locks require more atomic memory operations than simple
> > spinlocks. Unless the reader critical section is long, you are better
> > off just using spinlocks."
> > 
> > Since read_lock() is never called, switching to a spinlock reduces
> > overhead and improves efficiency.
> > 
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> 
> Hi Yu-Chun Lin,
> 
> Thanks for your patch.
> 
> My main question is if you have hardware to test this?
> And if so, was a benefit observed?
> 
> If not, my feeling is that although your change looks
> correct, we'd be better off taking the lower risk option
> of leaving things be.

Hi Simon

I perform a compile test to ensure correctness. But I don't have the
hardware to run a full test.

Yu-Chun Lin

