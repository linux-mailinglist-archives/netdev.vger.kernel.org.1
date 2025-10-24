Return-Path: <netdev+bounces-232292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3BC03F09
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F054E46ED
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343FC141;
	Fri, 24 Oct 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5glb2fS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66C10E0
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264769; cv=none; b=DVCtOTk8akikb8UvRD7A1jjjt2g5XyeWcYTeHyTv+6Zsk4mnR3aGzVDQF45nWc36DAPU+8hihgWzNKQ6mVvno7z0xt+qQXZ03bgH6cKDsES6aUpKLyfRaWj+HJN5+ATizOHj4T3QKWAdzUjn20kHMUIW/dIo0LM/i3g7tf3g9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264769; c=relaxed/simple;
	bh=51fj3pvteEnfxkx6ywBDPp1792Xf6URyd16RQe9v7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr1ALxGXwIPrRsJDZ2DNvjj+07+iwUADVM9zLD4lTpjF8Zzgjzl2RmRxJDPYz2uer3KbaTRT5YuYhLLpkhSZKd0vB+2m6SkXXBDzZ+XnOcUJArTAdYxj/3AeGwx+GiyA8NrICvFa0UzcxV57WGgWX8d0PWvcGbFghWQ9orT0l1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5glb2fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECFCC4CEE7;
	Fri, 24 Oct 2025 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761264767;
	bh=51fj3pvteEnfxkx6ywBDPp1792Xf6URyd16RQe9v7zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j5glb2fSqCHtGdGqWMYLZBx5YOkCuKdA1+DJkx0NRO/dV48AxhyX3m8xWzB4tX7na
	 KegGv5S6wfXVRsAYHFlG5XTfhlwtKsMUzIkYIC4WRqIiMyRc7loDOhPZ0AXraLsoam
	 5Eljq40Feho2js696Dr3yQnA0AiKBwdgJqKcNBa6E781IOu3FfwYsGrMlFvElBhrv9
	 /1X7qqwYMz0wOQLYDEQd0uRncCIr1UaqPVrS/c7m4gPizQVN3bb1mZEo+6BMBu6yK1
	 pzjtrnYGzrfbcOXukrbhd78jTpidUa8Y2sRFsWCEGEgbyCqz+gDSCRXmSuuVsCLdA9
	 Wl2qc1ptgko3g==
Date: Thu, 23 Oct 2025 17:12:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>, Mina Almasry
 <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Ankit Garg <nktgrg@google.com>
Subject: Re: [PATCH net-next 0/3] gve: Improve RX buffer length management
Message-ID: <20251023171246.78bea1d8@kernel.org>
In-Reply-To: <20251022182301.1005777-1-joshwash@google.com>
References: <20251022182301.1005777-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 11:22:22 -0700 Joshua Washington wrote:
> This patch series improves the management of the RX buffer length for
> the DQO queue format in the gve driver. The goal is to make RX buffer
> length config more explicit, easy to change, and performant by default.

I suppose this was done in prep for later buffers for ZC?
It's less urgent given the change of plans in
https://lore.kernel.org/all/20251016184031.66c92962@kernel.org/
but still relevant AFAICT. Just wanted to confirm.. Mina?

