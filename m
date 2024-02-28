Return-Path: <netdev+bounces-75946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7D86BC22
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F1B1C23094
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85167293B;
	Wed, 28 Feb 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="L13RgYxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C472925
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162581; cv=none; b=czX2xxhBbP3stjqKrIQpyvaXjk1nfBEXg3Ae2wCrwpERfpGWhESbt5wepQjY4oOeApX3W65a2ot13kbQkrP9kkDWsJWTgxYSXxuwiX7bET15+3nKI7pLpEA2PM46jVfvn7dGjcbUdnyGhCisGAwL2tqYvUofK9IdsF6tCKC7dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162581; c=relaxed/simple;
	bh=d2HppGWJaQa66JR1Fk24YetPh6Z/upq86bTQP4nNA/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgsMBfMIMCTY8hexnJSw3SFYZuWNlS+lIc3BaDgaWJ4JnjD3lGsLb0iU1s2MnqokeQUuXN7vIhdAtphADQEsVjhLCdQ6tNeTtzx1o3xy8W1z2ZQn0RVbB2IXTXiLpl3Ju7KQ33ZoSUvEJGCJ/uhbfwBL9LPmQ39FQK7Dp9bdwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=L13RgYxO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607eefeea90so2905487b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162579; x=1709767379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o/qfEe7PEuAJOpg929dSRy3Fc9j1BX3q2xBprmXfn0=;
        b=L13RgYxOiHR1njsVDPlGRQP+ZfFUzMpJCsw5aCkWEyog8SMuHz/9aT1tUNA+Ss7fEm
         ZpRvsGS9mtht9YUx4QypDQ8fMK+X6PQqnzPxVLFzPld094UEF+dIgM2jAfRtvuBTUVoR
         emU1dox4cFmyqdHFp+pO+We5WN7t4aC8qS8xp+EggGKBGvOlOdjL54Wqyf4nJi0qDX7k
         tyMcL7OUqBG0G97VmvcRMnN14jy/qLdX2KvkNjRx05h4+0WwPD7xkagYy4B+nV6S4ZjN
         tsbMq+/Ubu74VF8D0759LjO7AE3s6LWGWJ6MDyC3Zi3/L6AxhQUChRhODcSTEdSWkPqq
         vHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162579; x=1709767379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o/qfEe7PEuAJOpg929dSRy3Fc9j1BX3q2xBprmXfn0=;
        b=XJtKVMh3mOK1oobG4NTyaqQji02JcYhWb9qsfCzHKcb972zWdgXFQNDtTonjPeLCSB
         LeOckqXHgcAUs2Zg65tzwX57HPgU6iYzRyTkAbGmnlT1jJZq4rJnmq7gQZvG2mJxb0Bk
         MHT2Zni1Kbmp+yLEwk1NaiDeRcmKJF5W8OJAm5SMxhuOz2X/rY0BHeLfwyi+R5IHUUHw
         gix0YFpH2wdp23D0PyA5C71uumIhmms/W5khmPU9jDFZhH+sgNF2aAXVBlA31gI6gjRP
         iQgHxSyiNnmDynS3+RCoMlocSHq72WGa4R9XbXxX9G49vw0O2qZAqmOfAMSwBGIZj4th
         ICYg==
X-Forwarded-Encrypted: i=1; AJvYcCWUtrEcD0qsZaM6CzOZ3YvBzJCTTS6yLNqOmAxlqHK2edKEQjfZyL2KJocqiVmdrw38dCLlKw+BJpQ0rhhDPhzUA9YFuURm
X-Gm-Message-State: AOJu0YzAIxezhQg9gixe3S3xFMH2Dt4eCyssANIzH18m75fKzR3rTtsY
	Ln59nH54WC7uN4MxPFULQp3ozEq692LOpITowjC7Bfu/tanzB6AyIc2xe/DRpxI=
X-Google-Smtp-Source: AGHT+IHnQQffD6GzCU1pgzYuo1NA4cjXVJRbUV9u8ZxvGons4Thrd9fsGuP/Q083lPIPI+E9KNeDAA==
X-Received: by 2002:a81:a145:0:b0:609:531:8550 with SMTP id y66-20020a81a145000000b0060905318550mr147985ywg.21.1709162579182;
        Wed, 28 Feb 2024 15:22:59 -0800 (PST)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id b3-20020a81bc43000000b006086a467647sm29595ywl.56.2024.02.28.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:22:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 3/5] netdevsim: add ndo_get_iflink() implementation
Date: Wed, 28 Feb 2024 15:22:51 -0800
Message-ID: <20240228232253.2875900-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
References: <20240228232253.2875900-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an implementation for ndo_get_iflink() in netdevsim that shows the
ifindex of the linked peer, if any.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c3f3fda5fdc0..8330bc0bcb7e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -283,6 +283,21 @@ nsim_set_features(struct net_device *dev, netdev_features_t features)
 	return 0;
 }
 
+static int nsim_get_iflink(const struct net_device *dev)
+{
+	struct netdevsim *nsim, *peer;
+	int iflink;
+
+	nsim = netdev_priv(dev);
+
+	rcu_read_lock();
+	peer = rcu_dereference(nsim->peer);
+	iflink = peer ? READ_ONCE(peer->netdev->ifindex) : 0;
+	rcu_read_unlock();
+
+	return iflink;
+}
+
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
 	.ndo_set_rx_mode	= nsim_set_rx_mode,
@@ -300,6 +315,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_vf_rss_query_en = nsim_set_vf_rss_query_en,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
+	.ndo_get_iflink		= nsim_get_iflink,
 	.ndo_bpf		= nsim_bpf,
 };
 
-- 
2.43.0


