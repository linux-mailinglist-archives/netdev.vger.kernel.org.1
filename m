Return-Path: <netdev+bounces-111545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA842931804
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF11F21C13
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87EEAE9;
	Mon, 15 Jul 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzO8HI/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE20134BD;
	Mon, 15 Jul 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059304; cv=none; b=ukcfiJcewRx4pil96FyVqfAgXz3P8uOpB6maKHP8F3jofamjXG8QuCyoYcxhYc9KMGVc4+W5VofZYHR+KWfLLoFLgrGTUHZkqId9MViKVRBCWzgcFLsR9t+FAGdOlDauQPamo2a4QqaW79HQIkrh9xwXvKKptxsgr4dYXNYNh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059304; c=relaxed/simple;
	bh=hdZ1uWLfrmlCAu1exDSse0MJmB2RV4h4+omKn5OeTOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyTcjC2P69zhoCq75EKQX3Q2kYvBEprtgz+dpCTgNF2NMn71JnzZ1CeZCxTDoWN1MA49m48fXaF1h2c+e7jrjnJI5SyrGDNN5b0lyQpQf4G+2ot73SHh/0NXrxDe1f1qNUXhqOMxR1ci7W/BLp2ZiKiNGWrSgXN4cC2tq+T7b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzO8HI/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14049C32782;
	Mon, 15 Jul 2024 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059304;
	bh=hdZ1uWLfrmlCAu1exDSse0MJmB2RV4h4+omKn5OeTOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzO8HI/eEzxNy8ddFoI3PcKHZwffFK8KyjFJ/yZOY4J6doEyHz3b7cuBtBS11XDoV
	 oLVJQA5ZzbEj9J4L8vqCeutzPWGo0S+h0KuVuJP44H2MZFJF5u3fJo9UxjJt2qLXl+
	 6u9UFCy+YunGBLHM4eKRuSipn/md0ZpJUiaR/U3xP8k3TPCLd5SILWWViWYd5QOqba
	 u1sOtnhFtGqcKET9GYqjLG7F3Xuz27DxVK9BVQu2A5XhPBt41Y6eQciFqzg0bAFg/h
	 d3rSq2d7QDciv/PwPwykU4j9OgrYwA7ieWfc2qyARTe70sdlVQiWJLEcnOFKkWHWrL
	 F9vak1PoljrnA==
Date: Mon, 15 Jul 2024 09:01:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Paul
 Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-netback: Use seq_putc() in xenvif_dump_hash_info()
Message-ID: <20240715090143.6b6303a2@kernel.org>
In-Reply-To: <add2bb00-4ac1-485d-839a-55670e2c7915@web.de>
References: <add2bb00-4ac1-485d-839a-55670e2c7915@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 15:18:42 +0200 Markus Elfring wrote:
> Single characters (line breaks) should be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>=20
> This issue was transformed by using the Coccinelle software.

I prefer to only merge trivial changes like this if maintainer
indicates their support by acking them. Since the merge window
has opened we can't wait and see so I'm marking this patch and
your pktgen patch as deferred.

