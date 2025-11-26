Return-Path: <netdev+bounces-241940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A471EC8ACA0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EC1035926D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814A33C1AE;
	Wed, 26 Nov 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAlYW5Lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFB33BBCB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172820; cv=none; b=p3FlHKjGD9fGWv0S3BL++4xhHAYFFLBfcmvBlkZZo9xk5RUT12H2NesiwvOay3L0LyLY2/CoduQZgF+G9pN/Eb/gDy5tjTLWbn5QJPdorDYCNSaAhtnuoJTllN95tfPFHqCqHp4xv013q80dJIjR0sMkv0jtH0BHK+6OVfrf31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172820; c=relaxed/simple;
	bh=4dgOQdSFe09BlSpQ0D1vPz7WGtU4dRgFVV4sE/+Zdqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aua/FEQoTcPVDXJCLuRfabQW63m+v0g/FAOfNuitt0Z/CrFSZ0SyOQNGmfq3kgnZTXtq874bnBrp73p70oBkzFzK6CVeNKX2JQe53TSV+FHWFgZqYNiuNDdiYMNBZwax3qcR73yPG8GAAQlfTEyogREg4EZt1LpRTmbFt125IvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAlYW5Lh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2984dfae0acso107575785ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764172818; x=1764777618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dgOQdSFe09BlSpQ0D1vPz7WGtU4dRgFVV4sE/+Zdqs=;
        b=HAlYW5Lhcboo78KItzOwz+aTvGc5Xq9JLJZyN8W0i9VWBNHSfJwIfh5vHPd61ALkkv
         K6SUDzMW/ZuqSiqru/JyI+mKFAtSc89cx+6cWPLk0lRu8HvRxvybPz8cIJDOVUOROqfP
         dLwZfBf72FsOMZ6IRi13oc4Z9kMFtaNHBZuiPq+W/wIRk0jTO8k4fOcBEh81Qmi+68LQ
         1efMOZlj0RqNGRDNSIxvmkWDIdaJVbZ8jYVb+KuEk5+XxvoSEulhI6fNLSo0navcUge+
         hLYCcat74ouESqp+n7wjxO8gi4vLkrvJZAMsUXhV+A0CU28qV+R4ebCh1+WCP5yanwZf
         cNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172818; x=1764777618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dgOQdSFe09BlSpQ0D1vPz7WGtU4dRgFVV4sE/+Zdqs=;
        b=qnEpW0VITRGr/3GbEjcAPZXC/m32NE8OwuZbd/jcNZfKesNH8HmFe+g6q6hwssDkVf
         Whue0id4AYfBK6o9aDjdxAFjFTHjXwQiY7Rx3R1vZp5vUhEP4Tu/pPFjA2umBtnh7wKI
         mIh7qjKb3kwb+EFPAjw1ZrAS9ls4OtmPqtGsnuqS/fyUpgzKkyUmSYuXfvAplX0t7KS+
         gSnXfsKmbITG0HGtUFz0qmVX99ANQSJ8jXi4tnrXB7bjlPTOBBamjF7V+yPf88o3LDzs
         D4oKUcdZAT9ewp88AXQmzZbJooe/aFhUpgxBcM1ycXZjYuFX/WuKyauWXFUBwXb+vpB+
         vOSQ==
X-Gm-Message-State: AOJu0YzWdReJNPFpfE5N0/5uoOAWwmEzJUuFQTYLKytp//17wwNE5Th/
	aitAI8WaTK+9rqZJyb1Uh3MT4r5OFOiNGISAC6p9bc9pZ3TNB6krFece
X-Gm-Gg: ASbGncsScFqeS+8/9M6g8C/i28Etdqt47KdqhlCrPSI5ss0PgmP5LJM5fZORfVkLmKW
	okwFCrmFnooxvwQI7VasfVmdnx/UI8a0qqAf7yd0v8RIjP/vTqR+uMeJAwkXIH8+k1LuZJNthhT
	nEGrsKiwc2dDgJ99se+oC8c0HSrKpxlIHi/jrBdqKD7+5Ry3e14GhCWzc4EtYCKeCr85d+v3ReP
	t9FJoo1QHemz8QrequH3Djf7g1bmkQRIF03aup//tzgpx629XdURqPyZvQyqyHTlNWyVu8v2+ft
	XixQ35JK3DMgN0+Qp+iKV3h27mFFu0w7ENUVpvbRvAqpzBYm4kAMTtLgT2PiY5HCbxzatxkHJxh
	lDE47L/6DYltp3o2C4w5pnAP2V4r4GM+/gInk0hOXIgqoH9qXQFK7gBThas1l5OwQHSGRpmG39Q
	fZnkqCNpH5ymw=
X-Google-Smtp-Source: AGHT+IEN1dnseFjkRSCWJHAPzUAmJSqbWO1TSqAeJU/WodrPxU70FYq+iY4Tb9PGAoya/kU9IBj2tw==
X-Received: by 2002:a17:903:b07:b0:297:e231:f40c with SMTP id d9443c01a7336-29baaf75e00mr80206245ad.19.1764172816526;
        Wed, 26 Nov 2025 08:00:16 -0800 (PST)
Received: from fedora ([2401:4900:1f33:7df3:345:fd38:cbe7:7234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29d706sm199432785ad.80.2025.11.26.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:00:16 -0800 (PST)
Date: Wed, 26 Nov 2025 21:30:09 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH v2] net: ipv4: fix spelling typos in commentsending
 commands without the SCSI layer which eventually helped me understand Linux
 USB subsystem
Message-ID: <aSckCffx4DnQlGtz@fedora>
References: <20251121104425.44527-1-i.shihao.999@gmail.com>
 <20251124193121.6f9eab3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124193121.6f9eab3d@kernel.org>

On Mon, Nov 24, 2025 at 07:31:21PM -0800, Jakub Kicinski wrote:
> Please don't add any more files.
> But in the files you touch you should fix _all_ the typos.
> --

Hi

I have not added any more files in the v2 patch. I will send a new
patch for ipv6 directory.As for the v2 patch if There is anything wrong
or need some improvment please let me know.

thank you all

