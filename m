Return-Path: <netdev+bounces-64530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026268359D2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EE4B23768
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBC17FF;
	Mon, 22 Jan 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsulBQ+E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9D5227
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894856; cv=none; b=mS8vITJDCRnRaXL+bTYJ15n2QZcemDJBEw2gYDOgLyBEUqcqgXW6xsv9iKReXSAQt7T85w6/SDnyn+1DKFQHe5Um0DGfE83CznVprrGHdnK2KibRQC4iChFk03IHyeWCypITvzyChuZXCcLUD1lGVHydoSAY4uqwcyk5knERYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894856; c=relaxed/simple;
	bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBy0wBej4MzzMWSNfG4ePh5QVIy/LJaKKNWsdHDaddp5A89Je3dAvEKkfKW1LxlwA13mHuVHotjlth4Htg5ccYlOtU72wVSecUNaZ93NQSotWDpDts0+Xbz9XkLcD6/7RmicsYd9sOgd0KA2xgSk61dsT7tvPelN3Aqrr4/qGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsulBQ+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705894854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
	b=LsulBQ+E8EqUDrUKjtfdRn+x8EnAQe/X45Iu8yatFnhK/rOW5cTQXeo1eQssMrttcZGcJJ
	YBzOr6IAQ/HZZqkbnzLak5c5s1/HvWyDHfKsOgeK3yLgsPqfcqwgCbOQETyTRS0LgrxpLZ
	Pi0EU38r5tscNhRAcdPSkM+Z/UXpYdc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-7dTJekFIMJmN-Ti4Qgv-zQ-1; Sun, 21 Jan 2024 22:40:49 -0500
X-MC-Unique: 7dTJekFIMJmN-Ti4Qgv-zQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-598dfff253bso2515377eaf.2
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 19:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705894849; x=1706499649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
        b=LqF5y/mCdMsmtXOXdtJPW+WGytbVEE3LroH3YxCy+JEoV8oZJjsqDv5EpaX2zQzbTA
         PEx/qvVah+K8XW1GW5vg0q6Ff9WQUez60n2LY6kNpKMtAY2wWMRF0JUqGh91/5qUdvDF
         oRvilhnQSQo8ejQ0cXqtxHZOuVHgrmisAXDdxLD4rUm1UYM78xI1PLIDAHy3Ih9hK93h
         sBEKkyL7F6rnrE93YjYrlzOZImi/PgAAIqQw/gFTACPRf+5r3qgdpaKRXFu+JgQkeWQT
         dQPzMYljJpHStKqErniuhHeERIpaCaEvJje4PcWSjr80yYbfUgVY0usIcBioMQuyz7Ra
         4qZg==
X-Gm-Message-State: AOJu0YzMAmv3Gt4CQvNRWHaKlEvjXNmOJKhOnu4jss6mdJbtQBBd6uRW
	Hy5ZPAPoNfWJXv2l1nOvtrtk/oyAXAszFAFg7YGpDvkRwuA4fpCYXlGBDazBasjSN/HqZ0xyxjf
	/WU0zybiI3/YgPD7Xezxp8gjKEZ7w6LkVF1t5BJ+1/0AOBRCzjOBKlGYTaWmVo9BACo19eMEtwy
	FN0uXdy1x3ei5qNdDcYRRIsMfyvGuE
X-Received: by 2002:a05:6358:917:b0:176:4ed4:bc64 with SMTP id r23-20020a056358091700b001764ed4bc64mr305866rwi.26.1705894849103;
        Sun, 21 Jan 2024 19:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp2MTnFuCfcO0cpNTXwF8TVpOM8IaPRjH8DJYvhD+oni+Ctps91jRas926NgOAcRQv3rouXXOmASXeW8A6y+g=
X-Received: by 2002:a05:6358:917:b0:176:4ed4:bc64 with SMTP id
 r23-20020a056358091700b001764ed4bc64mr305854rwi.26.1705894848831; Sun, 21 Jan
 2024 19:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:40:37 +0800
Message-ID: <CACGkMEu6VtxxoRxfjMijpgC=qZmbsrLiJT8=0dgGzjqnz0CReA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tun: add missing rx stats accounting in tun_xdp_act
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:23=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.co=
m> wrote:
>
> The TUN can be used as vhost-net backend, and it is necessary to
> count the packets transmitted from TUN to vhost-net/virtio-net.
> However, there are some places in the receive path that were not
> taken into account when using XDP. It would be beneficial to also
> include new accounting for successfully received bytes using
> dev_sw_netstats_rx_add.
>
> Fixes: 761876c857cb ("tap: XDP support")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


