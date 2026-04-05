Return-Path: <netdev+bounces-275424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LYVCefG0WkyNQcAu9opvQ
	(envelope-from <netdev+bounces-275424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 04:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD439D181
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 04:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983FB300BD85
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 02:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1A286425;
	Sun,  5 Apr 2026 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnqQ39A+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB0283C87
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775355619; cv=none; b=asQNa8FdgiMIh0t03AEvBuAGkLqkLiP4dpeUX3EibjoE8MSe3F9Dvkg9yBjZpmXCcSIfDbUQI55LVioLlj+PHDapgWgglAgDnoCwCEKi8gVEq591ioJdLwSHQgpVTAEZLRN1x9wRCD87MQkNBZIl547CxvaDtC6BWCYMDdgFqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775355619; c=relaxed/simple;
	bh=1MTQFpcvnbpAS+lfN81eEUe3UhfVERkfW7ohsy5pZNY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c7RtMeeG60Q5kZ2a4BZSRV/OsSNTwgB/52KMnT8UCQyIrp/Nsg6v2ljAo/Cy2P2wpb1cDxDquBhqT5X31vsY9xv3FOotkkQ8vxHFjVTnCCrBf++OW9H3Ur06VfnHtqBS9BNzpI5TLaSaI0jIfJV9TyoaWmurUh+YDOWi3hAp9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnqQ39A+; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e87a81639so2780370d50.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775355617; x=1775960417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PjEXNTzVETVGk8h3G8N5TJ5xNnIosmnv47Cvo0s4Js=;
        b=MnqQ39A+jChZ6ycdPWUQKVnzSRzRRCUxgQFFm71OVNdEfyFBmvtOmDrwGTYHvfiNcG
         s88mfLHYKM1vF8ie7I+MSwGxbvw2naXLsj5zxaoHuANx4DqieZXKjvSoAgA1g8Pf8HBp
         bMR7yrbAzq/xHfIOD3B131owc8FFFCmLVu2OTA4MhaRAXHdRlCHZ+Hd5oIh7MKFzvnE3
         tA6LPfhRqtZcfI2KneIAnc0xHurx7UT2/FIuz86TqTU5gpS6ZMcQgTznBrkJSDQH+6fu
         +NkJy6Q2kz4i3f3lxaUB35Fc2T3fZwgfM7duLIVAUyczDcSwJ7qMvAX3H5eprTIR6Ygs
         3VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775355617; x=1775960417;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PjEXNTzVETVGk8h3G8N5TJ5xNnIosmnv47Cvo0s4Js=;
        b=AVSNiNShXOYIpU/7S8pq6fbKeZVZb1l3CEYZldaJ5pjDssnMP3KHwpmV7MvItvXelK
         NF2OuvRmgUsT+qEeRZeM14IeNUBXOA61NwJtnqVeKa7uCtLCuh4Xcnrfdzonb2muJPMN
         2Oh/ZahPtcBOOp3MsvR7ZRcWP/bpRoKHAO5gkatnDhyQlftMDQB0fiAs4HfPYmN6KA3G
         LXEpi24hmE/5eLlYj0bIMn7/dg7WHAo1a6lwnJxayn/1E9leL6HHVj0HZ7dR/luwELr3
         uk6C2UA/S3hVsHcG8bVWmLCqQFcO1QaYghoKX/Px5fEwk+VvbO9n0xbNjqWMTgYoUe5V
         KtkA==
X-Forwarded-Encrypted: i=1; AJvYcCXQvoeQCydBdW8XhiRf+3YKsc/VgmZH8goHHjRcIQqGD1ktqzwfRIYeOXdZLN2jtLObSPsfwHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKk2mL6HMAOmuSsFBA90jruA8hqWuPNGGmt7ZJdfvLdBVauoba
	JM403PKgznEj5Wd+hjbAA+XNT1fSwWtj0OSb+cqdFBxGmjp38o0/PQjX
X-Gm-Gg: AeBDieuk4SS7X9djydz3KYAjQh1kdSFLiH7aw49xOkya9CnUseRxm0R29/I/0C9nMo5
	d0N4J73tbJeMMeKGz5cK7jBNZM6QyVZUpSYMe9M0ma/A5EaVqgQNm0cnhw/L9Fkog7ePuOgchYO
	251PBX0PHXsmmlUdpJRoIldKPsOu9bjpi2OrAkZl0w32GmM074q5LqLXPHn9enliaJakrRGdV35
	NatC8MLrPsstXtemdmz1TfiBtB8HD/4Vcq3xgoF6NQC7m6AQlgD28sLqK6j7xHLHcuufdkCuUT8
	3VLeytkVLFTWRtUFoOxGN06p8W4Rv8d8tUHI1XIDgH/hzMQcXuGAMKDOmEWVnsM9eclykYG5tiV
	aAlzjh2vuLSo2DxqKQHbwOXrCaxuKPD9D7jQfd4J60JKTSvF2Wu0eJsJb/2X+o/ZmxfAqURAlEa
	VFQFZOadOsQJwgALE++r6/KnS6gKFnkNgyqzERgA9GGpjCVCxUo3p1Ofplarb0il/D1rPDe/M6M
	wKc
X-Received: by 2002:a05:690e:4808:b0:650:3ed8:f89e with SMTP id 956f58d0204a3-6504872487bmr6352833d50.25.1775355617282;
        Sat, 04 Apr 2026 19:20:17 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a97908dsm4272461d50.13.2026.04.04.19.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 19:20:16 -0700 (PDT)
Date: Sat, 04 Apr 2026 22:20:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1622322e50a5d@gmail.com>
In-Reply-To: <20260405014458.1038165-1-willemdebruijn.kernel@gmail.com>
References: <20260405014458.1038165-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2] selftests/net: convert so_txtime to drv-net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,so_txtime.py:url,queues.py:url,shaper.py:url,xdp.py:url,ring_reconfig.py:url]
X-Rspamd-Queue-Id: 73CD439D181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Also update so_txtime.c to not exit on first failure, but run to
> completion and report exit code there. This helps with debugging
> unexpected results, especially when processing multiple packets,
> as in the "reverse_order" testcase.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ----
> 
> v1 -> v2
> - move so_txtime.c for net/lib to drivers/net (Jakub)
> - fix drivers/net/config order (Jakub)
> - detect passing when failure is expected (Jakub, Sashiko)
> - pass pylint --disable=R (Jakub)
> - only call ksft_run once (Jakub)
> - do not sleep if waiting time is negative (Sashiko)
> - add \n when converting error() to fprintf() (Sashiko)
> - 4 space indentation, instead of 2 space
> - increase sync delay from 100 to 200ms, to fix rare vng flakes
> 
> v1: https://lore.kernel.org/netdev/20260403175047.152646-1-willemdebruijn.kernel@gmail.com/
> ---
>  .../testing/selftests/drivers/net/.gitignore  |   1 +
>  tools/testing/selftests/drivers/net/Makefile  |   5 +-
>  tools/testing/selftests/drivers/net/config    |   2 +
>  .../selftests/{ => drivers}/net/so_txtime.c   |  24 +++-
>  .../selftests/drivers/net/so_txtime.py        |  88 ++++++++++++++
>  tools/testing/selftests/net/.gitignore        |   1 -
>  tools/testing/selftests/net/Makefile          |   2 -
>  tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
>  8 files changed, 114 insertions(+), 119 deletions(-)
>  rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (96%)
>  create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
>  delete mode 100755 tools/testing/selftests/net/so_txtime.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
> index 585ecb4d5dc4..e5314ce4bb2d 100644
> --- a/tools/testing/selftests/drivers/net/.gitignore
> +++ b/tools/testing/selftests/drivers/net/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  napi_id_helper
>  psp_responder
> +so_txtime
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 7c7fa75b80c2..85d6a7e26627 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -20,12 +20,15 @@ TEST_PROGS := \
>  	queues.py \
>  	ring_reconfig.py \
>  	shaper.py \
> +	so_txtime.py \
>  	stats.py \
>  	xdp.py \
>  # end of TEST_PROGS
>  
>  # YNL files, must be before "include ..lib.mk"
> -YNL_GEN_FILES := psp_responder
> +YNL_GEN_FILES := \
> +	psp_responder \
> +	so_txtime

This should just go under TEST_GEN_FILES (sashiko)

I don't quite understand the check_selftest check_new_files_makefile
failure.

