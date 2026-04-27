Return-Path: <netdev+bounces-281244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AXjMksP72kq4wAAu9opvQ
	(envelope-from <netdev+bounces-281244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CFB46E506
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB3D63001A57
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40246390998;
	Mon, 27 Apr 2026 07:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656537B413;
	Mon, 27 Apr 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274689; cv=none; b=AVJ1VVaT60F0Y8nBZ+U3t85k116OoQA1vAOj7dRqMBwDnV7K+v0x7oByovc94JEhBFw5vCntO+3ZignITUnp6G4EHl2/bcqK7UD8o2khTlyRhBqvLx/joyjwjastjr5y6B1ezX8DB/Wg7akBHPsm/D6aKuDEp1P/ppWlZRoIgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274689; c=relaxed/simple;
	bh=tQCRguxmbjAScgCKFpr5khzYOVpiWhaEWDJtW6u4gUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUUeMsHG6BGFGxttWOQpeQp+VdU6fbRYGtNJsyufRXZCdA3dmlfDG9h6ke5pVHUfhIUYuC8c/dajKeLZrRQObw6EUG3X1cvCWzImnZ2uolTDMMeu6P5UKagVgwIA2GOr/5f0j8DTuw5A1t+66VoJF0IQ9IVmcoHCgDc72ENz6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgAXLaAPD+9pVwkVAA--.22769S2;
	Mon, 27 Apr 2026 15:24:01 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v7 0/4] net: stmmac: eic7700: fix EIC7700 eth1 RX sampling timing
Date: Mon, 27 Apr 2026 15:23:53 +0800
Message-ID: <20260427072353.1114-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAXLaAPD+9pVwkVAA--.22769S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1kAw4UCr47XrWfJw4kCrg_yoW3tw4xpF
	WUWrn8JFsxJF1xAan7t3W09a4Sqan3GF4jgr1rJrnrXws09Fyqqr1S9F45ZFyDurZ7ZryY
	vF15KF4jka4j9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRifHU3UUUUU==
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 10CFB46E506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-281244-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[checkpatch.pl:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Zhi Li <lizhi2@eswincomputing.com>

v6 -> v7:
  - Address checkpatch.pl --strict warnings for DTS changes:
    - Split DT binding documentation and DTS board description into separate patches
    - Fix DTS style issues reported by checkpatch:
      - Reduce line length where applicable
      - Add required description for rgmii-rxid

  - DTS changes in this series are split into:
    - Patch 3/4: syscon binding update (documentation / reference only)
    - Patch 4/4: board DTS changes (architecture overview only)

    These patches (3/4 and 4/4) are provided to facilitate review of the overall
    Ethernet integration across binding, driver, and device tree, and are not
    intended as final upstream submission in their current form.

    A cleaned-up, upstream-ready DTS series will be submitted separately once
    all dependencies and final hardware integration are completed.

  - Note:
    - Clock-related bindings referenced in earlier revisions are now already merged
      into net-next, so dtbs_check warnings related to clock are no longer present
      and are not relevant to this revision.

  - No functional changes in the stmmac driver or binding semantics in this revision.

  - Link to v6:
    https://lore.kernel.org/lkml/20260423085501.760-1-lizhi2@eswincomputing.com/

v5 -> v6:
  - Update DTS/DTSI descriptions to fix invalid phandle references reported by DTC:
    - Add missing GMAC provider nodes required for proper hardware description:
      - HSP power domain: GMAC nodes moved under this domain to reflect
        hardware power hierarchy.
      - Clock nodes: added to provide clk phandles referenced by GMAC.
      - Reset nodes: added to provide reset phandles referenced by GMAC.
      - Pinctrl nodes: defines pinctrl settings for GMAC signals
        (pinctrl_gpio106, pinctrl_gpio111).
    - Move GMAC nodes under the correct HSP power domain.
    - Ensure DTS builds without dtc errors and all phandle references
      (clk/reset/pinctrl/power-domain) are valid.
    - This update does not change runtime behavior; it only improves DTS
      consistency and resolves issues reported by dtc.

  - Note:
    - The patch 3/3 for DTS changes in this series provide an overview of the GMAC
      integration and its dependencies, as discussed previously:
      https://lore.kernel.org/lkml/64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch/

    - It is **not intended for upstream inclusion** in its current form,
      and is provided solely for architecture overview and integration
      context.

    - A fully cleaned and upstream-ready DTS series will be submitted
      separately once all related components (pinctrl, clock, power-domain,
      etc.) are finalized.

  - dtbs_check has been run on top of net-next for reference purposes.
    Remaining warnings are expected due to missing EIC7700 clock bindings[1]
    in net-next and do not reflect issues in the DTS design itself.

  - One remaining warning:
    - eswin,eic7700-clock

  - The clock binding has already been applied to upstream and is present
    in mainline, but not yet available in net-next.

  - The syscon binding is extended in this series to include the
    eswin,eic7700-syscfg compatible.

  - Any further refinement of the syscfg binding will be handled in
    separate patches if needed.

  - Dependencies:
    - [1]EIC7700 clock binding:
      https://lore.kernel.org/lkml/20260303080637.2100-1-dongxuyang@eswincomputing.com/
      (already applied to upstream)

  - Link to v5:
    https://lore.kernel.org/lkml/20260324073017.376-1-lizhi2@eswincomputing.com/

v4 -> v5:
  - eswin,eic7700-eth.yaml:
    - Add Acked-by from Conor Dooley
    - No functional changes

  - Update dwmac-eic7700.c:
    - Disable clocks on the error path to fix a clock leak in
      eic7700_dwmac_init() when regmap_set_bits() fails
      (reported by Simon Horman <horms@kernel.org>)

  - Link to v4:
    https://lore.kernel.org/lkml/20260313075234.1567-1-lizhi2@eswincomputing.com/

v3 -> v4:
  - Update eswin,eic7700-eth.yaml:
    - Improve commit message in dt-bindings patch to clarify the
      hardware difference of the eth1 MAC and why a new compatible
      string is required.
    - Move the newly added eswin,hsp-sp-csr item to the end of the list
      to avoid inserting entries in the middle of the binding schema.
    - Simplify the compatible schema by replacing the previous oneOf
      construct with an enum.

  - Update dwmac-eic7700.c:
    - Fix build issues.
    - Adjust code to match the updated binding definition.

  - Update DTS/DTSI descriptions:
    - Move SoC-level descriptions to the .dtsi file.
    - Keep board-specific configuration in the .dts file.

  - Link to v3:
    https://lore.kernel.org/lkml/20260303061525.846-1-lizhi2@eswincomputing.com/

v2 -> v3:
  - Update eswin,eic7700-eth.yaml:
    - Extend rx-internal-delay-ps and tx-internal-delay-ps range
      from 0-2400 to 0-2540 to match the full 7-bit hardware delay
      field (127 * 20 ps).
    - Add "multipleOf: 20" constraint to reflect the 20 ps hardware
      step size.
    - Make rx-internal-delay-ps and tx-internal-delay-ps optional.
      A well-designed board should not require internal delay tuning.
    - Remove rx-internal-delay-ps and tx-internal-delay-ps from the
      example to avoid encouraging blind copy into board DTs.

  - Update dwmac-eic7700.c:
    - Treat rx-internal-delay-ps and tx-internal-delay-ps as optional
      DT properties.
    - Apply delay configuration only when properties are present.
    - Keep TX/RX delay registers cleared by default to ensure a
      deterministic state when no delay is specified.

  - Describe Ethernet configuration for the HiFive Premier P550 board:
    - Add GMAC controller nodes for the HiFive Premier P550 board
      to describe the on-board Ethernet configuration.

      The Ethernet controller depends on clock, reset, pinctrl
      and HSP subsystem providers which are currently under
      upstream review. These dependent nodes will be submitted
      separately once the corresponding drivers are merged.

      Due to these missing dependencies, dt-binding-check may
      report warnings or failures for this series.

  - No functional changes to RX clock inversion logic.

  - Link to v2:
    https://lore.kernel.org/lkml/20260209094628.886-1-lizhi2@eswincomputing.com/

  - This series is based on the EIC7700 clock support series:
    https://lore.kernel.org/all/20260210095008.726-1-dongxuyang@eswincomputing.com/
    The clock series is currently under review.

v1 -> v2:
  - Update eswin,eic7700-eth.yaml:
    - Drop the vendor-specific properties eswin,rx-clk-invert and
      eswin,tx-clk-invert.
    - Introduce a distinct compatible string
      "eswin,eic7700-qos-eth-clk-inversion" to describe MAC instances that
      require internal RGMII clock inversion.
      This models the SoC-specific hardware difference directly via the
      compatible string and avoids per-board configuration properties.
    - Change rx-internal-delay-ps and tx-internal-delay-ps from enum to
      minimum/maximum to reflect the actual delay range (0-2400 ps)
    - Add reference to High-Speed Subsystem documentation in eswin,hsp-sp-csr
      description. The HSP CSR block is described in Chapter 10
      ("High-Speed Interface") of the EIC7700X SoC Technical Reference Manual,
      Part 4 (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf):
      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases

  - Update dwmac-eic7700.c:
    - Remove handling of eswin,rx-clk-invert and eswin,tx-clk-invert
      properties.
    - Select RX clock inversion based on the new
      "eswin,eic7700-qos-eth-clk-inversion" compatible string, using
      match data to apply the required configuration for affected MAC
      instances (eth1).

  - Link to v1:
    https://lore.kernel.org/lkml/20260109080601.1262-1-lizhi2@eswincomputing.com/

Zhi Li (4):
  dt-bindings: ethernet: eswin: add clock sampling control
  net: stmmac: eic7700: enable clocks before syscon access and correct
    RX sampling timing
  dt-bindings: mfd: syscon: add ESWIN EIC7700 compatible
  riscv: dts: eswin: eic7700-hifive-premier-p550: enable Ethernet
    controller

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/eswin,eic7700-eth.yaml       |  69 ++++-
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 239 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 105 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 183 ++++++++++----
 5 files changed, 541 insertions(+), 57 deletions(-)

-- 
2.25.1


