Return-Path: <netdev+bounces-46226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204F7E2A60
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EAD1C20BAF
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BD29439;
	Mon,  6 Nov 2023 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOS5HNkM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8929437
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007DCC433C7;
	Mon,  6 Nov 2023 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699289477;
	bh=D7U5sPw1ljuXHAERwh7BlUz+baOcbqpEzHKLV6noWzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VOS5HNkM8ueXwyZ63bqn7EF65hFyscpitOmyfnOn2VwX8EKZqVA2/Jks8Yr/SlxWH
	 4TE/EEMPFryfL7t9VYMGOI4jKnST4ZvGj9nM/d36S4wNGNntfVGiIb0hTjukcysqT1
	 V45XR6wZqqWPq0Pd9BY1uEzDCiQyoV5cEMsTTRn6Hd3Qtq5P2Inmf6kXFKi7wKuvnc
	 1djQbhux/8FsaOn0MCusQ5t6E5qsX98Hp5FE/dtIPynBYntm1a5ZR0N3mfcyiLNeBK
	 +3x5bNhQ6JRcdNxgULbNZKPzA2eoFZgUjfyuAj7LY93piVSkttdx0Qlv5T3vxaXK7P
	 UaVBEfDF0XzMA==
Message-ID: <081c33fa-0fa7-4ac3-aadf-3036a24fd8a3@kernel.org>
Date: Mon, 6 Nov 2023 09:51:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bypass qdiscs?
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Ousterhout <ouster@cs.stanford.edu>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
 <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local>
 <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
 <CAM0EoMm+x2eOVbn_NMDYVu4tEjccvvHObt0OSPvCibMAfiNs5w@mail.gmail.com>
 <CAM0EoM=nzobHqxD45wf+DR-sAGSaxE2m-kUf__40-rekdkhhoA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAM0EoM=nzobHqxD45wf+DR-sAGSaxE2m-kUf__40-rekdkhhoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/23 9:17 AM, Jamal Hadi Salim wrote:
> BTW, Homa in-kernel instead of bypass is a better approach because you
> get the advantages of all other infra that the kernel offers..

yes. The memcpy that Homa currently needs (based on the netdevconf talk)
should be avoidable using the recent page pool work (RFCs).

