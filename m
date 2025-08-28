Return-Path: <netdev+bounces-217897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32DAB3A5AD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4194668057C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B529E0F5;
	Thu, 28 Aug 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PJJLm2+C"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400222848B3
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397299; cv=none; b=ZimbFXoy9PIb2369zDOKfNGUB569zt6cGqUTjdT95eIiynA/lzpMX40g4hhYzHJj5fn/xO2QjyypH5mzOSi72n+Kh/A/SV0q8rDvSIA69zcRX0lQB2GwjMf4eBWMEw0Y93y/T1DRmXTCSbQfSlzZg48XRzGnCW+b0ShXH/cG5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397299; c=relaxed/simple;
	bh=iJTmLUgZv5gpqAHAfWE6Qbrn0ETkRyIGkrDBcz1D4FE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3RlY6pKhzpWZk5vfEAAPf9sxkVKWWvTcFMWV/YYjHyaSJN6GlzErp/Rb2/eF0rLYkp4PLV3wP8etHVG37iWRMRpPovdHmjNAMQzWU2xyp+9r7Po/EsstENnmh9h/Xr9wYMhAtCuHg/KFxFwvsr9QuQoLnCCQMrgbG3PBWveR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PJJLm2+C; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756397298; x=1787933298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nh/VJrUFOXz8QhwyJ43wTvfhplg3LaJS20YULhedKVA=;
  b=PJJLm2+CMWNE3YZCxBEOG7I2mq3tkfqjBgsJJHoiFhXCHY2BQdlt2fuU
   7M0oWBIY4DYIk5bKwX6KWdxfENq6DVVj/imNJJGXPcsq6/Dw3svgxffjO
   q9xSoFxCHNWZyAWZCDLPxfUU1XYWUceD5rIZPobta5FkiFq8UJlFwuOFR
   xu9r7bAoq80s2gVR1cAnXmhbwqnP2flN+hHAe0v9u+AFVH6DQd+rxF1qT
   QBBD78E/lq+6MvgcTYQYOJxSHF2k4Jwq2i+mdUP3tt9ma8ySIlXKH8Jwf
   U0Nx03OICY6CWbW7Xn5WYA1fKu0S/+iHy89XHFauq0is42zwLqseQLAPe
   w==;
X-CSE-ConnectionGUID: RzLSND8ySAy/0sCw+69lEg==
X-CSE-MsgGUID: QesUz69cToCSKIYGdxyWaw==
X-IronPort-AV: E=Sophos;i="6.18,220,1751241600"; 
   d="scan'208";a="1984228"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 16:08:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:48517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.7:2525] with esmtp (Farcaster)
 id 1094b440-8c0b-4fd0-8fc4-0e42387fb5ca; Thu, 28 Aug 2025 16:08:15 +0000 (UTC)
X-Farcaster-Flow-ID: 1094b440-8c0b-4fd0-8fc4-0e42387fb5ca
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 16:08:15 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 16:08:13 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: preserve RSS indirection table across admin down/up
Date: Fri, 29 Aug 2025 01:08:04 +0900
Message-ID: <20250828160806.84557-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b83c21c4-f379-47ff-9dd2-9d2fc0779d8f@molgen.mpg.de>
References: <b83c21c4-f379-47ff-9dd2-9d2fc0779d8f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sun, 24 Aug 2025 20:00:32 +0200, Paul Menzel wrote:

> Dear Kohei,
> 
> 
> Thank you for your patch.
> 
> Am 24.08.25 um 13:20 schrieb Kohei Enju:
> > Currently, the RSS indirection table configured by user via ethtool is
> > reinitialized to default values during interface resets (e.g., admin
> > down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> > Check for RSS key before setting value") made it persistent across
> > interface resets.
> > 
> > By adopting the same approach used in igc and igb drivers which
> > reinitializes the RSS indirection table only when the queue count
> > changes, let's make user configuration persistent as long as queue count
> > remains unchanged.
> > 
> > Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
> > Connection.
> > 
> > Test:
> > Set custom indirection table and check the value after interface down/up
> > 
> >    # ethtool --set-rxfh-indir ens5 equal 2
> >    # ethtool --show-rxfh-indir ens5 | head -5
> > 
> >    RX flow hash indirection table for ens5 with 12 RX ring(s):
> >        0:      0     1     0     1     0     1     0     1
> >        8:      0     1     0     1     0     1     0     1
> >       16:      0     1     0     1     0     1     0     1
> >    # ip link set dev ens5 down && ip link set dev ens5 up
> > 
> > Without patch:
> >    # ethtool --show-rxfh-indir ens5 | head -5
> > 
> >    RX flow hash indirection table for ens5 with 12 RX ring(s):
> >        0:      0     1     2     3     4     5     6     7
> >        8:      8     9    10    11     0     1     2     3
> >       16:      4     5     6     7     8     9    10    11
> > 
> > With patch:
> >    # ethtool --show-rxfh-indir ens5 | head -5
> > 
> >    RX flow hash indirection table for ens5 with 12 RX ring(s):
> >        0:      0     1     0     1     0     1     0     1
> >        8:      0     1     0     1     0     1     0     1
> >       16:      0     1     0     1     0     1     0     1
> > 
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++------
> >   2 files changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > index 14d275270123..d8b088c90b05 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > @@ -838,6 +838,7 @@ struct ixgbe_adapter {
> >    */
> >   #define IXGBE_MAX_RETA_ENTRIES 512
> >   	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
> > +	u16 last_rss_i;
> >   
> >   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
> >   	u32 *rss_key;
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 80e6a2ef1350..dc5a8373b0c3 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -4318,14 +4318,22 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
> >   	/* Fill out hash function seeds */
> >   	ixgbe_store_key(adapter);
> >   
> > -	/* Fill out redirection table */
> > -	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
> > +	/* Update redirection table in memory on first init or queue count
> > +	 * change, otherwise preserve user configurations. Then always
> > +	 * write to hardware.
> > +	 */
> > +	if (adapter->last_rss_i != rss_i) {
> > +		memset(adapter->rss_indir_tbl, 0,
> > +		       sizeof(adapter->rss_indir_tbl));
> > +
> > +		for (i = 0, j = 0; i < reta_entries; i++, j++) {
> > +			if (j == rss_i)
> > +				j = 0;
> >   
> > -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
> > -		if (j == rss_i)
> > -			j = 0;
> > +			adapter->rss_indir_tbl[i] = j;
> > +		}
> >   
> > -		adapter->rss_indir_tbl[i] = j;
> > +		adapter->last_rss_i = rss_i;
> >   	}
> >   
> >   	ixgbe_store_reta(adapter);
> > @@ -4347,12 +4355,19 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
> >   					*(adapter->rss_key + i));
> >   	}
> >   
> > -	/* Fill out the redirection table */
> > -	for (i = 0, j = 0; i < 64; i++, j++) {
> > -		if (j == rss_i)
> > -			j = 0;
> > +	/* Update redirection table in memory on first init or queue count
> > +	 * change, otherwise preserve user configurations. Then always
> > +	 * write to hardware.
> > +	 */
> > +	if (adapter->last_rss_i != rss_i) {
> > +		for (i = 0, j = 0; i < 64; i++, j++) {
> > +			if (j == rss_i)
> > +				j = 0;
> > +
> > +			adapter->rss_indir_tbl[i] = j;
> > +		}
> >   
> > -		adapter->rss_indir_tbl[i] = j;
> > +		adapter->last_rss_i = rss_i;
> >   	}
> >   
> >   	ixgbe_store_vfreta(adapter);
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you for reviewing v1, Paul.

I've posted v2 with additional logic to check reta_entries changes.
Since v2 includes a functional change, I haven't carried forward your 
Reviewed-by: tag.

> 
> Kind regards,
> 
> Paul

