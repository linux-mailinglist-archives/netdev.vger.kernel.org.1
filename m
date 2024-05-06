Return-Path: <netdev+bounces-93884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A48BD847
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC001F23EC8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195315D5C8;
	Mon,  6 May 2024 23:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62591E891
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039588; cv=none; b=aeivOcL7VTpX+cPMkRKVqbTwUlSufUUG29vkMTcFE1eCwpoBavgEdVcup6saX3WAxj5WDMMVyishqaDqF+oOzXNeQyXqe+4fv+ZjykTEyhOEXPQXFS/hu+ACnV2ucnsEtW1dRRLZFUwAJchqnwiwRdsOvr3rNK5YE1T1ghp3vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039588; c=relaxed/simple;
	bh=bqUNyjuJOlFRpmCSkcUeX940jla/mrxHWgpoWiCxzmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkmPLuw3n0ILV/5/OU5nGY5rIXS9G2fISZHGNWRu2eBKUF3tU6PEhOwSymBw1CDV763DpN8Nt1olLtYztMoG5sAvGWmNH3FvJok+nBoTnqKm/parxw+61XddVzZjiZjJu0NwALfa5UoDE9f19O8BvKSFvtt5K5npK1QuD0SZso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 00/12] gtp updates for net-next (v3)
Date: Tue,  7 May 2024 01:52:39 +0200
Message-Id: <20240506235251.3968262-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

-o-
This v3 includes:
- fix for clang uninitialized variable per Jakub.
- address Smatch and Coccinelle reports per Simon
- remove inline in new IPv6 support per Simon
- fix memleaks in netlink control plane per Simon
-o-

The following patchset contains IPv6 GTP driver support for net-next,
this also includes IPv6 over IPv4 and vice-versa:

Patch #1 removes a unnecessary stack variable initialization in the
         socket routine.

Patch #2 deals with GTP extension headers. This variable length extension
         header to decapsulate packets accordingly. Otherwise, packets are
         dropped when these extension headers are present which breaks
         interoperation with other non-Linux based GTP implementations.

Patch #3 prepares for IPv6 support by moving IPv4 specific fields in PDP
         context objects to a union.

Patch #4 adds IPv6 support while retaining backward compatibility.
         Three new attributes allows to declare an IPv6 GTP tunnel
         GTPA_FAMILY, GTPA_PEER_ADDR6 and GTPA_MS_ADDR6 as well as
         IFLA_GTP_LOCAL6 to declare the IPv6 GTP UDP socket. Up to this
         patch, only IPv6 outer in IPv6 inner is supported.

Patch #5 uses IPv6 address /64 prefix for UE/MS in the inner headers.
         Unlike IPv4, which provides a 1:1 mapping between UE/MS,
         IPv6 tunnel encapsulates traffic for /64 address as specified
         by 3GPP TS. Patch has been split from Patch #4 to highlight
         this behaviour.

Patch #6 passes up IPv6 link-local traffic, such as IPv6 SLAAC, for
         handling to userspace so they are handled as control packets.

Patch #7 prepares to allow for GTP IPv4 over IPv6 and vice-versa by
         moving IP specific debugging out of the function to build
         IPv4 and IPv6 GTP packets.

Patch #8 generalizes TOS/DSCP handling following similar approach as
         in the existing iptunnel infrastructure.

Patch #9 adds a helper function to build an IPv4 GTP packet in the outer
         header.

Patch #10 adds a helper function to build an IPv6 GTP packet in the outer
          header.

Patch #11 adds support for GTP IPv4-over-IPv6 and vice-versa.

Patch #12 allows to use the same TID/TEID (tunnel identifier) for inner
          IPv4 and IPv6 packets for better UE/MS dual stack integration.

This series integrates with the osmocom.org project CI and TTCN-3 test
infrastructure (Oliver Smith) as well as the userspace libgtpnl library.

Thanks to Harald Welte, Oliver Smith and Pau Espin for reviewing and
providing feedback through the osmocom.org redmine platform to make this
happen.

----------------------------------------------------------------

The following changes since commit 353f5ffbc63b532aa0c92a7635e84bd53d04644e:

  gtp: remove useless initialization (2024-05-07 01:35:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git tags/gtp-24-05-07

for you to fetch changes up to c75fc0b9e5be7350ab1c73a0dcd48e9a8985ce24:

  gtp: identify tunnel via GTP device + GTP version + TEID + family (2024-05-07 01:36:02 +0200)

----------------------------------------------------------------
gtp pull request 24-05-07

----------------------------------------------------------------
Pablo Neira Ayuso (11):
      gtp: properly parse extension headers
      gtp: prepare for IPv6 support
      gtp: add IPv6 support
      gtp: use IPv6 address /64 prefix for UE/MS
      gtp: pass up link local traffic to userspace socket
      gtp: move debugging to skbuff build helper function
      gtp: remove IPv4 and IPv6 header from context object
      gtp: add helper function to build GTP packets from an IPv4 packet
      gtp: add helper function to build GTP packets from an IPv6 packet
      gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP
      gtp: identify tunnel via GTP device + GTP version + TEID + family

 drivers/net/gtp.c            | 861 ++++++++++++++++++++++++++++++++++++-------
 include/net/gtp.h            |   5 +
 include/uapi/linux/gtp.h     |   3 +
 include/uapi/linux/if_link.h |   2 +
 4 files changed, 743 insertions(+), 128 deletions(-)

