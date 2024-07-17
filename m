Return-Path: <netdev+bounces-111829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F8933541
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 04:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D1E1F23293
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC21C36;
	Wed, 17 Jul 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiAXh4Eg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E200184F
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181843; cv=none; b=rvplEHZ0Mo8Qo5SgmKAKDPKFGywooLI3vPkGfF7M4ee0cLO3VbJweSPcD0kfYTbQG9zOKbqERZHg6MUTjrsGQhN1P15SfzeHQ1IxiD/Flz3Kp1aZYwzNm5sX9S08VuXi7gK+KkM9lZirvUQB1e6E8CszNnqfa4/NynxNyGi7DAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181843; c=relaxed/simple;
	bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WCc/A7YDndImx4XeFhIudfIfaAxJlbGTtjOTQSog6XNkbQakRmqq+NUao50RJOwAv0lT8e9eTRUwtvibIpIUL0m7A8qGvBsIX5gx4NZLKaYzqPAcoXYXAYll6yQNlwP9Z+/iixAU8LB3B9Tcbrolm0BMa2AIcAbmxUA9w33Twt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiAXh4Eg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721181840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
	b=ZiAXh4EgUre8dlU3aNpPvHPvmihadVnMYmJJxYG7sY9FbCOAZlq5ccHEH2gTEeJaXsSUcl
	9cTv5XBrVPBNGvfTcH+SlJlqfymHVHggaHOJ5oGeESympmG6yzRhbESGLu5cUwEiJbK9/g
	4B4tefaRVZOlSnn2CbMz3FQovS6zhl0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Xze_C17dNNa1q6gne9h-nQ-1; Tue, 16 Jul 2024 22:03:59 -0400
X-MC-Unique: Xze_C17dNNa1q6gne9h-nQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79efed0e796so69188485a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 19:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181838; x=1721786638;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
        b=i/KG/Drhswjf2kt1lzb2KmikR8hoVRgIPH2g52Rc81uR5Ch2nn5qrqDBlj8c25l7vN
         usIBr/FAuLhr0JsDTtQc3bA+d0Y7nki2jFCsLuV+TdErjPJQnAEhbSUOMkKRJ2Zn/ZLX
         tESoWaK4W44XTdCV2HT48m0rEzhUsnXERT1ZwSTmG7KIjOyo1fnJ2cFE7Pelv25pnKx+
         Fctt6pQKKvBxRUGOq43H01rJvBAhNOClNqC050XUL3ewjsvmbnN5eVh9Hx7YiEmPY01d
         BG3x9F3WGQ3MmVDJ+YVINZgQnLNMLEQEsKLIKjcJhaFREFe8j1suQgGDPjvzHF9Kr9Yb
         XOGw==
X-Forwarded-Encrypted: i=1; AJvYcCXP7Qjr1X6/E3Ed1TWZC+Lwkm7kJuX6f4gqtCPgwc3PuQIj49RSk+b8cc1dgMMaPu1sb/P3sWDAsWQOLeSo3d+zVlgjvuVG
X-Gm-Message-State: AOJu0Yy/n4K5Pmg0IWOU4Pyu+gtTgnHQ8GMfxilAt63+Yvjs/ThCe8Gt
	RqdLKCP52ctBN+oElup7udWlr9hK1g51y0LmKEPbZbNtRlVlTYdRrfmNieoNrzfj4h0PmVQVJf5
	AxVbOJqbkA5ED6afdwosNK/wXe0t32CV+wKwu0ADcfPeQYn7m/cHXsw==
X-Received: by 2002:a05:620a:294e:b0:79c:ad5:cd7d with SMTP id af79cd13be357-7a186eb6d93mr58860385a.23.1721181838622;
        Tue, 16 Jul 2024 19:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcZ13hx6uL+FJZ7QUBpqM6DgtsKq91qaLvPtXzJ6FXcTNBbI3o6TNmDVvqg9/yLg3dDIqZUw==
X-Received: by 2002:a05:620a:294e:b0:79c:ad5:cd7d with SMTP id af79cd13be357-7a186eb6d93mr58856685a.23.1721181838333;
        Tue, 16 Jul 2024 19:03:58 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b84715dsm41346281cf.91.2024.07.16.19.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:03:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:03:53 +0900 (JST)
Message-Id: <20240717.110353.1959442391771656779.syoshida@redhat.com>
To: tung.q.nguyen@endava.com, pabeni@redhat.com
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
	<AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Tung, Paolo,

On Tue, 16 Jul 2024 13:29:08 +0000, Tung Nguyen wrote:
>>If only this one returns a negative error, modification to the function pointer callsite will become prone to errors (and stable backports
>>more
>>fragiles)
>>
> I really do not see any issue with returning a negative error which is the correct thing to do. The function pointer call returns 0 on success, non-zero on error as expected.
> I do not see "prone-to-error" when it comes to backport.
> As said, problem is returning 1 in infiniband and ethernet media that should be corrected.

Thank you for your comments.

I understand Tung's point. Returning 1 is not descriptive. But I think
addr2str() functions need consistency for the return value,
i.e. return 1 on error.

How about merging this patch for bug fix and consistency, and then
submitting a cleanup patch for returning -EINVAL on all addr2str()
functions?

Thanks,
Shigeru


