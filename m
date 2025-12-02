Return-Path: <netdev+bounces-243260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DBC9C55E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6A3A8505
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C42BEC2B;
	Tue,  2 Dec 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QR0U3OTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773229E0E7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695255; cv=none; b=SS19eqLt9QRchC5TN9mYeu/o9laNY50DT2c84frAFAFdKteA6G6NSaJRzVoi+wTUCpYVt+ykZYygRLCquj87nw+FoTPTiTD01aTg+Oeqk9q068Y/Krc0BRZXR0mtbrzipn/RtWntjfXhfl5uDDYRR7oxeK6587B3OHNb0FMfLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695255; c=relaxed/simple;
	bh=cp8i1yF+Ggk9bXhjIIcBncOO67Nj5gsbJm9VUwveP3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpZBB/KqRBpfLeWwscBbmYSdWLD7jK0djnss9t5ZSTJ6U+ES56R+Yp82pVxuPVVuRWF842ICvpaJTNyXl++4iW2gYF15oeD9FVdfdTwv9I8KNF/T2HPnNnYtbD4zYJSjDUTbhksq0YsaIym71+gSGWjUPV7somIL1dqVPV+FXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QR0U3OTX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso34548095e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764695252; x=1765300052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfTv1XAcFgxTl+WmVWdNcnymzQHB1oIiqmKPoSjXU6o=;
        b=QR0U3OTXen5aMwpeSVcPMi4Oczi8nEwIIP+aXjxoZY9cmcg+cup1jhMWwBXt9purgd
         ayqJqKuab6ZZ1toGQNGntQFCvnzFXeHwyzfpJHHyP3K4/P7nPTzgw0zFwxGhYbu9Uhgf
         t5jdZtq6ntmwRC5SwwSdHR6XS9PGbpPIx5o0AoC1k/VhjQuGtzVVcdLqnXhThhNyNF0h
         UIUKupdonIaWrqTMNUN7gBUGlKYt+L9ep62D1mUc0cTZe2ERkr8ZZU2Mo+GQB9LNoSu7
         DYxBF5j5HK/uO4jOcFCdSctTr2DdOMpgENVQTJCCCwNPr8tmAIdZdA0UlQ4rGbqtWyzq
         bBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695252; x=1765300052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfTv1XAcFgxTl+WmVWdNcnymzQHB1oIiqmKPoSjXU6o=;
        b=BfH5sO6wo9fGhflLVVJ56nlF7rcfIThOnlxeJUHb8J7YsufOSih6I//e9Ijiy+cZCw
         638NYjIYyMxFZ2vIcvGsF6pyuxqKkUzq31zcq0kefCsIdluoWeQgfwPuXOOmoIbiUs5H
         s7bacyEamwiU1VmSLn11VBhfoAMBpiiv6Wn+MYa7JW4MFgP1IVKfsxJrYDwqZjkidGUH
         ZPmIeoa8drMbrNxRMryqgTaYjXGyRDfCMPm/riMlP67Fqqm47zXL5wsc8b2bpDGGLV4x
         VdltPNsYhbqeFsZE1hxLNQ8SYbv1LfhLvjaNq3SbIlrxEqXZ254WCoXh+LT623OpUMyp
         vAPA==
X-Gm-Message-State: AOJu0YyAPKExox6LK1UV8jxmoWYjKCdKEoj5ie+V52OmgFwLrhxkX6dz
	kYNWGYdik93cTvfLD6VNpTM1JMDaVmtKk3SupbtdM8jb1DYDRPhQ+ib3+155aLoQpHCKhOSY3sP
	Dy+mZ
X-Gm-Gg: ASbGncu4LwhBQ5Flh6CHayL5pcwsPZfHzUqsn+WFvKUcKWMsoZNjjor1Ob+nd3/q2nO
	EYKkGaU5ZXpEYkCTcQ2jQttNqEfOiF3EwKMuStuhSSOftuR+iIKWsi6WztpDpkpi/h5uOubElBz
	QGM49eLI0bJN6LpTnMh6xQ8CW2dv+aKcaUTULhVZE7Y7C2881dYQ3Rw67xlYNPLfwKD9p2xH/DF
	b0ebt8upjL8i09ao2ocsWUtfUegDbR61Tp2zzOIyY6aCOjYLnMLNnCmS8CUifA42KMrgjHxdKCs
	aq763TAz6I4c4+rq3HVH9z6ZRdQxbb1WsF9XBlFuouuXQoX8GFoD+ySpE25HyD6dc1ko2eTCmBr
	ZTeuFPnYgL4fJ8jhgto4dYrwsBrjBmo1Vk5daEpJgaiQP97bCuIuiJoOVELbWTped2zqygCy/lS
	TvUkBglfiKo0hpID8xLZ5R4FapgBi4V6sLWMIFAeBNVj4T4IT77N7sRXKGlh5Z66g=
X-Google-Smtp-Source: AGHT+IH/5MYyyeGBp89UTRNbmm7Y1ex4hohSGmEHPr+zFpm1RDb1E8/O+wmRQcJJBX+hT1zUpEujAw==
X-Received: by 2002:a05:600c:3592:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-4792a61e75dmr2387015e9.35.1764695251583;
        Tue, 02 Dec 2025 09:07:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111438b9sm350462895e9.2.2025.12.02.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:07:31 -0800 (PST)
Date: Mon, 1 Dec 2025 16:40:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, Cong Wang
 <cwang@multikernel.io>
Subject: Re: [Patch net v5 4/9] net_sched: Prevent using netem duplication
 in non-initial user namespace
Message-ID: <20251201164042.5ef12ced@phoenix.local>
In-Reply-To: <20251126195244.88124-5-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
	<20251126195244.88124-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 11:52:39 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> From: Cong Wang <cwang@multikernel.io>
> 
> The netem qdisc has a known security issue with packet duplication
> that makes it unsafe to use in unprivileged contexts. While netem
> typically requires CAP_NET_ADMIN to load, users with "root" privileges
> inside a user namespace also have CAP_NET_ADMIN within that namespace,
> allowing them to potentially exploit this feature.
> 
> To address this, we need to restrict the netem duplication to only the
> initial user namespace.
> 
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Signed-off-by: Cong Wang <cwang@multikernel.io>
> ---

Duplication logic should be fixed rather than trying to build
a wall around it.

