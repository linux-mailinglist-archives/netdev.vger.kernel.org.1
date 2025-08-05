Return-Path: <netdev+bounces-211667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87721B1B112
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4931166629
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8623816E;
	Tue,  5 Aug 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSi+u/3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5A2F30
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386310; cv=none; b=bXypA7LwL5CIrXIeaFnZkiMkagrUjFgt4raZwjXEg/jyVK9taQ4GLWPtVXOBGeWiWOtioW89+65DJDa3cwlYTQ2CiFaqWTIJ4iIqXJzHfeXUyU346bchjva2jsCVmTOg2umZfKZgWwEPTUoB8x/tHasBEsayfwUe8LHMbLgykDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386310; c=relaxed/simple;
	bh=ApLfOZ7rBItbL9w4r66vWFgv3GQHR5w9AFkDNamf+uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbW0VKPR+fhWb0gFl2NvPWMzvm1tAavL/yQstBxIBZTBUszNF4fnldxJzv8GgywmhwUegm63o7ZMbPZgxoWoMwzKF3SCsFVIPyYa5VL/qNBQg/HOVgq7RGhkRJntOR8UJA/DpBszuzo9Mm8R6HEdHqhe6joEcdmYE/s4DgNzfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSi+u/3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F129C4CEF0;
	Tue,  5 Aug 2025 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754386310;
	bh=ApLfOZ7rBItbL9w4r66vWFgv3GQHR5w9AFkDNamf+uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSi+u/3twu+giBzglNsyT2IU7EeO+T4oy/U6XCJZgWWX+j4lGnWmsBYotA5vG4ABt
	 +lZIpVw9eb7t/TH4kHEEIdVCvrqhEkNT0ypYY3DrUcVHQ4zQ2jDgG+sLoN6RgSzPF/
	 00uG36nCmfmCQn4DskwIo5XMSaa44czaNr0JzlM+SS+fuCVTtf/H73qB7bT+eDxBxl
	 ES7pEOIZOMtuLHhKyo3/wAN6sZCQdBJb6clFu4akRlz7W0SFkW4JPyy9L8Ipf5KKQ+
	 T/dKPZCy44hL6jtv7xib0qfNK2MoeLT2pe7q0fdlEA/tDrBfUHx4WOqEDxe4fM1/mp
	 U3Q0R7X1TqiqQ==
Date: Tue, 5 Aug 2025 10:31:45 +0100
From: Simon Horman <horms@kernel.org>
To: David Hill <dhill@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] PATCH: i40e Improve trusted VF MAC addresses logging
 when limit is reached
Message-ID: <20250805093145.GV8494@horms.kernel.org>
References: <20250802141322.2216641-1-dhill@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802141322.2216641-1-dhill@redhat.com>

On Sat, Aug 02, 2025 at 10:13:22AM -0400, David Hill wrote:
> When a VF reaches the limit introduced in this commit [1], the host reports
> an error in the syslog but doesn't mention which VF reached its limit and
> what the limit is actually is which makes troubleshooting of networking
> issue a bit tedious.   This commit simply improves this error reporting
> by adding which VF number has reached a limit and what that limit is.
> 
> Signed-off-by: David Hill <dhill@redhat.com>
> 
> [1] commit cfb1d572c986a39fd288f48a6305d81e6f8d04a3
> Author: Karen Sornek <karen.sornek@intel.com>
> Date:   Thu Jun 17 09:19:26 2021 +0200

Hi David,

Your Signed-off-by, and any other tags, should come at the end of
the commit message. In this case, immediately before the scissors ("---").

And the correct form for a commit citation in a commit message is like
this. Note: There should be 12 or more characters of hash - usually 12 is
enough to prevent a collision with current hashes; And, unlike a Fixes
tag it should be line wrapped as appropriate.

commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
trusted VF")

> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 9b8efdeafbcf..44e3e75e8fb0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2953,7 +2953,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>  		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
>  						       hw->num_ports)) {
>  			dev_err(&pf->pdev->dev,
> -				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
> +				"Cannot add more MAC addresses, trusted VF %d uses %d out of %d MAC addresses\n", vf->vf_id, i40e_count_filters(vsi) +
> +          mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,hw->num_ports));
>  			return -EPERM;
>  		}
>  	}

I am wondering if we can achieve the same in a slightly less verbose way.
And follow more closely the preference in Networking code to keep lines
to 80 columns wide or less, unless it reduces readability (subjective to to
be sure).

Something like this (compile tested only!):

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9b8efdeafbcf..874a0d907496 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2896,8 +2896,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
+	int mac2add_cnt = i40e_count_filters(vsi);
 	struct i40e_hw *hw = &pf->hw;
-	int mac2add_cnt = 0;
 	int i;
 
 	for (i = 0; i < al->num_elements; i++) {
@@ -2937,8 +2937,7 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * push us over the limit.
 	 */
 	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
+		if (mac2add_cnt > I40E_VC_MAX_MAC_ADDR_PER_VF) {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
 			return -EPERM;
@@ -2949,11 +2948,14 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * all VFs.
 	 */
 	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+		int add_max;
+
+		add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
+							     hw->num_ports);
+		if (mac2add_cnt > add_max) {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses, trusted VF %d uses %d out of %d MAC addresses\n",
+				vf->vf_id, mac2add_cnt, add_max);
 			return -EPERM;
 		}
 	}

While sketching-out the above I noticed the dev_err() relating to
undtrusted VFs (around line 2940). And I'm wondering if you think
it makes sense to give it the same treatment that your patch
gives to the dev_err for trusted VFS (around line 2955).


