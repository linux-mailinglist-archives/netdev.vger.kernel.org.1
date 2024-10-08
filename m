Return-Path: <netdev+bounces-133351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3FD995B93
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49034285646
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE72185A4;
	Tue,  8 Oct 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILumA5YD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AE218594
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429678; cv=none; b=uMCTiy59TXUyCMhrjcb37Xiqej6hSELzIn8SFUNgNr8xiu3zaBUZVOeUaPyBCkdSJKdPxxqpZCnzPj2zVh2JRWK4T3g5fNEGOe61LfE7QwLknYmxM74doG86wWC12zBI04aMXc7EkOXgcWJaBSHy0Rs55EANCSe1n6NET7raW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429678; c=relaxed/simple;
	bh=TSCizON5lR9Cjf1v9ABJPi4tqtOgZIyr2vFmSq606gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJoFM+seQbE07JcXRqCMqV6Oz6C/T0X1wYB0qZ4rN7n5eY3DbANoAgEEcNHBG8nb2SfCXn+Im2Uuxt7P/ulP+PP/bX0uCt7tcP4SZxVHIXOHvxdEOrX0dqgIvoFdTbElgVGsb7qj3y/H08SBGXIwbbeT7CyB7eCA6vfMp804TaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILumA5YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E94AC4CEC7;
	Tue,  8 Oct 2024 23:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429678;
	bh=TSCizON5lR9Cjf1v9ABJPi4tqtOgZIyr2vFmSq606gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILumA5YDIdjkZdG4Soz78Qc/eorLST1D2LkCxrxLpHQZQv2LKSCYDWMx7xNoTnw4c
	 wVlIZ2VKwn3/1xS0+Vcro2s5bzsQ7Ugz9HTcnRbliBZIBIXPGzs92V6of855bb+JGD
	 bhw6SyC6+vfnIHsz/fnEhDJqXGCQWTtXXWZvx4ZZDT7fYbcazLoTparSYaU5HDcOyy
	 NMVvFyfJSqIDXg/yZLy2IF9Rw3V9FnL10AhYZ0q+9WmZ4hLdUbGJX4y01oPzNee7Ba
	 XM6z0oJj7yVEUUbLoSDF30ZzUdDuirceucvcO9ozEdhlzSEeqWEe1F4juRlyqx5+1M
	 3QxQqNOUwGFpw==
Date: Tue, 8 Oct 2024 16:21:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, Stanislav Fomichev
 <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 00/15] net: introduce TX H/W shaping API
Message-ID: <20241008162116.7c63d85a@kernel.org>
In-Reply-To: <cover.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:53:47 +0200 Paolo Abeni wrote:
> We have a plurality of shaping-related drivers API, but none flexible
> enough to meet existing demand from vendors[1].

Does not apply, you'll have to repost.

