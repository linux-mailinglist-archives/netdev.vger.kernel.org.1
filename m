Return-Path: <netdev+bounces-101438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1A8FE864
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B22C283DDD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602D19751F;
	Thu,  6 Jun 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU0hRccN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A016197513
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682733; cv=none; b=SJU60inZUAiAtYr4b3dTBft4XVcmybvGuda/xEXJD7UZez18G++SEkOETmvUxmXs7I+jTfUBUlj4YfvVLs5DTMnhDC7izWi6QGqzqF5g08ptUjflC80W3EcuYkvhzETx/w9zZFwnl69/lt/ET+aJH4oQof2w/aAXL9SgFGAG//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682733; c=relaxed/simple;
	bh=Q45IMW11Cj3YkI+0qiE/9sP+n6AQlpiWwHUmH2Ip1J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUrBiuBvG2Y1dvWBZCrlTbN7Agsgl2+sl1e9HyzuonzBaoQa00SSLUcxhWINroRqTR2L2ogv8SVhXME6jQS94I2P7xl2qVcMNtlKiLmUAnxgITA+GhXCktlw2lVEgTXbASAxw28fPYDr7tfDiDREjkoPWlpsPGXglBDlhqYZmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU0hRccN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717682731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q45IMW11Cj3YkI+0qiE/9sP+n6AQlpiWwHUmH2Ip1J0=;
	b=DU0hRccNgRoyIxg1UpRmJtizp9bEAKMmD0JBYa3BrXOlND+4CaM5Cp9Igt3LdfVWumljJ2
	RJOTo21twPnM5I1z3p6/drn1yi8vsNKXCbo3M9GNWvLuLc6rZ/PDPm+Cy2tO0HjUBu+rJf
	9qvbYawNaY67utRY4W23a/5THeJikVg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hZjurJmPOEyZqwbJhJJyJQ-1; Thu, 06 Jun 2024 10:05:28 -0400
X-MC-Unique: hZjurJmPOEyZqwbJhJJyJQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a68b41fb17cso192193966b.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682727; x=1718287527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q45IMW11Cj3YkI+0qiE/9sP+n6AQlpiWwHUmH2Ip1J0=;
        b=fYTYm6xFBG+X33nsoEieYK5WGZDRqaVQyuyIk+5/BL2Qh2J++Gx3kSp+2GmPJ+KTV7
         U05sc7Qw0EYqrjxGIYu5TJbJ1s2x6MHsRnlO3x6LYrRh7+UvIWCLhXoTb7Eg893oebGM
         HTb+3Y2ZVdI+/bufwf5bw6Yn5o/zOpX9do1CJ8I2N58+MMqrSnfjumNGK547H6O3bkl3
         lFHgYzOP6PM621cI70sGM5jFS47F3Lo9UROMc2XRIFQD2PmRqU5xBhyRVxxPjyiV08fF
         ticQqWXdGY3d5ZL60oSKY3yN2/R0Ht4zX0fcBnkWq1EphznbVSPE+501SYE7VUPyrrx/
         KDSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdaGermSJahrulInP7oSCIxMCF4QCmwapaCNHnYXWdx5cDnbZ59Le4GJXHJCnowxgC4YZ3QcrXSlxPcMI8aAPGQ7iHCTEI
X-Gm-Message-State: AOJu0YyK1d+IyPm76++HreCl4tEH9IE0T2V2pbFMFOnRooSuVXzhl316
	00dT+wY7/9KSx2SieXNEAiHZEwGOX3aVUVhKoHX1qU/sDl7ssgGUvFpnzVa58cl1y+WzY3piSmZ
	ckRgkKUC9XkmYfej+Ep8jW5cucrV7RorVC7Bk9Eu25vmZG61Iv5+WUQ==
X-Received: by 2002:a17:906:8db:b0:a69:20ba:43cd with SMTP id a640c23a62f3a-a6c763bf0a8mr223354466b.26.1717682727464;
        Thu, 06 Jun 2024 07:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/nI7+mU4+sllVVTn5ujhOOhLLIrT8H5XfsVIDMgWu8m+zkD2Zj13ABL0KagKe76r2AGgQA==
X-Received: by 2002:a17:906:8db:b0:a69:20ba:43cd with SMTP id a640c23a62f3a-a6c763bf0a8mr223353266b.26.1717682727118;
        Thu, 06 Jun 2024 07:05:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-82.retail.telecomitalia.it. [82.57.51.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070c334sm102516466b.149.2024.06.06.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:05:26 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:05:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: namespaced vsock
Message-ID: <5cpsru7f43jkks3dxov6ezqs7yfxdvsh3agyp7bvquwb7by5pc@c4i5gx3w7vzm>
References: <20240605075744.149fbf05@kernel.org>
 <myowlo6xpjrhbawt6sptwcqktm34zbfnsxzyo5eahcbspitwzq@ypssm5pe6q7m>
 <20240605142252.466c3af4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605142252.466c3af4@kernel.org>

On Wed, Jun 05, 2024 at 02:22:52PM GMT, Jakub Kicinski wrote:
>On Wed, 5 Jun 2024 18:00:25 +0200 Stefano Garzarella wrote:
>> On Wed, Jun 05, 2024 at 07:57:44AM GMT, Jakub Kicinski wrote:
>>> I found you patches from 2020 adding netns support to vsock.
>>> I got an internal ping from someone trying to run VMMs inside
>>> containers. Any plans on pushing that work forward? Is there
>>> a reason you stopped, or just EBUSY?
>>
>> IIRC nothing too difficult to solve, but as you guessed more EBUSY ;-)
>>
>> Maybe the more laborious one is somehow exporting a netdev interface
>> into the guest to assign the device to a netns. But I hadn't tried to
>> see if that was feasible yet. I have some notes here:
>> https://gitlab.com/vsock/vsock/-/issues/2
>>
>> I've been planning to take it up several times but haven't found time
>> for now, if there's anyone interested I'm happy to share information and
>> help with review and feedback. Otherwise I try to allocate some time,
>> but I can't promise anything in the short term.
>
>Makes sense, thanks for the info!
>
>> Do you have time or anyone interested in continuing the work?
>
>Depending on the priority compared to other work, as usual :(
>
>There was a small chance you'd say "I'm planning to do it next month"
>and I wouldn't have to worry at all, so I thought I'd ask ;)
>

Yeah, I know :-)

Let's keep updated if plans change!
Stefano


