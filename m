Return-Path: <netdev+bounces-258807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COLPGIdEkmlysgEAu9opvQ
	(envelope-from <netdev+bounces-258807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:11:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45113FDD2
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A142B300C823
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E3289E13;
	Sun, 15 Feb 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLKblj91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA49261B9B
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771193476; cv=none; b=M7b67I4lk1zP7uxysOSaN4N6k9No8ppgjAc4IHTOKhblM5tSzIAMMrKp34uEfYWTw7QWi5tl3msOScZmlB/Us4JsRB78FHGKpATpImphV9PcW7goW3cW6kDmBb/j+S0sITY7t4188sEmBjIY8fNWX49bQY1oUmLruRe8vr2loas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771193476; c=relaxed/simple;
	bh=Cdq2GxXVu2b/hGRedLvxBBhZlQM+y3WBPyODiiej0Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8Zv+umD3fFDoEFRisEINKCCv0ybwtMgkEdi5/Mu6JQglLw4dFNWiX+S6WXXQeD/3CeTa6Z/BUD8hvCGBgWtEN1CbU6h336VbbqeT47MtFNphFXkZWuKMO/8iPVzF02Lh1+f84qZluXRbtFMzTeMgblCHNeXuiYoLyAhkegztgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLKblj91; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43638a33157so2525923f8f.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771193474; x=1771798274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bjgdv6+xVwcOY0VJHxGLDRP61lwXv1KxDnm7ljawwVw=;
        b=lLKblj91cIOROyd26RkCboTjChlKIHBHK777gRdHuwK+TcSAJp2RA/L1R5p7Pqnnwu
         Q79L4EyfK9GpUUAg7f1JjWnJ6VEVYy7u252+mYAKJtq+bT37JnhO8xfRf+6C7OBKb2Z0
         alITYBkA81AfPK62U61HPAad7X0KMwfmUumDWeRq8aACAnBsFO0Szv9Xv9i/sAJEclSl
         4Dnne32awSwqqJ1ND9JF7fDgzBzDlimPhOMDtwuTskpkooFBWHtTRR0Y4e1acbtFrHQp
         nZtXxrMSoEBu5yrVmNUFItNrxwM4HEqKIMiMe4oGtLhjHklOa1BBaku3YvAHvdcbRiMp
         C4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771193474; x=1771798274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bjgdv6+xVwcOY0VJHxGLDRP61lwXv1KxDnm7ljawwVw=;
        b=mRk/Z0zVtkR4D4QMjU2BDbjrKNGxiNne6N8k5cBMbFN5RtICd602ASdnQ3SIm0sgeL
         +I0byxzfSmeYx39bkfqr/VIkYOHyUOaSj/hQCvgMOAx5WyyJ+Iw8x4/2/uwRcD7Ek8ro
         oessOjVucgzuIuU7K4DCRdO1auS/LkE5YQnuroLb93PNxR/jFzWsIdwg3jgP+QRJbnZK
         o2dksQAH5Zwf+7P74vX7QoCsg1Y5920s8rni+4k4M+duQQrild0GXJW6fpc9JX5MbBTr
         8DUwi643CvHhaGNzZOZPe413LUKrUP+Gc/Hg9rywkvjjZ2mP/tYyPogfARvUFbZkAUX/
         bRew==
X-Gm-Message-State: AOJu0YwzrXY04h5ij8FRA/916qcaajJ92bh8oVqms4+VnvmVwgy5mcrS
	OB+Q4hsrfGE6px5axVIZm48zn8OUKuZ45Ap5t57n540b3yZv69HBlrlAKplmFQ==
X-Gm-Gg: AZuq6aLaO5u1UmO4NBNsEVlRdhChzpbm88xlUmM6fhIuoTtj3iCbc4UCIoOjwPgeElE
	JtZRwXgIJz+JOkUeyO8a/MLHVt54/zGiJEd9I1GKVg7dSY78Tiz9Fk3qgiSICcJ6V3QzotDF/hT
	rovwVniV9ZwmqVZ8C+HQ6DJZwgmmoWpJ06grX4xEUUW0qZOB6VJ/4GkjH//dKGYM1wX8kwLWh9g
	LbQplOS6xQrbB5IUT1YWcd+XZi7lYmc+vwsxLNqjmqQ7rmBG3aZHxiy9yVo5ptoOzDMgXjZmsI+
	YrcYfFsui4X+yeesCXipVfOcXdvpcbKWQog4TrsqxKbvgvLFSiHEqFF5Td4SMhVgyDn7NWvW/i+
	m3HyTEnSC0VakCIq8ZnUIxbT4pqZoqvXC7PNtvzhzZbF8/sSqzQjXwkySHd+RI/Tp8CFX5Uy1C8
	AOK7Nor4gOu3I81q7GAFTDL5pU4AckseHyZLbzSamepLXxapDTKtln5mtSGxUxsJVs2RsQaDdY0
	+3vVe7S8mYdg7ZT1qUSOc6wzN5+HO8hDfQ9Y9C4FAT2FDC07KFNcNSD1LpDgw60pJBrh3gXpT/i
	og==
X-Received: by 2002:a05:6000:4285:b0:435:bbd7:18e4 with SMTP id ffacd0b85a97d-4379795efa9mr17511803f8f.63.1771193473971;
        Sun, 15 Feb 2026 14:11:13 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac92sm22139366f8f.1.2026.02.15.14.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 14:11:13 -0800 (PST)
Message-ID: <611435d8-0f3e-4c43-bd37-9e74d8512de3@gmail.com>
Date: Sun, 15 Feb 2026 22:11:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.0] io_uring/query: return support for custom rx
 page size
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
 <b9c6eea4-cc66-43ae-bf87-907b35db9c8e@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b9c6eea4-cc66-43ae-bf87-907b35db9c8e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258807-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC45113FDD2
X-Rspamd-Action: no action

On 2/15/26 22:06, Jens Axboe wrote:
> On 2/15/26 2:34 PM, Pavel Begunkov wrote:
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index fc473af6feb4..6750c383a2ab 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -1090,6 +1090,14 @@ enum zcrx_reg_flags {
>>   	ZCRX_REG_IMPORT	= 1,
>>   };
>>   
>> +enum zcrx_features {
>> +	/*
>> +	 * The user can ask for the desired rx page size by passing the
>> +	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
>> +	 */
>> +	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
>> +};
> 
> Well I guess one comment - supposedly ->rx_buf_len is going to be added
> in the future? Because right now it's not there.

# git blame include/uapi/linux/io_uring.h | grep rx_buf_len
795663b4d160b (Pavel Begunkov          2026-01-24 10:36:17 +0000 1115)  __u32   rx_buf_len;

commit 795663b4d160ba652959f1a46381c5e8b1342a53 (tag: for-7.0/io_uring-zcrx-large-buffers-20260206, axboe2/for-7.0/io_uring-zcrx-large-buffers)
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Jan 24 10:36:17 2026 +0000

     io_uring/zcrx: implement large rx buffer support


You should've already forwarded it to Linus with
"[GIT PULL] Large buffer support for zcrx".

Different base?

-- 
Pavel Begunkov


