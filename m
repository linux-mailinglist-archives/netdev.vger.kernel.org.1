Return-Path: <netdev+bounces-203760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C7AF70E6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC571C4802D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15F2E2EFE;
	Thu,  3 Jul 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCWoYLzX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943772632
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539838; cv=none; b=qcrMedYeoQ7X1KM9mwoxMlsCHrdrplF66dIjHfycFj9R4Iw5dwyNtRf6fRweySi932MIxX4LnvJbMB6lLbE+tFeNPjL+OpX8aEGQ65wV8us8IC74AINhYo8ngplE/xtm0fog9PpAeiCFQHTWky/kS7OsQAkj5Eirt17CL/aN6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539838; c=relaxed/simple;
	bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN5DRNfIUIbOjMz9m3HrjBY8fVKnuspHFG452qvhLj7iKgHop3gKT+ww2QE1mbUDiIImsPHTop5lCLIaMDuni8wP4/cjMYEsXrVAUKuNEQhsLTskc83zGbGd17DHxOp8voZajdQs1I4gH0CjFLmGjNzBqIxGLuFEqChCJYE9oTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCWoYLzX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751539835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
	b=cCWoYLzXt3kQH6X9vDoaUPRmOmA+p3aR0oPtvHrBiUmxjAzwZlGXcgr0GM9OSpWTh5gri8
	GrdNFed14o1fMYpSdn2LwB5cZYlXM7SkXUHhsEvaRu70pLcNQPjd4DKjshRXXWvbeAfQo1
	sX9J/to0LNmYOWi6zXc8GLlmD+ToS6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-xiML0q1-OjeWocmYWQs-MQ-1; Thu, 03 Jul 2025 06:50:32 -0400
X-MC-Unique: xiML0q1-OjeWocmYWQs-MQ-1
X-Mimecast-MFC-AGG-ID: xiML0q1-OjeWocmYWQs-MQ_1751539831
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450db029f2aso35775785e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539831; x=1752144631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
        b=xIJ29sZNOitNAtLDLivFCl/rvPwvBFyewNKlxxb9Z8/9vLhVf9G1KkJhlh0j53/bW/
         xz/yW7hB+Niu6LWwAJ6OsQ7pJkRGzG+wcvrHXmR7Vf2zdAAFmAS3oNbTqfSF3onL+3H0
         rKfmV3RGcnC8yXpXrLOBxtWOldERhKXLqGccd/u26NHXeWxjKtCHw4YIF3jH3/Ofnj2/
         fl4gdgKCxA/TZm0Liw8ihjujtZuIyiz14AnlBdzFDinjpAKPmN9PLajrYJZryOYpXN/e
         8Tok46WgqCsuZeUlg/OkZIklpwM9rjdNdlQ5PAFi3lagrU++SmsHbDNc0y7cFB6tZAr2
         gjrA==
X-Gm-Message-State: AOJu0YziMknJXJChfQyoa/YNFq8AMIsLdBbKC1m3Upatci+UGtYfof8P
	WoYAUro7miJyWDDE5Ps/8ZXsL1/TNRZabOaqZKrEO/VOYTO/ConGDHp7I59KCIRF/3Sma20jXfS
	66TZFjXIN7PeOIQOGGaNXlKuVAawqwmBo/KpMx/ddsWX3XWQ3a+nlrwzkhg==
X-Gm-Gg: ASbGncv2w9uNkXsI2MFrnRLvT8Fd/5APIZd17W8sByioe1FbKbPE5Zmo08AAtCSOXOF
	RjID9btYimpYmy8h3o1daMBtKk2ITauxYef4Ak4kmec8oKNa9xQcCK1B43ao6E1IoVZNXqQ7NUc
	simqeyWoBZV5efUmZFB6Xu/t846RumNy/d1O+AOe5NsIkcA3zV6kCk4WlmM+g7XzpwWHG+w8Du6
	onQmXMXvLemKS4ImxS591p+VA95+sH69Dnpwt6EBu9zQve8x+Lnk4jcJrXnz3oJXHHezpw/Jiw+
	UwJ8dzdLFBW32S7hnKMPcfPTwaof
X-Received: by 2002:a05:600c:8b77:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454a9c8b237mr29470995e9.5.1751539831111;
        Thu, 03 Jul 2025 03:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzDX+vbYuYqXz4dknV8AbAZbalPiUFcm+rHJ2WbwReCp9n7u2EYHmOh5K438umgtQEGSI9Og==
X-Received: by 2002:a05:600c:8b77:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454a9c8b237mr29470635e9.5.1751539830522;
        Thu, 03 Jul 2025 03:50:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e24bsm23279805e9.16.2025.07.03.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:50:29 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:50:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <756ms3h6ayqohczk3426xnzoby65luxzrbxblqvgl4ezlcqgph@xjz5m5qf5jew>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
 <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>
 <2025070144-brussels-revisit-9aa3@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025070144-brussels-revisit-9aa3@gregkh>

On Tue, Jul 01, 2025 at 02:56:14PM +0200, Greg Kroah-Hartman wrote:
>On Tue, Jul 01, 2025 at 02:42:10PM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>> > From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>> >
>> > In vmci_transport_packet_init memset the vmci_transport_packet before
>> > populating the fields to avoid any uninitialised data being left in the
>> > structure.
>>
>> Usually I would suggest inserting a Fixes tag, but if you didn't put it,
>> there's probably a reason :-)
>>
>> If we are going to add it, I think it should be:
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>
>Yeah, I didn't think it was needed as this is obviously a "ever since
>this file has been there" type of thing, so it will be backported
>everywhere once it hits Linus's tree.

I see, thanks!
Stefano


