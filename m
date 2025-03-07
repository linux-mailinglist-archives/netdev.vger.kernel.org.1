Return-Path: <netdev+bounces-173104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0CA57589
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBF3A748E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 22:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829E2580F3;
	Fri,  7 Mar 2025 22:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1F23FC68;
	Fri,  7 Mar 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388378; cv=none; b=F/7Mv3h8Xsu3aPdhMBD854miE3b6u/OODEQ28U013q4ZgiDDfKfYExal4opmSnw50T9hu+UDpFj3wgsLu92Yh153ltnRe02bXNm3yhs+T/Hq4VK1x+EkBCjIxb7QMTBlqzCtMe7pVq5hEgjnFR7FE2a+TUx50TY6ib6iXtS7c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388378; c=relaxed/simple;
	bh=ps/ePn2bU5KXMMjkXKN0AyznXyAUZlWjIXQJNpTWXd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsjaDb/HvKPpqt34broK/kP5QR6LcsMQQPpf7P7Jg2g0Y420hnyfFJkrjQBmpLElNsVoZ7wtn/CCz0K/NvS7RmDwY1NumsSAulowONTMXFILT4yvmiRRSo7VJFoxTKon8MctcM+/5CQ/0XIRL2gOuTsL76d6/5ntmnPgNZjVQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1tqgf3-0002dR-CX; Fri, 07 Mar 2025 22:59:21 +0000
Message-ID: <1e5dcc30-47b1-45c7-8cbe-0c72d07b88ed@trager.us>
Date: Fri, 7 Mar 2025 14:59:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: fix memory corruption in
 fbnic_tlv_attr_get_string()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski
 <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/25 1:28 AM, Dan Carpenter wrote:

> This code is trying to ensure that the last byte of the buffer is a NUL
> terminator.  However, the problem is that attr->value[] is an array of
> __le32, not char, so it zeroes out 4 bytes way beyond the end of the
> buffer.  Cast the buffer to char to address this.
>
> Fixes: e5cf5107c9e4 ("eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> index d558d176e0df..517ed8b2f1cb 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> @@ -261,7 +261,7 @@ ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
>   		return -E2BIG;
>   
>   	srclen = le16_to_cpu(attr->hdr.len) - sizeof(*attr);
> -	if (srclen > 0 && attr->value[srclen - 1] == '\0')
> +	if (srclen > 0 && ((char *)attr->value)[srclen - 1] == '\0')
>   		srclen--;
>   
>   	if (srclen >= dstsize) {

Thanks for catching that. While I didn't see any negative effect without 
it I have verified on hardware this patch works.

Reviewed-by: Lee Trager <lee@trager.us>



