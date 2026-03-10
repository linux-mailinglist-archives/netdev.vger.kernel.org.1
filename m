Return-Path: <netdev+bounces-265973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE/GNYDur2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:12:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBB2492D5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F127300B448
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB3449ECA;
	Tue, 10 Mar 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siw4ADmA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC273C3BF4;
	Tue, 10 Mar 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137337; cv=none; b=pL0uj55e0mpzezmw3katrtYluzKGQ7GGAKaxDthffTTh79NMCPhyJkDmroRc+8vY4agDwzZl04qLGzVk8d6LQdUy+TnPmrsSEboKlk/6QfAeemHSy3UpXdXKYHDZj6v47MedObOuJRC3C7dyPYRk8GoH0fQn0sJVfFRStJZ3dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137337; c=relaxed/simple;
	bh=obEfT3AD1mMFpeTHxVpWRtrOFdIR7Q7q521v30zZyQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqaCwSf+9xOUCMifSe+Ly381Ncu0nZ05zTm/yoKeKusnkF2oXkJMYOAF7Wnp3TPRurzE75j9G4BGSbqTSWUf2VnomQJgCBqSAfkk5NQLMB6AQh0Ggeq46nk3lzIGN5kzdM2OTET3HpXFPP3CoozUOExnbSSDXkq65TvXMrC0AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siw4ADmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FB8C19423;
	Tue, 10 Mar 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137337;
	bh=obEfT3AD1mMFpeTHxVpWRtrOFdIR7Q7q521v30zZyQY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=siw4ADmAtj4YQyj1ZCQf+wxNc4ggzMirID7hpANDEd5lfY9wiHgUdeI9y/eLeu9Aa
	 IBVucpVrARfQ9IB3zMiY/HsB9ps6GS2LKZLKxDwq2rLNaCwXonw4/GKX2B3hAXwbn+
	 z2fdgWxELtnTWvsoDsTfmEQYh5XG+e6YTmC4O0LitqOfXR2q9X259de4ge57kVeqZE
	 itlPswXSczEd2im5u/CVrq7H4Pr0hM97FHwTFd9VBT3jP5nPVRY0JARtWrnvLDrYC9
	 8iP7K0+ntUn7Ox/0kHgw0cqFSGNnjfzv1EnHXmuiW3Wj4k0NKAT8BYsJL1kf+Ykf8U
	 zzGVEUnsu1exg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE38FCC9A9;
	Tue, 10 Mar 2026 10:08:56 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v7 0/2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
Date: Tue, 10 Mar 2026 11:07:24 +0100
Message-Id: <20260310-net-next-mv88e6xxx-tcam-v7-0-7d9db9012b28@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFztr2kC/4XQzWrDMAwA4FcpPs/DUvzXnfYeo4fEllfDkpYkC
 y4l7z4tMJYR0h18EJI+S7qLgfpMg3g53EVPUx7ypePAPR1EONfdO8kcORao0CqESnY08iujbCf
 vyZZS5BjqViZrGgKrlE+N4O5rTymXRX4TP03ixJlzHsZLf1u+nGDJ/6tPIEEqA2QMEtYpvH58t
 pkrnxta0AnXkNuHkKHodUgaVay13UDVCkK9D1XfUADvvYsOEm4gvYbMPqQZAnCJb0caottA5he
 q1IMbGamkTUfAo/UO3XY1u4YeTGQZqjC41NSBtfgHmuf5C1GA9A82AgAA
X-Change-ID: 20260213-net-next-mv88e6xxx-tcam-f65be16008fb
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773137335; l=3616;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=obEfT3AD1mMFpeTHxVpWRtrOFdIR7Q7q521v30zZyQY=;
 b=MqDM+t9Yz8Qpgn6HpdHWQMCqDj4EypX8vRyovyXaOzQcBw65VBE6TrYteTAq2I2vT2WphEwr+
 gQaznjfKvIMAs5DMZ9mJFL11H0LeBeAAGD4oyfaTzqHqV2f0Axh1tcB
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Queue-Id: D4CBB2492D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265973-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[luminex.be:replyto,luminex.be:email,luminex.be:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series adds partial Ternary Content Addressable Memory (TCAM) for
the mv88e6390 and mv88e6393 family of switches. TCAM entries allow the
switch to match the first 48 or 96 bytes of a frame and take actions on
matched frames.

This patch introduces a subset of the available TCAM functionality.
Matching on ip addresses/protocol and trapping to the cpu.

Eg. to trap traffic with destination ip 224.0.1.129 to the cpu:

tc qdisc add dev p1 clsact
tc filter add dev p1 ingress protocol ip flower skip_sw \
    dst_ip 224.0.1.129 action trap

Review of the mv88e6xxx changes have brought to light something in
cls_flower:
When adding a classifier with an ipv4 address both
FLOW_DISSECTOR_KEY_IPV4_ADDRS and FLOW_DISSECTOR_KEY_IPV6_ADDRS bits are
set in dissector->used_keys.
A change was made to address this.

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
Changes in v7:
- clear register field before setting it
- fix name inconsistency of mv88e6xx_flower_parse_key
- use defines for spv and spv_mask register fields
- Link to v6: https://lore.kernel.org/r/20260305-net-next-mv88e6xxx-tcam-v6-0-32c7fbac129d@luminex.be

Changes in v6:
- add num_tcam_entries in chip info and check this is not exceeded when
  adding an entry
- fix use after free in error path of tcam entry deletion
- fix copy/paste mistake in comment
- Link to v5: https://lore.kernel.org/r/20260303-net-next-mv88e6xxx-tcam-v5-0-6f9129687276@luminex.be

Changes in v5:
- changes to cls_flower to only set the correct
  FLOW_DISSECTOR_KEY_IPV*_ADDRS bits
- Link to v4: https://lore.kernel.org/r/20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be

Changes in v4:
- return -ENOMEM on allocation failure
- fix double mv88e6xxx_reg_unlock
- return -EOPNOTSUPP for unsupported addr_type
- improve error handling in mv88e6xxx_tcam_entry_del
- Link to v3: https://lore.kernel.org/r/20260224-net-next-mv88e6xxx-tcam-v3-1-dc18887d71f2@luminex.be

Changes in v3:
- move locking to top level functions
- use defines for match field offsets
- use correct comment style
- remove warning used for debugging
- rename rc variables to err
- limit line length to 80 characters
- Link to v2: https://lore.kernel.org/r/20260217-net-next-mv88e6xxx-tcam-v2-1-d84cf420da46@luminex.be

Changes in RFC-v2:
- moved tcam_addr to chip info struct and remove tcam_support field
- added 6393-specific tcam ops that write the TCAM extension register
- rename the defines for TCAM registers to be consistent
- reverse christmas tree variable declarations
- Link to v1: https://lore.kernel.org/r/20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be

---
Cedric Jehasse (2):
      net/sched: cls_flower: remove unions from fl_flow_key
      net: dsa: mv88e6xxx: Add partial support for TCAM entries

 drivers/net/dsa/mv88e6xxx/Makefile   |   2 +
 drivers/net/dsa/mv88e6xxx/chip.c     |  34 ++++
 drivers/net/dsa/mv88e6xxx/chip.h     |  52 ++++++
 drivers/net/dsa/mv88e6xxx/port.c     |  28 ++-
 drivers/net/dsa/mv88e6xxx/port.h     |   7 +-
 drivers/net/dsa/mv88e6xxx/tcam.c     | 338 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/tcam.h     |  41 +++++
 drivers/net/dsa/mv88e6xxx/tcflower.c | 157 ++++++++++++++++
 drivers/net/dsa/mv88e6xxx/tcflower.h |  13 ++
 net/sched/cls_flower.c               |  12 +-
 10 files changed, 674 insertions(+), 10 deletions(-)
---
base-commit: cd51b40495c09b92beea6893663b3d0ed7605e81
change-id: 20260213-net-next-mv88e6xxx-tcam-f65be16008fb

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



