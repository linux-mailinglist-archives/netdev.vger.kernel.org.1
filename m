Return-Path: <netdev+bounces-185490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16705A9AA1B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B0462DD8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3822128F;
	Thu, 24 Apr 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8wui8m6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AB214A8B;
	Thu, 24 Apr 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490317; cv=none; b=qbxJGSZuq7b146pY2l+gQg9144Nku62NtzXWxq4pu2AaK1t/yvWRPvhFiLpiV2QcHVo9tLHlPzR7PFFQ/RzeWUqa1ejz5B71zK245VCFd2d7Ffe0kNmYqDuMvVOnZ7j+Oia5E3CbQb8nVR+2T2lu8EcJHqsq/VBWRQsR4800HS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490317; c=relaxed/simple;
	bh=dq3SEv/mAr3Fh7AUnlDUbfcGx4Y3XJcuMQH+ODPQkq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzWieb7ldsS1o3jC1HCMXX8d1K3whWjS9dRGjhdEW8sWmHLFNGdP5OAaFeII8HlMgHjMIc0BEak5p35lcn/oEtJvpcVI+vFQAfbIjY6y5Ly2Y7f5/LhH+nFy6Azfkqm2riOiSur1A7rOZM8q0OntiroPM4gkwCrbnw2ImSThdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8wui8m6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61a18c05aso128473a12.1;
        Thu, 24 Apr 2025 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490313; x=1746095113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZMp6B5mpmeFYGu6EDH43QaBIrfAmtdeuZxvgFBICYw=;
        b=i8wui8m6946OWsfKNt/56p0nXHkXQ3c2jBZKPmkf0xkexBrQlkD+ZbYgoDYm1U9dtg
         3eBgJango6xrIeYGu1VglYyH4DXRVNwEQzFsX3LOCzdqA2ZsOgR4ty4I2yR5mozTMNs3
         qj16/56O3WSoKsjODg0axi695t6lL+07ZnK5NQ5ga31WQ/kbHJ/5wkx0P7hT+ulpXZAY
         sfUhkwEtvZewGIoG46YkzlcwDLgDEV82xUgMIa/2xXvl0xZWbZWymqPW1jyZWYgjgVBK
         aGTBNpXMm9g5khDZUX5rkzyKCh0gmth9QKICrza0joIyaDoNwPVT4tij7GBu99lubblY
         AQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490313; x=1746095113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZMp6B5mpmeFYGu6EDH43QaBIrfAmtdeuZxvgFBICYw=;
        b=a/T+OD9qZYdyZHqAjQ+eUiA46DUWcpFMIDpwtI/AVzDWpbMg18orbxTN3hsiyUhr+K
         4cymIiRbWznVcTJ0ybJ1U/SmGJNR4nurx4CiqgSkUiuNqCxMPUnQRehEvqP1EvQQLGnM
         qE+Akkq8vY2c5ml4EVTbRbRXunza6/bbmhTQEK0v9F5IUn2N6cTq0VroCrttrViNZYKk
         8J15ddDvptA23EsXb6rTOqn4KRGkSLcyJiBEC8/jXMwUGILs5fGeUU/whubbbvOHlnKt
         ZstonNKKzbxh0jY00Ct631F4Z67jDBhP4x841rZ3K3/HTesyh+6m9KezMUreip1q815b
         YH2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEFSwdNrID7cP26BBCr7MOkDJclYn0feaoIWJv3ajzs++a1xLfzGDryL4GS/EdCCuSTCZlcqNs@vger.kernel.org, AJvYcCXRMb2C9DBWU14oxPVJRum7yQhjPPRH3dWv4Z7dNNfX8MNdBvu1IJTKpRJp2xkU6LmjIJ0ztvFuWbkYxh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT5lFNbLjazSF5UK/2bmW9pCLoxjj2C6Q+3SryEV9jchGHzA7
	3MBC0dWad6xbc5N4ZmRrZ2DQv4SekU6Ygu1VRGV/TuI0vPxtRY+Q
X-Gm-Gg: ASbGncuGXHloT2GhazIuMTSA6htBeRGCCcjBdez3/0l1uW7AUCHIsdHA/gJbTRYQase
	DesaOUdCtGeBO/IfUJ/M5qM+J4/t3dPTgQ+FYKjRB0bBZMa9vTV5NhX1W/MMjMKR8dkV+brIalW
	vQHRFq+hCqah6IzhfsxmV+suzcpOZk1M6W9wF6t9O1FdAVixoVptoQtfsNcV14FNl321Jatc/CH
	L9fAm2l2A+/1vjyI6hSg5DunTEOpkZ/v8dB8laQf+exbfAAnyZvWEnnCa/3qdoBIpXbKO7S+Kqy
	DvmALbPWT12JzeXtQOEojrgWalp3
X-Google-Smtp-Source: AGHT+IG8MYu06ujGbb7kKbPP/EfBk+GYNRAuV0slFfvCch4wK1VUGdi9kwB47zwnFSLbeAuVCEdzkQ==
X-Received: by 2002:a05:6402:3584:b0:5ed:c6aa:8c6d with SMTP id 4fb4d7f45d1cf-5f6df93668cmr708490a12.9.1745490313090;
        Thu, 24 Apr 2025 03:25:13 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6eb43ea92sm941608a12.25.2025.04.24.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:25:11 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:25:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250424102509.65u5zmxhbjsd5vun@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422184913.20155-1-jonas.gorski@gmail.com>

On Tue, Apr 22, 2025 at 08:49:13PM +0200, Jonas Gorski wrote:
> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> will add VLAN 0 when enabling the device, and remove it on disabling it
> again.
> 
> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
> dsa_user_manage_vlan_filtering(), user ports that are already enabled
> may end up with no VLAN 0 configured, or VLAN 0 left configured.
> 
> E.g.the following sequence would leave sw1p1 without VLAN 0 configured:
> 
> $ ip link add br0 type bridge vlan_filtering 1
> $ ip link set br0 up
> $ ip link set sw1p1 up (filtering is 0, so no HW filter added)
> $ ip link set sw1p1 master br0 (filtering gets set to 1, but already up)
> 
> while the following sequence would work:
> 
> $ ip link add br0 type bridge vlan_filtering 1
> $ ip link set br0 up
> $ ip link set sw1p1 master br0 (filtering gets set to 1)
> $ ip link set sw1p1 up (filtering is 1, HW filter is added)
> 
> Likewise, the following sequence would leave sw1p2 with a VLAN 0 filter
> enabled on a vlan_filtering_is_global dsa switch:
> 
> $ ip link add br0 type bridge vlan_filtering 1
> $ ip link set br0 up
> $ ip link set sw1p1 master br0 (filtering set to 1 for all devices)
> $ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
> $ ip link set sw1p1 nomaster (filtering is reset to 0 again)
> $ ip link set sw1p2 down (VLAN 0 filter is left configured)
> 
> This even causes untagged traffic to break on b53 after undoing the
> bridge (though this is partially caused by b53's own doing).
> 
> Fix this by emulating 8021q's vlan_device_event() behavior when changing
> the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so that the
> absence of it doesn't become a red herring.
> 
> While vlan_vid_add() has a return value, vlan_device_event() does not
> check its return value, so let us do the same.
> 
> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Why does the b53 driver depend on VID 0? CONFIG_VLAN_8021Q can be
disabled or be an unloaded module, how does it work in that case?

