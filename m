Return-Path: <netdev+bounces-184938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A41A97C08
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E043BF767
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998EC288A2;
	Wed, 23 Apr 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgYCvE63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555614286
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370961; cv=none; b=RWfWzlF/2CARms7kMA7cBBGZDxCVz1XAU9PlMlyZuvy6+PtfnfCEMxcz8/2fDxh0bkfSSWaBjBkrr8GgbpYmuC/jD8mf0eT8E2FpNQx0xa0J2rTYoYTdq9d94WMCyaWwUyBHnil/AvQBx5Zg1i6DwTXmf9XMZ9TzErUBW+zlFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370961; c=relaxed/simple;
	bh=DDBIaRd7/PYETMKxsfw80fEdg/3qTd4YC7ybdRiF3IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXdnOdvJ6fvgboAmjX8gvlvDY/fzd55+j881/QhkDu2+7D6KwGbGmdGGEGbuZ71ecxwTjG1Ak3o1OeOKX9fv9mt0vpypjemkqStSglWb8Nd4/NtdB3CfitOmHB5UJKXsp1hxkzXF2BTDexuqD7d2lKfl+Q+YIzOmwdqTn8m3cDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgYCvE63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A46C4CEE9;
	Wed, 23 Apr 2025 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745370960;
	bh=DDBIaRd7/PYETMKxsfw80fEdg/3qTd4YC7ybdRiF3IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UgYCvE63DpBhwexZaJb/qQBKqOVO+MaySxlUBNWjB37D+uleh84zteo6hp7rp3s2P
	 0psQ6vn+ou44LvatYSQAdEqPfXcbrII0WF3F476vHzJbkamxZYGRXhhtTtY1ASUcIV
	 8p4ELcy19cnRy6KnyV+mazkZRTulB6J3OKAEanHenEOdgG2iwDMNJvC2qx8QzqM+Ar
	 Y2nSdm+vAso70ZOxiq2ttbzwCiTxg5S5UmJAP4UFiMh8UjLvaXsnh/OS/KrpsBKgYz
	 AnjNvl0y4LZ9iManymFAaBgTri9rQ2+lMMugWwlu3HX3gcLuADzKLJ21/RzcY/4fUf
	 lEj5RNzaZTsyA==
Date: Tue, 22 Apr 2025 18:15:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
 horms@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 2/3] net: ibmveth: Reset the adapter when
 unexpected states are detected
Message-ID: <20250422181559.64b6e63f@kernel.org>
In-Reply-To: <20250416205751.66365-3-davemarq@linux.ibm.com>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
	<20250416205751.66365-3-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 15:57:50 -0500 Dave Marquardt wrote:
> Reset the adapter through new function ibmveth_reset, called in
> WARN_ON situations. Removed conflicting and unneeded forward
> declaration.

There's a schedule_work() added but neither cancel nor flush when
interface is shut down or removed, probably a bug :(
-- 
pw-bot: cr

