Return-Path: <netdev+bounces-81040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430688590C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B081E1C21185
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC876038;
	Thu, 21 Mar 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sft0ykV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CB5A4D4
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023955; cv=none; b=njBESFXVfWsfob/D33CksuRMWfcli0UDZsCK9q7FXC4PlUQwXBN8GJoHMe1KQAAHU29SLm9OMLsZuARgl27STq0DaWkk3CVMmoMBYMluVDbqtMVANRvChHwGBI6yneHNy0BlfkbMArohELwjJpl3Gppy21caaljJrOwP7uffRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023955; c=relaxed/simple;
	bh=f0UFDOliM0/oFqbShrqNpo9zCLLTLt/hpgBvhtyDe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGby/dAjnWZwfnmUN97K/PoMgYxLJWeJbE8mwWvpobzsy1JKwFgWGKn+Wfq51wDsPzMB2ZQ3tZT/qjwf7ghM0T+u32xaoLP1piCilPLT4mizPiOBPpjsnmyGfdCTYExN14oKZh24J5U2LvQfdIcfcFWEcAngsy8sK2hVp8PxBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=sft0ykV+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ececeb19eso480811f8f.3
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711023952; x=1711628752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m56XLFlbHMb5W7WCW5wQ6I/h2Kkdc9w2hy23AT0x+8w=;
        b=sft0ykV+UrAfrPgr79cd80zj73jXjxyorNdZgOvu3AVF1TEcM6ls5QF2r2koABIUuY
         cp8VcWo43NwpgZGuMiWXZGcieTkyoISFRQfCD6PPVYL54AcoS9MfPDf/LIe/LFzAFyhI
         W74w+NtDy2s9h/UDR7fY7d0rPPK6NJX+Elrj2bLzowrQ1AYcNZa9S3+fzPTluNOIEgbq
         18sU0BlfYM0uIa3yquTlDwpf4u3YJu0Um8EiU6V8Il4g2kp0fzp4UxLdwSvxTsyh9R82
         1yTP+ffIGD6yIZOBUcUABPjZoQn/7T7bimRgJ2t3wQ6euX0gIWRL66wTBun1zv8QNqO0
         18Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023952; x=1711628752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m56XLFlbHMb5W7WCW5wQ6I/h2Kkdc9w2hy23AT0x+8w=;
        b=BiXMDGTf960xHgzuTFDvGLQEU13+w6tAlEfGtP4The45HTxrJ5c5QrJHI6mETVFclX
         WzeexBfEbDhUt+sGMOSJiB8PX1azv57DUxmslZ7HWLNoNFajdbW76ZpXcpHHvm+qgfq/
         bgN6W8x+aMN+JyP3MhPBhgK88/gvj6/Ui2/nAE/znQ4YowdESo6jm4WLce7oPSHHAr0w
         3CleGMxu46kh5N8ktWghNl/ri+ccW612zNVOWqkU8jv1X2F4gzfmqDGFU3AW/b+jTC76
         UzS+vphKLwFZV8t/W6kP2LiFZ0jn2cfiZSCCyvC/gLn5iRqKPhJmHavexV4Mfw2T7yj0
         DoVg==
X-Gm-Message-State: AOJu0YxHYLF282W13DW78Oa/xeuwONsQcr8ApHLXo90up7oJANZKCczK
	Rj4YsWGKehD0/i50Xt/dedG/R16L2ck8dHxla72jLN33OzxHqabIAmE/ozJLIOQ=
X-Google-Smtp-Source: AGHT+IGhXuA9mSb9k6iVMD5LLd452Lwv0mOTj1BFgjLiBJYBANZoXhSViPIyKUvXNEgYKATgMq1kHQ==
X-Received: by 2002:a5d:4483:0:b0:33e:7650:58b4 with SMTP id j3-20020a5d4483000000b0033e765058b4mr1434697wrq.27.1711023951565;
        Thu, 21 Mar 2024 05:25:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033dedd63382sm17012019wrx.101.2024.03.21.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:25:50 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:25:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] virtio-net: a fix and some updates for virtio dim
Message-ID: <ZfwnSz5vP4KzXNxa@nanopsycho>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>

Thu, Mar 21, 2024 at 12:45:55PM CET, hengqi@linux.alibaba.com wrote:
>Patch 1 fixes an existing bug. Belongs to the net branch.

Send separately with "net" indication in the patch brackets:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr


>Patch 2 attempts to modify the sending of dim cmds to an asynchronous way.
Not a bugfix, then send separately with "net-next" indication. Net-next
is currently closed, send it next week.


>
>Heng Qi (2):
>  virtio-net: fix possible dim status unrecoverable
>  virtio-net: reduce the CPU consumption of dim worker

The name of the driver is "virtio_net".



pw-bot: cr


>
> drivers/net/virtio_net.c | 273 ++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 246 insertions(+), 27 deletions(-)
>
>-- 
>1.8.3.1
>
>

