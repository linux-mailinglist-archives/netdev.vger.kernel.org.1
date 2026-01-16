Return-Path: <netdev+bounces-250452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80BD2C6B5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D0B304323E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83225342CBA;
	Fri, 16 Jan 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a0Nj2Gtw"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE50322533
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544205; cv=none; b=pqjZ/VptKDfuZwMcu6faTOSBoBmWEiywCx6/ObnteDgcqmS9PXJjnX8J6rG0zAddPy8I9MWGjbkDyDkIcwpghWh1loXw1pRZI6ls2E0YyONZTRoYzOWUJrZFmWqwZxPmpOIzlNdXR5UaisKDcXuwSwcmsVRnlIsf22+OhUz7IBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544205; c=relaxed/simple;
	bh=y/Cx2zbsytOQ8HB2TXHSgCNMOJzg2AE3hjdpB44xxkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK99iWOSqfrtcS8JZ7EzWHVVADwqKsEA9yfujGxTaaOk+VC9GA/opTZP72xubBrAxLtkY/uKLYyOFcNJQkmYA9HrSpbkggz1viE5gVi+GMkiv/VDgjlVjWLSnryKj1B8CB9+fDpUF5IFgoect+Byl3r4wfeDqziqH5rxMFDJlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a0Nj2Gtw; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768544203; x=1800080203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYmrqpWIPJWJpN9ggqrG8icNXtPcugfX8hE3p0bXivo=;
  b=a0Nj2GtwvvQCHEQl5MpiAo9XD2e//jVPCQwHClnHPwqYca4aEGzaQrsV
   Z8f1nnXST7pO7F+KCew9QAhWaOO5esry9+nmMlMdlwdvxhedCk+Hh2gl8
   Qt4PtKv6wsMSLJJKemEVU5gGNcqt6cCJP5E08BBFQgymJqsB7uR616fvG
   0dH3SeEzF9CGEHj5oyex7pTi58zx5z24y6MotTl+rosHdgPhpnfMo9nBL
   WKQSuXX4ITiTkRahGd/Qd1dtJmxW6SVMUOvBNI3DsyvGCeQIykuP+HITx
   8R5lo7L/jFVRL2P9xb0OdpdI/sO5x9MfLEZ8oQw50VSQbyShgr8ZidsFf
   A==;
X-CSE-ConnectionGUID: VC7y4LxHQCiNZMA6aQ8Zvg==
X-CSE-MsgGUID: pyI9yhR9QYGA0MYc9INvaA==
X-IronPort-AV: E=Sophos;i="6.21,230,1763424000"; 
   d="scan'208";a="10781657"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 06:16:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:17737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.191:2525] with esmtp (Farcaster)
 id 29701752-47e2-42e6-99e6-c54bb65648dc; Fri, 16 Jan 2026 06:16:40 +0000 (UTC)
X-Farcaster-Flow-ID: 29701752-47e2-42e6-99e6-c54bb65648dc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 06:16:39 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 06:16:38 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <takkozu@amazon.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igb: prepare for RSS key get/set support
Date: Fri, 16 Jan 2026 15:16:31 +0900
Message-ID: <20260116061630.77723-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2ad8d26a-794c-498b-a09b-5791acb0a9d5@molgen.mpg.de>
References: <2ad8d26a-794c-498b-a09b-5791acb0a9d5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> From: Paul Menzel <pmenzel@molgen.mpg.de>
> To: Takashi Kozu <takkozu@amazon.com>
> Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
> andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
> kuba@kernel.org, pabeni@redhat.com,
> intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
> Kohei Enju <enjuk@amazon.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igb: prepare for RSS key get/set support
> Date: Thu, 8 Jan 2026 13:27:57 +0100 [thread overview]
> Message-ID: <2ad8d26a-794c-498b-a09b-5791acb0a9d5@molgen.mpg.de> (raw)
> In-Reply-To: <20260108052020.84218-6-takkozu@amazon.com>
> 
> Dear Takashi,
> 
> 
> Thank you for the patch.
> 
> Am 08.01.26 um 06:20 schrieb Takashi Kozu:
> > Store the RSS key inside struct igb_adapter and introduce the
> > igb_write_rss_key() helper function. This allows the driver to program
> > the E1000 registers using a persistent RSS key, instead of using a
> > stack-local buffer in igb_setup_mrqc().
> >
> > Tested-by: Kohei Enju <enjuk@amazon.com>
> > Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> > ---
> > drivers/net/ethernet/intel/igb/igb.h | 3 +++
> > drivers/net/ethernet/intel/igb/igb_ethtool.c | 12 ++++++++++++
> > drivers/net/ethernet/intel/igb/igb_main.c | 6 ++----
> > 3 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> > index 0fff1df81b7b..8c9b02058cec 100644
> > --- a/drivers/net/ethernet/intel/igb/igb.h
> > +++ b/drivers/net/ethernet/intel/igb/igb.h
> > @@ -495,6 +495,7 @@ struct hwmon_buff {
> > #define IGB_N_PEROUT 2
> > #define IGB_N_SDP 4
> > #define IGB_RETA_SIZE 128
> > +#define IGB_RSS_KEY_SIZE 40
> >
> > enum igb_filter_match_flags {
> > IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
> > @@ -655,6 +656,7 @@ struct igb_adapter {
> > struct i2c_client *i2c_client;
> > u32 rss_indir_tbl_init;
> > u8 rss_indir_tbl[IGB_RETA_SIZE];
> > + u8 rss_key[IGB_RSS_KEY_SIZE];
> >
> > unsigned long link_check_timeout;
> > int copper_tries;
> > @@ -735,6 +737,7 @@ void igb_down(struct igb_adapter *);
> > void igb_reinit_locked(struct igb_adapter *);
> > void igb_reset(struct igb_adapter *);
> > int igb_reinit_queues(struct igb_adapter *);
> > +void igb_write_rss_key(struct igb_adapter *adapter);
> > void igb_write_rss_indir_tbl(struct igb_adapter *);
> > int igb_set_spd_dplx(struct igb_adapter *, u32, u8);
> > int igb_setup_tx_resources(struct igb_ring *);
> > diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > index 10e2445e0ded..8695ff28a7b8 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > @@ -3016,6 +3016,18 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
> > return ret;
> > }
> >
> > +void igb_write_rss_key(struct igb_adapter *adapter)
> > +{
> > + struct e1000_hw *hw = &adapter->hw;
> > + u32 val;
> > + int i;
> > +
> > + for (i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
> > + val = get_unaligned_le32(&adapter->rss_key[i info.plist 4]);
> 
> Why is `get_unaligned_le32()` needed?

I think it's necessary in order to align to 4 bytes.

