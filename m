Return-Path: <netdev+bounces-255792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIgQHk1pgGlA7wIAu9opvQ
	(envelope-from <netdev+bounces-255792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:07:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8DC9E92
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8461300335D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B934EEEA;
	Mon,  2 Feb 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Scd2xrk3"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0734D3AA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023228; cv=none; b=Kv1QE149H68NNWKIlAq3W2+pYZmiKiuslihqSN1IdlVnHQBoA1yLTS+yPozoIXeDSPs5wYqa4+NFBLTqGKjd/Fw0E9j4JYIv2t213pTct0sJS3CUJGPt3JvwXC+IITXSTFQpDjXu2k7Qu2BdmzU9VS29x8RT2uzZ8C8ZbtNlMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023228; c=relaxed/simple;
	bh=eMPh5S334P7xUNWlMvIx3LZ1VKaQGPO2IBL01BTqCe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bud9SLQxIVdHIuDA1t2ScGouNHXQ42kK/UJ8gmaBGxlg6/WAHE94Ms13G8su7b25ohNJFO2lWVIQ/z6xByqZiJXtT1tUnuW7USOxxfdIHK6mBzTSsWk5iuu0p8OsgsbcN2SDZqkDGuWG8c24bSeaD/PL26eppqgCqykfvzjQ1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Scd2xrk3; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 612974hT066924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 2 Feb 2026 18:07:04 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=yyiESOm90+z7sZstCR+aMqmEF6B3vc9FhNQzGa+DDnE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770023224; v=1;
        b=Scd2xrk3YRXMJ6fh/iB7Mz0rAgl7g7gvaTNfc630RKlwg6J9Q+SMqz6R2rMNL0lB
         x2gbPv5TVxrF0Q7sk1NrDnyG9e4tbdkVNBn9dYbQFM9G8sxeVQb7li3GhvS52ZSz
         yAwwXyQMol4qNCZHuJF+z9OlEax2LVXiTaANmtgg56CuAzKKgpu0ncLoQ6CvZgrw
         9uW7lSB6wEsVGgCRz7rOExgG2FajkUddnDSfydRnOHrkJfbslzDwOaHGzHtxvIg9
         JDLq1IXUe65UKnBygtxcCXMPnqHHxvXvbdyfReuSQPSVsFgTkmg/7gof2WMCSl+J
         QQzuI4rKsoejryGoNk8Mmg==
From: Kohei Enju <kohei@enjuk.jp>
To: aleksandr.loktionov@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, kohei.enju@gmail.com, kohei@enjuk.jp,
        kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, vitaly.lifshits@intel.com
Subject: Re: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set support
Date: Mon,  2 Feb 2026 09:06:26 +0000
Message-ID: <20260202090704.13025-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <IA3PR11MB89866EDA0E5756FBE635AF8DE59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89866EDA0E5756FBE635AF8DE59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,kernel.org,lists.osuosl.org,gmail.com,enjuk.jp,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255792-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim]
X-Rspamd-Queue-Id: 03A8DC9E92
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 07:59:55 +0000, "Loktionov, Aleksandr" wrote:

> > @@ -360,6 +362,7 @@ unsigned int igc_get_max_rss_queues(struct
> > igc_adapter *adapter);  void igc_set_flag_queue_pairs(struct
> > igc_adapter *adapter,
> >  			      const u32 max_rss_queues);
> >  int igc_reinit_queues(struct igc_adapter *adapter);
> > +void igc_write_rss_key(struct igc_adapter *adapter);
> >  void igc_write_rss_indir_tbl(struct igc_adapter *adapter);  bool
> > igc_has_link(struct igc_adapter *adapter);  void igc_reset(struct
> > igc_adapter *adapter); diff --git
> > a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 3172cdbca9cc..1b4075e7e8e6 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> I think here should be added include?
> 
> #include <linux/unaligned.h> /* for get_unaligned_le32() */
> 
> Isn't it?

Hi Alex, thank you for reviewing.

Compilation succeeds as is, and the header file is included indirectly
in the following path.

igc_ethtool.c
  -> linux/if_vlan.h
    -> linux/etherdevice.h
      -> linux/unaligned.h

> 
> > @@ -1460,6 +1460,26 @@ static int igc_ethtool_set_rxnfc(struct
> > net_device *dev,
> >  	}
> >  }
> >=20
> > +/**
> > + * igc_write_rss_key - Program the RSS key into device registers
> > + * @adapter: board private structure
> > + *
> > + * Write the RSS key stored in adapter->rss_key to the IGC_RSSRK
> > registers.
> > + * Each 32-bit chunk of the key is read using get_unaligned_le32()
> > and
> > +written
> > + * to the appropriate register.
> > + */
> > +void igc_write_rss_key(struct igc_adapter *adapter) {
> > +	struct igc_hw *hw =3D &adapter->hw;
> > +	u32 val;
> > +	int i;
> > +
> > +	for (i =3D 0; i < IGC_RSS_KEY_SIZE / 4; i++) {
> > +		val =3D get_unaligned_le32(&adapter->rss_key[i * 4]);
> > +		wr32(IGC_RSSRK(i), val);
> > +	}
> > +}
> > +
> 
> ...
> 
> > --
> > 2.51.0

