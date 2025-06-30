Return-Path: <netdev+bounces-202561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501DAEE476
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA79F3BD355
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C328DB5E;
	Mon, 30 Jun 2025 16:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071F28B7D6
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300555; cv=none; b=eK8kLvc2ZuzLiJ0VzMsSZBnIV1kSvJoT2vUnD5qMJ1x8KsnLpOTbGYOgZQQYTXMsTvfqzTN93Lw1LWIRoE4nYkamC5k1LyFgsETWP9d1Ly6GNMpsXxqRGVUYY9BHn8r9X0RftS+e2UHR20OZ3klIgl/37G2Znz8TcyTHPRbqOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300555; c=relaxed/simple;
	bh=1rCH+HsM2DxvWfsTBLhYKbMHhlWqMGiVP3TLuGQjiFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBGgmojgNAobYGT4CKP5Roaff6fTNJZ3Zy8mudSljLdp8ui1SFw0L18UoSyJezQKkDPT0/USsu6IOMg27oUzjXU2V6b45lQ5/iRmR1HVnvGGcE7ArkV07mZKZFyVs/NWyzY0b98L453TnQoRG80PtSKuselSpb9PniQCJB1fOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fe.dynamic.kabel-deutschland.de [95.90.247.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 96C1861E647AC;
	Mon, 30 Jun 2025 18:22:11 +0200 (CEST)
Message-ID: <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>
Date: Mon, 30 Jun 2025 18:22:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
To: Joshua A Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
 <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Josh,


Am 30.06.25 um 18:08 schrieb Hay, Joshua A:

>> Am 25.06.25 um 18:11 schrieb Joshua Hay:
>>> This series fixes a stability issue in the flow scheduling Tx send/clean
>>> path that results in a Tx timeout.
>>>
>>> The existing guardrails in the Tx path were not sufficient to prevent
>>> the driver from reusing completion tags that were still in flight (held
>>> by the HW).  This collision would cause the driver to erroneously clean
>>> the wrong packet thus leaving the descriptor ring in a bad state.
>>>
>>> The main point of this refactor is replace the flow scheduling buffer
>>
>> … to replace …?
> 
> Thanks, will fix in v2
> 
>>> ring with a large pool/array of buffers.  The completion tag then simply
>>> is the index into this array.  The driver tracks the free tags and pulls
>>> the next free one from a refillq.  The cleaning routines simply use the
>>> completion tag from the completion descriptor to index into the array to
>>> quickly find the buffers to clean.
>>>
>>> All of the code to support the refactor is added first to ensure traffic
>>> still passes with each patch.  The final patch then removes all of the
>>> obsolete stashing code.
>>
>> Do you have reproducers for the issue?
> 
> This issue cannot be reproduced without the customer specific device
> configuration, but it can impact any traffic once in place.

Interesting. Then it’d be great if you could describe that setup in more 
detail.

>>> Joshua Hay (5):
>>>     idpf: add support for Tx refillqs in flow scheduling mode
>>>     idpf: improve when to set RE bit logic
>>>     idpf: replace flow scheduling buffer ring with buffer pool
>>>     idpf: stop Tx if there are insufficient buffer resources
>>>     idpf: remove obsolete stashing code
>>>
>>>    .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   6 +-
>>>    drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 626 ++++++------------
>>>    drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  76 +--
>>>    3 files changed, 239 insertions(+), 469 deletions(-)


Kind regards,

Paul

