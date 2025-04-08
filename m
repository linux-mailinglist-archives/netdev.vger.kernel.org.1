Return-Path: <netdev+bounces-180013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56361A7F19D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829EC188E2F5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED6A921;
	Tue,  8 Apr 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgchPq7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75A11CAF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072110; cv=none; b=bGzBacrzKAcS4jKZTE/hGJ6DxOjJeI8Sx7RIUz2hLzeMtues+kAHJHCy3WD+Iyy97LBy7d1b/hrv8oggl6i2HM+AarRWGfKgOLJtnVvnhfqTTHYZQOX2ry9o5EeciF45HBTH+e0lHvS1+ArWIkK6/Q5pIx3EpHBqq6QNsQTrOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072110; c=relaxed/simple;
	bh=3/7UROoXHvSlBxrxM9Ivnb+77yLwJSyShgcH/6HYkC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei7qXf60uGbolmsOeLj2gPkGLtmovzT1XSEVzY1ucJeOvuF5sPp6bdFQnRsjeiTfLOh9HHJGVtFbuwbv9ZzVzXNxqn8qnCjvl71sATyjaDaPh1p7g5XaC0VEIZl8G587gMSOsOpO1mRaZKjMUMzeocIMa/onKmz9Bs6Hmqm1nXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgchPq7V; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b34a71a1so5860666b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744072108; x=1744676908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rlsn+eAE3yMOuwazA3cH7gPvs+v8B4DVWfJux5HRuM=;
        b=KgchPq7VyeCSzzHifQtTzgQv07ZHVAx0vhX4fus6dG/erOuWIicSSmp2rI+pFRzSqE
         8Kkakbl3jW8yGPLtItXDQB4wQpV2I/CMxPeyf1JUA1KBSiMY0eNQOso6wNGQxkZsbuyl
         hsxZRBA8/qQAFjkQNNOshrq73xnPvE4rszuQhSygczo/E4o6WquJ9Fy+EQ/t6q5/4fLL
         9rh9I7G39o/B/PwS+IuBybbMJIH24AD1jjLRN8wSpmF838iBsh5vomlPrTCUwjLSEMNB
         tJ9WoPiuDpdBWiysOI0Fh5agDwJtVcki6uDQ9Z4ZyB6LlPQRNWAKrDX3OsDlv02uZU1K
         VDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744072108; x=1744676908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rlsn+eAE3yMOuwazA3cH7gPvs+v8B4DVWfJux5HRuM=;
        b=nFjFiDcsop4FMy9SDm2QGUjHvUppxAg5TADHhTa4DQ+CRPu1kBUuqOxC/Z8oNGCaNY
         45cTFKyuYy1D9pgzMY1gmIEEIz1ULQsg6+kRi5etgjMQoK0ldocAKcWp96W8uh8FsBnS
         9rWGdfQXJF7ltMtRjJsdp+sRJ8AnSgfxHxrqpcxqTEO5nmHuanNpkjuW1n80bZlXAAFk
         mHJLceth87rbJANfHq3BplEPHCC7skc4J0LtcLhpuv3aIeMTqfTLljchyWYNli9EgpFh
         P8ZEGcH7nmIZ0pqP44ysrdI8s6f6+eUfoUU75A6eULDc4hLgSEIxcHfLbn4pL4WfhHII
         5CuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNM9txpen4pfkMePeyVh8sbjiY8j3xlCeKaTL3QU+EUFSUnIdTH5Rvw2fSecYcdlnS/Q2X/WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwaULk+sE9/8iXDy9kLEr9Tw1zghQMnIEtPlukUWbmJ5vySDz
	PsHdaWO+IxV2OvQy5K9yJea3rIrAZ1lvFIKzEvuw94ZMqhiuzDY=
X-Gm-Gg: ASbGnct25G06v9syOF9oRJy6Hhl+TM+1Yam4EKSPiL489HNAi/2RuYQTu2DddzaovCv
	txIAMdPAOQQ6PmyQ54N1tMlFJIVjoY2BczmDcejjxihfOSS2GcvvWtAJDmm+KUx0MK9SwWfu2je
	Egbw7zfqchtA4qMcqvf73s/sPS59MWRRGU1/Z3S4CwReLVeNBlPyHLmtqT9lc1TKRvKWYBSChLJ
	yzLTMPWUs+jNz5q2vKjm9KseSd/g4giLaODn79aGSzlVQzJQkJJIsG7aMBjpQUMSjl/59gYiq/2
	ZoYI5HBKblipDqHnbyJ7Nnl3sFHS1cfAM8fIxENjA2F86NcI7rcuqeE=
X-Google-Smtp-Source: AGHT+IHH0Pw7qoUmOi4hYB4OVTLlt+vqNW3Io/gkKx0rPVpqyi0ADEJFhgFFAe0r+GvlZB+sC//BXQ==
X-Received: by 2002:a05:6a21:4603:b0:1f5:5b2a:f629 with SMTP id adf61e73a8af0-20104734ccdmr23656227637.30.1744072107539;
        Mon, 07 Apr 2025 17:28:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af9bc2cfbc9sm7942448a12.9.2025.04.07.17.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 17:28:27 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:28:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com,
	jdamato@fastly.com
Subject: Re: [PATCH net-next 0/8] net: depend on instance lock for queue
 related netlink ops
Message-ID: <Z_RtqpNCsBzwlB8J@mini-arch>
References: <20250407190117.16528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-1-kuba@kernel.org>

On 04/07, Jakub Kicinski wrote:
> netdev-genl used to be protected by rtnl_lock. In previous release
> we already switched the queue management ops (for Rx zero-copy) to
> the instance lock. This series converts other ops to depend on the
> instance lock when possible.
> 
> Unfortunately queue related state is hard to lock (unlike NAPI)
> as the process of switching the number of queues usually involves
> a large reconfiguration of the driver. The reconfig process has
> historically been under rtnl_lock, but for drivers which opt into
> ops locking it is also under the instance lock. Leverage that
> and conditionally take rtnl_lock or instance lock depending
> on the device capabilities.
> 
> Jakub Kicinski (8):
>   net: avoid potential race between netdev_get_by_index_lock() and netns
>     switch
>   net: designate XSK pool pointers in queues as "ops protected"
>   netdev: add "ops compat locking" helpers
>   netdev: don't hold rtnl_lock over nl queue info get when possible
>   xdp: double protect netdev->xdp_flags with netdev->lock
>   netdev: depend on netdev->lock for xdp features
>   docs: netdev: break down the instance locking info per ops struct
>   netdev: depend on netdev->lock for qstats in ops locked drivers

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

