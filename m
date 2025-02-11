Return-Path: <netdev+bounces-165031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC6A3020C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF21188B6D3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088251D5147;
	Tue, 11 Feb 2025 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GKlxAoiY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D732D600
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739243711; cv=none; b=FP43o0R16xzqyrnK9OngC6QHIYMztUpxR/r/R2PVQDdbjMc2cRXyWvpas8v/vpyTDMY02qVZW0gg8BP3h6aAID8N7bQx4gZXfepS569I0ymaNSucjHx22O3WZV7Ad2uMPx0hol0e1uoWxxnXPOVvP5oGQROrbWh001Hs1BMcX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739243711; c=relaxed/simple;
	bh=13k6LCcCb5+sF7UQbEq3q6gkRLL9onQSDkVtjpfIdxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atfAuicw/828IzkYs89FauYSWLwJsz8LoD4+Y1nGLTuftdC+bFeyr3QYlWZX3gxuKhj/tZOvIibc/Npntr/Di5FitC62dw2b5eliRliF11AVdcTpfVUbXbacLKmVB0x10qzyLv1PI5+fKxXlC3heTQDSvaGBiD8+EQHKyfWBJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GKlxAoiY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21fa56e1583so22392415ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739243710; x=1739848510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1kP+XWZTOkAajPber64+I/sNCVI/eizySysH4dcPnI=;
        b=GKlxAoiYhzHG15xJDtIgvsoYuynoKrquXeZhlhR735GxX6InwVRpLZpKMvQwdc+e4f
         o0d50HIoK7DZnTm1PF+4OOsd6j4yVw1pysNdRoo808IxZAEi6/yesTjChs4xoe7sNqbZ
         kKk3JSrP+yp76TTT4M6CA5ZyHL7isEGEWLEbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739243710; x=1739848510;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1kP+XWZTOkAajPber64+I/sNCVI/eizySysH4dcPnI=;
        b=CPcjPkOd+4u+YEklr0C30mql52n7uERKXzjT82ku863ZqSua/vYC83U48QJYOU08Kp
         km0W9Yy1kNARySxkeTR2XgSW0443fSXZy7RLZulYPfI7bpf+vNVY3CfypFRMvYrD5dYU
         x9U+dN9ZwfTJuHiKwpqjG7vQqMeXq49ATemuXnPgxcTc/6RX/y9ZCTrTxJZHCyrjtr7U
         rz6GhmcMoqiZLTtk7qGNTtjFWVQfQ3psbyqPln50ec9fIpEYsds11hIj4gVD0PNcSpid
         F6+ojJBVokZdpySqprmtIaiO2X/iZ5Ihkq1lxOqVN8Hdx2K2F9iKoWYNtlBTxIzlXxnh
         itHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNS6cmPL3jumewyFIzP7ilznSpaVZMwOE5D4XUt9BuSprF8I7Sxap31b5oqdwrfWULwcw5qLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Lz2y/+kOTbV1IEnYHolhscfeDbG5ESIsDd6AVUNvQza20fiJ
	R/xzZli4F06bz4Z8L1baprkgCz+GFYr1Gtq24q9Kx2BTVbNMSsDBPNMH/4z6WH4=
X-Gm-Gg: ASbGncv1na+ZbaHLHtn3gHA9a9l40k0vPeV/VUGdKpWA8RoUU6LAevsMZrvWgoak4ri
	lkJSeIv7AoYfxtJanIlZ5jBTR3vkP3W0WAIk0oDI5LkTPsa5tO8RJvfCPVENSyd+yKZuJ075CQQ
	azpt+SIEU41kypVQ28/4q3852Q9j8KtLWkstcv7ODFVtaE0bevcTwbSV1WmWuMCvuRHMZjKbUXI
	/hBOEgJcJhU3DWn31ifEuJIiwFyBF8aJXMabNHtrSUhAVzth0gurW72iaI7e3ZkrYG8/gV11sVG
	0QZ360AlhKI3v/DNrns6Gsn/LtkdaainOFdLVVEksvek3qJIzy5AkF4PYDesa74=
X-Google-Smtp-Source: AGHT+IELYS0mgNiIgF09/UGSX5ndAImM0FhA9QaK3O1rhuAZR7Qa6bUo3XbZmbsTOscqHOLk72pZ2A==
X-Received: by 2002:a17:902:c941:b0:21f:8099:72de with SMTP id d9443c01a7336-21f809974b2mr116223295ad.45.1739243709678;
        Mon, 10 Feb 2025 19:15:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368cff88sm86052585ad.242.2025.02.10.19.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 19:15:09 -0800 (PST)
Date: Mon, 10 Feb 2025 19:15:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] igb: XDP/ZC follow up
Message-ID: <Z6rAuqYnIzQH_gtN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>

On Mon, Feb 10, 2025 at 10:19:34AM +0100, Kurt Kanzenbach wrote:
> This is a follow up for the igb XDP/ZC implementation. The first two 
> patches link the IRQs and queues to NAPI instances. This is required to 
> bring back the XDP/ZC busy polling support. The last patch removes 
> undesired IRQs (injected via igb watchdog) while busy polling with 
> napi_defer_hard_irqs and gro_flush_timeout set.

You may want to use netif_napi_add_config to enable persistent NAPI
config, btw. This makes writing userland programs based on
SO_INCOMING_NAPI_ID much easier.

See also:

https://lore.kernel.org/netdev/20250208012822.34327-1-jdamato@fastly.com/

