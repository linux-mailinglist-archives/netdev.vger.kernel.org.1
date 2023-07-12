Return-Path: <netdev+bounces-17278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8BA751072
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5461D1C211C3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5820FB2;
	Wed, 12 Jul 2023 18:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420714F7D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E9C433C8;
	Wed, 12 Jul 2023 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689186339;
	bh=ULH/st5gl+19kdRgKh/qaSmVJysjJgl+dLliG1WryAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gI4QDnNlekKSj5NnXe62Wcz0lQkvl5FhNFbrNTeuhZpZe0aY+Pyu9YdfrNZejDhfn
	 s58Awk1FbMXcH9ZvLAKqdNzUpKUAjVD48bshA5aO79S/P8j06QbXU3GCOsysQOQ5pQ
	 DJXnGQoSNfi9Z/y1PkO3OY1jiwhBpvoBBG1UQIvkp0JCKUMUVC8CambsBfINY3NkU2
	 Q9xClgHkOWa/vADQFAaZJAPNZT1wqsf4QVGottteyxKAXeZMkFZxT9uQ0cKq6162hZ
	 VN+NXBVGHrFe7JDEQibKVPeSUviXIs9s2H4zvXvZl5M2bdomsZZuDIZWEg4UIU1qmh
	 Erh8Tx1G/42wg==
Date: Wed, 12 Jul 2023 21:25:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v5] ice: Fix memory management in
 ice_ethtool_fdir.c
Message-ID: <20230712182534.GF41919@unreal>
References: <20230712130210.33864-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712130210.33864-1-jedrzej.jagielski@intel.com>

On Wed, Jul 12, 2023 at 03:02:10PM +0200, Jedrzej Jagielski wrote:
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
> may first fail to be added via ice_fdir_update_list_entry() but then
> may be deleted by ice_fdir_update_list_entry.
> 
> Terminate in both cases when the returned value of the previous
> operation is other than 0, free memory and don't use it anymore.
> 
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend CC list, fix freeing memory before return
> v3: correct typos in the commit msg
> v4: restore devm() approach
> v5: minor changes
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

