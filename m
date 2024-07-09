Return-Path: <netdev+bounces-110167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351892B29B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9DF1F225D9
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C15152E0D;
	Tue,  9 Jul 2024 08:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29089146D6D;
	Tue,  9 Jul 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515087; cv=none; b=vA/raACPiqCM1tt8dJaQQvmJMao3zCgM9aPuz0c/pTDkakb3v6TrB6RbR8W5UKzncOv/ny9UU5LInktUzPbxlPAMWrfaiXgRGR35CkqDn1gMSZCzL8ffZdF18L+cfoijNMLyKrIAwhFcTWWIlrRhQKg06+f/RU2u59kl3WIh93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515087; c=relaxed/simple;
	bh=LD1/f+QGXtsINrfK/x9B1DLA2J3EdBZ8CD+2frlVZt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgvFK34b3FN4XdR2PHBvZm0/NJRa6LdIojp76aXhP4dDWcJAjkW0TQdPfHzqhOa+Rn2bh6aj52nlL9adMSCu7FEduec4ARx4SlJhaBLJR8bGUTGsIUZBNWRECsovpWf1NwBcF5CKT+wOXrBt2tkR0hOk5LtW3EmpF9JqutAEBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C410161E40617;
	Tue,  9 Jul 2024 10:49:57 +0200 (CEST)
Message-ID: <033111e2-e743-4523-8c4f-7d5f1c801e65@molgen.mpg.de>
Date: Tue, 9 Jul 2024 10:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ice: Adjust over allocation
 of memory in ice_sched_add_root_node() and ice_sched_add_node()
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 lvc-project@linuxtesting.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>
References: <20240708182736.8514-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240708182736.8514-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Thank you for your patch.


Am 08.07.24 um 20:27 schrieb Aleksandr Mishin:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But incorrect types are used as sizeof()
> arguments in these calls (structures instead of pointers) which leads to
> over allocation of memory.

If you have the explicit size at hand, it’d be great if you added those 
to the commit message.

> Adjust over allocation of memory by correcting types in devm_kcalloc()
> sizeof() arguments.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Maybe mention, that Coverity found that too, and the warning was 
disabled, and use that commit in Fixes: tag? That’d be commit 
b36c598c999c (ice: Updates to Tx scheduler code), different from the one 
you used.

`Documentation/process/submitting-patches.rst` says:

> A Fixes: tag indicates that the patch fixes an issue in a previous
> commit. It is used to make it easy to determine where a bug
> originated, which can help review a bug fix. This tag also assists
> the stable kernel team in determining which stable kernel versions
> should receive your fix. This is the preferred method for indicating
> a bug fixed by the patch.


> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v3:
>    - Update comment and use the correct entities as suggested by Przemek
> v2: https://lore.kernel.org/all/20240706140518.9214-1-amishin@t-argos.ru/
>    - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>      'net-next' as suggested by Simon
>      (https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/
> 
>   drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
> index ecf8f5d60292..6ca13c5dcb14 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
>   	if (!root)
>   		return -ENOMEM;
>   
> -	/* coverity[suspicious_sizeof] */
>   	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
> -				      sizeof(*root), GFP_KERNEL);
> +				      sizeof(*root->children), GFP_KERNEL);
>   	if (!root->children) {
>   		devm_kfree(ice_hw_to_dev(hw), root);
>   		return -ENOMEM;
> @@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
>   	if (!node)
>   		return -ENOMEM;
>   	if (hw->max_children[layer]) {
> -		/* coverity[suspicious_sizeof] */
>   		node->children = devm_kcalloc(ice_hw_to_dev(hw),
>   					      hw->max_children[layer],
> -					      sizeof(*node), GFP_KERNEL);
> +					      sizeof(*node->children), GFP_KERNEL);
>   		if (!node->children) {
>   			devm_kfree(ice_hw_to_dev(hw), node);
>   			return -ENOMEM;


Kind regards,

Paul

