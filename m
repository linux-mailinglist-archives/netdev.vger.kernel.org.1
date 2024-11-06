Return-Path: <netdev+bounces-142330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBE9BE487
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E611F222CD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443A1DE2BB;
	Wed,  6 Nov 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FSvpKXqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706901D6191
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889881; cv=none; b=nuUxHROmHVOfhvEFI9iBjW9z56mucwrO7WTyjNMn6WLbvW/yeUsEFYduxT3mFoi1E2MjFxpYavH72dlfKyw/iqxmbeTgSzcoLVE4gRj2jpFFEx1hiaKwclnYoxnK2se1EWAEtjE9FqgheHa4wyzbeLclrMSH8FqVu5SMlGB6yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889881; c=relaxed/simple;
	bh=wY+Ghtl8OHCmvO4RRUCKxlLE8oGioKjRaRQoDwHsEdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtWdLnsPqc6Y/g1F1y/HRSU9OsMyceWI2/d9026NuvulNocbWiz/w4M0rzoP1kSEav8g+HJhjmUjSa97yJaS0IKQrUEMIozVifeWzpJHtoLxhfHgWlQghyi7hQ3P8zR0okm0DFCQKKEXJmc2JJek+b3TR+Ujpa828VARBp8Re1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FSvpKXqr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e3f35268so7961564e87.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889877; x=1731494677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62qh646GpvjlP+xmX9TNCRorlHO26GssuL6MxAV6gSc=;
        b=FSvpKXqrWSCvnkIXh6hpXegTLftkznSetfQfZj7eXPw9Klboan4Q0i1iijuVcKyF6o
         bBWDOfa17UafpPoDolWYIyB6SiXxyO/Yk9b5uiz1mLr7SoN/bbzDVfZQ7MGFkH6ohvrz
         iQBYvUa9HDCqkRkSd5VhoutugNvE9iRJWA85RW8s6uRbcsqZfJV4iajhLr+RYp4eoak7
         fiPptsibxJKHTfBoefYvI0jmzyuIjEjk+VlJlauhXpfePEIr4amdf4DBLSa/F847EF3M
         s41lPIo0YseNxOcUlQZT0MWkJ9DZmZHQYyLG+CTm27TKgxPTHClhlNLK3iUEfqCQm13K
         A0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889877; x=1731494677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62qh646GpvjlP+xmX9TNCRorlHO26GssuL6MxAV6gSc=;
        b=htWl1XthzrHD0GXGOjkwcAI8c74R6Zh3DKM9l6Liync6SRST9GTDnl/xGcIVXd0feZ
         kQ8hUptFeRVMdQG8VeOxioSstV/cK2RRHsLt0gHN1jN6c6UMiy9cNDuAJuXriR1gGSQq
         PXuLCBh6am6ajgMRbRVD48nkP30O/6X+MVuUlUKV+GIO4yzyAUSAZ4Fv/V7FdV41/JnP
         rb+tLigZubjBFzUKMR7jskRmM8GCb65wJGAOtx611HqC1Jv+PnDS+flFdebrrgjsoH9y
         xjuufU0QR3shaEcrcHj2ytsSjIEIlfEnIgPcPL49Z5osyc70fpbES+LNpmJjGmKkGkrB
         pH+w==
X-Gm-Message-State: AOJu0Yw3QBNLHacd53lt/r0Xx917eIoPEHl4Z5Yk4LFS7e7tm/P0BKqb
	YeH1bg1PAYbFLbpUq1qTqENVg7V8UsiORoHu/pIRR8xancQZcCNSpSe5YiMrf0A=
X-Google-Smtp-Source: AGHT+IHKOvVmGpDv0Rb+QaFKzxFEmBF5i3SaGTPXbYLhre4LICxHFGg6QqXrN7uVueWwrpLpqhT2qg==
X-Received: by 2002:a05:6512:398d:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-53d65e1abc1mr9195064e87.45.1730889877511;
        Wed, 06 Nov 2024 02:44:37 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce69esm2428924e87.157.2024.11.06.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:44:36 -0800 (PST)
Date: Wed, 6 Nov 2024 12:44:34 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, roopa@nvidia.com, horms@kernel.org,
	petrm@nvidia.com, aroulin@nvidia.com
Subject: Re: [PATCH net-next] bridge: Allow deleting FDB entries with
 non-existent VLAN
Message-ID: <ZytIkgDsKaallC7F@penguin>
References: <20241105133954.350479-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105133954.350479-1-idosch@nvidia.com>

On Tue, Nov 05, 2024 at 03:39:54PM +0200, Ido Schimmel wrote:
> It is currently impossible to delete individual FDB entries (as opposed
> to flushing) that were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  RTNETLINK answers: Invalid argument
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
> 
> This is in contrast to MDB entries that can be deleted after the VLAN
> was deleted:
> 
>  # bridge vlan add vid 10 dev dummy1
>  # bridge mdb add dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge vlan del vid 10 dev dummy1
>  # bridge mdb get dev br1 grp 239.1.1.1 vid 10
>  dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge mdb del dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge mdb get dev br1 grp 239.1.1.1 vid 10
>  Error: bridge: MDB entry not found.
> 
> Align the two interfaces and allow user space to delete FDB entries that
> were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  Error: Fdb entry not found.
> 
> Add a selftest to make sure this behavior does not regress:
> 
>  # ./rtnetlink.sh -t kci_test_fdb_del
>  PASS: bridge fdb del
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_fdb.c                      |  9 ++----
>  tools/testing/selftests/net/rtnetlink.sh | 40 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
 
Nice catch, I'd even queue it for -net. :)
Of course we should be able to delete anything.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


