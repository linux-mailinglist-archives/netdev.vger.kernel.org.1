Return-Path: <netdev+bounces-233312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2EC1193A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB14E5837
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16752DE71D;
	Mon, 27 Oct 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Tj2u4Tpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654B2D5C86
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601734; cv=none; b=hQxsZtGS28gQvedefvIQL2yWSZ0E96NcpViyctVGWKZhUVT2cXuDaz+29nq6mgBzX2BPygRpupL/s/MDBx+eYqfeof6ymqyA+NIx7ivtjcA4UJmrYwOcVp9AjA9zCP+3a1o6pnJ6033JXW0xKuKx0ow+kqdaeH+rfn6MFU2+hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601734; c=relaxed/simple;
	bh=HESvwmfoiGXdnTQyiQ/4wlcD6w8702121djuiembiTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4DmaFC7sBjQPK5YONeyWGKwUkPwYQe90dV20/i2irGePuXztLKdMvbpTyvJvL0Yb5c6J+vDhti8C5Q0Db5tZMzwZr9deXWtGNXYxRB6WoigJV5p3x0DSAkLY+zEXVT+c3MTlx7+hMAd2/eE9R6T98sa52QTW3UGVW5tnY9bpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Tj2u4Tpi; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430ca4647c7so22505195ab.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761601730; x=1762206530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/0vwNg+qgGMIcwUt5jgRslT1jJKk2XffVBkdX0DK+4=;
        b=Tj2u4Tpi7YtX67PdmWmkJELh6TcHS+jBzjBU/vFgZtzosDgrOuW8oqhKUtVt7PqPqo
         pp8R51swZjK9cNpXXl88YElaYTtzGAyp30yV1e/qM8nZn4cqYGwcUHzCCeUF6GdxcJnD
         vmDrdREQDS8rIBPPmNoQUuFJvx0BEDSaBV8PssXwkIqOA4HpeOEEHIcZ4WQNS/CehR0u
         IbIPXEuSTQVyNmmHS/Prsqn6h0Luy03372h9710zJ840Iz15Ecl1ubhKfUnZMjJMpDvV
         4Kh6IiCJnS0RzGWdGq1osv6hKt1YkzFrWwLpp4urERf2P4saYrtaBLu4Kj5gg05A4ZtL
         i7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601730; x=1762206530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/0vwNg+qgGMIcwUt5jgRslT1jJKk2XffVBkdX0DK+4=;
        b=GDdgcuOoVMfKbD0feWDu7w2i+pohc7F+/27p3Uxhbh2HkZ7ey8pHYUw2hJLByRx/E0
         j7O5n2u28BWAW9u5oQ3Djujm3QhmpofhyfIKgnCdpG7hXP9kvkaHyBOgxxwUt0imIy09
         pVlujnRNCfXftCAXgLD6I2p+jPyf33IW7CX1bDvPqBI6VjKkyxHVPc9mUqM+UwngoDGd
         fiWX9vdq4RFJ6JabLbdzM7DC4LsBdeUljk4Sjfn1RHWMdd5QabZdbucIMhxToz1djCoh
         mSk32A6G97A1FEN/TqYgwmfYr1PRurbcLHcbNu2z/8tiZbxpw/bh8wnVgoikHUCdvZ5M
         /Lsw==
X-Gm-Message-State: AOJu0Ywah5iBQuQgeMsVZ1sYk0BY0WwPaD59fyd0mhAh7A0Y1yG/c6W5
	IIRYF+cSYAXM7OXG8Kzk4tKf63ZdtitNy/XaY0sUk7RVOJNzz6fkLWN5Lp+nQ97hHMg=
X-Gm-Gg: ASbGncsVSYCaQaJ+7VpICSvPEF+4wr6uU6KqAOfJ6qNVfs7wcrlcIook2wFoZCgovxA
	+mWMwpC6bjLwpZQ71mG8BUay94KYtr6GX0cM/GaRa90cs87ZrPXrFylR6F4UQ7Ut1MBnibAmAHr
	jceu7hfMh8Zkg7GYEDD6B16sv4iH2wg5PB9F5SNNxFDVxGyHdjlRXwialtg07mbO4SI1YpP5Otk
	X//crQSbXkq82wwZurgNdTUNDmhJuzYOIG4Knxpt47G2RwlMVse15GvxF0l3opB9YaWojssDkoy
	CyMOmPaF3e12mHrkrqWg2kRMAjohHtzHpMzWRGPKprpTdVjjH5U8ecaFLtfr9lK8w0h9jgtVcMU
	vqXifBVEsmb+HzJOMwmnFRB7cT+okzeoohlrk+2zSOL36NJuWOy3ha/Waf1rPFf9/rR3xpx9547
	12VM0Ly/Hb
X-Google-Smtp-Source: AGHT+IHzO3FpGLd7oMr9wjLHWyDiT//0dXgSKkkQx/4gl+VhyjAOsEpPRYjjWCpnczR7BrGo6EngCg==
X-Received: by 2002:a05:6e02:2406:b0:431:f808:622a with SMTP id e9e14a558f8ab-4320f6a89ffmr27613425ab.6.1761601729644;
        Mon, 27 Oct 2025 14:48:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dbe02sm3498228173.2.2025.10.27.14.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:48:48 -0700 (PDT)
Message-ID: <23860806-f58d-4f11-977a-8ec518adc59a@kernel.dk>
Date: Mon, 27 Oct 2025 15:48:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] io_uring: Introduce getsockname io_uring cmd
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20251024154901.797262-1-krisman@suse.de>
 <20251024154901.797262-4-krisman@suse.de>
 <f61afa55-f610-478b-9079-d37ad9c2f232@kernel.dk>
 <87ldkwyrcf.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87ldkwyrcf.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 3:20 PM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/24/25 9:49 AM, Gabriel Krisman Bertazi wrote:
>>> Introduce a socket-specific io_uring_cmd to support
>>> getsockname/getpeername via io_uring.  I made this an io_uring_cmd
>>> instead of a new operation to avoid polluting the command namespace with
>>> what is exclusively a socket operation.  In addition, since we don't
>>> need to conform to existing interfaces, this merges the
>>> getsockname/getpeername in a single operation, since the implementation
>>> is pretty much the same.
>>>
>>> This has been frequently requested, for instance at [1] and more
>>> recently in the project Discord channel. The main use-case is to support
>>> fixed socket file descriptors.
>>
>> Just two nits below, otherwise looks good!
>>
>>> diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
>>> index 27a09aa4c9d0..092844358729 100644
>>> --- a/io_uring/cmd_net.c
>>> +++ b/io_uring/cmd_net.c
>>> @@ -132,6 +132,28 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>>>  	return -EAGAIN;
>>>  }
>>>  
>>> +static int io_uring_cmd_getsockname(struct socket *sock,
>>> +				    struct io_uring_cmd *cmd,
>>> +				    unsigned int issue_flags)
>>> +{
>>> +	const struct io_uring_sqe *sqe = cmd->sqe;
>>> +
>>
>> Random newline.
> 
> Done, but this fix will totally ruin the diffstat.  :(

What do you mean, it'll look even better as you're now killing a
redundant line you added :)

>>> +	struct sockaddr_storage address;
>>> +	struct sockaddr __user *uaddr;
>>> +	int __user *ulen;
>>> +	unsigned int peer;
>>> +
>>> +	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
>>> +	ulen = u64_to_user_ptr(sqe->addr3);
>>> +	peer = READ_ONCE(sqe->optlen);
>>> +
>>> +	if (sqe->ioprio || sqe->__pad1 || sqe->len || sqe->rw_flags)
>>> +		return -EINVAL;
>>
>> Most/all prep handlers tend to check these first, then proceed with
>> setting up if not set. Would probably make sense to mirror that here
>> too.
> 
> Ack. will wait a few days for feedback on the network side before the
> v2.

Sounds good, thanks.

-- 
Jens Axboe


