Return-Path: <netdev+bounces-238326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C43C574C2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82F63B0FD8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD833FE34;
	Thu, 13 Nov 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kD39OLUE"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD00299AA3
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035054; cv=none; b=pECHcmMBOLJb42V239kxhr22uOCfS8aLoNAvy8xAbMtUUCJgfEWiaF4timBsEYI2Mz8OC8wgvUNMPxvk4vAfQWr6XS2DbUgwurqShAjljVq4kTSLCpzDZyt4tf4Yfn5neoDlZ4BKT893OBdovAuWglLOKRI3T8b75jE7zBQDjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035054; c=relaxed/simple;
	bh=okHM3Ga+QlCddHAyWNBL66JzqZ4h3luH1tCYlPxT5uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icyayocTpqZsD9Ie942e88g+c+N1AZDNcne+VbychZPrjlk/FTys6pucG4kl6QNK4TJoL60roG8BNopqBQiSftpFy/hKTFLT7ouF4by0tTfx/5owzoYwqlQ9sSqZIT8eez/10NfGnTSdnsZ6QBvUi14o8sRybXOlXVmPBS/j9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kD39OLUE; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b9369f2-66fb-4c47-8bae-48577cf18c94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763035049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrZSn3wGbTqcQm6E0Pcl3rE+6joPJ9ezxS2O/g3SFgI=;
	b=kD39OLUE4icX2riCiznVkpY2IeM3pTGLoidZH3fdXnxAFQrR0BI/Y2I8MtZ+jY+pWRElmo
	M/7VOdfVdcTL5XOp/2qXR96CCHaeySG0QzZVtoQEPso/9/lL5FTtEX38ftV/TV4tD6zWs0
	a6AWwaerZdCpNI1daXg8Cc0CcRAHzyY=
Date: Thu, 13 Nov 2025 11:57:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by
 page
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 'Andrew Lunn' <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>,
 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 'Paolo Abeni' <pabeni@redhat.com>, 'Russell King' <linux@armlinux.org.uk>,
 'Simon Horman' <horms@kernel.org>, 'Jacob Keller' <jacob.e.keller@intel.com>
Cc: 'Mengyuan Lou' <mengyuanlou@net-swift.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
 <20251112055841.22984-6-jiawenwu@trustnetic.com>
 <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
 <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 02:21, Jiawen Wu wrote:
> On Wed, Nov 12, 2025 8:49 PM, Vadim Fedorenko wrote:
>> On 12/11/2025 05:58, Jiawen Wu wrote:
>>> Getting module EEPROM has been supported in TXGBE SP devices, since SFP
>>> driver has already implemented it.
>>>
>>> Now add support to read module EEPROM for AML devices. Towards this, add
>>> a new firmware mailbox command to get the page data.
>>>
>>> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

[...]

>>> +int txgbe_read_eeprom_hostif(struct wx *wx,
>>> +			     struct txgbe_hic_i2c_read *buffer,
>>> +			     u32 length, u8 *data)
>>> +{
>>> +	u32 buf_size = sizeof(struct txgbe_hic_i2c_read) - sizeof(u8);
>>> +	u32 total_len = buf_size + length;
>>> +	u32 dword_len, value, i;
>>> +	u8 local_data[256];
>>> +	int err;
>>> +
>>> +	if (total_len > sizeof(local_data))
>>> +		return -EINVAL;
>>
>> if it's really possible? SFF pages are 128 bytes, you reserve 256 bytes
>> of local buffer. What are you protecting from?
> 
> It can be changed to 128 + sizeof(struct txgbe_hic_i2c_read).

My point is why do you need this check at all?
It looks more like defensive programming which is discouraged in kernel.

> 
>>
>>> +
>>> +	buffer->hdr.cmd = FW_READ_EEPROM_CMD;
>>> +	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
>>> +			      sizeof(struct wx_hic_hdr);
>>> +	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
>>> +
>>> +	err = wx_host_interface_command(wx, (u32 *)buffer,
>>> +					sizeof(struct txgbe_hic_i2c_read),
>>> +					WX_HI_COMMAND_TIMEOUT, false);
>>> +	if (err != 0)
>>> +		return err;
>>> +
>>> +	dword_len = (total_len + 3) / 4;
>>
>> round_up()?
>>
>>> +
>>> +	for (i = 0; i < dword_len; i++) {
>>> +		value = rd32a(wx, WX_FW2SW_MBOX, i);
>>> +		le32_to_cpus(&value);
>>> +
>>> +		memcpy(&local_data[i * 4], &value, 4);
>>> +	}
>>
>> the logic here is not clear from the first read of the code. effectively
>> in the reply you have the same txgbe_hic_i2c_read struct but without
>> data field, which is obviously VLA, but then you simply skip the result
>> of read of txgbe_hic_i2c_read and only provide the real data back to the
>> caller. Maybe you can organize the code the way it can avoid double copying?
> 
> Because the length of real data is variable, now it could be 1 or 128. But the total
> length of the command buffer is DWORD aligned. So we designed only a 1-byte
> data field in struct txgbe_hic_i2c_read, to avoid redundant reading and writing
> during the SW-FW interaction.
> 
> For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
> to true, then page->data = buffer->data. For other cases, I think it would be more
> convenient to read directly from the mailbox registers.

With such design you always have your return data starting at offset of
15, which is absolutely unaligned. And then it needs more buffer
dancing.

> 
>>
>>> +
>>> +	memcpy(data, &local_data[buf_size], length);
>>> +	return 0;
>>> +}
>>> +

