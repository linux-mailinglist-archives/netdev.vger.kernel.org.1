Return-Path: <netdev+bounces-158445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6AA11E55
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040B2169C41
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071720764C;
	Wed, 15 Jan 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYkTodFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46C1EEA56;
	Wed, 15 Jan 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934139; cv=none; b=D7k11mwfElJPKk2kd5H+5POYgX43muQVAqfilCiH0T1RS5+s50TFsRa9V+29X/ftu5HFZXBRCfEvS9H1/+fcPRaZ6n26OaJOxjhCrCm6OHAFn0G/SQRJGpv/SW32ckqjZI8x0yO4hVAaqMwXCEj175OB5gz9X9VINmt6f3644Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934139; c=relaxed/simple;
	bh=YSLhuyIPUEm41m6Yprs/vEHuG32fhL/GEm8iarCJ+rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOaFQiZN713NYnUogH2/T9b/JCVR03YyVfAwz4H3/7bKnDaBBYeoHSZEEVqEcv1rV7AKdcdQlwsUL6J9rYqoXyq17mjoVsziWMd8mjnxEBL4hE+5QI+I+sRx6pMYq049VIeQsPsvprgOdSwqSaTMEDeXWfhJkdpvv+E7VOk53cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYkTodFu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216395e151bso8443285ad.0;
        Wed, 15 Jan 2025 01:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736934136; x=1737538936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PCqI8zti+JreyoNdBnZH3j435qRqCZJzLrLfcvyZs0=;
        b=CYkTodFurNMJh9lxi+cY5lvQHzg9hSSrW8jJiSuJ+WiHx1R0f3EiTGIVobNTXDkasG
         /vpSpydWj5S/MNfMg4lOVkW7kkImYoUPbVKnTqZ6OikiZt8Yk5y6hTKAClvUGZn93zjT
         hlLfC7jqs5KZxQZDOD6dmoSo5tmYr3BfG0dRPgheAw4AYEOutTpY9VVtCRga8vaUfBnY
         g9wWyPrmXW4/+V0J0IoiXmR/SUbjkM1Gm+CK0pTiBfodRE2NISgfwaVRGbKmKhcdaoz6
         tvgyHWbkHfbzrIxZFOVmIGMXpoAEyZSHor9S9k59LVwql3nbGUAmrQ/h4FpoJB7iQS0C
         wRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934136; x=1737538936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PCqI8zti+JreyoNdBnZH3j435qRqCZJzLrLfcvyZs0=;
        b=hvTblhzgBqHHeOaciQLvT7uNCct5CJiBSYwVeZP3nSFKk2NJq9HhgcWwH5/+zGxWa2
         eOAQQobx3tkwgvZpeXJzvJS929WHp0mpTAyw1ubO3F2V6R+XbSbKu9+PuLQH4zgHqCXR
         gQSdNd8N3VDeQ82v3sfuS04NART8PGs7X84/3ap0hyu5MIHp2sBeFdVdFd/3DoxrQUUL
         WUWWgrFUZ0qAkFbMIwF/e6/bpf1JXiRvWnT8hG6tE4wJQq3b7I2mBTt+QNKGvq1HQPSV
         6AZTdVBiMTrtBkne4i7ZZoDN4/nynhvJ/qUNpL4Wv8q9zBrruwvXNwjqfiyGLKdLcNfb
         +Exw==
X-Forwarded-Encrypted: i=1; AJvYcCWWzaPbIfaWTG0XONyowJlzOKE3Mm651wRU5B3hlbVg8MJFAkFlP+D63KokApLRX2+MuQBXQ2MW@vger.kernel.org, AJvYcCWadT0BSWiFnFGWZW+HoA1VZUxCjYtxhdZt7iYMVsQToQ613Nm5NEeyazQm3VOALq99pamZDZjOZR6bDlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPT7vygoB90DrZ8zs9wVmOY7DxkU6GzOvfxy7x5ABG8/Gn0f1O
	EU49wSmNAWhlpIjXa6LiFGFwg5fkWtLqFc5HUGLEIK7ExzxCHdx5
X-Gm-Gg: ASbGncuXjIU3boWY+MyI8JXXq0jypkKMWJ0BI2QvUTfDMTikDGfNPiyt2frAgS1hNjG
	BdSm4+0aDaJQ+OYhcStl5NR9R/sHs0n3fIyFPx18ws25Bfn+1SNsTlaks6T4fmJJRFcRgug9mno
	P59JaIHqxGxAwU+p4UeGg5lhQj+NcA8gF1PcSf06igdSbMQY9hucxR3ApSosGduLzhpGpxa/Ysc
	mMiAmJh+Euye1xFkv3SwzSjX+hdWCZ5wZySrAr07Rk9qQ5IUfJXbQ==
X-Google-Smtp-Source: AGHT+IEViG1woM9PBpD214FVNA5t8I0lr/5QhyHOXXzSPsB7NE7bv6dDqxK/aHWRPpBH7PVcTN1sCQ==
X-Received: by 2002:a17:903:11c6:b0:216:3440:3d21 with SMTP id d9443c01a7336-21bf0d36eb5mr36020345ad.26.1736934136335;
        Wed, 15 Jan 2025 01:42:16 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f97csm79689865ad.16.2025.01.15.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:42:16 -0800 (PST)
Date: Wed, 15 Jan 2025 17:42:04 +0800
From: Furong Xu <0x1207@gmail.com>
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net 1/1] net: ethtool: mm: Allow Verify Enabled before
 Tx Enabled
Message-ID: <20250115174204.00007478@gmail.com>
In-Reply-To: <20250115065933.17357-1-chwee.lin.choong@intel.com>
References: <20250115065933.17357-1-chwee.lin.choong@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 14:59:31 +0800, Chwee-Lin Choong <chwee.lin.choong@intel.com> wrote:

> The current implementation of ethtool --set-mm restricts
> enabling the "verify_enabled" flag unless Tx preemption
> (tx_enabled) is already enabled. By default, verification
> is disabled, and enabling Tx preemption immediately activates
> preemption.
> 
> When verification is intended, users can only enable verification
> after enabling tx_enabled, which temporarily deactivates preemption
> until verification completes. This creates an inconsistent and
> restrictive workflow.
> 
> This patch modifies ethtool --set-mm to allow users to pre-enable
> verification locally using ethtool before Tx preemption is enabled
> via ethtool or negotiated through LLDP with a link partner.
> 
> Current Workflow:
> 1. Enable pmac_enabled ¡ú Preemption supported
> 2. Enable tx_enabled ¡ú Preemption Tx enabled
> 3. verify_enabled defaults to off ¡ú Preemption active
> 4. Enable verify_enabled ¡ú Preemption deactivates ¡ú Verification starts
>                          ¡ú Verification success ¡ú Preemption active.
> 
> Proposed Workflow:
> 1. Enable pmac_enabled ¡ú Preemption supported
> 2. Enable verify_enabled ¡ú Preemption supported and Verify enabled
> 3. Enable tx_enabled ¡ú Preemption Tx enabled ¡ú Verification starts
>                      ¡ú Verification success ¡ú Preemption active.
> 

Maybe you misunderstand the parameters of ethtool --set-mm.

tools/testing/selftests/drivers/net/hw/ethtool_mm.sh will help you :)

