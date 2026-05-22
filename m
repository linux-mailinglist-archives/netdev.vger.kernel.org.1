Return-Path: <netdev+bounces-290787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO1fNL5AEGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2115B3254
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0701E3030B0E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85A3E5ED8;
	Fri, 22 May 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh7/dP8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D63E5A14;
	Fri, 22 May 2026 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449561; cv=none; b=AxY6QXeUPGGV7Mpb+JK7Hir6W4RgYV2W2oWSudJvroxmZ9FMG2ofZkyqVyKAfnEdbIsvnzGL3q16lL3MJOfoOIy7+8awSpmvL/k7msm7M5eJYHNd+CUhfNi+hhLBVa2LYdecr26d84QsS62qZXz0xxZXIOvWE9KCZLjAI9o1+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449561; c=relaxed/simple;
	bh=jYzbxjrZthWt73Beqahfgf2Sbh7MkL70Bkt+TMyCwZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOz5B/+icrQhv8+q65fCF7zWGIevLwYoMtf9gSvXisxOs7rxiwhvZ3EHQxZcHN3PJ6wlcWc9p+fRUKTcwzZexJq25Zga9OHAxT8oYG281+kwkPTYCwIUWSoo/ndAT0OZAN3IgAkHtrg/FbO4lCJfeslEKqQFgsy3pkQ5AzbCePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh7/dP8M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849121F000E9;
	Fri, 22 May 2026 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449555;
	bh=Da/LUoEp/2+SUk5O0pH1Ab+4zQ0ZfMfGzwCZOrKrw50=;
	h=From:To:Cc:Subject:Date;
	b=Yh7/dP8MVpGmXEnnUrGwNWcFN4E56xX4fKr6q3+Lfe8cl//PkW7whJOswPXiak9oL
	 CJAtfu4HPL1xwMuSfcYahLkBNwLg6PRlKoo2udbCZymQh4OEwXunlXqabzlQlTzfkZ
	 ttK6ldvd2HPoGY66vHbpLYmCtdvqurWNUVEJRLNQHkdCB2glR+iXniPerr83qieuCI
	 cbf1OUtPmCv3EnGKif9DDUwiR3vp8CeaBCIP+lE/kEKPGT6W52XDmQq+sLMt4jlceO
	 53ybZ1T7Q/ofsyc6+q8cGy3CVzsi7XmEa94hYzE15kOWsRcmEHE4Ar3v9WNj51Igmv
	 Tmw8Rm2gIKMMg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/3] fbnic: Support larger io_uring zcrx buffers
Date: Fri, 22 May 2026 13:32:19 +0200
Message-ID: <20260522113225.241337-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A2115B3254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

Fbnic programs receive buffers through BDQs. The hardware consumes
BDQs as 4 KiB fragments, and receive completions report the consumed
buffer by returning the BDQ buffer ID in the RCD.

The driver currently derives the BDQ fragment layout from PAGE_SIZE.
That works while HPQ and PPQ use the same allocation size, but
io_uring zcrx can provide larger receive buffers through rx_buf_len.
For zcrx, the PPQ page pool allocation size and the PPQ BDQ fragment
geometry need to match the requested buffer size, without changing
HPQ.
                                                                                                                                                                                                                                                                                                                                                  
Make the BDQ fragment geometry per ring, then use the rendered RX
queue rx_page_size when creating the PPQ page pool. The NIC still
consumes the PPQ as 4 KiB fragments; a larger zcrx buffer is
represented as multiple BDQ fragments belonging to one net_iov.

Fbnic also validates rx_page_size against its own queue geometry. The
core validates the zcrx request and checks that the imported memory
can be represented as rx_buf_len-sized DMA chunks, but fbnic still
needs to make sure the PPQ retains usable depth after expanding one
software buffer into multiple 4 KiB hardware fragments.

The normal open path uses the rendered per-queue rx_page_size as well.
This preserves a memory-provider binding made while the netdev is
down, instead of falling back to the default PPQ geometry on open.

The selftest change adds an optional iou-zcrx helper check for manual
driver testing. It is not wired into the generic large-chunk test
because different drivers may legitimately return different CQE
boundaries.

Manual testing
==============

The fbnic QEMU model and firmware setup are described here:

  https://lore.kernel.org/netdev/20260309113852.2c654de5@kernel.org/

I use something like:

  KERNEL=/path/to/linux                                                                                                                                                                                                                                                                                                                           
  DISK=/path/to/fedora-qemu.raw                                                                                                                                                                                                                                                                                                                   
  OVMF_CODE=/path/to/OVMF_CODE.fd                                                                                                                                                                                                                                                                                                                 
  OVMF_VARS=/path/to/OVMF_VARS.fd                                                                                                                                                                                                                                                                                                                 
  MODS=/tmp/fbnic-modules                                                                                                                                                                                                                                                                                                                         
  QEMU=/path/to/fbnic-qemu/build/qemu-system-x86_64                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                  
  $QEMU \                                                                                                                                                                                                                                                                                                                                         
    -machine type=q35,accel=kvm \                                                                                                                                                                                                                                                                                                                 
    -drive if=pflash,format=raw,unit=0,file=$OVMF_CODE,readonly=on \                                                                                                                                                                                                                                                                              
    -drive if=pflash,format=raw,unit=1,file=$OVMF_VARS \                                                                                                                                                                                                                                                                                          
    -smp 16 -m 16G \                                                                                                                                                                                                                                                                                                                              
    -object memory-backend-memfd,id=mem,size=16G,share=on \                                                                                                                                                                                                                                                                                       
    -numa node,memdev=mem \                                                                                                                                                                                                                                                                                                                       
    -kernel $KERNEL/arch/x86/boot/bzImage \                                                                                                                                                                                                                                                                                                       
    -append "root=/dev/vda2 rw console=ttyS0 earlycon" \                                                                                                                                                                                                                                                                                          
    -drive file=$DISK,format=raw,if=none,id=drive0 \                                                                                                                                                                                                                                                                                              
    -device virtio-blk-pci,drive=drive0 \                                                                                                                                                                                                                                                                                                         
    -no-user-config -nodefaults -nographic \                                                                                                                                                                                                                                                                                                      
    -virtfs local,path=$MODS/lib/modules,mount_tag=modules,security_model=none,readonly=on \                                                                                                                                                                                                                                                      
    -virtfs local,path=$KERNEL,mount_tag=hostshare,security_model=none,readonly=on \                                                                                                                                                                                                                                                              
    -netdev user,id=hostnet0,hostfwd=tcp::9999-:9999 \                                                                                                                                                                                                                                                                                            
    -netdev hubport,id=hub_uplink,hubid=0,netdev=hostnet0 \                                                                                                                                                                                                                                                                                       
    -device virtio-net-pci,netdev=n1 \                                                                                                                                                                                                                                                                                                            
    -netdev hubport,id=n1,hubid=0 \                                                                                                                                                                                                                                                                                                               
    -device pcie-root-port,id=pcie.1,bus=pcie.0,chassis=1 \                                                                                                                                                                                                                                                                                       
    -device fbnic,bus=pcie.1,id=fbnic.1,mac=00:de:ad:be:ef:01,netdev=n2,rbt=skt.0,bar4=ctrl.1 \                                                                                                                                                                                                                                                   
    -netdev hubport,id=n2,hubid=0 \                                                                                                                                                                                                                                                                                                               
    -chardev socket,id=ctrl.1,path=/tmp/fbnic-ctrl-skt \                                                                                                                                                                                                                                                                                          
    -netdev socket,id=skt.0,connect=localhost:9000 \                                                                                                                                                                                                                                                                                              
    -serial mon:stdio                                                                                                                                                                                                                                                                                                                             

Here you'll get a fbnic device, host port forwarding for TCP port
9999, and a 9p mount for the kernel tree and modules.

Inside the guest:

  mount -t 9p -o trans=virtio,version=9p2000.L hostshare /host

  cd /host/tools/testing/selftests/drivers/net/hw

  ethtool -L enp1s0 combined 2
  ethtool -G enp1s0 tcp-data-split on hds-thresh 0 rx 64
  ethtool -X enp1s0 equal 1
  ethtool -N enp1s0 flow-type tcp4 dst-ip 10.0.2.15 dst-port 9999 action 1

  echo 64 > /proc/sys/vm/nr_hugepages
  ./iou-zcrx -s -i enp1s0 -p 9999 -q 1 -x 2

On the host:

  cd /path/to/linux/tools/testing/selftests/drivers/net/hw
  ./iou-zcrx -c -h 127.0.0.1 -p 9999 -l 12840

For fbnic-specific manual checking that traffic reaches the second 4
KiB fragment of an 8 KiB zcrx buffer, run the receiver with:

  ./iou-zcrx -s -i enp1s0 -p 9999 -q 1 -x 2 -F 4096


Björn Töpel (3):
  fbnic: Track BDQ fragment geometry per ring
  fbnic: Support larger zcrx receive buffers
  selftests: drv-net: Add zcrx payload offset check

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  29 +--
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 168 ++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
 .../selftests/drivers/net/hw/iou-zcrx.c       |  28 ++-
 5 files changed, 176 insertions(+), 60 deletions(-)


base-commit: 1a1f055318d82e64485a6ff8420e5f70b4267998
--
2.53.0


