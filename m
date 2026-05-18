Return-Path: <netdev+bounces-288814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAuZDnh3Cmpe1wQAu9opvQ
	(envelope-from <netdev+bounces-288814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA46C564FFB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEB9A30078B1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFC33262F;
	Mon, 18 May 2026 02:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96630F531;
	Mon, 18 May 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070833; cv=none; b=FHLJq24Rj9QSYUUwvCCgvlunvLRZqORYtUAMttYrpW8L2fOuK2CJh5qEkLUYgGC+9qx3eCMcZptlpHI4nSO54H3GNGqMUAdoHG1d93oR6yYw/SmI4rgcddmIXshzbyNzoxTsTEKAK9URf6sgPQyaUu/Bjk4m7rezupmkQ+9YaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070833; c=relaxed/simple;
	bh=wNYxcHVaC0JeT2LN2oAb5f3R+9+JjdEwKIBlDCvZ4eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5YHrMjONRkkHqGUGHhHWXfTSm3RchtebNW+S/vyR9cphNjcpbuoUF0v5DCaZGPU58r2QKRhWywqmFBPTR+LGb03ZnbdfIwLFJv3fNX5ZzYNXLSAXv4L26uVscCgeSz+gP14OBRt1k+dqrWhN8TUHejoQaTq+p+BDDG5TU72t20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgBHXaApdwpqD0oaAA--.47720S2;
	Mon, 18 May 2026 10:19:23 +0800 (CST)
From: lizhi2@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net v2 0/5] net: stmmac: eic7700: fix delay calculation and initialization ordering
Date: Mon, 18 May 2026 10:19:19 +0800
Message-ID: <20260518021919.404-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBHXaApdwpqD0oaAA--.47720S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5Xr1fJF45Xr1kKryfZwb_yoW8AFW8p3
	93GFWrtr1kJryxJws7JF1vvFWrtan3CF1Y934rG3s7X3s0gas0qw18K3WFgFyUCr4xZF1j
	yF4UXa98Cas0krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi7KItUUUUU==
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: BA46C564FFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288814-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Zhi Li <lizhi2@eswincomputing.com>

v1 -> v2:
  - Update eswin,eic7700-eth.yaml:
    - Limit the binding changes to adding optional TXD and RXD delay register
      offsets in eswin,hsp-sp-csr.
    - Restore the original enum-based definitions for rx-internal-delay-ps
      and tx-internal-delay-ps.
    - Keep rx-internal-delay-ps and tx-internal-delay-ps as required
      properties.
    - Restore the original example content, with only the additional optional
      TXD and RXD delay register offsets.
    - Restore Acked-by from Conor Dooley for the binding change, which was
      temporarily omitted in v1 during series restructuring and has been
      reinstated now that the change is stable and properly isolated.

  - Update dwmac-eic7700.c:
    - Split driver changes into smaller patches based on review feedback to
      improve reviewability and bisectability.
    - Keep the existing requirement that rx-internal-delay-ps and
      tx-internal-delay-ps must be present in the device tree.
    - Treat TXD/RXD delay register offsets as optional and only program them
      when provided by device tree.
    - Remove the previously proposed fix_mac_speed logic.

  - Link to v1:
    https://lore.kernel.org/lkml/20260507083037.152-1-lizhi2@eswincomputing.com/

Zhi Li (5):
  dt-bindings: ethernet: eswin: add optional TXD and RXD delay register
    offsets
  net: stmmac: eswin: fix HSP CSR init ordering after clock enable
  net: stmmac: eswin: clear TXD and RXD delay registers during
    initialization
  net: stmmac: eswin: correct RGMII delay granularity to 20 ps
  net: stmmac: eswin: validate RGMII delay values

 .../bindings/net/eswin,eic7700-eth.yaml       |  13 +-
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 126 +++++++++++++-----
 2 files changed, 101 insertions(+), 38 deletions(-)

-- 
2.25.1


