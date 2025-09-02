Return-Path: <netdev+bounces-219061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA5B3F980
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96863B6929
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AE2EA173;
	Tue,  2 Sep 2025 09:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1572EA14A;
	Tue,  2 Sep 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803747; cv=none; b=hTTvCKIfiC8Y5F+0sCBEibKog0PlTREHPmX2a4NpEQqgjY4sY0HFquwij08nU7FSY8UCBrtn9UdCNgLIyoh4Nuhzxtl+rdaHja+i/AQDUH+a2YsksUi3diQ1zTd4ShLUxyHEdtR1bv7PM76BME1toEOPJmqBBU/MI4oBnWXldHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803747; c=relaxed/simple;
	bh=Qo8o4X1vIJhxz9EjQvGCY/ZX8gplKQ/64Th+DZCktBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8iGFh3OIXuGwKTa4/3jFL5xVMZ1A1XprtYgh3veEsk8uikMhTgtPO+M6XJw29iHc2Ag/8+7oUF35z5wz5+9Qp08iX+fJCP0JBwfFIgMl0I+S24mAmphBWwF87O7KdYWp+2DJcw6Ak7/mYn1h7oO5useNfUyli8bAes1HZp5Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509021702091558;
        Tue, 02 Sep 2025 17:02:09 +0800
Received: from localhost.localdomain.com (10.94.12.93) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 2 Sep 2025 17:02:09 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <horms@kernel.org>, Antonio Quartulli <antonio@openvpn.net>, Sabrina
 Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: PATCH v2 Re: Re: [PATCH 1/1] ovpn: use kmalloc_array() for array space allocation
Date: Tue, 2 Sep 2025 17:00:50 +0800
Message-ID: <20250902090051.1451-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250901112136.2919-1-chuguangqing@inspur.com>
References: <20250901112136.2919-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259021702099217d4ed3cb39d2b8944c47b299f51f8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

v1 -> v2:
Unnecessary parentheses have been removed and line alignment has been adjusted to 80 characters in width.

> 
> On Mon, Sep 01, 2025 at 07:21:36PM +0800, chuguangqing wrote:
> > Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
> > allocation and overflow prevention.
> >
> > Signed-off-by: chuguangqing <chuguangqing@inspur.com>
> > ---
> >  drivers/net/ovpn/crypto_aead.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ovpn/crypto_aead.c
> > b/drivers/net/ovpn/crypto_aead.c index 2cca759feffa..8274c3ae8d0b
> > 100644
> > --- a/drivers/net/ovpn/crypto_aead.c
> > +++ b/drivers/net/ovpn/crypto_aead.c
> > @@ -72,8 +72,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct
> ovpn_crypto_key_slot *ks,
> >  		return -ENOSPC;
> >
> >  	/* sg may be required by async crypto */
> > -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> > -				       (nfrags + 2), GFP_ATOMIC);
> > +	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2),
> sizeof(*ovpn_skb_cb(skb)->sg),
> > +					     GFP_ATOMIC);
> 
> I think this could benefit from:
> a) Removal of unnecessary parentheses
> b) Line wrapping to 80 columns wide or less,
>    as is still preferred for Networking code
> 
> (Completely untested!)
> 
> 	ovpn_skb_cb(skb)->sg = kmalloc_array(nfrags + 2,
> 					     sizeof(*ovpn_skb_cb(skb)->sg),
> 					     GFP_ATOMIC);
> 
> >  	if (unlikely(!ovpn_skb_cb(skb)->sg))
> >  		return -ENOMEM;
> >
> > @@ -185,8 +185,8 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer,
> struct ovpn_crypto_key_slot *ks,
> >  		return -ENOSPC;
> >
> >  	/* sg may be required by async crypto */
> > -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> > -				       (nfrags + 2), GFP_ATOMIC);
> > +	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2),
> sizeof(*ovpn_skb_cb(skb)->sg),
> > +					     GFP_ATOMIC);
> 
> Likewise here.
> 
> >  	if (unlikely(!ovpn_skb_cb(skb)->sg))
> >  		return -ENOMEM;
> >
> 
> --
> pw-bot: changes-requested


chuguangqing (1):
  ovpn: use kmalloc_array() for array space allocation

 drivers/net/ovpn/crypto_aead.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.5


