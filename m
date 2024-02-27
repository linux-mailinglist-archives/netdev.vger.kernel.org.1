Return-Path: <netdev+bounces-75310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665186917A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFBC28FD43
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651613B28B;
	Tue, 27 Feb 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZIY3lcaY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6713B285
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039670; cv=none; b=DLlX/4nzqXmaCHv6KND3IV4W9pa2Cu0wuQmheW0uNLt6dBoWoKrKKj8d/PEgrKVYV/J1k7bPp4UNimcbHi/uE0KjtzB7v4Jw8aYPzA/dl5Z4FILB59v/7czXsTPGP95hmeH0CG6tszuCNYCbkDX4jtywWT2F0ERI0Tb46iD9IH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039670; c=relaxed/simple;
	bh=ptRFBXO9Jpg8128ah9oHQMEu8XEuCDUQRkxKmyhlxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA6NEpLJfqfU1oBxKNbCYaI7aVv4OuVF1QJU3qSdZyPSzfqwSA+qXOaUBVCH9xrB63OeuNThubtkwTVxfbGepf+U4QCxvlH3D6BIuWe0IwkzWFhK2RF6bTtvGFMKHm536c7eSMLfMpS5L284I9ZNL1lw05WAijzmKV1FQXbtgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZIY3lcaY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so70041431fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709039666; x=1709644466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaqJXVS/o9ZLjDcC3LExNS8YspO5mJ2Ato/Q0hLHtpM=;
        b=ZIY3lcaYC0ZL3aY957sQJ93bBTle60UX0xFcLWk/to1sm7ZH4GYLo7IjnmMeOKI2UW
         d6CqLGwkewrrLK1CKNvlrDVOLd15pZITjcbER5tEBYtIZ2FEZQF4qOggFXsTFT4GRO81
         zNMGamCigjFGCVfZ4Vq7sMDrrQDr2OYji3AzNfdYBCtvleixRVTfXua86nMhmuDwvJlW
         pj/RXfK9/EZ1BgS/sn5nDUmvbFim2EsEkA00GRm9zrxkj22h67NF+8p2abkg7rEDbeIn
         rHxt4CFot27FvztGJUPm0MLAxcIoQD4ySd1SW25yDeigXIhSVat7NPDsuzAnUPdU8YCE
         6iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039666; x=1709644466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaqJXVS/o9ZLjDcC3LExNS8YspO5mJ2Ato/Q0hLHtpM=;
        b=eawsOzr0eWx3av/n/ylf9rrpicrrTfvC4kGVGKlZjV+MUAt+LSK/grFgmrbFZgaU+J
         2EMy5eiLwhiobkWA1hjn+NaSDwilhH26qwDQu+XUdFcWAWpHbmzzL+LM2Y9tGzeEZbj6
         9XQ5lYJi60aqgvIkfNX5L+uHoK+9szNYjidnBBib6z/9R9rJdf3TSUaXAtsE1yK+2Ka8
         kjfQKxJdkRRXvN+gGBepxEUks5wV78T0ODxkQM2iAHKjHPQb+OAGU1O1KY9a6+YWTP0T
         8o/5QwzkdnkwLMTbTi9Y4cfQ3zfWdEpQl1yWF/c4gUvsU6kxgijE8ODKOX2/nrbipNsM
         EQIg==
X-Gm-Message-State: AOJu0YxqMYWed3CI+tlwI5x263759tje0RFNgbL0qKdyDFLOvYiiSSoh
	cFsBA3ObJ+LyuJzogwGPc2rpsgoqo0Wh0dm3TKvcCrBPbM6xk2SDy+0ZHbozoow=
X-Google-Smtp-Source: AGHT+IHpjC36J3Q+WJOGBOAur6xPab0p/dNZi1zN9BC2HwfKmlYBwHXsetNgRWncF7WsZpwUw5Ak4Q==
X-Received: by 2002:a2e:9999:0:b0:2d2:65ff:3b78 with SMTP id w25-20020a2e9999000000b002d265ff3b78mr6030020lji.35.1709039666300;
        Tue, 27 Feb 2024 05:14:26 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b00412b0ef22basm52304wmo.10.2024.02.27.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:14:25 -0800 (PST)
Date: Tue, 27 Feb 2024 14:14:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/6] virtio-net: support device stats
Message-ID: <Zd3gLsIfhMlvm_0T@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:02:57AM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtio net supports to get device stats.

Okay, you state what hw supports. It would be nice to throw in a
sentence or two about this patchset (as the cover letter should do)
what it actually does. Some details would be also nice, like example
commands and their outputs to show what is the actual benefit
for the user.

pw-bot: cr


>
>Please review.
>
>Thanks.
>
>v3:
>    1. rebase net-next
>
>v2:
>    1. fix the usage of the leXX_to_cpu()
>    2. add comment to the structure virtnet_stats_map
>
>v1:
>    1. fix some definitions of the marco and the struct
>
>
>
>
>Xuan Zhuo (6):
>  virtio_net: introduce device stats feature and structures
>  virtio_net: virtnet_send_command supports command-specific-result
>  virtio_net: support device stats
>  virtio_net: stats map include driver stats
>  virtio_net: add the total stats field
>  virtio_net: rename stat tx_timeout to timeout
>
> drivers/net/virtio_net.c        | 536 ++++++++++++++++++++++++++++----
> include/uapi/linux/virtio_net.h | 137 ++++++++
> 2 files changed, 613 insertions(+), 60 deletions(-)
>
>--
>2.32.0.3.g01195cf9f
>
>

