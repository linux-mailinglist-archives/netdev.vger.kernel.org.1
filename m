Return-Path: <netdev+bounces-183315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE6A90507
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CBF19E0DA0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04024EF7C;
	Wed, 16 Apr 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI7RTDIr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E324EF68
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811107; cv=none; b=PXg9A5vaXL7FsOFu9Q82i/ihGLXmE5VZxozPn/sysiCpaVsGU6pq9LxdxL3NAw+yh6MrAtY+9M4/gcBNmOQFR5WSrqSV+zJXa/KrAteXFej3P0raWKbu57o9JmsEj3gKN2kieJ5MeAeM0stzuGrihm7lI3pp7YRcXwFXlCutsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811107; c=relaxed/simple;
	bh=09n1pHzq7xsPf1WoNTuzo5/94vpJGWWJ1LSb8D2ZGTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRvlN2Esubqi333It+P83fxYX+cZxMbuuZRWoZSydoi7DGufbB+zNFspB3GumBq2pjyqWlaP8bewjgSDF+uF+kkWgtBit7NN4ShUAgddQrSmIbC61YTfzZgj/EcyVDeAX7GIThlTU8J5tx87d6DF9lS2lMNqFmoEoWdTpBTBiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI7RTDIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D1C4CEED;
	Wed, 16 Apr 2025 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744811106;
	bh=09n1pHzq7xsPf1WoNTuzo5/94vpJGWWJ1LSb8D2ZGTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QI7RTDIr8OckBbsg8vakCxAd0L6cgcrkw2VWZCEucMWONITTuX/cn0HkLls4DDZMk
	 pQM99353CdHmSLMZ3uaF6VW23fOh3OkYDBw2wJEtDIIiQZ0MBr9xGVLWNeyJ2e0Bob
	 XCofHcM22CpxpYj0yJKqRWzPkF+o5O3XJY1cPkZ/C3gU9QdxSpbM8cHKPYVvI8d7Pc
	 zuNuUDUAAqoWQ8IGVkoG9AZWy05GySgymIn3xxDvi6sjzVfF+vqmCy17hXSVBdyUX6
	 aM5ME4qoontmdTmWi3h9wycni8vx1fjQXrdwa0z29bRVsYiUjFpEOHk4qmIM+xRXAh
	 TKxsnGVymyWuQ==
Date: Wed, 16 Apr 2025 06:45:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, sdf@fomichev.me, jacob.e.keller@intel.com
Subject: Re: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator in
 place
Message-ID: <20250416064505.220f26e8@kernel.org>
In-Reply-To: <m234e8mndc.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-2-kuba@kernel.org>
	<m234e8mndc.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 11:06:39 +0100 Donald Hunter wrote:
> >  def put_req_nested(ri, struct):
> > +    local_vars = []
> > +    init_lines = []
> > +
> > +    local_vars.append('struct nlattr *nest;')
> > +    init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")  
> 
> Minor nit: the series uses += ['...'] elsewhere, is it worth being
> consistent?

Agreed, it was annoying me too.. but in _multi_parse() I seem to have
used .append() in the exact same scenario. Hard to define "consistent"
in this code base :(

