Return-Path: <netdev+bounces-198825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E155FADDF60
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD8517E195
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2596293C57;
	Tue, 17 Jun 2025 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2/jcO8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEC2F5313
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201594; cv=none; b=OjkRcfIMlaVTbvjlRGyT5J/uAqgZHOo6mNfW7UeI+dMyePotIpA6nVfKM+PPpJh0gkGRUBSqOULgR7D2YZEt9ncZCh8cOuUx8Yd6C+NHKR3Hr7BECrK21O5q0ekvJ7VmsTdqNpAQ/WlBtftMLL67Fv04/W5EYtb+dIzOoL7GX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201594; c=relaxed/simple;
	bh=QphvZN62mTOXzzCHHyf/h0E9ng4ZwXuRyW3ukOicqEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqBZ8hXCCjkVB5/w/YYxfMOabP/ZAWyrmtJlzP/4/GULJ7Vk1PhPbG2Uj/xdcUYoymh1a06hxw7dv1xEwfQFUolj8YJNycDXOhvu3dAAfRUEE8c3OB7LvhN13b42Q+dfpvG1aV29bZSMeaf7jNp9lsT31ahEYXlOpAlh5tYizQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2/jcO8r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236377f00a1so56240775ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750201592; x=1750806392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r5A+ftzWTWjTVhZsrkqVGma+/L+zMTgogVSh7PcLbg=;
        b=k2/jcO8rXC0EFE/vV0o1GhMZ3fKLXYT2MSHbHezppjAfUeU7dpSLv3Cr672K2OKiKN
         ySbzw1iHUqoFFKCqRFyhacOo5cjEvwlLueGF0YO1vreqcdvWBUNbdWNQ8MvELdJFCESK
         JkhJf8Amx6dglnbVs6cf5PCAp5OIfZOqTDwWHP718RK3jalezlP/9Uv/mDQ+Ca7WMD+T
         5KZEwwSjBtu0hTQgXXSTME2s/oKvkvy6ItmHkUISw1H17pte6sozteGw2fy6zhrx+VKc
         TN4yFYsz3mrABIosrgGIuTnHrHQRnVJRtB3SUAS5Izx6lXJv8SiY9nRXAdUtDq/LpC4v
         UUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201592; x=1750806392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r5A+ftzWTWjTVhZsrkqVGma+/L+zMTgogVSh7PcLbg=;
        b=T0sg48CpVXLuVQ1ZjtYc/TGxhJgJcP29ox5BVWk42VLcUrIkyK773LPTctStnKRnOy
         GddyohA1VOPCrXix2UqXVrYdo003CRZ6+HBm447gW2k4E/5/jSovhTEXCgbVuXAl1lfr
         a1SqFABL2Aj17hv8IfWxFucwoT2xR0hTQbmPUWWsp9eZrRXJn+zKryxhalXJhXDvHPRG
         fioq+ot6rjvAbEBdud5gZYaCsq2DOxKL8jMIw4fiqXU2ldqpUtSQ8Cs15fbDKq0WfN9J
         SW9mg6VSN7CdUQHWITwLIjqrNjxvSBxwJmH6cTfxGHMqalEvoSo8PEk0C51BAF/7N3pX
         R/dw==
X-Forwarded-Encrypted: i=1; AJvYcCVdbW5D3yNKC4S71qlfDKNtG/jcR4Shk217Eaa7c81nMhow6AIDMf1SAsKG1GOTcx6ovYJja3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXSAN3on7bmbnh9WxvMAm8SZpxtqQwirHfHaQ1pvnZXw736rL
	FF2903bu86jhGMyDu4kiE6ME1g40W/eHYfwLZpvvLdUfscGtFm/77IQ=
X-Gm-Gg: ASbGncvZb6RynuSfwq6H0x6bA6/xJQzob+LcToHqaWiIXobt1RPCA1M5jHM2QXcozKK
	cXtinemgAyDttzC9gW6CdaCbEEpxT2+kS2RMMblzipI1c9JjZxKk5jIQycnHsjzeUdo+KU+QKl2
	6pNuhAqyzThbyHPMPJgPR7+lFnxspVpIqhAtMrvoDyuLbCs8O/GQ4So1WKzLsg1cxY99SYF1CzP
	kDnEAz4fB1s8Bj8c5XVMAHxm/upMzvBvwnFYg0BJS2nFXD7+u6nMv/y2Lcy8B61+HJcvtF+J4Yh
	1ocu0W5+isTaZxY+GW8hbvXrLPubog8DBFwY4E8=
X-Google-Smtp-Source: AGHT+IGoI/82qZhdYe1j4UlTR+w9ytLpnrKWSTHFVO2TVbq3Oe0VWdiPgrfE10GZ0U8Z1cLRENRQ/Q==
X-Received: by 2002:a17:903:1a83:b0:234:9656:7db9 with SMTP id d9443c01a7336-2366b122186mr240092015ad.32.1750201592515;
        Tue, 17 Jun 2025 16:06:32 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c09dsm86549425ad.33.2025.06.17.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:06:31 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: nico.escande@gmail.com
Cc: davem@davemloft.net,
	decot+git@google.com,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] neighbour: add support for NUD_PERMANENT proxy entries
Date: Tue, 17 Jun 2025 16:06:03 -0700
Message-ID: <20250617230627.31793-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617141334.3724863-1-nico.escande@gmail.com>
References: <20250617141334.3724863-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Escande <nico.escande@gmail.com>
Date: Tue, 17 Jun 2025 16:13:34 +0200
> As discussesd before in [0] proxy entries (which are more configuration
> than runtime data) should stay when the link (carrier) goes does down.
> This is what happens for regular neighbour entries.
> 
> So lets fix this by:
>   - storing in proxy entries the fact that it was added as NUD_PERMANENT
>   - not removing NUD_PERMANENT proxy entries when the carrier goes down
>     (same as how it's done in neigh_flush_dev() for regular neigh entries)
> 
> [0]: https://lore.kernel.org/netdev/c584ef7e-6897-01f3-5b80-12b53f7b4bf4@kernel.org/
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

