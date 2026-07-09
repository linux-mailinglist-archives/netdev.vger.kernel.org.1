Return-Path: <netdev+bounces-306366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ORPtE88DUGqXrwIAu9opvQ
	(envelope-from <netdev+bounces-306366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D188735552
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=HtjF1bZF;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=cNp2knMQ;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306366-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306366-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 524CA301C883
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A736C9E5;
	Thu,  9 Jul 2026 20:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-1.smtp-out.amazonses.com (a9-1.smtp-out.amazonses.com [54.240.9.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713B449990;
	Thu,  9 Jul 2026 20:25:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628748; cv=none; b=Ewe2TmIIeh+4Qmku5re4wopnuZDyOX7pmPeccvazaECuR1PtXhHPw1w7wDVbReLFlEO+HLqAfY4or4DkLPn+wV3sHU3W8Cs3+7g47dKmfEATVDQ4CGlhlmaIMafsCjxXeAQENsHM1idMQ7ee2w/m+qF9cvPPa2kcrRk431vM7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628748; c=relaxed/simple;
	bh=lL9n7hll/due2YYWr7PTYqin6eS9yPRhzUSTgauLamw=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=JWhGEnwlrwYCwao7q5JYjnQYz8aCeGff/SjkReYbQQu55YD2a02dzEMm6jsFKJaE5PR12nIO/yFeRWCV+dAaMIPbv/Awrb6E0zf7y9KMhFnhjehZ30qclGDNjZR6WqZq8FhCMaGvRdDWkVGFba7zcnc4bcfc4Qzp6r/PyWafwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=HtjF1bZF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=cNp2knMQ; arc=none smtp.client-ip=54.240.9.1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783628745;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=lL9n7hll/due2YYWr7PTYqin6eS9yPRhzUSTgauLamw=;
	b=HtjF1bZF6xN1MJiPdLVenvDdNl4we9+XJZ1VofQlR/VNt4JZCB8FY9R4WDRlWs0p
	MjVbnas+EklxMJh5R6n+VHcDT5NhO6F7kf3hJuyuFIW2003QYyTuT3hYTeU8qcnktqJ
	EKgFqoqQf40xt/j3w7mTNVe3R9y9NyILlEG5kgbM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783628745;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=lL9n7hll/due2YYWr7PTYqin6eS9yPRhzUSTgauLamw=;
	b=cNp2knMQbDRu4xyESya2GEyumWN/iFB4tKSqWcwzIllcetqywM2RacWe1GFlAteB
	SCoCrYndcsdnyJuppLfqFztnqrDjOy3jiZiQPjQQA8OxMHTmqzp/qhzn7WQTEsOkp1l
	wVUcFNFEKK89Mc/YdIVTanxcTGud2E0GfXo5DHYw=
X-Mailer: git-send-email 2.55.0
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk
Cc: luizluca@gmail.com, maxime.chevallier@bootlin.com, namiltd@yahoo.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	contact@c127.dev
Subject: [PATCH net-next v5 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
Message-ID: <0100019f488ec83f-cd82d418-999a-40de-b58b-135b4b2aee51-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Jul 2026 20:25:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.09-54.240.9.1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:namiltd@yahoo.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306366-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,yahoo.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazonses.com:dkim,email.amazonses.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D188735552

The RTL8367S is a 5+2 port switch from the same family as the
RTL8365MB-VC already supported by this driver. Its chip info table
entry declares SGMII and HSGMII on external interface 1, but the
driver so far only implements RGMII, leaving boards that wire the
switch to the CPU over the SerDes without a working CPU port.

This series implements both modes. The configuration sequence and the
SerDes tuning parameters are derived from the GPL-licensed Realtek
rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
drop, and cross-checked against the real register sequence captured at
runtime by chainloading a custom U-Boot ahead of the stock firmware
and logging the live SerDes accesses on hardware.

The vendor driver brings=
 up the SerDes by loading firmware into the
switch's embedded DW8051 =
microcontroller. Analysis of that firmware
(by Luiz Angelo Daros de Luca) =
showed it only performs a SerDes
data-path reset right after the SerDes =
reset is deasserted, and then
runs a link-polling loop that writes the =
external interface force
registers -- duplicating, and racing with, the =
link management phylink
already performs. This series therefore keeps the =
DW8051 disabled and
performs the one necessary action (the data-path reset =
via the SerDes
BMCR register) directly in the driver, avoiding both the =
race and a
dependency on a redistributable firmware blob.

The SerDes is modelled as a phylink PCS: mac_select_pcs() hands the
SerDes interfaces to a phylink_pcs whose pcs_config()/pcs_link_up()
ops own the SerDes register sequence, keeping it out of the MAC
operations. In-band autonegotiation is not implemented; the link is
forced (fixed-link or conventional PHY), as for RGMII, and the PCS
reports this to phylink through pcs_inband_caps().

Patch 1 adds the SerDes indirect access helpers, the PCS and SGMII
(1 Gbps) support. Patch 2 extends the PCS to HSGMII (2.5 Gbps), which
phylink represents as 2500base-x.

Tested on a Mercusys MR80X v2.20 =
(RTL8367S wired to the SoC over the
SerDes), in both SGMII and HSGMII modes=
 with a fixed-link device tree
description: link bring-up verified across =
cold boots, warm reboots,
module reloads and link down/up cycles, with =
sustained traffic and no
CRC/symbol errors. The SerDes pause enables were =
verified by driving
congestion toward a 100M user port and observing pause =
frame emission
on the CPU port (dot3OutPauseFrames) toggle with the =
SDS_MISC
TXFC/RXFC bits. The port 6 rate limiters were verified to be live =
by
lowering them to 100 Mbps at runtime and observing iperf3 throughput
across the CPU port clamp accordingly in each direction, recovering
once the maximum was restored. The HSGMII link is confirmed running
at 2.5G at the register level (SoC uniphy mode and gmac clocks);
per-direction throughput could not be pushed past ~1 Gbps on this
board because the SoC side is driven by the IPQ5018 SSDK and the
user-facing PHY is 1G, so full 2.5G line-rate throughput remains
unverified on my hardware. Independently, >1 Gbps aggregate HSGMII
throughput (~2 Gbps with multiple clients) has been observed on an
RTL8367S-based Mercusys MR85X running an OpenWrt backport of this
series with the rate limiters raised (see patch 2).

The RTL8367SB also declares SGMII and HSGMII in its chip info entry
and therefore gains both modes as well. The vendor driver drives the
two chips through the same code path, keyed only on the chip option
register (both report chip id 0x6367), so this is expected to work
there too, but I have no RTL8367SB hardware to confirm it.

Signed-off-by: Johan Alvarado <contact@c127.dev>
---
v5:
  - Raise the port 6 ingress and egress rate limiters to their maximum
    at setup time, as the vendor switch init does. The chip resets them
    to 0x1FFFF (~1.048 Gbps in units of 8 Kbps), which caps the
    aggregate HSGMII throughput at roughly 1 Gbps; the cap was
    confirmed on an RTL8367S-based Mercusys MR85X, where raising the
    limiters took multi-client throughput across the HSGMII CPU port
    from ~1.02 Gbps combined to ~2 Gbps (link in patch 2). The related
    HSGMII scheduler line rate (LINE_RATE_HSG_H) is already set to its
    maximum by the common init jam table. Pointed out by Mieczyslaw
    Nalewaj.
  - Drop the PHYLINK_PCS_NEG_INBAND_ENABLED check from =
pcs_config().
    With pcs_inband_caps() returning LINK_INBAND_DISABLE, =
phylink can
    never select an in-band-enabled negotiation mode for this =
PCS, so
    the check was unreachable. Pointed out by Maxime Chevallier.
  - Document the SerDes SDS_MISC pause bits as the functional pause
    enables of the SerDes external interface, after testing flow
    control on hardware: pause frames are only emitted with the SerDes
    TXFC bit set, while the MAC force pause bits alone have no effect
    on this port. Comment-only change, prompted by a question from
    Maxime Chevallier.
v4: https://lore.kernel.org/netdev/20260702204648.=
276112-1-contact@c127.dev/
  - Drop the chip model name from the driver's =
NOTE comment; which
    interfaces a given chip exposes is described by its=
 chip_info entry,
    not the file header. Pointed out by Luiz Angelo Daros=
 de Luca.
  - Build the SerDes BMCR data-path-reset values from the =
standard
    BMCR_ANENABLE | BMCR_ISOLATE bits instead of a bare magic =
number, so
    the meaning is in the code rather than only in a comment. =
Pointed
    out by Luiz Angelo Daros de Luca.
  - Use a temporary for the =
DIGITAL_INTERFACE_SELECT value instead of
    wrapping the expression =
across the regmap_update_bits() arguments.
    Pointed out by Luiz Angelo =
Daros de Luca.
  - Reject the untested SerDes tuning variant. The vendor =
driver keeps
    two sets of SerDes tuning parameters and selects between =
them based
    on the chip option register (0x13C1); the tables in this =
series are
    the variant for a non-zero option, which is what the =
RTL8367S parts
    seen so far report. The option is probed once at setup =
and the
    SerDes interface modes are only advertised to phylink when the
    tuning parameters match, so an unsupported variant fails at phylink
    validation time instead of when configuring the link. Thanks to
    Luiz Angelo Daros de Luca for pointing out the conditional.
  - Express the external interface line rate bypass bit through a
    parametric macro keyed on the port number (with port 5 as the base),
    instead of an open-coded BIT(interface id) that only matched by
    coincidence; other RTL8367 families index this register differently.
    Suggested by Luiz Angelo Daros de Luca.
  - Drop the arbitrary =
usleep_range() after each SerDes indirect access.
    SerDes writes are now=
 fire-and-forget and reads poll the self-clearing
    BUSY bit with =
regmap_read_poll_timeout(), matching the vendor driver,
    which never sleeps. On the MR80X the BUSY bit is never even observed
    set: the access completes within the register transaction. Pointed out
    by Luiz Angelo Daros de Luca; poll approach suggested by Mieczyslaw
    Nalewaj.
  - Drop the always-zero SerDes index argument from the SerDes=
 indirect
    access helpers, along with the INDACS command index field =
whose
    width was questioned during review; this chip has a single SerDes
    block reachable through this window, so the index served no purpose.
    Raised by Luiz Angelo Daros de Luca.
  - Stop hardcoding external =
interface 1 with an early -EOPNOTSUPP in
    the SerDes configuration path.=
 The SerDes interface modes are now
    advertised in phylink_get_caps() =
from the chip_info
    supported_interfaces, and mac_select_pcs() returns =
the PCS only for
    those modes. Pointed out by Luiz Angelo Daros de Luca.
  - Keep the new register definitions as raw hex masks, matching the
    prevailing style of the file. A file-wide GENMASK/BIT conversion,
    raised by Luiz Angelo Daros de Luca during review, is left for a
    separate cleanup patch so this series stays focused on the feature.
  - Convert the SerDes path to a phylink_pcs, as suggested by Maxime
    Chevallier. The SGMII/HSGMII SerDes handling now lives in
    pcs_config()/pcs_get_state()/pcs_link_up() selected via
    mac_select_pcs(), instead of being driven from the MAC
    mac_config()/mac_link_up()/mac_link_down() operations. This
    separates the MAC and SerDes layers and makes future in-band
    autonegotiation an additive change. No functional change intended
    for the forced-link path; retested on the MR80X v2.20. In-band
    autonegotiation remains unimplemented and is left for a follow-up,
    once hardware is available to validate it.
  - Implement =
pcs_inband_caps(), returning LINK_INBAND_DISABLE so that
    phylink knows this PCS cannot do in-band autonegotiation and never
    selects an in-band-enabled negotiation mode for it. pcs_config()
    rejects PHYLINK_PCS_NEG_INBAND_ENABLED with -EOPNOTSUPP instead of
    the previous warn-and-force.
  - Program the SerDes pause controls in =
SDS_MISC from the resolved
    pause modes when forcing the MAC external =
interface, as the vendor
    driver does, instead of leaving whatever state=
 the boot firmware
    left there. Done in mac_link_up() because =
pcs_link_up() carries no
    pause information.
  - Set the PCS poll flag: =
the SerDes has no link interrupt wired up,
    so phylink must poll =
pcs_get_state() when it tracks the link
    through the PCS (in-band mode =
with autonegotiation disabled).
  - Report link down from pcs_get_state() =
if reading back the forced
    speed/duplex fails, rather than reporting =
link up with a stale
    state.
  - Reword the misleading "disable in-band =
aneg" comment.
v3: https://lore.kernel.org/netdev/20260613232136.=
24246-1-contact@c127.dev/
  - Drop the DW8051 firmware loading entirely. =
Analysis of the vendor
    firmware showed it only duplicates the link =
management phylink
    already does; the one needed action (SerDes =
data-path reset via
    the BMCR register) is now performed directly in the=
 driver, with
    the DW8051 kept disabled. This removes the dependency on =
the
    rtl8367s-sgmii.bin firmware blob, which could not be redistributed
    via linux-firmware (the GPL vendor source ships it as a byte array
    without the corresponding microcode source). Thanks to Luiz Angelo
    Daros de Luca for the firmware analysis.
v2: https://lore.kernel.=
org/netdev/0100019eb0b1822e-ffc5626c-1b9f-4c8a-8a1a-759a9e665f4f-000000@ema=
il.amazonses.com/
  - No code changes; resend because the SMTP provider =
used for v1
    corrupted the mails and patch 1/2 never reached the list.
v1: https://lore.kernel.org/netdev/aebccaad-eca3-4ea4-99dd-ae7edbc8981b@smt=
p-relay.sendinblue.com/

Johan Alvarado (2):
  net: dsa: realtek: =
rtl8365mb: add SGMII support for RTL8367S
  net: dsa: realtek: rtl8365mb: =
add HSGMII support for RTL8367S

 drivers/net/dsa/realtek/rtl8365mb_main.c =
| 619 ++++++++++++++++++++++++++++++-
 1 file changed, 614 insertions(+), 5=
 deletions(-)


base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
--=20
2.55.0


