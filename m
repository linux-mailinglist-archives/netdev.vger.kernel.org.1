Return-Path: <netdev+bounces-127005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4E9739A8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5142FB2553F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E817BEC8;
	Tue, 10 Sep 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki3E7y8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463A2AEF1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977812; cv=none; b=laWYouviE29sDfW+XXAOLAdXdh1GiDPGuyNhhpBrkd9JLLNXHTVdjtQe2koxkvdLMeWyRRAoFBkS3nN0I7SA6o2PJk3Wdz+jGX4aJ7hsrifelXQTTL6sYPeYdVBIWMj+1i03OE92UnLxDgphT6wPHs+n5IlcScBC49gUvbgXP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977812; c=relaxed/simple;
	bh=IKnDCWdnwqfShhKxkPaguVfcs+6CmKseZq1WrNUDX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUsjR7kb0BqAUr7VgajOeRsrfIxsFBcyPTF6iW4gGJSRwVyAFMVO6/CwdxO6rAySyWzHUack4HkOdYE2DY3MMW1EhaMDWvLSLbQjjvxIUOwFkZoCXIMBwXUa0SuKdYn23sWKEo84T+Wg3lfIBd+CUBqUPq+2mGY6kc22VivEhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki3E7y8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABC3C4CEC3;
	Tue, 10 Sep 2024 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977812;
	bh=IKnDCWdnwqfShhKxkPaguVfcs+6CmKseZq1WrNUDX+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ki3E7y8sybXyST+vtIhMofIhzk7Oznpr9gzN5rJj0GLZV6HYCwZHl2ROUMXjoJhSF
	 Q3NdjvQlKLtkswVjmKpcVNNVDr6ZvJpHSPwUKcQmtKmo+NsiS5/v6Sn3Kw1RyFwfNB
	 9xVy2FFUtpQlXMQnLnkfeQLVGhVOdMrB2pDtn8o48q9HZkRJUl16CTDVrl+eTAPvIZ
	 9P8yctarEQwVcg033rHYGTeJA3qyNKWS0z8DMxcRIxXnuTk6WitDNQktUZysuN1Rfn
	 Fr5rtsYAP0qaee9rRM7S6D2SJgx5vJ6KBFP36ARPKyTL0ZET4IhFZf+RVdbjNJXtUx
	 cetomlGhByZXg==
Date: Tue, 10 Sep 2024 07:16:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, joshua.a.hay@intel.com,
 michal.kubiak@intel.com, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 willemb@google.com
Subject: Re: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
Message-ID: <20240910071649.4fba988f@kernel.org>
In-Reply-To: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 13:53:15 -0700 Tony Nguyen wrote:
> Alexander Lobakin says:
> 
> XDP for idpf is currently 5 chapters:
> * convert Rx to libeth;
> * convert Tx completion to libeth (this);
> * generic XDP and XSk code changes;
> * actual XDP for idpf via libeth_xdp;
> * XSk for idpf (^).
> 
> Part II does the following:
> * adds generic libeth Tx completion routines;
> * converts idpf to use generic libeth Tx comp routines;
> * fixes Tx queue timeouts and robustifies Tx completion in general;
> * fixes Tx event/descriptor flushes (writebacks).

You're posting two series at once, again. I was going to merge the
subfunction series yesterday, but since you don't wait why would 
I bother trying to merge your code quickly. And this morning I got
chased by Thorsten about Intel regressions, again:
 https://bugzilla.kernel.org/show_bug.cgi?id=219143

Do you have anything else queued up?
I'm really tempted to ask you to not post anything else for net-next
this week.

