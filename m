Return-Path: <netdev+bounces-206193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520FB02000
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67A54A0842
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC412EACFB;
	Fri, 11 Jul 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IId9Hb+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07402EAB9E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245901; cv=none; b=ehjL2/AmW5NKiRfcUeeTy27PlpINJ6SG58Qb90zU3OIYtILmY4+CCB0ZDKMvmdxAbzzZSgotXlnvSyrMpU0n+Hxsh45cenqO+BD7oC04ByWhoUS7/tU5OvO3fkp1oO4Q3EoM1Do8uZ0jaJIad12ll33r+L6sQeI7h5a+ddmEi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245901; c=relaxed/simple;
	bh=Sya4IZecYhktVtfCvUqQruAjlPK6WvHM6B90iSMN2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjKj1/HcLERx55EGpj2iLhZX26pEQzvuYSPglcXarxl1MaM2A4FZ+zI0EUb/ZYN377Pq9v0n4j2EZdWlOkupSDYAfXNTYxiBV351/KFwtVJl5kX8/mHbPIbmLcDaNOwv9Bsy2uaWPA3j54qMjQlcjjeGdIJgUxFq1CNU0oWHNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IId9Hb+A; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5851764e1so42643621cf.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752245898; x=1752850698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=IId9Hb+A/p5KLntqBo8PCqBaELxv7TM8Xq5Wpq4NTGR6uTZyDHdUq6jqKU8zq3PlgZ
         35bWi2+DQHYJlvFghQlFUTxlkg2lyO/rH58DPHm8vQESsFtAJtBJ5t/oIL+2ZuXsuIFs
         RvBUxRXCRGZKM1M/Lxo+gpXIp+o/7pEUkTqEQ15I4kCF5yw6LPU+M3D+72DCvUc8ynde
         YYsxh1oYDPvl2CMN7LtpRdb3OW89ymK3nTtbmLNyA/LF5G4tufQYP3fHtq49Xr1v5RD4
         k5jEJeNREiAV6ZVRi3FUP1zYAVw8SefwV+3XiRh5lIj/u66tWNpMKpPTata1nWjzJQHY
         xJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245898; x=1752850698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=hM/xbWHp4Kx+A/TP+5f5wfnPpp6BPQwoTG9RNZEIMsGWBJSuIuKx/lqUfmU7ZXXVO8
         IzhG974LIkBCgAXGg0i9miocyhVEUSbhfukHMb/+h3F2V/CN6nb3lKEhV/Xi+j87NTUm
         1cpZyDDGX+qr/X2ycfrI0L1beI4D1F8ioEYzpBTTagrupdo56y34OC5dL+QyMWqq231H
         phSs95VI3OwW5YiT0YdtnHdUu5t4ls6EItWrOgGH7/fxVU+mtkg0YEQouPtrl6Z8BAUN
         eGYQIwrdBMYpbE3DKaPFhncKIxOxylHSQRbCHKOB9C/P0alZw/Yq58lRRp6VcniEmw2V
         rknQ==
X-Gm-Message-State: AOJu0Yy+eI0cbmOcMV+M7r3HiYev1OVFRrirDeQ8a4YwHnnnoTZzj5xe
	VXlIpreMyR/H9mbY1ITKBbVF9lOxfdcEGvlbgnmUjXb/Tjg3LE35h/Lr1Cf/7PwWvUoI844aeZS
	Arb9dOPA=
X-Gm-Gg: ASbGncuV51d22IArh7usPOshOlc+iZ46eSXAyiZ1R8CSMLx2+w3sZH9pEOAQTqVy0Mm
	BJN6oiICOdn7ljW+7LHOZM1pE9w9yuMXdKqJK0VbOhfzkaaAdy3LMR/rFL7bPd/ui7sG7yxtm4f
	VqOa1EKtt6+SnfG1eLF6s4JC217Y8i6gtRCQuXi8yrB2vGooScIvWmiPeezKqQkmWuSIbu+3u4U
	0yh38g/BCM3CHU9kZD3OlvRhVWGoVp9UdNy8/B5/2xyI5wZPKPD+GRR4v3HEnHG7XrXkIkjjTs0
	Nnfl8lhdYL47aIBdm7/w0NDlNG5jpwsjitcjmdlRCfORYvIQ42vV3gniRjiuNdfFXRe+miQbvpr
	rS7TSad3n0Zkr1wU6PLejHNiQReNQPJazlWCAXrK8h2/IZp1MIIBb77cLmim7Sw4G50iAWzLco2
	Y=
X-Google-Smtp-Source: AGHT+IHL89Heh4CdilUF5hG4UKz4fj2b51QwxhHDN537ydTZFAi50FvMeaNyPPTH09uspMZNgw10pA==
X-Received: by 2002:ac8:5d0c:0:b0:4a6:f6e6:7693 with SMTP id d75a77b69052e-4a9fb861a08mr57831191cf.6.1752245898221;
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc1b784sm22118351cf.12.2025.07.11.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:58:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250711075814.1f5ae098@hermes.local>
In-Reply-To: <20250711040623.12605-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711040623.12605-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:06:23 +0800
Li Tian <litian@redhat.com> wrote:

> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")


Should be Fixes: tag since the reference commit caused the regression.
Yes, it is a way to blame and track.

