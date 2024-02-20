Return-Path: <netdev+bounces-73179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8A85B43C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A972C2843E1
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4945BAD5;
	Tue, 20 Feb 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bGNhB0lB"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E25B697
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415517; cv=none; b=hnfO3tNQIYf1E34CpuYRqs+u+Rud7Hvf5SJMhy2GFA/6Ijyzr3Rx0NGTcSRi7Am1eKeSLCf6nWadQ5DDk4CR3pd+kUaHmO8K6F0N/qw0vsZM2u1cItmoh7YGPr6ClQkD37W40E/vou2I8OlDKywkGodB0MoaGJd0eq/UmAO7CcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415517; c=relaxed/simple;
	bh=STlFEk58iPnqTEPgUbO9JRua3s7ziMI8L3+HEHjxfeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyJvQk88BehYYJs0MIkCZOGi7k13P1Jke0z7Q4I1vYgK1Uj7ibJ0FH/PleVkuky4px3+DX8CAbghwYxTlhV65XGW1UMgklQ5XDhOQrfw49vzEUuj4bzonUwnizEAo1m+RPhQAlaHJGYVvJypL2Za5ChVuL0c2lC5/1wCAi5esXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bGNhB0lB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 683032009F;
	Tue, 20 Feb 2024 15:51:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708415513;
	bh=STlFEk58iPnqTEPgUbO9JRua3s7ziMI8L3+HEHjxfeo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bGNhB0lBohzFSL2zG0LcwNUNBPKbqPWZLedM92EuytuEF1cNzRB7PuCT6XH4urCXv
	 KWAI5/kF6DDS0rw0ZDnG/5+pEvSCQTWiYi25F3rOgIH/FfCjRljak8FCkOU+oCODSa
	 9Vrxo2nYDukoJP1V1SRs8BzLOCQppe//dCcvUDkbnnR9HSVg6Kche6JF1KzxbHf1yI
	 dEsdaf8Fi6unZ9mh7WgcfnHNOU9tDOB1m6/xXIYEhL2yR8ngiyxxsLAY43gxBR4AvS
	 6D3jP90EiR8pSvsyL8erlQvNnE/3vUL7J6VgxA3SDUfld1axsEKNcZLAqRTsTm+MzO
	 o2t/TYzYTTj4w==
Message-ID: <7c940ae800544aabd92be1fa9e2cd49e3fc50360.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: take ownership of skb in
 mctp_local_output
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Date: Tue, 20 Feb 2024 15:51:52 +0800
In-Reply-To: <20240219095247.GV40273@kernel.org>
References: 
	<f05c0c62d33fda70c7443287b2769d3eb1b3356c.1707983334.git.jk@codeconstruct.com.au>
	 <20240219095247.GV40273@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Simon,
> Previously this path returned -EINVAL. Now it will return rc.
> But by my reading rc is set to -ENODEV here.
> Should that be addressed?

Yes! While ENODEV is kind-of suitable here, but it would be better to
not change that case. I will send a v2 soon.

Thanks for the review.

Cheers,


Jeremy

