Return-Path: <netdev+bounces-71843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1D855502
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE421F28247
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79B141982;
	Wed, 14 Feb 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="HMVaQLqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404B13F01A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946815; cv=none; b=LUpV+Czm1tNnKu0iSytLvc8HAXaMDkSknwopuACLio+s8Guuh66Z7dpUEIp6AKKJcGtDU6twYgedkmSoqBqKxGVHVnL58I3lZoEb/li8B7NTUZStndqv4ASoRS3UdU98BdlZwUSozX5EY+CXgGk3+A6Dy+aSanwBfx03eSFfykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946815; c=relaxed/simple;
	bh=OmnJN9Q8u2zV8nqxhParOEeCdD1V2mFcmwrCl6IRG10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qARGHvC2yWiMQ3i0Az0EFXJN6uUw9i8fk7ycR02dtN0iJ2PMvNCiuMKIZoJ+nNRiYQQbcZm4dxHZOXm+Pzw8JM0U4rgj1Ct2KF19EDsc18u7BQDyXRe6n0HhN6ELFhw8r9VMW5v9GAFrdF6Gqj4TAynBZgomEBl9klsBWQux+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=HMVaQLqs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so221948e87.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707946812; x=1708551612; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/7Cz9+LJXOYNuaesM1/OfmeIXVklCAdfmfwFJERx+E=;
        b=HMVaQLqsDue15RJqQpzQB64wvFa/lkcZL+CVoK+mLEcUA8N2eX+uCTehuwxT1h7SJG
         CNOCdFJPADm8S/isOb9/kONn59RtBhbH223Lh8MmcPPPnio2jdCXlQvGTatFdecDd1PS
         6P4E42RBAgu601USH4wLsUvFB9bwDefJbczL/PuplGYEgsFg1Ii7uIoL8Fpoy+mviiho
         62sXvzkuWercafTb7oJz8roZT4gx0+KMt0nJb3K7j82OSgHtf5dQgML0jDsiEQJU5AEf
         tR5WrGH7Ht32hafnxCNmhyApiuWe7MA2xFHWS7NeugbbarDft+Nvnp+NfD+J6GvjD1N8
         rZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946812; x=1708551612;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/7Cz9+LJXOYNuaesM1/OfmeIXVklCAdfmfwFJERx+E=;
        b=ed/lKs4pB+b7TGZE4zlmscNzZTMba+74hR9rZWtzw5NQGdYZzczaodkinY9Mk37lan
         4AHfZVXIDVHLxnRgkSAEMD3mgzvtAdsiU6N8LbNC/KlFe6N8azkgDkGrY2HzjpAySazO
         HKL7lgRYYW4LrdGRwYwIwyswBXRp737/U9S6Csi/rmg/tC4epdbS6DCsI2Qt+LbT+MXt
         qmciBYlPIorIncmVyN0P89SgC+ct/cy0TI7k1Ly0NC7o72FiLXe7PzaLhi2DrOIs4DAR
         2mOqrisxs3sDrqMfaA4eCrZmOlzpzP33+YJoVWtOUaE9XOenu2yPpyZCqD2GLylv+fyQ
         FdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaz2GtA/bO7xFO02/8TrRJ2g11bYQXebF3aOdeXXLc+J0T7Dyw4oKuEuKjWFocOs7wP9Xz+8VZp7Dk5irbhg/KTCWbVekF
X-Gm-Message-State: AOJu0Yx9Uqfsc3lRld8LvBLFoS0ROTNyEiX7OsxDv08gQiM3u8t7wpLH
	DerRTKfKHsaPoOf0RpSiygCksNCF//QG55Ni4kayxIeylWcBJO1rkvbEZjWVKdA=
X-Google-Smtp-Source: AGHT+IHhBEayvfK+XLhESwHfsYqjjSCzIZtH3aCKlzT86KFy1OTOPs8rv4HSzTRWOYoHedtGqtAENQ==
X-Received: by 2002:ac2:5b4a:0:b0:512:852d:dc3b with SMTP id i10-20020ac25b4a000000b00512852ddc3bmr42379lfp.4.1707946811711;
        Wed, 14 Feb 2024 13:40:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR1YXPWDmJGJqYpZaXbahCBi8YYAlK9vKKnlrOUrfqSVIIKm0RQk3ugb+eV4MipvGtqarCPFv7IoVUf3W5/twcPsMyg5uxXoQIImzS5MPO74UOmatT8OqS3cPDUaqTdfSdVhhZ41gnaAWg/ql/3QbN9/T3Ru0vDzTsB0AE/eH0fzHnzu8yjUrZDNtt4A7fsLYc8DCx6X7wwzaTE1bM1uoFEj05/JStGGDTBXYj2CtOO6mZGh3/ENftZQQD+zJvwugrHfmwxt4zDLzvFBsgLO86
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h21-20020a197015000000b005118c6d6a2fsm1433290lfc.305.2024.02.14.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:40:10 -0800 (PST)
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
Subject: [PATCH v5 net 2/2] net: bridge: switchdev: Ensure deferred event delivery on unoffload
Date: Wed, 14 Feb 2024 22:40:04 +0100
Message-Id: <20240214214005.4048469-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214214005.4048469-1-tobias@waldekranz.com>
References: <20240214214005.4048469-1-tobias@waldekranz.com>
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
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


