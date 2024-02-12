Return-Path: <netdev+bounces-71066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D521F851DCD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 20:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EE21F228D4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D647A40;
	Mon, 12 Feb 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Z1aJ3qVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE24644F
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765563; cv=none; b=LQWNgHHtY2CcvoH1dZO80B/qBridcfAR6UJg6eakslW9srU7GRZHcELBI86vL2+r02pxLH6GFm9RtwwUSqDJe1TPSAIGLmOC5AK0Llx9Q7qw6XVbYem1q58T8uolX97qjJzOHfXieal+8Y+4cPAcXTLYiFPKs3J+qp3y10PVecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765563; c=relaxed/simple;
	bh=tREySGsYyctYQRNHowu6FpIzdFgRGgQKJzBJBe5SiUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOrynkFGIoylt7XjGxH/OWIeM8TCWfz9MpuUgVNF0OpamYVtaCB4E4rwLeyZXhxBC9vO3TdIqgGOawozY7+C59zebBvsQwwbQdwMi6nlFa7lj3hVpFyzdUEobqK8cFnVZSqdum8aRYg/RKJ233290V82y1aKBpe+4ANoifoCVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Z1aJ3qVf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51182f8590bso2475813e87.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707765560; x=1708370360; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+wtZVHBlRBdgOXll+bQOWRpw11A9TK3JHghIbdQJgo=;
        b=Z1aJ3qVf6s8xMWEyO6nyf+/N8kzRvcDQ4dFH/TroYYIx9PB+BW+6aPGxRoFfFAYNDk
         KhhNvkNdWaPGH2KDg4B7s79NPatOuLIRgtAluCQyF3hrK+1ADicXnvJIs2KragNwyl2A
         SD5SVgoiq3KWiA2cAaQejUXY3rZZobw/JBkWEEgaXKLmk8XP1ZjuRZCcqEhPZ4/CiFid
         pJbH++6T/icBGYu3LAduNyIKpYvLGNmFvUO7tk2z3NYXFFjj5WOlgEiFE+8Ak9vs8uaA
         uuYBSdZcC1cjRrNEM/oGAjNd8thXAeu3uS+ooamZKA7Mxxtk1LZYpVuwcsfvtvxN15UZ
         jWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765560; x=1708370360;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+wtZVHBlRBdgOXll+bQOWRpw11A9TK3JHghIbdQJgo=;
        b=F8Tl0sWOvAg3a6ikBjM/sJ9/vAklslJcVCJEBhM58Tx98BicyK3PepbqOttvSZ2pb0
         laT+voh2N7+R1tz99l+Ux+BD1pwkpWXqzYITJ5a1hrEc7jYk4gfXoNLNCxFmnsLMaf2t
         EfbSVJIC+p+Js/gVyXgyfR0ebDE5z4V3ZYuQHjWZiBLUcD8rhbJb1Q2+sKJCbR1xZfB4
         Qre8ws4iiGIAWD1UPA761Q99slL3WQ3YjgH+8Qm8h8gm0lIw30dbWwCumCdBWNUTLD5R
         jxezjUGqr8bkdQ7bGz0ZPBquMbl4h+mavtUqFTBDGgfWmapGy1UeXV8JMce+eZiEUDUd
         P4MA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+IEXS/J5sqgK81p8M1YqPeUSESxvp29MBN2Y69JI4+ZHi4+qOmbZ08ppzPCPUvHvOwiqcbXv0KDBV4/K0QKLNKnWdjZu
X-Gm-Message-State: AOJu0Yx+9aWvRCtWYy9Soi5FV/RQJszeoJQrbf/plfIOpeeBeaIrwD+J
	oovOZgyDH8paNlnpqhFTVQOXcucM7NrMZm/I8wtAj9mM+7K/JHR9+vr3u59OyiI=
X-Google-Smtp-Source: AGHT+IHh37cBee4GYsqUQXihtNoQHNqa3Lb0NvrWTvxIs9dwteEUJ5PKbdM7u7qnHY1lOblxQ9WWoQ==
X-Received: by 2002:a05:6512:3e0d:b0:511:8619:1f6 with SMTP id i13-20020a0565123e0d00b00511861901f6mr5500486lfv.13.1707765559832;
        Mon, 12 Feb 2024 11:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULdbvjfbNelR49/rsk2DnvfzQHPiwZl6N6eYbmMwuWCNYuOvsBLRVHPquPjiSGJHVDsowy01myFOmvNTvN3c97jGMOZyDn9J2G8KBF9/zcKlNYfTcJgEULaMYoPKsSwqlF7CPBDoX7S3aWqBFQaFsezLK4yRvq/Wza8hj1W5Lu4+O0TBqA3bG0lLMLY43dGpN8T8v0kIvk9+ZMUJd4jJAyVlFt5hHFDPx/y4TLvONG+Jyn2AxzSoal7RAUiPwTQDMkZPmInp0k4bi3HMP1S/Kj
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id n9-20020ac24909000000b0051157349af3sm974647lfi.47.2024.02.12.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:19:18 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	atenart@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v4 net 2/2] net: bridge: switchdev: Ensure deferred event delivery on unoffload
Date: Mon, 12 Feb 2024 20:18:44 +0100
Message-Id: <20240212191844.1055186-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212191844.1055186-1-tobias@waldekranz.com>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

When unoffloading a device, it is important to ensure that all
relevant deferred events are delivered to it before it disassociates
itself from the bridge.

Before this change, this was true for the normal case when a device
maps 1:1 to a net_bridge_port, i.e.

   br0
   /
swp0

When swp0 leaves br0, the call to switchdev_deferred_process() in
del_nbp() makes sure to process any outstanding events while the
device is still associated with the bridge.

In the case when the association is indirect though, i.e. when the
device is attached to the bridge via an intermediate device, like a
LAG...

    br0
    /
  lag0
  /
swp0

...then detaching swp0 from lag0 does not cause any net_bridge_port to
be deleted, so there was no guarantee that all events had been
processed before the device disassociated itself from the bridge.

Fix this by always synchronously processing all deferred events before
signaling completion of unoffloading back to the driver.

Fixes: 4e51bf44a03a ("net: bridge: move the switchdev object replay helpers to "push" mode")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/bridge/br_switchdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 6a7cb01f121c..7b41ee8740cb 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -804,6 +804,16 @@ static void nbp_switchdev_unsync_objs(struct net_bridge_port *p,
 	br_switchdev_mdb_replay(br_dev, dev, ctx, false, blocking_nb, NULL);
 
 	br_switchdev_vlan_replay(br_dev, ctx, false, blocking_nb, NULL);
+
+	/* Make sure that the device leaving this bridge has seen all
+	 * relevant events before it is disassociated. In the normal
+	 * case, when the device is directly attached to the bridge,
+	 * this is covered by del_nbp(). If the association was indirect
+	 * however, e.g. via a team or bond, and the device is leaving
+	 * that intermediate device, then the bridge port remains in
+	 * place.
+	 */
+	switchdev_deferred_process();
 }
 
 /* Let the bridge know that this port is offloaded, so that it can assign a
-- 
2.34.1


