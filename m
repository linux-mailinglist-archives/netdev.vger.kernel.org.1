Return-Path: <netdev+bounces-126938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27F973276
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C61C2441C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B519E7E7;
	Tue, 10 Sep 2024 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYs6LG6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14719DFAC
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963436; cv=none; b=f2GivlXcy7QbG0bLgAJr6Qa5iLVvl6631Jn4mOi/RPcBuPYlXIiq54EPn34BrxissoyY8ICeXfLnKhvsES5nd3RaV5R0WNmY1lB4a7eQFPrJ8VmaV2a4kwhvILnNoHnD8p+Dd2zhkkRdSenbqHnosJjkALwn0w0CNgrxG0FmiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963436; c=relaxed/simple;
	bh=wImfXMoZ5B2yLzT8FnYI1lRVaypfWo0B3Gx0AgOak9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pTsI3TlTFXL7Qot70mU1LhgDtDdiEhYiH5WlaLpBe0QGZpGm3zeAjY/bXyjvuCnf5pwgNElENZnbIZqV9UQgbN9xGwaOAPu5RhVrlJQ7t7IrPHOfmimaE5d8f8YEsl3hA7jJhFLqde/DvH8cPhtscdo5ZfPgHsRztKP6Inex0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYs6LG6j; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718f28f77f4so592653b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725963434; x=1726568234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyeVR3mB1XOSCzQtVkCuXomgdvtRDbuqoRkgdL7q/VI=;
        b=NYs6LG6jgHP06qgI9F+mJsZA6XZ5hpOvvOJw54DKB7wJ2TAugELfoc1HHT4WEaAm8N
         Ur4aVMC9lkhFcGl+pmMCDvzEpGV0G3GpI1H2gibJayEw+RdroVzCfyY+JHx8CrBnffPh
         N3OGbvoucENV7AmBUIuPpZYhqEuVtQnDP2piKIumpFD7t+8c2bJjkJ1U6LnzXDrL+9eP
         /3v+JLWqrB4oeD/ZJ3EpOKzlzz7m9JCUs3J65jwbfMnPMYhxgTDXc0phG5ntvvhkCLKL
         Tzzf6TvxqcKaoD2wqWYa7eNi2zkR7L/OuIbDey2nYGUltF7X6M75Kv7gkrm8P86qVdg5
         fZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963434; x=1726568234;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyeVR3mB1XOSCzQtVkCuXomgdvtRDbuqoRkgdL7q/VI=;
        b=aPZ7W5AYJAqPNxyh62q5l5QL9F9LCY2ytBXWf54ioGEDIAgYZWCYQ/Kb6b67FIqX6q
         +9C3/7AhmcZiE+Phz2LpwJGMrze74UFDX6mscipLEzLGfRTvNfzckYAalKU93J0BOPiz
         ih/9uOBLXqIGI201dxAD4DIC8wxph8cDmkmSg7JACL3muaKbWUdLmwwLtA/QHFvkYADz
         WbLNCee7h9H1XiNvPCSnTyfDKQHDI95Cmn8m2D9EZA9OGZTD9zf2DsNvnKOl08DwOLzE
         dkk4ze11Yz6hnhRnyTtY7hnyok5yw8hhEOrEBQQp3JKVEcIYcieeTwwTPJam1x59PLcf
         /FOQ==
X-Gm-Message-State: AOJu0YylQvvL+MjkycnZIy23pUPhtCcrSQzW+W7F9I+kvZmmqxkAZVTz
	4mi7RX1kbZBfKyLuzHZdfnpV7LnUxTVWw7Fq8rJ+ag/FWh/QLhjYxWSGdIui/g9e+Q==
X-Google-Smtp-Source: AGHT+IEpS+BlakB9Lfrozp7rc6nx5VIvJZ3QOH2Cuq4xxR3pxf8xfbrD9XqRZziPh6BHJQNQy69C1w==
X-Received: by 2002:a05:6a21:478b:b0:1cf:2d44:1f2d with SMTP id adf61e73a8af0-1cf5e1abe91mr274019637.38.1725963434074;
        Tue, 10 Sep 2024 03:17:14 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8237362casm4589004a12.2.2024.09.10.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:17:13 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:17:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Stanislas Faye <sfaye@redhat.com>
Subject: [Discuss] ARP monitor for OVS bridge over bonding
Message-ID: <ZuAcpIqvJYmCTFFK@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

Recently, our customer got an issue with OVS bridge over bonding. e.g.

  eth0      eth1
   |         |
   -- bond0 --
        |
      br-ex (ovs-vsctl add-port br-ex bond0; ip addr add 192.168.1.1/24 dev br-ex)


Before sending arp message for bond slave detecting, the bond need to check
if the br-ex is in the same data path with bond0 via function
bond_verify_device_path(), which using netdev_for_each_upper_dev_rcu()
to check all upper devices. This works with normal bridge. But with ovs
bridge, the upper device is "ovs-system" instead of br-ex.

After talking with OVS developers. It turned out the real upper OVS topology
is looks like

              --------------------------------
              |                              |
  br-ex  -----+--      ovs-system            |
              |                              |
  br-int -----+--                            |
              |                              |
              |    bond0    eth2   veth42    |
              |      |       |       |       |
              |      |       |       |       |
              -------+-------+-------+--------
                     |       |       |
                  +--+--+  physical  |
                  |     |    link    |
                eth0  eth1          veth43

The br-ex is not upper link of bond0. ovs-system, instead, is the master
of bond0. This make us unable to make sure the br-ex and bond0 is in the
same datapath.

On the other hand, as Adrián Moreno said, the packets generated on br-ex
could be routed anywhere using OpenFlow rules (including eth2 in the
diagram). The same with normal bridge, with tc/netfilter rules, the packets
could also be routed to other interface instead of bond0.

So the rt interface checking in bond_arp_send_all() is not always correct.
Stanislas suggested adding a new parameter like 'arp monitor source interface'
to binding that the user could supply. Then we can do like
	If (rt->dst.dev == arp_src_iface->dev)
		goto found;

What do you think?

Thanks
Hangbin

