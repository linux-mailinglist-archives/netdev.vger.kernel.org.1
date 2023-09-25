Return-Path: <netdev+bounces-36168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD47ADFD9
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 21:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 96CFF2813D5
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB301224F9;
	Mon, 25 Sep 2023 19:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1470179B4
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:50:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D50109
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ipzR39TmhmqHzS02fSh+VFhLnrwo7FeJ03ytLCA7Hdw=; b=ys
	meiksB71VUOPmP6qMhMhXRN6jSxTnYe3M5xENzDedkETd7YkAA2ZP/6ySlA7siHr2utNiD82QJis2
	YpG38C2Fgh1pGVy5kB7d9/z1U7l11ki1Btj0Cmjmi9R6lOzirrrXyo6rWuwMR4FDxHJ+VAitoShgA
	yFlsU6bw0hH+13k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qkraV-007U0J-NV; Mon, 25 Sep 2023 21:49:47 +0200
Date: Mon, 25 Sep 2023 21:49:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasad Koya <prasad@arista.com>
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	"lifshits, Vitaly" <vitaly.lifshits@intel.com>, edumazet@google.com,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Subject: Re: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Message-ID: <8b73a251-c00d-4de7-b520-7e43478846f5@lunn.ch>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
 <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
 <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> However, to reset the link with new 'advertising' bits, code takes this path:
> 
> [  255.073847]  igc_setup_copper_link+0x73c/0x750
> [  255.073851]  igc_setup_link+0x4a/0x170
> [  255.073852]  igc_init_hw_base+0x98/0x100
> [  255.073855]  igc_reset+0x69/0xe0
> [  255.073857]  igc_down+0x22b/0x230
> [  255.073859]  igc_ethtool_set_link_ksettings+0x25f/0x270
> [  255.073863]  ethtool_set_link_ksettings+0xa9/0x140
> [  255.073866]  dev_ethtool+0x1236/0x2570
> 
> igc_setup_copper_link() calls igc_copper_link_autoneg(). 
> igc_copper_link_autoneg() changes phy->autoneg_advertised
> 
>     phy->autoneg_advertised &= phy->autoneg_mask;
> 
> and autoneg_mask is IGC_ALL_SPEED_DUPLEX_2500 which is 0xaf:
> 
> /* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
> #define ADVERTISE_10_HALF       0x0001
> #define ADVERTISE_10_FULL       0x0002
> #define ADVERTISE_100_HALF      0x0004
> #define ADVERTISE_100_FULL      0x0008
> #define ADVERTISE_1000_HALF     0x0010 /* Not used, just FYI */
> #define ADVERTISE_1000_FULL     0x0020
> #define ADVERTISE_2500_HALF     0x0040 /* Not used, just FYI */
> #define ADVERTISE_2500_FULL     0x0080
> 
> #define IGC_ALL_SPEED_DUPLEX_2500 ( \
>     ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
>     ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
> 
> so 0x20c8 & 0xaf becomes 0x88 ie., the TP bit (bit 7
> of ethtool_link_mode_bit_indices) in 0x20c8 got interpreted as
> ADVERTISE_2500_FULL. so after igc_reset(), hw->phy.autoneg_advertised is 0x88.
> Post that, 'ethtool <interface>' reports 2500Mbps can also be advertised. 

So you seem to understand the real problem here. It would be better to
keep the patch, which does in fact look sensible, and fix the real
problem, the mixup between TP and ADVERTISE_2500_FULL in the igb
code.

	 Andrew

