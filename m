Return-Path: <netdev+bounces-26788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA855778F2D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EED1C20B31
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8297125AC;
	Fri, 11 Aug 2023 12:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF29134CF
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:19:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1D2D5B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:18:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 097D221870;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0guy6Kwb2D1N8Y0N+hhU5yzEE3nfdd5dkj2ObzwgKKo=;
	b=I2bF8/VzktMs362GMUfCVO3puieq4JwTOC9HwLhfMjwpCLHZtiRixq1ujHtNedaJhLland
	o+rKPapGmyIoN006Ph0E9gpNw7x4VGpNTH05CTr/tZsojnB8o2UfSU/ksUVHg8U3sUIgu/
	PCIv5vk5rNYQVvSZepngFAIe50yDmT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0guy6Kwb2D1N8Y0N+hhU5yzEE3nfdd5dkj2ObzwgKKo=;
	b=wX4vFwrAIC193XhoXi71HPcB6Zuo0RsrNpUqBJjiU2bgsHAcW5Y7UOpHEvi3cM58PCauIR
	utJgq8GoMx0+NfCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D70092C145;
	Fri, 11 Aug 2023 12:18:05 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C1B3E51CAEE4; Fri, 11 Aug 2023 14:18:05 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8 00/17] nvme: In-kernel TLS support for TCP
Date: Fri, 11 Aug 2023 14:17:38 +0200
Message-Id: <20230811121755.24715-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

with the merge of Chuck Levers handshake upcall mechanism and
my tls_read_sock() implementation finally merged with net-next
it's now time to restart on the actual issue, namely implementing
in-kernel TLS support for nvme-tcp.

The patchset is based on the recent net-next git tree;
everything after commit ba4a734e1aa0 ("net/tls: avoid TCP window
full during ->read_sock()") should work.
You might want to add the patch
'nvmet-tcp: use 'spin_lock_bh' for state_lock()'
before applying this patchset; otherwise results might be ...
interesting.

It also requires the 'tlshd' userspace daemon
(https://github.com/oracle/ktls-utils)
for the actual TLS handshake.
Changes for nvme-cli are already included in the upstream repository.

Theory of operation:
A dedicated '.nvme' keyring is created to hold the pre-shared keys (PSKs)
for the TLS handshake. Keys will have to be provisioned before TLS handshake
is attempted; that can be done with the 'nvme gen-tls-key' command for nvme-cli
(patches are already merged upstream).
After connection to the remote TCP port the client side will use the
'best' PSK (as inferred from the NVMe TCP spec) or the PSK specified
by the '--tls_key' option to nvme-cli and call the TLS userspace daemon
to initiate a TLS handshake.
The server side will then invoke the TLS userspace daemon to run the TLS
handshake.
If the TLS handshake succeeds the userspace daemon will be activating
kTLS on the socket, and control is passed back to the kernel.

This implementation currently does not implement the so-called
'secure concatenation' mode from NVMe-TCP; a TPAR is still pending
with fixes for it, so I'll wait until it's published before
posting patches for that.

Patchset can be found at:
git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch tls.v12

For testing I'm using this script, running on a nvme target
with NQN 'nqn.test' and using 127.0.0.1 as a port:

modprobe nvmet-tcp
nvmetcli restore
modprobe nvme-tcp
./nvme gen-tls-key --subsysnqn=nqn.test -i
./nvme gen-tls-key --subsysnqn=nqn.2014-08.org.nvmexpress.discovery -i
tlshd -c /etc/tlshd.conf

and then one can do a simple:
# nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.test --tls
to start the connection.

As usual, comments and reviews are welcome.

Changes to v7:
- Include reviews from Simon
- Do not call sock_release() when sock_alloc_file() fails

Changes to v6:
- More reviews from Sagi
- Fixup non-tls connections
- Fixup nvme options handling
- Add reference counting to nvmet-tcp queues

Changes to v5:
- Include reviews from Sagi
- Split off nvmet tsas/treq handling
- Sanitize sock_file handling

Changes to v4:
- Split off network patches into a separate
  patchset
  - Handle TLS Alert notifications

Changes to v3:
- Really handle MSG_EOR for TLS
- Fixup MSG_SENDPAGE_NOTLAST handling
- Conditionally disable fabric option

Changes to v2:
- Included reviews from Sagi
- Removed MSG_SENDPAGE_NOTLAST
- Improved MSG_EOR handling for TLS
- Add config options NVME_TCP_TLS
  and NVME_TARGET_TCP_TLS

Changes to the original RFC:
- Add a CONFIG_NVME_TLS config option
- Use a single PSK for the TLS handshake
- Make TLS connections mandatory
- Do not peek messages for the server
- Simplify data_ready callback
- Implement read_sock() for TLS

Hannes Reinecke (17):
  nvme-keyring: register '.nvme' keyring
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  nvme-keyring: implement nvme_tls_psk_default()
  security/keys: export key_lookup()
  nvme-tcp: allocate socket file
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: control message handling for recvmsg()
  nvme-fabrics: parse options 'keyring' and 'tls_key'
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
  nvmet-tcp: allocate socket file
  nvmet-tcp: reference counting for queues
  nvmet: Set 'TREQ' to 'required' when TLS is enabled
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: control messages for recvmsg()

 drivers/nvme/common/Kconfig    |   4 +
 drivers/nvme/common/Makefile   |   3 +-
 drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++
 drivers/nvme/host/Kconfig      |  15 ++
 drivers/nvme/host/core.c       |  12 +-
 drivers/nvme/host/fabrics.c    |  61 +++++-
 drivers/nvme/host/fabrics.h    |   9 +
 drivers/nvme/host/nvme.h       |   1 +
 drivers/nvme/host/sysfs.c      |  21 +++
 drivers/nvme/host/tcp.c        | 172 ++++++++++++++++-
 drivers/nvme/target/Kconfig    |  15 ++
 drivers/nvme/target/configfs.c | 108 ++++++++++-
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 335 ++++++++++++++++++++++++++++-----
 include/linux/nvme-keyring.h   |  36 ++++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 +
 security/keys/key.c            |   1 +
 18 files changed, 935 insertions(+), 57 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


