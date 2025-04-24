Return-Path: <netdev+bounces-185615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A0A9B271
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778951B86CB6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC321ACEBB;
	Thu, 24 Apr 2025 15:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834151A23BB;
	Thu, 24 Apr 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508828; cv=none; b=b1IAjibg1V8mn8bsTtmCXRd0LmEvHHq1Tqfrucv/TkUK5iuqffqnGL7xNMiQpwbKESeNyc2Zga2qgdle7xUgdVdifztOumBJy7YAej0OxkW/byQPM9dYusxXWTsdGvkgsld05K4nlk1/Zmup2ZkWhBgduTMsel49cAi+t6EnVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508828; c=relaxed/simple;
	bh=4HfjmEm5IlH5WYmbJs8B10pPWJN+B7Bu0WVVN3ycwz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5WdaDNbqDBZrea6A0r8q0xKoeMmcVlGSJM7EHfn1hphffAKhjwTOY4J2ZQ+P9Y8RtvTJvccykWj17AeVUkSEHpvt75Lku8DlaCL4OpVWCNCG9zZTJCFUo3xHB6sV/c+YijxZw093Kw72IYJlRo9pU4wTSQXbyptYnxrgXQh2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 049956016243C;
	Thu, 24 Apr 2025 17:32:18 +0200 (CEST)
Message-ID: <744538a0-a1f5-48a5-b454-f1a2530268b7@molgen.mpg.de>
Date: Thu, 24 Apr 2025 17:32:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 08/14] idpf: refactor idpf
 to use libie controlq and Xn APIs
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Lee Trager
 <lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
 Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
 "Singhai, Anjali" <anjali.singhai@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-9-larysa.zaremba@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250424113241.10061-9-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Larysa, dear Pavan,


Thank you for the patch.

Am 24.04.25 um 13:32 schrieb Larysa Zaremba:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> Support to initialize and configure controlq, Xn manager,
> MMIO and reset APIs was introduced in libie. As part of it,
> most of the existing controlq structures are renamed and
> modified. Use those APIs in idpf and make all the necessary changes.
> 
> Previously for the send and receive virtchnl messages, there
> used to be a memcpy involved in controlq code to copy the buffer
> info passed by the send function into the controlq specific
> buffers. There was no restriction to use automatic memory
> in that case. The new implementation in libie removed copying
> of the send buffer info and introduced DMA mapping of the
> send buffer itself. To accommodate it, use dynamic memory for
> the send buffers. In case of receive, idpf receives a page pool
> buffer allocated by the libie and care should be taken to
> release it after use in the idpf.
> 
> The changes are fairly trivial and localized, with a notable exception
> being the consolidation of idpf_vc_xn_shutdown and idpf_deinit_dflt_mbx
> under the latter name. This has some additional consequences that are
> addressed in the following patches.

(You could reflow the text above to have consistent line length.)

Also, how can your patchset be verified? Does the module size change? Is 
the resource usage different for certain test cases?

> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
>   drivers/net/ethernet/intel/idpf/Makefile      |    2 -
>   drivers/net/ethernet/intel/idpf/idpf.h        |   42 +-
>   .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 -------
>   .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
>   .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
>   .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
>   drivers/net/ethernet/intel/idpf/idpf_dev.c    |   91 +-
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |   49 +-
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |   87 +-
>   drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    2 +-
>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   89 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1622 ++++++-----------
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   89 +-
>   .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  303 ++-
>   16 files changed, 886 insertions(+), 2613 deletions(-)
>   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
>   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
>   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
>   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
>   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h

[…]


Kind regards,

Paul

