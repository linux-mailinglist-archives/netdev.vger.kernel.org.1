Return-Path: <netdev+bounces-223704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD8B5A180
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AD7485EAE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E642DA74C;
	Tue, 16 Sep 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wkjh3SWJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223127F006;
	Tue, 16 Sep 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051261; cv=none; b=aEedoyqsJFLJup53LJj7UbXPIFu4XmqqSN2vCCQv69aXoJANz/KdeFGpW40IH+EZVz7yac9itsyAiteFnnWYbqU2JF5yHUhAuLl0ADJiIA/eefkFDSK3nLDpJEGk87F+LBw+vH64PKvT9mBpcoTWBH+kqp6fSnUtsKuB/XAKoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051261; c=relaxed/simple;
	bh=btjlquJZgN4cfS3dp6NZPpiz13/EggiO0pSdV9kExQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTVoB9vebuvfseBf5eVUiqxiQREa12qB7eB2s3xLDqHuOTRTGNATBhvnPsUIBavHxDVjgoJ0RoAVF+6TWDmYI2MagtRPXAEzf3nZrxqrUIqnZU1HtKZoZfj67clIJrMqZtU/BF5p9RKkxDY9XZn1hO94PeM9qVtUlZ2hxq5AGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wkjh3SWJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DirpkGByuFZfnnqnuYZc8fUxpUvQJF3y+mZitXGzjPU=; b=wkjh3SWJtut/oefauPN+WQTgpL
	fwRI5OHhy7A2arc4MRTDdvSjCDuTx1m3EDlvtahIWysgdVB06IIb3u4pJlqYApEp3wd7zwxH1uOKN
	qiEO/54r8kw+rAkA03grxvlaiBf8xpfDRARPuO7Z6qXkz+qLL143nvG9x4NrNyp2bUgc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uybQm-008bS6-3R; Tue, 16 Sep 2025 21:33:36 +0200
Date: Tue, 16 Sep 2025 21:33:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <5a942120-fe95-4d6a-a2cf-ef832f65343e@lunn.ch>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-4-dong100@mucse.com>
 <7d4olrtuyagvcma5sspca6urmkjotkjtthbbekkeqltnd6mgq6@pn4smgsdaf4c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4olrtuyagvcma5sspca6urmkjotkjtthbbekkeqltnd6mgq6@pn4smgsdaf4c>

> > +	if (fw_req != 0 && fw_req != hw->mbx.fw_req) {
> > +		hw->mbx.stats.reqs++;
> > +		return 0;
> > +	}
> > +
> > +	return -EIO;
> 
> Only a suggestion: Might it be clearer to flip the cases and handle the if
> as error case and continue with the success case?
> 
> if (fw_req == 0 || fw_req == hw->mbx.fw_req)
> 	return -EIO;
> 
> hw->mbx.stats.reqs++;
> return 0;

That would by the usual pattern in the kernel. It is good to follow
usual patterns.

> > +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 req;
> > +	u32 val;
> > +
> > +	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> > +	req = FIELD_GET(GENMASK_U32(15, 0), val);
> 
> Why not assign the values in the declaration like done with mbx?

Reverse Christmas tree.

	struct mucse_mbx_info *mbx = &hw->mbx;
	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
	u16 req = FIELD_GET(GENMASK_U32(15, 0), val);

This is not reverse christmas tree. Sometimes you need to put
assignments into the body of the function.

	Andrew

