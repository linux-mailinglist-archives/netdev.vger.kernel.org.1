Return-Path: <netdev+bounces-79586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22F879FBF
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7149282D15
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788C46421;
	Tue, 12 Mar 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRGMJLFF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3004779C;
	Tue, 12 Mar 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286943; cv=none; b=CaggXcyTBG6KRTTeX45Vf9VHIaFbh9RyQ6l08oYlfhztdpfbncF62BdDkkJrYXYUEudpJGVe5Z1ppu94oQ6M8num5NH+HlzrfRAeM3KhlMXXytPbraTXFUH70jt99ZxYAbkq/TwLBm4e2/uzed10oWgwJWsEZ+fYUeJrlnpelR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286943; c=relaxed/simple;
	bh=05A/YBD+rxHHpBthb4+S+Ak7pHZr1GBzLlmla4nXVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMXFZp+Z149p6kfrLvY9WkGT3b8vRaSZ4ZW4HkXwwn6NHrfSOLcCghRi60RxflOaa8kwa7eQNZLWPIDuI0i0xqVICDIUaKUMe433zQKB22aaRFRqS0mrgUdVl/+sFSbrcpMlu8W2EWFjh5/bBxnbvU+T5q577+OoKdzUOEjeAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRGMJLFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C77C433F1;
	Tue, 12 Mar 2024 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710286942;
	bh=05A/YBD+rxHHpBthb4+S+Ak7pHZr1GBzLlmla4nXVNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WRGMJLFFOQJLSoqERFYLaPswoGKHmCUfQ6TcGzkU52htuvbVI+u72CioLu2qrtAdX
	 o8KlDlBON6/nyO+gN2MjCLkwhTBRk7v8pp1l95DoFbRaYt+kkjmEhXY9uuOGpmFvhQ
	 KQ9940j/auy1AgriACE212Eig8Ol29Jz9VQQq8tHudS9LISZ7XjB9TEz9oPBe/3LBB
	 EtIJ/7ktz8uN3tvjYqh3P7oEc7J/FhElqo2GDLfrrl0D9fIzYEpwE/vDb7g/Ywjx5z
	 3dxf9pnvmc9xaXS8r04eTB/vAyhtMLzbVXx71DX/LTGpClFQ43ZJUSEP0fx4e6Zu0R
	 xKt2Ru8RGN8LA==
Date: Tue, 12 Mar 2024 16:42:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net v2 0/2] net: veth: ability to toggle GRO and XDP
 independently
Message-ID: <20240312164221.5bf92fd0@kernel.org>
In-Reply-To: <20240312160551.73184-1-ignat@cloudflare.com>
References: <20240312160551.73184-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 16:05:49 +0000 Ignat Korchagin wrote:
> It is rather confusing that GRO is automatically enabled, when an XDP program
> is attached to a veth interface. Moreover, it is not possible to disable GRO
> on a veth, if an XDP program is attached (which might be desirable in some use
> cases).
> 
> Make GRO and XDP independent for a veth interface.

Looks like the udpgro_fwd.sh test also needs tweakin'

https://netdev-3.bots.linux.dev/vmksft-net/results/504620/17-udpgro-fwd-sh/stdout
-- 
pw-bot: cr

