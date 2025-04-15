Return-Path: <netdev+bounces-182924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DFA8A5B9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D785017A470
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074C2192E3;
	Tue, 15 Apr 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYBXdZgC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E020A5DD
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738537; cv=none; b=dGDPC/45gNEF0jMELfdmEfEhwie/EEK1RScG58LMT+SKVwbblJGa0NgB6DA8nnkyoN7/P3tSGhU1Hpmertp6iVAnnYq+8DDJhdq1uj+Z9SHiqJxF0lFu/6e6zdeyTnSth05OjuIakY7JNhnW+wkwWqD62J0kfBBBRuJD/2VpnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738537; c=relaxed/simple;
	bh=Ld3m8ruGOAaLwQ6HR26Dc7iRgZB29WpKkUAcAKe/3Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLQkKOYyiVzPReN9bhbz1DA/Ecr8dFNtj20CWFu1FqtZiUi698b2KJzJ4Q6jhSHAUIN3XnTc8cXZhVH2Dcb706Ec0qxR0/AXpRvtHpjcay/EZVWJxOKPAzp/Bu89zNS68lwhWIo2CQjpsy7NxPEPVmdZOy9cPPuIkpgv99pwCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYBXdZgC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so57502815ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738535; x=1745343335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONefhX4MfqbQv7HcGYgu/3rI+EPRYXQKcHyYzrXe2J8=;
        b=dYBXdZgCkh+YtOdeeBCyOZRpy6v7Wcvw3sJAB5pG1Q21WwhPG/IjeFfZu3mLVB6wFh
         H1YaflzjYWNX4fUsmwtSAeXqtF6uhPrwGzDv3xrIsD6urDJ08b5JgyS6mv5dUiRdiSZW
         kjIw0YSfBfAm7RHr7mV+th1cqCSAhsnh/5jHZPZTfge0L0zqgJGsQEKG0nFM1Rkca+/Z
         4xnt56IsxynKuWeDHAbzgEUTy5AXpNrY9ahhvluSYHbmFblXqjbeaULsC2Oj+v/bQrip
         ZFqAx02PESYxec6Kjxp24ye/rPRooq8fjk1u3llj+PprVQHxv+0Omfr/lJHvwqcoxfzl
         Ypyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738535; x=1745343335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONefhX4MfqbQv7HcGYgu/3rI+EPRYXQKcHyYzrXe2J8=;
        b=hsYmifH/wRTIt2MvperQM4XwyZ04Nb/zRDTr/afxZgRmKZbzcefhPqZs9sqHRQy6VE
         DSefNZXyFYuRIxmTMnZlP2J6xPptAw1lIeOKCxNqB3SHnIN7bheFtAlHZAGBt0nlNi1M
         MQqI1L2ca/k1f78yq3d0xGIxsgB759dHxYxv2d9jcHKI6PWXtK8FC3Ma0FmL/2H+gPj5
         tkI/HLQ57GLyduZeJTDyMWFfuLegGe05vpysSQwQUUxtCbu8ZqxXUkwqSga5w78m32p+
         4kW+V8SFdcz51moqzTXEUoZQB3itGz1wJ2UmLomleU6DLntxCSJs4eKDmWOIHzfG+ql5
         89ig==
X-Forwarded-Encrypted: i=1; AJvYcCW6pWip+iVnjqO0VylDMBDdDvlT4vR81ig+u54iO3G2YZxVunfANovKkEEMSTkMaDUjlES7RYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOmzrm6A2E1qnCkM4RRDyba8oysqZ0ltD8CzJ0/PMjpKNCU3m
	dfWTV5H5qlRuG9iOKd+IdP/N+QLYqc1dw/z/ulaDta7O5SmXRjQ=
X-Gm-Gg: ASbGncvtcqElEEz117OMyzELTJbwyXJIRWtWhHxLatFv1GP050qxX/jsezHXdXBIMBJ
	LabfaiRedAFw4jn5XCgy7mI+KZEAqrpRs6V5lDsAddW8VqVkLp+K4UroAwVkxkwBw/miaySLW1x
	2Kb+u+sSfKCul7Mf5I6sNToQnyJAHm3knVLML90rXezJGlG2WVICNyFeURMaYsDq+BRkatDueHd
	2swkdRGbeauGfKSr1T4mf/Z0oAr3BY+xuPVP7va8896gWk8+rqjnECZf1tNEp8DyBC6Z3DryREj
	O5vpOFQrQ7vRJzwulrs74Uas0dxRvSJLRgUxTN9J
X-Google-Smtp-Source: AGHT+IEigG5N2J3uwg295A6znFl0+oN3Gr3VPTyFYq1yIFVm9T0Cx/rJV9j6ctYqB1zwZogq+wtoyw==
X-Received: by 2002:a17:902:e542:b0:223:fabd:4f99 with SMTP id d9443c01a7336-22c31a0b8demr106745ad.5.1744738535275;
        Tue, 15 Apr 2025 10:35:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7c9db26sm120037555ad.140.2025.04.15.10.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:35:34 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:35:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com,
	sdf@fomichev.me, kuniyu@amazon.com
Subject: Re: [PATCH net] net: don't try to ops lock uninitialized devs
Message-ID: <Z_6Y5iWvbDr9dmjK@mini-arch>
References: <20250415151552.768373-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415151552.768373-1-kuba@kernel.org>

On 04/15, Jakub Kicinski wrote:
> We need to be careful when operating on dev while in rtnl_create_link().
> Some devices (vxlan) initialize netdev_ops in ->newlink, so later on.
> Avoid using netdev_lock_ops(), the device isn't registered so we
> cannot legally call its ops or generate any notifications for it.
> 
> netdev_ops_assert_locked_or_invisible() is safe to use, it checks
> registration status first.
> 
> Reported-by: syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

