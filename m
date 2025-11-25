Return-Path: <netdev+bounces-241475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E385C843C0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 504144E1AD8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D52C3245;
	Tue, 25 Nov 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GpG5SoZL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B31DF75A
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063054; cv=none; b=ulXwQ0PRulZWzNEaU6w68B0QMtK8Ue7mG9kelogo5Tw+qtQtNtCoP9E+tJ0xdMAirQ/Ru5pm9p3yWqud2LmpSXHgkWv/rNntoM388xlrxzQ/7o1D2lJ1/W+UW4Li3IrQ6FSp1++K4NmZlgwczqTOdrST2TmHJIfsmKY4VvVRXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063054; c=relaxed/simple;
	bh=01xvl8nub52BXwOAuZs9GJxMLSf40a0zqaG6x0feemQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QywsYO4tSUIRCE9QE2uaUKlM7OPOPgzAF0EONCTRPindEyi9aKNhVVly+OYjGJIrN8D2/GHS5alGUAGuMxms8GmjbEdWagIFDQqmA1jqkxElCYPKhK6a9k2/pFVjJHkoG5Lm8pMF7TfCFVRUqLG9Vgxn27p0MbCmpsvNDSeRRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GpG5SoZL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 559FF201D5;
	Tue, 25 Nov 2025 10:30:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCTMJF750sOn; Tue, 25 Nov 2025 10:30:50 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BDA1020892;
	Tue, 25 Nov 2025 10:30:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BDA1020892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764063050;
	bh=+hv8FDRZ1a+Nxn/L5MdnfuXGMZS0NOF1QR3Pe4LhLCE=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=GpG5SoZLuDDa/AuLwIyXQ2C2IA2wSTz9BclH9lonG2iIxtn8ewIWCwRbjaf9/D/pB
	 up/VG5g6ujAYIqxx2HqcDJ9ZqKX5tr+rpWKKflQm3HX5PLEjlqhsjk4Sikd4cv32H/
	 VYD5d5hlCkat5a7YTDtzlu5AvIEAai0vvRI4tu6uRkbTm1uw2zBzUOWQ/Hx58uVTDb
	 0uiHiH1YdYTBwQe/+eV/eM6y2pjYVT7Mmjk1QctG81oIAJKkIoHDuJOEcHvOA/rmma
	 y86Ic1MNfGkIEPn1TUiyCBwsizuQ06MMtuO87Dwx+xA/s1R+qoZXLhLm2wrHHJ0RI/
	 mksm93KjQ4SZA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:30:50 +0100
Date: Tue, 25 Nov 2025 10:30:43 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 5/5] xfrm: check that SA is in VALID state
 before use
Message-ID: <e9209b246d7af0a893e017ac56a8594f3ab658a3.1764061159.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-02.secunet.de (10.32.0.172)

During migration, a state/SA may have been deleted or become invalid.
Since skb(s) may still hold a reference to this deleted state, it could
be reused inadvertently. Using a migrated SA could result in reusing
the same IV for AES-GCM, which must be avoided for an output SA.

Add a check to ensure the state is in XFRM_STATE_VALID before use.
This check is useful for both output and input data paths.

Call chain:
  xfrm_output_one()
    xfrm_state_check_expire()
      if (x->km.state != XFRM_STATE_VALID) ---> new check
         return -EINVAL;
      encapsulate the packet

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 91e0898c458f..c9c5a2daa86f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2265,6 +2265,9 @@ EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
+	if (x->km.state != XFRM_STATE_VALID)
+		return -EINVAL;
+
 	/* All counters which are needed to decide if state is expired
 	 * are handled by SW for non-packet offload modes. Simply skip
 	 * the following update and save extra boilerplate in drivers.
-- 
2.39.5


