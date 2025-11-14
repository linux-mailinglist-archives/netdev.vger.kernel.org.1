Return-Path: <netdev+bounces-238565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF6C5B010
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CE09349531
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF12367D1;
	Fri, 14 Nov 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5FG/+s6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25D226CFE
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763087187; cv=none; b=fWHT3zkuL9VvSfQusUeLiOL3B5+hKKsJlnaxUdhNqgHoMPXuKDhxHZCvJwT1M4iC6Jq01eXYb4gFUc4O/M/71fTOuMu84a0/z6JUUofPLenJuDdamFViKgSn2jbQv7gdPV0gIcpy0F8ekox4M0dUYtktSVrN+Xk4QxL5VaJxn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763087187; c=relaxed/simple;
	bh=Y5dpV4tNgWUijVD1bpfIWWYMKshIq0O5UcLl1om+zr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZ/fnK3UJLsqAc2JjIh9jUIHNuJyxEnJF+zlpMMPrLjYsqFksbbBr+epGqDHnRS19e7kajrljAEz1Gf9eV2/f6/CAabDPL+ckG39jqOsrIgvmnqwckhPuXsR4iCirUlex2KMlkFb/jo3mmT1F0hwaKpXzasilTpO97D9x70act0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5FG/+s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82D5C4CEF5;
	Fri, 14 Nov 2025 02:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763087187;
	bh=Y5dpV4tNgWUijVD1bpfIWWYMKshIq0O5UcLl1om+zr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5FG/+s6npfP+2knepSShqBRpXqkXa2TKPbazIGdKowz5iGt7+a20AS0XlddEg4xW
	 GFDXEopxOVblBp4utH6KWSH38ugm2TkoLUvKY+JicIFeTmkEm0sr0oFUZweicG+uH8
	 659b02G3w8xvuqT8f5u+Hdu4HTA6+LJLS6haspbVw/xzLTd4L3+GOJ2htdMQsG3Ast
	 JURdkQtQBR7zRxa0+WBo9rKdl2Ilhg5w9uMQJFP6hwJdH52tV04mRzDNN4iUjF5eBZ
	 YVWAHkL/6ehMgRKB3VVTTNYZmsT5bncPE6Pul8YhELBv84M8rt0ysvRjpJ9XiI0uTf
	 Nxrne3XvxYTpw==
Date: Thu, 13 Nov 2025 18:26:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/8] ovpn: use correct array size to parse
 nested attributes in ovpn_nl_key_swap_doit
Message-ID: <20251113182625.4be5d5a7@kernel.org>
In-Reply-To: <20251111214744.12479-2-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
	<20251111214744.12479-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 22:47:34 +0100 Antonio Quartulli wrote:
> Fixes: 203e2bf55990 ("ovpn: implement key add/get/del/swap via netlink")

Since (IIUC) you'll respin - please drop the Fixes tag here.
You can say something like

The bad line was added in commit 203e2bf55990 ("ovpn: implement key
add/get/del/swap via netlink")

But real Fixes tags are for fixes

