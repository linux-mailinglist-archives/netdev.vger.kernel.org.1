Return-Path: <netdev+bounces-177282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE30A6E8C8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5B188563F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1C2628C;
	Tue, 25 Mar 2025 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkqEZ/YT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACF4A05
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875444; cv=none; b=SNzvVVb3J+z4SirVsphiMCJlGa5/3JERyFMG6sJYqJOgi+QlJT1XvTKhVq74Y2GyTlS8lF63Ysj/3a1BTIPWUtzpovmgJz42we3AvzOcDS17HHwLQM/RkTH2hs8lQHPSJABhx7k6OYIuEF6wE1TmwUAV2w3whl8jfG/jo1KS1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875444; c=relaxed/simple;
	bh=x0yyyOw1xk/7k7kWECY5F8yoogY/p29NR/vP+32yyG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/9IjHQSgZfuAUt8Ludk7X3I/HU/mpl7E+iyPM+FajzqN/8YFDFOjVXViFloMtKmZ1/cwsGO2qQoXduvhMeAybZilRtzsbn/FJPQkpVA1gvm1qQo8o/rzNJktYoJnluLpqAAR9kXrQnu2s2ZxoEuRynQtaILr9ctdiSNX37LiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkqEZ/YT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso8822981a91.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742875443; x=1743480243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ANBN0ifgUZ5G+F5HcuKMuVd65mR1FpvsOW6ZAr/cl8=;
        b=LkqEZ/YTCi/QJG8xZfJFL4jPDKKCC8i1F2j3haYNPQE2NrcqMcfq1jVwCdzUuMHKmf
         d4I/PJ9495u5WifDjJ+jW1btnmmA7lEJ0QVvLDxluI72WX7h12bPwxK9FFvObgY2oy46
         6znSMV26FVmRQv+XVUC1+/a3Oak6Q2OkO1eOk27QgNGqe+h9HIc39L2dGthce2SXpopu
         Iq/ZgEOaQTOgDW127lO+OmB1SdgS+2FJECByXMumYlIZdDWw6T/l8wRI9W2QZtr5076c
         8a5k0719EXT4joWGv4OxPzPbMOUEU9F00xq4SUWfRYernfozGAOijcjsi+rCnS2tlqOA
         9fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742875443; x=1743480243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ANBN0ifgUZ5G+F5HcuKMuVd65mR1FpvsOW6ZAr/cl8=;
        b=wgMEc8u2dPpMDG8KFmbL0ra/iHB11Sh4NUiOjdpvewhhlCMN6QEB8Zewap516J+kU8
         CzESVbOEGRu/0crOgAXTjhkKP2Ev+XOBxoTw+El1WgHr1vnXL8gIX+7HPAK9ECIX2Rtp
         T6I+S3oeQHhQOmWP4DgY/gvqMtlbh6GgGWQt7avAoaWO2tp2UmvvpD2NHbxYdpz6EsGV
         vckhSL9qMt49r4IDF6Hqr+0vfq3BDoI5/dpzugcZcCJjVdqyE0pYhp2nId8NgNkxDYaZ
         xfW0+3VKArwWhGOhj++Nr76e938P5eMy51eNY/p3n9u/281u8TFdmwNY5p0/AhYaWzzJ
         bfng==
X-Forwarded-Encrypted: i=1; AJvYcCVNAm5vh2KGY7EvCIZt86oT5aMRbvfwfpWVkPHAPd4HTu4vLRSaHHAH/NsiZB4ui/MKaHc8elc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIsYNDMgq1F/M4v3xqwGnkhihRmt4BNHkc/7cSlIzoQ9EjNH9
	bfaFTTMUlN8ZD/Jvtv0+kI52JFnN9kUpbIi9AhxYWsoG5RPvPO0=
X-Gm-Gg: ASbGncvoWaSP00qkKjX1HIz4yQ+EcRiQGs3vupHI2Xfs/zjZr1sKnOXurEU5XE/i1h/
	O3gL5u5LvwIBW+c2dHqE352uAv2aEpmikrWBwL1UceMZBJzevpx+utW+kBlI3MG74mL0pxX1fZs
	6AAgaw85EiTuzpPbWp8rmDDpEBLkn8bNe9/ja07JcTY++sz2MWnofK/6n15LjVdl14WU9z0L8AT
	FtKu4QrhnZ/PbXqOeKaRnjIWPcCWUM8Q5ZHgHCIhEqdR46qq3FbrOGNJd7HWi3gqrXtVkbA0jC0
	8r7bfexoMEGKIXmZsVQIauv7unNHxFvVmOI84S1h0TsLpO/jHsVAaek=
X-Google-Smtp-Source: AGHT+IGD85PUgC+Y5TRZMmkz151qVB3B+d2IvtKYqQpWqbT7x8HkO4+H9KMPqhvqkqdT6UbybewotQ==
X-Received: by 2002:a17:90b:4a10:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-3030fe90e15mr26159385a91.9.1742875442463;
        Mon, 24 Mar 2025 21:04:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf5a1d06sm14483605a91.29.2025.03.24.21.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 21:04:02 -0700 (PDT)
Date: Mon, 24 Mar 2025 21:04:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net-next v2 00/11] net: skip taking rtnl_lock for queue
 GET
Message-ID: <Z-IrMQQ-mnQJzGyL@mini-arch>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>

On 03/24, Jakub Kicinski wrote:
> Skip taking rtnl_lock for queue GET ops on devices which opt
> into running all ops under the instance lock.
> 
> This fixes and completes Stan's ops-locking work, so I think
> for sanity / ease of backporting fixes we should merge it for
> v6.15.
> 
> v2:
>  - rebase
>  - only clear XSK if netdev still set
> v1: https://lore.kernel.org/20250312223507.805719-1-kuba@kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

