Return-Path: <netdev+bounces-17163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14200750A48
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4499A1C21152
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1134CC5;
	Wed, 12 Jul 2023 14:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EC2AB42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:00:57 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7F1BC5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:00:44 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7943bfaed0dso2273229241.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689170442; x=1691762442;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/vFQIPrXmqoAuqmaBR6Mb0iwzrzICTbOr+yOCv90m4=;
        b=Kb58aMlya10S543rKj7Zu+hZUKi+Q17SMR6ArQ1EwpHMfqD4KcV7Jqb9nZ7QPI5Glz
         82vNdZmoQ2XMg/4/wYZZ9bttCnw5KWDHqucg7yzFniIuhJQsIKm1urth/5Kj7I0tM2nb
         LhhDmI2eq8YglxIopffGYpxxnG/ubl01JstAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170442; x=1691762442;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/vFQIPrXmqoAuqmaBR6Mb0iwzrzICTbOr+yOCv90m4=;
        b=JyeER+0JFxkvo1sLKA/sMgcPccMHRb0XFkm8bavV6yNpgzxBJRfBvnv5Xv3IkGhRPk
         2+oPctX3o9li0vRI9ccZmDRkBII3SOsuNXsfXxwf2cQgQ9B/9tG6160xIR2UYhuOSFQG
         fj6dRRi1pofkLLweZDS524I2kZ5pvbW9OFgndqG9XNTUWdIR620LzdsNReqTMXRY2wRP
         DHsI0NA+N5cyEWDS38DC6BnyGpiNTEqEyFx1blNd5iF5SrmmjZCle3PpxwZy14fj+lJB
         1jJsMRX85T6kYdZEekyjPwby36qQcuaPKqkFfrrTXEIgiOuIKiS2zIhsbEUgfY8MabtC
         cReA==
X-Gm-Message-State: ABy/qLbgXrJ0EAwDFUkQ7XIToB9NizFxbdOFFeZBfCPUVyPb2DsOLgis
	s9Op9Y0dAIyA/fGgMFIOqPf/9cwHAIAz2XwN07fh4h1B7EeqHOXY+dU=
X-Google-Smtp-Source: APBJJlHxN4fgLPmbr/yn0VmXtrJA60NILVBCtZkYooyacBhaBVOpSJDy1eeetX/3PQ+VOs/uNFS9VME71B+qb7fzDPo=
X-Received: by 2002:a67:eed3:0:b0:443:8ca0:87a1 with SMTP id
 o19-20020a67eed3000000b004438ca087a1mr9512397vsp.6.1689170442622; Wed, 12 Jul
 2023 07:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marek Majkowski <marek@cloudflare.com>
Date: Wed, 12 Jul 2023 16:00:31 +0200
Message-ID: <CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com>
Subject: Broken segmentation on UDP_GSO / VIRTIO_NET_HDR_GSO_UDP_L4 forwarding path
To: network dev <netdev@vger.kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear netdev,

I encountered a puzzling problem, please help.

Rootless repro:
   https://gist.github.com/majek/5e8fd12e7a1663cea63877920fe86f18

To run:

```
$ unshare -Urn python3 udp-gro-forwarding-bug.py
tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000
lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1392
lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1200
'''

The code is really quite simple. First I create and open a tap device.
Then I send a large (>MTU) packet with vnethdr over tap0. The
gso_type=GSO_UDP_L4, and gso_size=1400. I expect the packet to egress
from tap0, be forwarded somewhere, where it will eventually be
segmented by software or hardware.

The egress tap0 packet looks perfectly fine:

tap0  In  IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, length 4000

To simplify routing I'm doing 'tc mirred' aka `bpf_redirect()` magic,
where I move egress tap0 packets to ingress lo, like this:

> tc filter add dev tap0 ingress protocol ip u32 match ip src 10.0.0.2 action mirred egress redirect dev lo

On ingress lo I see something really weird:

lo    P   IP 10.0.0.2.55892 > 1.1.1.1.5021: UDP, bad length 4000 > 1392
lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1392
lo    P   IP 10.0.0.2.43690 > 1.1.1.1.43690: UDP, bad length 43682 > 1200

This looks like IPv4 fragments without the IP fragmentation bits set.

I think there are two independent problems here:

(1) The packet is *fragmented* and that is plain wrong here. I'm
asking for USO not UFO in vnethdr.

(2) The fragmentation attempt is broken, the IPv4 fragmentation bits are clear.

Please advise. I would assume transmitting UDP_GSO packets off tap is
a typical thing to do.

I was able to repro this on a 6.4 kernel.

For a moment I thought it's a `ethtool -K X rx-udp-gro-forwarding on`
bug, but I'm not sure anymore.

Marek

