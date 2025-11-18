Return-Path: <netdev+bounces-239296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9FC66ACF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B2F4728EA1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011082EC081;
	Tue, 18 Nov 2025 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlYR5kMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EA1A3164
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426409; cv=none; b=KyoLA3FUlwGoZ38XrN8iNgvOs1QjxckoOSedhH1bh8LsIPhkAclP3E+iMd1ZH4CkSXuF+faI5IyM6duQ2HXF8OYXHwIKUFAWndjn2qzAwc706g6ne7rsq/hTM+71KqoyLl4tIe+3tuRCboEPL0b5estvyuOdQk9ay0kVFJcg6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426409; c=relaxed/simple;
	bh=rbvKxkilGhW4hC5ITJRR1qWxAH0KtfJOgfRVxhMbNTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=akyHJG6Kx5LckFFKADgE5YEIrvOq9n+U71nyyMGcMwQM/zzhfvu50/w5oArHOSAtHH/FNoeyLTGa/SrVoNCfTGP+mHN627b4UR4H0xNIhXajm6zb1wulgyQ7pfdfnePnUkT/9/DnCc8wwKHceaS7Iyq9OwUfjVw8oEjVLLJ/FFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlYR5kMG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78665368a5cso47919917b3.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426405; x=1764031205; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QovSHzxOHHSJ1JTS/nieXeRhebq2+8AYH6v3fDX79E8=;
        b=KlYR5kMGFQ5UdgBnTFGRUhPZP2Bn8x5HK8JmSnVFln3rqITOwJk13TwCsKfJpj9P+q
         6kjtBtwn10Di9eYiMm8jTmy3+yFf9NzfAW580G32WIFAlmS/PlE4eJqh5ZG5ohjpNRTM
         npTitob1i4CrNcA/9yHtRLJM0h/dDY57YRPZ6mNiJjXP8o2A2877TOzjedyIn8vGa6aE
         jZmD07xQdzKyfdt4l6SNIN51ntGUdtJ01lWahD4BpY+7ozI9zjg28i56zT2Sr4btWAcP
         cONiUmfDmANu6g3h2wrxNMkLn0pSUDHXAk9huubQjDXHAcm75xzzidazXebAm/TMwDWO
         RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426405; x=1764031205;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QovSHzxOHHSJ1JTS/nieXeRhebq2+8AYH6v3fDX79E8=;
        b=LkwIGAQzGyXZXXrPrmTB5WgFZrfbX89ZZgajP2RFKoGkrWvVyrb5xe7JTjKEvPFq6a
         REi2Bpr3si0gDnTeImIOBLJWa8Uly18qoRfCYcLuJx4pn6ixCH6k27X8saTwf9pQeBuq
         eT4s4IjuLfT3uKL1DgPO6+mjBkm70BU0PYq0Xg0SQdo18jXhrDO4I2xCoQBWTueJB98a
         /76p2Fip1LnjgMEqfQYXw1JudDw5NOQP0ZwowBRTFV4219qAkpejjVrWBjs0H5ANk1vz
         B219N1JyJFqp5MfabyNlAJI2uA0hquDB5eSGjMEJCe2sR5K7poZ/lYg180enBe6FXQY4
         pBEg==
X-Gm-Message-State: AOJu0Yx61dMLnbcTO5fCDhVC2Un76j2wDxdgAHDp70tQY8/Me6I2jgPY
	Jt63tA1y7uc2R3s5pNT+x8LN1eA2cu8TDZeXB7Dtgi5fqLcYjQWybs1NHcygpQ==
X-Gm-Gg: ASbGncv9d5R+bm5mAlok3XFO5JACB3Be3ibyiXIyXd9jAXgdhDBmX2XACK6f0cvqw6G
	br1DadhnOKVnXc2nf45wrhJAdUFcLExA7rCffo6j3A2rK0NUBKxRQ72WL+6Qx9ZgXY0kICtn0Aj
	l+ydtTQ7e34IwrVo8XtJR98LhxPfN1swdK/itRZYGTMPGfIGQdX4PkbjjH1rZYfmnH3dssfdpEC
	IkTaMFxD+oRp4Uibz3kM+/ewj+J4DhRqp+ZZnYG9nL+WZf7lh1ci0SXAcgA5pvJ0PwDfEu/Y0UP
	HI/bmXf5AqJ+l7XtXoUd2SvrHMc+9+jofyBsfdbCYfDZJA5m4Q42chvIplzeJRA5/CZDeLjDzT4
	hy3zFZyoqaYXUfv5VoQK0cFXFccIOB1xl514Fvvngwu7noxnwBwmLDLEcHBLS6233sG09lX548R
	cYpiR5My5GS+jBO/juopo=
X-Google-Smtp-Source: AGHT+IGBzqQKTrsf8NsBEcYrKccimGPtuqkmtrDGofYMFyDNH4JXRIC+Ur/MfZ8VDrQbXd0a58/Guw==
X-Received: by 2002:a05:690c:a657:b0:787:e9f8:1869 with SMTP id 00721157ae682-78929e25fa7mr88947687b3.10.1763426404896;
        Mon, 17 Nov 2025 16:40:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221781e9sm47537627b3.52.2025.11.17.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:40:03 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH iproute2-next 0/2] devlink: support default flag attr for
 param-get and param-set commands
Date: Mon, 17 Nov 2025 16:40:01 -0800
Message-Id: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHAG2kC/x3MQQqEMAxA0atI1gamAZXxKuKi2nQmoLWkVQTx7
 haXb/H/BYlVOEFfXaB8SJItFJi6gvlvw49RXDHQhxpjDGG0ald07O2+5ISu+7beu6npaIISRWU
 v5zscQKJue2bCwGeG8b4fCi1hkm8AAAA=
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

Add cli support for default param values introduced in the
accompanying kerenl series [1]. Here is some sample usage:

[1]: https://lore.kernel.org/netdev/20251118002433.332272-1-daniel.zahka@gmail.com/

 # dump params with defaults
./devlink dev param show pci/0000:01:00.0
pci/0000:01:00.0:
  name max_macs type generic
    values:
      cmode driverinit value 128 default 128
...
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

  # set to l4_only
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode value l4_only cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value l4_only default default

  # reset to default
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode default cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (2):
      devlink: Pull the value printing logic out of pr_out_param_value()
      devlink: support displaying and resetting to default params

 devlink/devlink.c            | 165 ++++++++++++++++++++++++++++++++-----------
 include/uapi/linux/devlink.h |   3 +
 man/man8/devlink-dev.8       |  22 +++++-
 man/man8/devlink-port.8      |  20 +++++-
 4 files changed, 167 insertions(+), 43 deletions(-)
---
base-commit: da3525408f9607f1e7e41984c034d7e349317a3b
change-id: 20251112-param-defaults-d796ffdb572b

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


