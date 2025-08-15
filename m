Return-Path: <netdev+bounces-214056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F8BB28026
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFB6189F717
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693E145A1F;
	Fri, 15 Aug 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="MSexeHfc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBB1E4AE;
	Fri, 15 Aug 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261953; cv=none; b=D3Yjj6jalqEDBeS+SBpik67ts6KT3Vh2E1FI+JoJdZzIqxmVz38BG47vrRr4TJSyQSs/2gGyeVMJYHx4rgpF/GehXi+qmhZbwEjoT5Ul3upQmVYNo4i7dfZ8vFZ9KMM8wyTUy2MZOd3G9999LwPdiyt86WzRQPX5CFkPVvk2Nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261953; c=relaxed/simple;
	bh=8+6TpdYdDqe96tSoh53cUrd5tfr5n0Cr+vCH/HHUPGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i88559TbfeLzCVVBKMv5ab2joKb/TMFOo8qSWB6vOZbHIzZcTHqhL8I+SvfvrFEhqupukSgF2kChClPEUk0zlHW+RMAcNokG42I4g7EmKV/30hkoVQnDRhy0r0EVnByljspQXbjEsGswVKUWeT8UepVCBz5OBfbh+QfjgfKO6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=MSexeHfc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755261949; x=1755866749; i=efault@gmx.de;
	bh=JIEZbu1irSsV2ya34Xpmlcjm0pikfLY9034CibdQhko=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MSexeHfcaklpJcPJWiT6+KuqWstG/VspxYpsgul+w51c/hpTljcFcyOBVLug8rcy
	 wOZbZcyABHNzyrfmA8e7l+5M7mYT29SiB1Xzfqafr/NKYWi4RKFm4GTxV8WcvecGK
	 ZSdC8q4KIjPQ6yYl2SpBbeIm8Ee/xegJM5shZe0RhtmyrNNowhCPuoOy+6418vwgE
	 yvy4ai0b4f2xq4XjCwFp8bgIL3Xudg0aMJCOU+pItb0iqiNqmDzxZuyNlvlaC9TGp
	 n9YpnKJEepkRv4WP46171uYaY3saLW75JrUBASl6TDyBb0hhvMcseUPF6ZsNXcQ3g
	 v7T32JARhGzXi0ab2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1uQIM33NZL-00zLT6; Fri, 15
 Aug 2025 14:45:48 +0200
Message-ID: <27d3c0140bcec8698d7496687bcfe4382fbcccd6.camel@gmx.de>
Subject: Re: netconsole:  HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, asml.silence@gmail.com, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Fri, 15 Aug 2025 14:45:48 +0200
In-Reply-To: <20250814172326.18cf2d72@kernel.org>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:xR8VEE4wwQ4QoqEX+z0tLalRf+W5iiP982pK8lCbEUiAX39F7x3
 l0xodJ9AXT1h505nCUOzrskE4OvapbxodwXtFJezAzWBWGBFaUp7BUTNLsnd6cmAZb0lgGP
 scNbOaoN86YqFl0zKh7/MkR/WmCjAo6Y9D2DO8CTmhwhOXdXvsnxhD+5DuRztG38b0mvLGg
 W/LSX6NG+G9tBmKvNcAFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9FpfpfFoYxA=;9BTXjtCEYJIFiIPIPNmJDOVOrf0
 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
 Pu5Po3kcAPWjrsB2v5QJYXr3U=

On Thu, 2025-08-14 at 17:23 -0700, Jakub Kicinski wrote:
>=20
> We started hitting this a lot in the CI as well, lockdep must have
> gotten more sensitive in 6.17.

FWIW, the issues wireless lappy reported aren't merge window arrivals.
6.12.41+lockdep behaved as master, wired ran clean, wireless grumbled.

	-Mike

