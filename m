Return-Path: <netdev+bounces-197279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33147AD7FF6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2D63A324A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0F1B424D;
	Fri, 13 Jun 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNQhkDjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3717A319
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776686; cv=none; b=jP2AJwCRsImxiC4YdKFQ6gn61ck6x7PAJvKC9Sq4MWleXY8H3v9sV+tSlIH/KJm4eK3r8d9FvH50GlZasDuWouJc+/bNguk8GDt9k33bsk3KIRTkqPmEToRY91MSqeANQ8Mr+yGeBeVwR7teCRup6RIeE3Ptyfv5DzMUKC80ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776686; c=relaxed/simple;
	bh=uEmQLpCMHNjmYj4Qa76+yoYCEyL1a+0lJNg8mzuh1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9L+9pJhjEJmk2Zd1oSOBy0YwsbnwwJX4FDY6+g+5P7Bo3OWkSMJnQy+os6/gNO453zL7KzQNzdI6+dZwq1u3oK2OOtJuyDlwZEJnUrGTpQE7KL9kWGHFdkhBdkLXuXk540qNhfufgkxM2N6UJeVBrufp6bO319SynDpALyzB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNQhkDjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A46BC4CEEA;
	Fri, 13 Jun 2025 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776685;
	bh=uEmQLpCMHNjmYj4Qa76+yoYCEyL1a+0lJNg8mzuh1RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNQhkDjM9PDitCoxz692FbjnXiKWzXqcYGUcFFfRzoFXza013edtqLSvrsOt5xm2y
	 smp3auBkhe7oAqnjAWtWAtyYIkZgJFV5YWPD3TxCwEWKa1f97S5DoavOtJsEbZyPYJ
	 Ms2Lq6hwijCJtAXqr0iu9AhTSVhgYhiQ0yg/XoY9SSh1RJE8s+JZ1vK9TqH7Nsv4Op
	 hNu2M7gKosWwZEOBF03dNCOz9qnS3RahoxhHpHRxT2EVWaHikRXDlS7QA/hfWaQx2I
	 mgHVFZ0EJzZvv43UkYiR+Wv3SM6a22Mxxi3cWpXJHeI8v7jejX3+93hk2aoVmYvuR9
	 K2G7uFaRkk1fw==
Date: Thu, 12 Jun 2025 18:04:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC net-next 4/6] eth: bnxt: support RSS on IPv6 Flow Label
Message-ID: <20250612180444.5767aeec@kernel.org>
In-Reply-To: <CACKFLin1Y=XTJcWQQwR=aDnpEvjdYVYaKgJZDAYGQvWzTx=gsg@mail.gmail.com>
References: <20250609173442.1745856-1-kuba@kernel.org>
	<20250609173442.1745856-5-kuba@kernel.org>
	<CACKFLin1Y=XTJcWQQwR=aDnpEvjdYVYaKgJZDAYGQvWzTx=gsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 17:11:18 -0700 Michael Chan wrote:
> > @@ -1728,6 +1739,13 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
> >                         rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> >                 else if (!tuple)
> >                         rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> > +
> > +               if (cmd->data & RXH_IP6_FL)
> > +                       rss_hash_cfg |=
> > +                               VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;  
> 
> Just a quick update on this.  The FW call fails when this flag is set.
> I am looking into it.

Thanks for the update! FWIW I'm doing the refactoring to add netlink
support as requested by Andrew:
https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/
There's 40 drivers to convert so even if it goes smoothly I wouldn't
be able to repost for another week.

