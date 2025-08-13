Return-Path: <netdev+bounces-213266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD4B244B1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A83AB9CD
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7482D979B;
	Wed, 13 Aug 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Up8ZMfIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD82D5A13;
	Wed, 13 Aug 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074910; cv=none; b=drFN7+IwC+Rkqg5rGEeAfHrHMeOWYDysv0gSuqpnpII6LDBrl+um9CZwsUNM50P44ys9tbkxBUSMAZH8OiwK/OtO7I/6nuZhsoTKk55XkFqxv8Gkfcrsgq5lO53LD/gP+PtJz9+PIzoepfUnxAXnN/2MnJMTq1C4Zh4q9YcuthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074910; c=relaxed/simple;
	bh=U7AcBY+w23HaGZoQTSyjMhvyp/uzWVzGS7MvGLs6JTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yki5+yncECd0avsVn0kYFJQwjEINjUU4HZz8waY6XxlirWhfkwen10nL1GKIuEWL+RjZgKuZqDS+MumD2cOftYuhNpmU+MfNMR3D9n9Y2VDZJTgZajDWOBUrekh4Dsa8/tIBO9n8DevimUaY2AjPbvP93MhI4vsLVOAAzYvM5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Up8ZMfIp; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755074909; x=1786610909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/smX3GHjYtBpThREVOyuPUStG2BzCbDOiAFYJYi6Kc=;
  b=Up8ZMfIpG3XbNaKzWnqAXyK20QrS4rqHDo/sP4+Av3b+8XScWVDC08rL
   5idTLPLelR5pknUaMsU2OCQzv7uV3y88IBHu/q91NFP7jwEii5qkhWZXy
   OeBiE/f6qruCsBi5VqTVBLCkV0DlDbmbdWytQH4tZRl4lDkw4ZX6T5EF4
   7Q3f42oejXXzLxXJKfpYwUhGcm52/cOLWO7s3cbMzOUfwnkQLo0+L9M1+
   9sebloa8+AGOURFAm3jQKSL7uZDDidRooX1GLkAZOI0WL7yJOhizEa0O1
   C1yXQVj48by+nb/llEagPrHB60rmBATQy8mDMscK2Ugd409M0vtvC8N7A
   g==;
X-IronPort-AV: E=Sophos;i="6.17,285,1747699200"; 
   d="scan'208";a="515246079"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:48:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:18367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.146:2525] with esmtp (Farcaster)
 id dae87910-4c18-46bd-b32e-1944f016f0ca; Wed, 13 Aug 2025 08:48:24 +0000 (UTC)
X-Farcaster-Flow-ID: dae87910-4c18-46bd-b32e-1944f016f0ca
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 13 Aug 2025 08:48:24 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Wed, 13 Aug 2025 08:48:22 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <pmenzel@molgen.mpg.de>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next 1/2] igbvf: add lbtx_packets
 and lbtx_bytes to ethtool statistics
Date: Wed, 13 Aug 2025 17:47:48 +0900
Message-ID: <20250813084815.85188-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <9b44df93-acec-4416-9f32-f97d0bfaaa7b@molgen.mpg.de>
References: <9b44df93-acec-4416-9f32-f97d0bfaaa7b@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 13 Aug 2025 10:18:29 +0200, Paul Menzel wrote:=0D
=0D
> Dear Kohei,=0D
> =0D
> =0D
> Thank you for your patch.=0D
> =0D
> Am 13.08.25 um 09:50 schrieb Kohei Enju:=0D
> > Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX=0D
> > Packets/Octets loopback Count), but doesn't show the TX-side equivalent=
s=0D
> > (lbtx_packets and lbtx_bytes). Add visibility of those missing=0D
> > statistics by adding them to ethtool statistics.=0D
> > =0D
> > In addition, the order of lbrx_bytes and lbrx_packets is not consistent=
=0D
> > with non-loopback statistics (rx_packets, rx_bytes). Therefore, align=0D
> > the order by swapping positions of lbrx_bytes and lbrx_packets.=0D
> > =0D
> > Tested on Intel Corporation I350 Gigabit Network Connection.=0D
> > =0D
> > Before:=0D
> >    # ethtool -S ens5 | grep -E "x_(bytes|packets)"=0D
> >         rx_packets: 135=0D
> >         tx_packets: 106=0D
> >         rx_bytes: 16010=0D
> >         tx_bytes: 12451=0D
> >         lbrx_bytes: 1148=0D
> >         lbrx_packets: 12=0D
> > =0D
> > After:=0D
> >    # ethtool -S ens5 | grep -E "x_(bytes|packets)"=0D
> >         rx_packets: 748=0D
> >         tx_packets: 304=0D
> >         rx_bytes: 81513=0D
> >         tx_bytes: 33698=0D
> >         lbrx_packets: 97=0D
> >         lbtx_packets: 109=0D
> >         lbrx_bytes: 12090=0D
> >         lbtx_bytes: 12401=0D
> > =0D
> > Tested-by: Kohei Enju <enjuk@amazon.com>=0D
> =0D
> No need to resend, but I believe, you only add a Tested-by: tag, if the =
=0D
> person differs from the author/Signed-off-by: tag.=0D
=0D
Oh, I didn't know that. Thank you for the feedback.=0D
=0D
Since I want to resend the other patch[1] after updating as you pointed=0D
out, I'll resend this series as v2 including this patch without the=0D
Tested-by: tag.=0D
=0D
[1] https://lore.kernel.org/intel-wired-lan/20250813075206.70114-3-enjuk@am=
azon.com/=0D
=0D
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>=0D
> > ---=0D
> >   drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-=0D
> >   1 file changed, 3 insertions(+), 1 deletion(-)=0D
> > =0D
> > diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/e=
thernet/intel/igbvf/ethtool.c=0D
> > index 773895c663fd..c6defc495f13 100644=0D
> > --- a/drivers/net/ethernet/intel/igbvf/ethtool.c=0D
> > +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c=0D
> > @@ -30,8 +30,10 @@ static const struct igbvf_stats igbvf_gstrings_stats=
[] =3D {=0D
> >   	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },=0D
> >   	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },=0D
> >   	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },=0D
> > -	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },=0D
> >   	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },=0D
> > +	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc) },=0D
> > +	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },=0D
> > +	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },=0D
> >   	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },=0D
> >   	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },=0D
> >   	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },=0D
> =0D
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>=0D
> =0D
> =0D
> Kind regards,=0D
> =0D
> Paul=0D
=0D
Thank you for reviewing!=0D

