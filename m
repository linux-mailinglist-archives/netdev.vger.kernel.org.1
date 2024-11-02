Return-Path: <netdev+bounces-141248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13AD9BA314
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80081F212CE
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1781ABED7;
	Sat,  2 Nov 2024 23:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611E16DEB5
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590793; cv=none; b=oM7vQ9luUywGqVIHv8jz329rbtaGMq4nprvRAIDjfn1Y/wLA1zETfgBJkzXJyT7DNbN9NDao9zwVDpd9Z6fRu8ylAsp8DxZ0fyQ76k4BQOxQFl8CMK5jjjybYvGqnahE960DYwHIM6/ZYQEkJo6vdKGGsIf7tg4FaLr2qS6jbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590793; c=relaxed/simple;
	bh=wGL53SdCMy4//JdPge+zRfHwTL8v/8N2enBE0hgffWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtTAW1Hk3VMarj3TchJDhem4lh/4D9/0R0NltuEfiuUVH562DNbiAmZdfbFxMWQHkhJmpuEIv09XljkQgmUb1tK9DsZ1KtqsSHdCUYToMmeAEMIY5eWGfqDWNIl+uwqPNEddsTemPUPWa4yNrpQyl1ZU89OqpHcw4GgmErQ6j9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.217])
	by sina.com (10.185.250.21) with ESMTP
	id 6726B83400002249; Sat, 3 Nov 2024 07:39:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3399583408501
X-SMAIL-UIID: 5803A63A2F434F349C996F7132C8F5C2-20241103-073937-1
From: Hillf Danton <hdanton@sina.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	willy@infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] eventpoll: Control irq suspension for prefer_busy_poll
Date: Sun,  3 Nov 2024 07:39:25 +0800
Message-Id: <20241102233925.2948-1-hdanton@sina.com>
In-Reply-To: <20241102005214.32443-6-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Nov 2024 00:52:01 +0000 Martin Karsten <mkarsten@uwaterloo.ca>
> 
> @@ -2005,8 +2032,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  			 * trying again in search of more luck.
>  			 */
>  			res = ep_send_events(ep, events, maxevents);
> -			if (res)
> +			if (res) {
> +				ep_suspend_napi_irqs(ep);

Leave napi irq intact in case of -EINTR.

>  				return res;
> +			}
>  		}
>  
>  		if (timed_out)
> -- 
> 2.25.1

