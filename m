Return-Path: <netdev+bounces-145060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7E9C94A3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002C3B227DD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268D1AE01F;
	Thu, 14 Nov 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAyCrM95"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD921ABEC6
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620615; cv=none; b=uImf5Aqd0Eq5kLEM5+559dP/Vyr3dDloAhwOADWUMDYiHEqS2n9jv91FGowMS2uv+wH2Y1BzcqlfnaQoRueuYkZQ5bRgM8Zy5SFdvOrhGhMIv82T0hH93297Xl0gHv3pzmGL0hDSAK5tPsiUJ57jrHVTL2s910/Ot+PkcvdN3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620615; c=relaxed/simple;
	bh=n7JmvDQEJTOnk++XK6eA+PE6CAAvjld8xZERnikAMqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZs8FWJtmA8wyb4kbn841cVl7xLpyFsPTB+XbW4ovKf1ArJq7DUi+HvM6Fy5p3j2GVYYYlqD3joMX91bTKkgr6M/LH5mZxAWlmC/iGouKpRt8F4Ck7OnfgtbhkSMTTO1qn4lXZYQ689Ifcudr7/vMKPpVzPgfYsS46Pn9VNBkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAyCrM95; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5edc796-7ae3-4b57-b8ee-223f2c26f936@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731620611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDmTfCI6RKcz57gtjFsW2JZrMbqYTYu7rhILfnoxFRk=;
	b=QAyCrM95sT4SgqKL1YZL6gh5Iio9mME7K9TkmbaOtg2G5WNw0ki8VNgeGHcwHa6XCEIAKU
	r7l8SYf7aFKyP248QyuEjAFCg6fxDG/JzxE4grnJ/GMSBp83J5tHcS4IcrJCo9HepY796w
	RTWkXD8WOF4oYi3JWqcf5KW8V73gyew=
Date: Thu, 14 Nov 2024 13:43:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
To: Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, yoong.siang.song@intel.com, sdf@fomichev.me,
 netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 bpf@vger.kernel.org
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/24 3:30 AM, Felix Maurer wrote:
> When a new skb is allocated for transmitting an xsk descriptor, i.e., for
> every non-multibuf descriptor or the first frag of a multibuf descriptor,
> but the descriptor is later found to have invalid options set for the TX
> metadata, the new skb is never freed. This can leak skbs until the send
> buffer is full which makes sending more packets impossible.
> 
> Fix this by freeing the skb in the error path if we are currently dealing
> with the first frag, i.e., an skb allocated in this iteration of
> xsk_build_skb.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you help to take it directly to the net tree? Thanks!


