Return-Path: <netdev+bounces-216871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C1B359EB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D6C3A9A58
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FA30AAA5;
	Tue, 26 Aug 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vKi90Lq8"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890C233128;
	Tue, 26 Aug 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203308; cv=none; b=E0ATxZil9/LVBUuI0Kq1ffJRuChq01v0GPiI0yv11bUVmiaWydCabcJ4aEl660ixi6jZT/pUUsfFHXUvuzUiZ1CBsPXEb0/nu0qJlA/q3oi1Hbk+TT/bzr2cCpL9ErS5yNn6492zdMnnR1wgSd7MyZ61cy9wudJPEUiIp5xlhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203308; c=relaxed/simple;
	bh=jzCx4AJYjfVdLu4lvm7viYZkDwKumPWXqnVTmygMhf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSqpa1qwopVnXXcGQ+aMTftplK6j35WnM5GKhTCQhU+MTd/Ip0THrWZtmdOsoNsHqstPToYO0peudLfbMW3r7T6cZQsVR26Yrm3gdkaUFU3x0V57qAQHtBsr/mAYQ4IjRpjMtwzhqCsdtxIxSQ2yYnghFTPM+g7piDe7UtOIHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vKi90Lq8; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756203292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93BSLKjqwuhfuo1d7BbPvsz9FaxJknFZQrYjXgjX3Wc=;
	b=vKi90Lq8N/rLBoHV/tqnWppuyM5doMlL1lAFpjC9LmAx77dqYYLv2dujjcgkPedcv4S1Z9
	iMCUV/m4kMoYXj77kIMW/nhAhgV8WbG8og5OB9JvwilZ4AcQrp8cqsIAXz/O0+kuy7o6GX
	6200GzoLUS2Tj99Sr5Lx6WpG/etTCik=
Date: Tue, 26 Aug 2025 11:14:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 02:31, Yibo Dong wrote:
> On Mon, Aug 25, 2025 at 05:37:27PM +0100, Vadim Fedorenko wrote:
>> On 22/08/2025 03:34, Dong Yibo wrote:
>>
>> [...]
>>> +/**
>>> + * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
>>> + * @hw: pointer to the HW structure
>>> + * @req: pointer to the cmd req structure
>>> + * @cookie: pointer to the req cookie
>>> + *
>>> + * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
>>> + * reply. cookie->wait will be set in irq handler.
>>> + *
>>> + * @return: 0 on success, negative on failure
>>> + **/
>>> +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
>>> +				 struct mbx_fw_cmd_req *req,
>>> +				 struct mbx_req_cookie *cookie)
>>> +{
>>> +	int len = le16_to_cpu(req->datalen);
>>> +	int err;
>>> +
>>> +	cookie->errcode = 0;
>>> +	cookie->done = 0;
>>> +	init_waitqueue_head(&cookie->wait);
>>> +	err = mutex_lock_interruptible(&hw->mbx.lock);
>>> +	if (err)
>>> +		return err;
>>> +	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
>>> +	if (err)
>>> +		goto out;
>>> +	/* if write succeeds, we must wait for firmware response or
>>> +	 * timeout to avoid using the already freed cookie->wait
>>> +	 */
>>> +	err = wait_event_timeout(cookie->wait,
>>> +				 cookie->done == 1,
>>> +				 cookie->timeout_jiffies);
>>
>> it's unclear to me, what part of the code is managing values of cookie
>> structure? I didn't get the reason why are you putting the address of
>> cookie structure into request which is then directly passed to the FW.
>> Is the FW supposed to change values in cookie?
>>
> 
> cookie will be used in an irq-handler. like this:
> static int rnpgbe_mbx_fw_reply_handler(struct mucse *mucse,
>                                         struct mbx_fw_cmd_reply *reply)
> {
>          struct mbx_req_cookie *cookie;
> 
>          cookie = reply->cookie;
> 
>          if (cookie->priv_len > 0)
>                  memcpy(cookie->priv, reply->data, cookie->priv_len);
>          cookie->done = 1;
>          if (le16_to_cpu(reply->flags) & FLAGS_ERR)
>                  cookie->errcode = -EIO;
>          else
>                  cookie->errcode = 0;
>          wake_up(&cookie->wait);
>          return 0;
> }
> That is why we must wait for firmware response.
> But irq is not added in this patch series. Maybe I should move all
> cookie relative codes to the patch will add irq?

well, yes, in general it's better to introduce the code as a solid
solution. this way it's much easier to review

> 
>>> +
>>> +	if (!err)
>>> +		err = -ETIMEDOUT;
>>> +	else
>>> +		err = 0;
>>> +	if (!err && cookie->errcode)
>>> +		err = cookie->errcode;
>>> +out:
>>> +	mutex_unlock(&hw->mbx.lock);
>>> +	return err;
>>> +}
>>
>> [...]
>>
>>> +struct mbx_fw_cmd_req {
>>> +	__le16 flags;
>>> +	__le16 opcode;
>>> +	__le16 datalen;
>>> +	__le16 ret_value;
>>> +	union {
>>> +		struct {
>>> +			__le32 cookie_lo;
>>> +			__le32 cookie_hi;
>>> +		};
>>> +
>>> +		void *cookie;
>>> +	};
>>> +	__le32 reply_lo;
>>> +	__le32 reply_hi;
>>
>> what do these 2 fields mean? are you going to provide reply's buffer
>> address directly to FW?
>>
> 
> No, this is defined by fw. Some fw can access physical address.
> But I don't use it in this driver.

FW can access physical address without previously configuring IOMMU?
How can that be?

> 
>>> +	union {
>>> +		u8 data[32];
>>> +		struct {
>>> +			__le32 version;
>>> +			__le32 status;
>>> +		} ifinsmod;
>>> +		struct {
>>> +			__le32 port_mask;
>>> +			__le32 pfvf_num;
>>> +		} get_mac_addr;
>>> +	};
>>> +} __packed;
>>> +
>>> +struct mbx_fw_cmd_reply {
>>> +	__le16 flags;
>>> +	__le16 opcode;
>>> +	__le16 error_code;
>>> +	__le16 datalen;
>>> +	union {
>>> +		struct {
>>> +			__le32 cookie_lo;
>>> +			__le32 cookie_hi;
>>> +		};
>>> +		void *cookie;
>>> +	};
>>
>> This part looks like the request, apart from datalen and error_code are
>> swapped in the header. And it actually means that the FW will put back
>> the address of provided cookie into reply, right? If yes, then it
>> doesn't look correct at all...
>>
> 
> It is yes. cookie is used in irq handler as show above.
> Sorry, I didn't understand 'the not correct' point?

The example above showed that the irq handler uses some value received
from the device as a pointer to kernel memory. That's not safe, you
cannot be sure that provided value is valid pointer, and that it points
to previously allocated cookie structure. It is a clear way to corrupt
memory.

> 
>>> +	union {
>>> +		u8 data[40];
>>> +		struct mac_addr {
>>> +			__le32 ports;
>>> +			struct _addr {
>>> +				/* for macaddr:01:02:03:04:05:06
>>> +				 * mac-hi=0x01020304 mac-lo=0x05060000
>>> +				 */
>>> +				u8 mac[8];
>>> +			} addrs[4];
>>> +		} mac_addr;
>>> +		struct hw_abilities hw_abilities;
>>> +	};
>>> +} __packed;
>>


