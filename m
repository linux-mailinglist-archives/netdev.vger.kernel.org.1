Return-Path: <netdev+bounces-288574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBfiG/T7B2o8TwMAu9opvQ
	(envelope-from <netdev+bounces-288574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4055A3EC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0EB3013A68
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323FE280335;
	Sat, 16 May 2026 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2LQ5dtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC519F12D
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778908145; cv=none; b=EtJGlBvwn3sS/N7iXSTkC0RglYTKYoipc/7hEPLvY6h2UXwio3Zg7HgVJQFfBtk3zuN1dYPPZ37KgsW11mbNuVErnD0qNImELVJAdIv/7MFzpLtmO1Z9I3yAsw1tH9ZW2YbJF/+QVBkl9qfb8KGbbOy5PqbS9mR0b0xJTlrWpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778908145; c=relaxed/simple;
	bh=ISuYdhRgBF/I88vajJ/AvTvMbUJp4nxRUWM9QUUwl60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GC2dT4ccCqDkH/V52xPgyTZzgg6YVzBU4trOAkmpsvQHQeUuKNqyYX169GZ9tOovABLNsPV0LOlXLbtC4bCfDB6eKssvHb2hRMULwD9R+93S8zQeUdi5lj0tlsbkzzk3Th2m7YRJ7KfppXH2+krS+wIwFNPJB70SgDNqkG5qDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2LQ5dtI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso1951565e9.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778908142; x=1779512942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiPdzVDkhoOohsVNfeXeRSo393UPIi49IoHtz+Ot6WE=;
        b=S2LQ5dtIWa/CvZ9UuoWo4fQ/qPkn2hrzKEFJ9Y7u74cgaiJw8QUs6bl9M/ndrF2BKe
         hTtJ6zjZLCk7xpJEYKYb/X4NTlnF5uZhZgSsugdOLyaFb1o2gXf9jk8v8+suc9+ADDtB
         D+1eDMQimbyjadGrghGdJBAZlLZRmPL1oZfFkbe4Ukr+QnK52I0bYCIWFFD1WcVBkRHq
         rmrwatr0M1PRG7NRmbjyRMQNG8p4fKKziqBOT0OtWONu6VOCnz/Th8UFo0XwooRxCGao
         HAXQqoRby1aZqB2YamgP0Wz3+nKX3D53gIDTJ6GghUrsrK9JpJAhKKhLNDQsjO/bam2J
         I/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778908142; x=1779512942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiPdzVDkhoOohsVNfeXeRSo393UPIi49IoHtz+Ot6WE=;
        b=DjZ1+uaSzRe8e/En4veXc7K6UGRatltNkCgYQpE3STIKz1mPS1WX/8VZYHmHrwOmAd
         oCpecZdfQUTHaFQDlV4EPXinwoj7CgqP98uVJg+IFDlwY00YdgebANBA7HdrldNdq9k2
         7u8xd3t4N1C3x46V1cgFQjhymnnIX4KiFThzW+IEqi+iRU05h/FGAl+1w9Bh5XBNvPRW
         J02vIocWPXrAVL+9tcqKTC9wA6Wmj6RwVmKoSswEKkVQHLr0WTPYLaZCrPNai8U0MiNm
         lKwfd1FyXxgkCjKBPMEIiRgV5NmW8ae4xIGzw+rlxrlkpYzJ7xyruFA3wLXjJQJZsfNK
         6bUA==
X-Gm-Message-State: AOJu0YzL70ANDk+0NmhlMb1FI6VHlT10LJ3W8rkGjNx+zUzwc1WX0ozl
	EwpKSYGR9a5dxi3quLQWRP2HiJAmCkZ4NjzeYvQsIKRkHzJPr0V782Jv14fBuPTL
X-Gm-Gg: Acq92OFnTB42xujK6UKFPk/vQd7iy9lv/kB3YjfBsmxJMB7Fc4kcDy/vAzbwLR1Nbyt
	tuAX9fbFULeiao0GaAJ5w0Fc2sC8dgZ8vszok6MKqu7aCMLYzERNYCqW12VBQmcnuXKCtxcoh/7
	FSgUKoVN56VLJSqmZGzubeAGo/ilRLuENCHzEG/ATtBAwZ4ymQjGDloD46VBnT41x/R26uS7s7D
	zBlFTxAS3ynq677H9XtGQLa1/EEbpSSv78FsxC6JJtJDvxAVCiAaNLnbjBkCI+KNoDMGp5P8rOj
	+bXJhREM2wYd55YxFMhFTvAiyvDqDbbsn72cm+kH0JBgiXpQVIY9M4wHKo0ko+8HFRkN93lt51G
	4Q1ifWILrPkEFH/1uU1FHz4288stDipQPnP1ZFo9hZimqUthIQcLayZzZSrD4d9w6paooKtlQn1
	cHM4xwElJYPu2AQRHqpgj0Xx+RKW6m+ynVtZvQv2+0b0ZjyIvPsG7JrrNfK6XNqCGtROo+pFe6V
	s2jqKbJYx9GCpY3ODD5SQ==
X-Received: by 2002:a05:600c:4fc9:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48fe60e3b17mr86047875e9.4.1778908141750;
        Fri, 15 May 2026 22:09:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm20648123f8f.4.2026.05.15.22.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 22:09:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	andrew@lunn.ch,
	David Carlier <devnexen@gmail.com>
Subject: [RFC net-next 0/1] net: add Two-Port MAC Relay (TPMR) driver
Date: Sat, 16 May 2026 06:08:57 +0100
Message-ID: <20260516050858.23858-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBB4055A3EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288574-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,lunn.ch,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openbsd.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

This is an RFC for a small netdevice driver implementing the
Two-Port MAC Relay from IEEE 802.1Q-2014 §6.7.1. A TPMR is a
deliberately stripped-down L2 relay: exactly two ports, no FDB, no
MAC learning, no STP, and -- by spec -- it forwards most of the
01:80:C2:00:00:0X reserved group that a regular bridge consumes
(LACPDUs, LLDP, EAPOL, and so on).

The reason I started looking at this is that there is no clean way
to put a Linux box in the middle of a link without breaking the
control plane on either side. The obvious answer -- "use a bridge
with learning and STP disabled" -- doesn't actually work, because
br_input.c filters BPDUs / PAE / LACP before group_fwd_mask gets a
chance to forward them, so anything on the wire that relies on
those frames reaching the far end (link aggregation, MACsec setups,
802.1X) silently breaks. tc mirred only mirrors; macvlan passthru
is single-master; an XDP redirect between two ifaces works but
isn't a netdevice, so neither ip link nor any of the network
managers can drive it. None of these are what the IEEE standard
already describes.

OpenBSD's tpmr(4) [1] has filled this niche since 2019. The driver
proposed here is inspired by that one but mapped onto rx_handler /
rtnl_link_ops, which lets us drop a lot of the BSD bookkeeping
since the Linux framework already provides it. Details are in the
patch's commit message.

It's sent as an RFC because there are a handful of design choices
I'd rather get pushback on now than after I've written the
selftests:

1. New driver vs. a tpmr mode of the bridge. The fundamental
   question. A separate driver keeps the bridge code untouched and
   sidesteps br_input.c's filtering entirely; a bridge mode would
   reuse the slave management you already have. I lean toward the
   separate driver -- the semantics are different from what a
   bridge guarantees and switchdev offload would be cleaner -- but
   I'd genuinely rather hear from the bridge maintainers before
   going further.

2. MTU policy. Strict (reject mismatched slaves, refuse desyncing
   changes, bridge-like) or pass-through (bond-like). The current
   patch enforces strict at enslave time (a second slave whose MTU
   differs is rejected); runtime MTU policing via a notifier is
   left for v1 so the shape of that callback can be discussed
   first.

3. VLAN-tagged frames. The OpenBSD driver bails out on them. Here
   they are forwarded with the tag preserved -- in the MACsec /
   LAG cases that's almost certainly what users want -- but worth
   confirming.

4. Reserved-multicast forwarding table. The IEEE spec lists exactly
   which 01:80:C2:00:00:0X addresses a TPMR relays vs. terminates.
   Only 01:80:C2:00:00:01 (PAUSE) is terminated, as it must be by
   the MAC layer; the rest are relayed. The table is hardcoded.
   Making it per-instance configurable feels like premature
   flexibility, but I can be talked out of it.

5. Statistics. ndo_get_stats64 on the master via dev_get_tstats64
   over pcpu_sw_netstats is what's implemented. Per-slave
   forwarded/dropped counters would be nice but add ABI surface;
   master-only for v1 unless someone has a stronger view.

6. Netlink shape. IFLA_INFO_KIND="tpmr" with an (initially empty)
   IFLA_INFO_DATA nest, leaving room for a policy flag if #4 ends
   up configurable. Flagging it so the shape can be argued before
   it's frozen.

Not in this RFC, planned for v1: selftest under
tools/testing/selftests/net/ (bidirectional forwarding, link-state
aggregation, MTU sync, third-slave rejection, rx_handler conflict
rejection, reserved-multicast pass-through), Documentation/
networking/tpmr.rst, MAINTAINERS entry, and iproute2 support as a
separate series once the kernel ABI is settled. switchdev/DSA
offload and richer ethtool_ops are deliberately follow-ups -- only
worth doing once the base lands and if there's demand.

Thanks for taking a look,
David

[1] https://man.openbsd.org/tpmr.4

David Carlier (1):
  net: tpmr: add Two-Port MAC Relay driver

 drivers/net/Kconfig          |  14 ++
 drivers/net/Makefile         |   1 +
 drivers/net/tpmr.c           | 409 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/if_link.h |   8 +
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/net/tpmr.c

-- 
2.53.0


