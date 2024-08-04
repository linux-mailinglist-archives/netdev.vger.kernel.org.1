Return-Path: <netdev+bounces-115546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CFB946F97
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B55F1C209CC
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81F42077;
	Sun,  4 Aug 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrrwF1Pz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC9461
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722785519; cv=none; b=N8gj6unWrPBAvK1KQkSli254FJx0bwMpWl9yNfLVvEh0LnA++73HXwvt0pCCVPxO0YlbZt757kTS6c7Gnxqhqcj/7DfBDoLa70+noIEbNviuxY2wcvEXcJ7+VSwVHuq065HClkt9hyjXwPe2Lv1lY3NcNfsoUHWAJg01aEy3dUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722785519; c=relaxed/simple;
	bh=e3S0PVJHUscfk3m6DXwEfkefO4lPOcfNS+1F/JZNHXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mttEzA5t+TR2YXsATxPwEFUHAeNUAn+0jvYeSSLXmZooy0yOeIKp0nEl6mPhx2yr+/FFCG08hF9ybHIEg4ubkiKgZVhoEZ7UvWamEUlwssscS9L9BqTGmTOyv0I4PEvclWNGZH7/7CGYChwiwrWW1v/ddVB1cpD66tAzv48tkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrrwF1Pz; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8036ce6631bso394967939f.1
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722785518; x=1723390318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+N6nKtGdajwoqkOXody0ch4ApPs9gFE0KsqkSaU2cBw=;
        b=UrrwF1PzjuQY5T/ot5h5mkFHZeRWnoLB4VWM0klEzD+TylsNpRYYuNshNaUcAmkDxB
         edPRgxO8c/FgrsYtXaLsarbCBF2+8s+d83NvCl1PLMq1OMueJBcnfYwp7hGr8+DlIgPU
         317P7oOEnfE/9VU9ZvB+J1aEWPkT4SfCTYew5dC6O4HuS05ReFR0jY8fODgmRr9TtPrP
         XmFZOGeIY6iOKA+hEDXiaQueO7Lh5lDHV9veKy6jyHJ22rsyjVCiMDptHR5sPkCICSN8
         4LatXtE72UQz5Jczx9a+E2zjSEM8YVrRtHKwUBVHvLHsjmCHF+Cv86M1SdN0yaqA9zA4
         1fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722785518; x=1723390318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N6nKtGdajwoqkOXody0ch4ApPs9gFE0KsqkSaU2cBw=;
        b=c3gvqAKQCQC0rjDlTNNyhg25k9s9fpYXR8I9yok9/egMp6OQXOMXebv+DQEaVwmyTG
         h8aVtnchww052bPSkP0SgJ2VmlqUh8Nt2fF+oqMUpz5L/ORDc82p4Gkz0JUT49O5zgDy
         relFzNOKctqwvEOxxAJvjy0Iu8yqpwAWNCTMV4SQvyIn2ZZH28yhXsjx40FhQpsqQ0os
         x+117H5sNjwX+myqIHSG4ydJpzJAb6Ba+1lZBaxBV9WIYmpDY3cro0vC+o0M+hIpYVkX
         3WFmqXhy+E5lnkFbJHCaBmt/qpOffLBAQcqR2/0njvwsu/cr/JwVVFEpcblZlBWgsFiL
         GRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWr8IuUl0TQa2SifRBPYkWYNey/fP8b7Kmc3V4+CIA/ZRi0ppsn0+dPBr7TBkGG95auoDwAH4qLsdKJh/20N+oJeIY8mW3
X-Gm-Message-State: AOJu0Yzc0tyBHIf5FQ3gqux4ptnTskuO1Ohzi2oiC0t99QAGgFYvw6IQ
	PI75mY89OOiPbciHD7SKdBi1XsiLjw0QcYNWF6RZTY+FMkCRg3oY
X-Google-Smtp-Source: AGHT+IEnM7CqmZ9C04//VD6tXveo4CKmm4s8t4l+ovxw0QXoQFv9HxKVnjkltjAW/n/9qfbD9WARig==
X-Received: by 2002:a05:6602:610d:b0:81f:958d:f597 with SMTP id ca18e2360f4ac-81fd43564c4mr1215717839f.4.1722785517669;
        Sun, 04 Aug 2024 08:31:57 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:d96e:fd44:6c4e:beb? ([2601:282:1e02:1040:d96e:fd44:6c4e:beb])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a59d5bsm1341656173.162.2024.08.04.08.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 08:31:57 -0700 (PDT)
Message-ID: <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
Date: Sun, 4 Aug 2024 09:31:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa: Add support for setting the MAC address and MTU
 in vDPA tool.
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
 jasowang@redhat.com, parav@nvidia.com, netdev@vger.kernel.org
References: <20240731071406.1054655-1-lulu@redhat.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240731071406.1054655-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 1:14 AM, Cindy Lu wrote:
> Add a new function in vDPA tool to support set MAC address and MTU.
> Currently, the kernel only supports setting the MAC address. MTU support
> will be added to the kernel later.
> 
> Update the man page to include usage for setting the MAC address. Usage
> for setting the MTU will be added after the kernel supports MTU setting.
> 

What's the status of the kernel patch? I do not see
VDPA_CMD_DEV_ATTR_SET in net-next for 6.11.


