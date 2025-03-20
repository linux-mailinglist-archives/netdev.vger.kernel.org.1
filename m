Return-Path: <netdev+bounces-176549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E2DA6AC60
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A18A8A6BBB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E6221F25;
	Thu, 20 Mar 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUAasTu8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897B1E833D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492893; cv=none; b=AzMQ+kxKjaMPsx+UF1jW80R1ub1eJYs8unrkKMZh65P/s8zQSBzjebwE5Jukygi0jXJLddtFnv0CdcSC1Rhr4GE2mLwWhfXlEnxkpGl0h50QdZWVhdBHu7m4g3r2sF9Bx90f0LmyOlQt7Vs4pUu6rFS+KoSxPwekiyoZgvBo4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492893; c=relaxed/simple;
	bh=qUqh0dM3ST2dswSE/kDyddTFGE9Zdzt/hJuSRuesAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmXQhoa7xn004KzKcuDqv0lSa1WGAYZ7Qor574iYOGbCZzmrusDNUM4gMcIcZNsUG/gNzg9idvEv4vzp6Fmohh0eUU9+0FXK/26Gj2P0MWpenUvqyJLB+CXwGnOOnvhaRttEf8dGCHjAzMdwFmDOmsh/4EkWeNm7vvY8RZwq+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUAasTu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC5C4CEDD;
	Thu, 20 Mar 2025 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492893;
	bh=qUqh0dM3ST2dswSE/kDyddTFGE9Zdzt/hJuSRuesAhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUAasTu8uSEDVjSpCJNBnD7RfHptx9MM1S4C7VEB0+KBeYa3QwgHxyYpRYJKildpP
	 IqGtEP99xAfizIF8GWpySW4fUmRwr/uZS6SqnyfOp3c2aPJHbgNqhfhEwSb0EUXkef
	 nthQuCbFJIWqC4/NHBmt1LEiKmIY31Hiye4q6QhCkMQsn1hpAF8F2EZToMVQlf2qSo
	 bc6h1gR/Z0JNonMtfjlPRxNx63GtjAB59xkd1qSrBz3N9HWB4miaRcsqtE/LXqQecZ
	 Ydjdb/lC9jUsAl7SaaaUKf5KxK3Td4IxJQeM39e6IHpTBu8Tf0l0rLcangyPcQaAdF
	 l8rF1YZK0S/+w==
Date: Thu, 20 Mar 2025 17:48:08 +0000
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com, yuma@redhat.com, mschmidt@redhat.com,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH iwl-net v2] idpf: fix adapter NULL pointer dereference on
 reboot
Message-ID: <20250320174808.GG892515@horms.kernel.org>
References: <20250318054202.17405-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318054202.17405-1-emil.s.tantilov@intel.com>

On Mon, Mar 17, 2025 at 10:42:02PM -0700, Emil Tantilov wrote:
> With SRIOV enabled, idpf ends up calling into idpf_remove() twice.
> First via idpf_shutdown() and then again when idpf_remove() calls into
> sriov_disable(), because the VF devices use the idpf driver, hence the
> same remove routine. When that happens, it is possible for the adapter
> to be NULL from the first call to idpf_remove(), leading to a NULL
> pointer dereference.
> 
> echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
> reboot
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> ...
> RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
> ...
> ? idpf_remove+0x22/0x1f0 [idpf]
> ? idpf_remove+0x1e4/0x1f0 [idpf]
> pci_device_remove+0x3f/0xb0
> device_release_driver_internal+0x19f/0x200
> pci_stop_bus_device+0x6d/0x90
> pci_stop_and_remove_bus_device+0x12/0x20
> pci_iov_remove_virtfn+0xbe/0x120
> sriov_disable+0x34/0xe0
> idpf_sriov_configure+0x58/0x140 [idpf]
> idpf_remove+0x1b9/0x1f0 [idpf]
> idpf_shutdown+0x12/0x30 [idpf]
> pci_device_shutdown+0x35/0x60
> device_shutdown+0x156/0x200
> ...
> 
> Replace the direct idpf_remove() call in idpf_shutdown() with
> idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
> the bulk of the cleanup, such as stopping the init task, freeing IRQs,
> destroying the vports and freeing the mailbox. This avoids the calls to
> sriov_disable() in addition to a small netdev cleanup, and destroying
> workqueues, which don't seem to be required on shutdown.
> 
> Reported-by: Yuying Ma <yuma@redhat.com>
> Fixes: e850efed5e15 ("idpf: add module register and probe functionality")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
> Changelog:
> v2:
> - Updated the description to clarify the path leading up to the crash,
>   and the difference in the logic between remove and shutdown as result
>   of this change.
> 
> v1:
> https://lore.kernel.org/intel-wired-lan/20250307003956.22018-1-emil.s.tantilov@intel.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>




