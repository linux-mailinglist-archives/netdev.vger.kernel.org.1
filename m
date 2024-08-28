Return-Path: <netdev+bounces-122557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00334961B4D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A796F1F24566
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E811CA0;
	Wed, 28 Aug 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We1Q7LAd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B51224D1
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807686; cv=none; b=kRs27PvUXVVgPgIUD5xowYt0gacY1rZNfpKvMDEva4qTXDdUic3a4J4JEUu07e8mU6T3NY7IYCdI2wUnHAO7qB5PM6p3Z8wXI4Hn/K50T5NSUqPY3YdAJpXGlDUSr5MM26RZ/JrNfOmE5jTXKT3cmLzweJZPdB21hkH3GHPhrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807686; c=relaxed/simple;
	bh=3b+L74gq64OIS4dvdJeKnBJJ2ruR+DL4cW2HKIJ0QUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsrf4a3sfXS6wsecs8XAmvxBcM0QfUPmd1oQ5AnbCvvEg+72wFePQdlTTN4zo6fBS3KSIsx48nE8sZjjsCRubSC9NscEV7XIWTq4QCNH6B6IpyHWOesERIwah44WW6LplEGbBRbw9ZhqhlMOfzEwavCgBtG0C7Wm2QWkeA9AO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We1Q7LAd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4441592a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724807684; x=1725412484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXX0mppcgky/qmevz4q2sDCXCAoRcVgIJfb18HWs2EQ=;
        b=We1Q7LAdIKbuXVtC5L1AdW+pLHK/gOIcC/eA2MSXDW6bbvaNlX91tIgJ7w9s4nr8Li
         dyRbLnd73fUaQdZJDeRadg2pi30EA8wlT2zFoPUxQ97QXfxLzPCK3NO1mwlE74zO7Ngb
         po96eW+TXHQqcZa8YSqr1fXu+GPOPAt6BDuYX86i3lrDh1Ez6H7NcAU9oPn66M7jPc26
         EEI4mh+6+HHUGq1+acJSHOaYm1HH6JmubpzfdLyDAAvdHVC+D1NprRFja5Ty9h5wqDrF
         XpqxY5yMG55hWOSbjge/fj/5NxgPKb55oBT6O1nfkZ3A9n1a69aaszSkDCEy1pyBZF+w
         qK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724807684; x=1725412484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXX0mppcgky/qmevz4q2sDCXCAoRcVgIJfb18HWs2EQ=;
        b=qvTQMFyOWQwr/5rE58W3pBlLUpOl3+plz7v/XRTaqDWqS6r7mI06L0lVM76+PZdchX
         KTrRa43L317N2xFFao9YvOjvehRRwrCJLv5PWQPdC3bZlYuQM8/8Ev4BZfz1PgCHULim
         78PRItHN2MbdUXid5+Y9tVKureEM4bDv0IE7PebBZ2kniZBrbJnlLWE/Sjy8BNf9Rcil
         j9YLujMNf0V+SEtba5i36Iik+ttjqVHJ2T7gAmTw2eWn/Gl2kmTjWZJpQ0NI129zIpbH
         M3w9RuMvn6DIaN7b10ImNR8KRBQt3nltb0kN5QkdJvE24VeJJdD9mcAsJJzcvNAmKFUI
         OJ6Q==
X-Gm-Message-State: AOJu0YzdfI3n4aseb+kqVyM5wKRJxCmRhlybQqWyH8B7L88HgVW++xJN
	ZYENMMocLYtCGOm54N95/glcz+iIDnx1UkKwMelOFDV7UyzGzW+E
X-Google-Smtp-Source: AGHT+IHHp1UUTzLbUuDurLM/+9ezeJQLzsSV6duvDgGd73DOEhdgEoA1F3o+q/Xrfs8S/hynu+8BzA==
X-Received: by 2002:a17:90a:3047:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2d646bf0e04mr15795954a91.20.1724807683709;
        Tue, 27 Aug 2024 18:14:43 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462d22asm187367a91.32.2024.08.27.18.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:14:43 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:14:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <Zs55_Yhu-UXkeihX@Laptop-X1>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
 <20240821105003.547460-2-liuhangbin@gmail.com>
 <20240827130619.1a1cd34f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827130619.1a1cd34f@kernel.org>

Hi Jakub,
On Tue, Aug 27, 2024 at 01:06:19PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 18:50:01 +0800 Hangbin Liu wrote:
> > +/**
> > + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> > + *                  caller must hold rcu_read_lock.
> > + * @xs: pointer to transformer state struct
> > + **/
> 
> in addition to the feedback on v3, nit: document the return value in
> kdoc for non-void functions

I already document the return value. Do you want me to change the format like:

/**
 * bond_ipsec_dev - Get active device for IPsec offload,
 *                  caller must hold rcu_read_lock.
 * @xs: pointer to transformer state struct
 *
 * Return the device for ipsec offload, or NULL if not exist.
 **/

BTW, The patch now has conflicts with latest net-next, I can do a rebase if
you want.

Thanks
Hangbin

