Return-Path: <netdev+bounces-122870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8419962EBA
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B2F1C21C8B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC31A7074;
	Wed, 28 Aug 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLIkMJg7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10D1A706C
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866983; cv=none; b=uWBWPErnS2FNtKeOY/7sLtsJ9HpWSwKQwzyMGb/KGxn0Rsm7HwlQDLVpEPYNaiukvqSDfx0hX9VtDCNoq/rxL6FbxTWkLD+J4zEcPBevF1K95eKIznKPA89mVlbXcmkCtsePnvEEfJk5KeZW1VbA+08nBpL2ebI0nk3TEGl+yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866983; c=relaxed/simple;
	bh=SrcVjb8q5zY3iIzdaeioenvqGmh/ZGiLHHAu61Y8atQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd5c38UAUjp6H53LX5uhsbYdC++wO57FYqghDruqAp2HxPtMmKbbt4NP0hSSzACp4NI6I21Ij83tNlC3xxhe02cVHAEHng5XPFKgOTyMhbqtHFjfSxcIzQs2mlmCzxIOxx0AsUgAmluytkcFVDXhrc3d6Ih9jsjP35UjodTIVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLIkMJg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3258C4CEC4;
	Wed, 28 Aug 2024 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866983;
	bh=SrcVjb8q5zY3iIzdaeioenvqGmh/ZGiLHHAu61Y8atQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZLIkMJg7oxLgF2bV541SP0dTS4HOkzBU/HMzVgxq9VB/jXbbDeTytBHScKExW8VwL
	 DkYcMJ5CtWbAE8jIz7RhqPB0RQP4rfk/z4vBrX2kpvrKeIWj+6ZdMDq3KtaYuu31oo
	 UQjGhJRdyUYo3ljYOaVanOBZNSnop0ecBvGww70dv0t6+D/fd+BTTvyY2HLnHGuTDm
	 ocLR5jibd9ZZxyPiwiRn5JZCVVaZ1wn8k203XhNHZ7oW9oMsnrJdxPkyVy2TqSXXbc
	 BIqCal/3oMlbCoUDRkol15H8O5MVL2EZoRKzm0tOs9LcRFCLGY4QyzIFSngAXs7697
	 WChCyKbb9Xfkg==
Date: Wed, 28 Aug 2024 10:43:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
Subject: Re: [net-next, v2 2/2] selftests: add selftest for tcp SO_PEEK_OFF
 support
Message-ID: <20240828104301.3bc69271@kernel.org>
In-Reply-To: <d47f131f-2bb4-4581-a3cf-ecc2d4e215e9@redhat.com>
References: <20240826194932.420992-1-jmaloy@redhat.com>
	<20240826194932.420992-3-jmaloy@redhat.com>
	<20240827145043.2646387e@kernel.org>
	<d47f131f-2bb4-4581-a3cf-ecc2d4e215e9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 12:24:48 -0400 Jon Maloy wrote:
> On 2024-08-27 17:50, Jakub Kicinski wrote:
> > On Mon, 26 Aug 2024 15:49:32 -0400 jmaloy@redhat.com wrote:  
> >> +}
> >> +  
> Does this require a re-posting?

Yes, as indicated by patchwork status of the series.

> > nit: extra new line at the end here, git warns when applying
> >
> > BTW did someone point out v6 is missing on the list? If so could
> > we add a Link: to that thread?  
>
> I don't understand this question. v6 of what?

The Internet Protocol? :)

Rephrased:

  Did someone point out on the mailing list that the support for
  .set_peek_off is missing for TCPv6? If so could you add a Link: 
  tag pointing to that thread?

