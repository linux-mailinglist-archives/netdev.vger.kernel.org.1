Return-Path: <netdev+bounces-216310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876FB3311E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C9C3B8C9A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258841B5EB5;
	Sun, 24 Aug 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZTYC2LLd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2E111A8;
	Sun, 24 Aug 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048579; cv=none; b=WYWEnZpWna/KuxyFnr55w6BJBtrxYcCM7QAYRsnmUtsFTXPNk64XK0aU0nogFAj+MEhePcsYy8WJwAoBTQUDPGjcjmilXUbkUeQDm0zPJlDKtkTR54YO6zBFv5yjXYRDfin8rdHqjuFsyZOZtyGj7TOo/pDqoM5V4jMl87fuLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048579; c=relaxed/simple;
	bh=G2WnBlkD29xfFF7rlSWpoufymyzsHPV2Eism0iwubIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxCOjlvysKBrFKK5hWzIgetLWQlxTHY6LDxKCSVbSpk9kUl+tagI7Nz4tmrps1oVwyf2Tz/QNR2K5JnU0XdKiH3iXhvuDpOWebG7F6TD/l0VvUJuLK92Wf5HkTjuNtr6BZFm1yeeEfY3zxLOs5o2Cy2aUI7oIjCiS0pL+FmKttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZTYC2LLd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ebce3qTJJl9aY/XMrQEQpthtDw+h3aS8chg9ab8xgGs=; b=ZTYC2LLdWSUpmFSgefTT8AG14t
	UhTANmgfLT+tHaWF84bTwdpsnGCnPJAVQjqUbMW6070hukqrovKqJXzCi3cFyGYtQF3LLpc7bt6It
	hCJcuCFyG38AoVM1vxrkenvYxFOVqYLRaYySKpFi9JA8QWjLeBZP0EIf1n4itwswWNsM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqCRJ-005q8B-Kg; Sun, 24 Aug 2025 17:15:25 +0200
Date: Sun, 24 Aug 2025 17:15:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <809527f7-c838-4582-89cb-6cb9d24963dd@lunn.ch>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
 <C2BF8A6A8A79FB29+20250823015824.GB1995939@nic-Precision-5820-Tower>
 <f375e4bf-9b0b-49ca-b83d-addeb49384b8@lunn.ch>
 <424D721323023327+20250824041052.GB2000422@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424D721323023327+20250824041052.GB2000422@nic-Precision-5820-Tower>

On Sun, Aug 24, 2025 at 12:10:52PM +0800, Yibo Dong wrote:
> On Sat, Aug 23, 2025 at 05:17:45PM +0200, Andrew Lunn wrote:
> > On Sat, Aug 23, 2025 at 09:58:24AM +0800, Yibo Dong wrote:
> > > On Fri, Aug 22, 2025 at 04:43:16PM +0200, Andrew Lunn wrote:
> > > > > +/**
> > > > > + * mucse_mbx_get_capability - Get hw abilities from fw
> > > > > + * @hw: pointer to the HW structure
> > > > > + *
> > > > > + * mucse_mbx_get_capability tries to get capabities from
> > > > > + * hw. Many retrys will do if it is failed.
> > > > > + *
> > > > > + * @return: 0 on success, negative on failure
> > > > > + **/
> > > > > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > > > > +{
> > > > > +	struct hw_abilities ability = {};
> > > > > +	int try_cnt = 3;
> > > > > +	int err = -EIO;
> > > > > +
> > > > > +	while (try_cnt--) {
> > > > > +		err = mucse_fw_get_capability(hw, &ability);
> > > > > +		if (err)
> > > > > +			continue;
> > > > > +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > > > > +		return 0;
> > > > > +	}
> > > > > +	return err;
> > > > > +}
> > > > 
> > > > Please could you add an explanation why it would fail? Is this to do
> > > > with getting the driver and firmware in sync? Maybe you should make
> > > > this explicit, add a function mucse_mbx_sync() with a comment that
> > > > this is used once during probe to synchronise communication with the
> > > > firmware. You can then remove this loop here.
> > > 
> > > It is just get some fw capability(or info such as fw version).
> > > It is failed maybe:
> > > 1. -EIO: return by mucse_obtain_mbx_lock_pf. The function tries to get
> > > pf-fw lock(in chip register, not driver), failed when fw hold the lock.
> > 
> > If it cannot get the lock, isn't that fatal? You cannot do anything
> > without the lock.
> > 
> > > 2. -ETIMEDOUT: return by mucse_poll_for_xx. Failed when timeout.
> > > 3. -ETIMEDOUT: return by mucse_fw_send_cmd_wait. Failed when wait
> > > response timeout.
> > 
> > If its dead, its dead. Why would it suddenly start responding?
> > 
> > > 4. -EIO: return by mucse_fw_send_cmd_wait. Failed when error_code in
> > > response.
> > 
> > Which should be fatal. No retries necessary.
> > 
> > > 5. err return by mutex_lock_interruptible.
> > 
> > So you want the user to have to ^C three times?
> > 
> > And is mucse_mbx_get_capability() special, or will all interactions
> > with the firmware have three retries?
> 

> It is the first 'cmd with response' from fw when probe. If it failed,
> return err and nothing else todo (no registe netdev ...). So, we design
> to give retry for it.
> fatal with no retry, maybe like this? 
 
Quoting myself:

> > > > Is this to do
> > > > with getting the driver and firmware in sync? Maybe you should make
> > > > this explicit, add a function mucse_mbx_sync() with a comment that
> > > > this is used once during probe to synchronise communication with the
> > > > firmware. You can then remove this loop here.

Does the firmware offer a NOP command? Or one to get the firmware
version?  If you are trying to get the driver and firmware in sync, it
make sense to use an operation which is low value and won't be used
anywhere else.

	Andrew

