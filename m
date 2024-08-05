Return-Path: <netdev+bounces-115915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0243948622
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7282E281877
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2616F830;
	Mon,  5 Aug 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItOJjamc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B9149C4E;
	Mon,  5 Aug 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900881; cv=none; b=C9onM5dDASYT3rdIb40SKtNWcVbn0HPFOmibnBxBDQfMlxJ/Sx74t0SiXNFw3H9NJPMWpoAHE+lMIARMwBJxPKLaBTFtdczqPwFvVNdP4f72ZXELm5JFe7ScvNQDL04bnreWH/BN3LXEUdV9kLxmMXAnSYqPQpMNI11huDqnmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900881; c=relaxed/simple;
	bh=YiUDeANlqkkDVxjDrrvyzM0E/adeloaROUbrvhpCDhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3/ft9hJu2cGGYZ+W7LG6RCmZ1uiLHTHNfHnzbWQcIbpI2tw3Z4jcaWTn5dB+ZWbDIhxI0NrZuW/l6qiouaFSZaQHdMH+mpi2XXS1HkxkCJWs7xDNKfhsb310icergaPVzDultBtuBo/l+QBMIOm4oDft6umewhyLp0gwc9R9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItOJjamc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E903FC32782;
	Mon,  5 Aug 2024 23:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900881;
	bh=YiUDeANlqkkDVxjDrrvyzM0E/adeloaROUbrvhpCDhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ItOJjamcxi+gQDw+7+c4Aqnrhc/Siqpfk5DTAGb2DH+cQvhHJQeeWJjexhgPx6V+N
	 +EE9wpP4irZ/mJuO4SZOpf5lp0YWVhyHJNQSSFlQ6ij2pBUuy/bO2Bl0HIO4J7dejJ
	 /4/AGeeBSzzv+nRWWLRN3XfvSpIcnBAMTAUiokc1UbKEvHifgnO8WCfLZqbAjiwVj7
	 ZoeeuJfE44vY9eNKQg9+B+eKODlXaq880BGQDqfPtlP6aUKh/XkDbbOhi28dmTMU3C
	 sVLbHQwZ1y7DdjCqMi+o3uXHZNML7umsIC6Nr6xp6ZcEdKBCaRk0x5T2lloVF34MtF
	 ityTE23D/C6Vw==
Date: Mon, 5 Aug 2024 16:34:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: fix memory leak for not ip
 packets
Message-ID: <20240805163440.6b5f0fca@kernel.org>
In-Reply-To: <20240801135512.296897-1-dnlplm@gmail.com>
References: <20240801135512.296897-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 15:55:12 +0200 Daniele Palmas wrote:
> Free the unused skb when not ip packets arrive.
> 
> Fixes: c6adf77953bc ("net: usb: qmi_wwan: add qmap mux protocol support")
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>

Applied, thanks!

