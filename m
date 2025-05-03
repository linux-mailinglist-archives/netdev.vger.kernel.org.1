Return-Path: <netdev+bounces-187580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45249AA7E08
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C645F988343
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDB74040;
	Sat,  3 May 2025 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piP8naiz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184A17F7;
	Sat,  3 May 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238616; cv=none; b=aJbaOZ1VDXIqJ3ImzZIEgmlEkTD5NA7k3kbZ/yB6OJabvmY3JSU6DoFjmqVTwVgGeuBKy/bXiEUFKw46Ptl7m7pr13hk2AEvJCD0aFVOg2l2bdmP9iOByX4nY8uVMBFK5wUQ4M1f6/e/H2SdT4yjJ4+YwZDOy0mSe2IrX9d3r6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238616; c=relaxed/simple;
	bh=S9yP0Y2wTVUeGaFh/FcZXkUd4IK0A01eTYPb6dzK/7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dir9VJosNwSuOb0F8cLTkS+xnmmu/L16DtT9hX4ioGwxwH685ZJjxHT1PvWmTgBXPkgekqO/fLqnVFxlQaU8Tn5YH1bVMHBFuodcK9cdUmzZCCNRUeTgyB+CZ8zFFvt/myepmn2Xo+0ewzHs3AWVnGArB74nGZOiZVnC/fRghDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piP8naiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B42EC4CEE4;
	Sat,  3 May 2025 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746238615;
	bh=S9yP0Y2wTVUeGaFh/FcZXkUd4IK0A01eTYPb6dzK/7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piP8naizBQy2TPrVzfgu0ohGerlPNF8JCENFcyEFQf0D49XYtbImJth/oC8z4BqsO
	 wjuWxhj6+wqRdqNMUsb3oqbt7Pfw6VPcZFb48Nw6alCV900VGZdmSokgJ1bl+TT2Gb
	 87FXhVsMftqNtwz9cR1GEuUf8FtNN0wLrVUpmaGojN0MG5kMMBMSgi14P6He40E5eS
	 G4EXTjL/GgEzwdgX7mviHI2KD/QMhpEfAYzjke4wz73QpGSB/t+vhS0jbz3LWn8GRE
	 ufQ8pquxuafGG9bIfcUt+MiBdLT3zgghIgKtwQU70xdheqUB8JQE6fdgmmFQOwfdld
	 fmzHxNMaSDYOA==
Date: Fri, 2 May 2025 19:16:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, Hayes Wang
 <hayeswang@realtek.com>
Subject: Re: [PATCH net-next] r8152: use SHA-256 library API instead of
 crypto_shash API
Message-ID: <20250502191654.2da1f58b@kernel.org>
In-Reply-To: <20250428191606.856198-1-ebiggers@kernel.org>
References: <20250428191606.856198-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 12:16:06 -0700 Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This user of SHA-256 does not support any other algorithm, so the
> crypto_shash abstraction provides no value.  Just use the SHA-256
> library API instead, which is much simpler and easier to use.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks!

