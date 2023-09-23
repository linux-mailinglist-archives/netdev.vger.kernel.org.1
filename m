Return-Path: <netdev+bounces-35979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3927AC3CC
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A7D8228113B
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36110208C5;
	Sat, 23 Sep 2023 17:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B11F5E4
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 17:05:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DAD11B
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695488750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oUMO2OtaVNrK4yV1FIaqhnvn7xtcxe5yI1/jQcR5/F8=;
	b=PiD7JRKL7uMjz8moxLSIuEhQ3HmGDWBvFnYDGlxnPBfEbdBzPN+b0tkzgjLYlGn+oqyW7e
	AIb+Acw3SZcsarkrAlbJQ38ASCsCgCYaR8xeLrW5Q3uC0RpHBPN5gzllCX94w2x4AvrdsD
	WjfzpsoQ5ezY/7Lt9SmPb4O2JxAiBtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-0vJcqFGBM1iH50Q-lv9VZw-1; Sat, 23 Sep 2023 13:05:47 -0400
X-MC-Unique: 0vJcqFGBM1iH50Q-lv9VZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3BC9811E7E;
	Sat, 23 Sep 2023 17:05:46 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 949EB2026D4B;
	Sat, 23 Sep 2023 17:05:43 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC 0/7] vdpa: Add support for iommufd
Date: Sun, 24 Sep 2023 01:05:33 +0800
Message-Id: <20230923170540.1447301-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All
Really apologize for the delay, this is the draft RFC for
iommufd support for vdpa, This code provides the basic function 
for iommufd support 

The code was tested and passed in device vdpa_sim_net
The qemu code is
https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
The kernel code is
https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC

ToDo
1. this code is out of date and needs to clean and rebase on the latest code 
2. this code has some workaround, I Skip the check for
iommu_group and CACHE_COHERENCY, also some misc issues like need to add
mutex for iommfd operations 
3. only test in emulated device, other modes not tested yet

After addressed these problems I will send out a new version for RFC. I will
provide the code in 3 weeks

Thanks
Cindy 
Signed-off-by: Cindy Lu <lulu@redhat.com>
The test step is
1. create vdpa_sim device
...
vdpa dev add name vdpa15 mgmtdev vdpasim_net
...
2. load the VM with the command
  -object iommufd,id=iommufd0 \
  -device virtio-net-pci,netdev=vhost-vdpa1,disable-legacy=on,disable-modern=off\
  -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa1,iommufd=iommufd0\

3. in guest VM you can find the vdpa_sim port works well.
[root@ubuntunew ~]# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
        ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
        RX packets 53  bytes 9108 (8.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 53  bytes 9108 (8.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[root@ubuntunew ~]# ./test.sh eth0
[  172.815279] pktgen: Packet Generator for packet performance testing. Version: 2.75
Adding queue 0 of eth0
Configuring devices eth0@0
Running... ctrl^C to stop

[root@ubuntunew ~]# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
        ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
        RX packets 183455  bytes 11748533 (11.2 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 183473  bytes 11749685 (11.2 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Cindy Lu (7):
  vhost/iommufd: Add the functions support iommufd
  Kconfig: Add the new file vhost/iommufd
  vhost: Add 3 new uapi to support iommufd
  vdpa: change the map/unmap process to support iommufd
  vdpa: Add new vdpa_config_ops
  vdpa_sim :Add support for iommufd
  iommufd: Skip the CACHE_COHERENCY and iommu group check

 drivers/iommu/iommufd/device.c   |   6 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c |   8 ++
 drivers/vhost/Kconfig            |   1 +
 drivers/vhost/Makefile           |   1 +
 drivers/vhost/iommufd.c          | 151 +++++++++++++++++++++++
 drivers/vhost/vdpa.c             | 201 +++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h            |  21 ++++
 include/linux/vdpa.h             |  34 +++++-
 include/uapi/linux/vhost.h       |  71 +++++++++++
 9 files changed, 490 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vhost/iommufd.c

-- 
2.34.3


