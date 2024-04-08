Return-Path: <netdev+bounces-85887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304989CC29
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69A41F245B8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313291448FD;
	Mon,  8 Apr 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omS8M1uW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4213F006
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603082; cv=none; b=DBO3kSrbh6FgC21KM1+rzpwa79WOP0++KQTh54cO7fqPtvIDqXg0SMvwmBJdj6M8Y55ZgJvrgFLENem7LOXK4b2CYR0mi8hU1TO2yw3H+cWPjngyLBx1kNs+WKwB43tt69JTFsvRoIpOnFoG9hunPNP2Xcl1sOw+/vL1QqbNfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603082; c=relaxed/simple;
	bh=9FsXE6wJfIPpaXF4L7vG5uSotOj6Aj4PB83UfBG57p4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=adfJJ3KnBs/xJSFvdx8L1uinv+5dx//IOKS4wy9MYJ1TZ5eOJvlcONmxrmiTVBtTDJH3mZMLFzG1BfuzT1gdMpsmDnl+JWN57fBGyV6Dife+PZ/6zkhVXIiJkTLaQ1wJSjfcPnOJNDf7Eg8bSY12RHMZtV5dD74UoyDGD4R3A6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omS8M1uW; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-69655dbec66so49808086d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603079; x=1713207879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7d0GSHVG9OE2USpRXoMM5+Oo0gPES0b2OgQ0ETX8y1g=;
        b=omS8M1uWfEpyq6ZJh/Xl5WV471OYmSST8eq5FiBg+5b5Ymc/SS8jW6g4l3jehVEr42
         rmhrdnNFECi/4D4RPYsOEh50B+haUqvIrHavXDKc4Horj/RTOzTgn9n0Bnhj9uNWGqEf
         vvK0YmglvujjlQW+Pjwz4mggQbOP1Ii4l/5dNALOuecWpwHlu1AJCJQJVmEEqQzXcVhN
         1rC/R7xysXNN2gq+QEShyMo9//RBnAUgV67QPbaPvfQIY80yJ+zBqI/Pj5n1md9I6iLd
         j3r3TrzfNxsNIJKyrKK5WR46mnDmUNKFIQsvi5JxorHtojosLLFAbJ0KfYrthlIGfvaJ
         5vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603079; x=1713207879;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7d0GSHVG9OE2USpRXoMM5+Oo0gPES0b2OgQ0ETX8y1g=;
        b=DF8Owg9xjgVPm6ZOD/3uQK+rYd5jNOTgFk4ERYq8BUObIQh9BxlEE7440niK1D8u4M
         CP48T0MLdeMbxodkMQZcpmbeneGTsxddfB8+fERUxyfRdbdKyoTFwH+BuBjoccTfzY/8
         fRZUYcyiWwUfSnusseuhlZLendGSkxOn9qXUraWtJ4o236RtTLlV4a47Mk8mN8Gm2adc
         UV/+pe34NfS6aEKM0rbNI3ytWkyICO0g/EdrsBcLhqdhPd2Pe5VrfB3kzSY9G/g3zrTs
         wqp4OkvpIfhCBmnNIsGOvNbZ2A1GQux/SKvMDz+pz3NBJAQvxczdvqKl1EAAdLRKAUTU
         ecyg==
X-Forwarded-Encrypted: i=1; AJvYcCXMtp0VpRxtcXDkZfb/SfkiPH2HZKCRjEmTinRqmOX5ut2OGXbkym9+jMB6vz04EjJnoqO8pjDRcbTud3146WwVxrpcyvPP
X-Gm-Message-State: AOJu0YyExjNBi2AHQZarfa6LY+pWE/57rmE3+w3dGxtDXhectudqrWsk
	2SHoNN2tPhBZmXSU6yF3UsKe/ozNkqmqS4DGTCOkucxfW96DDKuIU2ps25zA9ElTgiGKXB1be8D
	4CHyjiaS3OA==
X-Google-Smtp-Source: AGHT+IHbnbBgJo48FOkMZzhpBdFy9glfPP8SlPpmf3KBNzL6iA+7yiqLr2ZQtLyhz9sc2fwYfiF2IYDfhjcuPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:4985:b0:699:28cd:67e9 with SMTP
 id pf5-20020a056214498500b0069928cd67e9mr192053qvb.13.1712603079494; Mon, 08
 Apr 2024 12:04:39 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:04:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408190437.2214473-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] bonding: remove RTNL from three sysfs files
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch might fix a potential deadlock.
sysfs handlers should use rtnl_trylock() instead of rtnl_lock().

Following files can be read without acquiring RTNL :

- /sys/class/net/bonding_masters
- /sys/class/net/<name>/bonding/slaves
- /sys/class/net/<name>/bonding/queue_id

Eric Dumazet (3):
  bonding: no longer use RTNL in bonding_show_bonds()
  bonding: no longer use RTNL in bonding_show_slaves()
  bonding: no longer use RTNL in bonding_show_queue_id()

 drivers/net/bonding/bond_main.c        |  6 +++---
 drivers/net/bonding/bond_netlink.c     |  3 ++-
 drivers/net/bonding/bond_options.c     |  2 +-
 drivers/net/bonding/bond_procfs.c      |  2 +-
 drivers/net/bonding/bond_sysfs.c       | 25 ++++++++++++-------------
 drivers/net/bonding/bond_sysfs_slave.c |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


