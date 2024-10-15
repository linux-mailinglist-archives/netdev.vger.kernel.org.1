Return-Path: <netdev+bounces-135649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA899EAFC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8341F21BCD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB951C07CF;
	Tue, 15 Oct 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yor2z9Hw"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5E1C07C9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997297; cv=none; b=KaOkVRpddNQIx05UjxV42wsM42lmP+1LDK2r+LGhkzS1jZRBlZafdljG81gYA8c5PbNTjg91WUhkKXW82pN9jMKnhwEJ7RG9EzdtLRdpokDyi+l6odsjbSLXpGJo2iDAvOee2AaLA4Y0v1d0vp71NUdMm8DdCphRQ80B4A/cgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997297; c=relaxed/simple;
	bh=yUZfuBVgIiU110ZO+jUaSJoucQDF0N+swGkk10tzhUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdEmoWheWJumm0IAeSbVBOi0YPZlZcIQX2ApIYubJzRvkpBx9TtVv4CicVVylNlDnwdWlsILvHmCbAMaXdMDm5jbHAc2PFuTfyW+raczhsS3U1M1JnQztkMGYyLsFDHlfdMxmgLz4BcEYr21WYywSgXHe1EfdKd+DhLT4xn79WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yor2z9Hw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a94404f1-93a9-4d13-9207-c95eff0d8b7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728997292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLuuY0Y6k3+TUbvxD1oCTUWEIHJK3gEjZzJobTHvMuc=;
	b=Yor2z9HwmUlLOijHKzIgHV3TSZtdWYrKb/DNT3GS9tfh3OtrUTs6KIIbs/869LtWPsNit/
	JedA/rEUHOSB7djUzNjzOyBluZPbG73x1Gx3+pbfasqOSB/Ug3Pdi3OzqJgSiBhMK29QI8
	86mJhVVKgHakWRfJpD0+7c0aw0Lzhes=
Date: Tue, 15 Oct 2024 14:01:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
To: Michael Chan <michael.chan@broadcom.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20241014232947.4059941-1-vadfed@meta.com>
 <CACKFLinJE-QfyUSDpYYfKtKEypMKZX_y_rAm_nQCQz_cDh8YjQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLinJE-QfyUSDpYYfKtKEypMKZX_y_rAm_nQCQz_cDh8YjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2024 07:20, Michael Chan wrote:
> On Mon, Oct 14, 2024 at 4:29 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> We can see high contention on ptp_lock while doing RX timestamping
>> on high packet rates over several queues. Spinlock is not effecient
>> to protect timecounter for RX timestamps when reads are the most
>> usual operations and writes are only occasional. It's better to use
>> seqlock in such cases.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
>> -/* Caller holds ptp_lock */
>>   static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>>                              u64 *ns)
>>   {
>>          struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>>          u32 high_before, high_now, low;
>>
>> +       /* Make sure the RESET bit is set */
>> +       smp_mb__before_atomic();
> 
> This may not be sufficient.  MMIO read of any register (clock register
> in this case) can hang the chip if it is undergoing reset.
> 
>>          if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
>>                  return -EIO;
> 
> We could have missed the flag and got here while the chip is about to be reset.
> 
> I will review the patch in more detail tomorrow.  Thanks.


Ok, so we have to serialize bnxt_refclk_read() and FW RESETS, but don't
block readers of ptp, especially on RX hot path. So it looks like
read_seqcount_excl_bh() can help us with it.

