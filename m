Return-Path: <netdev+bounces-77354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB718715E2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F8B1C212DA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE74595D;
	Tue,  5 Mar 2024 06:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFB45BFB
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620210; cv=none; b=TzAhcW2bXIQ4OhNDo6oyXiknZqhKouAiOiPtLjRIzaenODhFAz5+SJ/gTgma9APBehm63azlLlHcbLx87OWTQ4pHx/H+PJftRZcKTCVubdE81lcShcgBGOq+HKN8A67E8fsBoh63PtUGOYEXhHvftLP1MlAcBk/WGVvfcqyf24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620210; c=relaxed/simple;
	bh=q+QZ46RO4QmB/AvtS3moZU45Ta77P+v7tsIR4gVhP5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHw0i1EGbSVqu22d9dRulU0zTzM1LRrG3twU5Zk8SRnwa7ZSzRoQhjLtwiBp/SuACKj/lsSxwRkVRKkg52y7azx70QkVIPewCyuOqf9F6O2JLyV1oOO7qaU7A7QwITO+vG4HWO/WdbYL9wAenTQYj3NsTFcHnZyYxECtYQcAbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af0e0.dynamic.kabel-deutschland.de [95.90.240.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D16F61E5FE01;
	Tue,  5 Mar 2024 07:28:58 +0100 (CET)
Message-ID: <38f55ddc-a991-45e5-b32e-941ab7f3c0bc@molgen.mpg.de>
Date: Tue, 5 Mar 2024 07:28:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix bug with suspend
 and rebuild
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Robert Elliott <elliott@hpe.com>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240304230845.14934-1-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jesse,


Thank you for your patch.

Am 05.03.24 um 00:08 schrieb Jesse Brandeburg:
> The ice driver would previously panic during suspend. This is caused
> from the driver *only* calling the ice_vsi_free_q_vectors() function by
> itself, when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent
> NULL pointer deref during reload") the driver has zeroed out
> num_q_vectors, and only restored it in ice_vsi_cfg_def().
> 
> This further causes the ice_rebuild() function to allocate a zero length
> buffer, after which num_q_vectors is updated, and then the new value of
> num_q_vectors is used to index into the zero length buffer, which
> corrupts memory.

[…]

For the commit message summary I suggest to be more specific. Maybe:

ice: Fix memory corruption with suspend and rebuild

ice: Avoid 0-length buffer to fix memory corruption with suspend/rebuild


Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

