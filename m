Return-Path: <netdev+bounces-291672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDV2CmyIFWqGWQcAu9opvQ
	(envelope-from <netdev+bounces-291672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABE05D520F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32306321C265
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F73E5EEF;
	Tue, 26 May 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnu0YN7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05453E3D85;
	Tue, 26 May 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795681; cv=none; b=hbrHIBTBk8kpTMo+lstu8/hZF4fgltqzQwUtgiNVRbXnvK70maVezf4tj7nkH2KIgqlHmNAYRjrc1Lno3fHckcJRGErGMvp99hdylJuhfU9ID5VtcHdEGTp02HD2g1f3VzjVLDqAKJztRy/CmzM39TnU4lByujLzW/oiCeVQ1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795681; c=relaxed/simple;
	bh=gsBMOqckNew79nqSk38co9T/p1xGYyM8joscT6dFzlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dRmw3DqHKaHoVyJAO5Rx9dg0FnpEsUvdI1qlqDnu33FzLH1AIXmyy5JxejoHq/xNZ5vsh+LWqWSLsoWAyTnWOLD/LqvmdUj9jKQDK9Ycigzk2vUdWdjmujWeIUkaXbGeFagZpxJp+X8k1o99NNvFsx4bC02FNkKY+F5j0m7NZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnu0YN7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D91C2BCC6;
	Tue, 26 May 2026 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779795679;
	bh=gsBMOqckNew79nqSk38co9T/p1xGYyM8joscT6dFzlw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Tnu0YN7kBMhWFheei2ClZdPjyMT2Um+ld5JHQFqcHO6eLniyUfCGMSTuG2eWAzLnA
	 mj3fD6KwBTiErJQ1Ayfj34i+jOrFTsbgtJQsGUo2W52nUhGvwe4+XHRGyyZOpjFioG
	 W3L0Ym9UrFmZh2gj33tG3ds4q3kBtYe/7X7Ydn5Ugck4Dkfdyk9ZUWniRkL9x1al2w
	 Obh9U2EZGqPjW+Bwm3ehG8JmA/mXUT+QNCyP/s08YCADfsEaHvE1/ejUJrGFqRDa+w
	 sAUNY/RaXrXnZL4HqrMnLcbNNsJwvi6BOuYP4O2hbKIWudQcLq1llzCPgt7ynzcpwR
	 mw+mXMECFUE9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D3CD5BC8;
	Tue, 26 May 2026 11:41:18 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Date: Tue, 26 May 2026 13:41:13 +0200
Message-Id: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANmGFWoC/3WNsQ7CMAxEf6XyjFFiIAQm/gN1SIOhlmiLkhIFV
 f13okiMDDfcne95gchBOMK5WSBwkijTWAxtGvC9Gx+MciseSJFR+53CkeeiPOOQrGWTc0bfRSR
 NWpuTd85YKONX4LvkCr7CbwNtaXqJ8xQ+9WPSta/wA9E/eNKo0NujK1nnvfKX53uQcrjtGNp1X
 b+8S8XUxwAAAA==
X-Change-ID: 20260430-net-next-mv88e6xxx-cbs-2121169caa68
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779795677; l=1698;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=gsBMOqckNew79nqSk38co9T/p1xGYyM8joscT6dFzlw=;
 b=9Z/Kxlm4nnbXY7ex5AR29/rzFU9jQ7Uq1ABUsumK8TzhsfrgCrnQs7o4f2CB3lkxan6sdTM9q
 baYQHU2hDGTAsFBHcK+evUAh/yeTtPFBmK/jhkh98DIjLL9TmHNY+RP
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291672-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be]
X-Rspamd-Queue-Id: 7ABE05D520F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several of the switch families in this driver have switches with AVB
support. The switches with AVB support have support for Credit based
shaping. This series adds support for the 6352, 6390 and 6393 families.
The difference between the families is:
- total number of queues
- which queues support credit based shaping
- shaping granularity

Eg. setting up 20mbps credit based shaper on a 1GBit link:
tc qdisc add dev p8 parent root handle 100: mqprio \
    num_tc 8 \
    map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
    queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
    hw 0

tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
    sendslope -980000 idleslope 20000 offload 1

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
Changes in v2:
- tx_queues defined for all devices (which could be found). Thanks to Marek Behún.
- Link to v1: https://lore.kernel.org/r/20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be

---
Cedric Jehasse (2):
      net: dsa: mv88e6xxx: use the hw tx queues
      net: dsa: mv88e6xxx: add support for credit based shaper

 drivers/net/dsa/mv88e6xxx/chip.c        | 157 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  22 +++++
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 +++++
 drivers/net/dsa/mv88e6xxx/port.c        |  38 ++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  16 ++++
 net/dsa/tag_dsa.c                       |   3 +-
 6 files changed, 256 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



