Return-Path: <netdev+bounces-154685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE89FF721
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7920A161AC4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E09192B89;
	Thu,  2 Jan 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMLk1Hci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842018FDBE
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735808031; cv=none; b=WgEtfRqRMZRl96S0KKkcomhGDprBAnq2VBXROsteZUuxNZNclC1p7BYZdrSDrJKT9jBKCfQo2VzQKoi410MG043kjUvgpZNrjn/HM0n67qRCpaMdmvADwN5zJDRMtz2Dk7ikVTdsfZEC21pGUQp+HYY+iVfG52E5A1pvoSSdQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735808031; c=relaxed/simple;
	bh=A8WiaimXlPwPqWRSqucZEBMbK6rvd+XbVqJmFm8hBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz/GREois2oG7Fz58GZis1KP83wLLECMs+fSsEFsojfsLMXXj0rUjdWQnIhIThx/QcDJOptLemLC+UCWePgcJK4oXO+du5bR16K5gIRsOGy99CBrIANGMlRccjkJJ/kpT31DP1PsyfGh402yt7xiMQnt4iDXNqGVtcjOJNoW158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMLk1Hci; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-218c8aca5f1so189185495ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 00:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735808029; x=1736412829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg0YHzTon3pSEuzpAsXm7Skfn5CmXQOKEI95zFQGbjs=;
        b=QMLk1HciGXNIDNk9PpikVjS5n+tX246ZDsmV/8z9Humllz8+30EEGLU/GNgDZjJMNw
         kP/3KHgYpnBESzStih9f19hlwGd9+Q0RO+yL3V1WJ1n0vHpIUHAOV4/uxNrkRnnIXw+p
         FcXDa7puBBzsnNZ9BMZz+SuFwtG0+QKonLw5dx9wsRu6tqe/6Ix02I2u8uHVLl3kMQnX
         sYAIbysYT6UIPbFPZtkMSb4nq0UydLKK7c/P+WeGkEKzM4mbLQU9hbyXoptCVh6K5mpv
         EqNdGZmF6vICFHEUoDO/wNoDIYMVB01Vicy/2fRxzKPGAaukGl0aQVIFIQtvN2rDZ6t3
         slZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735808029; x=1736412829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg0YHzTon3pSEuzpAsXm7Skfn5CmXQOKEI95zFQGbjs=;
        b=J+sV12jc6fnkap6GDLBimwnAVsPMOPkhHH+cRKr28IuCWSVJBIttFx+1j19P8gdsfN
         lktzcc/tC8kcEh9y3NyLyGpZBl/AEwDCdfX1VwtH/6tf1kRXVIrnb1XLErI8xNEZIW7J
         XbOjJvc5rfaE2eYKaB7LZvV4RX8B3W0Fa9nrReRdPvqH87NNWM+ZAZ/7JutpYuUJax8c
         vKYcDnejHvjyjcEO2liVW9jE7w54mE2bDHDqCRyp+uaAvNaaOAlo8H2fVS/xYQGgca8F
         XBdsa8qZrZjhWsPaAofFqipV9lDflF/+DOXueylNP/svMZTG5o4DRnuNLnswynKjvsMV
         CvSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHFyN0dGuMBFUBaeYEyWze8t+NWrTZZRc1E6Zb54xRpZbaGkG6NJWqD+J4+lR0anaKM7qfUGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8y/uiTVPl5H65Pd4cY0zrbUzdeCkSpcNhk0kAT6+YrfcKcTCn
	jYXUnqm0Iy4mcxbmXhNPpFCYBE5RLCIiRjJD5R7Zd0wPHvj42eNSidwj5PG4+xI=
X-Gm-Gg: ASbGnculR3s9fC6wO6U+SuPGha9XVyljFV/gvd1ESaWmdJIBouOsJtU9WVdCtwB+S4z
	VdaKCzyq33hRejPTkghCFab/4R6Ci2IknnGDcwLjOXKW2HoOm6WR0+eErHeaQBuXIIDnMUN2F3Q
	gP6mUWmpc6t0RjvaYmWK+AuD3YPBbr5mFCVo0PVL0UH1If+0vsFTUvvVrJWuXlKgE2glRCrUltp
	uc9oe2edjn5xH8Y6ZKRFaM277fRpi18DIgaKKKDyLf5vxBgjDxPE5L+RMTxTg==
X-Google-Smtp-Source: AGHT+IEGpMIaJQn7RgXzFQWWKrSTCpELH0+oPt0mL7AmZAVOGLu0AAytv3Vs7SldLqmdgX5yUQukfg==
X-Received: by 2002:a17:903:234e:b0:216:46f4:7e3d with SMTP id d9443c01a7336-219e6e9fa68mr588929675ad.15.1735808029018;
        Thu, 02 Jan 2025 00:53:49 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7e49sm223246405ad.217.2025.01.02.00.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 00:53:48 -0800 (PST)
Date: Thu, 2 Jan 2025 08:53:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Octavian Purdila <tavip@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] team: prevent adding a device which is already
 a team device lower
Message-ID: <Z3ZUFq7dyiRHrdmi@fedora>
References: <20241230205647.1338900-1-tavip@google.com>
 <Z3ZTWxLe5Js1B-zp@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ZTWxLe5Js1B-zp@fedora>

On Thu, Jan 02, 2025 at 08:50:42AM +0000, Hangbin Liu wrote:
> On Mon, Dec 30, 2024 at 12:56:47PM -0800, Octavian Purdila wrote:
> > Prevent adding a device which is already a team device lower,
> > e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
> > vlan1.
> > 
> > This is not useful in practice and can lead to recursive locking:
> > 
> > $ ip link add veth0 type veth peer name veth1
> > $ ip link set veth0 up
> > $ ip link set veth1 up
> > $ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
> > $ ip link add team0 type team
> > $ ip link set veth0.1 down
> > $ ip link set veth0.1 master team0
> > team0: Port device veth0.1 added
> > $ ip link set veth0 down
> > $ ip link set veth0 master team0
> > 

I didn't test, what if enslave veth0 first and then add enslave veth0.1 later.

Thanks
Hangbin

