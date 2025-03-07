Return-Path: <netdev+bounces-173043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4CA56F98
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B864E175F02
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933AF23E229;
	Fri,  7 Mar 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq2kmCa4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCA217718;
	Fri,  7 Mar 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369851; cv=none; b=XpUE95LISUGVH1w0wMPjAtOSxkkDcXCcXRTDFOjV3bJF6l0tIfiPIpUeTTLAVNtBdsqpzq7R/kxfZwl8a5LtVWpMXewHnbTTEMoLLgQKp2FkDvQ7iBRbae0HIk1B2utGENvm8D0TMgXlSymtjJpjse1WgRUhCyXu0uq3BcRkAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369851; c=relaxed/simple;
	bh=1MWCqxtK8Lpq4HGsdsJhKayhm8VOxpoYt3Qdmn9CKHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbF8HeIRsqtRCBjoYRgI0r5DdrafMHKEYnEX6fhSPE9gBmA3hyty/iV6rJV4M8yOlg0XGJpqyThJ2vJInc7LovwA/QUduSs3KotvegPPvos7vr/xrNbz1ZwKMm18PDuBahl8hULC+VBslGO2lm8isVEHahYd+fAb46WrZ/Ts5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq2kmCa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D56C4CED1;
	Fri,  7 Mar 2025 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741369850;
	bh=1MWCqxtK8Lpq4HGsdsJhKayhm8VOxpoYt3Qdmn9CKHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pq2kmCa4I11NHxwRTW3/awru5/73mho8HX9w2W8hhsPr6UaGzpZUVLH0pYzGBigMx
	 tlHnqRcJcKwBFRnsIKeduEukN8HENXvYtFeSk6iEpHIDyJ/VxVpxuTaCLIVDUpdH7N
	 EATxgTdksBixIviElPlXElnJgZ+nYqlHfi/GmDtW4o6S1X1QN7hpyUsqI3I19H46c2
	 IYRuC/Ioyv3g20/LuXDIIKbP2xsQdmaMIMiBuRE8jkJCgxp79/0l7Vz237rf3nRFFD
	 TpIE3GU8zcqiMsbRTkqwDaG6/2ZzfK6a78xywi/h4V9hlQuwW/X/FbPQuIlSx+tZl6
	 Wc11M1vP2VK5w==
Date: Fri, 7 Mar 2025 09:50:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <20250307095049.39cba053@kernel.org>
In-Reply-To: <20250307155725.219009-4-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
	<20250307155725.219009-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> As we move away from rtnl_lock for queue ops, introduce
> per-netdev_nl_sock lock.

What is it protecting?

