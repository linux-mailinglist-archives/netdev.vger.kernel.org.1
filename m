Return-Path: <netdev+bounces-114347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7869423FD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A1B1F2500D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F4748D;
	Wed, 31 Jul 2024 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="H/0TYuY2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D6D2F5
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387320; cv=none; b=RDy4BDbvfMaf/hVorhwSCZqISd88JVqp/DTQ1e6YjZ3UcNFHVtBhbZ2v8L+p/SKYGewwIvQsN432skIgZRaYUd31RGndDWQPA7LBE3Ke8VE5RxGK2pyODQKxHWJZn7Q+Pi9seC8RJm1Gm+JFvTMl2Qs99BiwFFoLRG5doPtUCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387320; c=relaxed/simple;
	bh=W79kSfq4Bz4pOobK+Jb1XSq1CAUuKwxXh5INX4jDV4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5eq7K+8JzjE5r4TBHI3KI1oFHvy8BK7EtwHx+o6kmgS9rLqtPO5hnpKW4qbOdG+ZPg0IKxgmrJ6v6/n4qfbBuNXkOoiCVrM5SpzsnQMWlurV8qMMTO4eLf4fJatLHj/3mQcG+Tx5+6M0btVIW4SXQyTxTkUEwgCuKoecOoDKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=H/0TYuY2; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 46V0t0fZ014567
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 31 Jul 2024 02:55:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1722387304; bh=W79kSfq4Bz4pOobK+Jb1XSq1CAUuKwxXh5INX4jDV4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H/0TYuY2Jzuip5h3w1q6WvdNAfdOHijrih3qA6bGiA2kZEP10XSOvSG5rPRHZYc+F
	 edKiO1OUUQN2XNPTNf2qiFBwPVn77DW1uEOkqM9bk2AaCdgViiB41AstexSkq46FA0
	 AxFAhui54GfLF+K8ju34SeE48WgUnGX7Hq5Oe+ts=
Message-ID: <df1d503f-ec6b-4fd9-9135-50241325fecf@ans.pl>
Date: Tue, 30 Jul 2024 17:55:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qsfp: Better handling of Page 03h netlink read failure
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
        Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
        Dan Merillat <git@dan.merillat.org>
References: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl> <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
 <56384f82-6ce7-49c8-a20e-ffdf119804ae@ans.pl>
 <ZowP36I9jcRmUDkg@shredder.mtl.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <ZowP36I9jcRmUDkg@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.07.2024 at 09:12, Ido Schimmel wrote:
> Hi, thanks for the patch. Some comments below (mainly about the
> process).

Thank you so much Ido for your careful review, detailed feedback and
patience. I just re-sent both patches.

BTW: get_maintainer.pl for drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
also returned "linux-kernel@vger.kernel.org", should I be also including it
in the future?

Thanks,
 Krzysztof

