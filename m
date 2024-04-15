Return-Path: <netdev+bounces-88071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D48A5918
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 19:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B9F1C21019
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D782C7E;
	Mon, 15 Apr 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/rXqSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF4839E0;
	Mon, 15 Apr 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202021; cv=none; b=bebAhU0g/2pRv7O2poW2nW/Cuhqp1pGeW20bGPt/NqO0lF8wCH3hstWp8uQH8V46GxkeiuCQ+PJ/MxjU7KZjyeLlxKDpxRVUwb4q0kxlwv0TU6pjiRsc278qNG2lfyibIAcsW1KQQyXSWm2vBmVaui4FClWJvoQth8yTWcucSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202021; c=relaxed/simple;
	bh=4kVCEo6fwzE1S5Ul4Wf3IZQd7tlufRcLAuVY9c6A5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLX8jT9fe2qm8XFFAUPw1oaieCUVSclVqbMUX0q9dEuLT9hDsLba1MYAaZCc0PQJ1jn9WwzzGbsLakZPk2rmyEeW4YkN8vaquOs31aRnWrHJ89iO/+kL1j+oSGTvwQwbgbIkHPsQtOZMMoqOx2Ej6hKtT3ZilNTN6BDP85ISdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/rXqSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8DAC113CC;
	Mon, 15 Apr 2024 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202020;
	bh=4kVCEo6fwzE1S5Ul4Wf3IZQd7tlufRcLAuVY9c6A5ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fH/rXqSOpzY71Bq6Eii7loau4DJnENbDgUb9XIK1pGzISJy4Y/tM0Deq5Ud5dqZuG
	 7tM/jDiZgOv1DJ0/IFJ/tz+Z5FRfqG/6eOKf8YcigHbGDZwdhVsZecb5kj/6RE2GQd
	 jws7TxmRjwlEaKXZvoAamJzLzZ/9OHJLokaHgdQ7xSCl9MQBx8tXu0IQiOdwDsTlXe
	 O+6PqOFwzoBjnu5p/L8BlS++Q9mnc0aHm3vAh6KPTbxzhgbuCO7lk2b0ataeqSD32B
	 lWINIAbZWmXQ6QdwhGH4fh3etIXIcmfy1YerT4PfeX/FS82B1MkQv8UcitqUqewk94
	 xvktNDpiLl30Q==
Date: Mon, 15 Apr 2024 10:26:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, parav@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com,
 liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com,
 idosch@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <20240415102659.7f72ae8d@kernel.org>
In-Reply-To: <ZhqHadH3G5kfGO8H@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
	<20240412180428.35b83923@kernel.org>
	<ZhqHadH3G5kfGO8H@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
> That is a goal. Currently I do it with:
> vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"
> 
> and setting loop manually with tc-matchall-mirred
> 
> Implementing virtio loop instantiation in vng is on the todo list for
> this.

Just to be clear - I think the loop configuration is better off outside
vng. It may need SUID and such. We just need to make vng spawn the two
interfaces with a less verbose syntax. --network-count 2 ?

