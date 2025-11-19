Return-Path: <netdev+bounces-240203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D6C716C1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 09F4028A4C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD51327204;
	Wed, 19 Nov 2025 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lt1gjpav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98F2D9491
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593909; cv=none; b=p9daOsKUHlOyR1F51+wvfKGcC52PCEZV7Pk0oLmwo3KxFRZXPqqDpUgT1YctwUFgxAJ8/Dtlv9V2B7cjsRcPdhPB7Tw84DWOU0gwaWPHlYTAzTiTOvWrjyNmRst3OLJOmeSxZEJyZGJugPfS4qtoITngPTLz/Cp6LWx/ShAFfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593909; c=relaxed/simple;
	bh=B4ogaSzeCTEfO2fyf8QMTYxTmdo61Vz7PJm9iZmEd3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFtQVLwapByuVZm4TY2Tn+a59yKPS49dB8wMHRLCrNtNgZyMgB9PzujYBOI+5GdiU+YYqsJWs2aERQLe/p3ddduWiJxVCv4IpJau3AA5rbDRG9+u7fwdRikPIngtRvyXbdQM3aFVrPElgQ7H3aWVdVBEkhQkC2ac/7up7cscfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lt1gjpav; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b713c7096f9so43717966b.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763593906; x=1764198706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZaTR1bnryMwBTD6jnnFcRa6YP7RbWnYcC+dF48Y8gs=;
        b=Lt1gjpavpSK9inte/G57cwm4PSwPwttll4e+ymij3cyrakoFzX5zF+cp+l0Duw2unE
         Cj9YFP9FCAa6UL+1/iZCK4/U1HfDG8KMkkQFEWfA7LD1ZF0CHRoMFoX+wf2W2gkqNOSr
         baq3Jr8PZC6S8u47xPkFKIYIJlCGbhJHPK6xTeqzSx8ojhjE3YGndy+mljtrna6ezvl5
         wOMrQah3zr0jrP7SlN2OC39R9K0P9FW7TU6F+rAXBFrBzC05zC/ASF+OjJmh1qoahNX8
         XdhULDXE5nKDPxTooC340LvRvgbXlf5s/rs+yKg3nTTjdpM0HrZQHLUpF54qRCekB4Vp
         qFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593906; x=1764198706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZaTR1bnryMwBTD6jnnFcRa6YP7RbWnYcC+dF48Y8gs=;
        b=iq/qxVqoDkAPXKhp8WkZXasz87hszcBsAxQ+6s5njdP++P++Fukwr4FqtY4gC6KrP0
         ceknCgpx09MSgYPsZD6chBHXGoLPA6f0DJtmfYNYAFb6270pzfgtT/MzDSqCG2FqYJpc
         aBemqd8cAOVsQBo95OWbmuUee9t9DvF5CvzEcCLIHKIgW1ff3TBj3bju/gvxU02qSqVV
         R4ocLmbL3ppQyKIFhn6SR1MuB+vebv1prrQbvOf2UV3bka9DKwxZI6CkdGDfQQqcqqIP
         a8JyCmilUBZ0rR9bR2EmvwnaqYDjIhNIfbB1qiSmzh1Y3DKplfW4VZOQ/IxnI22+dZZ4
         saYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoa4mabZigOHNef+j9LYhSTA5d5Q5U2RR/GPmqpDKb73s0H6dRBlTih94/fXdw7gypNqmshTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnfoE9iT8tftKSw1RwCbMWiDGx//QnB1zqMdZd2uE9CdeGwTS
	5W4j3XzO/rZkCvW4YeyAGbGjie3rLdzSkBOQB88kSIMwYihSOFvAUIP/FWcK6F25gYw=
X-Gm-Gg: ASbGncv0Mt1JgMYR7SINtue1NntwEu8ZFupZ2x5j9GqCUo1TdgLCb+qveU7ThARDs8w
	Bgb9FImAsysipeXDGKFK/8cIImLrANoI3538vv75PwLjlOpDiyBBrb/YE2XzAYmIZiIYPzCh0ln
	BvfVGHwh/xpVNvBseo38XFNuNRry4rPZrTfaDUsizUXR8v7JUl9Of/Wtp8quWyN0BUgqDpwhJmZ
	0GCLh/cIDO/B4urf4NYR7gQJsHDt7rq3YZo6bQxm0Bes6ar2iEYUhIznvsflmXS1flfxt8hKhh5
	EjVhd4h7ExFeIp8/IZP678x57M9Gat3Fu1k1Zfo2vDYhVUWQEqxhxQ1+6eLZTD0TRhY0mQ4MqOo
	DTxkAnC7461asGgy8gI5B3BWd4QX/ECZn/lkKJ/vpnqAQepxXe+IkpvlMii8OnqH4ui1F9vaUSu
	BvQP6GjHAwlPQ+spzPD8jQM3tj+iRnfY+0U6kW
X-Google-Smtp-Source: AGHT+IGsbJFAHX8SXEuf70GC/fdHzn+3vcHUS7IST+d0xdlWSQsiYTr0gIPPSua8jakHdIJ/TGNUrA==
X-Received: by 2002:a17:907:2d20:b0:b73:572d:3aff with SMTP id a640c23a62f3a-b7654eaf8c8mr99610366b.35.1763593906003;
        Wed, 19 Nov 2025 15:11:46 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b7654d80665sm54469166b.31.2025.11.19.15.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 15:11:45 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mattc@purestorage.com,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	saeedm@nvidia.com
Subject: Re: [PATCH net-next 1/5] net/mlx5: Refactor EEPROM query error handling to return status separately
Date: Wed, 19 Nov 2025 16:11:15 -0700
Message-ID: <20251119231115.8722-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 23:42:05 +0200, Gal Pressman said

> Matthew and Jakub reported [1] issues where inventory automation tools
> are calling EEPROM query repeatedly on a port that doesn't have an SFP
> connected, resulting in millions of error prints.

I'm not very familiar with the networking stack in general, but I poked around a
little trying to be able to come up with a meaningful review. I noticed that in
ethtool there are two methods registered for "ethtool -m".. Looks like it first
prefers a netlink method, but also may fall back on an ioctl implementation.

Will users who end up in the ioctl path expect to see the kernel message? In the
case of users who run "ethtool -m" on a device without a transceiver installed I
think we should expect to see something as follows?  (Is this correct?)

$ ethtool -m ethx
"netlink error: mlx5: Query module eeprom by page failed, read xxx bytes, err xxx, status xxx"


Thank you for helping on this issue.
-Matt

