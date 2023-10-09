Return-Path: <netdev+bounces-39204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97307BE4FE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6449D2816E4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B503717C;
	Mon,  9 Oct 2023 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ESHYUKQG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793623717F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:36:43 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634EFD6D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:36:33 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S436Q2zgVzMqDhj;
	Mon,  9 Oct 2023 15:36:30 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4S436P6ywXzMpnPc;
	Mon,  9 Oct 2023 17:36:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1696865790;
	bh=BJqZcTfNbCj0R22YsFOtc6MUhionL6VnJo/5ED1Q1KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESHYUKQGz5ESQZslyPoQ8hV+1Vgjw30+yBsbFzwEKZ0Z0/wt6+K2uCxV4ci1E3GOP
	 ohJiSW2yU+ZPaDixYZuGzyfV2swjlfxsTKOzAh21K9eQiY1WpJNCf+OHbFZZmISfsM
	 Tj4un9AiOdrBihzbjEtPox761tbxdn5dNsh0mZjQ=
Date: Mon, 9 Oct 2023 17:36:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v12 08/12] landlock: Add network rules and TCP hooks
 support
Message-ID: <20231009.Aej2eequoodi@digikod.net>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-9-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920092641.832134-9-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 05:26:36PM +0800, Konstantin Meskhidze wrote:
> This commit adds network rules support in the ruleset management
> helpers and the landlock_create_ruleset syscall.
> Refactor user space API to support network actions. Add new network
> access flags, network rule and network attributes. Increment Landlock
> ABI version. Expand access_masks_t to u32 to be sure network access
> rights can be stored. Implement socket_bind() and socket_connect()
> LSM hooks, which enables to restrict TCP socket binding and connection
> to specific ports.
> The new landlock_net_port_attr structure has two fields. The allowed_access
> field contains the LANDLOCK_ACCESS_NET_* rights. The port field contains
> the port value according to the allowed protocol. This field can
> take up to a 64-bit value [1] but the maximum value depends on the related
> protocol (e.g. 16-bit for TCP).
> 
> [1]
> https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net

Could you please include here the rationale to not tie access rights to
sockets' file descriptor, and link [2]?

[2] https://lore.kernel.org/r/263c1eb3-602f-57fe-8450-3f138581bee7@digikod.net

