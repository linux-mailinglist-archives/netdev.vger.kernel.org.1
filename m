Return-Path: <netdev+bounces-167038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00529A3875A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104123A68B4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5821CC71;
	Mon, 17 Feb 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q87IwSYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF011494DF
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805462; cv=none; b=ZPSZKUE3JI6a5rzCOa2g7/CmSJ4u7HqUsD8Mxy2vM9fhoKgpxTpECHnoz9jNzjuvH9ONj3Lomt7QM1f4hSOpR97EG+VGMgPHcPVLiq3tvwdXVLhsqSzTi58B9SNYoYjSlwmJJ1xlwpq9vnvsmQteTSt/wCGXf24v/9XZyx9uq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805462; c=relaxed/simple;
	bh=2/3oEYmfX5KDq8u0qbVAxbUXLA91REQM11RvV68cy5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5rMaMj3/2ms/2qVaXhIdL5jJvYi8hPvboojlkCWEV76iDPqyCfbtJr/6WlGSlOgA7Msag6tRAA/Dcmq1sC6zjXEeVXwHht/5crTsJe9DbelAP+404YB0shvffXx1NPzJykuCsgjW5GQkOGBCwqLD4sNiEbJYcYSwDnzrbB8N7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q87IwSYg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d39a5627so64427665ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739805460; x=1740410260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BflKumye3Pgc9BOWnV7OSvmPwSBEavqxwqTy7HXLkq0=;
        b=Q87IwSYgs4nMwrINfO/TSfbDRU+SKWm/UT6rjVsyDvGbobfYnt9qcZsnwlNuRSeF64
         J1Sy4nJ+6pjBWtWThdetFMTeWtr2ZpcjypOVB3tnlunftaSMT1Vqm6wS2Zix0IabM1mC
         Knt6NVX9bT4To+ftWH5aBM0qyNoHgQwhf/Czu4dzz8EK17PtXuM5ngsK/W36Z8+rqshx
         njQHanEDELzI2EaDWvwzEYITe8IpVlnKhamSWf74ba+uwd1yNBf10HWFQIHiCcXdGJeD
         bGfzyHupF9eClea9046AeQTN7JtqvETaxYoHX5jDJjtAPOy4aabRG8GcWpBcH39r0vUH
         PS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805460; x=1740410260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BflKumye3Pgc9BOWnV7OSvmPwSBEavqxwqTy7HXLkq0=;
        b=kYPG+yzsInEfyMrxqaT5uzqGVxEryrjA+m6s4bboYcWERywnyziB5yxDxOOb/HsUIs
         Q9T7UNcz0LRR2Y3K4d1Zoee6BWseWbJ4zSXZ2RIfqND2+chaCfZkfNmmAjHD0AMJBEkd
         VW2rJW6VCIz9km2YGLK+MTLiy58a2P/0E9c9gjMq5x+Td0EVVxt4LA9XRGCkD5uGkqeU
         QPLrBv1dIjHUZEEHn1lnMdDWLWfBqsOajzbo+VzxXsUx3ClJcnC4Zzb90K4uyifYVS9Z
         jsf3CZ5VczUJ9DfU6Whu9FcxeEAndlXNNYlC6jJD4PuOmGURud4U1kxijQTKxXLr/8r1
         ppTQ==
X-Gm-Message-State: AOJu0Ywsr3Lls//7LVCNI3la7/EdTHFjz5M/JLgxG8Mu7j6LxUGUvFhC
	kBbl191yjSS4xpoW9iNtCkmt4Y8ycubWOapgC4MJypi9pLpZKZc=
X-Gm-Gg: ASbGnctjLJEln047Td0CsFFJ29gIHlurE7OvEAlbdkFHlTPsmyuVXy6scq9d+dpX/lM
	sSHO6qRvV/xMTeQlxsRGmaduBV1yrMzhw2hyQgRAJ9SikIzxqLXrQRCvA1l15SMp1/6CApTI3s0
	ELY6CWoFmtuDMbRTDj0f1QNUICboK75S+LyGLPojsfAfhoBdjLdOcXWMgh1Iqqyje4rGYGQhb3y
	xMBtpqY8tSgsmAHvdy2yqqJXA8uTlni7q4Ruah9VFz0ZmpthdbMyH2gv7NSHTIjvbFoMeY/3LLm
	epKvxP2/8ZzIbTw=
X-Google-Smtp-Source: AGHT+IEApZT00eK31x49RY0uwKSZlnERoGfjhRe/zH92dFJafjFpRILYquCBW10ZcV3k3r+hqHRtmQ==
X-Received: by 2002:a17:903:28ce:b0:220:f40c:71e9 with SMTP id d9443c01a7336-22103efa6f9mr111223835ad.9.1739805460526;
        Mon, 17 Feb 2025 07:17:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d534954bsm71649935ad.27.2025.02.17.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:17:40 -0800 (PST)
Date: Mon, 17 Feb 2025 07:17:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v3 00/12] net: Hold netdev instance lock during
 ndo operations
Message-ID: <Z7NTE1DlI0nQjjwy@mini-arch>
References: <20250216233245.3122700-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>

On 02/16, Stanislav Fomichev wrote:
> As the gradual purging of rtnl continues, start grabbing netdev
> instance lock in more places so we can get to the state where
> most paths are working without rtnl. Start with requiring the
> drivers that use shaper api (and later queue mgmt api) to work
> with both rtnl and netdev instance lock. Eventually we might
> attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> netdev sim (as the drivers that implement shaper/queue mgmt)
> so those drivers are converted in the process.
> 
> call_netdevice_notifiers locking is very inconsistent and might need
> a separate follow up. Some notified events are covered by the
> instance lock, some are not, which might complicate the driver
> expectations.
> 
> Changes since v2:
> - new patch to replace dev_addr_sem with instance lock (forwarding tests)
> - CONFIG_LOCKDEP around netdev_lock_cmp_fn (Jakub)
> - remove netif_device_present check from dev_setup_tc (bpf_offload.py)
> - reorder bpf_devs_locks and instance lock ordering in bpf map
>   offload (bpf_offload.py)
> 
> Changes since v1:
> - fix netdev_set_mtu_ext_locked in the wrong place (lkp@intel.com)
> - add missing depend on CONFIG_NET_SHAPER for dummy device
>   (lkp@intel.com)
>   - not sure we need to apply dummy device patch..
> - need_netdev_ops_lock -> netdev_need_ops_lock (Jakub)
> - remove netdev_assert_locked near napi_xxx_locked calls (Jakub)
> - fix netdev_lock_cmp_fn comment and line length (Jakub)
> - fix kdoc style of dev_api.c routines (Jakub)
> - reflow dev_setup_tc to avoid indent (Jakub)
> - keep tc_can_offload checks outside of dev_setup_tc (Jakub)
> 
> Changes since RFC:
> - other control paths are protected
> - bntx has been converted to mostly depend on netdev instance lock

Teaming lock ordering is still not correct :-(

---
pw-bot: cr

