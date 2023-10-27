Return-Path: <netdev+bounces-44619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3C7D8CC6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 03:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435F81C20F53
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A368EC3;
	Fri, 27 Oct 2023 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0yFetFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909BA5E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A539C433C8;
	Fri, 27 Oct 2023 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698369796;
	bh=ULdJbVIo2nKQfoocsRXy3Whn/iCeg4v9uVg3OpoAelI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0yFetFSRb0xB02zCwKhJnrAZPJ0oCcasaW8KLQdHCzOnikiNlFIZ1EJJ34AV7ES+
	 CRm/YuuJTuPturxtKH5PltgeySjiIsEV2bmIRfRnqs/VNMYNHmxohXtj1b6gd7ANoR
	 VREA8yz9WzG/8DHvikNaEZdY6WuwUdNhKRhhC6mcPX70U++cm8ByrhMuMfPNfPm0EH
	 +u8TxTIqjA6nTZA5JIMumGdZdQBBnCSC7qN8johV2romBWnVahdnViNaO0dy/SSiuB
	 dfZ4hjPN5AKXnFI9V65/Mhu/BeUPKTZEwm/+iQz+XIXd85U33bfLT7H66Zv1vnxqEX
	 GvDo6SgY9cH2g==
Date: Thu, 26 Oct 2023 18:23:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <20231026182315.227fcd89@kernel.org>
In-Reply-To: <CADjXwjjSjw-GxtiBFT_o+mdQT5hSOTH9nDNvEQHV1z4cdqX07A@mail.gmail.com>
References: <20231026081959.3477034-1-lixiaoyan@google.com>
	<20231026081959.3477034-4-lixiaoyan@google.com>
	<20231026072003.65dc5774@kernel.org>
	<CADjXwjjSjw-GxtiBFT_o+mdQT5hSOTH9nDNvEQHV1z4cdqX07A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 16:52:35 -0700 Coco Li wrote:
> I have no objections to moving the enums outside, but that seems a bit
> tangential to the purpose of this patch series.

My thinking is - we assume we can reshuffle this enum, because nobody
uses the enum values directly. If someone does, tho, we would be
breaking binary compatibility.

Moving it out of include/uapi/ would break the build for anyone trying
to refer to the enum, That gives us quicker signal that we may have
broken someone's code.

