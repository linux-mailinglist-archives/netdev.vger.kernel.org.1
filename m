Return-Path: <netdev+bounces-222667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308CB5552B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04F01D64BA2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94233168E4;
	Fri, 12 Sep 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf2xhb31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945621FCCF8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696251; cv=none; b=Yq9wD4UnaEIzeSeP7pqZa5gCw3oPxdKzxLD+9cyD6rc4M6pYjHPH/9E3RndxQ73QQLSE04CxLoKHa7tZgKaxrYD5rQidUNmLwsIcNgqzWJnOBp+slNgedmkqOjYbihQTrAeKVwoWzN0DHnjvd1FZ9ZA9eFiFzIP6npRKhiODbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696251; c=relaxed/simple;
	bh=1sbAr0s9p+oQd7W36mviMP+Agf5StnWCfZncNA8tcz8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=dd7jmZDx/dW4YYumxF0EBm5d2vk4yKJUcneTBN3ucc6Z/5b/ATacmIDyw4M19LyUQxeBZx9d+qlotp87WDnDHQskqvDx858uygZNhBVEEbK87U1DjKT7Wq5VQRU7rtfchHquCfMC+4IK344sJ2wOf0nXvoJ9F+IDo2zCJETnZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf2xhb31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BACCC4CEF1
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696251;
	bh=1sbAr0s9p+oQd7W36mviMP+Agf5StnWCfZncNA8tcz8=;
	h=Date:From:To:Subject:From;
	b=Bf2xhb31juTJWvnBbigCb+CU/PreB+WGKvTuLxc3j6nr4YKkgdpEEdG/iroytNUYy
	 uxi88IIUfcxiQkcp40QACXBUKuue+Te0yR9mYu66KZ0JoxPuvE/zcB6fTezWCOKcdq
	 YNcTVNOXlPDMz41nTTRFrtLw+li2HfsY7bVIl+6EQw8uIL7qL+ZPdCDSToj93eykf8
	 /wFxTnNiO2luqelyJUMIcvzbMrm4xSvlfPzS8qL3c+1P9wtjiSUQh8XaPr/dDfGea/
	 kV+hztkyps85QSDje1aADvhSr5bzMWpDJRLAfwYHDjsxw6FvVWyKofZFXpb+MFM/tq
	 ZVXBnSY4wc0uw==
Date: Fri, 12 Sep 2025 09:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] improvements to running nipa checks locally
Message-ID: <20250912095730.1efaac16@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We are growing the number of patchwork checks, so it's getting
increasingly tedious to manually validate everything before posting
patches. (*cough* kernel-doc)

I have polished the ingest_mdir.py script in nipa:

https://github.com/linux-netdev/nipa?tab=readme-ov-file#running-locally

It works fairly well for me. If anyone has tried to use it before
and gave up -- it may be a good time to give it another go.
Feedback and patches most welcome.

The allmodconfig builds it does take some time, so don't expect 
it to be fast.. :)

