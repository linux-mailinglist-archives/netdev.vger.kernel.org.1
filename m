Return-Path: <netdev+bounces-168391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC43A3EC21
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 06:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C69F3B2E93
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026D1F758F;
	Fri, 21 Feb 2025 05:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVSd7JV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034098F6E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114748; cv=none; b=NSkqwdaH9+J8bV4k295KTHqfLH/Ta9ziV/lEHuffwNngOGbXB2T8BVaF8KChTWBR8eD9X9el8v/TDnpxXjk74MnIY2hOZYPyZYWTPrnL6lvjWNm/7ZPDMOVXFZV2Aa+j+E5GAsDDZvaXozYfPW9fGFY6K402d4reRCjqP3mwXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114748; c=relaxed/simple;
	bh=s0L3SS2iDaMmMFYnqN76r6hyBBUesMNd+0GwVVNulUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H7nRkUPikWujLWsBcUEgJnfluG21CctB4S4Dx82KXdqxZfzLABUH3kxV2C+3Br/hQbuz2gULgoRGbI04agBVHfKchickAy04cXwaGBmEzd91sC4IrqusitVA1Swig4j+m7hYpxsGAyu4fLtMDnWB9ptSmdispHJe+Mh6q3jaKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVSd7JV9; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-472051849acso29056271cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 21:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740114746; x=1740719546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FcM5tFzsPz4keIRJwsQjxTttVZCWDZx2zXwRdrlLyKw=;
        b=zVSd7JV9mWj8zAmxuvbHDRwS0P5tcIOLe16CY6isP3SUWq8PhpsHDbvLCs3CToiy62
         aAV+a39e6r9ytK7UNv5G0xC7XpCx6LEyl1FmO7MS91q8YPsc/7MQECZj7lqWzzlFFzZg
         I0bmYYj6qi8M+UP5agiTBOuLDgkCAAzSiHX3zCxmrT08CxClkT+Acj6duxnYKWcR5YNK
         wUuE0ESmpCU66ss5qfUTFQwnR1SklraLJ19p65qzYXSenrok0cz6ZLHJ/YVHB5OvXt0s
         maDhV4ederbBqU71FeI2or8sqsIJ3ptYvqn/iZuN7Tt+L3qHwxoVTiBYuEUxJAhrDFsz
         tbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740114746; x=1740719546;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcM5tFzsPz4keIRJwsQjxTttVZCWDZx2zXwRdrlLyKw=;
        b=vbBrgqbDu18OHuNsviRuC9wt7Or4hGSiYGxzmA9iDNbSrYppR+iX6ftMDKL2/2IkaD
         OiHQYhQAFZpbjxS3JdsBnX2Afp+XnZfxgn9Zb5dQLdZY6TIPL4Mbz3fsCTwWxZjFVPTU
         WlP5b/L6/G/1YdTe8Hb+rAfsiZ0/cvlgocsAn4jKhlQfitMU+CqsbKzzFQcFjxO4Ugpq
         1jWR9Rw6hzVNKVcdjMglDnaxSoKJIBjZbAsOWR57WkRMV05TLZ3VNQ6q62n1TreSqG5S
         5r5lpsjx9mT9PDJK/cseZx/7j79F5tEePfrW6EDkGtRHjjqv6C+60Ddftc0YcI5v4HDI
         xsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQqVb5QZSe3x00mP0FsSG9TOHA5ZvT/LNiFjjhpOBrS6Fy8KRl56t9zLkGFfkc2XW/hnxg5Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rj+3uG6w8MfXRjNT8pklCmeK/O1OaCUeWrwLzWXjCiVcwfuJ
	nkVwivlpyR4wmogSrluhBcsezEiS2Uo5Kq58o4ePkxKaa6PtCFxRxghlBRphg0Zm53iv6Ts0rAd
	/KV+V7U8V3Q==
X-Google-Smtp-Source: AGHT+IFi6O7xcS7GrWgZZVP9tN0hLgP420+IWcQ+411wMfOvLlOxuIhUJy+BrxHldnYzCgqPj1MPwGGap2IEzw==
X-Received: from qtbbb15.prod.google.com ([2002:a05:622a:1b0f:b0:472:e0f:3fec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1994:b0:472:70e:8995 with SMTP id d75a77b69052e-47222978129mr31175511cf.52.1740114745908;
 Thu, 20 Feb 2025 21:12:25 -0800 (PST)
Date: Fri, 21 Feb 2025 05:12:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221051223.576726-1-edumazet@google.com>
Subject: [PATCH net-next] net-sysfs: restore behavior for not running devices
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Antoine Tenart <atenart@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

modprobe dummy dumdummies=1

Old behavior :

$ cat /sys/class/net/dummy0/carrier
cat: /sys/class/net/dummy0/carrier: Invalid argument

After blamed commit, an empty string is reported.

$ cat /sys/class/net/dummy0/carrier
$

In this commit, I restore the old behavior for carrier,
speed and duplex attributes.

Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attributes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3fe2c521e5740436687f09c572754c5d071038f4..f61c1d829811941671981a395fc4cbc57cf48d23 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -313,12 +313,13 @@ static ssize_t carrier_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
-	int ret = -EINVAL;
+	int ret;
 
 	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		/* Synchronize carrier state with link watch,
 		 * see also rtnl_getlink().
@@ -349,6 +350,7 @@ static ssize_t speed_show(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
@@ -376,6 +378,7 @@ static ssize_t duplex_show(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
-- 
2.48.1.601.g30ceb7b040-goog


