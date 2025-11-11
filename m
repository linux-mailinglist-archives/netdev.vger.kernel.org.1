Return-Path: <netdev+bounces-237398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0DDC4AAB2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F293F3B8079
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE72C324C;
	Tue, 11 Nov 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY4pBeMs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642C2BE7B8
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824018; cv=none; b=MjsZtnJ06PQmFq9NA3cI12sZkUGwYPd3wX5ehiy2VsjcfALBhMeO28JnntpNIOZSLWJKoQdiCN2vv68ADXwfl2GjTXYWDWLdUWAfan2Jn3dTJn3G0Y2pYRi/WlvpVLFtuIwwY+abEh5fjCWyymEDd/YnnpThTrqqrvEKUTLvP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824018; c=relaxed/simple;
	bh=yyT0ioEruyJ11OspHhKh4heetYZvFinXE3ocWm04cbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXAZRVo5a+IeQfDdn5dOvhUBfnNbqXRxI7xAQDbJZpxwQD7rq7TOCKeKEAsiu1P6ySEHucRxsp8iAqXQbC5JzYEIv1g0BKnmAJzmlhysuxlHdLXl596eytSixzC68BYZvnbDsO/fCcLR4PA1zxcvfEGEW6n+DpeeOPo6AWG7+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY4pBeMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A74EC116D0;
	Tue, 11 Nov 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824017;
	bh=yyT0ioEruyJ11OspHhKh4heetYZvFinXE3ocWm04cbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RY4pBeMsqzD9CPOrlJrLX+nK74a8luZJklsulf23378hpnaNoYAkhUdpO4gr1s10w
	 yZvcpq0yXXi36TQSyyYEVgJDGGrMPh+gB2z3A7zHfNtScUvPBXl9+OH/JP4qUnOma5
	 k1NjZB0fIqEFxSG864opO64Wpsuok435OeJW671DZG7jfGYke7k9LDhvSPERj5/+s5
	 CYpYnHTT8eq/oOeQyBuxv60nJqUr1K/7xf5kbhdwQ34yEyL5EPSyTrByZm186jpPb4
	 hQfyXGcrk5OkNj/e3czsgnn0vOZAaTXr6bMZas7tz2ndRxB7Gvt/CaaQNzkPvoHG9W
	 OFX40VT8zI0Fw==
Date: Mon, 10 Nov 2025 17:20:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 johannes@sipsolutions.net
Subject: Re: [PATCH v2 3/3] tools: ynl: ignore index 0 for indexed-arrays
Message-ID: <20251110172016.3b58437d@kernel.org>
In-Reply-To: <20251106151529.453026-4-zahari.doychev@linux.com>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
	<20251106151529.453026-4-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 16:15:29 +0100 Zahari Doychev wrote:
> Linux tc actions expect the action order to start from index one.
> To accommodate this, update the code generation so array indexing
> begins at 1 for tc actions.
> 
> This results in the following change:
> 
>         array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
>         for (i = 0; i < obj->_count.act; i++)
> -               tc_act_attrs_put(nlh, i, &obj->act[i]);
> +               tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
>         ynl_attr_nest_end(nlh, array);
> 
> This change does not impact other indexed array attributes at
> the moment, as analyzed in [1].

YNL does not aim to provide perfect interfaces with weird old families.

