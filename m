Return-Path: <netdev+bounces-221253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C124CB4FE4C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319415E42B2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB233EAE1;
	Tue,  9 Sep 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qiajghg3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177333314D4
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425875; cv=none; b=F9UJwRBQKD6xwuypnpp/kRsAqQbQOLc3sdsH+aSRAXK/aDT+PSIHVpRgTQO5lYH5n6Bps7E8r2VmdLPPlnjf4O0g9l6DMr+wE9TeL8fKAHh1SqH7bLXdQssJLpwM3sfpnBEGf4eUzvfLT1Oj3I1ZlJ5CabNYe0R3rY06lNbUd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425875; c=relaxed/simple;
	bh=1PyqPD5jVfrMchorMpPZvg6gawxeApjId6FmaU7IIvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtfhTVF0rvE46iAThMF2XSzhd/5vwob5wSWh7XxF6j9G/cqX4dwqpWqXyypZsQZq6PzgD7ujue9K537ILWXesJJ6KVS3WJ84GN5hd41Jd9y9dOcFABshu1skV//CzfYsA1E4N0Z5SJOb+FuUCxid3Iu+t5KgIX3tuUcOk1kof9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qiajghg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757425872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW8cJBejBUH9QmveZ4V7H3WvRCsiNBOrGQGOGWAK2mo=;
	b=Qiajghg3lrWb+ziYhnrS/yrGObiG6iaEjjHTeb/VQNBcxr9LaFfV9w9JRrNc4EKz53XlW5
	5hpTx/hv/18cmCgu66+Yg+7kiXQFb/sqHVLu9inz3+B0oMj0uM6lkBiqdjsJwswoWjAGms
	y+sOXjkmGHmWgqXjWrjVE7O50hxdhFU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-fC9Jb6lDNjexUREqoHN8SA-1; Tue, 09 Sep 2025 09:51:11 -0400
X-MC-Unique: fC9Jb6lDNjexUREqoHN8SA-1
X-Mimecast-MFC-AGG-ID: fC9Jb6lDNjexUREqoHN8SA_1757425871
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e751508f3aso488446f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425870; x=1758030670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW8cJBejBUH9QmveZ4V7H3WvRCsiNBOrGQGOGWAK2mo=;
        b=dMNAKJjnahFl64r4xL/rR3bMI33XeWun5XnkfVBSqetwB5f1TFEprtwYkDfaQsa74q
         f2Ne0gB+5JCRkmblHN/QdlPi/SLdHxIxSqnBccL1BjVSO2gS5MCffF+YgFfK/S7HKBeS
         WQZ2QJFNSXyODAxG2TrQiRf8SROwniGhdldLJ8ZwvR5S3kzlYOZ+Jz5F4SlQLRaTegsa
         1ZXF5YY1QlEAxvvzhPI9mf+DddgVuHKNFyC0KKYdX6j12lX2V6mbZDxqm4nPwRhjR2pk
         M+SG+veBWxZUUa5i6D8ONKCWDdth0KZGytQrxvn+zRGnBV3zihMgjCssEWH0lFieMHks
         ahTg==
X-Forwarded-Encrypted: i=1; AJvYcCXe++l6ZfKWKSTsak8YmEGYmo9qUfNrYQtq8h4tgDYC9gY2gj97mAHZf/MyEzRIDQX3xltOU+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExF1rQd/T4lEN8RNaELgiZw6vCRBtpDGs20aohg1kIIXxIQ0q
	ycKYv/QqKnrgWx2ByGYgaKfobUNbIV2ADBOyMSrTMyqromXaEcRpOmJ4RxYooajOnj/3h4LTsZZ
	2lZFGXD9cuOX38l20+jIy7rvlhlS6IprB12kufxfIE4+ih+aw2+RufymYWQ==
X-Gm-Gg: ASbGncu0SctL7i143Xj/ka9dRliieaBiRsG7tmg757LDgauC5IDV0PIMAypQ+LFHJ6e
	GlXNC/kJYg/BPf89TnLjs4pyhd3g7p+qiNlg/ZIIWzL7M9SPMySww/11Y/ICxe59ZFUNT0UcUWZ
	1fT+JPFqkt9aZtt45pv/X9iQvJAduQeWobmex6Kgwvb4l8mWvN3B4u27mzVbl2syT+zAeQU7itj
	Qw53/k4gq0kOfdiqyMR4JokLAOYYqnjeT5ytBpb67vynv26jKseH4Jr9ryKWQ535USZ1z8qBbVW
	QdeV6/GlZsFtuHlNRiGEjNb5XqghOdv92rtKS3HfoeTxsuAtUJmCMuKUhbVtUhKWsuVMnsriP7M
	9wcn5T9N88UU=
X-Received: by 2002:a5d:588f:0:b0:3e3:34b1:8342 with SMTP id ffacd0b85a97d-3e643ff65bemr11511553f8f.40.1757425870490;
        Tue, 09 Sep 2025 06:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxf0836JfMibH7BDALsxhDNh5QnDvbliGYZBlX0yCx/tPu8Sg35MgUvPGQD3nOhA5oKTI1g==
X-Received: by 2002:a5d:588f:0:b0:3e3:34b1:8342 with SMTP id ffacd0b85a97d-3e643ff65bemr11511521f8f.40.1757425869968;
        Tue, 09 Sep 2025 06:51:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfdc6sm2744898f8f.8.2025.09.09.06.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:51:09 -0700 (PDT)
Message-ID: <50b21c92-3bcb-42f0-b006-df3572254f8b@redhat.com>
Date: Tue, 9 Sep 2025 15:51:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-8-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904221956.779098-8-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 12:18 AM, David Wilder wrote:
> This selftest provided a functional test for the arp_ip_target parameter
> both with and without user supplied vlan tags.
> 
> and
> 
> Updates to the bonding documentation.

Quite a strange formatting choice for the commit message.

> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  Documentation/networking/bonding.rst          |  11 ++
>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>  .../drivers/net/bonding/bond-arp-ip-target.sh | 180 ++++++++++++++++++
>  .../selftests/drivers/net/bonding/config      |   1 +
>  4 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

Does not apply cleanly anymore, please rebase.

[...]
> +# Check for link flapping
> +check_failure_count()
> +{
> +    RET=0
> +    local ns=$1
> +    local proc_file=/proc/net/bonding/$2
> +    local  counts
> +
> +    # Give the bond time to settle.
> +    sleep 10

Can you replace the above sleep with a loop explicitly checking for the
'settled' condition up to a longer interval? It will make the test both
more robust and faster.

/P


