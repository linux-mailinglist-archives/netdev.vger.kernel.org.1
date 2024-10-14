Return-Path: <netdev+bounces-135196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E999CB93
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA0C1C21788
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE71A0B07;
	Mon, 14 Oct 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4lOD80bw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31471A726B
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912600; cv=none; b=gkcOxipZXeKvd5fbVHw19VT+S3Ofc5dU3n/i+Vo6Ys7GevjylG9hcBMRm8oFp/kWxohpGJHGRV4C2V6zjPspSrxwpPMWLAOgV4jTjKB0PbEZl79oRH0VTGc7BgLBi2wNSQ+AlItFvPJUC0e+KK9ALjfva+VWAY420u9dTA6Mx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912600; c=relaxed/simple;
	bh=jrmza/8m6NVkPAtqGDzYH66dUcYa1DiOiP6SpnQGKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5KPzOYjImlEqYVdPi05Mwqz9oF42D0nLCpCxrUBrwQ8JCTn4zwJVB/sQ4qnPM8FKO59OMMdtzn5JMcAL5emAbF4DpyQjECg5zVZoIDEbz1tqA6f/lxs35ARn6jKg4esN6HxgsXXPI0rDny2F5lGD+cK8vXt+gCPz1aAJnJCd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4lOD80bw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tLoeIYjJblCXeoCoIZm61CRPMFyzayogWLkcYe+8+OQ=; b=4lOD80bwNAiY2Uyw4Px0EL6bLa
	C1+Grqd15PW27uY85JK1MMMcj+FkdEGLVFoKRvVuQXzvoH7lO8JZB9AyJC6h5P9EKAX8anegEtjCe
	yuj0HWfznapA69bNCyc1kxY9dNC1V8rdio0wvrcDI+Nx2DoyYqpTawTB6212cR8bZFT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0L92-009vb7-Hg; Mon, 14 Oct 2024 15:29:56 +0200
Date: Mon, 14 Oct 2024 15:29:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix errors in max_vid and port
 policy for 88E6361
Message-ID: <5cce39c3-0ab6-46e6-881c-540efc5347ee@lunn.ch>
References: <20241014045053.9152-1-peter@rashleigh.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014045053.9152-1-peter@rashleigh.ca>

On Sun, Oct 13, 2024 at 09:50:53PM -0700, Peter Rashleigh wrote:
> The 88E6361 has two VTU pages (8192 VIDs), so fix the max_vid definition.

Hi Peter

Is 88E6361 correct?

> 
> Also fix an error in mv88e6393x_port_set_policy where the register
> gets an unexpected value because the ptr is written over the data bits.

Please make this two patches, since you fixing two things. Each patch
needs a Fixes: tag.

    Andrew

---
pw-bot: cr

