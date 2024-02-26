Return-Path: <netdev+bounces-75115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4E86833A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAC31C239D5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F0131E28;
	Mon, 26 Feb 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ui6eckD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381A131733
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983338; cv=none; b=hf0zxfccRQz5lPgd48bMsWWR4k5sj97LFAG/kEkU3Fi/fDip1uCNy3489jAzjAiaIbrKsO1WGzKQEbAR6DNfV5rczfZiqtlNUAt1YuwupFhTn1EoGQ2aDkWVKUEFMmi7OBg+43vsKSijnR+ar8nw22n3BQrj9pTl5yBBIM+TaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983338; c=relaxed/simple;
	bh=L7ySzKEbbxdHm2P4RanP/z6ymTcGIsmqVWieJn0oGoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cX40P686wnexNdTepA76P9famYO04Q9owiaFtNy7mdBgXKSo/eE7IDD1B1e6CW4hORDfyLL2boNjXrBQNpoDyoSCzQVdZawgG+KzKh/2nCYOwsvKqMv48klmHZVlbudOx1Fd7j9Y/KXfXRQ61zr6KoTrHDLmijIrAueBE8viuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ui6eckD7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6087ffdac8cso53668257b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708983336; x=1709588136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfjxxlD3XiW4169q9jpK78Z+thpfefEJ958/JzGWDtk=;
        b=Ui6eckD7aLJO0jkr5CUXNuj/O8B9n1+61t9etu3FOdzUTEYJlDV0U57JDiKTv0o3Dh
         62OBkgq2ZqXKLCNR8bDykKLkbeS5q9f95NKh5EVZAhOdZA0b9zvoNoXVPK14aC/ycS26
         CeksKBqaadPzzJJvVsIzaPVMQV2vkIVdvRJZlFOLJ3ppxIImw3wL7ndqCsXTCCv2994F
         5RKTxqryADGkLrtGno/EI59TXcsO6PxPtECep2Ox12H4qVXmMGVR/FwcDd1UBzS+GowH
         qKWOuewxBF/wgH0EB6kQcOenwpFHNgGUOxawHciFa4ASNg3/4cmN1AM2qly/PqwkYHUZ
         qgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983336; x=1709588136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfjxxlD3XiW4169q9jpK78Z+thpfefEJ958/JzGWDtk=;
        b=VXkwH7ULgwtUAa9WwZPgbux8kwctFgyIl1Eg5mm/Yg59i38cOL/Irm5AgAjzaeaMFi
         fuN8MpnVXtwqLHWhZNf5U2D8WgdMv+RTyIh2iB1YNhCRdJQN1CFa/Jtb8R6uxwQmOe81
         BEdcb/vfaNLbHRaMY8bKOzH4xfbFKBw1YjGJYrZ+GK50PwqPiTuVcYThM+695n50FLJg
         wOPOBwVtQDdHlbG1LDospTE0revS3gDGpGV9WUE8Y8e3gZ55t3T6k5wlNNOb9D0YE8QY
         Lnexi7D8if2s0xssC4V084xejg0sfAH/xxG11zSZ6RfL7INPM6iRlO2lVtkuRRjN4iUg
         wbhA==
X-Forwarded-Encrypted: i=1; AJvYcCXqttbDtKFNFpRCmAHU2lIEzYHAWb+MOW9sLgfWPrUl3M+ElKetDygHPlZfBvEuK9QBurRGRPOh/TVYQOnUiEpn2vG8kbWj
X-Gm-Message-State: AOJu0YwpMsCtZCjPfUgaP3blNm6igiO+mcvqRIyjcb7Tjclp2900ZgA1
	u2I925gB/c9TUAPr4aAtOh8G4dZKn5BQ6PBgoBbVRbYa3kfJKP7jc39AuOpTBHJMaw==
X-Google-Smtp-Source: AGHT+IGD7lfYKZRuyV3NXD8AGmp5CNcT6xukqKsaakX4wpL3un2JXCKW/4N9nCi7RJN5CcHgg1MkU1k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:18d5:b0:dc7:8e30:e2e3 with SMTP id
 ck21-20020a05690218d500b00dc78e30e2e3mr101176ybb.2.1708983336085; Mon, 26 Feb
 2024 13:35:36 -0800 (PST)
Date: Mon, 26 Feb 2024 13:35:34 -0800
In-Reply-To: <20240226211015.1244807-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226211015.1244807-1-kuba@kernel.org> <20240226211015.1244807-2-kuba@kernel.org>
Message-ID: <Zd0EJq3gS2_p9NQ8@google.com>
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com, 
	mst@redhat.com, michael.chan@broadcom.com, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="utf-8"

On 02/26, Jakub Kicinski wrote:
> The ethtool-nl family does a good job exposing various protocol
> related and IEEE/IETF statistics which used to get dumped under
> ethtool -S, with creative names. Queue stats don't have a netlink
> API, yet, and remain a lion's share of ethtool -S output for new
> drivers. Not only is that bad because the names differ driver to
> driver but it's also bug-prone. Intuitively drivers try to report
> only the stats for active queues, but querying ethtool stats
> involves multiple system calls, and the number of stats is
> read separately from the stats themselves. Worse still when user
> space asks for values of the stats, it doesn't inform the kernel
> how big the buffer is. If number of stats increases in the meantime
> kernel will overflow user buffer.
> 
> Add a netlink API for dumping queue stats. Queue information is
> exposed via the netdev-genl family, so add the stats there.
> Support per-queue and sum-for-device dumps. Latter will be useful
> when subsequent patches add more interesting common stats than
> just bytes and packets.
> 
> The API does not currently distinguish between HW and SW stats.
> The expectation is that the source of the stats will either not
> matter much (good packets) or be obvious (skb alloc errors).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  84 +++++++++
>  Documentation/networking/statistics.rst |  17 +-
>  include/linux/netdevice.h               |   3 +
>  include/net/netdev_queues.h             |  54 ++++++
>  include/uapi/linux/netdev.h             |  19 +++
>  net/core/netdev-genl-gen.c              |  12 ++
>  net/core/netdev-genl-gen.h              |   2 +
>  net/core/netdev-genl.c                  | 217 ++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  19 +++
>  9 files changed, 426 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 3addac970680..2570cc371fc8 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -74,6 +74,10 @@ name: netdev
>      name: queue-type
>      type: enum
>      entries: [ rx, tx ]
> +  -
> +    name: stats-scope
> +    type: flags
> +    entries: [ queue ]

IIUC, in order to get netdev-scoped stats in v1 (vs rfc) is to not set
stats-scope, right? Any reason we dropped the explicit netdev entry?
It seems more robust with a separate entry and removes the ambiguity about
which stats we're querying.

