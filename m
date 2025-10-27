Return-Path: <netdev+bounces-233114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF4C0C98C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A332E19A448B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2052F3632;
	Mon, 27 Oct 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVuS1ift"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858502F25F1
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556116; cv=none; b=C3c1vFH5V6LT0lJZ3PqX8hrKJUNA0JNKGaHMb+7MmWnrSnCcNuqpWUEUV1zwoPXsOgPQ8js+hv7NpwmXwduZhGEWSlkILrE4x21Y0idAW4VOFFecs7CaEfsf485IuRbbHJlc9FUuJwk62Rbvlx8sWwjuw0lHKj9sp3msDu55on0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556116; c=relaxed/simple;
	bh=KMLUCx37oodkWW/ecGieGDWDnscNn3RkvSQo3ZEJYSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2Zi61tgj7t/D+IDUHAZjOhrUDkiD+BDN4AbjfxuHUb7OK7k1dSz2KHdHY/0WBOL6H1tGAlAqC8UGYSwq0X4w2bZ908Rutn7rKhOtOhxUbG7D24i6YVqz+kVywnm17XJVAPtp81QDZCDXtOP1+nz/5RQM/SRSqszpI2RDB6j8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVuS1ift; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761556113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTIAdX/dwL5w1YKSS37dOxKFZ3s8yXzfHwYPH8iK7Nk=;
	b=CVuS1iftjMeJFmDczMVmCm79QGPkVS5OkiXawohadoSfucVmYeF+QrOkJugmpIMoYeXQez
	/TqxMekZiokPQ+qBZ0iDieyiSxK+6IZvGQXD82r2lZWpJ5tL52dYcvZ/u2qiWTcpaIE+4/
	wpc2FsaffVnCkH0zEOwCj7MlLndZN4c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-JhhY5nsMP_-U--IKn9Wj1w-1; Mon,
 27 Oct 2025 05:08:29 -0400
X-MC-Unique: JhhY5nsMP_-U--IKn9Wj1w-1
X-Mimecast-MFC-AGG-ID: JhhY5nsMP_-U--IKn9Wj1w_1761556108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308BF180035A;
	Mon, 27 Oct 2025 09:08:28 +0000 (UTC)
Received: from [10.45.225.43] (unknown [10.45.225.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94A9D19560AD;
	Mon, 27 Oct 2025 09:08:24 +0000 (UTC)
Message-ID: <b479b307-b590-467f-83df-837259a64b6c@redhat.com>
Date: Mon, 27 Oct 2025 10:08:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null terminator
To: Petr Oros <poros@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: mschmidt@redhat.com
References: <20251024132438.351290-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251024132438.351290-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 10/24/25 3:24 PM, Petr Oros wrote:
> The ynl_attr_put_str() function was not including the null terminator
> in the attribute length calculation. This caused kernel to reject
> CTRL_CMD_GETFAMILY requests with EINVAL:
> "Attribute failed policy validation".
> 
> For a 4-character family name like "dpll":
> - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> 
> The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
> overflow of constructed messages") when refactoring from stpcpy() to
> strlen(). The original code correctly included the null terminator:
> 
>    end = stpcpy(ynl_attr_data(attr), str);
>    attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
>                                  (char *)ynl_attr_data(attr));
> 
> Since stpcpy() returns a pointer past the null terminator, the length
> included it. The refactored version using strlen() omitted the +1.
> 
> The fix also removes NLA_ALIGN() from nla_len calculation, since
> nla_len should contain actual attribute length, not aligned length.
> Alignment is only for calculating next attribute position. This makes
> the code consistent with ynl_attr_put().
> 
> CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
> null terminator. Kernel validates with memchr() and rejects if not
> found.
> 
> Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed messages")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


