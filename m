Return-Path: <netdev+bounces-119928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3F95785E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFBC2828ED
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33771DD384;
	Mon, 19 Aug 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoGoMpzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B615AAB8
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108848; cv=none; b=CK+ntBYkEKOOkCqVOnlEHegBs542uZXmz/nygdoWUNmRoPcy0Ztwznkm9KNoZL1FURkwa60qz5vA+4UZhY8ljymgnMLr6jqpuK1tEr4NKYxBtSqPbbJSQCJoR05MK1bLWqTGNEGzYCjzcLObBTpVpRoe7v4W4Acg+KRHWVXGP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108848; c=relaxed/simple;
	bh=S9VEEGpGe7/nFnP8HNkfXZvi9SUHWX8PgXDcQ/2d/u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/lp/jqyIEaDvDIZyrOAIwcPxKBJ3KYZVGyUYs3FW35s3XuAsuq4KEHu75kNj1nRwe88Sgq9l++jMg2Vp22ffGrsRqaw0/YsBYI9HnCh56fnlaLdjmJUqRJm28BEL7zJf6SGeHaXOxsSsF55VBREVjeREyXc8E8agWysQCZImKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoGoMpzn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202146e93f6so33148855ad.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724108846; x=1724713646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STjIv1So/KEZnujCiw/3CsB2QFA4v7WDP/H7a9T55/Q=;
        b=NoGoMpzn/oEflyR1leR2atVNxgkHz8/YC7WL1PbJV8WGK7qBS5hmGTflfDa0adItMT
         iRM1Xa7IsF+/t3S19/XXqNDd6SoYmLh455VwnWyjwcdj+Uk1hqUT5Pg/LWKZrrp+43JM
         DragwpB0X0hess0Mwcr3lKTmffirTjdryZyP/J3469AlVLthAzjjrBRl8gEo9m1glww6
         8Hc8WZkyOs6FjLXVfG8QF7rB8JTcmFUwzTnP9OHftPhImfwePVP3BV5Zw6n04GlcXSdx
         EwslZ08//bD/+prdqLHjMEBe0V1kObk0uQZBgIsDQAdETiyjHnVIT8vqii4y/9gu8CfB
         PuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724108846; x=1724713646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STjIv1So/KEZnujCiw/3CsB2QFA4v7WDP/H7a9T55/Q=;
        b=KPBzUIF2hLFfg7izvIdQXQot5NsWw6a57obSpGurVeWBwGaOIDMtl/nRCmbYC8fZbU
         Hcb3pThEqGHNAlzTvSKX7TeATcrOTkTuW/JrA19uWIBxqE6Pry2zP3LCQG7Y/2VvyW2o
         W9ydwTC+gtUfZa91Gqw51h5BCwPAMLEg1JapASfyJt6VWAyaZFJrv5adGuTFbQ2q4mcV
         Ey84H06XTM5fgayB8BWTaQ3i4jjZmHCdqetAigDGmAoDNImpc9RUI+bvbLp3/BkCmulE
         TZVQ2ehWMCeeIBJ1EJm0LjeKANgHF3ruwPoYWUHxuhuZ6ubSfWIVrWHAH8tb7dWiYUwc
         imGg==
X-Gm-Message-State: AOJu0YyfisP21U2BqpGo8qbF2SpuggII8esNoEGpWIkwAY6DQxY6XpXG
	Fp8hbVmL9axu6oEh72f41fTrDNfJ1BW9GAV+GNBStI7+g3z20Vxb
X-Google-Smtp-Source: AGHT+IHJ7eVZyntyMsZDwZPWfg/rp1yw1pPIJ9EMUqaG+lDWTKr6kH929zhDeDm0X1CzojhDO3o47Q==
X-Received: by 2002:a17:902:da8b:b0:1fd:a0b9:2be7 with SMTP id d9443c01a7336-20203e50d12mr161482825ad.13.1724108846593;
        Mon, 19 Aug 2024 16:07:26 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03933e4sm66647755ad.211.2024.08.19.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:07:26 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:07:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <ZsPQKN3j4GvGgcz9@Laptop-X1>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-2-liuhangbin@gmail.com>
 <20240819143753.GF11472@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819143753.GF11472@kernel.org>

On Mon, Aug 19, 2024 at 03:37:53PM +0100, Simon Horman wrote:
> > +static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
> 
> Hi Hangbin,
> 
> Based on the implementation of the function, it looks like it should return
> 'struct net_device *' rather than 'struct net_device' (a '*' is missing).

Sigh, I noticed this but forgot the update the patch.. The build also passed
due to missing CONFIG_XFRM_OFFLOAD=y, even I added CONFIG_XFRM_OFFLOAD=y to
config file. I need to check the reason.

Hangbin

