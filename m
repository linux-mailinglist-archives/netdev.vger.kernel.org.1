Return-Path: <netdev+bounces-38792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF47BC865
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79358281CEF
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51AB28DC3;
	Sat,  7 Oct 2023 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lafranque.net header.i=@lafranque.net header.b="vHyie9Ql"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885B1D6AF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:46:28 +0000 (UTC)
Received: from mail.lac-coloc.fr (unknown [45.90.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B09B9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 07:46:26 -0700 (PDT)
Authentication-Results: mail.lac-coloc.fr;
	auth=pass (login)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Oct 2023 16:46:24 +0200
From: alce@lafranque.net
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, vincent@bernat.ch
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
In-Reply-To: <ZRv0IolLA28HlIkP@shredder>
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
 <ZRv0IolLA28HlIkP@shredder>
Message-ID: <6d0a9ca2d73b01a8a2e8bbeea70c142f@lafranque.net>
X-Sender: alce@lafranque.net
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.lac-coloc.fr (Haraka/3.0.1) with ESMTPSA id CE44FFF2-5F1A-4117-80E8-03D817CDCA6A.1
	envelope-from <alce@lafranque.net>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Sat, 07 Oct 2023 14:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lafranque.net; s=s20211111873;
	h=from:subject:date:message-id:to:cc:mime-version;
	bh=dS7Rh9ysg+D7enKJDvVYDE8Si3uZhGo/q70bW73wfWA=;
	b=vHyie9Ql56AZ3iQwyhZt7Tt1ASOwSAEeCCPdAeQjy/0aGCe+Fs+CVb6hUr2Fv6VNf/u+CwdCak
	zsysMHTfyTYBANPyNVs4q+gBdUhrWZg0PcMnH3gEuqDQpBM+QXsAq511Laf9riAHzoTdHcKqkTYM
	XVqUf7W9RGKYUoT25Jcfs=
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 2023-10-03 12:59, Ido Schimmel a écrit :
> Unless iproute2 is taught to probe for the new policy attribute, then
> when setting the flow label to a fixed value iproute2 shouldn't default
> to sending the new attribute as it will be rejected by old kernels.
> Instead, the kernel can be taught that the presence of IFLA_VXLAN_LABEL
> implies the default policy.


I have sent an updated version of the patch. It follows your proposition 
of using an enum to define the behavior of the flow label field. The 
kernel does not switch back the behavior to the default value when 
sending IFLA_VXLAN_LABEL attribute as we checked that older kernels do 
not reject the netlink message when it contains both IFLA_VXLAN_LABEL 
and IFLA_VXLAN_LABEL_BEHAVIOR, but we can change that if needed. Also, 
"ip link set" works and the behavior and label can be changed on an 
existing device.

