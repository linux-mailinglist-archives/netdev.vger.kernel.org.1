Return-Path: <netdev+bounces-171872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C5A4F2E5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647E17A3E54
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676D481DD;
	Wed,  5 Mar 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcLvWlZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F214C8F
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135454; cv=none; b=HbqPIxWHHjBEm4QvBFqvoueKx39K/RRfguOlcMmJKdZ+QGjhSGZfTHf1SsEmzfY7OKy7t3dzO498GLy81ehU3IeZiGFQsuB/oqvnnZD9qxUmz6auxkcAmTCGlJEc4870FW9QopQJSLitD+En2kID6/2r8oYuok9YEx+zqOhDhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135454; c=relaxed/simple;
	bh=Pgd52k93buyxmzppqapqAbP0Fe2Q54VC3fmaW9oJ9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZZ4VMR41YKDSVbwZewE8FBR5U3P83TFevLzug8LDlRKqiM1KsFdnR5FyR4wNIsfGMAWpss+OLug4aTxXToXdFo3PTQDdTTnmpfYg2fRB3+EBArmoLqo49UwIPgIGtMQLsTXZ7jtlCrmPJ+d78g8yb9yICzXgWvhlZQFfrlN+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcLvWlZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8229FC4CEE5;
	Wed,  5 Mar 2025 00:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741135453;
	bh=Pgd52k93buyxmzppqapqAbP0Fe2Q54VC3fmaW9oJ9Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcLvWlZlokyjmd45emiuz6W2iwUVV/UB+Gzu076ZMIvm7tFbxTDC3QPPCAOarI1HI
	 tL2b7kQrvqPrv8DISQUFN4nU8HIC9y8Mr2wOAGjBBPsPhrJ0yDnrr6A2knA0EZMK5Y
	 DIL/sXsA5z41ZWENg6h+YdhviqdxN9f2cpNdCodGQaABpT+vHWZZQI9PabECilfPcd
	 6GWjjaXejblJmirVpatgIp9joVh67NM+95fMiRzLWOl+tK/bF4DMI/7Hi5lT3+cGTE
	 DpqLJgEjOqNIJOlAMpiZEciufsVbj+LbbzdcZ2wNWqshRgPinFkOt5PUxNjLPYay4d
	 iMbqZJbcQek2w==
Date: Tue, 4 Mar 2025 16:44:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250304164412.24f4f23a@kernel.org>
In-Reply-To: <b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
	<20250228161908.3d7c997c@kernel.org>
	<b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 00:38:41 +0000 Allison Henderson wrote:
> > I'm guessing the comments were added because checkpatch asked for them.
> > The comments are supposed to indicate what this barrier pairs with.
> > I don't see the purpose of these barriers, please document..  
> 
> Hi Jakob,
> 
> I think the comments meant to refer to the implicit memory barrier in
> "test_and_set_bit".  It looks like it has assembly code to set the
> barrier if CONFIG_SMP is set.  How about we change the comments to:
> "pairs with implicit memory barrier in test_and_set_bit()" ?  Let me
> know what you think.

Okay, but what is the purpose. The commit message does not explain 
at all why these barriers are needed.

