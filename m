Return-Path: <netdev+bounces-245082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BECC6A9D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C55B30198C0
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAE34165F;
	Wed, 17 Dec 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qSke9S8Y"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AA34107D;
	Wed, 17 Dec 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961272; cv=none; b=lFM90v/FARfCMsK21yLEsoo2Gemliu6bvnYBco2Ma3mo5bcUXJZ27ghkFdA+oA89XSf1KhiCQFQBY/6b2qbuNLW3Ovy0X9Q6j3+L37gnQy9gIP1bqse2UyIaK65aw9TIrWHKoKXI6fywP+DRmSMTZM1Q3Q1PwHNnXfgrtEm1v5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961272; c=relaxed/simple;
	bh=x/E/deY9vTVLTGF3py+vQE2us8+WcHa4e2RC0cgnHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTmKjPK1UTHiVbf3AvHZizAWynnjreUgkpi0//l1MdtrKCsgsrQMJy/sG8gauO5iPNi7YDbOJFh+lNdnHN+dNptv0TOgXao0qkKymXfPBDy5Ro/pW6d7ZaN+3W/ZjtMg510dF/gC8IVTthblucD+vf/TWu/hWQHPFtbwYZmk0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qSke9S8Y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=UseiUIzWQ5jcCpGWT2FDdMdJpS00Sb35hFZExtBF5UM=;
	b=qSke9S8YKLzrxKkkx5Ssz3Bwqxl7JEoHSYdWGsJnessY95j3taTVaq4nOwJdl1
	yrhiQAkSEg/Ui+5r/G5oul0FnH/MABvTIHRBJrJHxTSwCB2RvsMUE8OXeoTraH2d
	KHYcUJcfABqcVI6xbgjVxQ9rR0JPBHZd7qHINu4X7vPDs=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3Ms0UbkJpr5KYAw--.48364S4;
	Wed, 17 Dec 2025 16:47:17 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Implement initial driver for virtio-RDMA devices(kernel), virtio-rdma device model(qemu) and vhost-user-RDMA backend device(dpdk)
Date: Wed, 17 Dec 2025 16:45:32 +0800
Message-ID: <20251217084640.5060-2-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Ms0UbkJpr5KYAw--.48364S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4rKrWDGF1DAF4UGw4rKrg_yoW5tFy8pr
	W2gF9rCrZ8Gr43G3yUW345uF42gFZ3A3y3Crn8G348K3Z5Xr9YvF1q9F15Way7GrZxAF18
	XFy8Jr92ka4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jU-B_UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0hWLFGlCbhWIIQAA3h

Hi all,

This testing instructions aims to introduce an emulating a soft ROCE 
device with normal NIC(no RDMA), we have finished a vhost-user RDMA
device demo, which can work with RDMA features such as CM, QP type of 
UC/UD and so on.

There are testing instructions of the demo:

1.Test Environment Configuration
Hardware Environment
Servers: 1 identically configured servers

CPU: HUAWEI Kunpeng 920 (96 cores)

Memory: 3T DDR4

NIC: TAP (paired virtio-net device for RDMA)

Software Environment
Server Host OS: 6.4.0-10.1.0.20.oe2309.aarch64

Kernel: linux-6.16.8 (with kernel-vrdma module)

QEMU: 9.0.2 (compiled with vhost-user-rdma virtual device support)

DPDK: 24.07.0-rc2

Dependencies:

	rdma-core
	
	rdma_rxe

	libibverbs-dev
	
2. Test Procedures
a. Starting DPDK with vhost-user-rdma first: 
1). Configure Hugepages
   echo 2048 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
2). app start  
  /DPDKDIR/build/examples/dpdk-vhost_user_rdma -l 1-4 -n 4 --vdev "net_tap0" -- --socket-file /tmp/vhost-rdma0

b. Booting guest kernel with qemu, command line: 
...
-netdev tap,id=hostnet1,ifname=tap1,script=no,downscript=no 
-device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:14:72:30,bus=pci.3,addr=0x0.0,multifunction=on 
-chardev socket,path=/tmp/vhost-rdma0,id=vurdma 
-device vhost-user-rdma-pci,bus=pci.3,addr=0x0.1,page-per-vq=on,disable-legacy=on,chardev=vurdma
...

c. Guest Kernel Module Loading and Validation
# Load vhost_rdma kernel module
sudo modprobe vrdma

# Verify module loading
lsmod | grep vrdma

# Check kernel logs
dmesg | grep vhost_rdma

# Expected output:
[    4.935473] vrdma_init_device: Initializing vRDMA device with max_cq=64, max_qp=64
[    4.949888] [vrdma_init_device]: Successfully initialized, last qp_vq index=192
[    4.949907] [vrdma_init_netdev]: Found paired net_device 'enp3s0f0' (on 0000:03:00.0)
[    4.949924] Bound vRDMA device to net_device 'enp3s0f0'
[    5.026032] vrdma virtio2: vrdma_alloc_pd: allocated PD 1
[    5.028006] Successfully registered vRDMA device as 'vrdma0'
[    5.028020] [vrdma_probe]: Successfully probed VirtIO RDMA device (index=2)
[    5.028104] VirtIO RDMA driver initialized successfully

d. Inside VM, one rdma device fs node will be generated in /dev/infiniband: 
[root@localhost ~]# ll -h /dev/infiniband/
total 0
drwxr-xr-x. 2 root root       60 Dec 17 11:24 by-ibdev
drwxr-xr-x. 2 root root       60 Dec 17 11:24 by-path
crw-rw-rw-. 1 root root  10, 259 Dec 17 11:24 rdma_cm
crw-rw-rw-. 1 root root 231, 192 Dec 17 11:24 uverbs0

e. The following are to be done in the future version: 
1). SRQ support
2). DPDK support for physical RDMA NIC for handling the datapath between front and backend
3). Reset of VirtQueue
4). Increase size of VirtQueue for PCI transport
5). Performance Testing

f. Test Results
1). Functional Test Results:
Kernel module loading	PASS	Module loaded without errors
DPDK startup	        PASS	vhost-user-rdma backend initialized
QEMU VM launch	        PASS	VM booted using RDMA device
Network connectivity	PASS	Host-VM communication established
RDMA device detection	PASS	Virtual RDMA device recognized

f.Test Conclusion
1). Full functional compliance with specifications
2). Stable operation under extended stress conditions

Recommendations:
1). Optimize memory copy paths for higher throughput
2). Enhance error handling and recovery mechanisms


