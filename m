Return-Path: <netdev+bounces-79651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88A87A63A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBAD1C20FA6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF673D977;
	Wed, 13 Mar 2024 10:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CA3EA6F
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327484; cv=none; b=oSd6jZ8PW274mRo67BhNPxyg5Y2tcBr60Oku8RC8bQ7L4oFtdn6pWVVCceZd0YG/BXZYlK6GTE7iTNsBKBJJCcf7so7TDnT8Ohn46L2uN6vx+1JHDazjjvidc3zfGapd2eA22Nzbu6nVBJMUVTpsOo4UPoCVNsOfKE6JSTF49zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327484; c=relaxed/simple;
	bh=VMs2zwGpER9F1FB7kmcZHWQdmNOaxDobVGylEeQAaRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2zyiTc55qUcummUjG2+m7bAd9Sdv/q7vdAa7d24WdEqunzsBWQZyQ3b8lSiUAwrGudJek0hyrd9vgWClKSckyFXgN2+OsS1idwm2uM8ULE1XZoZNkQ50tPPH+enVSa6UJFjbUkhYP2HY516VbzlVIPLg72dCHDlWYgfYP87Uy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 895A161E5FE04;
	Wed, 13 Mar 2024 11:57:34 +0100 (CET)
Message-ID: <1fa71d41-dc3c-4c1a-8b6e-70aa4c9511c1@molgen.mpg.de>
Date: Wed, 13 Mar 2024 11:57:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix vf may be used
 uninitialized in this function warning
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20240313095639.6554-1-aleksandr.loktionov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240313095639.6554-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Am 13.03.24 um 10:56 schrieb Aleksandr Loktionov:
> To fix the regression introduced by commit 52424f974bc5, which causes
> servers hang in very hard to reproduce conditions with resets races.
> Using two sources for the information is the root cause.
> In this function before the fix bumping v didn't mean bumping vf
> pointer. But the code used this variables interchangeably, so staled vf
> could point to different/not intended vf.
> 
> Remove redundant "v" variable and iterate via single VF pointer across
> whole function instead to guarantee VF pointer validity.
> 
> Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v1 -> v2: commit message change

Thank you very much. No need to resend, but I find it also always useful 
to have the exact warning pasted in the commit message.

[…]

> ---
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 +++++++++----------
>   1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

