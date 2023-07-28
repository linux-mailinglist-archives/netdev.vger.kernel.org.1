Return-Path: <netdev+bounces-22285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842ED766E85
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DB1C218D9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2F134D1;
	Fri, 28 Jul 2023 13:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A2C8C9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 13:38:14 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DE30C2;
	Fri, 28 Jul 2023 06:37:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 701451C0007;
	Fri, 28 Jul 2023 13:37:40 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH net] batman-adv: Do not get eth header before batadv_check_management_packet
Date: Fri, 28 Jul 2023 15:38:50 +0200
Message-Id: <20230728133850.5974-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If received skb in batadv_v_elp_packet_recv or batadv_v_ogm_packet_recv
is either cloned or non linearized then its data buffer will be
reallocated by batadv_check_management_packet when skb_cow or
skb_linearize get called. Thus geting ethernet header address inside
skb data buffer before batadv_check_management_packet had any chance to
reallocate it could lead to the following kernel panic:

  Unable to handle kernel paging request at virtual address ffffff8020ab069a
  Mem abort info:
    ESR = 0x96000007
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x07: level 3 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000007
    CM = 0, WnR = 0
  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000040f45000
  [ffffff8020ab069a] pgd=180000007fffa003, p4d=180000007fffa003, pud=180000007fffa003, pmd=180000007fefe003, pte=0068000020ab0706
  Internal error: Oops: 96000007 [#1] SMP
  Modules linked in: ahci_mvebu libahci_platform libahci dvb_usb_af9035 dvb_usb_dib0700 dib0070 dib7000m dibx000_common ath11k_pci ath10k_pci ath10k_core mwl8k_new nf_nat_sip nf_conntrack_sip xhci_plat_hcd xhci_hcd nf_nat_pptp nf_conntrack_pptp at24 sbsa_gwdt
  CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.15.42-00066-g3242268d425c-dirty #550
  Hardware name: A8k (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : batadv_is_my_mac+0x60/0xc0
  lr : batadv_v_ogm_packet_recv+0x98/0x5d0
  sp : ffffff8000183820
  x29: ffffff8000183820 x28: 0000000000000001 x27: ffffff8014f9af00
  x26: 0000000000000000 x25: 0000000000000543 x24: 0000000000000003
  x23: ffffff8020ab0580 x22: 0000000000000110 x21: ffffff80168ae880
  x20: 0000000000000000 x19: ffffff800b561000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 00dc098924ae0032
  x14: 0f0405433e0054b0 x13: ffffffff00000080 x12: 0000004000000001
  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
  x8 : 0000000000000000 x7 : ffffffc076dae000 x6 : ffffff8000183700
  x5 : ffffffc00955e698 x4 : ffffff80168ae000 x3 : ffffff80059cf000
  x2 : ffffff800b561000 x1 : ffffff8020ab0696 x0 : ffffff80168ae880
  Call trace:
   batadv_is_my_mac+0x60/0xc0
   batadv_v_ogm_packet_recv+0x98/0x5d0
   batadv_batman_skb_recv+0x1b8/0x244
   __netif_receive_skb_core.isra.0+0x440/0xc74
   __netif_receive_skb_one_core+0x14/0x20
   netif_receive_skb+0x68/0x140
   br_pass_frame_up+0x70/0x80
   br_handle_frame_finish+0x108/0x284
   br_handle_frame+0x190/0x250
   __netif_receive_skb_core.isra.0+0x240/0xc74
   __netif_receive_skb_list_core+0x6c/0x90
   netif_receive_skb_list_internal+0x1f4/0x310
   napi_complete_done+0x64/0x1d0
   gro_cell_poll+0x7c/0xa0
   __napi_poll+0x34/0x174
   net_rx_action+0xf8/0x2a0
   _stext+0x12c/0x2ac
   run_ksoftirqd+0x4c/0x7c
   smpboot_thread_fn+0x120/0x210
   kthread+0x140/0x150
   ret_from_fork+0x10/0x20
  Code: f9403844 eb03009f 54fffee1 f94

Thus ethernet header address should only be fetched after
batadv_check_management_packet has been called.

Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/bat_v_elp.c | 3 ++-
 net/batman-adv/bat_v_ogm.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index acff565849ae..1d704574e6bf 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -505,7 +505,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -513,6 +513,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e710e9afe78f..84eac41d4658 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -985,7 +985,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -999,6 +999,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
-- 
2.40.0


