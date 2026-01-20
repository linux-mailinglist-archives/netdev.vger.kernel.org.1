Return-Path: <netdev+bounces-251348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5020ED3BE22
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A601A4E0CAC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C133A6FE;
	Tue, 20 Jan 2026 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hi5gjZXH"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140C33A6F6
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882195; cv=none; b=kLfueserbWOieFnEe3hPLOVScW+IVBf5Vsl2nNHY9jKvtcPcTqTWJ3ZetM3YIiTGWNUU5SC6d94/BJYJnjCQfiTxPDHinWKj8BqBXSh93yskfQ9LdOMOTRjTeVoO43l5RJockJtlR8TSkIkxVEiz6hbbqzsjg1Mis1AjfUG2lyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882195; c=relaxed/simple;
	bh=4G8l5k6weanXKozxN4JF5V9Fs42XkHux3mZge0qViVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1V2xfPqtuLfbM5bOhy7ylF1FDyxXut0e/h6PdZVy905VQD1mykv7dlO+I+PzwZdlYqwMDizMTSZUIGifV7KI1063N1XDEMTaxMydoIQqxu8OFpMO34JJAXkthH7fFOnCZ5jQE3KsK7JqzPMfozuMU4PS7vK1LJhsOu+jOv5n7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hi5gjZXH; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768882193; x=1800418193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O9ZU9K6r9ey5QSCUFUoJneb2msolBKA4lldbC697eK0=;
  b=Hi5gjZXHZ+gJRAXMuqfbrikdCh8jHJ3x1aAMgrYKdebKGSIm+8rJKmf1
   DGEE9vhFDwkspJoAqKpMO7d0dA3GC9v+4X7aTe3MWx6qhM1PCRY1o3WE5
   6JR3eoz1n5X+rV1e/4ftZ+h9EzcZ1BKTpEUis96YjCEcOWrPM9HvZX7AB
   yleDXfor4h5z97Qf+/rAR9xeTk3BLcJvXFfJ6gJKtq72BkhS5b/ssUvSV
   X27qiFgPCW8KSgKSDsIUVaNQbXIwFBWaZOiuAd4aBChcQOIHuZ/gyGib0
   YllXV8987olsy307YzHDlQfq9jpnYY8QvCBY9zKYX84I9YT22iQtctOY5
   A==;
X-CSE-ConnectionGUID: UR6KsHMsSgKY/UEhXwa9IQ==
X-CSE-MsgGUID: kT+Eth0qQMWhIxTtzLv2wg==
X-IronPort-AV: E=Sophos;i="6.21,239,1763424000"; 
   d="scan'208";a="11176209"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 04:09:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:23499]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.231:2525] with esmtp (Farcaster)
 id 93351dc0-42f3-42df-8453-5ad81db6cc28; Tue, 20 Jan 2026 04:09:51 +0000 (UTC)
X-Farcaster-Flow-ID: 93351dc0-42f3-42df-8453-5ad81db6cc28
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 04:09:48 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 04:09:46 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <piotr.kwapulinski@intel.com>,
	<pmenzel@molgen.mpg.de>, <przemyslaw.kitszel@intel.com>,
	<takkozu@amazon.com>, <enjuk@amazon.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/3] igb: prepare for RSS key get/set support
Date: Tue, 20 Jan 2026 13:09:39 +0900
Message-ID: <20260120040938.95789-2-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <IA3PR11MB898693239F08B055E714E430E588A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898693239F08B055E714E430E588A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
> To: Takashi Kozu <takkozu@amazon.com>,
> "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
> Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
> "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
> "davem@davemloft.net" <davem@davemloft.net>,
> "edumazet@google.com" <edumazet@google.com>,
> "kuba@kernel.org" <kuba@kernel.org>,
> "pabeni@redhat.com" <pabeni@redhat.com>,
> "intel-wired-lan@lists.osuosl.org"
> <intel-wired-lan@lists.osuosl.org>,
> "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
> "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
> "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/3] igb: prepare for RSS key get/set support
> Date: Mon, 19 Jan 2026 10:19:02 +0000 [thread overview]
> Message-ID: <IA3PR11MB898693239F08B055E714E430E588A@IA3PR11MB8986.namprd11.prod.outlook.com> (raw)
> In-Reply-To: <20260119084511.95287-6-takkozu@amazon.com>
> 
> 
> 
> > -----Original Message-----
> > From: Takashi Kozu <takkozu@amazon.com>
> > Sent: Monday, January 19, 2026 9:45 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> > Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; pmenzel@molgen.mpg.de; Kwapulinski,
> > Piotr <piotr.kwapulinski@intel.com>; Takashi Kozu <takkozu@amazon.com>
> > Subject: [PATCH iwl-next v3 1/3] igb: prepare for RSS key get/set
> > support
> >
> > Store the RSS key inside struct igb_adapter and introduce the
> > igb_write_rss_key() helper function. This allows the driver to program
> > the E1000 registers using a persistent RSS key, instead of using a
> > stack-local buffer in igb_setup_mrqc().
> >
> > Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> > ---
> > drivers/net/ethernet/intel/igb/igb.h | 3 +++
> > drivers/net/ethernet/intel/igb/igb_ethtool.c | 21
> > ++++++++++++++++++++
> > drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++----
> > 3 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb.h
> > b/drivers/net/ethernet/intel/igb/igb.h
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
> > @@ -735,6 +737,7 @@ void igb_down(struct igb_adapter *); void
> > igb_reinit_locked(struct igb_adapter *); void igb_reset(struct
> > igb_adapter *); int igb_reinit_queues(struct igb_adapter *);
> > +void igb_write_rss_key(struct igb_adapter *adapter);
> > void igb_write_rss_indir_tbl(struct igb_adapter *); int
> > igb_set_spd_dplx(struct igb_adapter *, u32, u8); int
> > igb_setup_tx_resources(struct igb_ring *); diff --git
> > a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > index 10e2445e0ded..5107b0de4fa3 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > @@ -3016,6 +3016,27 @@ static int igb_set_rxnfc(struct net_device
> > *dev, struct ethtool_rxnfc *cmd)
> > return ret;
> > }
> >
> > +/**
> > + info.plist igb_write_rss_key - Program the RSS key into device registers
> > + info.plist @adapter: board private structure
> > + info.plist
> > + info.plist Write the RSS key stored in adapter->rss_key to the E1000 hardware
> > registers.
> > + info.plist Each 32-bit chunk of the key is read using get_unaligned_le32()
> > and
> > +written
> > + info.plist to the appropriate register.
> > + */
> > +void igb_write_rss_key(struct igb_adapter *adapter) {
> Opening brace placement violates kernel coding style. For functions,
> the opening brace should be on the next line, not on the same line as the function declaration.
> Or is it my mail-client issue?

From my side, the opening brace is correctly on the next line.

```
+void igb_write_rss_key(struct igb_adapter *adapter)
+{
```

> > + ASSERT_RTNL();
> > +
> > + struct e1000_hw *hw = &adapter->hw;
> Declarations should be at the start of the block.
> I think ASSERT_RTNL(); can be moved down safely?

Thanks for pointing out. I'll fix this.

