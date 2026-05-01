Return-Path: <netdev+bounces-283288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFzZDo4L9WmEHwIAu9opvQ
	(envelope-from <netdev+bounces-283288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71A4AF74F
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8255F3013737
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 20:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AB366061;
	Fri,  1 May 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QhlpVl1T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CD2EACEF;
	Fri,  1 May 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666951; cv=none; b=jIrs5O573kSvir6XTA9ps2015BGwkG1Ftyo4sD9y5MU0AxS37wTXV85A6dHE73VpXVtOvG3TEWQXmMjrYO60StyW0nNHvBp64z8mkD+yEFsyrfFnNEs+h8/psKBbBTGCUqZ36TM574KR6iFNv5Ig3RqhdK8TsAq0Xp2n92q4CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666951; c=relaxed/simple;
	bh=igR+pUQaD8NuaTzcTZl9INS3afQ7Mgsw6S7WL9l+Ue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmXcWPuIIfxQKPoHMrOSVjFqT99p0l49ULSXtpBvsm/Og/tEPqorG1f4cFI2VrKCBP9qOz0t1oXAsZ0bSjVB1EDKhUyZsE90clOSnuldGuVwUQcKSfhDBaGuQ9tRM5/sYZOBbg+GrEzyH3o6PXmvt6JUQtZ+NpJhyB44ehL2ZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QhlpVl1T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UaoQukG8/3m/kqFNc+N8A/oUZtIcpzTqAGxoeuhHRII=; b=QhlpVl1TweTTlpTbX5pCOYywvC
	yjbCjKNKnQ0m3aULTj1DSyZY5Khe4q8LRJWrbSHZ5b2///ibwDoGsWE5Un3p0B+cumaj0k5Nz+eXf
	BC3y0+Fcmbl61OY2dj8Vh11rOecE5BTa5IK6cz2idHsC7pF02Le3qXDVi16jg55O8PZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIuNQ-000sOX-5j; Fri, 01 May 2026 22:22:20 +0200
Date: Fri, 1 May 2026 22:22:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Message-ID: <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: BB71A4AF74F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283288-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

> +static int mmd2mms(int mmd)
> +{
> +       int ret = -EOPNOTSUPP;
> +
> +       switch (mmd) {
> +       case MDIO_MMD_PCS:
> +               ret = OA_TC6_PHY_C45_PCS_MMS2;
> +               break;
> +       case MDIO_MMD_PMAPMD:
> +               ret = OA_TC6_PHY_C45_PMA_PMD_MMS3;
> +               break;
> +       case MDIO_MMD_VEND2:
> +               ret = OA_TC6_PHY_C45_VS_PLCA_MMS4;
> +               break;
> +       case MDIO_MMD_VEND1:
> +               ret = ONMPH_OA_TC6_VEND1_MMS12;
> +               break;
> +       default:
> +               break;
> +       }
> +       return ret;
> +}

So you seem to be compliant with the standard. I've not seen anything
use MDIO_MMD_POWER_UNIT so not having that should not be an
issue. MDIO_MMD_AN is used by a number of PHYs, but i assume yours
does not.

802.3 C45 says that if a register does not exist, it should read
0. What would happen if a read was made to
OA_TC6_PHY_C45_AUTO_NEG_MMS5, rather than returning EOPNOTSUPP?

Table 6 says nothing about MMD 30, which you map to 12. 10-15 are
defined as vendor specific, so that is O.K.

But can we simply this. Add something like

void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
{
	tc6->vend1_mms = mms;
}

and make oa_tc6_get_phy_c45_mms() look at its value?

	Andrew

