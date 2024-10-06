Return-Path: <netdev+bounces-132565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF0D99221C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421431C209CD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3C18A6BA;
	Sun,  6 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvPrl+Kl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CF1C6B2;
	Sun,  6 Oct 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254485; cv=none; b=EgafaEs/Dt98PenJf7Cw6w8vU9wYD6VBpZAZvJkm5Ab0xO9AqWlNBU2eGMpd1kvbphGRt3A7eyXmW6A/gqhV12QMWPinLC0UCk3FtlsQkdje/njosI4ztnjkjH5mKChZUa71XFJg3BxQYpmnzHOgxuCCOzM4ANB5ZieqLA2G3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254485; c=relaxed/simple;
	bh=8fN6dHkL3m6k0pWOYMgr5qyQhdl6pyBbfGsGla+fxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH8lCXWyymxFCDm355st+wotymZdmUGP6cqFxIEhV3JYPvgDLZy2CzeTTv3tKgnrWVpwWolCQtKrceoFBhJL+WwY9OZFFCBTBRBZ7hKgpXDGsMp5YLXTdfUUZAogAwrljdPPmU8G1XSTWgB9W6RAf7GqvMe+V4lx0tFq3kbF0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvPrl+Kl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2352126a12.2;
        Sun, 06 Oct 2024 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728254479; x=1728859279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fN6dHkL3m6k0pWOYMgr5qyQhdl6pyBbfGsGla+fxX8=;
        b=XvPrl+KldU1xhhI+iLUR0v7GGpiPZsOaCsa0g1GVyfvZANgjWKC85MKsGmPQ2fXwkF
         j1EvV6pTyy9eZwEXcLJaRT6fwdBiXD9RV3Rm0GbJakaA11yscmH5rnkiMqTnp+eMTlKX
         eizz+tXWqlqnlMr5VHaUSKVo7Eqx3IAfbi3c10DYvPg1na29UXZpdkMiYdNRq23gPrGK
         vtssBQEwQeWic7t13NldkWrhbHDCDs2teMzWbsG99GfCbrQVQKpxuEAscsyyKwIfVYj5
         lGZf9gilTQZ5VlCtyWB7qde6ATsoqC0/469L2UdjIMtb1h8hPS+Zpo1FbsdcbKrhtVX6
         G1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728254479; x=1728859279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fN6dHkL3m6k0pWOYMgr5qyQhdl6pyBbfGsGla+fxX8=;
        b=Cy0VAGYdD33lp6a3ANyn+2WnbdhQbWCeWsfB3lUTGj5qpqPlVjQWsLk1kB+5vwiFQ+
         uHz3USdeOdELAJnxnWGj+9a8YFwmDxXfP3xM8+bVw0p819Vrqb3QPQZYMvsYBrFhPVpD
         BpPJbW7T++O89ZotTDUbHMpWyguZ/x+EvwJi7vkxpUaXzAtNjRgw1jHJtfRQl+4U7v+C
         EimYVkdeKxIc8omAPksnXzMNDqq0xEIfvk0tYELVis6ZnB3E6QZeYsc2jPcTneb6dZCs
         kYSpqyYNnaPpEy2KOkNkSCeOLiKboakBD2UEy9HPIdD0qE/yP5bN4/tkEDBUtJ7zSWgD
         fjww==
X-Forwarded-Encrypted: i=1; AJvYcCVo7tKwwAqZAOhZ342uzAH9JhdKJFQjoY1OXXiiLs5KVAwtatDDIsU83Bp9fElXE3o0B81/aPGO@vger.kernel.org, AJvYcCXATn923GKXp8agKH5nBJP2IsU1nFvd5sa4jR/XsL03e3p7XGWMEnScUOYqia+7MJ+LFoHHsDmyvdk5z6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxup8fuAE27HrZapT200p3JYhJeSisQ6qaUF9e8KEwl2KGtl6Kd
	9oWaiU1zAEhQ0gb7mXIr2ExxFqLIPdOVXTl9RJALgWc1xsKHT7Mv
X-Google-Smtp-Source: AGHT+IF0NeX/oWIC70KxaZWdaz7pfDMjInUKQm+ZZFHke41fOW+mwThTMAp7SqARXofvlZ5Ty56ypg==
X-Received: by 2002:a05:6a20:cd8f:b0:1cf:7123:86a6 with SMTP id adf61e73a8af0-1d6dfaef19emr14828042637.49.1728254479372;
        Sun, 06 Oct 2024 15:41:19 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d452b7sm3221655b3a.108.2024.10.06.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 15:41:18 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Mon,  7 Oct 2024 04:11:09 +0530
Message-ID: <20241006224109.2416-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <32b408a4-8b2d-4425-9757-0f8cbfddf21c@lunn.ch>
References: <32b408a4-8b2d-4425-9757-0f8cbfddf21c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I shall apply these changes and send a new v2 patch,
thanks!

