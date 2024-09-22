Return-Path: <netdev+bounces-129167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBA97E0DB
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3A1F211E7
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1C142E76;
	Sun, 22 Sep 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATmmYZs4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76698320E
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727000420; cv=none; b=u1jv+wYY17Nm6rqPxRny/OSKohDUrpfeDcwg2yGNARE+rapszK/YHbMUnCVmiADEWf/10upSiOz3ZRdr9zTG9PIAKbn83GnxGCP0FhsDo7MJiM5mCaXVUMZySlyXrZVZFha3J6wv9bBf1gPxtd6IPHD0IJhBWK06ttigc3our9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727000420; c=relaxed/simple;
	bh=bsgIG2b9IRaNGZrcciakwDpWqVLlObEUtHNnOW34j7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XekVaTfXCUVFSrI7h0yQgIYtLw8ShiiaXtJOitllcUhTVf9K5EMUz3XCfCZe9kzceihnHkNV5RUeXRlTe75UlhWsfPjRE/WtxgQ4RcHzx3ZFc6lORqVBrR4ryhIOjzw12d63/SmC1Ql5/sEDJ/6q3PhLQejXgvFa4Pvpb4+nhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATmmYZs4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so4730628a12.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727000417; x=1727605217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaGWABS4I7HUh6XY4HJVhFxlD56Ov8UWk8EJPDWLQro=;
        b=ATmmYZs4i5U+sG5FGYnC1yUdo665OD/zbXHrZ3IKirmQzaCzLQOjurLjDLIWOR9hE7
         uT+MvgSQFsM71fSlS1uo2F/bkiAiIrEH2Sh5oskfg83OSaJ4sNdGlijft39C/qPGBTJJ
         4GzIe1XpvQ6e416GrpazW+ps3AOkJDmSuBQQq02ZN1HZKftWE3oWnZXCKjOLx4KXTZB5
         m86aQRlin69DUiTduNWzy/jnPe+o6+PAJCmY/H24IZQuH9xL3nHiq4/QtAkNaUnEM8z7
         6vAjMwXyN18UMXd4QgJboDadYsnPiOxqJJhjjXXQU6vAElUkpyi1vwcFaXU5NyNW+JH0
         aAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727000417; x=1727605217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaGWABS4I7HUh6XY4HJVhFxlD56Ov8UWk8EJPDWLQro=;
        b=L0Iba9GaOILneRttcCd4Eh1KuyfvRcH0V4JKTCcq8PF/vr26IdKvhYNZFtfDl1cIKz
         2iXFDmd0nM3GwozdDsqsYc2392FqCTi5HSsv8qxyJFZ+vSAazEfDUDxxQZg/C8orzqlB
         22sr6toNdwhzEnhybvuXy1Ljhenb+CUr5pbSgFNhNIEkNWjQL+M92HbAIZFdZzFb8JSH
         toS0R4dehe4bXTG0wdD1+n4jdJCtP9/vvcz10Oi5+5jpY+h0CZhOlEoUPO3monJdu++F
         57CgA6e4lRo4688vsAucc+u1SWuW2BtYsYtuk1VKSFH8WBz/88itoDJMQS0YTtu9ww75
         ZQJQ==
X-Gm-Message-State: AOJu0Yz0ECZwYERvKcGR2IeFW185m4W1IUTq2jbd9Mfqbd/SgMNf0EJv
	qj5pW7maXRzYEacCeyFA8V6cCLEsqVxkVqOaAGmZbNpUiih/NMQL0+Itwy9z4f8JbXab2/ADjke
	g5TweZkprCpQAHLRqV/s8CNvqG5VRGWMPonmFn95OAUn6iCnWbjKH
X-Google-Smtp-Source: AGHT+IEsDNb2+DSRGbnVAWrPEHMyZYRrt+/s/KOa5w1WX+cAVNqKX9U41iAi4BHvg6ueilq/iDLR8iPZC1+UnEZ76HI=
X-Received: by 2002:a05:6402:40c8:b0:5c0:ab6f:652a with SMTP id
 4fb4d7f45d1cf-5c464663952mr7784640a12.3.1727000416555; Sun, 22 Sep 2024
 03:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921215410.638664-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240921215410.638664-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 12:20:03 +0200
Message-ID: <CANn89iKP3VPExdyZt+eLFk3rE5=6yRckTPySfh5MvcEqPNm6aA@mail.gmail.com>
Subject: Re: [RFC PATCH net] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Suman Ghosh <sumang@marvell.com>, Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 11:55=E2=80=AFPM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Regression Description:
>
> Depending on the GRE tunnel device options, small packets are being
> dropped. This occurs because the pskb_network_may_pull function fails due
> to insufficient space in the network header. For example, if only the key
> option is specified for the tunnel device, packets of sizes up to 27
> (including the IPv4 header itself) will be dropped. This affects both
> locally originated and forwarded packets.
>
> How to reproduce (for local originated packets):
>
>   ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
>           local <your-ip> remote <any-ip>
>
>   ip link set mtu 1400 dev gre1
>   ip link set up dev gre1
>   ip address add 192.168.13.1/24 dev gre1
>   ping -s 1374 -c 10 192.168.13.2

This size does not match the changelog ? (packets of sizes up to 27...)

>   tcpdump -vni gre1
>   tcpdump -vni <your-ext-iface> 'ip proto 47'
>   ip -s -s -d link show dev gre1

Please provide a real selftest, because in this particular example,
the path taken by the packets should not reach the
pskb_network_may_pull(skb, pull_len)),
because dev->header_ops should be NULL ?

