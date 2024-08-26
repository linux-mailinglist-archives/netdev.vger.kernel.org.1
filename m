Return-Path: <netdev+bounces-121842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31C95F013
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5C6B228D4
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7B155A53;
	Mon, 26 Aug 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Jg+gnVXN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E04154BFB
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672663; cv=none; b=eG/pHtHRjKy/9oysNw4XuCxGQWQIH6dvodH4IaMOI1Z9AMprK6f/3TSZPSSHsNuaZ43U5khbjvECIyYjEtSAJ1RJ0TASPucKDPr3J7L305E5gxpe429k+UiJfEtM13/7UmcMhchHdSxTNETVO42G5vNNLY7cetSKnfCL3ugl3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672663; c=relaxed/simple;
	bh=Q0WCBQ+YQhJIRNMx8ZqrxOmrXT56oBALfKJQmsCvtjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsFZXH7wawA0ZbtZ/+eqB7SL/8VgHINooHei6uorWW88zQ0gtzgBkMmmJvR+wBUsF+4rJfndtjpqaQffubiAwpZgkfIEkEHv9CUPy5BLYQiDZUCID5Rtnpb3ob5szofUsquX+BT1+Hxw06lK+foCSyF9bQO/RGomQjw4M7aIqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Jg+gnVXN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso37694645e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724672659; x=1725277459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=Jg+gnVXN47c4XZ/bOLnGZ+jCShSixFgRKiR3S10+NjKVG8A3+nen0q0/G27JlnFSsZ
         paZVCYJRR0pJZEtASFwZMWqjtEN9OfGX1HcXbb/nvHoQytjSMdEr88EqW6VwNcPY8SSN
         E3W/u8C7vtgf0NeIo/8N9CoCnp9Kq6F+TwH2/gCQ0LhmLIsJFfm0eIL5MGSfHDkMHMDN
         ZweNRtTmvN+HWVo5syRyXqq+o6J7O+BWpHRF3y4s6XSCW2p65muWqQp9tyzfW45k2w/0
         AXyim/u8MDr98fCv36vXSI8D8fsCzi96j7BinzFzKhY9djvBoewLVHah8ELlu/UOPaHm
         dbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672659; x=1725277459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=pN3r/GkJH7DSKElORBiLh3quOIxkORvJmjiqDs92JgGB/84M2nwVlcFV0x7hiFB/Ge
         2/lZ7vXXaePpROwHqof2X8/JphEagE0t4x2SQjM2K7hTZSOq4U6B1X/1Gxsdput2DR/l
         4Z6m/xY6oV7oenaFpF1x8YY6dWzq8Co4BT3TB+HVzC5KTMd2O/3mU0XI0TXYYZgNRNLN
         pGgMx2uHm6o2hiJVdHOkRWdTk/ZdydDu4sbE6cNOhKwyF9g1GmSh8AcgnNXHuLRbf9p+
         pE7rTCLSvder6acsQZhLjKC5Y7+n24+9uFXLKVldn9xIf9t2hkF4mbELbqd0jAL3bcoi
         XqhA==
X-Forwarded-Encrypted: i=1; AJvYcCU1u4t4ExRE6TCfBlsO76TUjgDkflHWV2nU+2NxzEwG3tYYj4Rjo1SRGXB7pF55qXEHodxNnPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmYJbuEHkH83RgqX8g+6vmGhMeAbQ+NrzQQtebu/PAuKpU54p
	Lfwqtws7FCwEGRvu9uU8eXlADt3d/V5FyN1yK1HuyzY1vmDgTKfTLuijcN2SiLc=
X-Google-Smtp-Source: AGHT+IEmvcGc7wd4ir9DzV0B4XPRNnCMACGg2Jljc1sciB66eE9kAhJjzoAZa61suLeAH/Jsj+VoBg==
X-Received: by 2002:a05:600c:3b90:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-42acc8d35e0mr64320925e9.6.1724672659114;
        Mon, 26 Aug 2024 04:44:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811044bsm10569394f8f.23.2024.08.26.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:44:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:44:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yan Zhen <yanzhen@vivo.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] sunrpc: Fix error checking for d_hash_and_lookup()
Message-ID: <ZsxqjkYDk1k0EbPn@nanopsycho.orion>
References: <20240826112509.2368945-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826112509.2368945-1-yanzhen@vivo.com>

Mon, Aug 26, 2024 at 01:25:09PM CEST, yanzhen@vivo.com wrote:
>The d_hash_and_lookup() function returns either an error pointer or NULL.
>
>It might be more appropriate to check error using IS_ERR_OR_NULL().
>
>Fixes: b7ade38165ca ("sunrpc: fixed rollback in rpc_gssd_dummy_populate()")

That certainly does not look correct.


>Signed-off-by: Yan Zhen <yanzhen@vivo.com>
>---
>
>Changes in v2:
>- Providing a "fixes" tag blaming the commit.
>
> net/sunrpc/rpc_pipe.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
>index 910a5d850d04..fd03dd46b1f2 100644
>--- a/net/sunrpc/rpc_pipe.c
>+++ b/net/sunrpc/rpc_pipe.c
>@@ -1306,7 +1306,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 
> 	/* We should never get this far if "gssd" doesn't exist */
> 	gssd_dentry = d_hash_and_lookup(root, &q);
>-	if (!gssd_dentry)
>+	if (IS_ERR_OR_NULL(gssd_dentry))
> 		return ERR_PTR(-ENOENT);
> 
> 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
>@@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 	q.name = gssd_dummy_clnt_dir[0].name;
> 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
> 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
>-	if (!clnt_dentry) {
>+	if (IS_ERR_OR_NULL(clnt_dentry)) {
> 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
> 		pipe_dentry = ERR_PTR(-ENOENT);
> 		goto out;
>-- 
>2.34.1
>
>

