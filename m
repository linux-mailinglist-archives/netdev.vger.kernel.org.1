Return-Path: <netdev+bounces-147379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EC9D94F2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EF12837DB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDA1BCA07;
	Tue, 26 Nov 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbyws1c2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8451B4159
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614988; cv=none; b=uq1LEun3XrEq8EKwvBE2wI0lcydx/efZjBsk/KoZ0BJP+9RFbIJ46GVqEsJXL6AqEO20Yvp2WKcz1NH0Lc3Zzuyfdx1bq1y5qY4o+pl7xB2oaNwZyhSE1er16X27Jugd6zerQq7nv8ePPrVluakmY3dGdcxGagYzJQ5WgJHrSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614988; c=relaxed/simple;
	bh=qTXEGV1NqvoB9oYQRL651OM5jxH+Id9oPw0Gr+SEBnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J70lLJiWLCHQvyyo/DY74yDLJVukD1xiSBdiFG6ZUydwNMKqvYTV8fNuMReQjQhHGq75mzZUoPOFNCAdaNQmGN0sMsJKyxUEr8Me7oI4kwLGeijJYLKJVmC+BAotVCA+Z7WV85WFppy2BKeKJlRyOH2DwvsRhku/XJcah4tVx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fbyws1c2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732614985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKQIRQM0DHbMs6DhX26g6JtTMb0P+1aEq6LX6Prz7ww=;
	b=Fbyws1c2A0HDLitlM8hGmf6l2mUmy7N9C9EJA3tdLhffHdLBRrCb+ePp4s3TvYgAE1XgFN
	QN4cYjqXNm0XPP+0YQqODEoDuMEjyJ17WxjHPtQmVZLIPnKxzAD7jL71jFHInRE3IZiodO
	2IGdObkTRbbMWmRVLC0M0OXMEO+bye0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-pQZFT-5cNamjDTid83uJ9g-1; Tue, 26 Nov 2024 04:56:24 -0500
X-MC-Unique: pQZFT-5cNamjDTid83uJ9g-1
X-Mimecast-MFC-AGG-ID: pQZFT-5cNamjDTid83uJ9g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3822ec50b60so3066287f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614983; x=1733219783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKQIRQM0DHbMs6DhX26g6JtTMb0P+1aEq6LX6Prz7ww=;
        b=Fkol4extpDFCF+9US/Pbhwetva/G1Nvz0rsgH1LCug9S7Wxeg0pmC/esZZEtze3pum
         lxH1r4qE5opws9sv0nT4VE2IIrWcEpDEGM+R1+0ct6nft3EfosSLem5xH4YQeyIHGIu7
         dIF0w2Pddv5z5Wunoz98uaY5TKlyKWQ8Mc7uUHXpiBeI2qu0vuaPgYPkXYjUNBgP4AwS
         e4YI7ap0FsCHhONRqTZr7YrhCoWM1Gci40XeKZOk1WA76sMhlJIR6WRESmkcxgS7qSG1
         EyKuvfy4CvsnkDKqVfbRotD34uRUacUj1euDsGcJ4aJQ/ojn93QfIKDFiRqMCBLNusY4
         qaGQ==
X-Gm-Message-State: AOJu0YyczfJ43lTZLhS/cuwkP+lcgLD2WPzzbmFmikyWrm8YkiBQORjq
	Vgg302y9YwAe0hi9a1I4X229ff35NWRmVURxlR9WIuFQXtnH5E/D4G/7sdWsIHX36nmFAbtprOn
	nhof76Fm0nF/z4dYMbEqJVFh8GPNIr7ULtOplRUiwjx9IczYubxRB2g==
X-Gm-Gg: ASbGncvZ5fqQ7XwiG+DnLreSWtNae6rQi8P7S/D2VdxA1CmiCAlKc6WiYqtMVR6LhxA
	EBTZK/12WOdiS7Bk448esw2zJqCL1vFOHSwnbqCAVRI9GzVUdsFQ9kEbMXy8aOV/RDPQhqHLu20
	Z5Kr3v/9uWETNauqixVmMcvN3Ee/n3AVn5d4rhHP5SrSwVVIwnvwf9FhYdW1qbJTg/ib1/Dsguj
	iI5JFNysfizqSWHO6RFvWJmzi7r7f/aWs56mjpwjD7tc+BZmRxzC2sA35/qHM23mzXMbHQOfQIn
X-Received: by 2002:a5d:5f53:0:b0:382:4b80:abc8 with SMTP id ffacd0b85a97d-38260bccddcmr13487969f8f.46.1732614982806;
        Tue, 26 Nov 2024 01:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7er+9nxXHPAG3ENsKoLjcP60A9V+9a0RO/xgQmaA3KSqpNdUGKqVrkbSnBm+ieOOasQsuZQ==
X-Received: by 2002:a5d:5f53:0:b0:382:4b80:abc8 with SMTP id ffacd0b85a97d-38260bccddcmr13487949f8f.46.1732614982505;
        Tue, 26 Nov 2024 01:56:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe9013sm13078237f8f.88.2024.11.26.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:56:21 -0800 (PST)
Message-ID: <9a2b27d0-c65c-4954-875c-65ad144bc584@redhat.com>
Date: Tue, 26 Nov 2024 10:56:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/qed: allow old cards not supporting "num_images" to
 work
To: Louis Leseur <louis.leseur@gmail.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Forestier <florian@forestier.re>
References: <20241121172821.24003-1-louis.leseur@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241121172821.24003-1-louis.leseur@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 18:26, Louis Leseur wrote:
> Commit 43645ce03e0063d7c4a5001215ca815188778881 added support for

Please use the following format to reference an exiting commit:

commit <first 12 chars from commit hash> ("<commit title>")

> populating flash image attributes, notably "num_images". However, some
> cards were not able to return this information. In such cases, the
> driver would return EINVAL, causing the driver to exit.
> 
> We added a check to return EOPNOTSUPP when the card is not able to
> return these information, allowing the driver continue instead of
> returning an error.
> 
> Co-developed-by: Florian Forestier <florian@forestier.re>
> Signed-off-by: Florian Forestier <florian@forestier.re>
> Signed-off-by: Louis Leseur <louis.leseur@gmail.com>

This is a fix, as such it should target the 'net' tree in the subj
prefix and should include a suitable Fixes tag.

See:

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/maintainer-netdev.rst

for the details.

Since you have to repost, I suggest re-phrasing the last paragraph,
noting that the caller already handle EOPNOTSUPP without failing, and
using imperative mood.

Thanks,

Paolo


