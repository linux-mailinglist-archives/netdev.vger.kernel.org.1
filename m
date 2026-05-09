Return-Path: <netdev+bounces-286118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK8eKgj1/mlv0AAAu9opvQ
	(envelope-from <netdev+bounces-286118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB474FED29
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76A4E300B98C
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9B390CB2;
	Sat,  9 May 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOQtexjy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FC38E129;
	Sat,  9 May 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316547; cv=none; b=oKPupwIcJKYfblUOzOgk34MnmXRalLKJXZeUIQJtVid244z/pcub1TZWrVzWQ4sOD5I+M3kKEdHU/WpJ4PPLM5yxCFZoGyos1PpV2Ce7QPmq7e1vT/XbTt1CRbzd7HEocInZo9F9+dh+JILll5GjqEvtC/ZGeIdYIMbcUqTpQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316547; c=relaxed/simple;
	bh=KmF/eESqYKfpvP59g3razwO7Poct99/F3H336ZNABs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X19arJ5G28CRfivemebdGliJ1Ze8wKGGXmOaMB0XtCcaIa/gkOZAYymaNR+TiQj6QT+jyn7inHIakkWFsWrJLVkfpn+ptqYQFua8CNOuwl05VgvlV7e6u/o0GXaj9PNO5yxDXDkVoTXrRpGpwS6Ban9+qtya9t6VkJIv6rmMuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOQtexjy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778316546; x=1809852546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KmF/eESqYKfpvP59g3razwO7Poct99/F3H336ZNABs8=;
  b=kOQtexjy9oscuX8Wz1fZCVrNaT01BUH43e5AMkj8TUuZMo6tVKQonq/2
   dTiq1E9FWxCdbl7jKLZ6tcBZKaRXWhbVwBSiQdW3bPfA5jgw6xW6pt+0r
   4jKFU6AS2WXOlD5fNf7VvOKVfscDX27XaUsC03MiOJ01pAjBO2AWm7j9R
   knVTWwMrfg2oArPzzfMZHMKFFH6MT+aPg/sGEcEjl4ewx7bWlxVdIgHjZ
   yqCjmmD9lC/fsRUbJayhlOJiTvq63VT+/xu+REsRA+cyfqDh7foDOHsw7
   79M97VcTmWmGJvr0jU1PzZkHZwJeq+poHt1EzNeeAFkyM2YzavnVAUkzp
   g==;
X-CSE-ConnectionGUID: JhEiua0fQdaebdqmlyCwew==
X-CSE-MsgGUID: gEjmnGp7RXyS4/2PyR/lnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748725"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748725"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: EIYZNrQdSlmM594ZbgzZJQ==
X-CSE-MsgGUID: Kt5/sM4iRD2VFLBTCA6A/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237088147"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 01:49:02 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	lorenzo@kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling for veth
Date: Sat,  9 May 2026 10:48:54 +0200
Message-Id: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEB474FED29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286118-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi,

this series is an attempt to make skb-backed XDP handling in veth use
the generic skb XDP machinery instead of converting skb-backed packets
into xdp_frames for XDP_TX and XDP_REDIRECT. This was brought up by
Jakub during review of previous work, which was focused on addressing
splats from AF_XDP selftests shrinking multi-buffer packet:

  https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/

veth currently has two different XDP input paths:
  - xdp_frame input, coming through ndo_xdp_xmit(), for example from
    devmap redirects; and
  - skb input, coming through ndo_start_xmit(), for example from the
    regular networking stack, pktgen, or other skb producers.

The xdp_frame path is naturally frame-based and this series keeps it on
the existing veth xdp_frame handling path. The skb path, however, is
still fundamentally skb-backed, but today veth converts it into an
xdp_frame for XDP_TX/XDP_REDIRECT. That conversion is awkward and has
been pointed out as undesirable before, because veth has to pin skb data,
construct an xdp_frame view of it, and then restore/massage XDP memory
metadata around that conversion.

This series takes a different approach: skb-backed veth XDP now reuses
the generic skb XDP execution path. veth provides its own xdp_buff,
xdp_rxq_info and page_pool to the generic XDP helper, so the generic code
can still perform the required skb COW using veth's page_pool when the
skb head/frags cannot be used directly. XDP_TX then uses generic_xdp_tx()
and XDP_REDIRECT uses xdp_do_generic_redirect(), while the xdp_frame
input path keeps using the existing veth xdp_frame TX/redirect handling.

The problem this series tries to address more generally is that
skb-backed generic XDP can end up with memory whose provenance is not
described correctly by a single queue-level MEM_TYPE_PAGE_SHARED value.
When skb is COWed the underlying memory is page_pool backed but current
logic does not respect it.

For that reason the series introduces MEM_TYPE_PAGE_POOL_OR_SHARED. This
type is not bound to a single registered page_pool allocator. Instead,
the return path inspects the individual netmem and dispatches either to
the page_pool return path or to page_frag_free(). This lets generic
skb-backed XDP handle mixed page_pool/page-shared memory without
mutating rxq->mem.type per packet.

The veth part also removes the old rq->xdp_mem juggling. For incoming
xdp_frames, veth now uses a local rxq view whose mem.type is taken from
frame->mem_type. This preserves the frame's original memory type for
XDP_TX/XDP_REDIRECT without overwriting the persistent rq->xdp_rxq memory
model used by skb-backed generic XDP.

One visible datapath change is that skb-backed veth XDP_TX no longer
uses veth's xdp_frame bulk queue. It now follows the generic skb XDP_TX
path. The xdp_frame-originated path is unchanged and still uses the
existing veth bulk path. The old skb-backed path had batching, but it
also paid the cost of converting skb-backed packets into xdp_frames. The
new path removes that conversion and keeps skb-backed packets on the
generic skb XDP path. From my local tests that consisted of
pktgen + xdp_bench I did not notice any major performance regressions,
however Lorenzo and Jesper might disagree here, hence the RFC status. I
am fed up of internal wars with Sashiko so I would be pleased to get
some human feedback.

In particular, let's discuss:

  - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
    skb-backed generic XDP memory that may be page_pool-backed after COW
    or ordinary page-shared memory otherwise;

  - whether passing caller-provided xdp_buff/rxq/page_pool context into
    the generic skb XDP helper is the right API shape;

  - whether letting veth provide its own page_pool to generic XDP is
    acceptable for avoiding the old skb->xdp_frame conversion; could
    veth just piggy-back on system's page_pool? even though it could,
    we still need xdp_buff being passed (metadata) and other refactors
    that allow veth to bump stats and do the redirect flush;

  - whether skb-backed veth XDP_TX using generic_xdp_tx(), while keeping
    xdp_frame-originated traffic on the existing veth bulk path, is an
    acceptable split;

  - the INDIRECT_CALL for taking the COW path; I wanted to preserve
    existing behavior, but is it really needed or maybe it would be
    possible to come up with conditions that would cover both generic
    XDP path and veth?

FWIW I do like the end result on veth side. If I missed CCing someone,
mea culpa.

Thanks,
Maciej

Maciej Fijalkowski (4):
  xdp: add mixed page_pool/page_shared memory type
  xdp: return status from generic_xdp_tx()
  xdp: split generic XDP skb handling
  veth: use generic skb XDP handling

 drivers/net/veth.c        | 179 ++++++++------------------------------
 include/linux/netdevice.h |  33 ++++++-
 include/net/xdp.h         |   1 +
 kernel/bpf/devmap.c       |   2 +-
 net/core/dev.c            | 124 ++++++++++++++++++++------
 net/core/filter.c         |   2 +-
 net/core/xdp.c            |  54 ++++++++++--
 7 files changed, 216 insertions(+), 179 deletions(-)

-- 
2.43.0


