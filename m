Return-Path: <netdev+bounces-50363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C327F5717
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A859F1C20BBD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7E8F57;
	Thu, 23 Nov 2023 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC981B5;
	Wed, 22 Nov 2023 19:49:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AN3mkzR72754270, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AN3mkzR72754270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 11:48:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 23 Nov 2023 11:48:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 11:48:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 23 Nov 2023 11:48:46 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase: Implement hardware configuration function
Thread-Topic: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase: Implement
 hardware configuration function
Thread-Index: AQHaF8h2HvTf1F/vj0i3mzSIlPQ+NLB8uXoAgAqPDBA=
Date: Thu, 23 Nov 2023 03:48:46 +0000
Message-ID: <3eef992d8e2440bc96d98bd5b5ce4053@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231115133414.1221480-6-justinlai0215@realtek.com>
 <20231116180610.GG109951@vergenet.net>
In-Reply-To: <20231116180610.GG109951@vergenet.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Wed, Nov 15, 2023 at 09:34:06PM +0800, Justin Lai wrote:
> > Implement rtase_hw_config to set default hardware settings, including
> > setting interrupt mitigation, tx/rx DMA burst, interframe gap time, rx
> > packet filter, near fifo threshold and fill descriptor ring and tally
> > counter address, and enable flow control. When filling the rx
> > descriptor ring, the first group of queues needs to be processed
> > separately because the positions of the first group of queues are not
> > regular with other subsequent groups. The other queues are all newly
> > added features, but we want to retain the original design. So they
> > were not put together.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Hi Justin,
>=20
> some minor feedback from my side.
>=20
> * I think that "rtase: " would be a more appropriate prefix
>   for the patches in this patch-set.
>=20
>   Subject: [PATCH net-next vX m/n] rtase: ...

Ok, I will modify this part
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/tt.c
> > b/drivers/net/ethernet/realtek/rtase/tt.c
>=20
> ...
>=20
> > new file mode 100644
> > index 000000000000..5ea4d51fcc47
> > --- /dev/null
> > +++ b/drivers/net/ethernet/realtek/rtase/tt.c
>=20
> ...
>=20
> > +static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start,
> > +u32 n) {
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     struct net_device *dev =3D tp->dev;
> > +     struct tx_desc *desc_base =3D ring->desc;
> > +     u32 i;
>=20
> nit: Please consider using reverse xmas tree - longest line to shortest -
>      for new Networking code.

Thank you for your review, I will modify it and check if there are other si=
milar issues
>=20
> ...
>=20
> > +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device
> > +*dev) {
> > +     u8 ip_protocol;
> > +     u32 csum_cmd;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
> > +             csum_cmd =3D TX_IPCS_C;
> > +             ip_protocol =3D ip_hdr(skb)->protocol;
> > +             break;
> > +
> > +     case htons(ETH_P_IPV6):
> > +             csum_cmd =3D TX_IPV6F_C;
> > +             ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> > +             break;
> > +
> > +     default:
> > +             ip_protocol =3D IPPROTO_RAW;
> > +             break;
>=20
> If the default branch is taken in this switch statement, then csum_cmd is=
 used
> uninitialised below.
>=20
> As flagged by a clang-16 W=3D1 build

Thanks, I will fix this compiler warning
>=20
> > +     }
> > +
> > +     if (ip_protocol =3D=3D IPPROTO_TCP)
> > +             csum_cmd |=3D TX_TCPCS_C;
> > +     else if (ip_protocol =3D=3D IPPROTO_UDP)
> > +             csum_cmd |=3D TX_UDPCS_C;
> > +     else
> > +             WARN_ON_ONCE(1);
> > +
> > +     csum_cmd |=3D u32_encode_bits(skb_transport_offset(skb),
> > + TCPHO_MASK);
> > +
> > +     return csum_cmd;
> > +}
> > +
> > +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *s=
kb,
> > +                         u32 opts1, u32 opts2) {
> > +     const struct skb_shared_info *info =3D skb_shinfo(skb);
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     const u8 nr_frags =3D info->nr_frags;
> > +     struct tx_desc *txd =3D NULL;
> > +     u32 cur_frag, entry;
> > +     u64 pkt_len_cnt =3D 0;
>=20
> pkt_len_cnt is initialised here...
>=20
> > +
> > +     entry =3D ring->cur_idx;
> > +     for (cur_frag =3D 0; cur_frag < nr_frags; cur_frag++) {
> > +             const skb_frag_t *frag =3D &info->frags[cur_frag];
> > +             dma_addr_t mapping;
> > +             u32 status, len;
> > +             void *addr;
> > +
> > +             entry =3D (entry + 1) % NUM_DESC;
> > +
> > +             txd =3D ring->desc + sizeof(struct tx_desc) * entry;
> > +             len =3D skb_frag_size(frag);
> > +             addr =3D skb_frag_address(frag);
> > +             mapping =3D dma_map_single(&tp->pdev->dev, addr, len,
> > +                                      DMA_TO_DEVICE);
> > +
> > +             if (unlikely(dma_mapping_error(&tp->pdev->dev,
> mapping))) {
> > +                     if (unlikely(net_ratelimit()))
> > +                             netdev_err(tp->dev,
> > +                                        "Failed to map TX
> fragments
> > + DMA!\n");
> > +
> > +                     goto err_out;
> > +             }
> > +
> > +             if (((entry + 1) % NUM_DESC) =3D=3D 0)
> > +                     status =3D (opts1 | len | RING_END);
> > +             else
> > +                     status =3D opts1 | len;
> > +
> > +             if (cur_frag =3D=3D (nr_frags - 1)) {
> > +                     ring->skbuff[entry] =3D skb;
> > +                     status |=3D TX_LAST_FRAG;
> > +             }
> > +
> > +             ring->mis.len[entry] =3D len;
> > +             txd->addr =3D cpu_to_le64(mapping);
> > +             txd->opts2 =3D cpu_to_le32(opts2);
> > +
> > +             /* make sure the operating fields have been updated */
> > +             wmb();
> > +             txd->opts1 =3D cpu_to_le32(status);
> > +             pkt_len_cnt +=3D len;
>=20
> ... and incremented here. But is otherwise unused.
>=20
> As flagged by a clang-16 W=3D1 build.

Thanks, I will remove this redundant code to fix this compiler warning
>=20
> > +     }
> > +
> > +     return cur_frag;
> > +
> > +err_out:
> > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> > +     return -EIO;
> > +}
>=20
> ...
>=20
> > +static void rtase_dump_state(const struct net_device *dev) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct rtase_counters *counters;
> > +     int max_reg_size =3D RTASE_PCI_REGS_SIZE;
> > +     const struct rtase_ring *ring;
> > +     u32 dword_rd;
> > +     int n =3D 0;
> > +
> > +     ring =3D &tp->tx_ring[0];
> > +     netdev_err(dev, "Tx descriptor info:\n");
> > +     netdev_err(dev, "Tx curIdx =3D 0x%x\n", ring->cur_idx);
> > +     netdev_err(dev, "Tx dirtyIdx =3D 0x%x\n", ring->dirty_idx);
> > +     netdev_err(dev, "Tx phyAddr =3D 0x%llx\n", ring->phy_addr);
> > +
> > +     ring =3D &tp->rx_ring[0];
> > +     netdev_err(dev, "Rx descriptor info:\n");
> > +     netdev_err(dev, "Rx curIdx =3D 0x%x\n", ring->cur_idx);
> > +     netdev_err(dev, "Rx dirtyIdx =3D 0x%x\n", ring->dirty_idx);
> > +     netdev_err(dev, "Rx phyAddr =3D 0x%llx\n", ring->phy_addr);
> > +
> > +     netdev_err(dev, "Device Registers:\n");
> > +     netdev_err(dev, "Chip Command =3D 0x%02x\n", rtase_r8(tp,
> RTASE_CHIP_CMD));
> > +     netdev_err(dev, "IMR =3D %08x\n", rtase_r32(tp, RTASE_IMR0));
> > +     netdev_err(dev, "ISR =3D %08x\n", rtase_r32(tp, RTASE_ISR0));
> > +     netdev_err(dev, "Boot Ctrl Reg(0xE004) =3D %04x\n",
> > +                rtase_r16(tp, RTASE_BOOT_CTL));
> > +     netdev_err(dev, "EPHY ISR(0xE014) =3D %04x\n",
> > +                rtase_r16(tp, RTASE_EPHY_ISR));
> > +     netdev_err(dev, "EPHY IMR(0xE016) =3D %04x\n",
> > +                rtase_r16(tp, RTASE_EPHY_IMR));
> > +     netdev_err(dev, "CLKSW SET REG(0xE018) =3D %04x\n",
> > +                rtase_r16(tp, RTASE_CLKSW_SET));
> > +
> > +     netdev_err(dev, "Dump PCI Registers:\n");
> > +
> > +     while (n < max_reg_size) {
> > +             if ((n % RTASE_DWORD_MOD) =3D=3D 0)
> > +                     netdev_err(tp->dev, "0x%03x:\n", n);
> > +
> > +             pci_read_config_dword(tp->pdev, n, &dword_rd);
> > +             netdev_err(tp->dev, "%08x\n", dword_rd);
> > +             n +=3D 4;
> > +     }
> > +
> > +     netdev_err(dev, "Dump tally counter:\n");
> > +     counters =3D tp->tally_vaddr;
> > +     rtase_dump_tally_counter(tp);
> > +
> > +     netdev_err(dev, "tx_packets %lld\n",
> > +                le64_to_cpu(counters->tx_packets));
>=20
> tx_packets is __le16 not __le64, so I think you want:
>=20
>         netdev_err(dev, "rx_missed %d\n",
>                    le16_to_cpu(counters->rx_missed));
>=20
> Likewise for align_errors, tx_aborted, and tx_underun.
>=20
> As flagged by Sparse
>=20
> > +     netdev_err(dev, "rx_packets %lld\n",
> > +                le64_to_cpu(counters->rx_packets));
> > +     netdev_err(dev, "tx_errors %lld\n",
> > +                le64_to_cpu(counters->tx_errors));
> > +     netdev_err(dev, "rx_missed %lld\n",
> > +                le64_to_cpu(counters->rx_missed));
> > +     netdev_err(dev, "align_errors %lld\n",
> > +                le64_to_cpu(counters->align_errors));
> > +     netdev_err(dev, "tx_one_collision %lld\n",
> > +                le64_to_cpu(counters->tx_one_collision));
>=20
> Similarly, tx_one_collision is __le32 not __le64, so I think you want:
> .
>         netdev_err(dev, "tx_one_collision %d\n",
>                    le32_to_cpu(counters->tx_one_collision));
>=20
> Likewise for tx_multi_collision, and rx_multicast.
>=20
> There area also similar problems in rtase_main.c:rtase_dump_state(), adde=
d
> elsewhere in this patch-set.

Thank you for your review, I will correct these little endian issues.
>=20
> > +     netdev_err(dev, "tx_multi_collision %lld\n",
> > +                le64_to_cpu(counters->tx_multi_collision));
> > +     netdev_err(dev, "rx_unicast %lld\n",
> > +                le64_to_cpu(counters->rx_unicast));
> > +     netdev_err(dev, "rx_broadcast %lld\n",
> > +                le64_to_cpu(counters->rx_broadcast));
> > +     netdev_err(dev, "rx_multicast %lld\n",
> > +                le64_to_cpu(counters->rx_multicast));
> > +     netdev_err(dev, "tx_aborted %lld\n",
> > +                le64_to_cpu(counters->tx_aborted));
> > +     netdev_err(dev, "tx_underun %lld\n",
> > +                le64_to_cpu(counters->tx_underun));
> > +}
>=20
> ...
>=20
> > +static const char rtase_gstrings[][ETH_GSTRING_LEN] =3D {
> > +     "tx_packets",
> > +     "rx_packets",
> > +     "tx_errors",
> > +     "rx_errors",
> > +     "rx_missed",
> > +     "align_errors",
> > +     "tx_single_collisions",
> > +     "tx_multi_collisions",
> > +     "unicast",
> > +     "broadcast",
> > +     "multicast",
> > +     "tx_aborted",
> > +     "tx_underrun",
> > +};
> > +
> > +static void rtase_get_strings(struct net_device *dev, u32 stringset,
> > +u8 *data) {
> > +     switch (stringset) {
> > +     case ETH_SS_STATS:
> > +             memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));
>=20
> Compilers don't think this is seem correct, because *rtase_gsrings is the=
 first
> element of that array, rather than the entire array. And thus is only
> ETH_GSTRING_LEN bytes long, rather than n * ETH_GSTRING_LEN bytes long.
>=20
> I think what you want is (compile tested only!):
>=20
>                 memcpy(data, rtase_gstrings, sizeof(rtase_gstrings));
>=20
> Flagged by a clang-16 W=3D1 build.

Thanks for your suggestion, I will fix it.
>=20
> > +             break;
> > +     }
> > +}
>=20
> ...
>=20
> > +static int rtase_init_board(struct pci_dev *pdev, struct net_device
> **dev_out,
> > +                         void __iomem **ioaddr_out) {
> > +     struct net_device *dev;
> > +     void __iomem *ioaddr;
> > +     int ret =3D -ENOMEM;
> > +
> > +     /* dev zeroed in alloc_etherdev */
> > +     dev =3D alloc_etherdev_mq(sizeof(struct rtase_private),
> > +                             RTASE_FUNC_TXQ_NUM);
> > +     if (!dev)
> > +             goto err_out;
> > +
> > +     SET_NETDEV_DEV(dev, &pdev->dev);
> > +
> > +     ret =3D pci_enable_device(pdev);
> > +     if (ret < 0)
> > +             goto err_out_free_dev;
> > +
> > +     /* make sure PCI base addr 1 is MMIO */
> > +     if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
> > +             ret =3D -ENODEV;
> > +             goto err_out_disable;
> > +     }
> > +
> > +     /* check for weird/broken PCI region reporting */
> > +     if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
> > +             ret =3D -ENODEV;
> > +             goto err_out_disable;
> > +     }
> > +
> > +     ret =3D pci_request_regions(pdev, KBUILD_MODNAME);
> > +     if (ret < 0)
> > +             goto err_out_disable;
> > +
> > +     if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> > +             dev->features |=3D NETIF_F_HIGHDMA;
> > +     else if (dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32)))
> > +             goto err_out_free_res;
> > +     else
> > +             dev_info(&pdev->dev, "DMA_BIT_MASK: 32\n");
> > +
> > +     pci_set_master(pdev);
> > +
> > +     /* ioremap MMIO region */
> > +     ioaddr =3D ioremap(pci_resource_start(pdev, 2),
> > +                      pci_resource_len(pdev, 2));
> > +     if (!ioaddr) {
> > +             ret =3D -EIO;
> > +             goto err_out_free_res;
> > +     }
> > +
> > +     *ioaddr_out =3D ioaddr;
> > +     *dev_out =3D dev;
> > +     goto out;
>=20
> nit: I think it's slightly more idiomatic to simply return 0 here,
>      and drop the out label below.

Thanks, I will modify it.
>=20
> > +
> > +err_out_free_res:
> > +     pci_release_regions(pdev);
> > +
> > +err_out_disable:
> > +     pci_disable_device(pdev);
> > +
> > +err_out_free_dev:
> > +     free_netdev(dev);
> > +
> > +err_out:
> > +     *ioaddr_out =3D NULL;
> > +     *dev_out =3D NULL;
> > +
> > +out:
> > +     return ret;
> > +}
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/tt.h
> > b/drivers/net/ethernet/realtek/rtase/tt.h
> > new file mode 100644
> > index 000000000000..9239c518c504
> > --- /dev/null
> > +++ b/drivers/net/ethernet/realtek/rtase/tt.h
> > @@ -0,0 +1,353 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/*
> > + *  rtase is the Linux device driver released for Realtek Automotive
> > +Switch
> > + *  controllers with PCI-Express interface.
> > + *
> > + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> > + */
> > +
> > +#ifndef _RTASE_H_
> > +#define _RTASE_H_
>=20
> If the code in tt.h is only used in tt.c, then perhaps the code can simpl=
y be
> moved into tt.c.

Sorry, tt.c and tt.h are redundant codes, I will remove them.
>=20
> ...

