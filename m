Return-Path: <netdev+bounces-82326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977588D47A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1402F2A804E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBF20322;
	Wed, 27 Mar 2024 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Hy1CTLY4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13031CD23
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505754; cv=none; b=f/rYWFb2ERXEydvFpGi9v16brXqJYUzM800iuxrnFGov0XPTp+9qtxQPcwihZ60dbP3o3o63lekpktHFw7ZGjU7w/iyww/XtFqRzcfA1XfLNbI8WRZucHIN8CMU6SDjTAP71Si1V0reDfBr0a9ZXvYWBjFGgKL8Oe0Wl86sXHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505754; c=relaxed/simple;
	bh=fKhJB7XOPc6JjVYKqznjvesnzBUsVbxtT8+Ew2OdcQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjZ84uWn6Hv6r6Aani9bMwdp+T1W8EGAivco9cgJjKns6vH/r64YnkQZg6/ugX7zYiTitgcDmd9uutMTofPeaCJMMWVBzjMgpA8FrlU/JQgyTIFSaJJo/sO+/Zp+QSjOm97N5hZl1i/cgAwwUdjTO5dr1haD9w5aGSvd0l65Taw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Hy1CTLY4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CAEFF3FB73
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711505749;
	bh=fKhJB7XOPc6JjVYKqznjvesnzBUsVbxtT8+Ew2OdcQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Hy1CTLY4JW+fQEfEOSpdRxxfDEjcvnUo2XPQic0IADbrYVxBEDhCGoZXKMtP2T2qN
	 rpw/kjSDAFz5lBsV/DCZV3e+mltPf81YgdOW+u+8E9E2er/6DRnRiF0CojgOVZoKbQ
	 t8xML5ez1alYwqeeElE4KJNW3Y29zt6xpHDdJvK5DhLB/tXPxY+rz4t8yyjihdmGeL
	 Oj90LN88nV6H9iNboKKJsjK2Q5HxVobrr2n6wVqf6oBpT7wOh+GZrjAQET0R1CkWDT
	 HvrwCDzHHkanXYOdAZd+od8bcvc3VZHuUggn5Dm4GwXqitDhl7d2p1KA2uF/qIz5p4
	 jNPU/AApFkbQg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c65e666609so5133458a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 19:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711505748; x=1712110548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKhJB7XOPc6JjVYKqznjvesnzBUsVbxtT8+Ew2OdcQo=;
        b=eZsERRoLIME9bJ3aVgwN3aLIKLz9d5nDuctG/S6egRwnIMopABaKodjFo/MTz5Sscx
         WwZTvtCIcqfahDZCVLlZAVBrNpTZloQKQKlTNpiY3d2Ss7PDgjC6NDI85+XvO0YMloJ6
         MyiPHtj44ZINe+6X54KMzxjn9rXW4zeXt67kzTH9bQeNJVJfOBns/I5fJTMFBCcnIMpp
         hpzuKz/V6sHHB1mork1LRnDbH4JLAefgn6N7qH/gZT7aTzw/UUjHY6VzAXAKFIPyiX9G
         hIHioitQZDnxPoOHCgYxJfSr//dWBekbRyuJJZ95wEuE/uWj41LQEeBPCGNCbyOeQuMt
         GwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmbnB+8zBkhN/dCstL7gG2wsShZPlVr7HMaT61GSihbI26MUEPPl1Aj9/F1RFiwrXkQlh3GCZ9ou67G7BkEIyWivTgk//9
X-Gm-Message-State: AOJu0YzpqmDnfLUqjBboyuVcKrQfjG46E2gKVLH9SBrG9/hi8wfHAnxc
	ZW1nVODdW8u+gzQvwVKx7CD7N2J1n9rZYdxPINXvlOd3qc2vrs0HNxqvlXmx4gC4YWIXtlzaPLq
	i/WkbyxouuhcDXFRpRgePpNHtBT1i+Q5Xcbu9yK/1lAYxt3qtW58Toiwth9+Pgs98lSaP+Q==
X-Received: by 2002:a05:6a20:2d0f:b0:1a3:6bd8:f487 with SMTP id g15-20020a056a202d0f00b001a36bd8f487mr3295562pzl.51.1711505748210;
        Tue, 26 Mar 2024 19:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElayVC2vlX0bfsO3hzEZTNU6MCgkaiVTRiIGamUJCoTz3gZwxK5rSgMl9m4F0wlnRMYohi9g==
X-Received: by 2002:a05:6a20:2d0f:b0:1a3:6bd8:f487 with SMTP id g15-20020a056a202d0f00b001a36bd8f487mr3295555pzl.51.1711505747876;
        Tue, 26 Mar 2024 19:15:47 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id m14-20020a170902db0e00b001e0afd21de3sm1690418plx.176.2024.03.26.19.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 19:15:47 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: hkallweit1@gmail.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: DRY rules - extract into inline helper functions
Date: Wed, 27 Mar 2024 10:15:41 +0800
Message-Id: <20240327021541.6499-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <146be1ba-c0fb-4ed2-8515-319151b1406b@gmail.com>
References: <146be1ba-c0fb-4ed2-8515-319151b1406b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 27, 2024 at 4:29 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:

> cond like conditional would be a little too generic here IMO.
> Something like rtl_dash_loop_wait_high()/low() would make clear
> that the poll loop is relevant only if DASH is enabled.

I don't know if cond might be reused later somewhere, so I am thinking of
creating both dash_loop_wait and cond_loop_wait. And specifying them to be
inline functions explicitly. What do you think?

