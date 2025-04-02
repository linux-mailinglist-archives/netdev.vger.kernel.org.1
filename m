Return-Path: <netdev+bounces-178914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB918A798AA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085DE18955EA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954381F790B;
	Wed,  2 Apr 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XONS9Vc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105691F63CD
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636059; cv=none; b=cC8Zclo3VNgZrfb34Ij4a4cAES//UGHR4fUNZk0PkVI+kQGVCaQm/obHeJs1LF/UcfAH6rH0+MU/MAJmgzcK4r01DojRgt/8DBdAQS1nUahzItBca4lm7ug2g2sigydmaUzQCbzXeQMeU4RMrwpAsKI6vH1eAhpZy92xXOIQQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636059; c=relaxed/simple;
	bh=Qp10X8LnSA1V/nxiP/4T9z0sZlVtVT8V3xFgAk/I69M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXnuj7tDYLpwITlIhgK2PIiNY4VyMZjIh2RQ4oCzGBo2HZHtx63Lfohu7WnlMt9wMjDq4G+m5OK37h4Fz+ETMjuvRCQxFjsiP6+K0XhOZJuCfkSjlshZuxqUvAmMz8VlYiz8TxAVapEZ6c+OaotWAnPKlkanP5+bcybOPHCsvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XONS9Vc9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so213982b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743636056; x=1744240856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBphlYcwU/1hlzR4oiaNvWz06PFPPjN1Tjq9YA7ayac=;
        b=XONS9Vc9K053KWZn2eeBGYfTM4zxS3v3RT/2BwYCwN8ZJVHD8u7cihw+YSRD2Xk9fz
         sbCv67+YxxPZS5DKV/vdVuSQWbMpInB50SZEwumKpg+cVG7ZeEobZv2J+1v9RMugr6wb
         cYWWILoIO1sVWmrwIYJgnhHutoAg+tLCry5iQAZ8dZK7iyP2AEsjXsT415ehLMpqWWLN
         FM4Ggh+0kuk0Mub3TgZJCK2JRkCmRyHFOW7G6NDHK1q7aCrgE6iUBKY5+tL9g18ojtSu
         fzovY/rpTpWi3hgg4mJhG8Vrnqdmq1L8Q6E8+gA+vJ2SyD2QyjtzMq1Lp0/yzXLxYkJe
         c9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743636056; x=1744240856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBphlYcwU/1hlzR4oiaNvWz06PFPPjN1Tjq9YA7ayac=;
        b=jegcR6oztrnwoZK7fcSLz8zToAwiI8EAjmRnmeRBVgugsykX6WbossaFn0If0TQEXf
         kEjLVEavtHxfxj4W5v8gA7EMQlYUrgxoV6SJQzKLSNsmEWQo5+9xqMIdOZpyW1r18sKX
         loKtyvTkC+3Ssq7qPKUh8DnQnc4Ecl3UITFnLSZsrCvW1lViUSwFvUvFoJjk3t2QPwoq
         wYyC/pvUIFzVrqxtIdOIlgo3c0wD2cmH5fqHbX8PInQUfwfxahVE+tBgnEpNvbO+9d76
         pky0s7v3zR+OWTmYOvhQzjq9rXQvaz+MEPDPZ9FvHfpkp8TmYfVD2uqwh1bSp+sgVWrx
         se6Q==
X-Gm-Message-State: AOJu0YxahhKCoIqaQOFjdvkvoYqKn2DqjaOayot+AlH0wVhJLpuCRiPK
	yPx5CoWsc0W45yi4l7qnnArG33iHdYWi5YlZpgZjF+oOxPMPGR0=
X-Gm-Gg: ASbGncv+z4H4AWJ4axuc1lgjDYkvQRfwBrCHV59oVxVGpHkOLNn54nZ4aqsfM1peGzK
	mL6oPLBgM6ckb68ctJ5/nxwlTJQOHTxzBV4Iwpt565gVZFMT+OkRf0gd2MrhTa5cu46xtdgO5is
	7N+pgfNiRKiypSmSsV04QWt+yqpECkvC4rUMBUW91tNscXi44TWfbJ1H3yXVzc3Ub8iFzIAwwcS
	qMoNJajG6vdcfm4o7hKjNH3VQv3i/AGaIkM52UEq4R9aBaieP6YNeuYvvflD+llC0pYCnC/VWcM
	w3Ze6SdX5a+5vzNH0BRQ9E37bCpRS4ROLUX8aQxtbl6C
X-Google-Smtp-Source: AGHT+IG0crscIMfhtK1DXLDymrpTotz+gLhsDilMsg0wLfOzwhxSJOei3KzTF9LhJx7s3hKZieD6iQ==
X-Received: by 2002:a05:6a00:9285:b0:736:4110:5579 with SMTP id d2e1a72fcca58-73980322513mr23587869b3a.2.1743636056027;
        Wed, 02 Apr 2025 16:20:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af9bc2cfa87sm17120a12.6.2025.04.02.16.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:20:55 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:20:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: another netdev instance lock bug in ipv6_add_dev
Message-ID: <Z-3GVgPJHZSyxfaI@mini-arch>
References: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>

On 04/02, Cosmin Ratiu wrote:
> Hi,
> 
> Not sure if it's reported already, but I encountered a bug while
> testing with the new locking scheme.
> This is the call trace:
> 
> [ 3454.975672] WARNING: CPU: 1 PID: 58237 at
> ./include/net/netdev_lock.h:54 ipv6_add_dev+0x370/0x620
> [ 3455.008776]  ? ipv6_add_dev+0x370/0x620
> [ 3455.010097]  ipv6_find_idev+0x96/0xe0
> [ 3455.010725]  addrconf_add_dev+0x1e/0xa0
> [ 3455.011382]  addrconf_init_auto_addrs+0xb0/0x720
> [ 3455.013537]  addrconf_notify+0x35f/0x8d0
> [ 3455.014214]  notifier_call_chain+0x38/0xf0
> [ 3455.014903]  netdev_state_change+0x65/0x90
> [ 3455.015586]  linkwatch_do_dev+0x5a/0x70
> [ 3455.016238]  rtnl_getlink+0x241/0x3e0
> [ 3455.019046]  rtnetlink_rcv_msg+0x177/0x5e0
> 
> The call chain is rtnl_getlink -> linkwatch_sync_dev ->
> linkwatch_do_dev -> netdev_state_change -> ...
> 
> Nothing on this path acquires the netdev lock, resulting in a warning.
> Perhaps rtnl_getlink should acquire it, in addition to the RTNL already
> held by rtnetlink_rcv_msg?
> 
> The same thing can be seen from the regular linkwatch wq:
> 
> [ 3456.637014] WARNING: CPU: 16 PID: 83257 at
> ./include/net/netdev_lock.h:54 ipv6_add_dev+0x370/0x620
> [ 3456.655305] Call Trace:
> [ 3456.655610]  <TASK>
> [ 3456.655890]  ? __warn+0x89/0x1b0
> [ 3456.656261]  ? ipv6_add_dev+0x370/0x620
> [ 3456.660039]  ipv6_find_idev+0x96/0xe0
> [ 3456.660445]  addrconf_add_dev+0x1e/0xa0
> [ 3456.660861]  addrconf_init_auto_addrs+0xb0/0x720
> [ 3456.661803]  addrconf_notify+0x35f/0x8d0
> [ 3456.662236]  notifier_call_chain+0x38/0xf0
> [ 3456.662676]  netdev_state_change+0x65/0x90
> [ 3456.663112]  linkwatch_do_dev+0x5a/0x70
> [ 3456.663529]  __linkwatch_run_queue+0xeb/0x200
> [ 3456.663990]  linkwatch_event+0x21/0x30
> [ 3456.664399]  process_one_work+0x211/0x610
> [ 3456.664828]  worker_thread+0x1cc/0x380
> [ 3456.665691]  kthread+0xf4/0x210
> 
> In this case, __linkwatch_run_queue seems like a good place to grab a
> device lock before calling linkwatch_do_dev.

Thanks for the report! What about linkwatch_sync_dev in netdev_run_todo
and carrier_show? Should probably also need to be wrapped?

> The proposed patch is below, I'll let you reason through the
> implications of calling NETDEV_CHANGE notifiers from linkwatch with the
> instance lock, you have thought about this much longer than me.

Yeah, I wonder whether other unlocked NETDEV_CHANGE paths can trigger
a call to ipv6_add_dev. Will try to take a look. Initially I
though that only NETDEV_UP will trigger ipv6_add_dev, but looks
like it can happen on CHANGE as well :-(

