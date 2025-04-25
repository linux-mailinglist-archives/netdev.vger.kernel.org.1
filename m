Return-Path: <netdev+bounces-185963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46770A9C596
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36004A767B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02C23ED74;
	Fri, 25 Apr 2025 10:32:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68223F28B;
	Fri, 25 Apr 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577135; cv=none; b=K8IMl+GtsN98/EFXXVYsODORrLJ68p18LGTOaoM2OHXxrIWj1yAEaBkL2xR9o57b4R06VeV9znUUNMnU1LxWPVeOk0rME3+TGAcmhCuHgLk/fSAYGJSMUHQOI78a6bUgnrEvVrmJHsvNzMeCg6k5YqdwosLbb9m6M6+0H+3OC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577135; c=relaxed/simple;
	bh=ZEus9rPpt6VRi7fwO/onz1YBoEYfyItEAWFJ1nvRomg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOkfq61in5nVtrvYcCyPpLglBlMI1uV2HrpP+5NTHM1Jkn+3fCk23X+GNOWOmgg+lO3dg2CjDRpso/54mPQw1rHoMCawqPQIlxgrzK47nh+yaReakb2TbQbei4UoF/wnbsgqsP2pp9qXXVQtB2W8B57lpW5tUw9MiKyx8OweCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3287D601E22C2;
	Fri, 25 Apr 2025 12:30:38 +0200 (CEST)
Message-ID: <32f03225-636d-4677-b5f6-2dde8ab76b6d@molgen.mpg.de>
Date: Fri, 25 Apr 2025 12:30:37 +0200
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
 <744538a0-a1f5-48a5-b454-f1a2530268b7@molgen.mpg.de>
 <aAtfVAp38hKWtx-n@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aAtfVAp38hKWtx-n@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Larysa,


Am 25.04.25 um 12:11 schrieb Larysa Zaremba:
> On Thu, Apr 24, 2025 at 05:32:17PM +0200, Paul Menzel wrote:

>> Am 24.04.25 um 13:32 schrieb Larysa Zaremba:
>>> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>>>
>>> Support to initialize and configure controlq, Xn manager,
>>> MMIO and reset APIs was introduced in libie. As part of it,
>>> most of the existing controlq structures are renamed and
>>> modified. Use those APIs in idpf and make all the necessary changes.
>>>
>>> Previously for the send and receive virtchnl messages, there
>>> used to be a memcpy involved in controlq code to copy the buffer
>>> info passed by the send function into the controlq specific
>>> buffers. There was no restriction to use automatic memory
>>> in that case. The new implementation in libie removed copying
>>> of the send buffer info and introduced DMA mapping of the
>>> send buffer itself. To accommodate it, use dynamic memory for
>>> the send buffers. In case of receive, idpf receives a page pool
>>> buffer allocated by the libie and care should be taken to
>>> release it after use in the idpf.
>>>
>>> The changes are fairly trivial and localized, with a notable exception
>>> being the consolidation of idpf_vc_xn_shutdown and idpf_deinit_dflt_mbx
>>> under the latter name. This has some additional consequences that are
>>> addressed in the following patches.
>>
>> (You could reflow the text above to have consistent line length.)

Re-flowing would save at least one line.

>> Also, how can your patchset be verified?
> 
> Just normal regression testing with kernel debug options enabled, a large
> portion of the touched code is covered by just loading-unloading the driver and
> doing a PCI reset, stuff like PTP needs to be checked separately, because it
> heavily uses control queue itself.
> 
>> Does the module size change?
> 
> idpf size does decrease, but overall size increases. It was 585728B for idpf,
> now it is 557056 + 16384 + 53248 [B], this amounts to +40KB of storage usage on
> systems that will not use ixd.
> 
> After
> *********
> idpf                  557056  0
> ixd                    40960  0
> libie_pci              16384  2 ixd,idpf
> libie_cp               53248  2 ixd,idpf
> libeth                 16384  2 idpf,libie_cp
> 
> Before
> *********
> idpf                  585728  0
> libeth                 16384  1 idpf
> 
>> Is the resource usage different for certain test cases?
> 
> We now pre-allocate small TX buffers, so that does increase the memory usage,
> but reduces the need to allocate. This results in additional 256 * 128B of
> memory permanently used, but our ctlq RX buffers need to be of size 4096B anyway
> (not changed by the patchset), so this is hardly noticable.
> 
> The worst-case memory usage should stay almost the same + abovementioned 32KB.
> As for the timings, we are mostly limited by the HW response time, which is far
> from instant.

Thank you for all these details. I’d love to see those in the commit 
message too.

>>> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
>>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>>> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
>>>    drivers/net/ethernet/intel/idpf/Makefile      |    2 -
>>>    drivers/net/ethernet/intel/idpf/idpf.h        |   42 +-
>>>    .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 -------
>>>    .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
>>>    .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
>>>    .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
>>>    drivers/net/ethernet/intel/idpf/idpf_dev.c    |   91 +-
>>>    drivers/net/ethernet/intel/idpf/idpf_lib.c    |   49 +-
>>>    drivers/net/ethernet/intel/idpf/idpf_main.c   |   87 +-
>>>    drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
>>>    drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    2 +-
>>>    drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   89 +-
>>>    .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1622 ++++++-----------
>>>    .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   89 +-
>>>    .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  303 ++-
>>>    16 files changed, 886 insertions(+), 2613 deletions(-)
>>>    delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
>>>    delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
>>>    delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
>>>    delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
>>>    delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
>>
>> […]

Kind regards,

Paul

