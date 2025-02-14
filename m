Return-Path: <netdev+bounces-166514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8FA36424
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06417A23F7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940D267AEB;
	Fri, 14 Feb 2025 17:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC8267706
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553150; cv=none; b=jg1DtUUDyMEayRkTtBs1x6DlIgLl+2FQx9h5KhEdmE8dRdMUSJczKk1L24OSFpso/fRttimR0fT+3nnhyjIjDhA0ZBJZ33eOoejcd1AjVTYXhKVKf/BIfkI+LL7BKPWVQTvfqmy8qlAIDQkzMJeddormfUfIrqqrBD+bEr19fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553150; c=relaxed/simple;
	bh=p4vP18wp2b9vouSv8sBf2Lb3K/dssY4LCr/9/FDOvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQRSB444OW1TKumtxmWc92U3lytjTzil1pUy4c2up8Wk8EQeNZ3coTuYyM7zWO5J1LE9AACvcE39uSuHwpX39VRbjmrz0HdZF70LONptJ3G3LgtyNBPKGBIW6vgM5EXMa0jKjqe16cffknDdiAs2ltJkhWhv6AvlaXT0HZjec2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51EHCJ7s008258;
	Fri, 14 Feb 2025 18:12:19 +0100
Date: Fri, 14 Feb 2025 18:12:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: ??? <jaymaacton@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Question about TCP delayed-ack and PUSH flag behavior
Message-ID: <20250214171219.GA8209@1wt.eu>
References: <CAPpvP8+0KftCR7WOFTf2DEOc1q_hszCHHb6pE2R-bhXMOub6Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpvP8+0KftCR7WOFTf2DEOc1q_hszCHHb6pE2R-bhXMOub6Rw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 14, 2025 at 12:03:17PM -0500, ??? wrote:
> Hi netdev,
> 
> When tcp stack receives a segment with PUSH flag set, does the stack
> immediately send out for the corresponding ACK with ignoring delay-ack
> timer?
> Or regardless of the PUSH flag, delay-ack is always enforced?

It depends, it's possible for the application to force a delayed ack
by setting TCP_QUICKACK to zero. This is convenient for web servers
that know they respond quickly and can merge this ack with the
response to save one packet.

Willy

