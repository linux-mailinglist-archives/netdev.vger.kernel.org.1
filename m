Return-Path: <netdev+bounces-105086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED390FA25
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40411C20C31
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14C18E;
	Thu, 20 Jun 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHtafr7z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B76365
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842383; cv=none; b=OQr2MPnaVUt0YlDVvnSzgK3EhP5Q4pf/Tv97Ejh2Sy2ngfe0hhOGdQbHjqSHHn/eyJtCBMCj1dzvitAEZ3tFSf74rjxe2QV5iZVzKgrBm+mqeLMYXXGkS6SeIAJvkMPYkUIpuk1zxfSpFhlfyNR1OY0C4VdIAQ7Hcpi1peRW4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842383; c=relaxed/simple;
	bh=cPsrnkKh+h7e5ODGDZsRFkE0TJGttYhgDdwirTlIk94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq8zk6ZKVqvBFEEUzdKtx5NXBkAlrjCbr/6CpFVCJT+AkLVHljoHz7KMTr8H66F/UTm6rlUHK0Sq4nsUuTNOb06zF4PiRfNNi9O31byprp3GskFUC3JOEJhdSf3kI/c7J5YEng8TtQXhUgHsX7zBhbq0Kzg1tHN1R4y50XmFYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHtafr7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDC9C2BBFC;
	Thu, 20 Jun 2024 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842382;
	bh=cPsrnkKh+h7e5ODGDZsRFkE0TJGttYhgDdwirTlIk94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHtafr7zzWnY/EpYA/DQuFCCa6pqx2qADNN5aYEcsXp1pGFILLiEByH3HtuG0bAze
	 bfA9KWd1ykPlhhcGBHrDJyUbiUQnEiBheQAxdHhVwjvdDbVTZjvg0dWqZYGlIXKkGV
	 PzJmJj9/PrvdWD0UGbfuhm+Sv9FLo8YEgGxuD8bN4PKz+JvnXo00P/iwcxHrozPap3
	 BBCw6prlMtyY42jpDwbsFCGAzIIm6pElxdfspLhZ1JLLdyuWFJEb9jKhQPeXH8W0i/
	 vp4TDWHCawlzRenkjQ7+CC0rmrNL5L/dLdc5f4OskzpDf42U8Busl2jVQHsUIh1aSh
	 VJkhyVkmkbshA==
Date: Wed, 19 Jun 2024 17:13:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 2/3] bnxt_en: Set TSO max segs on devices with
 limits
Message-ID: <20240619171301.6fefef59@kernel.org>
In-Reply-To: <20240618215313.29631-3-michael.chan@broadcom.com>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
	<20240618215313.29631-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:53:12 -0700 Michael Chan wrote:
> Firmware will now advertise a non-zero TSO max segments if the
> device has a limit.  0 means no limit.  The latest 5760X chip
> (early revs) has a limit of 2047 that cannot be exceeded.  If
> exceeded, the chip will send out just a small number of segments.

If we're only going to see 0 or 2047 pulling in the FW interface update
and depending on newer FW version isn't a great way to fix this, IMHO.

TCP has min MSS of 500+ bytes, so 2k segments gives us 1MB LSO at min
legitimate segment size, right? So this is really just a protection
against bugs in the TCP stack, letting MSS slide below 100.

For a fix I'd just hardcode this to 2047 or even just 1k, and pull in
the new FW interface to make it configurable in net-next.
-- 
pw-bot: cr

