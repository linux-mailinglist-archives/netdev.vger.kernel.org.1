Return-Path: <netdev+bounces-213269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6FB244C1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C336C7B4AF7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F62EF64A;
	Wed, 13 Aug 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lRmybN0Z"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E662D63FA;
	Wed, 13 Aug 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075281; cv=none; b=qImM/Pjg7wgmqTp/V6PT1QlM2/vG5qS2YxBn0FBcZxgvJ06TgRauDOhMWJxX5qkdlwPKh0HMDssUR1l5Uej+mbhLVPtilpAZioxxTqRb56O1NfzZ45AlzFXy1a29k1B64kwPahadQ9GiT4F11CJ/LSaJwFw4mxlv+AhySchGeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075281; c=relaxed/simple;
	bh=OX5cAn7DTkokSDT2GLwOZld9Ar0WmN22E6lBIalVeYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s23BOZZDDGWlMHhTQNzd8/D4ixx/KugWJ1UTW5RhNEmnMjWqNoyUJfCSET/QaTqg9EbJ7WSpobOWWBsZNxg+ifgmh8PN/DYvDU4848L3KzgKd+fQf4cKdr/Yw3og/0qz+zdVpOPdE0r9JkWDl4ItAAmtaGbF+UMAysk6Rc8YdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lRmybN0Z; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755075279; x=1786611279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3jaNKEVUZhYIrIsCy05Hngz/5E6Uji9DlFliACU1Mo=;
  b=lRmybN0Z4jbdzxHPQCAmFE7a+E/PcjKwuKF1GIzXD/qdE42TPZFq+utn
   PAxM3ivkiNvrUrCqcnP2BEzoF2UWdGskdO5IHKzRfd5y2K0p54f/5Wro7
   iYILiIC4wMOXh7nmAFDEeDYX/kVYL73ST00rshvjz/X+QLgLBZLkmkcSu
   AKjN+Thq0s9cF2JbIv3PK9P5np57L5FWu1jZIZeMv/HZnyWOUkbQUUesZ
   hpKlgtK3/hE5u0/CuxPF6yT5VyiehOn1Fp+Wmyls/Yp4KwFy73cHSL5Ek
   7Zle1Ujf8oOFnbPghfzHJZH3UYbRj+2cgkOPnWgDVV75aJx1cAtwDfYWT
   g==;
X-CSE-ConnectionGUID: niM61iOuSkO3prjmHbakQA==
X-CSE-MsgGUID: if+xEH1jQ/qY/p/uaH7NAw==
X-IronPort-AV: E=Sophos;i="6.17,285,1747699200"; 
   d="scan'208";a="1106306"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:54:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:40173]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.4:2525] with esmtp (Farcaster)
 id 1a967b2c-6129-4dea-8193-31851424e75a; Wed, 13 Aug 2025 08:54:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1a967b2c-6129-4dea-8193-31851424e75a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 13 Aug 2025 08:54:37 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Wed, 13 Aug 2025 08:54:35 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next 2/2] igbvf: remove
 duplicated counter rx_long_byte_count from ethtool statistics
Date: Wed, 13 Aug 2025 17:54:23 +0900
Message-ID: <20250813085428.89006-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <785b380c-d4ba-423c-93ed-059d0aebc6be@molgen.mpg.de>
References: <785b380c-d4ba-423c-93ed-059d0aebc6be@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 13 Aug 2025 10:20:33 +0200, Paul Menzel wrote:=0D
=0D
> Dear Kohei,=0D
> =0D
> =0D
> Thank you for your patch.=0D
> =0D
> Am 13.08.25 um 09:50 schrieb Kohei Enju:=0D
> > rx_long_byte_count shows the value of the GORC (Good Octets Received=0D
> > Count) register. However, the register value is already shown as=0D
> > rx_bytes and they always show the same value.=0D
> > =0D
> > Remove rx_long_byte_count as the Intel ethernet driver e1000e did in=0D
> > commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").=0D
> > =0D
> > Tested on Intel Corporation I350 Gigabit Network Connection.=0D
> > =0D
> > Tested-by: Kohei Enju <enjuk@amazon.com>=0D
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>=0D
> > ---=0D
> >   drivers/net/ethernet/intel/igbvf/ethtool.c | 1 -=0D
> >   1 file changed, 1 deletion(-)=0D
> > =0D
> > diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/e=
thernet/intel/igbvf/ethtool.c=0D
> > index c6defc495f13..9c08ebfad804 100644=0D
> > --- a/drivers/net/ethernet/intel/igbvf/ethtool.c=0D
> > +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c=0D
> > @@ -36,7 +36,6 @@ static const struct igbvf_stats igbvf_gstrings_stats[=
] =3D {=0D
> >   	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },=0D
> >   	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },=0D
> >   	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },=0D
> > -	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },=0D
> >   	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },=0D
> >   	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },=0D
> >   	{ "rx_header_split", IGBVF_STAT(rx_hdr_split, zero_base) },=0D
> =0D
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>=0D
=0D
Thank you for reviewing!=0D
=0D
> =0D
> Kind regards,=0D
> =0D
> Paul=0D
> =0D
> =0D
> PS: Should you resend, *redundant* instead of *duplicated* might better =
=0D
> describe the removed counter.=0D
=0D
Sure, I resend this patch as v2 with the changes:=0D
  - s/duplicated/redundant/=0D
  - Remove Tested-by: tag=0D
  - Add Reviewed-by: tag=0D
=0D
Thanks for the feedback.=0D

